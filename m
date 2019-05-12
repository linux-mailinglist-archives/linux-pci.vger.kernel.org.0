Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6399B1AC20
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 14:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfELMun (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 08:50:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35308 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfELMum (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 08:50:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so5324761pgs.2;
        Sun, 12 May 2019 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jp0J+0p/jZwToTztJ3shHuInfO0FLqac4sxv0Cyq2DU=;
        b=AT/huwu1y553IPnwlgygtbxBB21zyBTEXIuEb9FRsB/eFGRnNTrQobpz1vJdPReXDH
         RNiX5MtrJSu236UnRAfz/s/+4IRWlLYJiqcNWxmCv9ZKJVFhJS/bUZT3NAPtLayFXYeV
         IvTZTm+vDIhX6u2EgXanjoezFevNRILHLCqsQqcRVdlPM8z1Ml4Zc7ezYI0Q1Az1ipWl
         JEl5ITq+8OwOiENA5tODCHu2NqgtPq9d3vJK6evQbLzK2BowKycSDgfWMy2zotGMIWDc
         jfdOJwAutvLZH5KQYwd1ToDm+7dbE2rbXFobg5xa8kO25YIv7NbrlCKxFykuBDGWzzyK
         6Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jp0J+0p/jZwToTztJ3shHuInfO0FLqac4sxv0Cyq2DU=;
        b=Fh2xKcuKvO4FyQrXeg7H39CEegQwUHkUBmw9DeSYZLv6M5VlOR5Gq2ASPXMgseb9oC
         7I/U5PHgyRt27zD17oHWoyAFktaOVDT3Y/lYe+bkWusGvg+K+9UETp7h6oFqtJSYuKQs
         IcWw0R1cYUkbIMyWTcsiDBgkTKCS9pAFndbKVyt78M8DPJfFzPN27SySmLQNkhbkPSYv
         9Kuwafe5TBOgLiKPvcg2uUW5+lWKQhzrNyfIOn7ScMmg//i/vKc9kQFTJtV5e5tkwmSe
         yzcUEryLhOPhFxTPzPXHGdXxDx2Tho6qv+3qICIDDwUCzMXufvm8kSn7g3c8hQhvBbZA
         DcTg==
X-Gm-Message-State: APjAAAWrBNV7CSU5GW4KurB/fiGCreNc44/OClp7jLWOhDzO8JoJfHO5
        Es2zRGi3m+Te22dil+/NAPY=
X-Google-Smtp-Source: APXvYqwWRee6H3cQqBiYvhepkeEoeObFeQ8lJLHEmMXoy5yIvH8Eq7j1OCPKNqteWX5JjUhVZUMZ7A==
X-Received: by 2002:a62:1ec5:: with SMTP id e188mr27576729pfe.242.1557665441057;
        Sun, 12 May 2019 05:50:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id n2sm146426pgp.27.2019.05.12.05.50.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 12 May 2019 05:50:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 04/12] Documentation: PCI: convert pci-iov-howto.txt to reST
Date:   Sun, 12 May 2019 20:50:01 +0800
Message-Id: <20190512125009.32079-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512125009.32079-1-changbin.du@gmail.com>
References: <20190512125009.32079-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/PCI/index.rst                   |   1 +
 .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++++++++--------
 2 files changed, 94 insertions(+), 68 deletions(-)
 rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 79d6d75bbf28..0d9390298c4a 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -10,3 +10,4 @@ Linux PCI Bus Subsystem
 
    pci
    picebus-howto
+   pci-iov-howto
diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.rst
similarity index 63%
rename from Documentation/PCI/pci-iov-howto.txt
rename to Documentation/PCI/pci-iov-howto.rst
index d2a84151e99c..b9fd003206f1 100644
--- a/Documentation/PCI/pci-iov-howto.txt
+++ b/Documentation/PCI/pci-iov-howto.rst
@@ -1,14 +1,19 @@
-		PCI Express I/O Virtualization Howto
-		Copyright (C) 2009 Intel Corporation
-		    Yu Zhao <yu.zhao@intel.com>
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-		Update: November 2012
-			-- sysfs-based SRIOV enable-/disable-ment
-		Donald Dutile <ddutile@redhat.com>
+====================================
+PCI Express I/O Virtualization Howto
+====================================
 
-1. Overview
+:Copyright: |copy| 2009 Intel Corporation
+:Authors: - Yu Zhao <yu.zhao@intel.com>
+          - Donald Dutile <ddutile@redhat.com>
 
-1.1 What is SR-IOV
+Overview
+========
+
+What is SR-IOV
+--------------
 
 Single Root I/O Virtualization (SR-IOV) is a PCI Express Extended
 capability which makes one physical device appear as multiple virtual
@@ -23,9 +28,11 @@ Memory Space, which is used to map its register set. VF device driver
 operates on the register set so it can be functional and appear as a
 real existing PCI device.
 
-2. User Guide
+User Guide
+==========
 
-2.1 How can I enable SR-IOV capability
+How can I enable SR-IOV capability
+----------------------------------
 
 Multiple methods are available for SR-IOV enablement.
 In the first method, the device driver (PF driver) will control the
@@ -43,105 +50,123 @@ checks, e.g., check numvfs == 0 if enabling VFs, ensure
 numvfs <= totalvfs.
 The second method is the recommended method for new/future VF devices.
 
-2.2 How can I use the Virtual Functions
+How can I use the Virtual Functions
+-----------------------------------
 
 The VF is treated as hot-plugged PCI devices in the kernel, so they
 should be able to work in the same way as real PCI devices. The VF
 requires device driver that is same as a normal PCI device's.
 
-3. Developer Guide
+Developer Guide
+===============
 
-3.1 SR-IOV API
+SR-IOV API
+----------
 
 To enable SR-IOV capability:
-(a) For the first method, in the driver:
+
+(a) For the first method, in the driver::
+
 	int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
-	'nr_virtfn' is number of VFs to be enabled.
-(b) For the second method, from sysfs:
+
+'nr_virtfn' is number of VFs to be enabled.
+
+(b) For the second method, from sysfs::
+
 	echo 'nr_virtfn' > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
 To disable SR-IOV capability:
-(a) For the first method, in the driver:
+
+(a) For the first method, in the driver::
+
 	void pci_disable_sriov(struct pci_dev *dev);
-(b) For the second method, from sysfs:
+
+(b) For the second method, from sysfs::
+
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
 To enable auto probing VFs by a compatible driver on the host, run
 command below before enabling SR-IOV capabilities. This is the
 default behavior.
+::
+
 	echo 1 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
 
 To disable auto probing VFs by a compatible driver on the host, run
 command below before enabling SR-IOV capabilities. Updating this
 entry will not affect VFs which are already probed.
+::
+
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
 
-3.2 Usage example
+Usage example
+-------------
 
 Following piece of code illustrates the usage of the SR-IOV API.
+::
 
-static int dev_probe(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	pci_enable_sriov(dev, NR_VIRTFN);
+	static int dev_probe(struct pci_dev *dev, const struct pci_device_id *id)
+	{
+		pci_enable_sriov(dev, NR_VIRTFN);
 
-	...
-
-	return 0;
-}
+		...
 
-static void dev_remove(struct pci_dev *dev)
-{
-	pci_disable_sriov(dev);
+		return 0;
+	}
 
-	...
-}
+	static void dev_remove(struct pci_dev *dev)
+	{
+		pci_disable_sriov(dev);
 
-static int dev_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	...
+		...
+	}
 
-	return 0;
-}
+	static int dev_suspend(struct pci_dev *dev, pm_message_t state)
+	{
+		...
 
-static int dev_resume(struct pci_dev *dev)
-{
-	...
+		return 0;
+	}
 
-	return 0;
-}
+	static int dev_resume(struct pci_dev *dev)
+	{
+		...
 
-static void dev_shutdown(struct pci_dev *dev)
-{
-	...
-}
+		return 0;
+	}
 
