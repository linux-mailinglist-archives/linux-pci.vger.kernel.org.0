Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D901F8EAF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 08:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgFOGvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 02:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgFOGuf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jun 2020 02:50:35 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56272208B3;
        Mon, 15 Jun 2020 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203832;
        bh=DkbqyiXi236RYVyqQecB4kPGnjLiBBi56GZaBwWOy7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3Oa8miWM1zm+K1PodeLJ+vzdljfoIwtHiqoAG+DYkcKzfuJGPdX6hcAf9QEIPFCd
         mVGpixnEG6Du3hsDiXPkYFrCOVjZkbso54yixNbmBduPOUItaufWYWYglKtGyvMhXz
         tGzzVNBgzqCOMEGQtNBZc1uM+DlHlwJsoIvLb8ko=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiww-009o6O-DQ; Mon, 15 Jun 2020 08:50:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 13/22] docs: pci: endpoint/function/binding/pci-test.txt convert to ReST
Date:   Mon, 15 Jun 2020 08:50:18 +0200
Message-Id: <6254963b85417e44865dab05e4b99cd485074132.1592203650.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert this file to ReST by adding a proper title to it and
use the right markups for a table.

While here, add a SPDX header.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../endpoint/function/binding/pci-test.rst    | 26 +++++++++++++++++++
 .../endpoint/function/binding/pci-test.txt    | 19 --------------
 Documentation/PCI/endpoint/index.rst          |  2 ++
 .../misc-devices/pci-endpoint-test.rst        |  2 +-
 4 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.rst
 delete mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.txt

diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.rst b/Documentation/PCI/endpoint/function/binding/pci-test.rst
new file mode 100644
index 000000000000..57ee866fb165
--- /dev/null
+++ b/Documentation/PCI/endpoint/function/binding/pci-test.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+PCI Test Endpoint Function
+==========================
+
+name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
+
+Configurable Fields:
+
+================   ===========================================================
+vendorid	   should be 0x104c
+deviceid	   should be 0xb500 for DRA74x and 0xb501 for DRA72x
+revid		   don't care
+progif_code	   don't care
+subclass_code	   don't care
+baseclass_code	   should be 0xff
+cache_line_size	   don't care
+subsys_vendor_id   don't care
+subsys_id	   don't care
+interrupt_pin	   Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
+msi_interrupts	   Should be 1 to 32 depending on the number of MSI interrupts
+		   to test
+msix_interrupts	   Should be 1 to 2048 depending on the number of MSI-X
+		   interrupts to test
+================   ===========================================================
diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
deleted file mode 100644
index cd76ba47394b..000000000000
--- a/Documentation/PCI/endpoint/function/binding/pci-test.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-PCI TEST ENDPOINT FUNCTION
-
-name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
-
-Configurable Fields:
-vendorid	 : should be 0x104c
-deviceid	 : should be 0xb500 for DRA74x and 0xb501 for DRA72x
-revid		 : don't care
-progif_code	 : don't care
-subclass_code	 : don't care
-baseclass_code	 : should be 0xff
-cache_line_size	 : don't care
-subsys_vendor_id : don't care
-subsys_id	 : don't care
-interrupt_pin	 : Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
-msi_interrupts	 : Should be 1 to 32 depending on the number of MSI interrupts
-		   to test
-msix_interrupts	 : Should be 1 to 2048 depending on the number of MSI-X
-		   interrupts to test
diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index d114ea74b444..4ca7439fbfc9 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -11,3 +11,5 @@ PCI Endpoint Framework
    pci-endpoint-cfs
    pci-test-function
    pci-test-howto
+
+   function/binding/pci-test
diff --git a/Documentation/misc-devices/pci-endpoint-test.rst b/Documentation/misc-devices/pci-endpoint-test.rst
index 26e5d9ba146b..4cf3f4433be7 100644
--- a/Documentation/misc-devices/pci-endpoint-test.rst
+++ b/Documentation/misc-devices/pci-endpoint-test.rst
@@ -53,4 +53,4 @@ ioctl
 	      Perform read tests. The size of the buffer should be passed
 	      as argument.
 
-.. [1] Documentation/PCI/endpoint/function/binding/pci-test.txt
+.. [1] Documentation/PCI/endpoint/function/binding/pci-test.rst
-- 
2.26.2

