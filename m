Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1F41AC2D
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfELMvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 08:51:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36997 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfELMvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 08:51:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so5320296pgc.4;
        Sun, 12 May 2019 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xkpj2Zdg6DWJ2mSOWMnWDmzr9L09VZgca662PqKDh1U=;
        b=Grik67I1/pDoxGorB0DfOp57yWYgKmNrBys2q1gmC6g1nPCeMH8vrlYI/oN1tvDzy2
         xu6EgzCl8lSXCE1UZ7IJlsM0d7n+kopfySC1zCmVVmtESSkf0xjs9+p05C5meDOSiOt/
         6ZOiegrCiH39VO3cyfaHjEtLwPhM3MPpQhxongnmAYLLzY1nL6vmJyLEKWqppodwDe1q
         eJdRZRGErQ20h3xrDVO1wJEq+bFs5oCJ5WYJmCOmXTY8M/bLF2KeZL332jAqkOzGtIjs
         jXdVpZ59duIARM6s0+Bfy9aulO5Lc/ssXMpMwTbThrXoC+LFkUtIrT1DXnYrx/njjhhy
         Jptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xkpj2Zdg6DWJ2mSOWMnWDmzr9L09VZgca662PqKDh1U=;
        b=NxBRENgClCqGtSGDyWobygr4HIJ01kr+IIIhH+hyFNMEon+guaEdnw+BmiugVBj1UL
         eajW/ICJW3j0rQ6BZl3ICsFTjXUUEBVWUcz/FQ1MH1nIHwNLCBWVp00r9yMo9Bo9fev+
         nYzu69GDsCMmDpJFeObgB5j0e5fo0XzYIDFYDmu42nmHaFsJnt29w6jsyAFKMT8IfIOw
         GaUWxLFJptbXnOWWArfsY7RZApeY5+tKVRszUza7M/3dtbCKnPp9PXmuBy+Nr2J9plB7
         g8fE0P8e0GOXgHIFzBfvTXASPOZUdFCVEkRNpedxvgLAnmzpqHAE3mqPXk9hU7hRubv6
         kf3Q==
X-Gm-Message-State: APjAAAXCB4ovxv7BurqY93u61exjDd6aJfSN7pzwMKqBN0oe5GHqpsPA
        EITa9N7z+ckGGrceKBoRLcM=
X-Google-Smtp-Source: APXvYqzpYw7SkBmlyiTVVtVCzLZIBQ28zpcF8zrrt3fs4KTAQNvQb/o/KbMJuId8oNyPEWVqsMTCog==
X-Received: by 2002:a62:6c88:: with SMTP id h130mr27095121pfc.106.1557665460503;
        Sun, 12 May 2019 05:51:00 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id n2sm146426pgp.27.2019.05.12.05.50.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 12 May 2019 05:51:00 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 06/12] Documentation: PCI: convert acpi-info.txt to reST
Date:   Sun, 12 May 2019 20:50:03 +0800
Message-Id: <20190512125009.32079-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512125009.32079-1-changbin.du@gmail.com>
References: <20190512125009.32079-1-changbin.du@gmail.com>
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

