Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3BA1B951
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfEMO6M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:58:12 -0400
Received: from casper.infradead.org ([85.118.1.10]:52480 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbfEMO6M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V0SzVw8M6uJN/hRq9YRAL1GZTn5ATVLwpBgGDOIviro=; b=qdSiLKpQebxyf5h9UBOOu7CuMj
        IciOICZwhkr4yLAAgi8kCl7G/SAZdNk9ZC3izFPhWdBhLNd/y6WDl6YSGqXrtUfdTGTerG8CUgskI
        uTGJKVW8M6Vc7jwRsHQMK/q8zcrLEh9izBQOUVQuVN3kkl6rjq7HMr5ZaBfyu2jKbqPJ2+MRQsFZM
        gfdLQMcHwfYpHwPxKqRbSNqsLeWxgOZaxvg1uQFH68EcXljB1POB+DIJTuXDt8LuGvqF2R0Oy+J5r
        jCbfrsnpqpNO+iMIKtEng7Yp4CixKsdXpl/qwzx9XOym8k936Y62szgyuUaALxmBxc39EepajyxTC
        xHzMIBvA==;
Received: from [179.179.44.200] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQCP0-0002iu-RJ; Mon, 13 May 2019 14:58:07 +0000
Date:   Mon, 13 May 2019 11:58:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/12] Documentation: PCI: convert pcieaer-howto.txt
 to reST
Message-ID: <20190513115802.7dcd3166@coco.lan>
In-Reply-To: <20190513142000.3524-9-changbin.du@gmail.com>
References: <20190513142000.3524-1-changbin.du@gmail.com>
        <20190513142000.3524-9-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Mon, 13 May 2019 22:19:56 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/PCI/index.rst                   |   1 +
