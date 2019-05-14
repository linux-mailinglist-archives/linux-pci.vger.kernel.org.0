Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD401CAD4
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfENOsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 10:48:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36588 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfENOsR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 10:48:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so8401008plr.3;
        Tue, 14 May 2019 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZPCPQxGexWtk/HvjS0k1/QZKYTL6e4sdoymRbsDb0I=;
        b=DReEgfyNV4qU1wfII32i6tuNDwZBLhjQUNrsG4tJd6rKZjcHpakJ6YwqTNWYJQ6PDV
         9K5eHILZzXqNDgW5fQ4jhM5LbLsM7rNcl6JUFXo2X/bnCYWmkVKwuXPU2jI2v/xXz2F8
         euQ383ETAHsIYzbQn72oz7dtmr77bmb/hHrtZsGq4Ca1RNlBl6QH/g8AMBNV/yJvLIF9
         5CWUj+Jyw1MfeGlefkZMiJxNl7t1rXM6RAsdHyOByzPMx6Tk/QkSEy6aLMlashFYAnH1
         meAGLm+IouOHqoia+v0fmYg+6DOm3uRyh3QXGUkxWCcAqqicOZZKYBFGEn36SHDv9mdB
         kv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZPCPQxGexWtk/HvjS0k1/QZKYTL6e4sdoymRbsDb0I=;
        b=N7rPOT5ut+zKrRfJEhqamIDygxM1VMo8FxFcurIO/r+T1LvVCNaLjjbmimUK3sFgrl
         Sl1xxDKriqMaas1cpwGRQP9nQw1CuznHo4fhvO4QtJvJKAY9QGB5/V7+1xxDOrqxMSeQ
         5Kukb56JUEg25A2wFNOPS4w5AY5VwCaZ1aJ3SILq1nKr175VbcfjsKaIh8a2oFh0rme/
         su7OCsQVNoHc8y9Ilowy1T8ro7xZrnfQlFNPQMIHQJh/OcmdlMcjR8fS+/4j+aFjXzZs
         TOnDZKihE7cSRP0B3RDTN4m3EHH+q4KC1o6eKQMsd2Rs9fJMcHnVohzDG0rKUGXmBlpR
         dGWg==
X-Gm-Message-State: APjAAAWeU8lHMekOcKuAYmRMtIeaYDPjU6HXXP48XxynhqIvfJNgmec2
        4HIIbj6yyj5YhN/NXDp1IWc=
X-Google-Smtp-Source: APXvYqxvkJVbb9TTzlgEnbHW0VHeVS4ROAFFWNqxfcpCYwHxBBHX862JHcGxBlu49bVf6y91ehOUdg==
X-Received: by 2002:a17:902:7407:: with SMTP id g7mr3520848pll.311.1557845296254;
        Tue, 14 May 2019 07:48:16 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id j12sm20461415pff.148.2019.05.14.07.48.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 07:48:15 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 09/12] Documentation: PCI: convert endpoint/pci-endpoint.txt to reST
Date:   Tue, 14 May 2019 22:47:31 +0800
Message-Id: <20190514144734.19760-10-changbin.du@gmail.com>
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
 Documentation/PCI/endpoint/index.rst          | 10 ++
 .../{pci-endpoint.txt => pci-endpoint.rst}    | 92 +++++++++++--------
 Documentation/PCI/index.rst                   |  1 +
 3 files changed, 65 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (83%)

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
new file mode 100644
index 000000000000..0db4f2fcd7f0
--- /dev/null
+++ b/Documentation/PCI/endpoint/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+PCI Endpoint Framework
+======================
+
+.. toctree::
+   :maxdepth: 2
+
+   pci-endpoint
diff --git a/Documentation/PCI/endpoint/pci-endpoint.txt b/Documentation/PCI/endpoint/pci-endpoint.rst
similarity index 83%
rename from Documentation/PCI/endpoint/pci-endpoint.txt
rename to Documentation/PCI/endpoint/pci-endpoint.rst
index e86a96b66a6a..0e2311b5617b 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.txt
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -1,11 +1,13 @@
-			    PCI ENDPOINT FRAMEWORK
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Kishon Vijay Abraham I <kishon@ti.com>
 
 This document is a guide to use the PCI Endpoint Framework in order to create
 endpoint controller driver, endpoint function driver, and using configfs
 interface to bind the function driver to the controller driver.
 
