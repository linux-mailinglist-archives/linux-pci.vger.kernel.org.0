Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03F01B824
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfEMOVJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:21:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41108 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfEMOVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:21:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so6861583pgp.8;
        Mon, 13 May 2019 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ex05UlsVf7zPkC8vKuBv59szZ5k0T06G1zt3aeIQzkE=;
        b=NZU8gy+KJnrP0krbYzAW61rwPqVlygxLVOCfvrEHTq0dhby9E+MJvz0jKavTN1UkzH
         zodsO064149IGCNVXEF61k7A7/WsEUFf8fynlbqCiH4kWzNXFBHThPEAMd64gThqe5p0
         PC3MVi/qwgV2U1tLF6u3xdwXnKv1GSK+p5QFqjdXL51xssXeXbRaXMU/ov6aKXv+wlg+
         PUaZiU7DWbMvqwSLibpT4hOSZxng7VpgucTWPZcVO1yyDrxkvbV93Rqp75svCplrAXny
         +4GpZtuKzxG8coiRmeb0Lo5fYY/rNxn8h3gMtpVjAJDpJmgiV2sG9VE+o+kCBgeXubIs
         70eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ex05UlsVf7zPkC8vKuBv59szZ5k0T06G1zt3aeIQzkE=;
        b=qrh2OGC3/hRoMWZi9j9NLg+REcTzrNwRFUV7KxNcYgx/pUW+Rwj9iQa0FBh/q68OxE
         L68iRXEn6gIzTNdNJ3GgEg3aVh766PJwXD82wMAArMHTanMHhLLlIg/afQLup9qOpuXe
         BN1DIJ80PR4idhC3sXt2Oq4NQ5cRJuVe/ktTIS6fLOHS6a96/Rgxn4+P65hNseIpAL1J
         4ZUsiCWI/QXh9RjyLhzwiusHW0wO6CUD7ONWH42XX8e/bB7vDScdCjhNQaw19jbnVrVe
         68rR0sM6qvtEkkjafCNnumUoxnYSUcq3auN0RBsAtNlDfHpiLoIBqvsvShLoGEFlSVX3
         0+xg==
X-Gm-Message-State: APjAAAUuOTnCm9Bkq8OuUpbEQ8kotb9bsAgSxrW0BekHgR16OmbcRvWt
        91YNXruqchszbnvlp8ZrsGXoZUBY
X-Google-Smtp-Source: APXvYqw7oXx1eu6UK65GGyEXwq357QLXTGabuBDgrNliRG3ZZIqSXgTjHHLw96bSL6K07YFD/K6NVw==
X-Received: by 2002:a65:640c:: with SMTP id a12mr7016683pgv.1.1557757268304;
        Mon, 13 May 2019 07:21:08 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id x30sm15382513pgl.76.2019.05.13.07.21.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:21:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 09/12] Documentation: PCI: convert endpoint/pci-endpoint.txt to reST
Date:   Mon, 13 May 2019 22:19:57 +0800
Message-Id: <20190513142000.3524-10-changbin.du@gmail.com>
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
 Documentation/PCI/endpoint/index.rst          | 10 ++
 .../{pci-endpoint.txt => pci-endpoint.rst}    | 96 +++++++++++--------
 Documentation/PCI/index.rst                   |  1 +
 3 files changed, 69 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (82%)

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
similarity index 82%
rename from Documentation/PCI/endpoint/pci-endpoint.txt
rename to Documentation/PCI/endpoint/pci-endpoint.rst
index e86a96b66a6a..693f3a2ad7a4 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.txt
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -1,11 +1,17 @@
-			    PCI ENDPOINT FRAMEWORK
-		    Kishon Vijay Abraham I <kishon@ti.com>
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+PCI Endpoint Framework
+======================
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
@@ -19,26 +25,30 @@ add endpoint mode support in Linux. This will help to run Linux in an
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
@@ -51,110 +61,116 @@ by the PCI controller driver.
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
@@ -166,50 +182,54 @@ by the PCI endpoint function driver.
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

