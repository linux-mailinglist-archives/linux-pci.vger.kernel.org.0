Return-Path: <linux-pci+bounces-5491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C412893D5D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 17:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DFF1F22E23
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C2047A55;
	Mon,  1 Apr 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGqm6nd9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60D535D9
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986682; cv=none; b=nTWFPAhhCCBtTb5GqDjWErlROu2jhiUfaezRue5EUG0Kc80izYSWMYd1rQMtcXDkrnDSn/Ppbxz9gFbH4LH3oy3j0BF+GrBK5nmP2R9WGBmfAmNtlHXgb1x6VoWk0pMJEpha39VJGdlFOzvQaSpZN0E8Ey+fcJigue+PC3aYxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986682; c=relaxed/simple;
	bh=o26SriN4DO3Oj59xWZYfB2GhSdR1CNJUmn+kDdBgIjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQBCldWzuFNEmZanZvC4HJUUGOOlzQUGoLnzM6nGZFQGG6vCopheR9thdxk2fRmPAzVx39+OPW/wUdnQm9zrj8x8HPGwIqir2NxAJC2HS9VSQalukmZ1XbFCXLEkns1UQxTNeLHYVAKeMokAckuyzJj0OkY1L4qOkbEcOV31c0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qGqm6nd9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1def3340682so36293425ad.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2024 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711986680; x=1712591480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFiT88PKFBOrpOqMXMIRI/YWsJ4JPGHI2MIVO+PP/kw=;
        b=qGqm6nd9i5aaDMinIC6lPZB1EiHklL2Qp4K5l89tc6/OBDXqhnOCDK7QaPdA2Q+O6u
         nnR9buX0MXNHQEYIbJfCCGc7owi0SNIKE+ETrWH8Tpzn8l7EXjXvN04j4aDFwYnJ4d5T
         hkMWylUbTpeyjzlrYqyWgMPCPwR7fbnhK1/rATJMVpXzNcMcj+7kSFcCHAxcGi6Z/uK+
         ZAgDb2bhju6Rihlm5FkVpRwN+DZPRkvlygEeqC8rszmvYlNY+0V/orrKdEU4mcLlnwsS
         +M4AsAIGG08XpBriTqqWCCJZyZuzmdE3uzdegsec1CmpRKOhNBkUF9sIKpaKdDq8JTtx
         npRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986680; x=1712591480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFiT88PKFBOrpOqMXMIRI/YWsJ4JPGHI2MIVO+PP/kw=;
        b=Et2+GpIsCbMIUNVJI2wTd4vpu9I8UuiNx2VfdYufJN28SNEi0OYnr7JSlOxGyOr1jG
         50yzpjdT6f6BFSQqlqJxMfV6y0HfzvLZq4KtVKEu+0sE/R17IM4G9g6Gwswfz+hZAk3R
         MKns57Irp56cWMERvkf5JHPWC4Qv2dSp7faTWBl1tsq6T9tJiv99gJVuwLB/30RIaEPN
         AwYYLFG9qADWKA/IQT6T23dhuC3T+poKF0RIzZwWndi+5yI798mkdVEXaeyS6p+G4dC6
         Y/XfSojEnWM5qSG3FdI8XR7JIF5KesBbTOXIImIwsMDE016QzvRDYSTLNmrBXmVM6Bk0
         DEwg==
X-Gm-Message-State: AOJu0YxS71w2QXoZpBNvI2My6og1UaZlpkZQRzVHuWxNTj3CTXEzZBuh
	zndiL5+bJJs741y24ExBd8PzMU6E0KSKXNPvvU9osLappmtYHIy0O3imBHnJ4g==
X-Google-Smtp-Source: AGHT+IH0DEnfUBJAZAlQVIrgRQrSHOJlo8lrJRkd1PyXUeQVAQCFZc27RlJyY/B2jnT2reu9dapfig==
X-Received: by 2002:a17:902:ea0b:b0:1e0:b287:c1d8 with SMTP id s11-20020a170902ea0b00b001e0b287c1d8mr12690936plg.5.1711986679571;
        Mon, 01 Apr 2024 08:51:19 -0700 (PDT)
Received: from [127.0.1.1] ([103.28.246.102])
        by smtp.gmail.com with ESMTPSA id kh6-20020a170903064600b001e21957fecdsm8949076plb.246.2024.04.01.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:51:19 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 01 Apr 2024 21:20:33 +0530
Subject: [PATCH v2 07/10] PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-pci-epf-rework-v2-7-970dbe90b99d@linaro.org>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
In-Reply-To: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6705;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=o26SriN4DO3Oj59xWZYfB2GhSdR1CNJUmn+kDdBgIjw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmCtfVpr3mN+qfdEu8wKPMUeNA1iztJ0M5U6Gog
 mePyVnYM0CJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgrX1QAKCRBVnxHm/pHO
 9b8nB/9x2rOIrzKnp+uMJIEOgC1f7F6ZRVMKhffcA9WN2ExkPhRbxseRxs3HXuxDGxBq5qmxSnT
 zkiRqZFf64MBoN/TYl8Dfw6zUpXWBpXJWsJgIlaXcURS6WJS7uGp2/MaD9ageFAWsP44wz9+iXK
 auL4PHDI3zUK6rUsOsVMVzbtsGroDALLc9C2QgMQmPs0Gfbs4Nl72+FIw1NwN0StVmN83NImvz4
 UXciF60BT2QwQRFMstOeVTT2qhzzj9ZM6eMwh6ZtRCZ71EuqmcLPUTdX2N1h0OzKl7EbMUIerDh
 Fnvv1vv2qCXPr56Vr7XgPb6k7kRrJT21uwUky3s/2P26GGeg
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

