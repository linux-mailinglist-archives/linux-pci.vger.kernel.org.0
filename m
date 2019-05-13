Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160801B812
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfEMOUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:20:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45774 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfEMOUi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:20:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id a5so6552826pls.12;
        Mon, 13 May 2019 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jp0J+0p/jZwToTztJ3shHuInfO0FLqac4sxv0Cyq2DU=;
        b=LdmC+sGP/JOV51c2wHxXdkjCLuqVZCwH6GuWqiR8ZAsL2U3yX88ndi+Z3sv2raxAok
         XDALHjr+6pvtXX51IEGWbPLakFwp5rQ+EE8XdRFGuBR4sAomO/xNXzTX5JjZP9f9JeHi
         8banEMXFtlVkoDDLBWw5P+iTYEiJsbam2m5xr6fPuR/PEixbnsMU3Iylc0y1AmbU9xPv
         gbIA6Myw5U/0v73w0oXlVOHSfDlxF1jNS0ZTqcyCFKsQWb1Ah/r5TDzAxuLzFDaKbLlV
         uEx4IKi4Fz7EAAD2NntMTAFjVGAOeMl8guSwOZX7ojs7ZklhXjcJpSvQICgBOIBwnKQz
         vICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jp0J+0p/jZwToTztJ3shHuInfO0FLqac4sxv0Cyq2DU=;
        b=GAGZiWR+bWNUZ3L0a7r/+/Oj0mgu+4B05a9qhX20w8rbwStJe/pf18nO1VrIOghEM0
         OFdaza6ZGmSDQaXCS9WUlb/2A3mJ5Kn6LY0mrKzKUntOGWMBmjz8zK7LhBqA3yWpWmUt
         FX5fI3nXD2UN3p5WipTWG/mWzkL3CabMjsIbgUhCCu0LfOdKpnz6i166asOIcAgK4+Ii
         JrHmsGQ+lZza87vLzRIuxWk8v4x9/ewzf4pMK1306ZS/Dx7xehgeccgWr4HBMBEouOci
         XVtqebEjLgSAzefDUnsyoysRtxkC9whNuGUGRrLvdidjHRtZwMx6uuQF3NlNymNAaQh6
         oACA==
X-Gm-Message-State: APjAAAX7LfGFDwO2ktjKBHP5IS9gjMLjMt5As2JNXmoGvfqy5Gike+Nk
        G7q/EyrwAcs+AhENr8MWDvk=
X-Google-Smtp-Source: APXvYqx97aeB/JVBsMIwJob2Y6Vz+Xn3Cr5piNSVHmf2atN6iEKYzXhfzWzai+zAIzphtT9/QqUbYQ==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr30319663plt.59.1557757237618;
        Mon, 13 May 2019 07:20:37 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id x30sm15382513pgl.76.2019.05.13.07.20.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:20:37 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 04/12] Documentation: PCI: convert pci-iov-howto.txt to reST
Date:   Mon, 13 May 2019 22:19:52 +0800
Message-Id: <20190513142000.3524-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513142000.3524-1-changbin.du@gmail.com>
References: <20190513142000.3524-1-changbin.du@gmail.com>
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

