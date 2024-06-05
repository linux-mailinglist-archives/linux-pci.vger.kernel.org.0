Return-Path: <linux-pci+bounces-8298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9758FC5EA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685741C22713
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA0193066;
	Wed,  5 Jun 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbtRy5Z6"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D58191491
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575392; cv=none; b=RmPhHUJzSNMab7FJXEMkzltcVVo7tATqGW8HWviVSftCX5Tq4f8pZ+JEb7+Bwn9jTW2PRYpMwaJMhlaSVBPK/2KC4+Fji06V9dICXG4sLC/lESTW/2VMol/OcTiw932QinG1xfQf2cTVxZ/RZtmv3joxnPzVFarL5MGN5PIVZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575392; c=relaxed/simple;
	bh=GTeBpuYLIPwI5Fq4sasuRQzg6LJKBh8wPFCl/+rcDMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEAfDHNK14P5r5R84Fu0bEIbDXRbzwEL1/XvzQ1zkL+CvpMBWUCRwj2hM35UuzTdBBN6jRsia6vr+cQ69lVFz2Fmq9uclEaGBeX08kFOMm5Jl7BJoCxaqN7Qvl6cB7gk7HLI9Ze1OKU+mTLR+amvc2kl/Tq5L9HUHNYCV7a5j4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbtRy5Z6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BD+Ne3TkytD/xWKk8A40YJpqJowHiHm8wUBRIwRMhbs=;
	b=GbtRy5Z6HII4WyCpxFySLUy6ScOx9RqtOwHHhWYguhmyd/PnskBHf4NpKZZ/bwz3I63NLP
	DfNwJZRVOyuXt5t1fPPcjj2Mac6o0x7TSy1r1RZMD9qooFIwvJfcNENi2whbGAr8ZlnWRx
	YxmzAFpLyKdCPKX32nITa0kW4ulKrAI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-3WanoiuEP06JJaXkEc-org-1; Wed, 05 Jun 2024 04:16:28 -0400
X-MC-Unique: 3WanoiuEP06JJaXkEc-org-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35e0f2512ddso240540f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 01:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575387; x=1718180187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD+Ne3TkytD/xWKk8A40YJpqJowHiHm8wUBRIwRMhbs=;
        b=NpbcLOFw2QcubReq9OnfXTaNpE4/p6XQ2T6eYuLzMmkZypzHMViyMr62nXN05jpLDg
         xB/g45V8Zz/GJh32nFUE1Xr2q5bOzGJlBrwpA9B7VhyIPpqddaf7r3WCBKF+hUjBOfpu
         RRw56h2vB5SCbIyspsmUzvjRH0uOuVtq69cCLanw1yKvW00yfoe1N7QIBSb9iSBi1dJb
         BM7jxT+VwGgI6zWULXPUBqhtrGJ5OJddpTIMssd402Npu8kNFpc3etqIZk1t0CTpEpAA
         F1j+LyO4yQN4hQSbAgIwLvammZ1uz8w76Bln46ae2obLNowjj8YW9bG/jSw44rtwnSdL
         oREQ==
X-Forwarded-Encrypted: i=1; AJvYcCVli1qftMdMUB+2KBpu0aOORtqd3oRP5wjrI/ZF80Bbes/aDIgPGlQ5ARikudkUSc3G8rlm+2Ywlb1cGN1CIPfvBeCj1B0xJ/KA
X-Gm-Message-State: AOJu0Yz2WEEeUGsDjZkjpuPiPFQ10TE3IVOr3L0jx7eLjnxj9cu5b2tu
	wRJ5TE6vQOljfbZW9uBEIVG3fE6MR+Bo+yUMAphB0lRb4M4AemE9qC/Bu2Ta+9kz2PW4z3eTse5
	eQyF5SAkcHZSVdXZksnXlpr1eFSGcYVu0R3js4r+0E6fZvhFVr3gG97AaGw==
X-Received: by 2002:a5d:456d:0:b0:35d:cf2b:9105 with SMTP id ffacd0b85a97d-35e8ef90f08mr1063107f8f.6.1717575386874;
        Wed, 05 Jun 2024 01:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPnmKKMbioEu3OTnfk3Olk/HS1ljC/0uD3ilJbavzKouLbvntLOj9vIGtcz/0ZnPMjStdobg==
X-Received: by 2002:a5d:456d:0:b0:35d:cf2b:9105 with SMTP id ffacd0b85a97d-35e8ef90f08mr1063089f8f.6.1717575386552;
        Wed, 05 Jun 2024 01:16:26 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:25 -0700 (PDT)
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
Subject: [PATCH v7 10/13] PCI: Give pci(m)_intx its own devres callback
Date: Wed,  5 Jun 2024 10:16:02 +0200
Message-ID: <20240605081605.18769-12-pstanner@redhat.com>
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

