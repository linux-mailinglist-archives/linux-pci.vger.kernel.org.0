Return-Path: <linux-pci+bounces-43525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE9CD6294
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 14:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AE273001BB0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 13:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ED12D0C7F;
	Mon, 22 Dec 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChlFlhhn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DAB221546
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410169; cv=none; b=PeEKyewsn8T9Sp5R+fe5cLn0JbuZzfLANHqfykXKiblHqZpTElp7g7RR/WGcs3n9hZY93rqKcWb6Vf/W0wvseTBWWvzfFjeYqVQmSUuRDQ9xn7SNBSZLbZq/vfk0fNj1kMcnvn65CjNIt7EXKTAJGpkVBT2ucs/jzGJDwg5q3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410169; c=relaxed/simple;
	bh=H0+geXmxWC0pdqoFC0O11lIndm4fk+WN8y7JXX9OLvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkikmHCF3+99h9Soo5ZofaIZ1v8mV22ts+zOKmQxs3bJC7lrhY/T1uF6846vYutByPzxU+SheTQinSVFH4bqeBkClD6sFEnG+w0me5sT54iZW1bUZWAmxh0THCRYb1oJ41CNRRinC6bCy1/nD8YWj/Jg7U8PF2w3I4LRr6GMOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChlFlhhn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-594270ec7f9so4633415e87.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 05:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766410166; x=1767014966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bu+q7q+c7ZMv4WCo6U9gSylXco4r4YFmmYOVsykIHI=;
        b=ChlFlhhnh/aDhAsjlbza8k9tjuBTBw6iCxzhQ/vn/U7ySz9gqd7AuNsaUy5rIo42u2
         KShnaAJhPQnDeJLahBl3OL97gLqR1BdHAVBDZRDCa7YSpc+0AZkYRt1y5BTGxqwfUMH0
         WpRaYUUR+FDWdjnJFx79tUjSRzwkgcl2PEuarNWdSHRAh8VUig4a3NN4SPnSifLbgFmU
         fMGI3PfLXriiBmVm/C9aam8wbWDHJPv/tr2GGqChbhRLWZv5Yvh4/FJ7LICQ/6RDYnRt
         lQPVoneI8k+RWNR8HAGUXDltu9ycpGdlZOgK08Wk0TJTBQePrprZBxvaqTNvrIHFjAfm
         Mljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766410166; x=1767014966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bu+q7q+c7ZMv4WCo6U9gSylXco4r4YFmmYOVsykIHI=;
        b=hj1P1Ye77lAwnfspvoxA4AXCWuK6uPVqHV5nU13zNDpoHvfJT58fyKjOGVoXm9xpVI
         MhNDuWhojnpbUPKCOa0eoFXi08BCUKRSHNJbOfYnCt4GoEZXQbCDs4GE0Dg9Gkg94xXX
         1sgHBjB75jEdJbFEvM6xf3imUrw2suCkNYyDMLDcq0lJJRRjCTxZyajXUmFGseksNsry
         lgxuafbL4OQtEWoJl21AIRShyyqlYrhnuoWgFHzrigoTEAvjNYT9Q8wd8LJt8KgVPKmK
         cxIVh/ha2HAPwmVY0xDgcTC/oXAeMDpJQo2bJwKyKLIzoVKHJivhOnTIGVz45lzsbLE/
         hxZQ==
X-Gm-Message-State: AOJu0YyQdGcJYnJH5+oGvdN4G4gpaFPbLT+1FPrhOR/B8R4cWensk1dW
	mN77WL6UCuFNnJS/cLwty4X7r8DaJxKHEyLIRerkgiUTEHwRZf//jPkgrX0/QdNI
X-Gm-Gg: AY/fxX6YDDR1x0QIe/Odv9Cbond/ErfdcBbQa+5dI4tcG5T2S0PE8qXR3djavFen5Pe
	qZHy2q4WKF2CkwdRRKmnkzlFY4k1po81/ITpCnXT4FCxpKL/SY4SPbZYSkLgL9kEU/UxuFptsQO
	Tj0Y2du1mMT72kzOenBuArm2gxRL7jaxsud4ZsqCsfvr4zLBQjN8ITX76FjYNN9CdXAE2t8NAph
	6QWpT3QZgaPCswdoTuCbcQdp1rb8Q9cMlMql+xqxoRrjgxxrD6G1Ag/yt5wa/5VHOS0FoGikGI8
	uARmmcKR7GTkTKimWaHtAopInMTyQSOarW8EaJ/zOaI4uwyzrg6XOoe/3vUwzNpJSWUoPyPfYP6
	aTeU0kf5xK2W5s5OR0zrzEV2hTayQmlZLBhwp70IiPy/AgScI20/h/0rob3AEG2Or6yOu8/FRtz
	JIIPeCRbl0b1OES3037tQ=
X-Google-Smtp-Source: AGHT+IH63RpdYYwoMjKCYAxkTQ9fQ3MQI35TnXh4BzsSjju2bA83f1Sz9Kpp4sNdNES4sshdy0U86w==
X-Received: by 2002:a05:6512:2241:b0:59a:1087:f0e8 with SMTP id 2adb3069b0e04-59a17d22532mr4127732e87.21.1766410166081;
        Mon, 22 Dec 2025 05:29:26 -0800 (PST)
