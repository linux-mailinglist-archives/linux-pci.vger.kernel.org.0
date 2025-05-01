Return-Path: <linux-pci+bounces-27069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8971BAA6107
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD73A4A3411
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB27020C49C;
	Thu,  1 May 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCJ/oktI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE01BF37;
	Thu,  1 May 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114994; cv=none; b=aR5q9VSD/wfBok++Qa4XIIWxJNUDdCB/p0jH11k6GDwAx5iW/T239hEghkvYTx+eU3Nwl36VnjO+6SrE6zkgXXIxry/V23XDDIGCc/lw7MRtR3UhLFrfe7E/WvdNNAgEKumGc9eaY9QyhvFhLt7b97etZatat7TueQYkY2tAfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114994; c=relaxed/simple;
	bh=MVsOI5XqGV6KrnpEGByFDvmB/EVjzHVKI1q52/IKofA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koLtKIIK4B/cCzAsACB5Ed9qAp4OEtTQtTAbOdB1aEFR8Bh3P2GH0QeNfl53UXVIf7TJznxXVZimghALYUuMbhaASG2BrDRKSV32ximshH7x6Oydz/habEOJ0V3aKa0RjdtqR7Dmg+3hFUDERQrHXLrO0hHA9b+weLrvLB6gaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCJ/oktI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so8350815e9.3;
        Thu, 01 May 2025 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746114991; x=1746719791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm4Nt13v74NWTqm06gLw4HBrGjUTYIB/z/gIzW15jYY=;
        b=ZCJ/oktIz/PFIpilZMzepqKubwcJZsDyRuKaa04eKZkFPe4avHUsJHFWtxGviAsbB7
         EgsrEpZ/59VsbLOzxkQfFKj2R3hWJxXXYfYCGuzZPDMZ+pkswr05cOcuBsNrVs9NxS4C
         1r7BJhpoyFgVKbSUPOlmExKJOkPR6foSgm3CLGmnXCGbuQS4v8jGSdnGQdcS9dSxs5WP
         u7DdB3TwiSAHWzhf+V7Gm2EpbGZ9h9nWYPaNnJPfKit+2B8sxr4D4gG47r2U7ERVry39
         ssViywPyU5peB1ox5qE+zDPtW9EbePVnku78BZQsncn/cJOpHnhMP8XzmqHN9T3YwT+6
         JcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746114991; x=1746719791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nm4Nt13v74NWTqm06gLw4HBrGjUTYIB/z/gIzW15jYY=;
        b=WFBAWfNLDiIFtn1FLXoH7Clg9VeWq7AIiMFlSJfqHQdRIC4wXZSDxV/d4xOb4ddYPQ
         k86UMdo0Aw73LW24fEjn3dJPFDx/vhM+54m4MYypEYMsk1Di1utbJjVL9aS/oTYL0aT3
         1wtIxm65IQb8QdI+PZtzG4fxVCc3Hp9vWZDN2tHB8f21jTlo0FA7f6XznCd2CVyfw5xy
         /n8kzl7vK6kIVa4CPn9t5zcUkyHUOkpfFvPPeTNdkD+NMJPacBBikEvCITo2ZMNgijwM
         7qL2JyzG91kRW/29PVyOXnmOM/kaEHlJ0hrMx8mDHZJdbZmdjJ3Vx2v1m59pHcK+AGaH
         E7jA==
X-Forwarded-Encrypted: i=1; AJvYcCU6dZyeWXYfHLCKZrb+4hbzb8wQPyzZfKa1vsRk9lNUgCu2c6Bi1Hg7ApZPykOK0mSbzqgB++rA94rJGKI=@vger.kernel.org, AJvYcCVu+deutVQ8EXt4XuJ7UWjV2BkoSqFLEwG7Ar0gEcYnNzW8vvL0PKKlDhm7m4+iYhtNRwxeTZIQImoc@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhZTwlb+aY0DvUkQVQNJGw3Q4sSKcYJ+mETpPgoRvBP385bta
	0kGQq3WVAphZg449jSYo0TJwiJXA72HbSdeUuAQkRkSOB1nDI02U