As per the PCIe base spec r5.0, section 5.2, Link Down event can happen
under any of the following circumstances:

1. Fundamental/Hot reset
2. Link disable transmission by upstream component
3. Moving from L2/L3 to L0

In those cases, Link Down causes some non-sticky DWC registers to loose the
state (like REBAR, etc...). So the drivers need to reinitialize them to
function properly once the link comes back again.

This is not a problem for drivers supporting PERST# IRQ, since they can
reinitialize the registers in the PERST# IRQ callback. But for the drivers
not supporting PERST#, there is no way they can reinitialize the registers
other than relying on Link Down IRQ received when the link goes down. So
let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
non-sticky registers and also notifies the EPF drivers about link going
down.

This API can also be used by the drivers supporting PERST# to handle the
scenario (2) mentioned above.

NOTE: For the sake of code organization, move the dw_pcie_ep_linkup()
definition just above dw_pcie_ep_linkdown().

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 98 ++++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h    |  5 ++
 2 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2063cf2049e5..56b34267850e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -15,18 +15,6 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
-/**
- * dw_pcie_ep_linkup - Notify EPF drivers about Link Up event
- * @ep: DWC EP device
- */
-void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
-{
-	struct pci_epc *epc = ep->epc;
-
-	pci_epc_linkup(epc);
-}
-EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
-
 /**
  * dw_pcie_ep_init_notify - Notify EPF drivers about EPC initialization complete
  * @ep: DWC EP device
@@ -673,6 +661,29 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 	return 0;
 }
 
+static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
+{
+	unsigned int offset;
+	unsigned int nbars;
+	u32 reg, i;
+
+	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	if (offset) {
+		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
+			PCI_REBAR_CTRL_NBAR_SHIFT;
+
+		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+	}
+
+	dw_pcie_setup(pci);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 /**
  * dw_pcie_ep_init_registers - Initialize DWC EP specific registers
  * @ep: DWC EP device
@@ -687,13 +698,11 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	struct dw_pcie_ep_func *ep_func;
 	struct device *dev = pci->dev;
 	struct pci_epc *epc = ep->epc;
-	unsigned int offset, ptm_cap_base;
-	unsigned int nbars;
+	u32 ptm_cap_base, reg;
 	u8 hdr_type;
 	u8 func_no;
-	int i, ret;
 	void *addr;
-	u32 reg;
+	int ret;
 
 	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
 		   PCI_HEADER_TYPE_MASK;
@@ -756,25 +765,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ep->ops->init)
 		ep->ops->init(ep);
 
-	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
-	dw_pcie_dbi_ro_wr_en(pci);
-
-	if (offset) {
-		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
-		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
-			PCI_REBAR_CTRL_NBAR_SHIFT;
-
-		/*
-		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
-		 * size in the range from 1 MB to 512 GB. Advertise support
-		 * for 1 MB BAR size only.
-		 */
-		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
-	}
-
 	/*
 	 * PTM responder capability can be disabled only after disabling
 	 * PTM root capability.
@@ -791,8 +783,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 
-	dw_pcie_setup(pci);
-	dw_pcie_dbi_ro_wr_dis(pci);
+	dw_pcie_ep_init_non_sticky_registers(pci);
 
 	return 0;
 
@@ -803,6 +794,43 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_registers);
 
+/**
+ * dw_pcie_ep_linkup - Notify EPF drivers about Link Up event
+ * @ep: DWC EP device
+ */
+void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
+{
+	struct pci_epc *epc = ep->epc;
+
+	pci_epc_linkup(epc);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
+
+/**
+ * dw_pcie_ep_linkdown - Notify EPF drivers about Link Down event
+ * @ep: DWC EP device
+ *
+ * Non-sticky registers are also initialized before sending the notification to
+ * the EPF drivers. This is needed since the registers need to be initialized
+ * before the link comes back again.
+ */
+void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct pci_epc *epc = ep->epc;
+
+	/*
+	 * Initialize the non-sticky DWC registers as they would've reset post
+	 * Link Down. This is specifically needed for drivers not supporting
+	 * PERST# as they have no way to reinitialize the registers before the
+	 * link comes back again.
+	 */
+	dw_pcie_ep_init_non_sticky_registers(pci);
+
+	pci_epc_linkdown(epc);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_linkdown);
+
 /**
  * dw_pcie_ep_init - Initialize the endpoint device
  * @ep: DWC EP device
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f8e5431a207b..152969545b0a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -668,6 +668,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 
 #ifdef CONFIG_PCIE_DW_EP
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
+void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
@@ -688,6 +689,10 @@ static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 {
 }
 
+static inline void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
+{
+}
+
 static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	return 0;

-- 
2.25.1


