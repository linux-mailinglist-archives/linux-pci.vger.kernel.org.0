Return-Path: <linux-pci+bounces-11048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519A5942EA9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BA41C21431
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51E91B0113;
	Wed, 31 Jul 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8zB4gRK"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4F1AE868
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429330; cv=none; b=JNOF5kWMaQHYPScDGtn5tjnihKy8yno8B5TFTjXfjFT/wHx0rY+XuS31z9kwUYQTdl3cG4NO3gfm+L4GB5sUfrO6/td/mbesLlDDCits5WXEbl+0lowu9fimDfuDLAg7wyZ1tP7HQ4rz1PTDNQ+zellPZD9QQoIt5gArxpegQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429330; c=relaxed/simple;
	bh=4GsXkzyF1zXnnVccFMmH9MHA6OoXOba9lWFScuAVpNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kby0sQMJRLvK/S4u3yJKjvr/AtkCPDOwX2ikFdaG0frK1oWDhj98hA6qTpSeqdx7F9wbR8cpJak5cBZSkO3uUyTwsFBNFsE4uJX0CxrUXBMU7l0J/gLkaHU5suYXxr6WGtx1dfZLpbNNam4REwp9ZQC335Bm5mcI2UT2Nm6UDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8zB4gRK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722429327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t0H3lAj8yc7c4WzJFe947fa0IqEnSWxptGsCiAxUCV8=;
	b=L8zB4gRKXjT7GMuQKNs3iEffC05kgBQfGTmP2Fo/o3XaPwxGfN4KBBsPHjQJ9l+vJ7qQF2
	lAo4RRVkByjL6wtw/p0tvC2a3bu4cQuLBa1kOadPXsjB2y+1hCplCWrCilqBtozu1Em9YL
	FV9qlvBdCjgD1sTgO4tvRVca28rbhdU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-enPS8CN9M6m96CTaDrxEMg-1; Wed, 31 Jul 2024 08:35:25 -0400
X-MC-Unique: enPS8CN9M6m96CTaDrxEMg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280ec27db9so4302695e9.1
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 05:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429324; x=1723034124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0H3lAj8yc7c4WzJFe947fa0IqEnSWxptGsCiAxUCV8=;
        b=luF592ZHev22XBMo969YFYSRkbBy7UGAUkUkYeIyXYNOpUDqjiOqlZCgGCvdRuH3Ct
         CNwGCz2YPOOdiK69GK/DPt/u639J9VnSgtTBRQIZoZ/0EEOpZQ5M3t1Khbg9orlBkd3x
         8ubzJkRFJpxYgq3AdYnMWF3g/vos75ttrXjOE++/X+kEpt3ctFmSX9HiKqqHapWqjlSq
         F/TL154/R9bXTTBvLtJ2rwVYwk9Xdez25/q97MYgLPTH47RMH5RsGsf6fSsK7cI4n7IS
         Zl0Q+yoBejuypMll9TDbXdHsWiHr8G5ergm/Wtid+Nx73lzlN4AE1R7NmQmi1OfrqEAl
         1bOg==
X-Forwarded-Encrypted: i=1; AJvYcCV3VRRo+q+r4xYUrsCPVKRlk5/9ZRp0qZqj1jSQcb/9v4S7g3K234dRmmcrH12FcyldootU37H28FA0PHsP5tSZ5NrxaiDrFLwf
X-Gm-Message-State: AOJu0YwLpevy7fyhYeyJqWfOh1005Sjirr5kkLYHYQkYA3Giaaw0QCba
	fY+XNjxTWmLe6iOXbYteR2PKHrL8RFqPJ45s5HHfPDWlXTFsJ+cbu6d0zOU6D9UMWA+6NVeO+r0
	mTlqpKH+0WkbnBUiy2hDiSwe04P9gHmc9Q+BLBPopvLr16L5PVauxGYADGw==
X-Received: by 2002:a05:600c:1c12:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-428056ff97fmr91893055e9.2.1722429323707;
        Wed, 31 Jul 2024 05:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfOvupbs8UN9EJ8k6ZFAunCkUlCgJVCS0HdMLmdtgm1szKAcCpadESixN42bMPQ5/HJrVDGQ==
X-Received: by 2002:a05:600c:1c12:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-428056ff97fmr91892875e9.2.1722429323157;
        Wed, 31 Jul 2024 05:35:23 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0829sm16925976f8f.17.2024.07.31.05.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:35:22 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 1/2] PCI: Make pcim_request_all_regions() a public function
Date: Wed, 31 Jul 2024 14:34:54 +0200
Message-ID: <20240731123454.22780-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI-Device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..0ec2b23e6cac 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -932,7 +932,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -950,6 +950,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..5b5856ba63e1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2289,6 +2289,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
-- 
2.45.2


