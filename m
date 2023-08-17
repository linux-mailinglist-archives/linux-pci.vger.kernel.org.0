Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A595077F644
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350765AbjHQMSI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350789AbjHQMRy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:17:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF0A271B;
        Thu, 17 Aug 2023 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692274671; x=1723810671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oq2YofpAPzEgKpikZ0TmOuD8+AkfVu3ypV/aBgGls+o=;
  b=YCZxdsi3w53KwMHpavb7BxKT8TvBbDVpaHM63g8LGt5uDltLyFzxxzh1
   Q4IgSDdSMjiOfgRg6mSCp+vwTjzn8War0HSh1e9SdKDEYDlD5DtzjvWbD
   /kWNs8rUcS30BTIvnNlroy39PkTSudyztzPQpLakj1RFAvINpuCsqWlHd
   neEnSYqcbFUUPY1DU9gvPZj6O+zYS8Lv7KarJgo85abo1phLXjWi2LKFD
   CBm9sjzSa2sRQlAfNWTtj0gEUIWza0yVlmNLQV2buyUaFF9oNtGEMDdhb
   t0hiGfzCGgHLssj1AWH5Nmk0r02phjxEi8OiiF5aLNSHY4Sy3infb8G2p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436696736"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436696736"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848872991"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848872991"
Received: from lababeix-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.212.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:17:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/10] PCI: Store all PCIe Supported Link Speeds
Date:   Thu, 17 Aug 2023 15:17:03 +0300
Message-Id: <20230817121708.53213-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index f1587fb0ba71..586d44b5ed7a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -768,6 +768,29 @@ static enum pci_bus_speed agp_speed(int agp3, int agpstat)
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
@@ -815,12 +838,15 @@ static void pci_set_bus_speed(struct pci_bus *bus)
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
index 7b2927a90ee0..d14d92bb7eba 100644
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

