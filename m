Return-Path: <linux-pci+bounces-946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457D8812832
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6BD2825F2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 06:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D69EA21;
	Thu, 14 Dec 2023 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvBunkzR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC650A6
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 22:33:41 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b701b75f36so304988939f.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 22:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702535621; x=1703140421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQa3Oh83Y7BJ5yvT1MB3NL690VGSVlOorSazsJGg8O8=;
        b=DvBunkzR3aTXEws5zejCNZYt1dYO8HtNv22PpeD6BZKmjD3eCmS2gsZcsK+FCMSpNb
         QS8k2g9Z/aROFkkN6BnY14YNekty0/5l1xGNxGO8EhvXOGrstspSFxWTH4A+zvTVeNQX
         ddp6QzKJ2HIh72VkQS49DM8JLBZGnlhsln2b/UPTx4iJI7cFrm3RaHr2zH1kfyuFaHLP
         CTzk3hfIXFofXherSmYH5jbKYjpSmUuChlAw5RCe3HjNi6pOWBfnnrTNKgtIZ2o/Qr8C
         E5Ox8aAYefsHXyyeGqzoEMbb4p0l2CPZOs9xkm1cuTOEvAsuRQarmwSElYU9rjTfgSb2
         z6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702535621; x=1703140421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQa3Oh83Y7BJ5yvT1MB3NL690VGSVlOorSazsJGg8O8=;
        b=b7yY385C1kxvXdO/QqZfG+/XL3OOWx1Tz4pSdbPKbazbWd+1EZDEa5e8jLqkb815s2
         hnzFempqR53Z7p2Fa8fHYJU0oAywBZu7f+JAMwpYH84z2+kgt1VfQZnMYpXk//c6hVeF
         18iiAQmN5GgXaO5uAzWt3lJCmvdo5aULIDPstFFQKWz1RCu3hT37gNWEzN19sT3MBe0p
         QOvkYQcdTlUdhZ0F3fzd3Pfg4N8PzCE/aQ0o30GaatTPPkPLy2+UE/xzkj7wsnVJ1+/Y
         T5JEJTuO3SRj09qZYdBi6vKliY+yZ6ZenuW7KHd9ujraMAPXXtypOccq4tZFLUGHtohm
         hzRA==
X-Gm-Message-State: AOJu0Yw/Lsul/eiyjX609vQkvVJPpbOHQoULhR+ytefX+YUDbmCjDc0M
	3H2ypMj7U9WpJzyZSbERKQVC
X-Google-Smtp-Source: AGHT+IEz9WJYleLURMpZ+fxmZXd0E4sPrwuGGZyApaPAAwDEgLTtswTy+mHFNCYGonBLoIypIEFaLQ==
X-Received: by 2002:a05:6e02:184b:b0:35d:6d53:5439 with SMTP id b11-20020a056e02184b00b0035d6d535439mr14590043ilv.11.1702535621114;
        Wed, 13 Dec 2023 22:33:41 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001cc2ebd2c2csm11639491pls.256.2023.12.13.22.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:33:40 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com
Cc: kishon@kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: epf-mhi: Fix the DMA data direction of dma_unmap_single()
Date: Thu, 14 Dec 2023 12:03:28 +0530
Message-Id: <20231214063328.40657-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the error path of pci_epf_mhi_edma_write() function, the DMA data
direction passed (DMA_FROM_DEVICE) doesn't match the actual direction used
for the data transfer. Fix it by passing the correct one (DMA_TO_DEVICE).

Fixes: 7b99aaaddabb ("PCI: epf-mhi: Add eDMA support")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Bjorn, Krzysztof, I'd like to apply this patch to MHI tree on top of eDMA
async patches due to dependency:
https://lore.kernel.org/linux-pci/20231127124529.78203-1-manivannan.sadhasivam@linaro.org/

 drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 472bc489b754..d3d6a1054036 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -424,7 +424,7 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	}
 
 err_unmap:
-	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_FROM_DEVICE);
+	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
 err_unlock:
 	mutex_unlock(&epf_mhi->lock);
 

base-commit: f5668f251e29292326e45a022f933c15740a8af2
-- 
2.25.1