-1. Introduction
+Introduction
+============
 
 Linux has a comprehensive PCI subsystem to support PCI controllers that
 operates in Root Complex mode. The subsystem has capability to scan PCI bus,
@@ -19,26 +21,30 @@ add endpoint mode support in Linux. This will help to run Linux in an
 EP system which can have a wide variety of use cases from testing or
 validation, co-processor accelerator, etc.
 
-2. PCI Endpoint Core
+PCI Endpoint Core
+=================
 
 The PCI Endpoint Core layer comprises 3 components: the Endpoint Controller
 library, the Endpoint Function library, and the configfs layer to bind the
 endpoint function with the endpoint controller.
 
-2.1 PCI Endpoint Controller(EPC) Library
+PCI Endpoint Controller(EPC) Library
+------------------------------------
 
 The EPC library provides APIs to be used by the controller that can operate
 in endpoint mode. It also provides APIs to be used by function driver/library
 in order to implement a particular endpoint function.
 
-2.1.1 APIs for the PCI controller Driver
+APIs for the PCI controller Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI controller driver.
 
-*) devm_pci_epc_create()/pci_epc_create()
+* devm_pci_epc_create()/pci_epc_create()
 
    The PCI controller driver should implement the following ops:
+
 	 * write_header: ops to populate configuration space header
 	 * set_bar: ops to configure the BAR
 	 * clear_bar: ops to reset the BAR
@@ -51,110 +57,116 @@ by the PCI controller driver.
    The PCI controller driver can then create a new EPC device by invoking
    devm_pci_epc_create()/pci_epc_create().
 
-*) devm_pci_epc_destroy()/pci_epc_destroy()
+* devm_pci_epc_destroy()/pci_epc_destroy()
 
    The PCI controller driver can destroy the EPC device created by either
    devm_pci_epc_create() or pci_epc_create() using devm_pci_epc_destroy() or
    pci_epc_destroy().
 
-*) pci_epc_linkup()
+* pci_epc_linkup()
 
    In order to notify all the function devices that the EPC device to which
    they are linked has established a link with the host, the PCI controller
    driver should invoke pci_epc_linkup().
 
-*) pci_epc_mem_init()
+* pci_epc_mem_init()
 
    Initialize the pci_epc_mem structure used for allocating EPC addr space.
 
-*) pci_epc_mem_exit()
+* pci_epc_mem_exit()
 
    Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
 
-2.1.2 APIs for the PCI Endpoint Function Driver
+
+APIs for the PCI Endpoint Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint function driver.
 
-*) pci_epc_write_header()
+* pci_epc_write_header()
 
    The PCI endpoint function driver should use pci_epc_write_header() to
    write the standard configuration header to the endpoint controller.
 
-*) pci_epc_set_bar()
+* pci_epc_set_bar()
 
    The PCI endpoint function driver should use pci_epc_set_bar() to configure
    the Base Address Register in order for the host to assign PCI addr space.
    Register space of the function driver is usually configured
    using this API.
 
-*) pci_epc_clear_bar()
+* pci_epc_clear_bar()
 
    The PCI endpoint function driver should use pci_epc_clear_bar() to reset
    the BAR.
 
-*) pci_epc_raise_irq()
+* pci_epc_raise_irq()
 
    The PCI endpoint function driver should use pci_epc_raise_irq() to raise
    Legacy Interrupt, MSI or MSI-X Interrupt.
 
-*) pci_epc_mem_alloc_addr()
+* pci_epc_mem_alloc_addr()
 
    The PCI endpoint function driver should use pci_epc_mem_alloc_addr(), to
    allocate memory address from EPC addr space which is required to access
    RC's buffer
 
-*) pci_epc_mem_free_addr()
+* pci_epc_mem_free_addr()
 
    The PCI endpoint function driver should use pci_epc_mem_free_addr() to
    free the memory space allocated using pci_epc_mem_alloc_addr().
 
