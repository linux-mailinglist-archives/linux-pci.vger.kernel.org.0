Return-Path: <linux-pci+bounces-8726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62247906CE2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCED281B75
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C662148FEB;
	Thu, 13 Jun 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8Cfdo2Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B2148837
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279459; cv=none; b=MS2Pf7W3YneH45jJ19omMLp+dJ6mWgpL9rlcQ0+hFqkhrxwoPU8RoogUN4YZStoht2Cn03LLm+HgTgWl0+h7ztP8ViNdyD8UT743RfqTTgRKGq2UMKQj71WYO5ueTlOL3V0r/BbePmtL4MOMzhUdbGLY8OlKDsSCy8OKvjpPrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279459; c=relaxed/simple;
	bh=pCQsKw5JTEucg35lXycT49o+c0HiqjktK3rXy0MLKzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pge9Etxb+tuXwyoJoXQa4t11/GGhcGsD+mPhOJ5Hvh92m5n9fV9Xg6yHHfuOe43IlAKnoUwoN0ZPmgKJtiHl5JZKjrsWLgR/fhDzNNQKznm/atyr9qSxC+GAhm79kcX9SVJl/AV30TgP6LYhGhUETRnVt4RuaVtYw3/ruDog9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8Cfdo2Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVfgCjKnb7mN7tw6g3EsRXSFrlAe3Q6EtTbj0A26jHk=;
	b=h8Cfdo2QREHXS+XW3Qn/4dbxXQ8yNMudE6eowX96DkN2B14bjGwJ+/vXef1Vp3ITsingyn
	RjM2GzEZTWi0M9e7oMMPAfRGHZ7Qrr4j4EscEtPbuv+YAOGih7/9IUWfXdH1M+Dc/YepWR
	7+IWxZ2ntlaTOOArLXEqNOUmjUNtkao=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-H6sqTD9COZGHohC0C-YE9A-1; Thu, 13 Jun 2024 07:50:55 -0400
X-MC-Unique: H6sqTD9COZGHohC0C-YE9A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2eaeaefbcc6so1418861fa.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279454; x=1718884254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVfgCjKnb7mN7tw6g3EsRXSFrlAe3Q6EtTbj0A26jHk=;
        b=nCrmXz96nLBxbiGkXcjHfiraMSbFrlnUY3PV7/+L14s0sAcnBRf7hA/1S7+f3V3XdG
         mAdwYxJRpvMAa83jSUXPfnkfEuLnfatXdJ6KpqmcckTZsC2S9AXvJ/BSxga+RFOAoJkL
         xov+a/H1VdaL6Yr2jUatyanrubaNFCtz9/UpdFkfCEwAWBiBXONLdRoo/aWkaCyQB3ph
         RtHqQN5a+xrrpEg/Ega4yzIMi3GnqANnvI3TAlXNYa1tUVxqm10MmycM7Rf5RlaMuskq
         SxyiKdmnNcyMpBYV0r/gEcBQBwt/FMM/+CuJD/d7W/pu4TEddwF3qif709mFNUf+LHjg
         zukw==
X-Forwarded-Encrypted: i=1; AJvYcCUiMCrNACnvr+nXSInFxFBAzF+jktHx6TjtL2feqRUCHrEh6gkeuEwgrDXI1/DPHgrCNFUVAqhbeXP/r8Gei6JwGNcAfcnRSm1P
X-Gm-Message-State: AOJu0Yx6xO+W1Hem65t0zFAm/jbdXDiouX+zl8mR2hY5OuGmV3Wa1y3+
	Jdp7S1f9hPqHllC2Yp/q+vEn4JZMXEh0z9TkThBmCtXVf5bEEjvpsG5vWGxQMcNTvI+9wsxqMf/
	VtkM7nhgnaNGz4QkFVjEdbhJHNQD5g8+HrtD42yLPfEBWx/yZPu/WLs92gw==
X-Received: by 2002:a05:6512:ac3:b0:52c:9e80:387a with SMTP id 2adb3069b0e04-52ca59e9d11mr72165e87.0.1718279453801;
        Thu, 13 Jun 2024 04:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3dSZsb8l1qGTBxCy/CxpKhrwqSIxs3fGuB9Mz5Llia8E6mlHaM5OG7LJkgO+LSWP5CNnfZA==
X-Received: by 2002:a05:6512:ac3:b0:52c:9e80:387a with SMTP id 2adb3069b0e04-52ca59e9d11mr72136e87.0.1718279453401;
        Thu, 13 Jun 2024 04:50:53 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:53 -0700 (PDT)
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
Subject: [PATCH v9 08/13] PCI: Move pinned status bit to struct pci_dev
Date: Thu, 13 Jun 2024 13:50:21 +0200
Message-ID: <20240613115032.29098-9-pstanner@redhat.com>
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
 include/linux/pci.h  |  3 ++-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 643e3a94a1d6..84caa0034813 100644
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
index fb004fd4e889..0c19f0717899 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -367,10 +367,11 @@ struct pci_dev {
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
-	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
+	unsigned int	pinned:1;	/* Whether this dev is pinned */
+	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
-- 
2.45.0


