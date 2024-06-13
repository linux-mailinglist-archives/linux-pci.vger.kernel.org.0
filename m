Return-Path: <linux-pci+bounces-8725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B54906CE1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C881C20918
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC71459EA;
	Thu, 13 Jun 2024 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI1JMrCV"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30A1459E5
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279459; cv=none; b=i4/oPar5QCfelytGcX4543uh9jSuOJxyiSO6mTi7kUMNN/DQBfY/h8AZuvzSK4GiQq736lHikFPdThgp+OF1c8tqb+wkcrTrDmMnTmeSyxkF8tyQjTBoPVk7Wx/C+NfrUtLow8Y7K4Z/wucUAxOoTR7BcHqC77cwgk5havyx3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279459; c=relaxed/simple;
	bh=MwGxicOTdTG5eVnpyN9pPmSLSF5RFtnjndQbPoUTe1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me3ESZgrPgdzsxv/VrwbVw65RcSQpaS0tlQ0xybF/6tFPV9rDllCl5Uk7CqzMoKSxZKok7ZneM0NYiYPrdFXS1VBB9OjbIA2uXxnv58XhmJi1whVWia8AVgwTj/BqoECaznxCqofri6cYa/ft5cEhA+6P/77MCUJF5l9Hu6S8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aI1JMrCV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kh8+O2F7jgAFtGp/MUXcCP7XcWz8NnTH6l7tP4PdYbo=;
	b=aI1JMrCV0MYatILd9FSeNlnIr4oKuFgiaUndJUbTgz00JzPhN2nvfayJFWHlZp1EMGn2MW
	gFpqu5xy6l7p+erscQmlD5UV7QgcRrW1os/9G2VqNfZ0oItSh5kmBzCgqUchsN7eVL0CvT
	i1Jg/p3WESg4B6I8jdjWxfkecx5EQyY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-jrBxgQNvP6C7IzhjDfZozg-1; Thu, 13 Jun 2024 07:50:55 -0400
X-MC-Unique: jrBxgQNvP6C7IzhjDfZozg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-354dfd4971dso106186f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279454; x=1718884254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kh8+O2F7jgAFtGp/MUXcCP7XcWz8NnTH6l7tP4PdYbo=;
        b=PShWxhT1EoP60xC5JZuw4LvcGK8owR8092owmHDzqbd3CIyljgZQEGwWIuM5xwIlfH
         UBlVz4O2Jha9GXw0QKuuIvbrlqpFASeaP02c/F7rAukFtjpHOmkdZvzsLVJR7CF3Zg9A
         IF4ThIQ+4cD4b6bmkMFMCE9/XSbUugiChZLdL2F4QypW/53v2TFTbRC63DsCNwJmb8pt
         TUG4o108EBqj0YmVWbTOZRsXblSp9uU6E7UhGUbcU2i+JNkRUzXasRXoTHsdXkGdRMWq
         yfDb4xoMwINjbQ2A6hDRTzzta6cZOYbCjJSn7+cSczCQtI1KqSwM5tIN0tzoFiQ6vfEm
         PPDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGmadJhlR+jpYLOjVq143pZYWtA5OvedHEEsHG6eEgKQbWC+iUQbxmg2VYYcHRLhZXfojEQzAnsUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpmmT/NUkW8bZ+MHnJg1V8pI9vw7lbYTL4pW2+Ie3ohxjTb1FF
	zX5zbdHY5FyfTIJT47PCXZaYQ0GiUgWqLzv9hUphe3tFJE5CsQUgiCIF7DOz3Ocpp7rsjsULw+r
	6P0k4TcwInWJxcWySwPnSv2kem7aEuHcXJEQsbtVKR8S0DolUYowsubnRaw==
X-Received: by 2002:a5d:5f93:0:b0:360:6f5c:f5b3 with SMTP id ffacd0b85a97d-36079a6be34mr198403f8f.7.1718279454626;
        Thu, 13 Jun 2024 04:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWMTtngZAgGMBECTjwydMRwQNlXRtCSyH8PxV40YfOhooXvc8s+2rU6f0CqUMNMS0veU1KZA==
X-Received: by 2002:a5d:5f93:0:b0:360:6f5c:f5b3 with SMTP id ffacd0b85a97d-36079a6be34mr198391f8f.7.1718279454381;
        Thu, 13 Jun 2024 04:50:54 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:54 -0700 (PDT)
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
Subject: [PATCH v9 09/13] PCI: Give pcim_set_mwi() its own devres callback
Date: Thu, 13 Jun 2024 13:50:22 +0200
Message-ID: <20240613115032.29098-10-pstanner@redhat.com>
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
index 84caa0034813..e8de93e95eb6 100644
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


