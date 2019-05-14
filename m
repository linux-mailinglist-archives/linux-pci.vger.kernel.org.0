Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8BD1CAC9
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfENOsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 10:48:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43804 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfENOsY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 10:48:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so8383830plp.10;
        Tue, 14 May 2019 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lK1xlzj9XVgEphYMHzXNXMIFEbFxUpOQnQC8+zBIUE8=;
        b=lJD3Ov27c9VH3vWvtix/2KOW14mKXb/6Q9t+Zavy2Rwh77z5wMuzoJQRDlbVqV8usk
         9PXRehB/0uaQEugrXmTMwwV1Lwu5LJ1u3hQ03dxC/ZnEFOPWP90/CSsKlXUw+/7x3ULC
         YEASJogUhOxyFu4hbuzvO0DaFf8qPWEuj28YYE+0hoYUFoQs37y4iKwUx93x7LkquXZx
         grREBAaR6P5isXMc5TFcTKGnkxgKev3vs/nSWyHVfk/0akuX9GetSHzuzJyvlavgpcdG
         cgXyRjFoMvayOBR/iUw42vXuaaeRnMUgfKe701RfcUJj0OvDCSUZSYID7JHRlC8KtYN+
         pJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lK1xlzj9XVgEphYMHzXNXMIFEbFxUpOQnQC8+zBIUE8=;
        b=Xy7p6DbNNUNOyIIwqb3FVTNqjAnRuaY9ZI2JKX/3GSXYbUgVZrEOHSXjzhvY9hyODy
         WglvYGJeMIzwOsRq1T/8dHK3nF5834Y8zpdicQd7HqVikgej8Jv/UOiPF+N3mMOyytlG
         nfSKLG05OGGEcgqe7IW+YeT6cunvF1b1JuCB5Zzu3DiPwQ4/QqNqmnYDgcJiVNF7cMv9
         tCI8CarsBm/1QySj1v9eYmVeEsAGN86JvatV8blMLtxw86x/MUxMAcgHBxiEUA6BwGn4
         +PLLvTiRda5M+VBTwb9DnPcZwPnmSLVV3TXXXQr5BBWPymG6Thypk/M4yKohfaVO2nGJ
         WHfQ==
X-Gm-Message-State: APjAAAXHlyxFBucSq6vS8VJiUaJlffytaEhvMtqhgHjYAG4Ejcuf/7x7
        /otz4vG7tK7THmUBarNNdsQ=
X-Google-Smtp-Source: APXvYqwVMWPA37MiGapzQ6y3XYUwQ9SLAIkcEtRaZPZ/xMlUTgm8v7VSwIaos84vAugbbwC9fBkMvA==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr39345068plb.49.1557845303778;
        Tue, 14 May 2019 07:48:23 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id j12sm20461415pff.148.2019.05.14.07.48.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 07:48:23 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 11/12] Documentation: PCI: convert endpoint/pci-test-function.txt to reST
Date:   Tue, 14 May 2019 22:47:33 +0800
Message-Id: <20190514144734.19760-12-changbin.du@gmail.com>
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
 ...est-function.txt => pci-test-function.rst} | 84 +++++++++++--------
 2 files changed, 51 insertions(+), 34 deletions(-)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (55%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 3951de9f923c..b680a3fc4fec 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -9,3 +9,4 @@ PCI Endpoint Framework
 
    pci-endpoint
    pci-endpoint-cfs
+   pci-test-function
diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.rst
similarity index 55%
rename from Documentation/PCI/endpoint/pci-test-function.txt
rename to Documentation/PCI/endpoint/pci-test-function.rst
index 5916f1f592bb..3c8521d7aa31 100644
--- a/Documentation/PCI/endpoint/pci-test-function.txt
+++ b/Documentation/PCI/endpoint/pci-test-function.rst
@@ -1,5 +1,10 @@
-				PCI TEST
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+PCI Test Function
+=================
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 Traditionally PCI RC has always been validated by using standard
 PCI cards like ethernet PCI cards or USB PCI cards or SATA PCI cards.
@@ -23,65 +28,76 @@ The PCI endpoint test device has the following registers:
 	8) PCI_ENDPOINT_TEST_IRQ_TYPE
 	9) PCI_ENDPOINT_TEST_IRQ_NUMBER
 
