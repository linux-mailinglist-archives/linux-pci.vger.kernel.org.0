Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4BE1AC34
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfELMvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 08:51:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38346 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfELMvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 08:51:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so5316904pgl.5;
        Sun, 12 May 2019 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/Y+ncH2RPQ7WPNTjKYarl28Ee8gzLuA374D+ObE5d4=;
        b=iBOS82nNx4hSzNEVSmgu/lI9kIIh9CXnCSJctmPqKpiBITi6998XaBkN3VEJbLshpI
         l9lBPJo2mPZi2NKprcg0nVfn5XtDxlA6cbvOeqsLP0+Z8g24dJ9ScxAmf9OKyQgoMbbi
         fIc8csZ4OsYyokZUSpaocYo5A3gpqJVOrUr69yO2wBY+zqj9sxTC62dnAhCrP4xZy3pP
         Wpy/FoDL1l2POMc+Fr+6qiV3HhPP82wDvjftJuQzr7XrIKOJNt6adoieDXt+ryPQCtRG
         2mVVBZO6ErjJEihb/IOBUfICpVCIIr5yKPe3iLU8dVMhanhdKpQK2e+gSesXWeyhM/pP
         4CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/Y+ncH2RPQ7WPNTjKYarl28Ee8gzLuA374D+ObE5d4=;
        b=EYaYRbXt+cVdZo1KwP7w0yLQ4dg7OL26uwYBREqrwPVVIOgRc1hK0csMVN2a7PTaXY
         lfu1/N0pepMTHCTCiP2mdDpksY6gpNiNsN533Rm8Romf4OugYzzkXgqAqrBTLPKdIEMp
         zxwatIMCZfkOZrYREHY0Lr6ynoVZHG6W25uDh1xAlJA2K9fN+mnYGsMRPuXaBlVlTfj6
         KwyWclVF6/Ki+1DOs6N4BST165ptwXQ2GOKFLbtI+0K1BIu6vqMOYrOU3iklIXiEyYhb
         4lJKo4kXr2lx7ULHIRmf1ZeOdrLQhHcrD6HClw1FVrRtFKVTAKQZcXKEXlCdH28yGQ2K
         7c4A==
X-Gm-Message-State: APjAAAX7c0mZgU5MKaiiiTbNjGzG6zAVLsvHKYejGDXtDCGYgQjF1Utf
        FaFmavDx/uDY+mrg1y9xz3M=
X-Google-Smtp-Source: APXvYqwF3gGY0jY1NDZD/u+PHvSf7T/047uiNXZ4Ju9/xEdRS3W+9D3nsubjZr9nAF1E9bt4/tWSNA==
X-Received: by 2002:a62:7793:: with SMTP id s141mr27337075pfc.21.1557665476281;
        Sun, 12 May 2019 05:51:16 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id n2sm146426pgp.27.2019.05.12.05.51.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 12 May 2019 05:51:15 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 10/12] Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
Date:   Sun, 12 May 2019 20:50:07 +0800
Message-Id: <20190512125009.32079-11-changbin.du@gmail.com>
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
 Documentation/PCI/endpoint/index.rst          |  1 +
 ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} | 99 +++++++++++--------
 2 files changed, 57 insertions(+), 43 deletions(-)
 rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 0db4f2fcd7f0..3951de9f923c 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -8,3 +8,4 @@ PCI Endpoint Framework
    :maxdepth: 2
 
    pci-endpoint
+   pci-endpoint-cfs
diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
similarity index 64%
rename from Documentation/PCI/endpoint/pci-endpoint-cfs.txt
rename to Documentation/PCI/endpoint/pci-endpoint-cfs.rst
index d740f29960a4..b6d39cdec56e 100644
--- a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
@@ -1,41 +1,51 @@
-                   CONFIGURING PCI ENDPOINT USING CONFIGFS
-                    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Configuring PCI Endpoint Using CONFIGFS
+=======================================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 The PCI Endpoint Core exposes configfs entry (pci_ep) to configure the
 PCI endpoint function and to bind the endpoint function
 with the endpoint controller. (For introducing other mechanisms to
 configure the PCI Endpoint Function refer to [1]).
 
