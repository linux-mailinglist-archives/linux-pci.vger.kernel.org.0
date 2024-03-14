Return-Path: <linux-pci+bounces-4823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F287BFDE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 16:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D301F22DA4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE74B7316C;
	Thu, 14 Mar 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LK7PBwQM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7871B5F
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429853; cv=none; b=tCFdRLDbn3GiT+SfZZggyDXR2yvWPWpmy3NeYHBySmBcupK6jFfAH4evFf5TVCl9j9IZO6mGzVvTIswvuF1ZBt9l+HZSRubcXH7frfvGYLbhPtBq+uSpy4cVWsin9mQJs3t7Qj/IpinDKt9EW+ZzkRb2gCaNRmmu6WVPGIQ/qf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429853; c=relaxed/simple;
	bh=JRZLwKxhEM0x8HfB67G9+Fzppqg8xFqlyA8aRxI9XHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMKJs0NYfgl9vD5dh509jFg5sucNOdMBBuCRzLEZRyx9vpcXm13TwZST5j5jIdNfLXadviuvv+J2M5jHEsAki54B95PKcxAfA7+2CE4v0geAP7xRNp05mQdKV1wR2wVmie2AeoMqthba8ZDyBFsMiT0HBkJQ48csJbXoWFE1qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LK7PBwQM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso340949b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710429851; x=1711034651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IrOa9F9FCptyyElLcaGG4pDepSH3LTIYhrJfnXA2HI=;
        b=LK7PBwQMYWbLkvRxwvWy/ZjWPoXZwFihG1FkCi0AIudAoVAB1eS0H7bH/s3Oy6y6jk
         AF0rYbkid5IvNxMpChhQrDoMdEmVgp1vo/3+y8qmMI/rAnubePompPYvVzReDulzX1uo
         znWPI8C7hQ7CbQ94rPH/OCmc45KtaRYsRcckWj1zLLNAGwTiyhlLs+PNUWLdtLOAZPZc
         K7ufHM2XenZaIthORJ3vX0Ob+vOVNVNLsI8SJKRhetdnZ5+O/rdViopv6cbqRCxlyHK5
         s+/zYojZ32by9TLWxXMr9KYeZrHjwcYNalAIn9PuYIuBYNmGAPeXBvJuXZ+hZzkr0WGT
         lF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429851; x=1711034651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IrOa9F9FCptyyElLcaGG4pDepSH3LTIYhrJfnXA2HI=;
        b=ESaYl4yN/zLCHR/scxIJQjc/F8D/glf2wBW6J/4xlpqs+XaswO5NWskWuvADVsmlJi
         0fjjJdHN8HFACXtbtG9AviQXB1QqHQWw2SHit3N/sGD7EnXZsRFDfB4SQBa83zuf/7e8
         3QZTOXNnGJB8WqGUMpRDIsk85PIppph0duJQkqy9fjIiqh5L2sO8n3qXGYR6YPqGlLpt
         xlW+aARsYz9SUCUh0/KV2ju6Te8Bfg0p0+zv5njTWpd0tQTVAoJtMf2dN9IOKkcw0xyG
         ONZZ2mYSK7iXxQYT8ANvlsLJ0YjIW2SsyTJHM7GeQ5UtC1ha57BGEnTk3Wge/nyVbEiX
         XNXQ==
X-Gm-Message-State: AOJu0YzrfxfvtvMFgX6KJCXEPAoZhsweOJEMbya1qw2KOUHtqcQSoxqB
	eN8MdFTftz1AAQyXkQWNPOk1KLPCr7QxObFRlgMPNmJT605wnLQ7vZHjtcEDKA==
X-Google-Smtp-Source: AGHT+IG7jwbZIclHbE1GnAK6Rj5Bq8CoICWzMlScgrOOGIyJU6eaD/H0E/Up5FStL4M0GtXAcOvRKg==
X-Received: by 2002:a05:6a20:3941:b0:1a1:e41:3edb with SMTP id r1-20020a056a20394100b001a10e413edbmr3110511pzg.11.1710429850762;
        Thu, 14 Mar 2024 08:24:10 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b005e438ea2a5asm824021pgk.53.2024.03.14.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:24:10 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 14 Mar 2024 20:53:40 +0530
Subject: [PATCH 01/11] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=JRZLwKxhEM0x8HfB67G9+Fzppqg8xFqlyA8aRxI9XHM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8xaOLrQOPVb1HVr/175Bwj4SLK9E64perYmGL
 IBSuWUMVHGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfMWjgAKCRBVnxHm/pHO
 9ROLCACSxVDvqf0sTonqAB4efCgXpbE8NA//bIFdXLvO2DxsLrdraqYdwvMEiH+CAtxrSHwW3cE
 FCGe61CdFCnn3hhtoh05WnTStcOoxu7X2p8Lah7zUn7BBg7dScjvASClkPt0iqwsQjNhi0LmwHW
 xSofd+6XrLFHrATDGnodX1uVN2PcZZSXJdHw5oINOdggFxeHD1m9exuzvl6s5gY5SJ3lgg4q8Nw
 SZ86dARIy67pxK4Tkui+6vLp8YpJuby4gtksND4QVksT3VGTatVl30dDQE+e86Ntl1YgSKaJost
 K6XAXGDFLhZf0jQo8+mwwqh3P5s4NtOxeKumlgu2yg6kSQ4B
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

All EP specific resources are enabled during PERST# deassert. As a counter
operation, all resources should be disabled during PERST# assert. There is
no point in skipping that if the link was not enabled.

This will also result in enablement of the resources twice if PERST# got
deasserted again. So remove the check from qcom_pcie_perst_assert() and
disable all the resources unconditionally.

Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2fb8c15e7a91..50b1635e3cbb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
-	struct device *dev = pci->dev;
-
-	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
-		dev_dbg(dev, "Link is already disabled\n");
-		return;
-	}
 
 	dw_pcie_ep_cleanup(&pci->ep);
 	qcom_pcie_disable_resources(pcie_ep);

-- 
2.25.1