>  .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 156 +++++++++++-------
>  2 files changed, 101 insertions(+), 56 deletions(-)
>  rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (72%)
> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 92e62d0fc9e6..f54b65b1ca5f 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -14,3 +14,4 @@ Linux PCI Bus Subsystem
>     msi-howto
>     acpi-info
>     pci-error-recovery
> +   pcieaer-howto
> diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.rst
> similarity index 72%
> rename from Documentation/PCI/pcieaer-howto.txt
> rename to Documentation/PCI/pcieaer-howto.rst
> index 48ce7903e3c6..18bdefaafd1a 100644
> --- a/Documentation/PCI/pcieaer-howto.txt
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -1,21 +1,29 @@
> -   The PCI Express Advanced Error Reporting Driver Guide HOWTO
> -		T. Long Nguyen	<tom.l.nguyen@intel.com>
> -		Yanmin Zhang	<yanmin.zhang@intel.com>
> -				07/29/2006
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>  
> +===========================================================
> +The PCI Express Advanced Error Reporting Driver Guide HOWTO
> +===========================================================
>  
> -1. Overview
> +:Authors: - T. Long Nguyen <tom.l.nguyen@intel.com>
> +          - Yanmin Zhang <yanmin.zhang@intel.com>
>  
> -1.1 About this guide
> +:Copyright: |copy| 2006 Intel Corporation
> +
> +Overview
> +===========
> +
> +About this guide
> +----------------
>  
>  This guide describes the basics of the PCI Express Advanced Error
>  Reporting (AER) driver and provides information on how to use it, as
>  well as how to enable the drivers of endpoint devices to conform with
>  PCI Express AER driver.
>  
> -1.2 Copyright (C) Intel Corporation 2006.
>  
> -1.3 What is the PCI Express AER Driver?
> +What is the PCI Express AER Driver?
> +-----------------------------------
>  
>  PCI Express error signaling can occur on the PCI Express link itself
>  or on behalf of transactions initiated on the link. PCI Express
> @@ -30,17 +38,19 @@ The PCI Express AER driver provides the infrastructure to support PCI
>  Express Advanced Error Reporting capability. The PCI Express AER
>  driver provides three basic functions:
>  
> --	Gathers the comprehensive error information if errors occurred.
> --	Reports error to the users.
> --	Performs error recovery actions.
> +  - Gathers the comprehensive error information if errors occurred.
> +  - Reports error to the users.
> +  - Performs error recovery actions.
>  
>  AER driver only attaches root ports which support PCI-Express AER
>  capability.
>  
>  
> -2. User Guide
> +User Guide
> +==========
>  
> -2.1 Include the PCI Express AER Root Driver into the Linux Kernel
> +Include the PCI Express AER Root Driver into the Linux Kernel
> +-------------------------------------------------------------
>  
>  The PCI Express AER Root driver is a Root Port service driver attached
>  to the PCI Express Port Bus driver. If a user wants to use it, the driver
> @@ -48,7 +58,8 @@ has to be compiled. Option CONFIG_PCIEAER supports this capability. It
>  depends on CONFIG_PCIEPORTBUS, so pls. set CONFIG_PCIEPORTBUS=y and
>  CONFIG_PCIEAER = y.
>  
> -2.2 Load PCI Express AER Root Driver
> +Load PCI Express AER Root Driver
> +--------------------------------
>  
>  Some systems have AER support in firmware. Enabling Linux AER support at
>  the same time the firmware handles AER may result in unpredictable
> @@ -56,30 +67,34 @@ behavior. Therefore, Linux does not handle AER events unless the firmware
>  grants AER control to the OS via the ACPI _OSC method. See the PCI FW 3.0
>  Specification for details regarding _OSC usage.
>  
> -2.3 AER error output
> +AER error output
> +----------------
>  
>  When a PCIe AER error is captured, an error message will be output to
>  console. If it's a correctable error, it is output as a warning.
>  Otherwise, it is printed as an error. So users could choose different
>  log level to filter out correctable error messages.
>  
> -Below shows an example:
> -0000:50:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0500(Requester ID)
> -0000:50:00.0:   device [8086:0329] error status/mask=00100000/00000000
> -0000:50:00.0:    [20] Unsupported Request    (First)
> -0000:50:00.0:   TLP Header: 04000001 00200a03 05010000 00050100
> +Below shows an example::
> +
> +  0000:50:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0500(Requester ID)
> +  0000:50:00.0:   device [8086:0329] error status/mask=00100000/00000000
> +  0000:50:00.0:    [20] Unsupported Request    (First)
> +  0000:50:00.0:   TLP Header: 04000001 00200a03 05010000 00050100
>  
>  In the example, 'Requester ID' means the ID of the device who sends
>  the error message to root port. Pls. refer to pci express specs for
>  other fields.
>  
> -2.4 AER Statistics / Counters
> +AER Statistics / Counters
> +-------------------------
>  
>  When PCIe AER errors are captured, the counters / statistics are also exposed
>  in the form of sysfs attributes which are documented at
>  Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>  
> -3. Developer Guide
> +Developer Guide
> +===============
>  
>  To enable AER aware support requires a software driver to configure
>  the AER capability structure within its device and to provide callbacks.
> @@ -120,7 +135,8 @@ hierarchy and links. These errors do not include any device specific
>  errors because device specific errors will still get sent directly to
>  the device driver.
>  
> -3.1 Configure the AER capability structure
> +Configure the AER capability structure
> +--------------------------------------
>  
>  AER aware drivers of PCI Express component need change the device
>  control registers to enable AER. They also could change AER registers,
> @@ -128,9 +144,11 @@ including mask and severity registers. Helper function
>  pci_enable_pcie_error_reporting could be used to enable AER. See
>  section 3.3.
>  
> -3.2. Provide callbacks
> +Provide callbacks
> +-----------------
>  
> -3.2.1 callback reset_link to reset pci express link
> +callback reset_link to reset pci express link
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  This callback is used to reset the pci express physical link when a
>  fatal error happens. The root port aer service driver provides a
> @@ -140,13 +158,15 @@ upstream ports should provide their own reset_link functions.
>  
>  In struct pcie_port_service_driver, a new pointer, reset_link, is
>  added.
> +::
>  
> -pci_ers_result_t (*reset_link) (struct pci_dev *dev);
> +	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
>  
>  Section 3.2.2.2 provides more detailed info on when to call
>  reset_link.
>  
> -3.2.2 PCI error-recovery callbacks
> +PCI error-recovery callbacks
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  The PCI Express AER Root driver uses error callbacks to coordinate
>  with downstream device drivers associated with a hierarchy in question
> @@ -161,7 +181,8 @@ definitions of the callbacks.
>  
>  Below sections specify when to call the error callback functions.
>  
> -3.2.2.1 Correctable errors
> +Correctable errors
> +~~~~~~~~~~~~~~~~~~
>  
>  Correctable errors pose no impacts on the functionality of
>  the interface. The PCI Express protocol can recover without any
> @@ -169,13 +190,16 @@ software intervention or any loss of data. These errors do not
>  require any recovery actions. The AER driver clears the device's
>  correctable error status register accordingly and logs these errors.
>  
> -3.2.2.2 Non-correctable (non-fatal and fatal) errors
> +Non-correctable (non-fatal and fatal) errors
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  If an error message indicates a non-fatal error, performing link reset
>  at upstream is not required. The AER driver calls error_detected(dev,
>  pci_channel_io_normal) to all drivers associated within a hierarchy in
> -question. for example,
> -EndPoint<==>DownstreamPort B<==>UpstreamPort A<==>RootPort.
> +question. for example::
> +
> +  EndPoint<==>DownstreamPort B<==>UpstreamPort A<==>RootPort
> +
>  If Upstream port A captures an AER error, the hierarchy consists of
>  Downstream port B and EndPoint.
>  
> @@ -199,53 +223,72 @@ function. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER and
>  reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
>  to mmio_enabled.
>  
> -3.3 helper functions
> +helper functions
> +----------------
> +::
> +
> +  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  
> -3.3.1 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  pci_enable_pcie_error_reporting enables the device to send error
>  messages to root port when an error is detected. Note that devices
>  don't enable the error reporting by default, so device drivers need
>  call this function to enable it.
>  
> -3.3.2 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> +::
> +
> +  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> +
>  pci_disable_pcie_error_reporting disables the device to send error
>  messages to root port when an error is detected.
>  
> -3.3.3 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
> +::
> +
> +  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);`
> +
>  pci_cleanup_aer_uncorrect_error_status cleanups the uncorrectable
>  error status register.
>  
> -3.4 Frequent Asked Questions
> +Frequent Asked Questions
> +------------------------
>  
> -Q: What happens if a PCI Express device driver does not provide an
> -error recovery handler (pci_driver->err_handler is equal to NULL)?
> +Q:
> +  What happens if a PCI Express device driver does not provide an
> +  error recovery handler (pci_driver->err_handler is equal to NULL)?
>  
> -A: The devices attached with the driver won't be recovered. If the
> -error is fatal, kernel will print out warning messages. Please refer
> -to section 3 for more information.
> +A:
> +  The devices attached with the driver won't be recovered. If the
> +  error is fatal, kernel will print out warning messages. Please refer
> +  to section 3 for more information.
>  
> -Q: What happens if an upstream port service driver does not provide
> -callback reset_link?
> +Q:
> +  What happens if an upstream port service driver does not provide
> +  callback reset_link?
>  
> -A: Fatal error recovery will fail if the errors are reported by the
> -upstream ports who are attached by the service driver.
> +A:
> +  Fatal error recovery will fail if the errors are reported by the
> +  upstream ports who are attached by the service driver.
>  
> -Q: How does this infrastructure deal with driver that is not PCI
> -Express aware?
> +Q:
> +  How does this infrastructure deal with driver that is not PCI
> +  Express aware?
>  
> -A: This infrastructure calls the error callback functions of the
> -driver when an error happens. But if the driver is not aware of
> -PCI Express, the device might not report its own errors to root
> -port.
> +A:
> +  This infrastructure calls the error callback functions of the
> +  driver when an error happens. But if the driver is not aware of
> +  PCI Express, the device might not report its own errors to root
> +  port.
>  
> -Q: What modifications will that driver need to make it compatible
> -with the PCI Express AER Root driver?
> +Q:
> +  What modifications will that driver need to make it compatible
> +  with the PCI Express AER Root driver?
>  
> -A: It could call the helper functions to enable AER in devices and
> -cleanup uncorrectable status register. Pls. refer to section 3.3.
> +A:
> +  It could call the helper functions to enable AER in devices and
> +  cleanup uncorrectable status register. Pls. refer to section 3.3.
>  
>  
> -4. Software error injection
> +Software error injection
> +========================
>  
>  Debugging PCIe AER error recovery code is quite difficult because it
>  is hard to trigger real hardware errors. Software based error
> @@ -261,6 +304,7 @@ After reboot with new kernel or insert the module, a device file named
>  
>  Then, you need a user space tool named aer-inject, which can be gotten
>  from:
> +
>      https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
>  
>  More information about aer-inject can be found in the document comes



Thanks,
Mauro
