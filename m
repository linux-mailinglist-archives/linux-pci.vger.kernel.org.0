Return-Path: <linux-pci+bounces-3153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF084B6B5
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 14:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2317B1C244F7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78581332A6;
	Tue,  6 Feb 2024 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE53OMJe"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D78133291
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226857; cv=none; b=bnDwQ3CdCxnMpHBz8SOlDlk8doio8bIl+v1jKbbGmqQAD6oIPjoN3GQIO4Ca/98kApOAdBrbwKXAQra3Nt8nSwJifeK6pRc6pu0/mFlbl/PMTajmNd8pF7a3//H5Yz+pl6HpTkVhHWcjASCQL0LDHG9umfldp8ca10V+rTxaGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226857; c=relaxed/simple;
	bh=ZJ83zn6ztPV2uljoE1yZ3KKMxpJLVe/lGJ8ZusJAz8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3S1zIii3viDQU1e+rznGH6ztQNyKgq8UTGjxDpS3genQ3E2LSvGFJAacQXqbCkkk4ADTfHC2ygeweUnqoi54cWzLMIFQ4k5asZJqmKATDck5YPJejc+4SpBIN+WV4rbK74KQB6uMjkFSt8/NxrPZCg52rliMNI7EKyQ83XBfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eE53OMJe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Jh3czCqQDL/0c9zpNumpr/ueC3CRmD2SdHwNhVsws4=;
	b=eE53OMJe56dGsttNsUK5jiU0vsFV1KAzuEKC820woQQvTkylVB8LYfNBk2v27qLHf21baH
	wQ7xcWTPG4qCYAaFfTYuZNKbsy1C1wQoExFfN5MEFZfc/EDxf4aZh01LDgGmLc23h1Wj6v
	W+r/lHqfvmaLu0W4SAQhM6mC0luWG6c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-dx_Gd4WKNxuA2TkJDB11Bw-1; Tue, 06 Feb 2024 08:40:53 -0500
X-MC-Unique: dx_Gd4WKNxuA2TkJDB11Bw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78543d8dfd6so47977585a.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 05:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226853; x=1707831653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Jh3czCqQDL/0c9zpNumpr/ueC3CRmD2SdHwNhVsws4=;
        b=qIeudMs5Wxe7yaMEEPHL1qfM5a6grAAYmUGJbqXnhaKEIsUoPHqA4LLXMJjEVOMl0A
         YOt2YEX1d//R7D1+gyHzhWvbj421egxYWPrGini07LRPv4EhfB1btFDBHN7PJOmWDNLe
         4vB8TomRHjqJxp97hKzfP0wLuPaHQ7auUwGY5au23ZjZKyFRXzyzspRb8KnqHHizW6r9
         kOnAfk3sCiO7RjhoX1EDEnejzbW8Jd6EKsGHntvt42OHptbOo0oWc6+AHryvbdxFCMjh
         gLYf+LXRQbx15liDqh1OtjVQXg16RdnIyE/qX/qOy/2eSqjzH27cU/ksKhBUfZ2UhV0n
         IyDQ==
X-Gm-Message-State: AOJu0YyY+YhkovWx7/Hs8OXx4LuWhECDFNS6qVz1WSNNXTuSU8RPuhzM
	mPX/MroAYbV4x5/rdw2FEo2AdK4ZJrmezHtByvPa8+HH9ozjCrG2uK+OC6jGkYeUkhW6CgnXLlW
	jZDoSWDtzK4pJKxZnD2QXb6HKXXsB/vKS0RsgY6XkNlxBJJkVNsC1fBHgPA==
X-Received: by 2002:a05:620a:2994:b0:785:9219:4a43 with SMTP id r20-20020a05620a299400b0078592194a43mr1160659qkp.0.1707226852820;
        Tue, 06 Feb 2024 05:40:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE9KH3fko9/sK6cZhYyiOhj8EB67hwhvDraP4KKWzQNjKyJ1FE/oE2fiTpP6cQw1s3TpI8Xw==
