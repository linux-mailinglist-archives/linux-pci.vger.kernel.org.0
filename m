Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 574E11B81A
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfEMOUs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:20:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34320 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfEMOUs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:20:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so6876769pgt.1;
        Mon, 13 May 2019 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xkpj2Zdg6DWJ2mSOWMnWDmzr9L09VZgca662PqKDh1U=;
        b=HDrrjvYUEsplxZV44ictIOhUkYlOhycqoimbohpEEcuIh4eGexrb/hkKgfOZ2T000R
         SqvP3ccDC+hsJOL3bwPwHNTeQiy0x03puJ2CYX46XsKQxUHrwTfkltuICj2jp7iSGDIR
         mhKrPGKhOoFk7q7DRs6bcK7NJzHdBgLJM949mPL66tvhf0hKGF1ZIt2sbotoKrCk1aFa
         PNBxRqOzdYLsSwg0f8xBEAl2BJLy/BrTaE0rkH2yiagxV99sznI6/xL4ZiNlmFeA163A
         zFDuWj8xgarMyI3nwDPK67oSrqBwFKRK7ArlOdZPahztJkp5UqbQGzay/lMa0104cJje
         Nr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xkpj2Zdg6DWJ2mSOWMnWDmzr9L09VZgca662PqKDh1U=;
        b=fbWFhD9aidX64LeH7+nQ7xL8dhfWHGoP9FXXPyt/RwdYIYNL0afgo2pQ9svxXIvaQN
         PsZ56I0FI+Hr0S7ICgLuLuDU12kzKCe3Z5I7OsPddUMruE2Y171227luAmBbGSRvqb4u
         dwkjPBzdeQT/eiqGPd++wxjLwL2cf+wOPbIp5dTWAOpNmlWdBicuK3ABo/cSCFswuaMA
         3EfbqSkKFuK+6x5c4axFNZZALTKgFCEn5payCkpABaxcQy8x8SzoB2bbGhq/4KMslkVZ
         rVHZbEXY1rZraG+XXpjJqdJfeKe2yCRfRq6TqRQAQYooXV6hG33jTl69aCAfx86g/3Ji
         3t5Q==
X-Gm-Message-State: APjAAAWeP7lz1Dh/O7zfv4yXFmiPZBEVS+JA41xsXn2VmOrdDWlorSpZ
        VkwGF1JlpSaZqxmtF498yMs=
X-Google-Smtp-Source: APXvYqwYJ/m8zsSz16+Q2e1dP3Nc/6V70nGsUfsYsy6K1cW1MAYMs8oq2E9ihrs2wRt3GuD+o0YmQw==
X-Received: by 2002:a62:d244:: with SMTP id c65mr33522556pfg.173.1557757247466;
        Mon, 13 May 2019 07:20:47 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id x30sm15382513pgl.76.2019.05.13.07.20.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:20:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 06/12] Documentation: PCI: convert acpi-info.txt to reST
Date:   Mon, 13 May 2019 22:19:54 +0800
Message-Id: <20190513142000.3524-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513142000.3524-1-changbin.du@gmail.com>
References: <20190513142000.3524-1-changbin.du@gmail.com>
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

