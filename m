Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43431CAD2
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfENOsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 10:48:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43803 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfENOsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 10:48:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so9256346pfa.10;
        Tue, 14 May 2019 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xkpj2Zdg6DWJ2mSOWMnWDmzr9L09VZgca662PqKDh1U=;
        b=dTdwD07wyCWHvg23/pHU0urwjddtcKGWLWMyh1Ne8uzfs/hukGpZvjqhIGKKllgfsu
         ZNMWCza9/LIn8VVsB2pKkmN/2FMWRKulN3d/A0xgN/tc5IM+2sFxr7EzFBUf7NyOGVz7
         egZj4FoAX8lHn9udb7cs6wBCBsj/PmZNKjjnh/Caf8SSxmIoGlQg03uQ6EllZiboH4Kz
         jjPkE6jdzX6bAHpq4DuwexnuO0qzfW3O912BdaoRMcZs8Fhe1hIeo5gTnN3y8mAxwzIA
         RdSiYo4GEcUgd+fjgKCkVOInQG6PbSJb72sZPwRJdu1M6FtIntC40LxK68z7U1plbq74
         vMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xkpj2Zdg6DWJ2mSOWMnWDmzr9L09VZgca662PqKDh1U=;
        b=GegWo4rPfKwVMyWamnQOLxfVBeYLckmmdevFPd1yf0uhl2iaprU5cWYweRmCGxBXzn
         6bxSLrXl8amI+AFM9pjGexVWnwbb0ea/7/AGl2Ej2vZoJ9sLzzi4jy06g1YdmbrKx0wP
         txSBJh530E2WbzF15kRCy2UJdTsX4NpTpK0UxORoUcx79qZ/DMGg80X5IWRSZ1Wazf8b
         iGflEhI58uGvzdt264QiJi5LuIY7LJvQmJd5UFn0greyjGjWpcJwUnXdLuY8pvDcfeLh
         ZDkeoS0bYaMrHX1AnZ/W1VNsoBQs+OLwSNsZcD+G2+oXTFW+7eB6uf+dw218aDrZX0dR
         69ug==
X-Gm-Message-State: APjAAAWUOhaXcdQev5F9pTahVylc6OULjPIcqf3AFFvf3r16Lf6Zf7mU
        B7kPWHd+DVrheTnnW2oCmRk=
X-Google-Smtp-Source: APXvYqyyPVrKqgfuT29U5v/olYh/Ai2ByAbHBgzBYhxqJA+lQRn7G2m9KJi34hJ1n8fL6G8dElyKfg==
X-Received: by 2002:aa7:8a11:: with SMTP id m17mr18465895pfa.122.1557845285522;
        Tue, 14 May 2019 07:48:05 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id j12sm20461415pff.148.2019.05.14.07.48.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 07:48:05 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 06/12] Documentation: PCI: convert acpi-info.txt to reST
Date:   Tue, 14 May 2019 22:47:28 +0800
Message-Id: <20190514144734.19760-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514144734.19760-1-changbin.du@gmail.com>
References: <20190514144734.19760-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../PCI/{acpi-info.txt => acpi-info.rst}          | 15 ++++++++++-----
 Documentation/PCI/index.rst                       |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (96%)

diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-info.rst
similarity index 96%
rename from Documentation/PCI/acpi-info.txt
rename to Documentation/PCI/acpi-info.rst
index 3ffa3b03970e..060217081c79 100644
--- a/Documentation/PCI/acpi-info.txt
+++ b/Documentation/PCI/acpi-info.rst
@@ -1,4 +1,8 @@
-		ACPI considerations for PCI host bridges
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+ACPI considerations for PCI host bridges
+========================================
 
 The general rule is that the ACPI namespace should describe everything the
 OS might use unless there's another way for the OS to find it [1, 2].
@@ -131,12 +135,13 @@ address always corresponds to bus 0, even if the bus range below the bridge
 
 [4] ACPI 6.2, sec 6.4.3.5.1, 2, 3, 4:
     QWord/DWord/Word Address Space Descriptor (.1, .2, .3)
-    General Flags: Bit [0] Ignored
+      General Flags: Bit [0] Ignored
 
     Extended Address Space Descriptor (.4)
-    General Flags: Bit [0] Consumer/Producer:
-	1–This device consumes this resource
-	0–This device produces and consumes this resource
+      General Flags: Bit [0] Consumer/Producer:
+
+        * 1 – This device consumes this resource
+        * 0 – This device produces and consumes this resource
 
 [5] ACPI 6.2, sec 19.6.43:
     ResourceUsage specifies whether the Memory range is consumed by
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 458354daac47..6f573f3df993 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -12,3 +12,4 @@ Linux PCI Bus Subsystem
    picebus-howto
    pci-iov-howto
    msi-howto
+   acpi-info
-- 
2.20.1