-*) Mounting configfs
+Mounting configfs
+=================
 
 The PCI Endpoint Core layer creates pci_ep directory in the mounted configfs
-directory. configfs can be mounted using the following command.
+directory. configfs can be mounted using the following command::
 
 	mount -t configfs none /sys/kernel/config
 
-*) Directory Structure
+Directory Structure
+===================
 
 The pci_ep configfs has two directories at its root: controllers and
 functions. Every EPC device present in the system will have an entry in
 the *controllers* directory and and every EPF driver present in the system
 will have an entry in the *functions* directory.
+::
 
-/sys/kernel/config/pci_ep/
-	.. controllers/
-	.. functions/
+	/sys/kernel/config/pci_ep/
+		.. controllers/
+		.. functions/
 
-*) Creating EPF Device
+Creating EPF Device
+===================
 
 Every registered EPF driver will be listed in controllers directory. The
 entries corresponding to EPF driver will be created by the EPF core.
+::
 
-/sys/kernel/config/pci_ep/functions/
-	.. <EPF Driver1>/
-		... <EPF Device 11>/
-		... <EPF Device 21>/
-	.. <EPF Driver2>/
-		... <EPF Device 12>/
-		... <EPF Device 22>/
+	/sys/kernel/config/pci_ep/functions/
+		.. <EPF Driver1>/
+			... <EPF Device 11>/
+			... <EPF Device 21>/
+		.. <EPF Driver2>/
+			... <EPF Device 12>/
+			... <EPF Device 22>/
 
 In order to create a <EPF device> of the type probed by <EPF Driver>, the
 user has to create a directory inside <EPF DriverN>.
@@ -44,34 +54,37 @@ Every <EPF device> directory consists of the following entries that can be
 used to configure the standard configuration header of the endpoint function.
 (These entries are created by the framework when any new <EPF Device> is
 created)
-
-	.. <EPF Driver1>/
-		... <EPF Device 11>/
-			... vendorid
-			... deviceid
-			... revid
-			... progif_code
-			... subclass_code
-			... baseclass_code
-			... cache_line_size
-			... subsys_vendor_id
-			... subsys_id
-			... interrupt_pin
-
-*) EPC Device
+::
+
+		.. <EPF Driver1>/
+			... <EPF Device 11>/
+				... vendorid
+				... deviceid
+				... revid
+				... progif_code
+				... subclass_code
+				... baseclass_code
+				... cache_line_size
+				... subsys_vendor_id
+				... subsys_id
+				... interrupt_pin
+
+EPC Device
+==========
 
 Every registered EPC device will be listed in controllers directory. The
 entries corresponding to EPC device will be created by the EPC core.
-
-/sys/kernel/config/pci_ep/controllers/
-	.. <EPC Device1>/
-		... <Symlink EPF Device11>/
-		... <Symlink EPF Device12>/
-		... start
-	.. <EPC Device2>/
-		... <Symlink EPF Device21>/
-		... <Symlink EPF Device22>/
-		... start
+::
+
+	/sys/kernel/config/pci_ep/controllers/
+		.. <EPC Device1>/
+			... <Symlink EPF Device11>/
+			... <Symlink EPF Device12>/
+			... start
+		.. <EPC Device2>/
+			... <Symlink EPF Device21>/
+			... <Symlink EPF Device22>/
+			... start
 
 The <EPC Device> directory will have a list of symbolic links to
 <EPF Device>. These symbolic links should be created by the user to
@@ -81,7 +94,7 @@ The <EPC Device> directory will also have a *start* field. Once
 "1" is written to this field, the endpoint device will be ready to
 establish the link with the host. This is usually done after
 all the EPF devices are created and linked with the EPC device.
-
+::
 
 			 | controllers/
 				| <Directory: EPC name>/
@@ -102,4 +115,4 @@ all the EPF devices are created and linked with the EPC device.
 						| interrupt_pin
 						| function
 
-[1] -> Documentation/PCI/endpoint/pci-endpoint.txt
+[1] :doc:`pci-endpoint`
-- 
2.20.1

