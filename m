Return-Path: <linux-pci+bounces-4829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA8287C005
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 16:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650B22842CE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF0F74439;
	Thu, 14 Mar 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEzzEoCa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2771B3D
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429880; cv=none; b=p6hSlT74u22kIdnXjSauB+oZjGxDun23/AByWViFDmt6bz8RQACmeAqBJPM5+Ge91KzxwbFfNh9dJdI+HvTfc9z3+ghRxOe615nxPdp3lqemrd66+kJJ6+THl1G7mtez6nLTLn8PLHexuLxh7oFkOsbGHUxa/JlOk0xcPCHrg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429880; c=relaxed/simple;
	bh=VIhM1SwpvHKiQIt6fbXoqrPwWzSD6KDDn6A+YzkG9es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdeQqyDLpKfCwnOvjzBuU9INz74o2GpJh867y0dEvwkw8xYerMHk5WX7lQxQpVr6K40LhCCSIs5wJydDhaTWnesL9dBsA6TWInf9XC0jOs5RBi2W8uIdAnZVWdeen7MPBGPDziFJ/7D8VX+O04tRGgibT9KAYI5nVaSBQI1EOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEzzEoCa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6a9fafacdso949542b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710429878; x=1711034678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+1EDsXsf+K7qsHNtt8lSB5yG8fUoLJEBKbvpIYhu80=;
        b=mEzzEoCa5d4RajdpZCnLrF5z/CA3bzH+ykZtHy3Dj7kb77DOZepWne37NCOvIzteVR
         72OFznE98gRZCH7WaHBHRdiHsSixi2j/Hzey9AQ/bx6o3K1dls9Ap45K5F09trApuXcm
         JZPm1u8CFLLcoM0//ejut4dgPU8VQnOqu/53BHDZdrNpOLUDrc3XdLrh1Giml9iGfdz1
         mp4ZDslWkEJYbHbWS38SzzUbP+FB0o/wUVHLhBvw+J3HszJxA5rTddXL4jwSYSbqswvD
         LSz+hqxYgMfQO7AOxLFpL50+YdsAXxokMLC74uhcr7hALNFq0RLn9UCrubRlCx1GXKRI
         fzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429878; x=1711034678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+1EDsXsf+K7qsHNtt8lSB5yG8fUoLJEBKbvpIYhu80=;
        b=B0imsGBwpueN42jcd/9363HdZzwXF14ISqLtl6ec9SXfRwrpBSi8FgtuQ9AszLQCZm
         rjrYY1neK3y72b1SPsHNfck/U/uG3ta1KEaovTsXWGsyD0Q5yIrnFIOTVu2kBiKhXIR7
         sHRwNgiejGY44bFtfTU3T/Dk3HV3IAgWkK6y/HN0ht/psC1dmYQSlALgg4aORReKO+vP
         lJu2IVqDghEVUDKPtB81Vg2/Tv82U7WgBOJCLCA2Sij0WsbG1Ro2G6p2cNtBW572Z9dC
         4sBOZUMZJ4yVRBUMwiwGHCSdZaDAd26iwRFrVncigtMkimEC4jAyDeS1lU43+ddv0zmz
         mXuA==
X-Gm-Message-State: AOJu0YziWG5KXDsoETIQiKihEjDLXLZzFkCAA0U0kxfnqjBADypTsRTe
	M42LsJwNGlqkHyyxCPl2TF+W2EvkBMa7xQoDTqYlv/9FxerietxgIvA+NKyCuw==
X-Google-Smtp-Source: AGHT+IHoLB0wNaD/TQQxaVTbwCg0im3uKyRHP4gFVLzEzVwpoWWp9ZBksYQVG4r0KJYAhdjPsuz3iQ==
X-Received: by 2002:a05:6a20:bb05:b0:1a1:876a:9cce with SMTP id fc5-20020a056a20bb0500b001a1876a9ccemr341455pzb.42.1710429877636;
        Thu, 14 Mar 2024 08:24:37 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b005e438ea2a5asm824021pgk.53.2024.03.14.08.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:24:37 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 14 Mar 2024 20:53:46 +0530
Subject: [PATCH 07/11] PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pci-epf-rework-v1-7-6134e6c1d491@linaro.org>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
In-Reply-To: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6439;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=VIhM1SwpvHKiQIt6fbXoqrPwWzSD6KDDn6A+YzkG9es=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8xaPzHacr4f2+bSYz1iL9JkmwfhQE2tur5A5R
 UUhqYpqWROJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfMWjwAKCRBVnxHm/pHO
 9cbqB/4uJjTB1Y9VeeO4iRKw9T0+L5QipjpUasXox+jAgRVSksZgHw4m5hB6RIctDazj1umuHw0
 N0EtreEhcvM1Y4A8cu928KFVnpOchFKgtXyalC4FAdGD/rg1I2WVRvMuRLbBu80CIhL98/ZswFA
 BvjPX7y/JTuTam1d1P4uH80/6y7bGk2ieImSJweyJQuE0P/Qkb/1by8q+RKbEjpChqwL6CVSI7V
 t4Z4V92Xpg1Vt2IHuA9ImY0yTtzaYIKcdJW0AyEq7UQK9ixPe1TBjnPPc5kVJ7DNZmNiHxJnMHz
 eROokTARv2SJO75nSQwWKI2EU9BjGVV+qdijIVOiTD8YqhWC
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 93 ++++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h    |  5 ++
 2 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 3893a8c1a11c..5451057ca74b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -14,18 +14,6 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
-/**
- * dw_pcie_ep_linkup - Notify EPF drivers about link up event
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
  * dw_pcie_ep_init_notify - Notify EPF drivers about EPC initialization
  *			    complete
@@ -672,6 +660,29 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
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
@@ -686,13 +697,11 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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
@@ -755,20 +764,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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
-		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
-	}
-
 	/*
 	 * PTM responder capability can be disabled only after disabling
 	 * PTM root capability.
@@ -785,9 +782,6 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 
-	dw_pcie_setup(pci);
-	dw_pcie_dbi_ro_wr_dis(pci);
-
 	return 0;
 
 err_remove_edma:
@@ -797,6 +791,43 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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


