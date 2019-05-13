Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD7E1B829
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfEMOVY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:21:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36552 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfEMOVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:21:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so6585309plr.3;
        Mon, 13 May 2019 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKdu0ILcdwhzKdzRsRvLQoNRSuMzHD4GSeF3dTlEK0M=;
        b=FRFfDzqwjSbTAPTAxv7+FxL337yo+OR+vRQmwQLfnCyHXzK1MYQL2KhZNJcYs1cggA
         Mj2rtt0iKTlfJCL/WiCYTpo0xLEj07e8NvXq7cPtEVOzEroVMvD+xdOuSOskKoFrmoz6
         T8LfaDXK1f+ndWLah9Q0p9/Egzzmv85Nq7ecCG5Tkua1GltixIn10+vB+AIfeqvkpzrd
         a3HTw3rLj8AssW8b5X9cVOX4nghPqe/e5GAtZnYes0oIrmcnAXWTJmv4cLuJ5f2pDQoi
         ngr8FYThPYHhdfFVtYxtITUAOiGyTrF5FEpeq7mTy+MYPbrVphtQHv80Wz3XgvPWpq0R
         6hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKdu0ILcdwhzKdzRsRvLQoNRSuMzHD4GSeF3dTlEK0M=;
        b=Hb3jD1XFrdU2KF30+jXgFTFqNYsmx7cdGBk18ikFtWeNgpsn4Zqj8EQeXDowM8iw5b
         +TiDUc6lZYaf5jXYiqFuhGwtCFkM+Bwu+5ycNTSXEtbmai29ZUJiDFrUeQC7KCctN1su
         723hq7qapEPVWW5wxXH7h9gh7ymfPFLeXH2vxeWa43/tEvBxoJoeQXYkNXPlwWf4EMBS
         IpS21QvCvNujmQuw4sQCAevAeACP5baGseQkbfNt1rOlIq8zOfBfN2R+ObbahYeUKnKm
         KEJfr0uOL8ZwwmCCXM3LVoEU/Ac2YCpGMKLMUJAnqjPm2cZKEiuF3bgUUU7TKe+xDXJG
         LKzA==
X-Gm-Message-State: APjAAAX5FGYpn5gD3Tcd+ZR4q4bcg2Y/EugMWdbfrZH91lj5gt0XdJqI
        +eD8K1kekU2m4vbGrt2Pn8ZXKPvt
X-Google-Smtp-Source: APXvYqxSVDEnVaiRY37IS2N66WkfoB9mjMF2HZoCYJgB4J+dhgQbQuhcVShwXSxbtxwRJIdsvodZzw==
X-Received: by 2002:a17:902:2907:: with SMTP id g7mr6450252plb.114.1557757281255;
        Mon, 13 May 2019 07:21:21 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id x30sm15382513pgl.76.2019.05.13.07.21.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:21:20 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 11/12] Documentation: PCI: convert endpoint/pci-test-function.txt to reST
Date:   Mon, 13 May 2019 22:19:59 +0800
Message-Id: <20190513142000.3524-12-changbin.du@gmail.com>
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
---
 Documentation/PCI/endpoint/index.rst          |  1 +
 ...est-function.txt => pci-test-function.rst} | 34 ++++++++++++-------
 2 files changed, 22 insertions(+), 13 deletions(-)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 3951de9f923c..b680a3fc4fec 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -9,3 +9,4 @@ PCI Endpoint Framework
 
    pci-endpoint
    pci-endpoint-cfs
+   pci-test-function
diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.rst
similarity index 84%
rename from Documentation/PCI/endpoint/pci-test-function.txt
rename to Documentation/PCI/endpoint/pci-test-function.rst
index 5916f1f592bb..63148df97232 100644
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
@@ -23,30 +28,31 @@ The PCI endpoint test device has the following registers:
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
+Bitfield Description::
+
   Bit 0		: raise legacy IRQ
   Bit 1		: raise MSI IRQ
   Bit 2		: raise MSI-X IRQ
   Bit 3		: read command (read data from RC buffer)
   Bit 4		: write command (write data to RC buffer)
-  Bit 5		: copy command (copy data from one RC buffer to another
-		  RC buffer)
+  Bit 5		: copy command (copy data from one RC buffer to another RC buffer)
 
-*) PCI_ENDPOINT_TEST_STATUS
+* PCI_ENDPOINT_TEST_STATUS
 
 This register reflects the status of the PCI endpoint device.
 
-Bitfield Description:
+Bitfield Description::
+
   Bit 0		: read success
   Bit 1		: read fail
   Bit 2		: write success
@@ -57,31 +63,33 @@ Bitfield Description:
   Bit 7		: source address is invalid
   Bit 8		: destination address is invalid
 
-*) PCI_ENDPOINT_TEST_SRC_ADDR
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
+
  - Legacy	: 0
  - MSI		: 1
  - MSI-X	: 2
 
-*) PCI_ENDPOINT_TEST_IRQ_NUMBER
+* PCI_ENDPOINT_TEST_IRQ_NUMBER
 
 This register contains the triggered ID interrupt.
 
 Admissible values:
+
  - Legacy	: 0
  - MSI		: [1 .. 32]
  - MSI-X	: [1 .. 2048]
-- 
2.20.1

