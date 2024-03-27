Return-Path: <linux-pci+bounces-5240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584BB88D9FD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 10:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C7D1F2C220
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBAC38F91;
	Wed, 27 Mar 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrcehUTk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFC38DFE
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530922; cv=none; b=qaVgFMDO76I19LQKmHI63NceJJ1aPukveDzW/UkBcI22NPFvNypLfAbTHKfBrefC8U/c8BKOCRccywXDLGY9SPQ1BzRAhkCEFvLemRW9PwigTdJdHh/svvMcKlioSF0Okjn3+US2NsxafJxYO2UB01njZUj9DL2Mlex+5Ctb83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530922; c=relaxed/simple;
	bh=V0Mzth2vl1K0DFypRpWN9TY0MnmoC5wp8l5W1GdqahU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGCIugZ1fa9ssoqn+/EwS0xpeCMOJe3MmG5o9jAXHK/TryR7v7gANfHeMF6mfGAXt7hMVhvTZo3kJODBoMyboCZOKrQL2f1Zol5s7yx8s4xpMZoCAaHXfAdZlnIYmmFDOm/9NkRK+crKTz53KvR5nVS1sUU0kbOKwBTnle0tM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WrcehUTk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so514168b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711530920; x=1712135720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+s99ic6a4xby36ko4cSNl1g4BMNR39F6N7WDhYUFLA=;
        b=WrcehUTk03GvAxTi9G1xRBmR+aeHFtunVq+teYiv/ZB8RjSN/JR6OYeMAvagCsH/8j
         ZPe/BAQfQJmZ6nRws9jmH4foQLLYxAh0T+ax3rxtWCXbtPayWD0ZLyMCb2/DZKr5ySCj
         n2jcKB8bze/XjcaBTnct9UdJzx8hy6rD7w6uta2kCwDYUYct7CpwtbG3MtVzyh1DLfW7
         aUOLCEiWflltXVeThhrAQJoevJm8W5YEKjVCQBXnmse4JgGmaYXkCI9kXdvsYgAxs734
         s/xbof+2PfazgOWVDpJYRYIM9Zb4eF3Vx+3ZKp4dKdF2TiJgJ13U968grIMaJ8znik/q
         b0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711530920; x=1712135720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+s99ic6a4xby36ko4cSNl1g4BMNR39F6N7WDhYUFLA=;
        b=EhZTpnEbZOoB8Ba+KgEQemGU6eOuqTUTKgw0c2idqNNtoLIha6fMV8a5wtA6KjAs8H
         ZurVDwDJY44RuJxed8IqDeiBADNMU7L06HkIRDf4le1T3D+THXMLqw148aUODuSOoBjx
         h+3kZ1O0XF1IscKIPMoVosv0MQbEQQ3iQ/UycfQs7hzDox6OgI9T10Tfb/JAhaq8m385
         7Sjgl+rji/8UMiwtUuSIChPWnsXmAeRCNZJVIKD6ibt0i3T6NuFwH5UYJWDbXApq8MPN
         Mz12FISgqCETl5/b/fM43MHssl47MaBIp1bX6oP9QcU+78pIvVFgGmOTccY6pKhVvNTV
         Y4SA==
X-Gm-Message-State: AOJu0Yxr5r1+IRnBTAIoPrqrfiJnOaM7jajQ3WCumkjuPDqM0h85h+rn
	3gif4WqZJU+uGDY8R4rfkIVyFyIkZ8c4WUUVSgSxdR6geLglaGExexnId0WZBQ==
X-Google-Smtp-Source: AGHT+IGGlNwqqhJyPDs53FUp8HnF8MxmatY5hAsgpFI+AE8YxYjYhWVdUxUP+eXF583iNe5GoKe6mw==
X-Received: by 2002:a05:6a21:32a4:b0:1a3:63cd:5262 with SMTP id yt36-20020a056a2132a400b001a363cd5262mr5531403pzb.26.1711530919209;
        Wed, 27 Mar 2024 02:15:19 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.52.77])
        by smtp.gmail.com with ESMTPSA id h190-20020a6383c7000000b005dc4fc80b21sm8673871pge.70.2024.03.27.02.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:15:18 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 27 Mar 2024 14:43:35 +0530
