Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81D61CAC8
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfENOsY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 10:48:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37418 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfENOsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 10:48:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so9271258pfi.4;
        Tue, 14 May 2019 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/Y+ncH2RPQ7WPNTjKYarl28Ee8gzLuA374D+ObE5d4=;
        b=kEihEZ2m1JXXHWsZJv9hrvglutFYYopynDOg1MVObTiBaN0y9+BwTB3+rRsoRbwsYg
         kaw1jCejL8Sz76mj3vgxYGcPqiK9CX4+RLI6RFbgtP1OYkMOj2ftaKpbId8v0Y97YJUx
         vNFqBNUAPKcVzWQVc2j6hVNABSrYoEKKG1eQwPFyzJXmrB40n8oaeFudTpVHa5iTaoKJ
         GFLuMGW8keq0/MZK6oG6gyOtASK2P3NZZjYGfzZ4XXCjAfBJrnQEw+hn0Q5LwvagmvXr
         aVEVXmbIDl1W9WmgjCGKonXoa+0YRsKwhiLy9nYlk4NYhbIjribW9DamWnWpDVr0QYYc
         xG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/Y+ncH2RPQ7WPNTjKYarl28Ee8gzLuA374D+ObE5d4=;
        b=OTHZqeVMIsz/DRdORoHa0ANzwf/9rIxxOShb33lhuyuiVgxdjHnlukVkFtkO/MGQY6
         CyRUrajBwqY2Bh6dE+AlM69GNqzMHn85TDcp5/lB+k0msbVo8UUACwfDc3AjantexDhs
         NkzAKdbpAGFpNG+tCW2JXk9617kr/OGVZS+iUQlO4SokCVi/Sbhi++zl5IRy9m9ZzIKo
         gAL/FW2EMyTS2xH+DeGOaX3AJQuahwlQFCzclfqdhgrWu7LwhIy3OcnFBqIS39rSBe+o
         NcZ8kSwL+qztIGaVEyF8xq0zvpGgrHFNWwU2gbrq0hf+XyIgogYeCg+IDN00eoacLpZu
         bcVw==
X-Gm-Message-State: APjAAAXHphTy+aLP1D8RYiuWdR+ka7BpQKpu3jz8QGtYvmH5EauwBCXJ
        69PAqrfylGo/fS2r4bQ2rOc=
X-Google-Smtp-Source: APXvYqwU4XV3Sutz5JSyvs6SexvHw/fIFaOiFrCA9FZ1K7kZuugX+Gw9Xq1GswtOxXIKyTB3ZJ3ILA==
X-Received: by 2002:a62:56c3:: with SMTP id h64mr40527393pfj.163.1557845299473;
        Tue, 14 May 2019 07:48:19 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id j12sm20461415pff.148.2019.05.14.07.48.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 07:48:19 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 10/12] Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
Date:   Tue, 14 May 2019 22:47:32 +0800
Message-Id: <20190514144734.19760-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514144734.19760-1-changbin.du@gmail.com>
References: <20190514144734.19760-1-changbin.du@gmail.com>
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

