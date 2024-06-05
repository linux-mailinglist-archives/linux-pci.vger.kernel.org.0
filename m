Return-Path: <linux-pci+bounces-8302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324F8FC5F4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A91F1C22128
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500C6194A47;
	Wed,  5 Jun 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFB8w8at"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0019413F
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575397; cv=none; b=I9eqY/jfHBj1DTocfqhHkb0cMyK66SPqRmO89z/mNT0rFxSuf3bi+anBiLETygJsW756vXxv/u5ebugiokNxBg3yLyOC021aRuieHNQ4EmrVtC/odk7juzvYO/HFRxbDpft/2c2xhQMn6WqpDw/LuHMnnXAC752mtojn+Z/LOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575397; c=relaxed/simple;
	bh=JHKzjaKvnMGmn24TasdPaKkcQ0DRRNWgFayHL5mcauY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhfQnVhZOxKtf5l1xmdCa9/MFREiz7OkGdI2UmR+93beeZJ+vSUoPjzTiYsxg2gD8b8CZ8MAfxAc5m539G2gEsGYU2ihSmmP2yXCGiD1wN7VUFC8ZNj6CFvo16tP7qLhqwtzhDapmMGtJ8aVZj1ErnBGsUaPj6uuNfJq7Ua98RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFB8w8at; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aq3kAX8nkbuHPE3PafYDv6N/LvIBaqvSpbXV+kCTCaI=;
	b=ZFB8w8atV0LQ3tNEnjlagf1zcYpmGct+Aob4Rhn8PlwoNiLp4VVGPeC2MmDVwUhbqOOkAE
	acg6UxR/xe9HSmA0VSXLcGKOMRdPdMsgUvjLtNj//0KN+uSi5Xsq8wBCjNGI4VSvjBn3IF
	IN10hBQ5QS5XCCek1QGjehKwI4/mDYY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-Jso3eCDiOaqlcJ_0p2rViQ-1; Wed, 05 Jun 2024 04:16:27 -0400
X-MC-Unique: Jso3eCDiOaqlcJ_0p2rViQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ea91c7c801so6286941fa.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 01:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575385; x=1718180185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aq3kAX8nkbuHPE3PafYDv6N/LvIBaqvSpbXV+kCTCaI=;
        b=XUhtzxC1l3/eLNKR1ZSCGWTsGnAfNmiJerYQ0tkOfwhdv/iHEnsZ0VT/4XbAHXKLRE
         Rn7TbHygtZ0WasHpNQIDFjtyfZ0h5jIEClz+rwVlD1hetCr/hBUGcBUzMec/SnBCfaMo
         jkbOEr2wLYgoK/2rPLAZhqBlnteudqg0IoHKHwxAi0M3YkywJIKGN3XQv7F3lo1bO+08
         hFFdGnfqMuiCt+e4P276gQgecEyRX5/RvzP2LcK2f1lxh2li6lPYzvVW+5UmgwYXBI+7
         qsslSgHs7/tTMmeu8UMk4w0AyvsRwUzC4bE2uo+lK9e/ntxLwimnM2CnB0hhlHF+6Mkk
         SkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB1fkAuVb7536n/ahpKeG4/+5FM8Dqwvg7s4IJ9G2ltUFhxjnxwe9PdmVvwX4morsps0wg71j85+2k0H741iK0jJG/X3Fp8GOa
X-Gm-Message-State: AOJu0YwpVwtS5063l/Zj3WfMym5MYWeHxJRymhQKpay8In8jMzQF6vLF
	JgMYYgnLRdE8O122G3By/Epf0KiSKurlej+OBoCLEKD8sT62B9geLhoEZJbv23XnJbABMwe6x1y
	SX/uxrWQC+oUtafyKTJNjVRK7NGk4bJp3pRb2NSa7BTCQhT5g84j6NOasGg==
X-Received: by 2002:a2e:7307:0:b0:2ea:9449:7713 with SMTP id 38308e7fff4ca-2eac7775f64mr7590401fa.0.1717575385676;
        Wed, 05 Jun 2024 01:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfUtE9m1ruCD6JqFnfuBOCwZgT/GH33J2kpoHwk2yAvGJmqDf2EMoDqqUDaKApN4Naw9gsyQ==
X-Received: by 2002:a2e:7307:0:b0:2ea:9449:7713 with SMTP id 38308e7fff4ca-2eac7775f64mr7590191fa.0.1717575385284;
        Wed, 05 Jun 2024 01:16:25 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:24 -0700 (PDT)
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
Subject: [PATCH v7 09/13] PCI: Give pcim_set_mwi() its own devres callback
Date: Wed,  5 Jun 2024 10:16:01 +0200
Message-ID: <20240605081605.18769-11-pstanner@redhat.com>
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

Managing pci_set_mwi() with devres can easily be done with its own
callback, without the necessity to store any state about it in a
device-related struct.

Remove the MWI state from struct pci_devres.
Give pcim_set_mwi() a separate devres-callback.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 29 ++++++++++++++++++-----------
 drivers/pci/pci.h    |  1 -
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 936369face4b..0bafb67e1886 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -361,24 +361,34 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
 }
 EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
 
+static void __pcim_clear_mwi(void *pdev_raw)
+{
+	struct pci_dev *pdev = pdev_raw;
+
+	pci_clear_mwi(pdev);
+}
+
 /**
  * pcim_set_mwi - a device-managed pci_set_mwi()
- * @dev: the PCI device for which MWI is enabled
+ * @pdev: the PCI device for which MWI is enabled
  *
  * Managed pci_set_mwi().
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int pcim_set_mwi(struct pci_dev *dev)
+int pcim_set_mwi(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
+	int ret;
 
-	dr = find_pci_dr(dev);
-	if (!dr)
-		return -ENOMEM;
+	ret = devm_add_action(&pdev->dev, __pcim_clear_mwi, pdev);
+	if (ret != 0)
+		return ret;
+
+	ret = pci_set_mwi(pdev);
+	if (ret != 0)
+		devm_remove_action(&pdev->dev, __pcim_clear_mwi, pdev);
 
-	dr->mwi = 1;
-	return pci_set_mwi(dev);
+	return ret;
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
@@ -392,9 +402,6 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
 
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ff439dd05200..dbf6772aaaaf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -825,7 +825,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.45.0


