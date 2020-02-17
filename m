Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48A11617C3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgBQQUx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 11:20:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgBQQUr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 11:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xaj/Kq62ILPzY7lAW5KXKzbtsac5+1LbvXT8O3/lHog=; b=oKpZEejT4yP0H+tnFLoKeHJiun
        UNsEhOWK8lSoROqORqyGeFzdZfOWjNONfo/VChPdJn1dmpBUD8ac7geSH/P6acQRsFuc45v9w9qU/
        Sd5mZ2oQSALiLbw665nLt7FoTMYCYv29I5OzpSwFQnjqsMEfWl9IrxMCrmyh6qD7i/vSudsOzYfgl
        MMaJ9X80nD39XEYCUDBmHj94G4ZcTAJwLNMXX5lHa9sFdWHOVD9rg+D/rLP8D8O7OG3qCqPLy1gVG
        1ofQqpUnoi0k3Jd954Tbr+RMvvc3yNg/ZTXyOdf965FgxfjcEaWrxW1XoNQDLgpJnGc3EVsQREpEj
        GwrqfB3Q==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j8Y-00042B-3S; Mon, 17 Feb 2020 16:20:46 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j8W-000fpW-5m; Mon, 17 Feb 2020 17:20:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 12/24] docs: pci: endpoint/function/binding/pci-test.txt convert to ReST
Date:   Mon, 17 Feb 2020 17:20:30 +0100
Message-Id: <84d6075c17ce9a1c5c214f2f11ea55d951fdc3bd.1581956285.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581956285.git.mchehab+huawei@kernel.org>
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
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
 3 files changed, 28 insertions(+), 19 deletions(-)
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
-- 
2.24.1