X-Gm-Gg: ASbGnctvVupIrlwAhn3GpVjLs3PE6sWmg2WLZ8c9obkTXAs6h1VIkXM/HRHP0F2twOq
	iSm9cLl/pOJUEznRNVG0my4aUj9NstlCqcy2+rztfeE1Z79ZKbrA9om74xaQ0cGih4d8lAIXhbm
	tlaMQO7dGRHy5ars3OisJyMTTlULRr/UBFa972S3A6T84JQjIrBHXE3tDCm8UMH37322P7R3EjC
	s1d+kFHkN2I0LLFyv4j9JW9+C+ubqy44JjcbtRkSw3uJ3X2samWBEut43HIZ5nFvk+9uDElHMMo
	k/r5nO55WDFJ2WV7xV4pWnmE/SnmLosvtZKedw==
X-Google-Smtp-Source: AGHT+IG7OsJ/A21HZKJb7jfB7o7Yk1A+q+JvY1AWJUrAgnJ8W/COw6WfERcuSrvLd6XO5qInOBishg==
X-Received: by 2002:a05:600c:8507:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-441b265b10bmr68379705e9.18.1746114990801;
        Thu, 01 May 2025 08:56:30 -0700 (PDT)
Received: from pc.. ([197.232.62.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89ee37dsm16226065e9.22.2025.05.01.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 08:56:30 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: manivannan.sadhasivam@linaro.org,
	kw@linux.com
Cc: kishon@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH 1/2] PCI: endpoint: Replace manual mutex handling with scoped_guard()
Date: Thu,  1 May 2025 18:56:11 +0300
Message-ID: <49b27386eb57432d204153794bfd20f78aa72253.1746114596.git.karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746114596.git.karanja99erick@gmail.com>
References: <cover.1746114596.git.karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactor replaces manual mutex lock/unlock with scoped_guard()
in places where early exits use goto. Using scoped_guard()
avoids error-prone unlock paths and simplifies control flow.

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 358 +++++++++----------
 1 file changed, 166 insertions(+), 192 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 6643a88c7a0c..57ef522c3d07 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -323,57 +323,52 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 	if (buf_info->size < SZ_4K)
 		return pci_epf_mhi_iatu_read(mhi_cntrl, buf_info);
 
-	mutex_lock(&epf_mhi->lock);
-
-	config.direction = DMA_DEV_TO_MEM;
-	config.src_addr = buf_info->host_addr;
+	scoped_guard(mutex, &epf_mhi->lock) {
+		config.direction = DMA_DEV_TO_MEM;
+		config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
+		ret = dmaengine_slave_config(chan, &config);
+		if (ret) {
+			dev_err(dev, "Failed to configure DMA channel\n");
+			return ret;
+		}
 
-	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
-				  DMA_FROM_DEVICE);
-	ret = dma_mapping_error(dma_dev, dst_addr);
-	if (ret) {
-		dev_err(dev, "Failed to map remote memory\n");
-		goto err_unlock;
-	}
+		dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
+					  DMA_FROM_DEVICE);
+		ret = dma_mapping_error(dma_dev, dst_addr);
+		if (ret) {
+			dev_err(dev, "Failed to map remote memory\n");
+			return ret;
+		}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
-	if (!desc) {
-		dev_err(dev, "Failed to prepare DMA\n");
-		ret = -EIO;
-		goto err_unmap;
-	}
+		desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
+						   DMA_DEV_TO_MEM,
+						   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+		if (!desc) {
+			dev_err(dev, "Failed to prepare DMA\n");
+			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
+			return -EIO;
+		}
 
-	desc->callback = pci_epf_mhi_dma_callback;
-	desc->callback_param = &complete;
+		desc->callback = pci_epf_mhi_dma_callback;
+		desc->callback_param = &complete;
 
-	cookie = dmaengine_submit(desc);
-	ret = dma_submit_error(cookie);
-	if (ret) {
-		dev_err(dev, "Failed to do DMA submit\n");
-		goto err_unmap;
-	}
+		cookie = dmaengine_submit(desc);
+		ret = dma_submit_error(cookie);
+		if (ret) {
+			dev_err(dev, "Failed to do DMA submit\n");
+			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
+			return ret;
+		}
 
-	dma_async_issue_pending(chan);
-	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
-	if (!ret) {
-		dev_err(dev, "DMA transfer timeout\n");
-		dmaengine_terminate_sync(chan);
-		ret = -ETIMEDOUT;
+		dma_async_issue_pending(chan);
+		ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
+		if (!ret) {
+			dev_err(dev, "DMA transfer timeout\n");
+			dmaengine_terminate_sync(chan);
+			ret = -ETIMEDOUT;
+		}
 	}
-
-err_unmap:
-	dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
-err_unlock:
-	mutex_unlock(&epf_mhi->lock);
-
 	return ret;
 }
 
