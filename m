Return-Path: <linux-pci+bounces-8721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7217A906CD9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1F0B23EC4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F18148301;
	Thu, 13 Jun 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLbS/hEg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A540143C5F
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279454; cv=none; b=TszhUG0pjE6w4TOgQmyBOOP1MkDdlloSY9W6XQaY25kpeMIlNgUDvf7itqmO6+PHgiFQIvvNJLFldekNOlkePMMG25HE0YAow9Qy+1RTw+Ut/TqYL3WfUwrwKb/3Zyc0ANcH6WD7VEBM0r3oELoteLHk0vhq6dv/BcGeOlx3uaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279454; c=relaxed/simple;
	bh=CKmb7V8YQKy60Y3zYZ5nF36qcetaUUfvS68MhKTVZyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLBaiQTh7SZn9AYEMJ59w7fk63uFXtP85IwsalDr+CDVDmoBqAeHwsbDzVX3sFRC08gTNbU5GCDmPz3migYkTz//0mYL20FWNc7TYTYY6ZOlH2Yv96gp8DIUqwyk7iiUJx37q71edfTWSTiZ9xfIMs9ErsWChwIDRHaKFMmweKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLbS/hEg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CL+kLbe+Y26ksl0hcQ0e5foEJJ8TqrY6DSq54p9TklM=;
	b=RLbS/hEg17EQO8jILC2nuz/YivgLWKFduWRYcAYqKLuM3ZJrL4T2d2abz2lchYlpkEK5bc
	WA/6ns7mIUj8xsl9Cg2Juaii+2fsO8YtJ7JZ4BHhWKsjuxDNqNbrMEgoMCaEiF4Zu2iqt5
	E2cLQQb/nxjHcxMv2a+AABtFJsIJq6k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-iycpxrN9Pja6UFceaAfZmg-1; Thu, 13 Jun 2024 07:50:50 -0400
X-MC-Unique: iycpxrN9Pja6UFceaAfZmg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4210e98f8d7so1509715e9.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279449; x=1718884249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL+kLbe+Y26ksl0hcQ0e5foEJJ8TqrY6DSq54p9TklM=;
        b=NjUlDsOYanGmffEZhaC9NIVedxIfk38d9+Mb5XBtUCEDb5uU4CubAH4wvNRyGWdQSS
         754aVEOoOYVWbi7nnk2FMiz0b22JA0s+33esx92Rxogqk+0xdV+TP0rgQ+13P1RG3S0h
         MzpLnXHaMwOI0i84mP4XameDZLQereKQDPCHkXfulBRYCn/KE0qzaDjJGs9xU3QTVzEj
         k+fOFzZjZDKSfOouhAXGjqQbiETqPSoYljEb10Eb1XWUz9dYtiZO/U/4redoJ7g7cOFW
         MLpWQBml91DOhbXdw/nj+OLkPOFo7JZDYqROV1kNCL6QofKl/iofUqjmOMvJfmlD5P9h
         ikDg==
X-Forwarded-Encrypted: i=1; AJvYcCXZZS5woEMyxNfsjOiNOewxYegw8M8yXYJQk3p/isANSlDOruPPdlVfn8KZqgpj1zJQDUQ42Yb4Ncd/TQmnUOySaHr8egi7dt29
X-Gm-Message-State: AOJu0YwHasyN3Oqe6Obnju/aLPXREuayjwB4DQYIbQyuQRrLhu+sjAkL
	r7VgwekNQ1bCHr3foKetfT0XV/ArZeeeiUVrnH0awfyDQCqQd/1pLlN+QQt55VXr5M2tgSRetE3
	l834/I6M1Rz9RDctl6+AJHkwXbONrF2fSPz+faQFWsicVfOx2Hfr6IjBILQ==
X-Received: by 2002:a5d:5f93:0:b0:35f:306f:1587 with SMTP id ffacd0b85a97d-36079a50f05mr208537f8f.5.1718279448841;
        Thu, 13 Jun 2024 04:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEPTiocjmZpdSuZITHvA9vbQ/P9nyYz57aqk+QbvsZnFOIEMIsJGsexzqpTKeFCx6yJ+Ucbw==
X-Received: by 2002:a5d:5f93:0:b0:35f:306f:1587 with SMTP id ffacd0b85a97d-36079a50f05mr208519f8f.5.1718279448583;
        Thu, 13 Jun 2024 04:50:48 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:48 -0700 (PDT)
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
Subject: [PATCH v9 04/13] PCI: Deprecate two surplus devres functions
Date: Thu, 13 Jun 2024 13:50:17 +0200
Message-ID: <20240613115032.29098-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613115032.29098-1-pstanner@redhat.com>
References: <20240613115032.29098-1-pstanner@redhat.com>
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
index cf2c11b54ca6..5ecffc7424ed 100644
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


