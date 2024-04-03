Return-Path: <linux-pci+bounces-5601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F08896818
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 10:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0DC1C20C78
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 08:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2DB135403;
	Wed,  3 Apr 2024 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9F+g/GE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8180BE5
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131658; cv=none; b=L0GZoMPcmrZBTfJ6yN9jawZ4fc/pM8NDn9b+laMcmu6z0B4/y/cyjR1nElCXxQV2UKTvcf8vXNaka3uVHLSlj4yocvCK88aaz7jo6CO4QVEdFoRrcCGaDenZBsXbpdstuM4OaPWdpLAB6x+TYyijw7tpOr9YVUk0CS5OiBMdEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131658; c=relaxed/simple;
	bh=egR1XUvwOxPeyIZd3sd9jzFwNHxic15Pnh9GwC3PxjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg8kxmTxGtTJGagrZ5nrTCHZ/HDHhpBIcctfOw67TO7Vm1bzeH3/yk54+1XRfSFaU+9YTbkzXnA9G3i/KTE7ZIV5AK+QqqxlhNVGyD9nyaMltbEoePmbCXjQloiU9dschOfykEaIjdmtBg7fVmiE1Twlhmm58nNdv00+693JMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9F+g/GE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMdbSBwdbBKBdkE06cPmCOrD9+7wz7G2A47emsXg9D8=;
	b=U9F+g/GEAcC+FrH2/boQoVyGfCfF4HHqUlDI6rj8sJ50g8TNdVKiQcbcqAU06mU3nNh+Si
	7+glLWjN1d9QMP7SQH5OdbwssLIiOByX9GqlCx+1IBkcC8/HydQnCpawkE1OFNWScZOVOx
	HT6ME/C0LaBh4aHMBsPgAOfyODZh590=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-niMhdAHbPLWA56uut1nhog-1; Wed, 03 Apr 2024 04:07:33 -0400
X-MC-Unique: niMhdAHbPLWA56uut1nhog-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d344e352f1so8874321fa.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 01:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131652; x=1712736452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMdbSBwdbBKBdkE06cPmCOrD9+7wz7G2A47emsXg9D8=;
        b=qyoUWNI1E3pidzrZ0gWOsVdyoVlqydqrkIJpKln27SCl8ns2Ig81N3bC4qr5szZzSV
         Z/2xA/UQh9+CnD0n3j8S08IdpbRfjXTkqoOoVZgq830fgM7GQGLjGy95ptgoya6vXvfY
         6LYPT+IN7dgPXRtXEDW7ayAMBni8zC0xFhTMy/Ka88sCVJH5hMeurnQLLpeR52MoZE1B
         lTP2B4oOqPNOPKBP9OVxjRc4GMTboPTStGUd5JOyS546OnwHV5UMZvDoOS/2bEqi7s5T
         miPiZ0nR9Mki98sfqmGc6MeTnzQfu8PiEWN5kWlb0eigWJOdD4pHIjhcSZ/xC11A8/cX
         0pGg==
X-Forwarded-Encrypted: i=1; AJvYcCXnBLYmpBmTQS6llacBr8fBb1imUQFIyTkj06Kfxiy+LfVR1+hoPEMEHh61HNz7zs2608xE5GaXMRwCoSkbREZV9gIhl3AqNCiM
X-Gm-Message-State: AOJu0Yxzp2iTCPAmsBSmDeoBDFlqXNVhSno/Iz/TjtFWdLSDx7pGHWtP
	jGLlia/yO1rQruzFUZ5iCg6TYOtP79OZxseMRgehozTZWvSHdoBGDevfumriHiMfzWDwJu+XL55
	ZzSZOHfs5U+Mt4xMh825tfQLhfFTYhnqTf4y3zpKFqCJIgyksHHH2RWZrkA==
X-Received: by 2002:a2e:a30b:0:b0:2d4:7f17:185d with SMTP id l11-20020a2ea30b000000b002d47f17185dmr8036435lje.0.1712131652232;
        Wed, 03 Apr 2024 01:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ZKJGDq33FEBegelSh+aW2RNhstu69B5Bp3FcmKj9z5wrufQ/wWrxjzl1ABxOamDyWxbX4Q==
X-Received: by 2002:a2e:a30b:0:b0:2d4:7f17:185d with SMTP id l11-20020a2ea30b000000b002d47f17185dmr8036412lje.0.1712131651855;
        Wed, 03 Apr 2024 01:07:31 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:31 -0700 (PDT)
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
Subject: [PATCH v5 05/10] PCI: Move dev-enabled status bit to struct pci_dev
Date: Wed,  3 Apr 2024 10:07:06 +0200
Message-ID: <20240403080712.13986-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403080712.13986-2-pstanner@redhat.com>
References: <20240403080712.13986-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit describing whether the PCI device is currently enabled is stored
in struct pci_devres. Besides this struct being subject of a cleanup
process, struct pci_device is in general the right place to store this
information, since it is not devres-specific.

Move the 'enabled' boolean bit to struct pci_dev.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 11 ++++-------
 drivers/pci/pci.c    | 17 ++++++++++-------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  1 +
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 03662760d629..6bf93c6cbb66 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (!this->pinned)
 		pci_disable_device(dev);
 }
 
@@ -446,14 +446,11 @@ int pcim_enable_device(struct pci_dev *pdev)
 	dr = get_pci_dr(pdev);
 	if (unlikely(!dr))
 		return -ENOMEM;
-	if (dr->enabled)
-		return 0;
 
 	rc = pci_enable_device(pdev);
-	if (!rc) {
+	if (!rc)
 		pdev->is_managed = 1;
-		dr->enabled = 1;
-	}
+
 	return rc;
 }
 EXPORT_SYMBOL(pcim_enable_device);
@@ -471,7 +468,7 @@ void pcim_pin_device(struct pci_dev *pdev)
 	struct pci_devres *dr;
 
 	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
+	WARN_ON(!dr || !pdev->enabled);
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c0c1ee17a06b..9f1419bac9b9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2011,6 +2011,9 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	u16 cmd;
 	u8 pin;
 
+	if (dev->enabled)
+		return 0;
+
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
@@ -2025,7 +2028,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
-		return 0;
+		goto success_out;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
@@ -2035,6 +2038,8 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 					      cmd & ~PCI_COMMAND_INTX_DISABLE);
 	}
 
+success_out:
+	dev->enabled = true;
 	return 0;
 }
 
@@ -2193,6 +2198,9 @@ static void do_pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
 
+	if (!dev->enabled)
+		return;
+
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
@@ -2200,6 +2208,7 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	}
 
 	pcibios_disable_device(dev);
+	dev->enabled = false;
 }
 
 /**
@@ -2227,12 +2236,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
  */
 void pci_disable_device(struct pci_dev *dev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (dr)
-		dr->enabled = 0;
-
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 040ed2825554..2b6c0df133bf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,7 +823,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0f203338f820..95cdd1bc73c4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -367,6 +367,7 @@ struct pci_dev {
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
+	unsigned int	enabled:1;	/* Whether this dev is enabled */
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
-- 
2.44.0


