Return-Path: <linux-pci+bounces-8728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9408906CEA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1842835EA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02387145A14;
	Thu, 13 Jun 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWlAy/pe"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B7149011
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279462; cv=none; b=Y6g0+xozB58VeitySD28VnoseO715OmHUH/d6V1HoK7KCgJdGK2ff9MSPFEWdamlnokPP46yBJoQMzd4Th6klEsJpRRQJrGaWG4v0cHFru8spkVojDrXJ/bW6g+uTypLvnNUatVCtbHE0hkSR2FUUNSmPKBQsF0TbrpkorYAYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279462; c=relaxed/simple;
	bh=mgYu+PdBk2Uxe11LPVB6MI3T1q9XfYavbWG7yJM+v24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeJ/KyjjjHVmW1u+g6joE6hnr9rDvSiR7AsTXPOQ4YxDkY9ToqJi7m0XHHglpJiN//zAZ24myKcjCtVn8wtqFC421FY7Bz97PDqxDSPdo0n2BXrXUSIGkR9BcEqxFEt/qMhx64N6H1GoVkbZV7rwk0awiBuN1T3ozRkdA0kKrtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWlAy/pe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXtJP09mnY/VoBFabkO3D30y5UZGrDuagfM4gYTmfUM=;
	b=bWlAy/peIAtgXU0jJ6x2w36K00YFLpILrChPW47Mx7uOGGTQoPs0Mkdrl0R4CTEauTQmhu
	sNMgfHOlsDIMK4Je26yc9ja6zClvvRBVOMcKH/mlAL8rjbnfRw9/FSF3RTbRE99TUrVSQ6
	QH851d/rfGoYtw6gv77QP0WBe5ZKnn0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-Byc60YzEP8q7kuk2auIaOQ-1; Thu, 13 Jun 2024 07:50:56 -0400
X-MC-Unique: Byc60YzEP8q7kuk2auIaOQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42183fdb22bso1602495e9.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279456; x=1718884256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXtJP09mnY/VoBFabkO3D30y5UZGrDuagfM4gYTmfUM=;
        b=C38djLX0ijrna8i0NfMUQcih+M0sY3eP1PsssciegHdnsNwD28XXAxc/44b8I+sM5T
         XLd/9iwvsy1A3r3mOH17P0HlgPHvwzOK4pqu63jTm4EPQ2+2HvsJPT99qVedZYFxDbFk
         O3BSTyfqMdAFIpk3OoW9a6RZtui+Z06KpeZiu4QlTj5VwqCC0A2izbO+fTxftZRPgUpU
         uqb2L/pTXflbIanIEKhbZRET+/o1mlSmpXq8/E1EFJ27kfjlcet2nc35IIQ6d5YpWDP7
         NlPkFA2X2RNJ9A7xQVKf29YwtYt99CYp81R0GZWQJca5H/0MAZFGg9nG3fTGNfZOYBPS
         GIzA==
X-Forwarded-Encrypted: i=1; AJvYcCWFFH55hKmFVl9DPV8hmvvYTzrp1BpsNmF7hlvWjiEO1TX/PnpDdDQ2wkQKgXjJhvtEHqI9Xn5VkzYMwQc47WDoc3Y9IhQ/8t0U
X-Gm-Message-State: AOJu0Yw/t3MKt7IKu2w6tRP5MlxMONgPqb+RR05DbGqFIq/1YcBIT+9I
	gGUpFjLhS8J5LtmQpD61uepd3xv6uD8uTeV8Pd7sah6+2T/foO2pdwDwA4J/UW1mNMrqCQh3OJP
	0u0qlNPY8ft0R1UKd+BYOBQx2EWi0u0WRmi68SU90Nyq8hRd4yYsXD03PEw==
X-Received: by 2002:a05:6000:1aca:b0:35f:305d:d2c8 with SMTP id ffacd0b85a97d-36079a4c065mr196888f8f.3.1718279455710;
        Thu, 13 Jun 2024 04:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg6sk3xnm8Dx/Hnr1TCgUs2mRnf7/ulhG/8nI0xWi/V2RpnZJUye6zcNtI5u+FrxW/ybB/fw==
X-Received: by 2002:a05:6000:1aca:b0:35f:305d:d2c8 with SMTP id ffacd0b85a97d-36079a4c065mr196879f8f.3.1718279455407;
        Thu, 13 Jun 2024 04:50:55 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:55 -0700 (PDT)
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
Subject: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
Date: Thu, 13 Jun 2024 13:50:23 +0200
Message-ID: <20240613115032.29098-11-pstanner@redhat.com>
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
Remove the now surplus function find_pci_dr().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 76 ++++++++++++++++++++++++++++++++++++--------
 drivers/pci/pci.c    | 21 ++++++------
 drivers/pci/pci.h    | 13 ++++----
 3 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index e8de93e95eb6..7b72c952a9e5 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -42,6 +42,11 @@ struct pcim_iomap_devres {
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
@@ -397,32 +402,75 @@ int pcim_set_mwi(struct pci_dev *pdev)
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
 
-	if (pci_is_enabled(dev) && !dev->pinned)
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
+	if (pci_is_enabled(dev) && !dev->pinned)
+		pci_disable_device(dev);
 }
 
 static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index db2cc48f3d63..1b4832a60047 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4443,6 +4443,16 @@ void pci_intx(struct pci_dev *pdev, int enable)
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
@@ -4450,17 +4460,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
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
index c355bb6a698d..9e87528f1157 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -816,16 +816,17 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * there's no need to track it separately.  pci_devres is initialized
  * when a device is enabled using managed PCI device enable interface.
  *
- * TODO: Struct pci_devres and find_pci_dr() only need to be here because
- * they're used in pci.c.  Port or move these functions to devres.c and
- * then remove them from here.
+ * TODO: Struct pci_devres only needs to be here because they're used in pci.c.
+ * Port or move these functions to devres.c and then remove them from here.
  */
 struct pci_devres {
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
+	/*
+	 * TODO:
+	 * This struct is now surplus. Remove it by refactoring pci/devres.c
+	 */
 };
 
-struct pci_devres *find_pci_dr(struct pci_dev *pdev);
+int pcim_intx(struct pci_dev *dev, int enable);
 
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar, const char *name);
-- 
2.45.0


