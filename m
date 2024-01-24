Return-Path: <linux-pci+bounces-2516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF183A56D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 10:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB4B2D04D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7023C17C6B;
	Wed, 24 Jan 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjy8+86Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EA17C62
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088362; cv=none; b=Q15+DY86UAfaGYQjDNnMFR9HTvw1bB13D4e120kXKkkhPFy+2rdvL3ACLmtaqQGPZRaYSQanGwHJT7s2ZxwYThELZ6i1PP40HdsmzXRPZtXhEgPH5VlOllIqJ+yENQBgn0cdUk90+lUkvqvV+vaA6cMBFAmmfcBUokugTpwtOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088362; c=relaxed/simple;
	bh=/T4qp7NeBxf2y4VlW3CTSxvFocyExxLNjf4XK9Y98ok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QtxqBHhheLudh/zqidR7qhOGqebEGSa5kc2f9t0/XRAuhddu7+CSWaIQGP6w/F/lfgs7iD07iTPYwotOZ5GbooEZQoAt5U+PmV85KnN1GlaeiPuuayC3ECFLPIUTg5Y2yBoBkyHfsaWFjy4MSF5p41Pi3zxsJu4/GG/0kR34dhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjy8+86Y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602990c3b65so12855537b3.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 01:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706088360; x=1706693160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWHRVmzUr4KBxNqEMy2tpsvz4kpYJ3pdbxTLEf+rBg4=;
        b=gjy8+86YHv7k9E4nuCW8V1Q9odx2tQ68pWZ/xxsSWBTAnjs7lq/dNOWg2Su2qvfiVX
         pfifvFQrREEUTwrMSPEFBOLjwhFZ8ah3JYIICe+1nBljK38E77vcONYRjGRdKMzjPvRO
         4cjHyIt89oO89QjgxDqwAlDObt9HD+z+zFRwrd/ZFSPsrUUQqzXdxT6c/QYIvRt77uwR
         2NIe/Jcdgl7dPnLLpDXmyZDecx9Z6sdLkn0lGV8uAHNcT5rrLZgjvFxYWaEqw54dljM/
         qIp0P996ZWqrkizkN8LJ9871e9wGG0K9wjp5KXc0yeDnLGNQ1BYXE0aYRih/FiD1ZWcD
         laNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088360; x=1706693160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWHRVmzUr4KBxNqEMy2tpsvz4kpYJ3pdbxTLEf+rBg4=;
        b=lfNBPq3rfK44JA4puwAzY61bNSJK6YvS9txKc2+6Iu0euWnLKj7XmRFSM7vaRKroYm
         tPIEZnbeUsa4RJSPE2dMnPcnTLaS9qQrsw3p+gEkAjmgl3CsBuik1PaHCN8YAA+nih4U
         BSft/ekAi60R8Wwak/8CFdi2j/v8D8PmFh2C76HlbQMl73K4pSdxCwMVYo6KJc0Ectwd
         LXYSdkBoVJ9LwKghCCSh/lUKJSbCV4dJ8J5mAVf5SXMZn4zn5eUuGgC3huaz/1VMzi0p
         k+4TU7H+6TwkkQwT/QzdiacETLpoqSnwO2FxeNXJgExwuYs126bTACemUviR6ubRiOTj
         LwvA==
X-Gm-Message-State: AOJu0Yxmgcot/G/QKG8beug1/G/cT8vrFCeDyV7BdHdCNm2kL+GWAW6M
	gEn9cB/Kg0oTZ2kk3R8y84XM6u1GbTYDhZOlIjWJWgEmZaYa+AamfQNpvztWf0lBTRV0j4e7H4J
	RkO91oW5lIXdWWE+E3GaSkg==
X-Google-Smtp-Source: AGHT+IGhFhiCpwOPxI3ZTCpAKwgK4gpBc7OUdyO0zxBSWFeFdsh+XfrbsoGJJ1PqBfUZB+AQjZZxzXp0cWaOpuQaWA==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a81:9982:0:b0:5f8:b9b8:b120 with SMTP
 id q124-20020a819982000000b005f8b9b8b120mr272205ywg.2.1706088359988; Wed, 24
 Jan 2024 01:25:59 -0800 (PST)
Date: Wed, 24 Jan 2024 14:55:32 +0530
In-Reply-To: <20240124092533.1267836-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124092533.1267836-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124092533.1267836-2-ajayagarwal@google.com>
Subject: [PATCH v1 1/2] PCI: dwc: Add helper function to print link status
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>, 
	William McVicker <willmcvicker@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

Add helper function `dw_pcie_print_link_status` to print the link
speed and width. This function can be called from various places
to print the link status when desired.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 20 +++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b85..c067d2e960cf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -645,9 +645,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
-int dw_pcie_wait_for_link(struct dw_pcie *pci)
+void dw_pcie_print_link_status(struct dw_pcie *pci)
 {
 	u32 offset, val;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+
+	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
+		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
+		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+}
+
+int dw_pcie_wait_for_link(struct dw_pcie *pci)
+{
 	int retries;
 
 	/* Check if the link is up or not */
@@ -663,12 +674,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-
-	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
-		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
-		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+	dw_pcie_print_link_status(pci);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 55ff76e3d384..164214a7219a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -447,6 +447,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+void dw_pcie_print_link_status(struct dw_pcie *pci);
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
-- 
2.43.0.429.g432eaa2c6b-goog


