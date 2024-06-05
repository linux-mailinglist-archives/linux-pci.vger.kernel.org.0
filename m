Return-Path: <linux-pci+bounces-8305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ECC8FC5FD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B7DB284A8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02A19006B;
	Wed,  5 Jun 2024 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbzBrObm"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6963DAC0C
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575407; cv=none; b=ssGLndNxcZ15kYMy8GVos9+Isx8c73T33J1pehi2KT5SIMR93mW5XNYNEObDdiP//SQL0ojbeup7wv3fCsn/LmwkXHzSc0ikh8gQEo9FXmZj0Jj6K+tLAm0G0k0mAf1+znROsh5VScMzgPDbJLMdaKcwDkVAFegjGU9kLlvvBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575407; c=relaxed/simple;
	bh=bCBZE66HS4MGevuCEuGbllziHVNkZUwOrdLYjEkBs5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvItIii3Zmn8Dy689H7MsI6mUbmQkD2nUxl+60bwA78feyPyUsAjiQpoiOpFMsYiWc68ZeKIITJb1s5SzuA0GQuv0AfhKNSDuqkB/Tsj59nCiTbY+bKRVPrnhG+/d7313VzgdPYDgT9QrRj+tKQ8W7bqJVJs1H4fIqD3kTu+1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbzBrObm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQF/RRtq2M1mXHCVQZRIWcpncx1S//L9Tm5LTcwCt7g=;
	b=ZbzBrObm+j+iMlIWF5kabtlOGAiv40BI4MLT7jR4JLkLCnnvb6L7cgFAMZsEzp8xNOy+TX
	yLNwiTEQ2AmkORw07YNT7scevwPfmK8xQVAHe2aMJz2vkPPJIsP49UguIBrhRqisniURou
	B+ZCwWv0d215AV6aO37/6w6BzUyGQD0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-v-3t3J8qNo-lSIwyRGbm9Q-1; Wed, 05 Jun 2024 04:16:41 -0400
X-MC-Unique: v-3t3J8qNo-lSIwyRGbm9Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a68bed163b0so13228366b.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 01:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575400; x=1718180200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQF/RRtq2M1mXHCVQZRIWcpncx1S//L9Tm5LTcwCt7g=;
        b=QKxQfVsq7ZQw/pZVm2TKg6NY4vjWPsF17YziEEaxgzUDKhvJ2WnfzKTI5c5BklMd/l
         GiXMYksX4H/ZWhStMyWi67o7g1tLEqIFioKcuYi0tJKICSYpemqeZ97Stnff0OS+LjLf
         me3ZR5CT/2TXI1Clv5TsWeDo1JwaPa+UP9ZnMLDtwQ/B0qOW+MxthWLHudltTbckp7lj
         wOP9gzWEIBDgJo4xISkiOT4Yp+kzVXWkVIuZT28uKhjcJ6O979pSJ3Qmfi7ZrTcLMhDf
         HwlkYJrCTCBPXOu3MyerhYdrgliE0jGVrZR7FrXi8IsGKOSStPATbKUkKhzp8FbP2550
         5Y/A==
X-Forwarded-Encrypted: i=1; AJvYcCWCRtstvtB+wQSjAWImX9NgSBugI47EOd1MNxxLBasR75ND14Uz96/8st4IuhYojbz/1lzJ9wbhPzdsueycYNqwIxRoEXrk28sI
X-Gm-Message-State: AOJu0YxRlG9LosVmNiV/rTA3AZxBXNqOGMiziI59mpBn7Ks2PQ7jZ0ds
	yay8UJ//eZyW3YVJo/+C8g/hPefVoM8+vVb6azpYg1zlTp0SRmuYCrDJamzNPFHIfnw/CkPzR2d
	CSe1D9KceS5NswJbbUiuBGjvB0duJVTBVHwphZlCKQcE1NgAAGMmGoPSyew==
X-Received: by 2002:a50:9983:0:b0:57a:2069:e91 with SMTP id 4fb4d7f45d1cf-57a8b674ab5mr1282380a12.1.1717575400719;
        Wed, 05 Jun 2024 01:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnDWsmeGVuf2mez79IRf+VouIvlEPmoOV19RR5wEUe4IIflrHEB7JVXR7OyM17+DSycTI2BQ==
X-Received: by 2002:a5d:62c4:0:b0:358:a09:2677 with SMTP id ffacd0b85a97d-35e84046ff8mr1214838f8f.2.1717575380210;
        Wed, 05 Jun 2024 01:16:20 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:19 -0700 (PDT)
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
Subject: [PATCH v7 04/13] PCI: Deprecate two surplus devres functions
Date: Wed,  5 Jun 2024 10:15:56 +0200
Message-ID: <20240605081605.18769-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605081605.18769-2-pstanner@redhat.com>
References: <20240605081605.18769-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() should not be used anymore because it contributed to
the PCI devres API being designed contrary to devres's design goals.

pcim_iomap_regions_request_all() is a surplus, complicated function
that can easily be replaced by using a pcim_* request function in
combination with a pcim_* mapping function.

Mark pcim_iomap_table() and pcim_iomap_regions_request_all() as
deprecated in the function documentation.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index e6e791c9db6e..f199f610ae51 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -501,7 +501,7 @@ static void pcim_iomap_release(struct device *gendev, void *res)
 }
 
 /**
- * pcim_iomap_table - access iomap allocation table
+ * pcim_iomap_table - access iomap allocation table (DEPRECATED)
  * @pdev: PCI device to access iomap table for
  *
  * Returns:
@@ -515,6 +515,11 @@ static void pcim_iomap_release(struct device *gendev, void *res)
  * This function might sleep when the table is first allocated but can
  * be safely called without context and guaranteed to succeed once
  * allocated.
+ *
+ * This function is DEPRECATED. Do not use it in new code. Instead, obtain a
+ * mapping's address directly from one of the pcim_* mapping functions. For
+ * example:
+ * void __iomem *mappy = pcim_iomap(pdev, barnr, length);
  */
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 {
@@ -886,7 +891,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 }
 
 /**
- * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
+ * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to iomap
  * @name: Name associated with the requests
@@ -897,6 +902,9 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
  *
  * To release these resources manually, call pcim_release_region() for the
  * regions and pcim_iounmap() for the mappings.
+ *
+ * This function is DEPRECATED. Don't use it in new code. Instead, use one of the
+ * pcim_* region request functions in combination with a pcim_* mapping function.
  */
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name)
-- 
2.45.0


