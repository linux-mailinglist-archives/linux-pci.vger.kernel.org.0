Return-Path: <linux-pci+bounces-8388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F2A8FDFA9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 09:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C652878E2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F2013DBB2;
	Thu,  6 Jun 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znwwoQFb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6213AA42
	for <linux-pci@vger.kernel.org>; Thu,  6 Jun 2024 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658871; cv=none; b=NR6fG+JpytdNvmBVNWLoYPKJsvOenWRsVNM0EDbHDi8kTA1aSU9vYdgfVxAIibJH+v6FuT2phJF4zTlbdUBuC8jPk4fImgYb1NO84eG8arOFqQUMrVi6p/vQHsUqlj/vrnokc7jSWfk34xH6fpubJlHe5Y8ITyyGp4Nb9YfSx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658871; c=relaxed/simple;
	bh=O5xFzhtcTVsPW2oRgvJYNIDWPOdCoxabhuVw8QIdZvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNpwlVqnropuiXiuscgfcfxhQy4SePG4tpxh3M75intQJkIbEcUQOaGoAOcDa3N0mrzLk9X3cCu8XJMc4d8wX87eYsjY9IRMozlh0sU9IZRDAiAk2TzZcnZKx5X5Dog04lQeg5/3eI61CK4PBHETPZjh6qKkk4Ull9qs8GdY4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znwwoQFb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-701b0b0be38so629733b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Jun 2024 00:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717658869; x=1718263669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJExdlshI/LzGxmgV0APY0jbCwHbAgtoC/BDFnsN7OQ=;
        b=znwwoQFbtQ4wuD1IdNsfzQ7379LnvmYCXOqxvB7moAZTXqv16PZlygjo83KuJpsil/
         YUsesmjL97zwB39o0/3IM31Gwz7V2b9l4CPX+X72bpz2iAZnWFwvGdkPTjuTh2Q4htLo
         9gmu5IMPJllEx8d+2PM9ipUhGYGdm6ooxvEAhTAbnVvFcF4QrPSemvAna8FJ3mBu/Z72
         3lYlO+nxI74z4hXw1ogGp2v/tp3QJRObMCMYpEPB+yJ60/51/CUr0U/mJMPoFP/pHfMI
         /cg4LvTiaYmLUfpKYRF7TtuF9EHIW0z4zDzhDxhwSPZD8HahC7xO1fEHuJumrq9cP+AB
         erfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717658869; x=1718263669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJExdlshI/LzGxmgV0APY0jbCwHbAgtoC/BDFnsN7OQ=;
        b=ePt8qWWwhvj0R1S+qE6fZl8uufPH8oJlRmA5H1J2FhtiWoTLFsM6YWIi7zSgd1j1P5
         oa4LiB1A5m9+e/zCe7zK5OL+D8oyw+CcII2FMZNyR3gzoYTv09HDwSiZwlTIzQ++EdkX
         qiau56l4JmemvrfU7w2C9m52BKeJvAdR+FhGGOCBkqzBH5MhbPgE7FFG61IcX2VYX02l
         5clIKGEJvWiI/wZat3p77uft8DwlnjV2CWIgWeHuhlzzr6VwI/QIPoEXGgZRbs6aaiOv
         GKvwWeuyo3MIrwq+pSLd2jquzSUxXb4B3vHjxReNSnOAoXLu0k5oFUBzGmPwqZVs5uqT
         nPyw==
X-Forwarded-Encrypted: i=1; AJvYcCXfrp0r998ENnZRSotO8tZQPAYl4QJC33SaXGFfPQEYpzIApbEIo5juW0fzldflKGYuMDissFI9PWWh/NbRrcyGa/B4RCQaMmP/
X-Gm-Message-State: AOJu0Yw1IXB4IBkzgxU2P4WtyEKXtTYhqm2uRPpZBFXItgkQ4/3swlDI
	jjZCtqXhyRzsJx3gL8wFnP6kFlRuwy3ij3XikkmU1rHTAl+wzlxRJT1SvikddQ==
X-Google-Smtp-Source: AGHT+IHE2oR5v0Why3yjnX38J4mrLlwOPGlZ2u6XUoxDRmSxOxrVfN+J6poCz9GXnIiql3GkZYmfXg==
X-Received: by 2002:a05:6a21:6d96:b0:1b0:180b:218a with SMTP id adf61e73a8af0-1b2b73ade98mr4841566637.13.1717658869466;
        Thu, 06 Jun 2024 00:27:49 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.142.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd494feasm566621b3a.100.2024.06.06.00.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:27:49 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 06 Jun 2024 12:56:37 +0530
Subject: [PATCH 4/5] PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-pci-deinit-v1-4-4395534520dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=O5xFzhtcTVsPW2oRgvJYNIDWPOdCoxabhuVw8QIdZvA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmYWTCDD3Zk89+yzevKC0hNBYDEyFsV6QzuZHsh
 tHaN4WUEIeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZmFkwgAKCRBVnxHm/pHO
 9R0cB/9bA9491NDevYfqU5Xd3giwVDoj11ZyiC+uOfmItJ2Mqg+LjY5yIgYgU2b5u9eza2+qgOi
 4U0wQ++MHB3cRN8Qfi6FrDe0E+qa0KqH+kH+cY35umoGm8Zpgcx4MwJ/tMbjbEDe9tmPP6pdeeo
 aoRbCqLKiT7RwZIm/MH0OGPuFhv9nisV904RgEfR3gT+0Tpx3feFJWRFxSULskIjFCUOfubNx57
 A8RoeX3+G02D4OkIxrJBn3o6BIPuD8zGx+pfD2AEwZMjJAUhWsHsYx8R5f50vb+7YNWV/GhNkbP
 dPojiLZWnG6HfXVSNGT8M7+Mr1QS3JOavCuJ4pGNZfPAW5uG
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Now that the API is available, let's make use of it. It also handles the
reinitialization of DWC non-sticky registers in addition to sending the
notification to EPF drivers.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2324e56c9bfc..02a2a871a91f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -641,7 +641,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
-		pci_epc_linkdown(pci->ep.epc);
+		dw_pcie_ep_linkdown(&pci->ep);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received Bus Master Enable event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;

-- 
2.25.1


