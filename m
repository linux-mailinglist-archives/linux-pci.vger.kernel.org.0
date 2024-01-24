Return-Path: <linux-pci+bounces-2525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9583ACD9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 16:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F136BB24341
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7B1CD08;
	Wed, 24 Jan 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pf6e+/lA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B315BE
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108638; cv=none; b=bLG37b1dpYOD/XUUOqJk7HojrHSr6NnxOxlpALC1XVKfF39t0oZxRX7U8BHtvbto5UPr/466sFF6im77O3XIgfxAqRhmeYHoDq/jnb79nMrvGTOzMlIGLruId6hlCCNmUdI2bPJQJe06abVg+V7MjT2XeCVQSd+yfjF8io8R58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108638; c=relaxed/simple;
	bh=T/pn351JESsRmM/aRPuZIGT3H4X/z2umZFJ27SQOtmM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a5wQg2vLsrAuEw8FQEg/3znh9Ij/aYLR/dLtzNOkG0FHsXsG707+vpAAnQGRP4nqyOlrruQDTJF95srJ2RqJg4Jw9yzvY6IA4kpM/pb/hu9S6K8Ujzz45l3Ho5BYBsOp/n62cviqI/WwKrVEHCgMeYRGjDd/UxbG2dSTN0YnQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pf6e+/lA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e76626170so61482385e9.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706108635; x=1706713435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlaR5UjpyG5Q22l5wBG4NSdMskPDkfH7d0hZ/q3K1b0=;
        b=Pf6e+/lAMoKPiAFz/fjTwAzAEOBeXmpzGuwQwb/M7m67wgWiZx+bn0IYip4CLyxFsP
         m6ZyFPZiQKxbOWFi+1ECBCzUgFyyMZmFNt8GYm/ftZbNeoDRZMqel2fpxy/9llpmkBRS
         lvVxM4T6Qp3IhSIy94H21WOF5Sosc2I+2kg99C5RcOlgRFAP1DpFxR0IbhfNrRhnt61o
         3796hbD779jgNbpGLo9lASUT5TNGySAxEwuM2HD/fZK+Yo2xJzacXn/YHdk7b7KiZddz
         XwJLUAvYiml6DpuhPxpBZMAEj1uvz+CJJSPV0jdudh+NGdKPGYcBCdfKvQmpoBWHAQpD
         hcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108635; x=1706713435;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlaR5UjpyG5Q22l5wBG4NSdMskPDkfH7d0hZ/q3K1b0=;
        b=J4CpbSET9X09bEI8Ri+DoCfGg5iVzEZWA1Pu6xax8p62lrSFJhoe9EZMA9pOCM/Lsj
         sBXLRGX1tfXgNlUnFuo81xUnS39SBRe2vIfIRuysgCUTc07cIu+w5Uq+Rd9Vqhf4kn+S
         Np5NM+iv1KhM8JB1UjkKsAwjss1kKHyibFiDF3NCv0nHzIYsg0nqvLCFaAXWgXQ/kseC
         juNVZ45/rmHrYXA1WHRpcdiX53P33K29YBmA/u9yWhr94wfzeNykO+Q0CjejOPb79oWd
         dlnI9+Bb01GieTGPmQ24wLrJ93aVqcaLgerpdQanSB6dZOIFGM/gfJUV23dTFgeeYvVE
         nb1g==
X-Gm-Message-State: AOJu0YwTs74/t8VQKulSDlR1a2h7T5WoemSQ8Jpwcgu8lSxMJOq7RNZd
	WUzyOzy7mXIJWwFStFFKZf0K9I5cViMZmnqOXr2ujaBi3W4o/zktaXoZYh00aD8=
X-Google-Smtp-Source: AGHT+IGjsZLHD8kGFRZjmgj+ilkWj1OOfr4o3eEgd2290Aodbjq6/EXsgNVRRYOC+8mBQzRIcutvbg==
X-Received: by 2002:a05:600c:1d04:b0:40e:c337:fbe6 with SMTP id l4-20020a05600c1d0400b0040ec337fbe6mr1131335wms.106.1706108634709;
        Wed, 24 Jan 2024 07:03:54 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id f7-20020adff8c7000000b0033921c383b2sm13626449wrq.67.2024.01.24.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:03:54 -0800 (PST)
Date: Wed, 24 Jan 2024 18:03:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: dwc: Cleanup in dw_pcie_ep_raise_msi_irq()
Message-ID: <64ef42f0-5618-40fd-b715-0d412121045c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>
X-Mailer: git-send-email haha only kidding

I recently changed the alignment code in dw_pcie_ep_raise_msix_irq().
The code in dw_pcie_ep_raise_msi_irq() is similar so update it to match
as well, just for consistency.  (No effect on runtime, just a cleanup).

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v4: style improvements
v3: use ALIGN_DOWN()
v2: new patch

 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 51679c6702cf..d2de41f02a77 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -482,9 +482,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
 		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	}
-	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
-	msg_addr = ((u64)msg_addr_upper) << 32 |
-			(msg_addr_lower & ~aligned_offset);
+	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
+
+	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
-- 
2.43.0


