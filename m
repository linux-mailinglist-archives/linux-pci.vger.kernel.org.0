Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A120417780A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgCCN7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbgCCN7f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 08:59:35 -0500
Received: from mail.kernel.org (tmo-101-56.customers.d1-online.com [80.187.101.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC7821556;
        Tue,  3 Mar 2020 13:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583243973;
        bh=VCLZmy+ZW2tXSdrfWO+nS8XBzQHmJ+8yirLCEp0Uv0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTHxLYrbQIw6LLdv/srCr3OYQTiFnkIcyTT17Fb18of8ayfIMNnN/NeertSO4EDUk
         aNmtuLg8RjWYJyXQSHJdSz+d4lCA0pUcGBHtkUbURAl87oqpACjXeUS9MbgsBbEIrd
         Ef3+EFF+AxDnF8YekXmzeAPLmFg6lYAa/5y5Ce80=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j9850-001Ydg-Fm; Tue, 03 Mar 2020 14:59:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 12/18] docs: pci: endpoint/function/binding/pci-test.txt convert to ReST
Date:   Tue,  3 Mar 2020 14:59:19 +0100
Message-Id: <1f1f59eb9df5e50f0dc8648122c93177ca347c97.1583243826.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583243826.git.mchehab+huawei@kernel.org>
References: <cover.1583243826.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
2.24.1