-static int dev_sriov_configure(struct pci_dev *dev, int numvfs)
-{
-	if (numvfs > 0) {
-		...
-		pci_enable_sriov(dev, numvfs);
+	static void dev_shutdown(struct pci_dev *dev)
+	{
 		...
-		return numvfs;
 	}
-	if (numvfs == 0) {
-		....
-		pci_disable_sriov(dev);
-		...
-		return 0;
+
+	static int dev_sriov_configure(struct pci_dev *dev, int numvfs)
+	{
+		if (numvfs > 0) {
+			...
+			pci_enable_sriov(dev, numvfs);
+			...
+			return numvfs;
+		}
+		if (numvfs == 0) {
+			....
+			pci_disable_sriov(dev);
+			...
+			return 0;
+		}
 	}
-}
-
-static struct pci_driver dev_driver = {
-	.name =		"SR-IOV Physical Function driver",
-	.id_table =	dev_id_table,
-	.probe =	dev_probe,
-	.remove =	dev_remove,
-	.suspend =	dev_suspend,
-	.resume =	dev_resume,
-	.shutdown =	dev_shutdown,
-	.sriov_configure = dev_sriov_configure,
-};
+
+	static struct pci_driver dev_driver = {
+		.name =		"SR-IOV Physical Function driver",
+		.id_table =	dev_id_table,
+		.probe =	dev_probe,
+		.remove =	dev_remove,
+		.suspend =	dev_suspend,
+		.resume =	dev_resume,
+		.shutdown =	dev_shutdown,
+		.sriov_configure = dev_sriov_configure,
+	};
-- 
2.20.1