@@ -394,57 +389,52 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	if (buf_info->size < SZ_4K)
 		return pci_epf_mhi_iatu_write(mhi_cntrl, buf_info);
 
-	mutex_lock(&epf_mhi->lock);
-
-	config.direction = DMA_MEM_TO_DEV;
-	config.dst_addr = buf_info->host_addr;
+	scoped_guard(mutex, &epf_mhi->lock) {
+		config.direction = DMA_MEM_TO_DEV;
+		config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
+		ret = dmaengine_slave_config(chan, &config);
+		if (ret) {
+			dev_err(dev, "Failed to configure DMA channel\n");
+			return ret;
+		}
 
-	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
-				  DMA_TO_DEVICE);
-	ret = dma_mapping_error(dma_dev, src_addr);
-	if (ret) {
-		dev_err(dev, "Failed to map remote memory\n");
-		goto err_unlock;
-	}
+		src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
+					  DMA_TO_DEVICE);
+		ret = dma_mapping_error(dma_dev, src_addr);
+		if (ret) {
+			dev_err(dev, "Failed to map remote memory\n");
+			return ret;
+		}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
-	if (!desc) {
-		dev_err(dev, "Failed to prepare DMA\n");
-		ret = -EIO;
-		goto err_unmap;
-	}
+		desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
+						   DMA_MEM_TO_DEV,
+						   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+		if (!desc) {
+			dev_err(dev, "Failed to prepare DMA\n");
+			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
+			return -EIO;
+		}
 
-	desc->callback = pci_epf_mhi_dma_callback;
-	desc->callback_param = &complete;
+		desc->callback = pci_epf_mhi_dma_callback;
+		desc->callback_param = &complete;
 
-	cookie = dmaengine_submit(desc);
-	ret = dma_submit_error(cookie);
-	if (ret) {
-		dev_err(dev, "Failed to do DMA submit\n");
-		goto err_unmap;
-	}
+		cookie = dmaengine_submit(desc);
+		ret = dma_submit_error(cookie);
+		if (ret) {
+			dev_err(dev, "Failed to do DMA submit\n");
+			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
+			return ret;
+		}
 
-	dma_async_issue_pending(chan);
-	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
-	if (!ret) {
-		dev_err(dev, "DMA transfer timeout\n");
-		dmaengine_terminate_sync(chan);
-		ret = -ETIMEDOUT;
+		dma_async_issue_pending(chan);
+		ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
+		if (!ret) {
+			dev_err(dev, "DMA transfer timeout\n");
+			dmaengine_terminate_sync(chan);
+			ret = -ETIMEDOUT;
+		}
 	}
-
-err_unmap:
-	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
-err_unlock:
-	mutex_unlock(&epf_mhi->lock);
-
 	return ret;
 }
 
@@ -497,67 +487,59 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 	dma_addr_t dst_addr;
 	int ret;
 
-	mutex_lock(&epf_mhi->lock);
+	scoped_guard(mutex, &epf_mhi->lock) {
+		config.direction = DMA_DEV_TO_MEM;
+		config.src_addr = buf_info->host_addr;
 
-	config.direction = DMA_DEV_TO_MEM;
-	config.src_addr = buf_info->host_addr;
+		ret = dmaengine_slave_config(chan, &config);
+		if (ret) {
+			dev_err(dev, "Failed to configure DMA channel\n");
+			return ret;
+		}
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
+		dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
+					  DMA_FROM_DEVICE);
+		ret = dma_mapping_error(dma_dev, dst_addr);
+		if (ret) {
+			dev_err(dev, "Failed to map remote memory\n");
+			return ret;
+		}
 
-	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
-				  DMA_FROM_DEVICE);
-	ret = dma_mapping_error(dma_dev, dst_addr);
-	if (ret) {
-		dev_err(dev, "Failed to map remote memory\n");
-		goto err_unlock;
-	}
+		desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
+						   DMA_DEV_TO_MEM,
+						   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+		if (!desc) {
+			dev_err(dev, "Failed to prepare DMA\n");
+			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
+			return -EIO;
+		}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
-	if (!desc) {
-		dev_err(dev, "Failed to prepare DMA\n");
-		ret = -EIO;
-		goto err_unmap;
-	}
+		transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
+		if (!transfer) {
+			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
+			return -ENOMEM;
+		}
 
-	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
-	if (!transfer) {
-		ret = -ENOMEM;
-		goto err_unmap;
-	}
+		transfer->epf_mhi = epf_mhi;
+		transfer->paddr = dst_addr;
+		transfer->size = buf_info->size;
+		transfer->dir = DMA_FROM_DEVICE;
+		memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
 
