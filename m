Return-Path: <linux-pci+bounces-11529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A178D94CE0A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 12:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D410A1C21FE2
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5E193091;
	Fri,  9 Aug 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7RiH4yX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F2193082
	for <linux-pci@vger.kernel.org>; Fri,  9 Aug 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197281; cv=none; b=Lg9o+xI8e5qIK83K1AGJzzIthcI9Q4NJyDzIYeGXP438jPorVVyr8URyAJ7LLAkrmlJfGr4X5rvfJQKhSolFi8ykXPggy3kOfU4IueXwN3QxaxmMo/FE85EehVxzjezFTM/l2Pe3T9zZYVLOmvL0IRlZl853WpNSRGKR89lU+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197281; c=relaxed/simple;
	bh=xJ86mrvynAe99UrnLkIu1EHSKyB0aE6RkOOA/aLdCYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSSJ0BBaIhVil3mYFEiXK63X8VhzHk0KdGrLwae2meR2xSHH+7WFzuVFDRN23mluuyUEvw689BjtILHMNzENLv0qLdMgrVJ43ve0J1F36PuoFywY7ZM3CRNlfQ7MPJkr4PgiZS/1kLNLCyzhj6zSUHW/dB6I+QpWHl+STpqQD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7RiH4yX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723197278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zpcp771OskatVYXZisRNAltmkrv7cYnDZw6pclj2zoU=;
	b=Q7RiH4yX5wr+hGyL5yGP85D1BgH6iwhWrTZx3sslv8t7SDL/vDYG6GEtAo5+nwTTGKpcUE
	WTR+SHexJZN+8Sd9JPkpbUX9VD7/mw5sS5OHhqlKvYOvUr9r5am97vkhbjqeVmEn0y8Nb8
	oFg36b3vhTFSux2jgYe656MuQLTteu4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-bBtSrRDhNUqLc7QsKLo5Qw-1; Fri, 09 Aug 2024 05:54:36 -0400
X-MC-Unique: bBtSrRDhNUqLc7QsKLo5Qw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281d62be91so3714275e9.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Aug 2024 02:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723197275; x=1723802075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zpcp771OskatVYXZisRNAltmkrv7cYnDZw6pclj2zoU=;
        b=n5q0uMYTzaW0uv7R5+kO6GN9WbgHjfmAAxlYwXg24Mqn4FhgaIJIK4AbYltAK61bXC
         ZKfezkvCnbG2ZW+lcrKeXCCfWkxjLywEQnvY/wzEcFPoNMrpb3AaNplSGBjfQt6eV61p
         10WqIQdUggpBtXmyrCyQ22I+1NiOvouXy0+S4mS/V7QyIGyiuQbFYYpeUoI9/JW7tyJO
         Mq3Vn21o4bEretgTVihrl0St3F7bxjPe+BxGIhq5UtnVPYnBwCWHBiNMmvV8Cq3sbYM5
         ketNftz8yAus9AAHhZHHzW+YS5vo/3ZAy9+ZgSAPtW5mt6tyP/tzvrNXmi20G4l3odfb
         1sMA==
X-Forwarded-Encrypted: i=1; AJvYcCXQMPpPGIrog4Gbv1DlLkPgrtBTXUjh5xwhUZXz2uUqVR67M85jdKU2wiq0zZPOcimXlcTnsph65EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLJquUkwtcWOVejgQdY0Id/3hMeKA+ewYCkl4EK3LX9qSZtX3
	gTp079mMYhqcOdN3ssZicpwGga8El/eYVRKfLMpj3uUmcZEe1wTo/vGGghNgncS7tESwBvP0x2e
	bFHxligU2+sUheQwroDNpF3KUmHhELsErsOS9OVhvnDXDDv8zil6jmIDt6A==
X-Received: by 2002:a05:6000:154b:b0:367:95e3:e4c6 with SMTP id ffacd0b85a97d-36d5f3c5967mr579281f8f.1.1723197275282;
        Fri, 09 Aug 2024 02:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbGj5OVH3QAXRiEyZbBBhYCOVFAe/3JWA153ZxR0FYY6oLccO7DnrbGzPCX+nTOqZMIKtNGw==
X-Received: by 2002:a05:6000:154b:b0:367:95e3:e4c6 with SMTP id ffacd0b85a97d-36d5f3c5967mr579264f8f.1.1723197274756;
        Fri, 09 Aug 2024 02:54:34 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d272290e6sm4708543f8f.99.2024.08.09.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:54:34 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH RESEND] Documentation: devres: fix error about PCI devres
Date: Fri,  9 Aug 2024 11:52:48 +0200
Message-ID: <20240809095248.14220-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation states that pcim_enable_device() will make "all PCI
ops" managed. This is totally false, only a small subset of PCI
functions become managed that way. Implicating otherwise has caused at
least one bug so far, namely in commit 8558de401b5f ("drm/vboxvideo: use
managed pci functions").

Change the function summary so the functions dangerous behavior becomes
obvious.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
+CC PCI and Bjorn.

Bjorn, btw. neither PCI nor you are printed by getmaintainers for the
touched document. Possibly one might want to think about fixing that
somehow.
But I don't think it's a huge deal.
---
 Documentation/driver-api/driver-model/devres.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index ac9ee7441887..5f2ee8d717b1 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -391,7 +391,7 @@ PCI
   devm_pci_remap_cfgspace()	: ioremap PCI configuration space
   devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
 
-  pcim_enable_device()		: after success, all PCI ops become managed
+  pcim_enable_device()		: after success, some PCI ops become managed
   pcim_iomap()			: do iomap() on a single BAR
   pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
   pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
-- 
2.45.2