-*) PCI_ENDPOINT_TEST_MAGIC
+* PCI_ENDPOINT_TEST_MAGIC
 
 This register will be used to test BAR0. A known pattern will be written
 and read back from MAGIC register to verify BAR0.
 
-*) PCI_ENDPOINT_TEST_COMMAND:
+* PCI_ENDPOINT_TEST_COMMAND
 
 This register will be used by the host driver to indicate the function
 that the endpoint device must perform.
 
-Bitfield Description:
-  Bit 0		: raise legacy IRQ
-  Bit 1		: raise MSI IRQ
-  Bit 2		: raise MSI-X IRQ
-  Bit 3		: read command (read data from RC buffer)
-  Bit 4		: write command (write data to RC buffer)
-  Bit 5		: copy command (copy data from one RC buffer to another
-		  RC buffer)
+========	================================================================
+Bitfield	Description
+========	================================================================
+Bit 0		raise legacy IRQ
+Bit 1		raise MSI IRQ
+Bit 2		raise MSI-X IRQ
+Bit 3		read command (read data from RC buffer)
+Bit 4		write command (write data to RC buffer)
+Bit 5		copy command (copy data from one RC buffer to another RC buffer)
+========	================================================================
 
-*) PCI_ENDPOINT_TEST_STATUS
+* PCI_ENDPOINT_TEST_STATUS
 
 This register reflects the status of the PCI endpoint device.
 
-Bitfield Description:
-  Bit 0		: read success
-  Bit 1		: read fail
-  Bit 2		: write success
-  Bit 3		: write fail
-  Bit 4		: copy success
-  Bit 5		: copy fail
-  Bit 6		: IRQ raised
-  Bit 7		: source address is invalid
-  Bit 8		: destination address is invalid
-
-*) PCI_ENDPOINT_TEST_SRC_ADDR
+========	==============================
+Bitfield	Description
+========	==============================
+Bit 0		read success
+Bit 1		read fail
+Bit 2		write success
+Bit 3		write fail
+Bit 4		copy success
+Bit 5		copy fail
+Bit 6		IRQ raised
+Bit 7		source address is invalid
+Bit 8		destination address is invalid
+========	==============================
+
+* PCI_ENDPOINT_TEST_SRC_ADDR
 
 This register contains the source address (RC buffer address) for the
 COPY/READ command.
 
-*) PCI_ENDPOINT_TEST_DST_ADDR
+* PCI_ENDPOINT_TEST_DST_ADDR
 
 This register contains the destination address (RC buffer address) for
 the COPY/WRITE command.
 
-*) PCI_ENDPOINT_TEST_IRQ_TYPE
+* PCI_ENDPOINT_TEST_IRQ_TYPE
 
 This register contains the interrupt type (Legacy/MSI) triggered
 for the READ/WRITE/COPY and raise IRQ (Legacy/MSI) commands.
 
 Possible types:
- - Legacy	: 0
- - MSI		: 1
- - MSI-X	: 2
 
-*) PCI_ENDPOINT_TEST_IRQ_NUMBER
+======	==
+Legacy	0
+MSI	1
+MSI-X	2
+======	==
+
+* PCI_ENDPOINT_TEST_IRQ_NUMBER
 
 This register contains the triggered ID interrupt.
 
 Admissible values:
- - Legacy	: 0
- - MSI		: [1 .. 32]
- - MSI-X	: [1 .. 2048]
+
+======	===========
+Legacy	0
+MSI	[1 .. 32]
+MSI-X	[1 .. 2048]
+======	===========
-- 
2.20.1