Subject: [PATCH v12 6/8] PCI: dwc: ep: Rename dw_pcie_ep_init_complete() to
 dw_pcie_ep_init_registers()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-pci-dbi-rework-v12-6-082625472414@linaro.org>
References: <20240327-pci-dbi-rework-v12-0-082625472414@linaro.org>
In-Reply-To: <20240327-pci-dbi-rework-v12-0-082625472414@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Srikanth Thokala <srikanth.thokala@intel.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@axis.com, 
 linux-rockchip@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4791;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=V0Mzth2vl1K0DFypRpWN9TY0MnmoC5wp8l5W1GdqahU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmA+NJlxhtcI5x9HWzPDSMHMbS7UUf3ccej2MOr
 Gzs0KQ0lNqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgPjSQAKCRBVnxHm/pHO
 9RqICACXtyJ4U4bh9LLyWGD3MnW+UaIlaEoKFtd4l7YOpLPXe+ZOCiCG2SqP2VwPGBQB0AYX3Xi
 0wPUXq/TdoUXUgXkKzNjY2AdItwj+kDbJPVrMu6Wf4VyxDfNwM/X53E7QMmUBynilnn6s4wTATg
 o/NhZDNTBFFSDkRrLYdPeZdAG+TryXFOBkadhD1Phx/6iy4GOTCQajvuGi9yvDHWu0YTtffO47l
 ixzD8lGfiQBguL3irb2Oi4TIbZSdC2YOVYto+eG7SU/TTU8cH6O7xzgNj1EmVpx0lwqRohk01PL
 oc0BF2SEjA/fL1yk3YTlMDuWlzBOmS0ZGJTw6wchBfxS/Wxy
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

The goal of the dw_pcie_ep_init_complete() API is to initialize the DWC
specific registers post registering the controller with the EP framework.

But the naming doesn't reflect its functionality and causes confusion. So,
let's rename it to dw_pcie_ep_init_registers() to make it clear that it
initializes the DWC specific registers.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 14 +++++++-------
 drivers/pci/controller/dwc/pcie-designware.h    |  4 ++--
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c      |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index eeff7f1ff8f1..761d3012a073 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -674,14 +674,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 }
 
 /**
- * dw_pcie_ep_init_complete - Complete DWC EP initialization
+ * dw_pcie_ep_init_registers - Initialize DWC EP specific registers
  * @ep: DWC EP device
  *
- * Complete the initialization of the registers (CSRs) specific to DWC EP. This
- * API should be called only when the endpoint receives an active refclk (either
- * from host or generated locally).
+ * Initialize the registers (CSRs) specific to DWC EP. This API should be called
+ * only when the endpoint receives an active refclk (either from host or
+ * generated locally).
  */
-int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
+int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_pcie_ep_func *ep_func;
@@ -801,7 +801,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init_registers);
 
 /**
  * dw_pcie_ep_init - Initialize the endpoint device
@@ -880,7 +880,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	 * (Ex: tegra194). Any hardware access on such platforms result
 	 * in system hang.
 	 */
-	ret = dw_pcie_ep_init_complete(ep);
+	ret = dw_pcie_ep_init_registers(ep);
 	if (ret)
 		goto err_free_epc_mem;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 351d2fe3ea4d..f8e5431a207b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -669,7 +669,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 #ifdef CONFIG_PCIE_DW_EP
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
-int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
+int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep);
 void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep);
@@ -693,7 +693,7 @@ static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	return 0;
 }
 
-static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
+static inline int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 {
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 59b1c0110288..3697b4a944cc 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -463,7 +463,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	      PARF_INT_ALL_LINK_UP | PARF_INT_ALL_EDMA;
 	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_MASK);
 
-	ret = dw_pcie_ep_init_complete(&pcie_ep->pci.ep);
+	ret = dw_pcie_ep_init_registers(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
 		goto err_disable_resources;
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 26ea2f8313eb..db043f579fbe 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1897,7 +1897,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = (upper_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_HIGH_OFF, val);
 
-	ret = dw_pcie_ep_init_complete(ep);
+	ret = dw_pcie_ep_init_registers(ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
 		goto fail_init_complete;

-- 
2.25.1


