Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD57B31E4
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 13:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjI2L7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 07:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjI2L7G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 07:59:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726CF1B0;
        Fri, 29 Sep 2023 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695988743; x=1727524743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5GI9De0NedLS8Fb+1iCt8QAfte6ia8Vm/9fJLfKqyBE=;
  b=KtarcQXNP/o65oNQiIK/akayDJM7rPqashxAuwRz1JWkR2MqiisLCzQ1
   MKxFkVV+bzsSeqZgMrF1nYS7QJqVy0m01v+UPZ3eDFzI239PYue681jTM
   zTsHMcLPiLFZsKfxoDkROuE3Arkzi/VBJwVyrFE5slkSNOX2Ra3+0Jnb+
   uVu8o7oa8tUB31Py7t9OaLavF1rcBBfXjg+qVVHiM1svY4z3nB9YDtpeh
   ejDapAvBN6fw0YJbMOW8vRP9KYYjd0oXlk3rGFgKs537MfiMWLEJNAmJj
   CRt30mLtqa95Q3Y4jpnvLd80Qgga+Y0lWn4bPof3syC9kPEvp+fUNk1cI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="362528079"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="362528079"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="815581136"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="815581136"
Received: from valeks2x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:58:54 -0700
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
Subject: [PATCH v3 06/10] PCI: Cache PCIe device's Supported Speed Vector
Date:   Fri, 29 Sep 2023 14:57:19 +0300
Message-Id: <20230929115723.7864-7-ilpo.jarvinen@linux.intel.com>
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

The Supported Link Speeds Vector in the Link Capabilities Register 2
corresponds to the bus below on Root Ports and Downstream Ports,
whereas it corresponds to the bus above on Upstream Ports and
Endpoints. Only the former is currently cached in pcie_bus_speeds in
the struct pci_bus. The link speeds that are supported is the
intersection of these two.

Store the device's Supported Link Speeds Vector into the struct pci_bus
when the Function 0 is enumerated (the Multi-Function Devices must have
same speeds the same for all Functions) to be easily able to calculate
the intersection of Supported Link Speeds.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c  | 10 ++++++++++
 drivers/pci/remove.c |  2 ++
 include/linux/pci.h  |  1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ca1d797a30cb..a9408f2420e5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2564,6 +2564,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
+	u8 dev_speeds = 0;
 	int ret;
 
 	pci_configure_device(dev);
@@ -2590,11 +2591,20 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 
 	pci_init_capabilities(dev);
 
+	if (pci_is_pcie(dev) && PCI_FUNC(dev->devfn) == 0) {
+		u32 linkcap, linkcap2;
+
+		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
+		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &linkcap2);
+		dev_speeds = pcie_get_supported_speeds(linkcap, linkcap2);
+	}
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
 	 */
 	down_write(&pci_bus_sem);
+	if (dev_speeds)
+		bus->pcie_dev_speeds = dev_speeds;
 	list_add_tail(&dev->bus_list, &bus->devices);
 	up_write(&pci_bus_sem);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..656784cfb291 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -36,6 +36,8 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	device_del(&dev->dev);
 
 	down_write(&pci_bus_sem);
+	if (pci_is_pcie(dev) && PCI_FUNC(dev->devfn) == 0)
+		dev->bus->pcie_dev_speeds = 0;
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cb03f3ff9d23..b8bd3dc92032 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -665,6 +665,7 @@ struct pci_bus {
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
 	u8		pcie_bus_speeds;/* Supported Link Speeds Vector (+ reserved 0 at LSB) */
+	u8		pcie_dev_speeds;/* Device's Supported Link Speeds Vector (+ 0 at LSB) */
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	int		domain_nr;
 #endif
-- 
2.30.2

