Return-Path: <linux-pci+bounces-8718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07292906CD0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E111283513
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D91459F3;
	Thu, 13 Jun 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLo2ThCF"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF51448C6
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279451; cv=none; b=mFth5C2qyy4J0rsMJVHTa/LrkYYOHlL5LwhvUhPGXHwIGgXYsgUhxwlIXTTvvmE6jiwgTK0/pBnPxrPIcdQ2gcNq0xVZ+vVwLaBwbFhslyqCFciPgXSNx+ymIUbd97lBYGLadWw8ItLt8lrk+P37fR9Bcq5zfMDtTPRj1sTGgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279451; c=relaxed/simple;
	bh=uxWR+cyvQnS6F+Ku7i7pYs3ZA+OagBoxvbut16jkiT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVkvckM0PJ/6CuW3OEeIAfe+Tv6PosOfkEAUKOblgyO6ytf/gkfqVP/iXLwcSIW50QB5PDj5aUh7F1qaMFqTOQ05gpPlNLjikWin0NSb3AgLGLCCBBLMUMRubVWBpxDbrXbI9V/vExd2b4iNXkU+DHO12Swnt5FO1SLq0H2QxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLo2ThCF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oyizp71aDVZTVSj1hEgGPWD4Zgvxaje3MhAhMHAAQDo=;
	b=CLo2ThCFKPSJDssi4eH+TlfhKKari8ckyIxBPwD/ThJY8NLwSZPneR7k7eDb1ilzBrNzST
	zGr6yWu4x40ZK1aAgelIyyi29NvB0yHdC+vamx88EioxDbbD/3sYeKpfsmEbtDNjT89FLe
	UkxThevCmA2b8YRDJ0lIKHzlo4kIUNY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-kip71_kBPkOkJXbyLM6BTg-1; Thu, 13 Jun 2024 07:50:47 -0400
X-MC-Unique: kip71_kBPkOkJXbyLM6BTg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ebe9456e2dso435521fa.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279446; x=1718884246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oyizp71aDVZTVSj1hEgGPWD4Zgvxaje3MhAhMHAAQDo=;
        b=q0mW7rB9pgHwEYEsXnCTPbxESAeZtvGXTeYJxBME8Qf1E0wjyX55EJvt3NIaeKkyYu
         9aF98zPiEv/+/q+MaGLIC/Z1SmyVn9TMT5qakz20Tuza2V4rvbIbWJZh2IqP5CAH6eyN
         k5A7f+zg7IKe4BG+9wnAEBBR6UjL2ZSJgNQ3hYWX7xIL4s4s7tp/hUUalgh78oX+4er6
         jCK1SoR9F2xNcSU7RYlHZCj8WMm2apZzKY8S83e/hM74ibLpJ8GjQC32yRf5VWL5fhZm
         KKrAfdcPv2iEqxKnoUH8zWpaQhj1ejvI8ll0dUCB0E6gI0nCHdgsp3Ox6riNW4jD5Dip
         MYOg==
X-Forwarded-Encrypted: i=1; AJvYcCXFDKjRgRWD4/0ofka/mOQPIRyXJwVYe1LOz/h2mtHxhzYPyTopGMtPFJmQ9Yds5KIpC8g9QUoQcsHn3Moolgvr/hZCX6ofsOgK
X-Gm-Message-State: AOJu0Yy7cHXEQQ0PM0qAb6jhzfx9x85WJYuU1PbNlEawD+GrYMkD3cFl
	LetatbQb/diUVMv24cp0oMsG17oPwG4CiGjrzObz3OPAVfWwaejHZErK3MxEWM5k3ga8lrWXAen
	KGSKRoRsIsWr0V6rWexXv+s+sGXfsnMgJ+ABNiD1cd9DfhRCpaZRT8XUB5g==
X-Received: by 2002:ac2:4db6:0:b0:52b:b349:c224 with SMTP id 2adb3069b0e04-52ca59e8a34mr41632e87.0.1718279446136;
        Thu, 13 Jun 2024 04:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLhEgk5PVdiMFlFsN3ltE7pAoZnfjyVgZ6hFXz98dULDmP/AUIKfgL84nHKqB6KbULbimrYw==
X-Received: by 2002:ac2:4db6:0:b0:52b:b349:c224 with SMTP id 2adb3069b0e04-52ca59e8a34mr41612e87.0.1718279445706;
        Thu, 13 Jun 2024 04:50:45 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:45 -0700 (PDT)
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
Subject: [PATCH v9 01/13] PCI: Add and use devres helper for bit masks
Date: Thu, 13 Jun 2024 13:50:14 +0200
Message-ID: <20240613115032.29098-2-pstanner@redhat.com>
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

The current derves implementation uses manual shift operations to check
whether a bit in a mask is set. The code can be made more readable by
writing a small helper function for that.

Implement mask_contains_bar() and use it where applicable.

Link: https://lore.kernel.org/r/20240605081605.18769-3-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
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


