Return-Path: <linux-pci+bounces-8520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5C0901E54
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5D41F21C4A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91E7E57C;
	Mon, 10 Jun 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek9HQDQe"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65A7BB13
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011936; cv=none; b=DfJqPLAfmTFn6qWmYa/LUSN/MrAsYhdyjwwvQeiBBzny5S6MOQ6WIqluSL5C0V2HVGWXDGv823HGWTShgHVC5Ci7FK2NQJwjb09TWgdrO9UNxyQSMLQQmbSe9TBSeWRbt84uBKmy05Ry2KE8TxIpvSuD/bIOy/f6t+L9SrqxJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011936; c=relaxed/simple;
	bh=R+ahaaj9Z92r/qtOUZY3Zpj6x9Bj6I0WxW/a/NzXs2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhW2xg1WF3ID3nOyswC6KgfBcGaxZXuvXb8az/fHl4e1bGRoX6SqdQX/7EanDV/lTftYlWIG+FgspsOv3BU/SaCIsL4TQpoOrccf89FHGokR3Nle/WweiY5FmmGPDYA8n5mA/f1czV8VX/Kk5paMWnrvRfj9Wyep/n6vPA3QSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ek9HQDQe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiUwSs1HtnX+QGE2Zl9KICBy9ex3+lEWzbjMxYLRGDA=;
	b=Ek9HQDQeYROyD8mz60JaYxA8B7CxyJ0Eyroin69EROLDmOVYEUJB960tHwXGe4oWiqpSpA
	DG02IXmddzPteo78PZKX/1JJUEVJSBqsyGw0SMckD1AtpKmt7ezBvRQcSaJEeEBt0W+/Vx
	8T/q6N0Dc9Exni04Pe7/AT6EATy9QQw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-zuhgz6--MZi0US29fHLeVA-1; Mon, 10 Jun 2024 05:32:05 -0400
X-MC-Unique: zuhgz6--MZi0US29fHLeVA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421920de031so1511965e9.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011924; x=1718616724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiUwSs1HtnX+QGE2Zl9KICBy9ex3+lEWzbjMxYLRGDA=;
        b=vqtFXNKctdso1/XO/vr3ubQwJzLBRrw3WqIW3Wn8+NgYHeg4B/IfKpOR0NrkmPhWEH
         pW4m5ysuA4xEGLY5Ey94ifeHp1GEbgFAZ4jkO1R3RjJ+07a7bRnEDbutU3ITf5+BnFEg
         CNlpkNcZA9JEL5zGIXDD1+TsHSsM033ThIvHNo8S0QFzJJi6Yrxg+T1k7VEXw4vC3CPb
         XVR5GE6a9OICBWZcHJ+O6Masfi0PBBbMQogWR8s077On7huEdvqY/hwYuAtobl5cAsf8
         HCyMXq6Q3NEjnWJxJvZKKZ5bdz2httlhDUQBzrzPS7vU0qkzoWQRD44ESNjUSex1gRtb
         NDsw==
X-Forwarded-Encrypted: i=1; AJvYcCWwENLgsz6O5qUAl22FQA8IAX9XlRvEBZuDmOLerp66tcP4JmO1e54Dpy9h8w6pMeeXG9XvZoLrzW42WC3u9bvhnr3Zidl0ZSNs
X-Gm-Message-State: AOJu0Yw7B/OXW8ArUiwrKpqOAoKMqAmIwY+vDldHotOyx2n/XBgxfUuk
	fLnJXowphr6QN/0VP7vJhi0KeHKZb0jmhFE+1YCnx83QC7mJVHKnvLpf7sunbLBhZbbSDtebVMt
	/vI3F2lGxiVBYdyQI6QkIB+TahAWXzfEJ/vqc5jpcOrRFjoQk5klTQLOnLA==
X-Received: by 2002:a5d:6c65:0:b0:354:fc97:e6e3 with SMTP id ffacd0b85a97d-35efee1d38fmr6464063f8f.5.1718011923970;
        Mon, 10 Jun 2024 02:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHVbLME23XHqqxGSb/L2UcmsZWCbVxunmo7ktVNIV+TisnX0BItNxZ6wxaQvx45l+MZoucwQ==
X-Received: by 2002:a5d:6c65:0:b0:354:fc97:e6e3 with SMTP id ffacd0b85a97d-35efee1d38fmr6464047f8f.5.1718011923677;
        Mon, 10 Jun 2024 02:32:03 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:03 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v8 04/13] PCI: Deprecate two surplus devres functions
Date: Mon, 10 Jun 2024 11:31:26 +0200
Message-ID: <20240610093149.20640-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610093149.20640-1-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() should not be used anymore because it contributed to the
PCI devres API being designed contrary to devres's design goals.

pcim_iomap_regions_request_all() is a surplus, complicated function that
can easily be replaced by using a pcim_* request function in combination
with a pcim_* mapping function.

Mark pcim_iomap_table() and pcim_iomap_regions_request_all() as deprecated
in the function documentation.

Link: https://lore.kernel.org/r/20240605081605.18769-6-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/devres.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 82f71f5e164a..54b10f5433ab 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -507,7 +507,7 @@ static void pcim_iomap_release(struct device *gendev, void *res)
 }
 
 /**
- * pcim_iomap_table - access iomap allocation table
+ * pcim_iomap_table - access iomap allocation table (DEPRECATED)
  * @pdev: PCI device to access iomap table for
  *
  * Returns:
@@ -521,6 +521,11 @@ static void pcim_iomap_release(struct device *gendev, void *res)
  * This function might sleep when the table is first allocated but can
  * be safely called without context and guaranteed to succeed once
  * allocated.
+ *
+ * This function is DEPRECATED. Do not use it in new code. Instead, obtain a
+ * mapping's address directly from one of the pcim_* mapping functions. For
+ * example:
+ * void __iomem *mappy = pcim_iomap(pdev, bar, length);
  */
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 {
@@ -894,6 +899,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
+ *			(DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to iomap
  * @name: Name associated with the requests
@@ -904,6 +910,10 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
  *
  * To release these resources manually, call pcim_release_region() for the
  * regions and pcim_iounmap() for the mappings.
+ *
+ * This function is DEPRECATED. Don't use it in new code. Instead, use one
+ * of the pcim_* region request functions in combination with a pcim_*
+ * mapping function.
  */
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name)
-- 
2.45.0


