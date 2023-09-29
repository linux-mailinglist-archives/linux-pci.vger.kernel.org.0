Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14567B31E0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 13:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjI2L64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 07:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjI2L6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 07:58:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F471B6;
        Fri, 29 Sep 2023 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695988731; x=1727524731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jEq8VuTODvxdM49avhgWzqUC3yyIiRlCMHso5pMiaHY=;
  b=e98uagiNJwv8KjGVu705Yz5jVqPvOq8ScqVpjdijvIUJaDpA/XUShrTU
   OtSFhzJVUfisLbTqyKKFKvxSahFxRTmXbvKqTpc+pjCxN+M5HclHR+CU6
   KySl+JgivSP2rC7qpiiKrj4lPRPPV7EIzz8xIs862IczWgJAv9qJo+2Ab
   KYQ18tU0A8ozUVErncQvJbXvfcqcUy86IkILWoV6EvEMJP8ki9VKCT85G
   yfnlmN7EnJyr5RQ3uaHK0qslBMqH/SDNTu3R4xR9wjZzhrp11mq+wIy/k
   v80pK0jQJjnBzBz+/TZDTsQhLh3PXME6mxxzZpHOHBZKc/vR8tFi63WhJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="379552955"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="379552955"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="726573840"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="726573840"
Received: from valeks2x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.242])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:58:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 05/10] PCI: Store all PCIe Supported Link Speeds
Date:   Fri, 29 Sep 2023 14:57:18 +0300
Message-Id: <20230929115723.7864-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

struct pci_bus stores max_bus_speed. Implementation Note in PCIe r6.0.1
sec 7.5.3.18, however, recommends determining supported Link Speeds
using the Supported Link Speeds Vector in the Link Capabilities 2
Register (when available).

Add pcie_bus_speeds into struct pci_bus which caches the Supported Link
Speeds. The value is taken directly from the Supported Link Speeds
Vector or synthetized from the Max Link Speed in the Link Capabilities
Register when the Link Capabilities 2 Register is not available.

pcie_bus_speeds field keeps the extra reserved zero at the least
significant bit to match the Link Capabilities 2 Register layouting.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c           | 28 +++++++++++++++++++++++++++-
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 795534589b98..ca1d797a30cb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -767,6 +767,29 @@ static enum pci_bus_speed agp_speed(int agp3, int agpstat)
 	return agp_speeds[index];
 }
 
+/*
+ * Implementation Note in PCIe r6.0.1 sec 7.5.3.18 recommends determining
+ * supported link speeds using the Supported Link Speeds Vector in the Link
+ * Capabilities 2 Register (when available).
+ */
+static u8 pcie_get_supported_speeds(u32 linkcap, u32 linkcap2)
+{
+	u8 speeds;
+
+	speeds = linkcap2 & PCI_EXP_LNKCAP2_SLS;
+	if (speeds)
+		return speeds;
+
+	/*
+	 * Synthetize supported link speeds from the Max Link Speed in the
+	 * Link Capabilities Register.
+	 */
+	speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
+	if ((linkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
+		speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
+	return speeds;
+}
+
 static void pci_set_bus_speed(struct pci_bus *bus)
 {
 	struct pci_dev *bridge = bus->self;
@@ -814,12 +837,15 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 	}
 
 	if (pci_is_pcie(bridge)) {
-		u32 linkcap;
+		u32 linkcap, linkcap2;
 		u16 linksta;
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
 
+		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP2, &linkcap2);
+		bus->pcie_bus_speeds = pcie_get_supported_speeds(linkcap, linkcap2);
+
 		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
 		pcie_update_link_speed(bus, linksta);
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16db80f8b15c..cb03f3ff9d23 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -664,6 +664,7 @@ struct pci_bus {
 	unsigned char	primary;	/* Number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
+	u8		pcie_bus_speeds;/* Supported Link Speeds Vector (+ reserved 0 at LSB) */
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	int		domain_nr;
 #endif
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5f558d96493..2b27e4f6854a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -674,6 +674,7 @@
 #define PCI_EXP_DEVSTA2		0x2a	/* Device Status 2 */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2 0x2c	/* end of v2 EPs w/o link */
 #define PCI_EXP_LNKCAP2		0x2c	/* Link Capabilities 2 */
+#define  PCI_EXP_LNKCAP2_SLS		0x000000fe /* Supported Link Speeds Vector */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
-- 
2.30.2