-	transfer->epf_mhi = epf_mhi;
-	transfer->paddr = dst_addr;
-	transfer->size = buf_info->size;
-	transfer->dir = DMA_FROM_DEVICE;
-	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
+		desc->callback = pci_epf_mhi_dma_async_callback;
+		desc->callback_param = transfer;
 
-	desc->callback = pci_epf_mhi_dma_async_callback;
-	desc->callback_param = transfer;
+		cookie = dmaengine_submit(desc);
+		ret = dma_submit_error(cookie);
+		if (ret) {
+			dev_err(dev, "Failed to do DMA submit\n");
+			kfree(transfer);
+			dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
+			return ret;
+		}
 
-	cookie = dmaengine_submit(desc);
-	ret = dma_submit_error(cookie);
-	if (ret) {
-		dev_err(dev, "Failed to do DMA submit\n");
-		goto err_free_transfer;
+		dma_async_issue_pending(chan);
 	}
-
-	dma_async_issue_pending(chan);
-
-	goto err_unlock;
-
-err_free_transfer:
-	kfree(transfer);
-err_unmap:
-	dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
-err_unlock:
-	mutex_unlock(&epf_mhi->lock);
-
 	return ret;
 }
 
@@ -576,67 +558,59 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	dma_addr_t src_addr;
 	int ret;
 
-	mutex_lock(&epf_mhi->lock);
+	scoped_guard(mutex, &epf_mhi->lock) {
+		config.direction = DMA_MEM_TO_DEV;
+		config.dst_addr = buf_info->host_addr;
 
-	config.direction = DMA_MEM_TO_DEV;
-	config.dst_addr = buf_info->host_addr;
+		ret = dmaengine_slave_config(chan, &config);
+		if (ret) {
+			dev_err(dev, "Failed to configure DMA channel\n");
+			return ret;
+		}
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
+		src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
+					  DMA_TO_DEVICE);
+		ret = dma_mapping_error(dma_dev, src_addr);
+		if (ret) {
+			dev_err(dev, "Failed to map remote memory\n");
+			return ret;
+		}
 
-	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
-				  DMA_TO_DEVICE);
-	ret = dma_mapping_error(dma_dev, src_addr);
-	if (ret) {
-		dev_err(dev, "Failed to map remote memory\n");
-		goto err_unlock;
-	}
+		desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
+						   DMA_MEM_TO_DEV,
+						   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+		if (!desc) {
+			dev_err(dev, "Failed to prepare DMA\n");
+			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
+			return -EIO;
+		}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
-	if (!desc) {
-		dev_err(dev, "Failed to prepare DMA\n");
-		ret = -EIO;
-		goto err_unmap;
-	}
+		transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
+		if (!transfer) {
+			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
+			return -ENOMEM;
+		}
 
-	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
-	if (!transfer) {
-		ret = -ENOMEM;
-		goto err_unmap;
-	}
+		transfer->epf_mhi = epf_mhi;
+		transfer->paddr = src_addr;
+		transfer->size = buf_info->size;
+		transfer->dir = DMA_TO_DEVICE;
+		memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
 
-	transfer->epf_mhi = epf_mhi;
-	transfer->paddr = src_addr;
-	transfer->size = buf_info->size;
-	transfer->dir = DMA_TO_DEVICE;
-	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
+		desc->callback = pci_epf_mhi_dma_async_callback;
+		desc->callback_param = transfer;
 
-	desc->callback = pci_epf_mhi_dma_async_callback;
-	desc->callback_param = transfer;
+		cookie = dmaengine_submit(desc);
+		ret = dma_submit_error(cookie);
+		if (ret) {
+			dev_err(dev, "Failed to do DMA submit\n");
+			kfree(transfer);
+			dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
+			return ret;
+		}
 
-	cookie = dmaengine_submit(desc);
-	ret = dma_submit_error(cookie);
-	if (ret) {
-		dev_err(dev, "Failed to do DMA submit\n");
-		goto err_free_transfer;
+		dma_async_issue_pending(chan);
 	}
-
-	dma_async_issue_pending(chan);
-
-	goto err_unlock;
-
-err_free_transfer:
-	kfree(transfer);
-err_unmap:
-	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
-err_unlock:
-	mutex_unlock(&epf_mhi->lock);
-
 	return ret;
 }
 
-- 
2.43.0


