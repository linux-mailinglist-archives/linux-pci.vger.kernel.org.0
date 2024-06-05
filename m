Return-Path: <linux-pci+bounces-8304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0518FC5FA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C99D1F21494
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B821C18A;
	Wed,  5 Jun 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2jB74V1"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2E194A6A
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575403; cv=none; b=V+Fd2/ksMTqO7kaH0YZrLXna7NMZ0Ey5fiDBhebLV9VQLLZyJC6y8LJhl/UaBcFMQ01V6WdnDUIyw5mfVEpfOMwHgl/Ib78Km/TKBYmq80wWZBZgvjTr62ozbKcZExYXf2P6zC2ftH4zvzKz4hArS8jvWnH5XogPNfRn85GvAqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575403; c=relaxed/simple;
	bh=tV49a5+qMkVnfBuVcqqm88/YXQEYCtYEpLyZHAId3eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBx+mU1cB1NiLYFyogM/++MSIj4LgmcLaLHbodvPEiRhSy7xdPF1+lw7Mvzp1cZ6zdEPr5R51qNkjRxWtZrQJ8KWRh2NbNDe97UB+OOEkJebPpv6+71HoFaxbygv4WXt8M+F0/fSeZ99Z+zb1c/CxBOK+dT0N4KYafGX7oUphJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2jB74V1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FprLruSafewJCGyfXmuQwDL1Jg/OKDGH6ODfzThcTic=;
	b=O2jB74V1BbEg7AcE8r/dvcqjL+QZRLdixpVG1kyslUOMoZu+95mWsmNIHHoJk3DSHawitv
	echLG8vd6g34S59K2dZllcMgeY+EriRItqEz/T7aMzXQ8DOhVnD8LHhlFiO7bLUJgyYfhG
	xfrlkuyOL903CNlik3wPSvIX0IeQErg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-4B4qLlT7Nca0Qx_-ZXDMhw-1; Wed, 05 Jun 2024 04:16:39 -0400
X-MC-Unique: 4B4qLlT7Nca0Qx_-ZXDMhw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a68aa5ca81eso17769666b.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 01:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575398; x=1718180198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FprLruSafewJCGyfXmuQwDL1Jg/OKDGH6ODfzThcTic=;
        b=F7lQQdpLlp3JBtM5cUzmz8rp08QlhwO6kXecn+PUkRi6/ew6nvxRqk9JbsBy3MMgdi
         I+q2hCk7z5QHU6ThZg5hiaZm6xxPsUVYdyzcf8HDUemxHh8PvbyBudnMhKw7dXuFDCxP
         KiTeDXq26WghcFD5vw+nF6zJWqgOBJ9vPEcR+i/eKW6tRYNPup5k/Y61fbkxR5Na4QSp
         vnvr7YBkCcyxSq9R7+r8IYjHPSEMp6sxid1kdpWb3OJ/48I0K99vD/g+wiRilWPdwoko
         ZXET92GkJlIHUGhOQ6su3zfLb9V2d3YbNPB5OqOM9RtqirFpLHjaM/hvwcEKLMw56ATq
         QtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOAmtcI0SsUwgRNJZS0qVwx+pIrCeCxzqyU0LWynnD5M4Yt4NuGT+OGWzo0oQyZrLhVSm33EGf/TqVexs9DhUw7kJ5NDsuVS9k
X-Gm-Message-State: AOJu0YxtRytsmmnAZb+qhrB26Hw5zdPVEakj+Gxcmj5Mtsci97Aj7JbW
	DjUVZnCtFbWQ93MHxs+GzCySuDtoSZRKzBIZUMPu0k2+AC3BxNmdWVaAaPMu8U+hqJznCD4G4xd
	9hLkzWnKFj5NvBXjff9am5+/9qGOYyELXqNlFxL2ExuASj/B+rS+FrPeH4XN9n6dOog==
X-Received: by 2002:a17:906:4091:b0:a5a:89cf:489a with SMTP id a640c23a62f3a-a69a023ebfemr107141766b.4.1717575397888;
        Wed, 05 Jun 2024 01:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH01zzkiwwO2rlaNoVMW4xlWaRAMHnpBHn33IIaKEoTGFWWRSfd/BTk6G3QT5BqGH8wLV82w==
X-Received: by 2002:a5d:404d:0:b0:35e:83dc:e6ed with SMTP id ffacd0b85a97d-35e83fcb079mr1241057f8f.0.1717575377322;
        Wed, 05 Jun 2024 01:16:17 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:16 -0700 (PDT)
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
Subject: [PATCH v7 01/13] PCI: Add and use devres helper for bit masks
Date: Wed,  5 Jun 2024 10:15:53 +0200
Message-ID: <20240605081605.18769-3-pstanner@redhat.com>
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

The current derves implementation uses manual shift operations to check
whether a bit in a mask is set. The code can be made more readable by
writing a small helper function for that.

Implement mask_contains_bar() and use it where applicable.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 2c562b9eaf80..f13edd4a3873 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -161,6 +161,10 @@ int pcim_set_mwi(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
+static inline bool mask_contains_bar(int mask, int bar)
+{
+	return mask & BIT(bar);
+}
 
 static void pcim_release(struct device *gendev, void *res)
 {
@@ -169,7 +173,7 @@ static void pcim_release(struct device *gendev, void *res)
 	int i;
 
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
-		if (this->region_mask & (1 << i))
+		if (mask_contains_bar(this->region_mask, i))
 			pci_release_region(dev, i);
 
 	if (this->mwi)
@@ -363,7 +367,7 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		unsigned long len;
 
-		if (!(mask & (1 << i)))
+		if (!mask_contains_bar(mask, i))
 			continue;
 
 		rc = -EINVAL;
@@ -386,7 +390,7 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 	pci_release_region(pdev, i);
  err_inval:
 	while (--i >= 0) {
-		if (!(mask & (1 << i)))
+		if (!mask_contains_bar(mask, i))
 			continue;
 		pcim_iounmap(pdev, iomap[i]);
 		pci_release_region(pdev, i);
@@ -438,7 +442,7 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 		return;
 
 	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
-		if (!(mask & (1 << i)))
+		if (!mask_contains_bar(mask, i))
 			continue;
 
 		pcim_iounmap(pdev, iomap[i]);
-- 
2.45.0


