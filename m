Return-Path: <linux-pci+bounces-8517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F377901E4D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077792871C7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2979952;
	Mon, 10 Jun 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dn7L1JqD"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447178C6B
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011933; cv=none; b=sloErZp+qmCEiD+oE37DLXdTLjsMIRZH5tEiItcHrfaS7wIn3mG5lpSAynOEPexv02ptwyl02pRyXlEVueAX5wGo7U1HjZWHC+qgt+FgJOvJZvazLAGUpOQWA0OMDmqedkRe6qZh7tbfh6frdktfXxpVE6OCekSuYV8YSIIPg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011933; c=relaxed/simple;
	bh=JZ0qVkY2AySl55GbKU4MmbsmlZou/0KAge/Bt6uyTGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOpc6/E3OnpV3XAc4LwfcMxCmNSmcTnfocohJRzSdq1bcPKnYSAwcYwMXhZ0Z62t7MdtNtk/z7OSsCHibDD6cv6KS0q9M4TeUlHF2XnR7jN5lKm8X/TuZLq4U3iCCrz8qa6/oQ9or9Tk0sgfEjlRx1WT+VxzEiJkv1p0IqwP7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dn7L1JqD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YC1P2jDfqZ/b0bhQ66lkvDoa/VkJd5IY0GIkzmrgRyA=;
	b=Dn7L1JqDp3+Q4JxSXAAabidSnjVOSlTRBd5w7JxvSSxauJjB/xKyPaCEQYb05AD0Ihd+oM
	h9fBQACMHmtTmjWUJd6aPyzOTlyp/IqUh/4whHWHNHpRaoSMgULzS0dC9goSpvcBF7j2cM
	+1dvotHuNiBFMTDLVJyosebP6HbvjCY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-S5XBIowaPAmc_nguXqjZHw-1; Mon, 10 Jun 2024 05:32:09 -0400
X-MC-Unique: S5XBIowaPAmc_nguXqjZHw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4215f69475cso3516805e9.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011928; x=1718616728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YC1P2jDfqZ/b0bhQ66lkvDoa/VkJd5IY0GIkzmrgRyA=;
        b=TkUFPP0TIQQqSkr/wiI8tB1pG+O44SUeiktaN3+QghJTVJipX4fvBfyJH7FirEbNrH
         khQXGO2q5f1XNIdrkC46toQBJFs9Mk0egvI6M0n6GInhvqCO+umEbkgAG5K0r4j/rzaU
         9JiMViAPFiB0FPOkhFSW0QUzR3w5fIAX5pSNLpt9agtyoNMiJqQZz8+IVe5+P9lD5mMY
         qBVP5lZEcd+IbRJ3xqu4fb7I/mGPnb+Am6uj/8xtR6RTIkGA56QfOk+PiSB8f+8UAe3B
         DyEdz550pVIs0nTv7We5MjWfOWMOTc9eq0JwHovvFRovzwbUTnwF+U3niJzVyu4oF1d+
         +rHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN15MZPbbFRMIbpEbHIAPIqHG6XLhWxLA8BhWkMVvCnaO5dYf5Fj8RDXevPpSfTjJShneurQ5eotvPIjHiY4WgUaKsud9rITev
X-Gm-Message-State: AOJu0YxIOSepQWZEdtTHZJ+JgjNnCy8nMYiGITWVsVoDcl8DAn1ZPFf8
	pK8sYId/jUini19bHPmj/Cq0EUZGF2UEdrVSNeImOz7gDzkLkldLo/JqbnTd+jtp3vXK8Dlkbb/
	g0qK6SCfpXKHsBPhm921N517wEs/hJwxyFaXtqE/LeXMyfPCJIRv9UPHhDg==
X-Received: by 2002:a5d:6c65:0:b0:354:fa7d:dcf5 with SMTP id ffacd0b85a97d-35efea7e189mr6469035f8f.0.1718011928179;
        Mon, 10 Jun 2024 02:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVJwLx4/C+jduwDhQw/dzOe6oYBT02eJHjQK+Qoax/SQHHf7G+cPrhRcc8vOfgRdZ1mMl4TQ==
X-Received: by 2002:a5d:6c65:0:b0:354:fa7d:dcf5 with SMTP id ffacd0b85a97d-35efea7e189mr6469015f8f.0.1718011927762;
        Mon, 10 Jun 2024 02:32:07 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:07 -0700 (PDT)
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
Subject: [PATCH v8 08/13] PCI: Move pinned status bit to struct pci_dev
Date: Mon, 10 Jun 2024 11:31:30 +0200
Message-ID: <20240610093149.20640-9-pstanner@redhat.com>
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

The bit describing whether the PCI device is currently pinned is stored
in struct pci_devres. To clean up and simplify the PCI devres API, it's
better if this information is stored in struct pci_dev.

This will later permit simplifying pcim_enable_device().

Move the 'pinned' boolean bit to struct pci_dev.

Restructure bits in struct pci_dev so the pm / pme fields are next to
each other.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 14 ++++----------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  4 +++-
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 9d25940ce260..2696baef5c2c 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (pci_is_enabled(dev) && !this->pinned)
+	if (pci_is_enabled(dev) && !dev->pinned)
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
-	WARN_ON(!dr || !pci_is_enabled(pdev));
-	if (dr)
-		dr->pinned = 1;
+	pdev->pinned = true;
 }
 EXPORT_SYMBOL(pcim_pin_device);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d7f00b43b098..6e02ba1b5947 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -821,7 +821,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb004fd4e889..cc9247f78158 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -367,10 +367,12 @@ struct pci_dev {
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
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
2.45.0


