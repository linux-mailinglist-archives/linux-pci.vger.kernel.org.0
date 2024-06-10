Return-Path: <linux-pci+bounces-8522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60841901E56
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105A228306A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B37EEFF;
	Mon, 10 Jun 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8MkPIIu"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB117CF16
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011936; cv=none; b=Q9vFbazeHGQ99PBckU8t/U5W/C18iYqsAFA6FvC0NG+HX1eigaEcF+GzrfotNF83hLnCp6ubov2rfsaluoPkQm/GJ32PApwdqAcct/tYrKuw/eV1w4yUUQs/zrHk1sSPMlU6SiKWCtaKo+JBzTK3WU0kkHB/CqcjQuI2T999ASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011936; c=relaxed/simple;
	bh=nOn0DRXnO8oQWYZd4giX2BtFyTmcsIi2D+kKy3al+uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryIPzzcgfKSA2fTwCEhNq70gPkEZW9jptzYGyi5bmGbcujoJ4LaCmlVkRADXwYFHdaPSqGW7PZgdj/bDgehYm6yNVC+VQUwx/3J/WeslUgjo5Cu3W9ZoYEG/O8zLJaxTNVTic6XJsPQek1y+DulDFwCgoPb7Wl+bIjktlUVntuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8MkPIIu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0E+yd/NqAYSK8WFgRSEHpHq5LwGzPXxKeB5ucvUWBek=;
	b=h8MkPIIuDUM7rMp9DJp1nHI9rfTryGF7Fdl4/syfujPrcahQFHlIdyYy0wf5RiezbTBRyc
	ZEHLP8Lhd9g8z3g4/T21cI0811G3fhXEbXn4eb60aqkmsukqVibXA8C+iqaYpd7WkluXas
	oUq1UFRR59/eYXxIRv7gltSCvsp2B2M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-pwW93rxpObO3oisRAjGh5w-1; Mon, 10 Jun 2024 05:32:10 -0400
X-MC-Unique: pwW93rxpObO3oisRAjGh5w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4211239ed3dso5276895e9.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011929; x=1718616729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0E+yd/NqAYSK8WFgRSEHpHq5LwGzPXxKeB5ucvUWBek=;
        b=qXVO8CzMNgMhCIyez0MsRMgzYhAObPDgRKVXRMWdw1LdB66DCgPtTTXW+bSSAGogHJ
         7U1Ej8Yjv2Am73F/OjxIt8c3Sh7wjgOvKLbJSVfKQh+HON4c7qkLR83X8ohsCv50+IHf
         WL3A9Lj8MA1D84fEpNmsRntjxfIXhrzvPrZ2o+6qHbIwU83YQs+WTlRKBl4TpHbcOp38
         Gilqtk3c+cHgaiXija2s1QSJi1UU/eLfLsVCYMt4phZmn3CoJpS9IFUeqR+0nQhr0QJI
         XPKOMpBHD5rN6lC01DIredural8UbeSXUj5hhJI06V725jCuFIQvIeoOotduTKEXNAVz
         4bCA==
X-Forwarded-Encrypted: i=1; AJvYcCWorsEwOsXYAn4bR72sOfUac8d5lwNrhcVRaEuL/NKayzMaWMbnDZzX8uggLx8buuUnJ/5u59fxX3guwqLmUY/QqDsQgr2P0nWe
X-Gm-Message-State: AOJu0Ywx8Aawxbp89nQ2XNDsp/VXPPfktWjHq3+rREBvYAKut37IIzQF
	T+/z6t22Q6mfLQNrxiLpP+yMSYcvvTubKARtudxfvxO8Mb80SeJV2Q2stC7UNIIG9zwJ/m7d2ZF
	q23BozRI8Q7wuhoc11vlepi9oYBA8YJXaFbY0Vw/03MuUc9cVHy35p4+46Q==
X-Received: by 2002:a5d:464b:0:b0:35f:247e:fbcb with SMTP id ffacd0b85a97d-35f247efda6mr1269301f8f.2.1718011928888;
        Mon, 10 Jun 2024 02:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrZxYD3HEuC5SQMDdGziGt7mw/V9beP3O+PtWTxv0mACsmhdqWKMeo5TR1WqKS8I+N5uEZTw==
X-Received: by 2002:a5d:464b:0:b0:35f:247e:fbcb with SMTP id ffacd0b85a97d-35f247efda6mr1269289f8f.2.1718011928640;
        Mon, 10 Jun 2024 02:32:08 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:08 -0700 (PDT)
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
Subject: [PATCH v8 09/13] PCI: Give pcim_set_mwi() its own devres callback
Date: Mon, 10 Jun 2024 11:31:31 +0200
Message-ID: <20240610093149.20640-10-pstanner@redhat.com>
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
index 2696baef5c2c..a0a59338cd92 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -366,24 +366,34 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
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
 
@@ -397,9 +407,6 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
 
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e02ba1b5947..c355bb6a698d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,7 +823,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.45.0


