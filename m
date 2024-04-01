Return-Path: <linux-pci+bounces-5492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09704893D62
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B744B28318D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B638548E4;
	Mon,  1 Apr 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h71Z7G+J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2054730
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986685; cv=none; b=AhnkmIARmeq4Pn+F0WXoQ5cbFjj+1Os32BaMGAjIsllhHkXoN2bTrQHL0baVHHA2XEGLdRMcIEgOqyzjcabZAPxWZwRulD7zXmK0eHkRI3yURojeQmHr4Q66I2OWimdcn8vpcRKG7Af1Jp77kSot39F5Mr/Dh5pKxCyQv1hDf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986685; c=relaxed/simple;
	bh=8yY6jCOZX7OXEAdw+SEiYpcVr/6cp2rpK2Wx/LrayPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pCe2YtTYrTqFyc9RSEo6Gv8RBA/4xpql60f+jyOWyIkZXX1X90VPQ/IkoCDE/m5z/dcty8OtXCIYhvNQvlJL8yAGMm0Eeb+6Q+l2BUKy0MUlRNUT2oh96xgR3u7pnrH5QCj9XmGN6kTOx35R/sWcfe5FdekUb6Av2AojByyYza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h71Z7G+J; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dff837d674so31690835ad.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2024 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711986684; x=1712591484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jszqw6C2qSlbopOLyelwWx4NbFpqH3DEAKuVgxD1es=;
        b=h71Z7G+JJsyLTn9bgyHREzG7HRT5GeYqTkbemBCR8G5235KsBTYVhN6T3VnTy3980U
         cQETVDQVaaxWDNuQ9k3v0X2GMpjhMkuROpiWIO6A/J5M69ej5ZMqOdqYWeyQzUEv1hxH
         OJYSWlDxrTL4MrmOJu6LYkZa8oLM904GAxIzSbox5aJHZqhTELDfES677vPNs6VLJhii
         1jJuGPgpPBcieVHaQg1A5V7zET0MA7T3A4owQahIkTpO+96k61iq3M6BjLHeVIUUPsOQ
         3PwdmDHm+qMtgAA5IbJoUewFeBttSVju7CanfIYNR7xiO4MAsoNmwED4mXrqQtXnnnzF
         oVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986684; x=1712591484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jszqw6C2qSlbopOLyelwWx4NbFpqH3DEAKuVgxD1es=;
        b=cYEh2C+14h3bSXCGcp1hcWWE6LOv7MDrWWlGfni/kWNv8QNny051V9Gi1WcpXMZtI+
         35jnWnTL+ntkKlwcboTLShXYB60sxgAwsj5Ip3MiSpo0fL6YmA+wVJjlATODu484Julw
         Ntp73miVpWz3DSfef0X8UZEobnwdH41d+P2G5+wpmPk+VxdfHEsi4V6TEnsvzg/+ZYgW
         0B7pNioCEzYqU5sEBTgDwaz1pmrnAZnRrLpUbnXvPdZ2ojNksQ/tGNrDI7VvRuyQsHxN
         +bQErSDkYYKStEij2zRDUHHjNHJGEdvoh46QJmVI7EZ90MdmhFHgfJNKS6wlUNLcT5BA
         3+fw==
X-Gm-Message-State: AOJu0Yys8zPBHFyH2CbjOjw7MF1oN+VW4XjB0vwml1g0lVdjTfqZZI1A
	9kQaiwpSx45FxIjw1fKfZQAWxhrp2EHE4tbaqOhqu4o2zCRqVCRv85Cm6VUqjQ==
X-Google-Smtp-Source: AGHT+IHULv2dcA00LFbG4IUgT0rHHhvPKHKi4w6PpAp6Nyjs1Q6Qxfsn8NeioUr4m216ngvIirDE6g==
X-Received: by 2002:a17:902:d492:b0:1e0:e2a4:1b1b with SMTP id c18-20020a170902d49200b001e0e2a41b1bmr11748880plg.0.1711986683577;
        Mon, 01 Apr 2024 08:51:23 -0700 (PDT)
Received: from [127.0.1.1] ([103.28.246.102])
        by smtp.gmail.com with ESMTPSA id kh6-20020a170903064600b001e21957fecdsm8949076plb.246.2024.04.01.08.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:51:23 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 01 Apr 2024 21:20:34 +0530
Subject: [PATCH v2 08/10] PCI: qcom-ep: Use the generic
 dw_pcie_ep_linkdown() API to handle Link Down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-pci-epf-rework-v2-8-970dbe90b99d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=8yY6jCOZX7OXEAdw+SEiYpcVr/6cp2rpK2Wx/LrayPc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmCtfV6J8VpiGQ+aH7wa+/NlTond9MlF7bJLsXm
 d9oE/+P1emJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgrX1QAKCRBVnxHm/pHO
 9c18B/4wB2b/Olqnabq+LzKAm23UYq0JFUhH2Qhade00RQj3OTcedNVpMx4UL8xMRS+4B8p/SeS
 xCYORBSL4g0whqjretPvkDWShAqvZozuSdlJg9HALExtjrSPRUVwFUPkCU3ckGOSOq3GFDnlxtE
 OCufJkeUAdH61kw1HG3N68f76R73Hx1TxiHD4fdou4clcoUE2UyGcwWNUpepCV1jAoIX9U3/mC7
 0hghQdaBJfpjKBPI3paNexfLsN3OULjAQJ0VqOHVAoQzy2wrFDLsB3EJEBMMmp0ISggPfiVM53P
 P5aYybqqH9z/OHedlriYtvH64hEBIsX+WdwDpbiKUMkUCnl/
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
index e4b742355d57..811f250e967a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -635,7 +635,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
-		pci_epc_linkdown(pci->ep.epc);
+		dw_pcie_ep_linkdown(&pci->ep);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;

-- 
2.25.1


