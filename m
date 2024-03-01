Return-Path: <linux-pci+bounces-4315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000286E05B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46CB28451E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA16EB53;
	Fri,  1 Mar 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYBECC5y"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A76E610
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292627; cv=none; b=WIW6T1gn6n2E7XbIS8Dl4OphBgN+ipQsaTkarike9nqMmZMXvf6Ut8Fbyp+zBVjFyEu7Cq1p3jBD+ZwpL0CEi6XkznsWi//w/2rEhLALBbN9SlP3pwkyMOrHEUdAoCDUDHrX2AE8rAa+rZpMHc82/9irE3zqDtLzb3/4pIAv+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292627; c=relaxed/simple;
	bh=FDNHRtLE6hNHjH2r39UrBWAZWNGYNFSj11RRKynJczI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SG0y/TiT7Crt4tUEQCG+kzCrsTrlLDmxxCH3sUW1kV5OSBqcep303vGf6QX0ZNnBOoOPKAjmFa4oqIv5qmIriK90Xgju7jTfwD9pBr4qp8KEzTB7gv1ffQhEP/nRM/PWGYIrIejkbS8dJole9M3RmJ71SWzO1YiLeFuuKV3pdiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYBECC5y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivdu8iiMoXpDkyzYV+DyKD6eGNB0PhvUs/32A1olwX8=;
	b=hYBECC5y47gKaTfp76/fyMWM/1w5jnTzIp3C2ObD/YhiRsSRo2BCbv1bkfOwDPCM7uB5p/
	qR245levPb96xEjX8SZyw2EsS0skM0RGB3D642UYEyrPD4LEFIRvV/B/AgM0vpubdL0/p4
	u63zD5xBBdkwhGj8Kw6r25pcIcwToAs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-9VSPPgpVO3CJdES5G0zxLw-1; Fri, 01 Mar 2024 06:30:23 -0500
X-MC-Unique: 9VSPPgpVO3CJdES5G0zxLw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e4a790b3c6so126540a34.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 03:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292622; x=1709897422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivdu8iiMoXpDkyzYV+DyKD6eGNB0PhvUs/32A1olwX8=;
        b=c2a+juCyWzrEv1jjH2KuAxgMCgSEJI2leEjru1phalSA5gYTYQQ9jF1zPBJwjMzmvG
         85FMgf72plJbNQ6qydIG1qq/no/zfuBS1VMoycMsQVe1div4tduclOxBMpQtwnSe6Yk6
         GQT2mxMC6WX9kKPuMBzhdvSOqWxBpuO6dQTlN/L9PyM9bwayhDsmxhJnzT4WQWQEGfHS
         N/xUBD0g6QMBKi8sCf4lyixanE0qWOuDug5O2mUrm8rs98UdI8AOIzJ0ZJz03YPn9TdL
         sJf8lYMbDkSMDhKssMT81q8tFqWMRUP7vZsaRphgiEAj8uz8bhZsTBm3W0wOAKc4o1TH
         V1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUuf3e3eenPwikq3yQ2S6kdkOc/rykIVwhXLIiH9rIcM35XFXp82Di8rnabKVncPK/1TfCJgDeiie9OfuKNGJZprXjI8zTyDl6r
X-Gm-Message-State: AOJu0YxFAASmUEmnM8zYTIHK0jgqnI3FKMXn7vJgYbL1Xa+yZpCaxu5X
	IVjh5Fnn/CS6mKxFeZQcSzedTa9NiE8y5opI6uatUOwbNxdpRxMpTSbOnuOwlusSojQDzuzEr62
	FJOB4UdKoDQQ4/wVlZ37B4ktc0PqCs2tTiohwoW+/eo4ekc3xvMcqjpSjdA==
X-Received: by 2002:a05:6870:1b89:b0:21e:be91:ae48 with SMTP id hm9-20020a0568701b8900b0021ebe91ae48mr1406131oab.1.1709292622693;
        Fri, 01 Mar 2024 03:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8ckx+w8g4Wwwu8eFQ5kKdvTt+sQ5kL9bsz1OBV7fqZNxqMuodycq5A8JPNFFAp2o3NusiBQ==
X-Received: by 2002:a05:6870:1b89:b0:21e:be91:ae48 with SMTP id hm9-20020a0568701b8900b0021ebe91ae48mr1406108oab.1.1709292622384;
        Fri, 01 Mar 2024 03:30:22 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:22 -0800 (PST)
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
Subject: [PATCH v4 06/10] PCI: Move pinned status bit to struct pci_dev
Date: Fri,  1 Mar 2024 12:29:54 +0100
Message-ID: <20240301112959.21947-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301112959.21947-1-pstanner@redhat.com>
References: <20240301112959.21947-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit describing whether the PCI device is currently pinned is stored
in struct pci_devres. To clean up and simplify the PCI devres API, it's
better if this information is stored in struct pci_dev, because it
allows for checking that device's pinned-status directly through
struct pci_dev.

This will later permit simplifying  pcim_enable_device().

Move the 'pinned' boolean bit to struct pci_dev.

Restructure bits in struct pci_dev so the pm / pme fields are next to
each other.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 14 ++++----------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  5 +++--
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 6bf93c6cbb66..076362740791 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (!this->pinned)
+	if (!dev->pinned)
 		pci_disable_device(dev);
 }
 
@@ -459,18 +459,12 @@ EXPORT_SYMBOL(pcim_enable_device);
  * pcim_pin_device - Pin managed PCI device
  * @pdev: PCI device to pin
  *
- * Pin managed PCI device @pdev.  Pinned device won't be disabled on
- * driver detach.  @pdev must have been enabled with
- * pcim_enable_device().
+ * Pin managed PCI device @pdev. Pinned device won't be disabled on driver
+ * detach. @pdev must have been enabled with pcim_enable_device().
  */
 void pcim_pin_device(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !pdev->enabled);
-	if (dr)
-		dr->pinned = 1;
+	pdev->pinned = true;
 }
 EXPORT_SYMBOL(pcim_pin_device);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 97bd1c074d26..0a4220aa303e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -825,7 +825,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f29c9289b378..fdf579e0d6ec 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -367,11 +367,12 @@ struct pci_dev {
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
-	unsigned int	enabled:1;	/* Whether this dev is enabled */
-	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
+	unsigned int	enabled:1;	/* Whether this dev is enabled */
+	unsigned int	pinned:1;	/* Whether this dev is pinned */
+	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
-- 
2.43.0