X-Received: by 2002:a05:620a:2994:b0:785:9219:4a43 with SMTP id r20-20020a05620a299400b0078592194a43mr1160636qkp.0.1707226852504;
        Tue, 06 Feb 2024 05:40:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW58JBDBApNpqJsWEGCS9AfiEEgz4FYsMiw9RHIh8YS/o9y6CqyWUT3O0cCIrUkSvFFUTQgZw1aVSiGh8XUhat01vzCYbg01AKfA10KZLd50xCK/Fq4/uHWExw1Icq69Uz1Rsj2+FVDflE2P0HSGB48AvdOkNI6pK9/nCjj6u3bqGTWn+O8KjXMg6GtsC+r/bGA4RU922mfLClydAUH4va1s68jaLPWHonU3ih72UOFT/68qUdEvY/20hduKvq8QlHmB61tb1uOkQgC2wkYn1MJ8c2J+J7+Hd2LDBVbK9Sbi4J5O+hDLOcPnCNfZgjqh5rdatXyTd9D46UCB1K9Q1DlJBQj057kHVr0cCMSNkjIJETYrWdPzCDxHia1ifDUr/okJMlD
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:52 -0800 (PST)
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
Subject: [PATCH v3 08/10] PCI: Give pci(m)_intx its own devres callback
Date: Tue,  6 Feb 2024 14:39:54 +0100
Message-ID: <20240206134000.23561-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206134000.23561-2-pstanner@redhat.com>
References: <20240206134000.23561-2-pstanner@redhat.com>
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
removing further large parts of the legacy pci-devres implementation.

As in the region-request-functions, pci_intx() has to call into its
managed counterpart for backwards compatibility.

As pci_intx() is an outdated function, pcim_intx() shall not be made
visible to other drivers via a public API.

Implement pcim_intx() with its own device resource.
Make pci_intx() call pcim_intx() in the managed case.
Remove the struct pci_devres from pci.h.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 76 ++++++++++++++++++++++++++++++++++----------
 drivers/pci/pci.c    | 24 +++++++-------
 drivers/pci/pci.h    | 21 +++---------
 3 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 89d2d6341b19..8a643f15140a 100644
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
@@ -401,31 +406,70 @@ int pcim_set_mwi(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
+static void pcim_intx_restore(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcim_intx_devres *res = data;
 
-static void pcim_release(struct device *gendev, void *res)
+	pci_intx(pdev, res->orig_intx);
+}
+
+static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pci_devres *this = res;
+	struct pcim_intx_devres *res;
 
-	if (this->restore_intx)
-		pci_intx(dev, this->orig_intx);
+	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
+	if (res)
+		return res;
 
-	if (!dev->pinned)
-		pci_disable_device(dev);
+	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
+	if (res)
+		devres_add(dev, res);
+
+	return res;
 }
 
-/*
- * TODO:
- * Once the last four callers in pci.c are ported, this function here needs to
- * be made static again.
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
-EXPORT_SYMBOL(find_pci_dr);
 
 static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a6b5140fc6f6..fe8cbf9be0fc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3939,7 +3939,7 @@ EXPORT_SYMBOL_GPL(pci_common_swizzle);
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
 	/*
-	 * This is done for backwards compatibility, because the old pci-devres
+	 * This is done for backwards compatibility, because the old PCI devres
 	 * API had a mode in which the function became managed if it had been
 	 * enabled with pcim_enable_device() instead of pci_enable_device().
 	 */
@@ -4527,11 +4527,22 @@ void pci_disable_parity(struct pci_dev *dev)
  * This is a "hybrid" function: Its normally unmanaged, but becomes managed
  * when pcim_enable_device() has been called in advance.
  * This hybrid feature is DEPRECATED!
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
@@ -4539,17 +4550,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
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
index eaec3b207908..ee8d38bf3f9e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -798,24 +798,11 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 #endif
 
 /*
- * TODO:
- * The following two components wouldn't need to be here if they weren't used at
- * four last places in pci.c
- * Port or move these functions to devres.c and then remove the
- * pci_devres-components from this header file here.
+ * This is a helper that shall only ever be called by pci_intx(). It helps
+ * cleaning up the PCI devres API in which pci_intx() became a managed function
+ * under certain conditions.
  */
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
- */
-struct pci_devres {
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
-};
-
-struct pci_devres *find_pci_dr(struct pci_dev *pdev);
+int pcim_intx(struct pci_dev *dev, int enable);
 
 /*
  * Config Address for PCI Configuration Mechanism #1
-- 
2.43.0