-2.1.3 Other APIs
+Other APIs
+~~~~~~~~~~
 
 There are other APIs provided by the EPC library. These are used for binding
 the EPF device with EPC device. pci-ep-cfs.c can be used as reference for
 using these APIs.
 
-*) pci_epc_get()
+* pci_epc_get()
 
    Get a reference to the PCI endpoint controller based on the device name of
    the controller.
 
-*) pci_epc_put()
+* pci_epc_put()
 
    Release the reference to the PCI endpoint controller obtained using
    pci_epc_get()
 
-*) pci_epc_add_epf()
+* pci_epc_add_epf()
 
    Add a PCI endpoint function to a PCI endpoint controller. A PCIe device
    can have up to 8 functions according to the specification.
 
-*) pci_epc_remove_epf()
+* pci_epc_remove_epf()
 
    Remove the PCI endpoint function from PCI endpoint controller.
 
-*) pci_epc_start()
+* pci_epc_start()
 
    The PCI endpoint function driver should invoke pci_epc_start() once it
    has configured the endpoint function and wants to start the PCI link.
 
-*) pci_epc_stop()
+* pci_epc_stop()
 
    The PCI endpoint function driver should invoke pci_epc_stop() to stop
    the PCI LINK.
 
-2.2 PCI Endpoint Function(EPF) Library
+
+PCI Endpoint Function(EPF) Library
+----------------------------------
 
 The EPF library provides APIs to be used by the function driver and the EPC
 library to provide endpoint mode functionality.
 
-2.2.1 APIs for the PCI Endpoint Function Driver
+APIs for the PCI Endpoint Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint function driver.
 
-*) pci_epf_register_driver()
+* pci_epf_register_driver()
 
    The PCI Endpoint Function driver should implement the following ops:
 	 * bind: ops to perform when a EPC device has been bound to EPF device
@@ -166,50 +178,54 @@ by the PCI endpoint function driver.
   The PCI Function driver can then register the PCI EPF driver by using
   pci_epf_register_driver().
 
-*) pci_epf_unregister_driver()
+* pci_epf_unregister_driver()
 
   The PCI Function driver can unregister the PCI EPF driver by using
   pci_epf_unregister_driver().
 
-*) pci_epf_alloc_space()
+* pci_epf_alloc_space()
 
   The PCI Function driver can allocate space for a particular BAR using
   pci_epf_alloc_space().
 
-*) pci_epf_free_space()
+* pci_epf_free_space()
 
   The PCI Function driver can free the allocated space
   (using pci_epf_alloc_space) by invoking pci_epf_free_space().
 
-2.2.2 APIs for the PCI Endpoint Controller Library
+APIs for the PCI Endpoint Controller Library
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint controller library.
 
-*) pci_epf_linkup()
+* pci_epf_linkup()
 
    The PCI endpoint controller library invokes pci_epf_linkup() when the
    EPC device has established the connection to the host.
 
-2.2.2 Other APIs
+Other APIs
+~~~~~~~~~~
+
 There are other APIs provided by the EPF library. These are used to notify
 the function driver when the EPF device is bound to the EPC device.
 pci-ep-cfs.c can be used as reference for using these APIs.
 
-*) pci_epf_create()
+* pci_epf_create()
 
    Create a new PCI EPF device by passing the name of the PCI EPF device.
    This name will be used to bind the the EPF device to a EPF driver.
 
-*) pci_epf_destroy()
+* pci_epf_destroy()
 
    Destroy the created PCI EPF device.
 
-*) pci_epf_bind()
+* pci_epf_bind()
 
    pci_epf_bind() should be invoked when the EPF device has been bound to
    a EPC device.
 
-*) pci_epf_unbind()
+* pci_epf_unbind()
 
    pci_epf_unbind() should be invoked when the binding between EPC device
    and EPF device is lost.
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index f54b65b1ca5f..f4c6121868c3 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -15,3 +15,4 @@ Linux PCI Bus Subsystem
    acpi-info
    pci-error-recovery
    pcieaer-howto
+   endpoint/index
-- 
2.20.1

