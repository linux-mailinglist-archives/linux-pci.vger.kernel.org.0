Return-Path: <linux-pci+bounces-5602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D6A89681A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 10:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C6B1F26465
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D98F13664D;
	Wed,  3 Apr 2024 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzGeemOs"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F110135A53
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131659; cv=none; b=pHQmaLjd4QWuBt/nad8ML1qIv1cw8n9If68VyRJEl2gbplUe4iPRAUZ/TtKjIcIqoCg5F0dFJHNem87wgArDPDY3w0HQYJexFF910WsNMCFw0CEMFf5CmNWCAGgR4u2xBRZC+IkCT2rhW1t+o++GIWy4Wp4RoleJflfxH2LFv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131659; c=relaxed/simple;
	bh=9p/a21NS5PRLRt4lKV9MFdnF9ger+P3gJJ0Lhr4IHQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJe1Lxz7e8PQDp1cNXTLhI9ArWcw8ct+j4G7cF2nflQix885I34YkpsVy7JGSEtbnfgQMLHtrw0rr4jR0f6RiyA3uD0r4cDaURNeZNUeZb3UlxfUyTLI4AbWxXGE2MIS4VZAz/1+u8T+9CYrGkjvpjq4UnSce0iK2gp+X+yH/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzGeemOs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BoLOksgDfWbI16hyJ8yDaTAy/N4I72F11fYMQTrJEvk=;
	b=OzGeemOskgQ0BYxkhawUrMuRLuxiYLrqMiNqib7ZgYP3yiTceBEb1vTGjYAUryg0eGmnSz
	ItZxBWAmCCxyyR/NHGdcT0G3mNsfaBYC1+DDM8+jigvfzO6QpkMbxjlO8Oe9lduQM5jgja
	wS5/koEd0rWcHJk4QjEb73T/UbGoafc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-lp9w0nHLP5-wLZjSURUcjQ-1; Wed, 03 Apr 2024 04:07:34 -0400
X-MC-Unique: lp9w0nHLP5-wLZjSURUcjQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343740ca794so324777f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 01:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131653; x=1712736453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoLOksgDfWbI16hyJ8yDaTAy/N4I72F11fYMQTrJEvk=;
        b=C8bA/T+a0Gg4FU+pwXVc4uHcW+guIndsTyUbnnY5xcKIojfd5WcZwpn0Uq/Fzb9ME+
         lLIuRh8hXH5aAcooYjSfdF7OZ4xH7H52BAB/jADY84FMiZIGnSEt4HCDlKwGeZtHhaPm
         2kI427iPz/d2oUtQzkqkCVHaVX3Zm62HetwCknyWOzCppqqd4Gx7kn0r/9VUO4OFC86T
         B5h8Jf2Gq3FoEVBpSqpowA4Rwh8oyaeKiyOxPT43iHGDpSx3tE6mxAbxBMnT/Et1zpXH
         JGIyfJ7cHrXgN04+ckODKU8VHrR/GyP9e2btRi23HMyPZJe0CM7jwWKnWqoLBgDwA1EZ
         BlEA==
X-Forwarded-Encrypted: i=1; AJvYcCUBFBTUQmkS5Ftx4vppGQnGXF/L2X7f0ReThzzjsF7gBXQqVc9Y0s737x0DTMcfxEDF2lWWsFe3+9lIzAzgqrJmHdH2KjTk+cUw
X-Gm-Message-State: AOJu0YyjcxNsKShjTPlZ19P+Zm88zLrF8UEbtR4+T3GeJyRGrpXqbeK/
	Ct5+ElYDa6uQXKRWSKv6a2QfVYbJYdN9CvdSugPormmRMVwUdHrlz2IckoW4j9djNe8lN15KhL0
	A+zTrxPX2Hn8SZIMtHFNFEv51ug+zXRubx8CplE5J1PNvTHmD48PKPxzwPA==
X-Received: by 2002:a05:600c:5114:b0:414:8084:a2e7 with SMTP id o20-20020a05600c511400b004148084a2e7mr11598696wms.4.1712131653225;
        Wed, 03 Apr 2024 01:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL1OZqcpCT4lUdvpXOXJzFl5uup5f2oesW1up00E+QvTRHiJaEGrozTM68bu2J6Gv2ppGWaQ==
X-Received: by 2002:a05:600c:5114:b0:414:8084:a2e7 with SMTP id o20-20020a05600c511400b004148084a2e7mr11598671wms.4.1712131652967;
        Wed, 03 Apr 2024 01:07:32 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:32 -0700 (PDT)
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
Subject: [PATCH v5 06/10] PCI: Move pinned status bit to struct pci_dev
Date: Wed,  3 Apr 2024 10:07:07 +0200
Message-ID: <20240403080712.13986-9-pstanner@redhat.com>
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
index 2b6c0df133bf..a080efd69e85 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,7 +823,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 95cdd1bc73c4..9d85d2181083 100644
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
2.44.0


