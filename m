Return-Path: <linux-pci+bounces-8724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBAF906CDF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BE4B2415A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543D014883F;
	Thu, 13 Jun 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONkuou/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775F1487DA
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279458; cv=none; b=iim1XLLH9+mYI2LVJuiWExpBRiYd5A9FCOppRbQMwXZFeIzgrF8BqxqiSw7uARdDrHZBlX8JHIEYFDwVodyIiICO3SPlUvPWDo56+1n79ScYF+G+TV3F0a6kxTD/Q04SF3GwTpThcZUa7ip4iGPddHgNle58J+Y5kiwHxHAmFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279458; c=relaxed/simple;
	bh=xCJskR4ZILXQ5wDrghh4Sq+j29QXGosY9+0FgltF0/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di6j+U9SchSKWrWgvPM13TSbWtJ1kN/nJCx+zf/aQ/hNo6KGcfOBQUnumC1HFK+HvybjGt34R2zn5vIJGKKWs3FjaGWMGcaA+QhcbntTjG7ZSUGD02a08ncWwGGN5+a+W3RfqqcUxLIUX1aZlUsxuC8wm2QjhrjGLBhwvxmPdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONkuou/t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMEejGKihJo2G832kSH48RcHSFeE2XrrHWpYzOQBaEo=;
	b=ONkuou/tKfMRfE3Y/QnJKm4lGCi2cZQPQ6CR6B8qrIHmWlDf6dkZy/8/YGVroVTM3SXGci
	dFHoNd2HBkFREFwznSprQjI6MC4oBGT1fBE8BscpPV1Jz/hfRUGxl2sdih+3Lg0nomAeyg
	SfakEpQhEiy0kHSgOCD2m7Oh/M8czbc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-xOXLsQoaPJ26jUEsS2dcwA-1; Thu, 13 Jun 2024 07:50:54 -0400
X-MC-Unique: xOXLsQoaPJ26jUEsS2dcwA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ebd962eb88so397811fa.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279453; x=1718884253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMEejGKihJo2G832kSH48RcHSFeE2XrrHWpYzOQBaEo=;
        b=IJQTJLaz/JrDH3EJZUcvkZRiP0NdF7B1s5e1MQ2noqDyW0iTfRz4IzTrt9Wn1tsVBE
         cf32u+/76qGupQYfaHwSPMFO5jK6fRGoFSJfCscvzZ1RH1V8vv9eigPIVBIjLD4zHvCW
         XbkLIp6C16a/h2RJHoAJKWpcvKI5v9L/Mdt5pYhdvE0o7+jQHkSBRw0Fs9TpGDzy7zZ9
         D8VuXEnpXwMuhwXXBE1iMq5jFGbPXlR5Cb7L/9w9AZGyZNvpI/PKtvMXY4aWKMTIeZS/
         m+woebxePk89EIt3QjVKQZzKRsM2Fg3FCxE2op5ZxNLrkIotRIAo/9KuS+fg7uT9hKWr
         nyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDHDvsoPcpCNm8SHTYXogAzWYZaP2PsP0FqRGa4yQOJM1VepQxsIOT2GebrGSBD0w5UhKemPcw8XeHA/G30ReSz4Y/QftoloYC
X-Gm-Message-State: AOJu0YwFP5upI+7nkCAMUGXVVLW+1AaEdHRFEp58TQMDtnaIVH4e0k5t
	jQvBOhPOT9nhT+FbHaZOv5VWRAzD8lPdOXXnTxJE7Cb9EnSddH7tShL7g9+pxSLqcN3ut5KU+Pn
	7zPzqdIfpht4qu4wkYBqkgXOu5iq50P3gdp8guzuWklve0fUE4x+pFiBz6A==
X-Received: by 2002:a05:6512:1598:b0:52c:8784:5b2c with SMTP id 2adb3069b0e04-52ca5d03c67mr13446e87.3.1718279452684;
        Thu, 13 Jun 2024 04:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEqupRIXquizQF60Ogvk1gSUj/lELnfPgWk0B7d0l5dOVUd+wsdDCM/WABqJ9TrRzGJhmkEQ==
X-Received: by 2002:a05:6512:1598:b0:52c:8784:5b2c with SMTP id 2adb3069b0e04-52ca5d03c67mr13426e87.3.1718279452377;
        Thu, 13 Jun 2024 04:50:52 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:51 -0700 (PDT)
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
Subject: [PATCH v9 07/13] PCI: Remove enabled status bit from pci_devres
Date: Thu, 13 Jun 2024 13:50:20 +0200
Message-ID: <20240613115032.29098-8-pstanner@redhat.com>
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

The PCI devres implementation has a separate boolean to track whether a
device is enabled. That, however, can easily be tracked in an agnostic
manner through the function pci_is_enabled().

Using it allows for simplifying the PCI devres implementation.

Replace the separate 'enabled' status bit from struct pci_devres with
calls to pci_is_enabled() at the appropriate places.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 11 ++++-------
 drivers/pci/pci.c    |  6 ------
 drivers/pci/pci.h    |  1 -
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index d90bed785c3f..643e3a94a1d6 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (pci_is_enabled(dev) && !this->pinned)
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
+	WARN_ON(!dr || !pci_is_enabled(pdev));
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5e4f377411ec..db2cc48f3d63 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2218,12 +2218,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
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
index 2403c5a0ff7a..d7f00b43b098 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -821,7 +821,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-- 
2.45.0


