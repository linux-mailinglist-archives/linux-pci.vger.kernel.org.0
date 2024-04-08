Return-Path: <linux-pci+bounces-5870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F789BAAF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036541C208A5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859574EB5F;
	Mon,  8 Apr 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEYxa5JR"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D64F1FA
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565895; cv=none; b=X/2itHIYIeoqkMDKfj3iBECg/nknBYudXBRdRRFr8f0ZDjw5YrOXP1rj5SaM1KWny0Sq0dmRnxkM94MecBXXOexjV9kh1aUS5hSCAOuJcs+Za5++Od4ptQbhHHApWujBEhGaZgqikUEX0dlOoUvx9fH32YfJGNe6oOw52Dws6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565895; c=relaxed/simple;
	bh=S0oq+FGKUVk50tt2PkFQpXV/fGnFNIfPoPpC31bSxTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLcSe6AkJEreR1RvVsq+jK9j+I+SOZDLANu+zFs4Ydxk9usu06Fj/TPHje4YYUHheiL0olOCgyDZKH3fgseoocQF6PT3MrMWHXnVklsJAWp75kBT45Ci4s/1FJlDPwWFAbRW1XevwyzcOIrtk2pJjlX/Sp1Psvj+zYqRWKdTcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEYxa5JR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfte4b3wPijsP9MEYyJuLZ+mSeCcAqIklzESx/bINtI=;
	b=KEYxa5JRbM02qH5LEroDm8lkKDCHLzdKUrmWMYQYhKwEsKXjzHg4iOp4GTqnIvhq8OOe4q
	NO1nUk0hQ3e7+vahTLBgQG5Z/TuMT38SEmUXADsEFeKvURRMrTL/lES06pLIpM3FYJDWsV
	Klt+Zaxw++pyb/eJExSHA0PUk3jSLNc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-vNkX68ImMe2L8_v8WBnAlw-1; Mon, 08 Apr 2024 04:44:42 -0400
X-MC-Unique: vNkX68ImMe2L8_v8WBnAlw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78d5267ae96so8517985a.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 01:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565882; x=1713170682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfte4b3wPijsP9MEYyJuLZ+mSeCcAqIklzESx/bINtI=;
        b=oBclNSZd7aLJYQhcH/o5T/kj4hBbCxTZaHsvIzHrXAR7cHYEiolsQgNzsVS8w0vYLR
         4PmkCxnb7bk79LP+IG89gnvfwy4/Yo4+vZNfihxs+7OplvAINsWjQvQPvoP9DYEwHha3
         QayqkzElT5H2sCMDhxQZVqEwncx7jnxAa9bmqfioAbjz74zGsCqLekoIyPvpMfjviN7f
         glHJhOA/M33EY8coeT21kRmHZ6LXYjQBhEgmg+9A09H5eAvWnI6K+gQsaxuQPw8V2w3u
         4oOMZgGk1gukiqY8QlTkcmD+dW3b6UA5bFeQcOxIt0cBgAjMYUGNf3Khi1jR6nwvZlWd
         7hYA==
X-Forwarded-Encrypted: i=1; AJvYcCVxyABAFde84WV6DnEXTTwS3BWrRFjZzKJzf5SwuazjJ/V6TBFB0+h9Ze7vTlVtBvhvp6yAC7yCwb3/sPxUkoCLCK9+vxCbKCRZ
X-Gm-Message-State: AOJu0YyNe5wD6VBGai7xgX9YjRhEXznP2Ub1VN8HACV2bXWm7pGfrJ+0
	dOiP9KwE48PmwcgwVoYQvWjiddea4O30WkQes79vzCDgQWda0bVAFtnXma0CZjsQo/SuQK+6H2b
	dhakxuhTL0N+OnRwaC/7+bFbnAy9hhIOPtYK60MeDuPEG7T9O0M5y3Q0Akg==
X-Received: by 2002:a05:620a:450e:b0:78b:ea64:e0fa with SMTP id t14-20020a05620a450e00b0078bea64e0famr9523800qkp.4.1712565881730;
        Mon, 08 Apr 2024 01:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3mwwm/R12WcmH2kE9iBLa1vhhd3RLItPquJFca7C9FUCjE4MBkJwpaP0CUP/2AT65JzFDBQ==
X-Received: by 2002:a05:620a:450e:b0:78b:ea64:e0fa with SMTP id t14-20020a05620a450e00b0078bea64e0famr9523787qkp.4.1712565881410;
        Mon, 08 Apr 2024 01:44:41 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:41 -0700 (PDT)
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
Subject: [PATCH v6 06/10] PCI: Move pinned status bit to struct pci_dev
Date: Mon,  8 Apr 2024 10:44:18 +0200
Message-ID: <20240408084423.6697-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408084423.6697-1-pstanner@redhat.com>
References: <20240408084423.6697-1-pstanner@redhat.com>
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
index 623e27aea2b1..fb9e4ab6bcfe 100644
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


