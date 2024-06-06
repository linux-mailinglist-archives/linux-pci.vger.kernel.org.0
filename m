Return-Path: <linux-pci+bounces-8387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E2C8FDFA1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 09:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79215287C00
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 07:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8413C67B;
	Thu,  6 Jun 2024 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZnZ2gQ7N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5A13C822
	for <linux-pci@vger.kernel.org>; Thu,  6 Jun 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658862; cv=none; b=dLaFsaSPlf9z1JW+syIDWPRhRYqyr92htsWEO4PSafzURd/BJ/MUjNlG9Ahk72teDSqhYyOy3kn4kxOjZcf7Stu27MIvVQhJYLONqwBxTo9YTX+nQ7TGzHhBO8W6R5FoVopDX9KZYQwYjGyrCoWbIkB+OHn+BSiJycBU38HiEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658862; c=relaxed/simple;
	bh=CyPVVcJODJ2tCBdthwAVOus+8aJwJCp9nbRVeHHFCiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fqc2pdWACA5PGLvk4CjW5howizBAHsEL7Vb+j424mgtr/ceAGQiLwa7fwyGUwvbbRTQN+izqsp6dQQ1SpTkbzOKMDAs2sY77cl5omoqZ58hGvXWj605fajnp/Sw72tUfneKfKAProYL00BcdrwJ/K9YmmfYHT0idNEkUXkMUH7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZnZ2gQ7N; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-702508bf0a9so532583b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Jun 2024 00:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717658860; x=1718263660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7dQ9TfqMHdXG8LG6tUjAnjQ7RMaAYCpFAwKOPZMm9w=;
        b=ZnZ2gQ7N/w/LsBSIgAqLsQ8jkb29/AtxGee0JchkkpbBS6AznOfhNiWBdJdwxYWmrK
         U93v7xekrUf0wEu6V7mHXsajBJu3BWpCM9yrQs9TQgpOqK/yuda/aIQlShrrGHTKK70Y
         VXSac70sGx+PO8H7M3reQcyonmHgym1JmWOjxNhDjSVKx5qmxaXXkAnjGFW0OHwP2a9m
         KotbIJUTjx1a/AVAXliCqhLmOrmS410btPTJ0HTID4ZdyHK5dbnPI9FSa0Z8Hkzs2IIF
         P0f7erYbc9ChMTOd27HXb9bySFi6qH8wVxxk7EfWrtqesRpUAUZj9y5mbPrMsqVWpJRj
         V/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717658860; x=1718263660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7dQ9TfqMHdXG8LG6tUjAnjQ7RMaAYCpFAwKOPZMm9w=;
        b=PwXPSwS20/nTw6SEE8IpAFazkxrIxZ/5+pSnQ4Y81tFwiSaoadgIrotblxszMTZ+HV
         CYE8hl7qhcMQZrK7uqjHOeWd2SippRAOAMwAedLIOit/yDorEInEGd6jr5UVlmndMYpH
         LipLJiiHa6j3og4I8Lk+n0XYpXPg/GcClb6uNqxnIFLJ3c7AAtkmViMG+cB5R+LUYJfR
         mZyJrDczgmVgjfOINDG8GFXfaGPno4tQOBl4X4l6329UvGp0iEwy7Ug+5FK82E5TzRgE
         3mIlSQjsIeYpaRzKwGsv+qpx3o3cOqn/fxoU1IG0hO/Mv0QtGRr//nl+vUBgigM+YV/1
         lGug==
X-Forwarded-Encrypted: i=1; AJvYcCXtwE8aIe2+LjB/iMhxQEJ7YP0PPcuzPPkO0+s6QhW+KpvNY3BIOF5ggNImZ+P4Lr+86rCAt9QSqK+pSaEK2+C7jzoD/Ml0qiW7
X-Gm-Message-State: AOJu0Yyu+kuQMLZrGm/42TcyOqpNoq7kVxerR7sn5ExuK/sMpYtYkE7u
	pyCQT1EZyOdqgA6bAedgJCA8H9/dzwaUuY4R+V32NJCh7jVclBeyNrxsd6GaxA==
X-Google-Smtp-Source: AGHT+IEHiQ8WtwlFSj6EjFB6496Btx4UY0bPcJcqZ/rLzZcY0YY29ZVlXGd6vnqJZdPzzFq9RezUpw==
X-Received: by 2002:a05:6a00:198d:b0:702:5b3f:6c1a with SMTP id d2e1a72fcca58-703e5a5d66amr5009435b3a.32.1717658859582;
        Thu, 06 Jun 2024 00:27:39 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.142.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd494feasm566621b3a.100.2024.06.06.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:27:39 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 06 Jun 2024 12:56:36 +0530
Subject: [PATCH 3/5] PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API
 to handle Link Down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-pci-deinit-v1-3-4395534520dc@linaro.org>
References: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
In-Reply-To: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Minghuan Lian <minghuan.Lian@nxp.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Srikanth Thokala <srikanth.thokala@intel.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org, 
 mhi@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6883;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=CyPVVcJODJ2tCBdthwAVOus+8aJwJCp9nbRVeHHFCiQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmYWTC1tIEUprHWLU3EJbohGb4dhy/c74Ocfx/L
 gFMNksZJ96JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZmFkwgAKCRBVnxHm/pHO
 9RqiB/wMM8Tt9y5MfBLY75mIEysw4v7tQX00FYGFLUMXPKf2oEKReZt+8J/fkmIfXEHWwiGONN2
 uYmAwIdX2adk3LvRje/TCwo/ejcIJ2zykk0oss3oBr6t2GJXXIPuAKtNzISB4p2D3ey/Vjy/6xk
 0Rtzznh3Wlz5rda3ypN/B5AEOGTLlzLQiqIYgn4iuPIgntiAE18mp0zhbiRpO4X/EwLyFSV7cwB
 X8XO5m6EKI1tkg6yVUJAsu4CJFSupVEEJbczhUSeXBVeFErpeyQeDM4ovmeHVXxvX+JHrTwPk+q
 eP90fxT0EFQCjKr/rr15hqsncrMBMRB74CQmXHyqxFRtrBCr
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
 drivers/pci/controller/dwc/pcie-designware-ep.c | 103 ++++++++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
 2 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 78d5fc72c9cb..09ad6f7b5095 100644
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
  * dw_pcie_ep_get_func_from_ep - Get the struct dw_pcie_ep_func corresponding to
  *				 the endpoint function
@@ -661,6 +649,34 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
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
+		/*
+		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
+		 * size in the range from 1 MB to 512 GB. Advertise support
+		 * for 1 MB BAR size only.
+		 */
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
@@ -675,13 +691,11 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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
@@ -744,25 +758,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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
@@ -779,8 +776,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 
-	dw_pcie_setup(pci);
-	dw_pcie_dbi_ro_wr_dis(pci);
+	dw_pcie_ep_init_non_sticky_registers(pci);
 
 	return 0;
 
@@ -791,6 +787,43 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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
index 49ae845a3662..89f9046af7eb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -668,6 +668,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 
 #ifdef CONFIG_PCIE_DW_EP
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
+void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep);
@@ -687,6 +688,10 @@ static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
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


