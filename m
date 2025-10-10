Return-Path: <linux-pci+bounces-37800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D0BCC5C0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8252B3542FF
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C832367D7;
	Fri, 10 Oct 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hwj+0uhn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C426560D
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088778; cv=none; b=SJs52fCz80iNGexogYW/QCRhgjCOUKAXsudkQm9zl3v1MnFM8XtaeMHzB9009aOW2UsBG/IbJU7ryolRIpMEQXuJFSUrZPGm48nPmy6hNdTkx7ccXaCHCgo/za3UL8Aqy1luBUhZe+XugcXKEazW1QaXISWR98VKVqoBOEQSmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088778; c=relaxed/simple;
	bh=6mprBf9rHm8t7EC0WKhRFNgUz+XHrcRxygL5v/apfQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GZOM/m59Bp0qdcFByP/RfH8YVspD2e4mwdc6xH4Bo6zNYArOuOA1UzYuMymB2RFyyFzmfCGmoSQUFiDrcKwQMSqqo8vp5qD7nh+KGGGjSNdelGGEaHki/j8Bou7pbzVUoHCFdDN/67VTJGc1bJskWvBSi4ALh8lty+4404LjhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hwj+0uhn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7811fa91774so1669098b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760088776; x=1760693576; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OhN24A5UCW1ooWw6ilGbTrMsyp8dpaTZlf+HDDnFDSk=;
        b=hwj+0uhnqFZen5RcA6FAvmGrtlpUZN53g3sD6rDpLuEt79/zQvLqZF8dscFxzSx42H
         Iq/IJ/wr6YuhlAXUAIE2ozl1a2ycoULBpGbxMnOmAJnw0Ye1cTiqq9Q2SgkTMkBCUf7x
         0Da7XhiTe8SrP8+4v0lNfei3wN8lolP+t5/13YuVsJGMw4B9K/OQPKElnKjB8zdgpzsU
         aoBYRyfGFXt4j7cQnMVphINOtEZtkfIjbb5KY8AqYoPdNRRnlyD1h8ldeVzvWNiHpRrA
         lBDQfRGQuCQEPBUvxGtiEdLPSTMbTRbyryZ7C+GY81PfF/GBsgOv8HxhapcF7nrDrhRP
         H9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088776; x=1760693576;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhN24A5UCW1ooWw6ilGbTrMsyp8dpaTZlf+HDDnFDSk=;
        b=S7pAiY56pJrDA/u74XAypz2+U0/AseYH8XXfbvABuA0DwR4Xf9UO0gY0uQHotl5jPq
         tQAAp9bYgL+6U9yKRU+LRaMUUDBiUJuLy3hNTYTWfyg9xMuti9E6irF444dVk3gpnRum
         a5LuVSIU2jmIfB8UYTks5e6iEsIxZKQ8tAVJXT1iKGIoTeDor8wMRnQhPD0nVvcR7fob
         +vbo9YoJyX2k8+pmTXWVeBCDJKi5+ZDFSBsJ5RmQBxaeL7PKfivHHB4J935j/TFIIG0n
         alx4LOjSSa8ERJN4r5dyNnGj0m6M5YywCtjCej6gieMBBylRfpzHE2cPm3XKBYjdYAhx
         ukeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMwSioW0UdMAEyWjaM8hk1Ig5g/dBkugjFRxlVYQX4Env0Jirw5B1tDa+1yNcyq0PPWj7t7BAWETU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1utGqFyRD63uSZqL407gOyJU17GKcZiFONyz7Uy+jq/BXfaFS
	EPE1wPTxKx6ZhjqmCGveP2w1KgKvEimB+aiBCgkbmi2vrNbnJzkvMQ5rqIW4oganxMg=
X-Gm-Gg: ASbGncsBICL//6TkobUXcxyBN9ePiMoAQ97cXKFo1j26k6ntbNT4LCkEPJnRYWUBitl
	gQXCyKU5nmt26RrO2fAPANoXnOG41zyum74P6fWgr2rX2vf9DVhx5zrBwYI4y33toOh0QYxux2G
	DXA1AiNErn1NHVYIbGiBhHzQ9u5nGrQ4ilTkb3iOP/WMtl2pdKmTZWjfv3sp72So4INP8YCiRcT
	Mpw9FDqU/NPx95uJ3lMGXW1aYwsGwcdsY6KpDIXg+rXUC/gxxTwwgrfcTFJTTBLpE/YNjVmeSTY
	6mmrPD3044GKF2IZPAu08Tfo2ATKtbtfsH57/VKrzg0WtRdu5tzQoXtRYHzjjHD7RgXHlzJDj5D
	HHatZfT42+MUITjiiwONGHAUzCSAyzxr4yVNYEYHS5Sj3aFS9prZyje+Ev9cIdRmIvy2wT69/Bg
	ujTK73oopd1Q0TFLRW0uaofxN0fRbb
X-Google-Smtp-Source: AGHT+IGToyfnFp6Nx9gf8NmRJnd4O/Y3pam9cbiDX+UZWPa17SsaNbTO7MXGaHWms2MZ1He/ASjT8A==
X-Received: by 2002:a05:6a20:3d8c:b0:2b4:41d9:b068 with SMTP id adf61e73a8af0-32da8462f7emr12905134637.37.1760088775650;
        Fri, 10 Oct 2025 02:32:55 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2d51sm2308775b3a.65.2025.10.10.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:32:55 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: bhelgaas@google.com
Cc: guojinhui.liam@bytedance.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: Print the error code when PCI sysfs or procfs creation fails
Date: Fri, 10 Oct 2025 17:30:23 +0800
Message-Id: <20251010093023.2569-3-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
References: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pci_bus_add_device() ignores the return values of
pci_create_sysfs_dev_files() and pci_proc_attach_device(), so any
sysfs/procfs creation errors are silently lost. To make PCI
bring-up failures easier to diagnose, log the errno returned by
pci_create_sysfs_dev_files() and pci_proc_attach_device() in
pci_bus_add_device().

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/bus.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6ff588..395a1c7bb4c7 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -344,6 +344,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 {
 	struct device_node *dn = dev->dev.of_node;
 	struct platform_device *pdev;
+	int ret;
 
 	/*
 	 * Can not put in pci_device_add yet because resources
@@ -353,8 +354,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_fixup_device(pci_fixup_final, dev);
 	if (pci_is_bridge(dev))
 		of_pci_make_dev_node(dev);
-	pci_create_sysfs_dev_files(dev);
-	pci_proc_attach_device(dev);
+	ret = pci_create_sysfs_dev_files(dev);
+	if (ret)
+		pci_err(dev, "created sysfs files error %d\n", ret);
+	ret = pci_proc_attach_device(dev);
+	if (ret)
+		pci_err(dev, "created procfs files error %d\n", ret);
 	pci_bridge_d3_update(dev);
 
 	/*
-- 
2.20.1