Received: from localhost ([212.74.230.163])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a18628388sm3197270e87.99.2025.12.22.05.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:29:25 -0800 (PST)
From: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>
To: helgaas@kernel.org
Cc: linux-pci@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pci: pci-stub fix kernel-doc warnings
Date: Mon, 22 Dec 2025 16:28:54 +0300
Message-ID: <20251222132854.112890-1-roman.shlyakhov.rs@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings reported by kernel test robot:

Warning: drivers/pci/pci-stub.c:55 This comment starts with '/**',
	but isn't a kernel-doc comment.
Warning: drivers/pci/pci-stub.c:122 This comment starts with '/**',
	but isn't a kernel-doc comment.
Warning: drivers/pci/pci-stub.c:148 This comment starts with '/**',
	but isn't a kernel-doc comment.
Warning: drivers/pci/pci-stub.c:207 This comment starts with '/**',
	but isn't a kernel-doc comment.
Warning: drivers/pci/pci-stub.c:222 This comment starts with '/**',
	but isn't a kernel-doc comment.

Convert incorrect /** comments to proper kernel-doc format or
regular /* comments as required by Documentation/doc-guide/kernel-doc.rst.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512202126.F1IQYL9V-lkp@intel.com/
Signed-off-by: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>
---
 drivers/pci/pci-stub.c | 58 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index 3ca5e11c3939..fdeed328080e 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -27,6 +27,14 @@
 
 static char ids[1024] __initdata;
 
+/**
+ * struct pci_stub_busid - represents a PCI BUSID for stub driver binding
+ * @domain: PCI domain (if domain_specified is true)
+ * @bus: PCI bus number
+ * @device: PCI device/slot number
+ * @function: PCI function number
+ * @domain_specified: true if domain was explicitly specified in BUSID
+ */
 struct pci_stub_busid {
 	unsigned int domain;
 	unsigned int bus;
@@ -52,8 +60,11 @@ MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the stub driver, format is "
 		"\"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\""
 		" and multiple comma separated entries can be specified");
 
-/**
- * Checking if the PCI device matches the BUSID list.
+/*
+ * pci_stub_find_busid - Check if the PCI device matches the BUSID list
+ * @dev: PCI device to check
+ *
+ * Return: pointer to matching pci_stub_busid if found, NULL otherwise
  */
 static struct pci_stub_busid *pci_stub_find_busid(struct pci_dev *dev)
 {
@@ -81,6 +92,13 @@ static struct pci_stub_busid *pci_stub_find_busid(struct pci_dev *dev)
 	return NULL;
 }
 
+/**
+ * pci_stub_probe - Probe function for pci-stub driver
+ * @dev: PCI device being probed
+ * @id: matching PCI device ID if any
+ *
+ * Return: 0 on successful claim, -ENODEV otherwise
+ */
 static int pci_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct pci_stub_busid *busid = pci_stub_find_busid(dev);
@@ -120,7 +138,15 @@ static struct pci_driver stub_driver = {
 };
 
 /**
- * Parsing a single BUSID.
+ * pci_stub_parse_one_busid - Parse a single BUSID string
+ * @str: BUSID string to parse
+ * @busid: pointer to pci_stub_busid structure to fill
+ *
+ * Formats accepted:
+ * - with domain: "DDDD:BB:DD.F"
+ * - without domain: "BB:DD.F"
+ *
+ * Return: 0 on success, -EINVAL on parse error
  */
 static int pci_stub_parse_one_busid(const char *str, struct pci_stub_busid *busid)
 {
@@ -145,8 +171,10 @@ static int pci_stub_parse_one_busid(const char *str, struct pci_stub_busid *busi
 	return 0;
 }
 
-/**
- * Parsing the "busid" kernel parameter.
+/*
+ * pci_stub_parse_busid_param - Parse the "busid" kernel parameter
+ *
+ * Parses comma-separated list of BUSIDs and registers them for binding.
  */
 static void __init pci_stub_parse_busid_param(void)
 {
@@ -205,7 +233,11 @@ static void __init pci_stub_parse_busid_param(void)
 }
 
 /**
- * early_param "pci_stub_busid" handler for the built-in module.
+ * pci_stub_early_param - early_param handler for "pci_stub_busid"
+ * @str: BUSID list parameter value
+ *
+ * This function is called during early boot to parse BUSID list.
+ * Return: 0 on success
  */
 static int __init pci_stub_early_param(char *str)
 {
@@ -219,8 +251,11 @@ static int __init pci_stub_early_param(char *str)
 
 early_param("pci_stub_busid", pci_stub_early_param);
 
-/**
- * Binding devices by BUSID via dynamic IDs.
+/*
+ * pci_stub_bind_free_devices - Bind devices by BUSID via dynamic IDs
+ *
+ * Attempts to bind all PCI devices matching registered BUSIDs to pci-stub
+ * driver using dynamic IDs.
  */
 static void __init pci_stub_bind_free_devices(void)
 {
@@ -285,8 +320,11 @@ static void __init pci_stub_bind_free_devices(void)
 	pr_info("pci-stub: bound %d device(s), skipped %d\n", bound, skipped);
 }
 
-/**
- * Checking the final binding state.
+/*
+ * pci_stub_verify_bindings - Check the final binding state
+ *
+ * Verifies which devices from BUSID list are bound to pci-stub,
+ * bound to other drivers, or not bound at all.
  */
 static void __init pci_stub_verify_bindings(void)
 {
-- 
2.51.2


