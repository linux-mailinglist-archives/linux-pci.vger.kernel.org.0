Return-Path: <linux-pci+bounces-37994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37323BD6A5D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 00:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7436418A5460
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 22:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D30308F0F;
	Mon, 13 Oct 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnlunlRK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7AD30507F
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395055; cv=none; b=CrihmJQK+a8qFxC3m8dyWb7dsdY1dqdULvAENGZ5IHbOqYOnwmS//YGt9HTwRSQBLv+x58kHQaePXA7xSKwGQJjF7ZG/y7UGKI09cwf+IkDK2keouRrxFADwhc3F110Bbb9CDOOWNTB7oHJJDrkuECrtFuNBH6BmwUpgYiT7REc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395055; c=relaxed/simple;
	bh=4zPbmz/GYQ9Xc4qksgNbJt7SIAPFTibdbVLdYd1h/gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cwgxej6jNRTziwSadjWU8CP/7DRlBAHyTk4HVc1xdflGLc0kme9/b5hio7S2V0pZWXN1xkQOdGKTV3lLtc7V05ygxecqNUGyQgjrTueFMovrpIuJF5YAG55lTytLmtFdA5RKuK9sTyo/E8tmR+L2yakj26l+KehFJAPQNMRznkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnlunlRK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so24172235e9.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760395052; x=1760999852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24Ftr7hy8LaAtQlSQs7NMC+zhhMlyRCsiGOHiR7triQ=;
        b=dnlunlRK644J2QsmWvcBtfyWvA82YIqPFf+VOvLYpFv7Gztn22N6DqtI30tJqdkYF0
         rU18qW5JSrU1ddKQon+W4nCG9bDiwRlaHDgoVgBw1MkurHlGlKMitcLHxXLmFbmsC89r
         0ToxW6PG+8v5yWrykkurjBuG+0q9ffTmlxps9Q5DkMrlVx3SvnZJkebztuQgmwq2ZWJh
         NaI2jb2N7y08lIjM8aZPQ8u6KCVJBbamEp1fmqrC386ZL3+c8bd8TxA7/ha6/Jy0h9P0
         6E+CdaTisV9z6yK9CsZloeCSoKpo7x4TUfrQWgbbgvIerYj4bel6Uq1SsffgP8MGekKk
         HFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760395052; x=1760999852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24Ftr7hy8LaAtQlSQs7NMC+zhhMlyRCsiGOHiR7triQ=;
        b=IG0hnIlqiOo8CfzP3V1iRCHyno26ZIx+1SJ/UXyv4GHilTZOoT2Ht7xHfTd0K4faNu
         UXpsctBDbG57NuzOA5vmyDNLhetuhGBYm0MFS2EiBUf6w46PWW1/KHauJjDXYiLm3wmZ
         IeD3JugPGGn/IVJrhXSSg/ToW0wmmMFl3dKlakQwKPFhNjvLIKpP5quqDCjRe7i6Xhui
         rVpaKQxYiixFr1com87GvKlRvNBAnDDVNXpv5HoxldY7D7SwFVcgNVZOXUoKtMu+/VAW
         MH5XHs7Z6Amv/0yoo30f+aDVdsGFYpGmVAPvOlqCnDW/NAT8rr/ie2Y+6aQBMSpYnUZ6
         izow==
X-Forwarded-Encrypted: i=1; AJvYcCXBlaDdebMdMPvw933SOR4zIZM6Sxp9XfGptZsL6ehe9l1PKSvO6WxK7XD9zmC/3S6xgQutJZsm9Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+a3E3bS3gY6f7Nx69cL3s28ep4nCRyX15geImBl2bdIJDIfp0
	YToK0UiM3TEZx0Mda43vJAomSOKKAF8cLIkU2Odk2pkNXM9RFt88D/9f
X-Gm-Gg: ASbGncunfx0J6WQtDfBHczSpusx/srZq+I9yqPb5W1v/EKlYR0YbuffU/Tcdp7weJs8
	Ru3VqnWEm9r0wT5uDOvXtKu6d2sPKgOrbWtb8KJK1mJNI52nPrWyPCHg+gbm9mojD/Bts0hGC1y
	yRfDnjkOqY9OPOxAdq1+uS8+iuRnU/YTTSuK2XrCVKBvnObZ3i8fr7OM39I0/g35RHSiCNPQZdV
	wVRS1DAHFIdTdY/7XlTBpsY5yKMlNmUy40MtzZ2GTFVIRGzHtPfAU2TObfSZQS4PyxDgIIDoJHB
	TeM1vneV/ZpqbnGxyHz1Zep2/uVEVd9LCLHSN19OWZluF8myZ+2EMF2T3ocvccigDU6wgpRJXMa
	lgNCXCR/wUfkxtVkLx6XZrvnAF04ONxMTXIBIEVnOlqpcJQxgb0RG7iVHMvPhatgP6c5VKnS7eb
	svNV6wCigG
