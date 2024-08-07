Return-Path: <linux-pci+bounces-11418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D777D94A2F6
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 10:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FD21C22300
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCE31D1727;
	Wed,  7 Aug 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzRJZufl"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A61CCB22
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019433; cv=none; b=P0VBg9RHfHLlS4xWNku4PUNjOs+Qt3wMd5c70MN7GolIGgvpiq6K8gh4xintxY0nXj38LGGzIFG1Zm7XjR37Kun9OWUWEVlCw+9CGugDxI0IVlFJ5Gzdpd0QD90GbJTn9uO6L5S2AzbX14bJPsyXWEyqjYum8BQxqb+MEiD0wHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019433; c=relaxed/simple;
	bh=8/IVVXD4FeMZWKFKtoNpDRSh5vex9vQC00VHkqB1wBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doDdsAS+FPYIu9T9b3SBBwAKTV8Zpmu98nxtFO1xv8zvobrJU/HvZ9jTk2wJBkgx4d0lHfPax9CbhLOpfJcq4bdFsgxRiiiuJJJnGAVXdTMWuwTizzwboJlJq3TZVn/OWb4jf9aXqaScuWRDoq4hg22L+cssG0pVmyqdfLBWPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzRJZufl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723019430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OfBj6lBAY4VJsMws6sBIFpxuMUursLja0EGRzFyXM78=;
	b=YzRJZuflcrpWujK5+/dYnmvUTyl6HUDYozzlD7Ux1hUBVngAjHSOQ95CL++WS02fWW4LWU
	ZyQgcYB1b0+H4x3XO2iwHLCQTwpSDP6Uka8oC4VN7S/Iq21mS6gIuujztPYW/cRi77bUDO
	rn3tbRcdF9D0+AGHesn8Q82CC+82b4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-Hn5SqRRYO02BHMmZ4tWmbg-1; Wed, 07 Aug 2024 04:30:29 -0400
X-MC-Unique: Hn5SqRRYO02BHMmZ4tWmbg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281e72db54so1306795e9.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 01:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723019426; x=1723624226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfBj6lBAY4VJsMws6sBIFpxuMUursLja0EGRzFyXM78=;
        b=TM/kMzR4LshGFHnRY5K9gPuZpYpJAV/SpyJWv88a/kms++OmqwlQ724mpv2cd9Z8Xz
         vsfEhhLBv937RGY9aLgutgotv1bcKhgO0eYce8IY5eEDo4j0lbgooovbTlx+1rbv+mFf
         31qCV6KrxMF9bbBlu2rvPjoTMZ8E78z5L3DjmRZd2MoU0eI2OahMqJYluDNCHTkWx4ss
         esykWZjkKb91BS2wzLfccgB+5AZb0C+P13X9wRP8Hgs2gInOPFbYOlVHFFvQkjk25RYQ
         xcyxTQBmV0eanM150HI0KSKtlKhm461Viptf80whyK7Nz/d2cwb2yvTtJcQ4H0bLAmHg
         C3lw==
X-Forwarded-Encrypted: i=1; AJvYcCX3cHHmDobWoxxEKLyvaFlPka443xMrWtta92URIjS4KSF9J3B5TUQyBLoKytHIWRZZ/09dc1xXUTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBEH/farwNKQGguACvP2kXWqn0kzcj3luoWAY4MlB/+lB+GvAB
	jf57YjObECQk6+p3UW2S0Ky+2BHoNbsyvvejy667VXoJvbW+ATMbdQKVYK4f/lPUibWcpWCo8Gs
	ftwRudqKTXRygGU9T58O8kiNSBAlWNNoLcQ1HandQPOP7eoKSiUCpOBZ/5g==
X-Received: by 2002:a05:600c:4591:b0:426:6f48:415e with SMTP id 5b1f17b1804b1-428e6aea795mr73820965e9.1.1723019425855;
        Wed, 07 Aug 2024 01:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdhIO0KlL48PS+jaZDCPIETER1vQyM9Ppq36CYnKYH6adnAP4mB8NMbC+bOkQ6YfKhAfEWRA==
X-Received: by 2002:a05:600c:4591:b0:426:6f48:415e with SMTP id 5b1f17b1804b1-428e6aea795mr73820815e9.1.1723019425354;
        Wed, 07 Aug 2024 01:30:25 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580cb80sm18544835e9.45.2024.08.07.01.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:30:25 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Dave Airlie <airlied@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 1/2] PCI: Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()
Date: Wed,  7 Aug 2024 10:30:18 +0200
Message-ID: <20240807083018.8734-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() is a complicated function that uses a bit mask to
determine the BARs the user wishes to request and ioremap. Almost all
users only ever set a single bit in that mask, making that mechanism
questionable.

pcim_iomap_region() is now available as a more simple replacement.

Make pcim_iomap_region() a public function.

Mark pcim_iomap_regions() as deprecated.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 8 ++++++--
 include/linux/pci.h  | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..89ec26ea1501 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -728,7 +728,7 @@ EXPORT_SYMBOL(pcim_iounmap);
  * Mapping and region will get automatically released on driver detach. If
  * desired, release manually only with pcim_iounmap_region().
  */
-static void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
+void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name)
 {
 	int ret;
@@ -761,6 +761,7 @@ static void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 
 	return IOMEM_ERR_PTR(ret);
 }
+EXPORT_SYMBOL(pcim_iomap_region);
 
 /**
  * pcim_iounmap_region - Unmap and release a PCI BAR
@@ -783,7 +784,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 }
 
 /**
- * pcim_iomap_regions - Request and iomap PCI BARs
+ * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to request and iomap
  * @name: Name associated with the requests
@@ -791,6 +792,9 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
  * Returns: 0 on success, negative error code on failure.
  *
  * Request and iomap regions specified by @mask.
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pcim_iomap_region() instead.
  */
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..fc30176d28ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2292,6 +2292,8 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
+void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
+				       const char *name);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.45.2