pci_intx() is one of the functions that have "hybrid mode" (i.e.,
sometimes managed, sometimes not). Providing a separate pcim_intx()
function with its own device resource and cleanup callback allows for
removing further large parts of the legacy PCI devres implementation.

As in the region-request-functions, pci_intx() has to call into its
managed counterpart for backwards compatibility.

As pci_intx() is an outdated function, pcim_intx() shall not be made
visible to drivers via a public API.

Implement pcim_intx() with its own device resource.
Make pci_intx() call pcim_intx() in the managed case.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 76 ++++++++++++++++++++++++++++++++++++--------
 drivers/pci/pci.c    | 23 ++++++++------
 drivers/pci/pci.h    |  7 ++--
 3 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 0bafb67e1886..9a997de280df 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -40,6 +40,11 @@ struct pcim_iomap_devres {
 	void __iomem *table[PCI_STD_NUM_BARS];
 };
 
+/* Used to restore the old intx state on driver detach. */
+struct pcim_intx_devres {
+	int orig_intx;
+};
+
 enum pcim_addr_devres_type {
 	/* Default initializer. */
 	PCIM_ADDR_DEVRES_TYPE_INVALID,
@@ -392,32 +397,75 @@ int pcim_set_mwi(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
+
 static inline bool mask_contains_bar(int mask, int bar)
 {
 	return mask & BIT(bar);
 }
 
-static void pcim_release(struct device *gendev, void *res)
+static void pcim_intx_restore(struct device *dev, void *data)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pci_devres *this = res;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcim_intx_devres *res = data;
 
-	if (this->restore_intx)
-		pci_intx(dev, this->orig_intx);
+	pci_intx(pdev, res->orig_intx);
+}
 
-	if (!dev->pinned)
-		pci_disable_device(dev);
+static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
+{
+	struct pcim_intx_devres *res;
+
+	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
+	if (res)
+		return res;
+
+	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
+	if (res)
+		devres_add(dev, res);
+
+	return res;
 }
 
-/*
- * TODO: After the last four callers in pci.c are ported, find_pci_dr()
- * needs to be made static again.
+/**
+ * pcim_intx - managed pci_intx()
+ * @pdev: the PCI device to operate on
+ * @enable: boolean: whether to enable or disable PCI INTx
+ *
+ * Returns: 0 on success, -ENOMEM on error.
+ *
+ * Enables/disables PCI INTx for device @pdev.
+ * Restores the original state on driver detach.
  */
-struct pci_devres *find_pci_dr(struct pci_dev *pdev)
+int pcim_intx(struct pci_dev *pdev, int enable)
 {
-	if (pci_is_managed(pdev))
-		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	return NULL;
+	u16 pci_command, new;
+	struct pcim_intx_devres *res;
+
+	res = get_or_create_intx_devres(&pdev->dev);
+	if (!res)
+		return -ENOMEM;
+
+	res->orig_intx = !enable;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+
+	if (enable)
+		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new != pci_command)
+		pci_write_config_word(pdev, PCI_COMMAND, new);
+
+	return 0;
+}
+
+static void pcim_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = to_pci_dev(gendev);
+
+	if (!dev->pinned)
+		pci_disable_device(dev);
 }
 
 static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 04accdfab7ce..de58e77f0ee0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4444,11 +4444,23 @@ void pci_disable_parity(struct pci_dev *dev)
  * This is a "hybrid" function: It's normally unmanaged, but becomes managed
  * when pcim_enable_device() has been called in advance. This hybrid feature is
  * DEPRECATED!
+ *
+ * Use pcim_intx() if you need a managed version.
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
 	u16 pci_command, new;
 
+	/*
+	 * This is done for backwards compatibility, because the old PCI devres
+	 * API had a mode in which this function became managed if the dev had
+	 * been enabled with pcim_enable_device() instead of pci_enable_device().
+	 */
+	if (pci_is_managed(pdev)) {
+		WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
+		return;
+	}
+
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
 
 	if (enable)
@@ -4456,17 +4468,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
 	else
 		new = pci_command | PCI_COMMAND_INTX_DISABLE;
 
-	if (new != pci_command) {
-		struct pci_devres *dr;
-
+	if (new != pci_command)
 		pci_write_config_word(pdev, PCI_COMMAND, new);
-
-		dr = find_pci_dr(pdev);
-		if (dr && !dr->restore_intx) {
-			dr->restore_intx = 1;
-			dr->orig_intx = !enable;
-		}
-	}
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index dbf6772aaaaf..3aa57cd8b3e5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,11 +823,14 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
+	/*
+	 * TODO:
+	 * This struct is now surplus. Remove it by refactoring pci/devres.c
+	 */
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
+int pcim_intx(struct pci_dev *dev, int enable);
 
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar, const char *name);
-- 
2.45.0