X-Google-Smtp-Source: AGHT+IEamLZvij5RfRNleTzFAVlezTx1ysHtzuQYGAsX+iOPJIp3KIAoTV4KFic1Q1UmEwJsLYhfCg==
X-Received: by 2002:a7b:cc06:0:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-46fa296e763mr131783135e9.8.1760395051548;
        Mon, 13 Oct 2025 15:37:31 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb49d0307sm204948955e9.18.2025.10.13.15.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 15:37:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Subject: [PATCH] PCI/sysfs: enforce single creation of sysfs entry for pdev
Date: Tue, 14 Oct 2025 00:37:16 +0200
Message-ID: <20251013223720.8157-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In some specific scenario it's possible that the
pci_create_resource_files() gets called multiple times and the created
entry actually gets wrongly deleted with extreme case of having a NULL
pointer dereference when the PCI is removed.

This mainly happen due to bad timing where the PCI bus is adding PCI
devices and at the same time the sysfs code is adding the entry causing
double execution of the pci_create_resource_files function and kernel
WARNING.

To be more precise there is a race between the late_initcall of
pci-sysfs with pci_sysfs_init and PCI bus.c pci_bus_add_device that also
call pci_create_sysfs_dev_files.

With correct amount of ""luck"" (or better say bad luck)
pci_create_sysfs_dev_files in bus.c might be called with pci_sysfs_init
is executing the loop.

This has been reported multiple times and on multiple system, like imx6
system, ipq806x systems...

To address this, imlement multiple improvement to the implementation:
1. Add a bool to pci_dev to flag when sysfs entry are created
   (sysfs_init)
2. Implement a simple completion to wait pci_sysfs_init execution.
3. Permit additional call of pci_create_sysfs_dev_files only after
   pci_sysfs_init has finished.

With such logic in place, we address al kind of timing problem with
minimal change to any driver.

A notice worth to mention is that the remove function are not affected
by this as the pci_remove_resource_files have enough check in place to
always work and it's always called by pci_stop_dev.

Cc: stable@vger.kernel.org
Reported-by: Krzysztof Hałasa <khalasa@piap.pl>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215515
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/pci-sysfs.c | 34 +++++++++++++++++++++++++++++-----
 include/linux/pci.h     |  1 +
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 71a36f57ef57..cab3aa27f947 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
@@ -37,6 +38,7 @@
 #endif
 
 static int sysfs_initialized;	/* = 0 */
+static DECLARE_COMPLETION(sysfs_init_completion);
 
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
@@ -1652,12 +1654,32 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 	.is_visible = resource_resize_is_visible,
 };
 
+static int __pci_create_sysfs_dev_files(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = pci_create_resource_files(pdev);
+	if (ret)
+		return ret;
+
+	/* on success set sysfs correctly created */
+	pdev->sysfs_init = true;
+	return 0;
+}
+
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	return pci_create_resource_files(pdev);
+	/* sysfs entry already created */
+	if (pdev->sysfs_init)
+		return 0;
+
+	/* wait for pci_sysfs_init */
+	wait_for_completion(&sysfs_init_completion);
+
+	return __pci_create_sysfs_dev_files(pdev);
 }
 
 /**
@@ -1678,21 +1700,23 @@ static int __init pci_sysfs_init(void)
 {
 	struct pci_dev *pdev = NULL;
 	struct pci_bus *pbus = NULL;
-	int retval;
+	int retval = 0;
 
 	sysfs_initialized = 1;
 	for_each_pci_dev(pdev) {
-		retval = pci_create_sysfs_dev_files(pdev);
+		retval = __pci_create_sysfs_dev_files(pdev);
 		if (retval) {
 			pci_dev_put(pdev);
-			return retval;
+			goto exit;
 		}
 	}
 
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
 
-	return 0;
+exit:
+	complete_all(&sysfs_init_completion);
+	return retval;
 }
 late_initcall(pci_sysfs_init);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f3f6d6dee3ae..f417a0528f01 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -480,6 +480,7 @@ struct pci_dev {
 	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
+	bool		sysfs_init;	/* sysfs entry has been created */
 
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
-- 
2.51.0


