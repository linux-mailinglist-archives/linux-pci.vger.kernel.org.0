Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09237CDA85
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjJRLeU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRLeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:34:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A984113;
        Wed, 18 Oct 2023 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697628857; x=1729164857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=za1tMI3kospkfp0GbYoB/w+yEM/E+KhNu9VygOaadfA=;
  b=OpRZX6AxSFriTTFF7KbMatHmznaPqB8B5nQfaUBYnWsCVh0LKujcSRni
   YDK5M8nw3siGMSj/MUEao2Z4mlt8DJ77n1pmMUeCNP8oupNK42jgoST1v
   nK9dSR3pOcxn0ZbtX6UU3wl9r4Y1/wUCGi03glpCzwtw05ei/PWh3MmxH
   XiJLq+00n5k6Ss6T5NwUrc+5G9kTT9BSjbHZXeRamusl2T8S0FxFkKhwm
   qrFUz0EOCk681FXJtZtZKxHBFi9vw7p3zayHE3ZfX/Hvls43zKkL6Yl6K
   Cqd3EP0FV64wi3ps4D3pWxEsGTtEy5f05Pa/hSxLUkpbdpDTPv61Leoub
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="371056750"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="371056750"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="930150810"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="930150810"
Received: from suguccin-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.44.63])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:33:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/7] PCI: dwc: Use FIELD_GET/PREP()
Date:   Wed, 18 Oct 2023 14:32:49 +0300
Message-Id: <20231018113254.17616-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
References: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert open-coded variants of PCI field access into FIELD_GET/PREP()
to make the code easier to understand.

Add two missing defines into pci_regs.h. Logically, the Max No-Snoop
Latency Register is a separate word sized register in the PCIe spec,
but the pre-existing LTR defines in pci_regs.h with dword long values
seem to consider the registers together (the same goes for the only
user). Thus, follow the custom and make the new values also take both
word long LTR registers as a joint dword register.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
 drivers/pci/controller/dwc/pcie-tegra194.c      | 5 ++---
 include/uapi/linux/pci_regs.h                   | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8d552f..20bef1436bfb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
@@ -334,7 +335,7 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	if (!(val & PCI_MSI_FLAGS_ENABLE))
 		return -EINVAL;
 
-	val = (val & PCI_MSI_FLAGS_QSIZE) >> 4;
+	val = FIELD_GET(PCI_MSI_FLAGS_QSIZE, val);
 
 	return val;
 }
@@ -357,7 +358,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	val &= ~PCI_MSI_FLAGS_QMASK;
-	val |= (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
+	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, interrupts);
 	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, reg, val);
 	dw_pcie_dbi_ro_wr_dis(pci);
@@ -584,7 +585,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	reg = ep_func->msix_cap + func_offset + PCI_MSIX_TABLE;
 	tbl_offset = dw_pcie_readl_dbi(pci, reg);
-	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
+	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
 
 	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 248cd9347e8f..12d5ab2f5219 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -126,7 +126,6 @@
 
 #define APPL_LTR_MSG_1				0xC4
 #define LTR_MSG_REQ				BIT(15)
-#define LTR_MST_NO_SNOOP_SHIFT			16
 
 #define APPL_LTR_MSG_2				0xC8
 #define APPL_LTR_MSG_2_LTR_MSG_REQ_STATE	BIT(3)
@@ -496,8 +495,8 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 		ktime_t timeout;
 
 		/* 110us for both snoop and no-snoop */
-		val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
-		val |= (val << LTR_MST_NO_SNOOP_SHIFT);
+		val = 110 | FIELD_PREP(PCI_LTR_SCALE_SHIFT, 2) | LTR_MSG_REQ;
+		val |= FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, val);
 		appl_writel(pcie, val, APPL_LTR_MSG_1);
 
 		/* Send LTR upstream */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5f558d96493..495f0ae4ecd5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -975,6 +975,8 @@
 #define  PCI_LTR_VALUE_MASK	0x000003ff
 #define  PCI_LTR_SCALE_MASK	0x00001c00
 #define  PCI_LTR_SCALE_SHIFT	10
+#define  PCI_LTR_NOSNOOP_VALUE	0x03ff0000 /* Max No-Snoop Latency Value */
+#define  PCI_LTR_NOSNOOP_SCALE	0x1c000000 /* Scale for Max Value */
 #define PCI_EXT_CAP_LTR_SIZEOF	8
 
 /* Access Control Service */
-- 
2.30.2

