Return-Path: <linux-pci+bounces-5867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C7F89BAA4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811BBB228AC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4103A1D3;
	Mon,  8 Apr 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVN6U0Gg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716564C631
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565887; cv=none; b=Yb75o7/P77i4r9zHtsFR2aQw9ZC5cr3ssmcTpUPuyLOqPwHtapksflfGGV7gASl4pMZWNie8gUQEzGFFtVPRuBORG5aeIB9IF0WKdbxchad0QL3stJh8Zjl0kjW/zeoYJwbm8ebzhOhR7t9ZgRthZhbof+27hjWZ0j+bUN65KoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565887; c=relaxed/simple;
	bh=jtMfRJzrGj6Hya59/CapvknY9OFyyO9+qwkwlnNChyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfFPZ+a4Jb/dHhhzbIToEB1RkkLFS0kN61l5OSn0v6OTJFjpQr7DH6Oe6YDYQMO1fdNNNT0/OQDa6/n55XFu7W1RvR81yVmFxR9b9BKg5BpmzJvU3H/3N1CC+tQkGEdaeszuwqxm+eZRxCO4yLaSesOQFMKQmhW6U6KmPHF825s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVN6U0Gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQbNzzWRGbAMJ/ZvXVtvXB/7D5Q8r5XT3mcCvFUlfNA=;
	b=YVN6U0Ggsr2srExWLrgjbzZxG0LHofCGu2j8R7Mni2x0bGFIdE/DWJBUBL8Tu3zfw6f1rT
	8/7PmClJS7JvsJicOKZ/+U1tnGHAsRJsQXsiJDJvg9+jvnd0t25ksN3kNWSP4fqbgUu+yC
	ui4y+jRIn7CUNW+nbUN7wXkYrCClKGs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-LE8G0EB5MSCm-kY9RCLplA-1; Mon, 08 Apr 2024 04:44:44 -0400
X-MC-Unique: LE8G0EB5MSCm-kY9RCLplA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78d670996e4so2636485a.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 01:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565884; x=1713170684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQbNzzWRGbAMJ/ZvXVtvXB/7D5Q8r5XT3mcCvFUlfNA=;
        b=nYdwLx7aznHG1zXsEK9IpAbdip0vKSxjfjMIBstWzmolb3u1xAJ4ZlqUsi3DQZZNkC
         g4rgPppiKvIbROya+YWxyyfNEAukDWUxQgOA83PA5nFaSTC0vLUVmF6CbSIJn3bn7RAc
         vIwhhemakTjeWNo2swYwRSOoKIuV/vbbUMroHgLxa2M8GJcqNoWZnbEPexKUxc4HbQac
         NZQocAdJMuBjcaoc4LV9aOVSZopJniPDHHKbMmYXoOSwwlhFqEMuSuaL7aJFdhueK1XP
         4NzJGViEVXacznwWZAS2W/2xnFaEZtI4gYSBPr0CU645i/wzhdpDT0USu9i1Z1ColhBn
         wR2w==
X-Forwarded-Encrypted: i=1; AJvYcCXgZeuHAGXz3kZX/qQd90AxfpVXuvZyKpEiXBAe7HELPfWOtpQNHHO9s3+JUHbpPD7O+IVnjVgqm9FYzF884/EJypeuCdl+iunM
X-Gm-Message-State: AOJu0YzlkhCc/PrfSFW9+n/4x9aq2f8GGZkLkfWkaRBkNx02qjsmwoZc
	HnBkqoZE0ZogMdAdOqE/ArA3UhjRgyvqf8iAVbiNik4xy6EOpuFMIQrsCUHAL2usrVNPz3+3Lbo
	H1c1LXlN9yrOOUqIFqsJjHYAsrv/MytkKmHdf6Gr7rG6mYvpr/0VpcEK7tA==
X-Received: by 2002:a05:620a:19a9:b0:78d:6439:127d with SMTP id bm41-20020a05620a19a900b0078d6439127dmr3282075qkb.0.1712565883918;
        Mon, 08 Apr 2024 01:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0qa1JgWscwtLKGJLtJEsFGCHRLEHSbkg6kELrSv9oOSNF02qqh4zCKM10yPLZo0wFlJ4eGw==
X-Received: by 2002:a05:620a:19a9:b0:78d:6439:127d with SMTP id bm41-20020a05620a19a900b0078d6439127dmr3282068qkb.0.1712565883582;
        Mon, 08 Apr 2024 01:44:43 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:43 -0700 (PDT)
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
Subject: [PATCH v6 07/10] PCI: Give pcim_set_mwi() its own devres callback
Date: Mon,  8 Apr 2024 10:44:19 +0200
Message-ID: <20240408084423.6697-8-pstanner@redhat.com>
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
index fb9e4ab6bcfe..e257c212cd9c 100644
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
index a080efd69e85..c98de280b16e 100644
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
2.44.0


