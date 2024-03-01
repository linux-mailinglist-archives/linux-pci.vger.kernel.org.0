Return-Path: <linux-pci+bounces-4316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2265586E05E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A580B21FA5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD536EF1D;
	Fri,  1 Mar 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRQ3SPcd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CF6EB62
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292629; cv=none; b=PdHJ3ZqtU4IEmSAS0OLfRsGSDsp7EijmWIQXuJdb/C6b7TzzdhPbVbbB0J47u9Tj0Hvc8L/DMtQ57GkR8uf3hSBfZo6/0xGGrpBi3HpnNVMxn8XN7Guefz2IVZFaCkhFsyEIiUpOSG6niMdbXoim5Fod1aMqT9EiFxopaOrTSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292629; c=relaxed/simple;
	bh=qzll3gbZTQmG4Hgqe4U2JNI8CMMEvh2buM8H3tGASRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqZP8Zg8S5P4gxX0WWRTXja6UxYjs4lAMA0PCZ/psMyml9T+aPqN5Bqyx30fnpjil+vijCqawyz28qm0WZ8cd+sNMyq6UxdIWyCzP0JM0c+v5R6UFZBKjtijCBxytMeGgG8LLdj0j7G//MMJ5SB0dLtaWkyR1rhPfqOpDWzqMX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRQ3SPcd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnDGhpR1zPECXp+96e14QkYQqiMZF4VdGZBiE6G7ho8=;
	b=NRQ3SPcdKaWsLNIQZWj0qY9a0yOM9HKRzyVSRw0lwqey0Gaijtvf/o3uvYDv0H3YWNIqVi
	79//HHImcBOUCOR6sm7PcBu0N4T6YawTXt3A4aPW5xlLBU/T2vJB67BisjxEqLosru9Kxd
	UyMulDCymhnvgYMRe3B/uNY1SgYwyUY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-6x96hPCZPIukfJCSI7Rc5w-1; Fri, 01 Mar 2024 06:30:25 -0500
X-MC-Unique: 6x96hPCZPIukfJCSI7Rc5w-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c1acda228eso477433b6e.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 03:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292625; x=1709897425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnDGhpR1zPECXp+96e14QkYQqiMZF4VdGZBiE6G7ho8=;
        b=vc3m+LlruCT7WVXcoNAr8Ja0s9r34z5BLjUL6CSR9hUGicMcuRkAcrwbHlCewQJxp7
         4w1pXD2fLl4pynU9rTrTrOkEjvlY/9FhezWGLTA+hQOSo/WCwP+a0TQa6HLGTdRE9xfg
         QYBTIZy6TpO42o34tLlW/vrY2+uozDX5OFjQn9gbL+8DTnOang/3OIVq+RyEem6xgN2R
         vPI6ozTT8c8wox8rXdAi/zAnmvzJoVvzIuSZpN2Wq+1G63GTcJMognwHe3yqL9mE9W63
         tPRZFBPW6mkhQwLKIurcGUX0McG8U73coTZfoxjWosT3HetYX7ERyI4SnxNRZt4iyoJf
         x4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU0KbTkyvrZppg/KzzC7nL3cf50MgX1NrMIqYbC5CQ1539cLA0qusKGDe4vPrsCPLu/fEaORTE1syJRwWel7JQs4uxbPF/EBPW
X-Gm-Message-State: AOJu0YxL2AqxP+FJg/WAMjvxmA9FkxZYr00FWXIRaBHkYn7WD5N6zjHD
	fGwLEH4aq8eOIrTXQvR0BSJTCRQ/KgxYopc8fcc754ID2wRGZFsCy/dCsSVvO56icNLxRlfm7B9
	TFPuOGPyKwgaaWB00GacfjmMOpzasdubAfnsVSemb+PTTU9OAkUKGKDBjuDXJt4hulA==
X-Received: by 2002:a05:6808:1a29:b0:3c1:d272:dca7 with SMTP id bk41-20020a0568081a2900b003c1d272dca7mr1735107oib.3.1709292624740;
        Fri, 01 Mar 2024 03:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7fzu12EwwD2RTKdgoVCsRW7y+HhyKLkFOutLSchbvE7Xkn+qmX80OdLOAnw7zYZwFAwXGWg==
X-Received: by 2002:a05:6808:1a29:b0:3c1:d272:dca7 with SMTP id bk41-20020a0568081a2900b003c1d272dca7mr1735086oib.3.1709292624490;
        Fri, 01 Mar 2024 03:30:24 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:24 -0800 (PST)
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
Subject: [PATCH v4 07/10] PCI: Give pcim_set_mwi() its own devres callback
Date: Fri,  1 Mar 2024 12:29:55 +0100
Message-ID: <20240301112959.21947-8-pstanner@redhat.com>
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
index 076362740791..e417bd3ea96f 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -370,24 +370,34 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
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
index 0a4220aa303e..bbe004eabcc1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -827,7 +827,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.43.0


