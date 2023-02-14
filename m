Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91753696B85
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 18:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjBNR2z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 12:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjBNR2t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 12:28:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9CC2C656
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 09:28:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80543617CE
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 17:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA01CC433D2;
        Tue, 14 Feb 2023 17:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676395712;
        bh=rS6Frpxsdzt30xsGDz5wEFS6DhZa3opphrBlmeXJdBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BaNOg4jN+Urt1Artq3y9/G4YvsSjpRjC7Dv5yctqCgpgdeNeb9i3dUvSbq+Hj8rJw
         72e3ZF45BDc9ziPviK3g+tMuBmFCF0/RyvLuT0uH0N94bqTIqlT+pbUt6gmq85plXr
         ezQihiVwTutGgaUcRhwybeXMGbHUdbl5ISfx7y4v7EXVXG9+q0Y0kIgFwnJEnhiC0j
         hRSSwB4r45ZhXYCRRDWeTBwuqwBk2n3qVc9muUxzsn9lL4sVB6mz1dQA4WU3zZF3h0
         RUV8c9HZ7R0ub4xF/OXO3a5qQzrBOoYxftEMPiTw9WNXNe5Sg04rphRE55hXkG8GaN
         ZZOAzTzEkvoWQ==
Date:   Tue, 14 Feb 2023 11:28:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        bhelgaas@google.com, lukas@wunner.de, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] PCI/AER: Remove deprecated documentation for
 pcie_enable_pcie_error_reporting()
Message-ID: <20230214172831.GA3046378@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167639333373.777843.2141436875951823865.stgit@djiang5-mobl3.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Stefan, Sathy, Jonathan]

On Tue, Feb 14, 2023 at 09:48:55AM -0700, Dave Jiang wrote:
> With commit [1] upstream that enables AER reporting by default for all PCIe
> devices, the documentation for pcie_enable_pcie_error_reporting() is no
> longer necessary. Remove references to the helper function.
> 
> [1]: commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Thanks!  I'll attach my work-in-progress patch from yesterday for your
comments.  I think we can go even a little further because I don't
think we need to encourage drivers to configure AER registers (if they
do, they almost certainly don't pay attention to ownership via _OSC),
and if they don't use pci_enable_pcie_error_reporting(), they
shouldn't use pci_disable_pcie_error_reporting() either.

> ---
>  Documentation/PCI/pcieaer-howto.rst |   18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 0b36b9ebfa4b..a82802795a06 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
>  errors because device specific errors will still get sent directly to
>  the device driver.
>  
> -Configure the AER capability structure
> ---------------------------------------
> -
> -AER aware drivers of PCI Express component need change the device
> -control registers to enable AER. They also could change AER registers,
> -including mask and severity registers. Helper function
> -pci_enable_pcie_error_reporting could be used to enable AER. See
> -section 3.3.
> -
>  Provide callbacks
>  -----------------
>  
> @@ -214,15 +205,6 @@ to mmio_enabled.
>  
>  helper functions
>  ----------------
> -::
> -
> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
> -
> -pci_enable_pcie_error_reporting enables the device to send error
> -messages to root port when an error is detected. Note that devices
> -don't enable the error reporting by default, so device drivers need
> -call this function to enable it.
> -
>  ::
>  
>    int pci_disable_pcie_error_reporting(struct pci_dev *dev);


commit d7b36abe72db ("Remove AER Capability configuration")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Feb 13 11:53:42 2023 -0600

    Remove AER Capability configuration

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 0b36b9ebfa4b..c98a229ea9f5 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -96,8 +96,8 @@ Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 Developer Guide
 ===============
 
-To enable AER aware support requires a software driver to configure
-the AER capability structure within its device and to provide callbacks.
+To enable AER aware support requires a software driver to provide
+callbacks.
 
 To support AER better, developers need understand how AER does work
 firstly.
@@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
 errors because device specific errors will still get sent directly to
 the device driver.
 
-Configure the AER capability structure
---------------------------------------
-
-AER aware drivers of PCI Express component need change the device
-control registers to enable AER. They also could change AER registers,
-including mask and severity registers. Helper function
-pci_enable_pcie_error_reporting could be used to enable AER. See
-section 3.3.
-
 Provide callbacks
 -----------------
 
@@ -212,31 +203,6 @@ to reset the link. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER
 and reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
 to mmio_enabled.
 
-helper functions
-----------------
-::
-
-  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
-
-pci_enable_pcie_error_reporting enables the device to send error
-messages to root port when an error is detected. Note that devices
-don't enable the error reporting by default, so device drivers need
-call this function to enable it.
-
-::
-
-  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
-
-pci_disable_pcie_error_reporting disables the device to send error
-messages to root port when an error is detected.
-
-::
-
-  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);`
-
-pci_aer_clear_nonfatal_status clears non-fatal errors in the uncorrectable
-error status register.
-
 Frequent Asked Questions
 ------------------------
 
@@ -257,24 +223,6 @@ A:
   Fatal error recovery will fail if the errors are reported by the
   upstream ports who are attached by the service driver.
 
-Q:
-  How does this infrastructure deal with driver that is not PCI
-  Express aware?
-
-A:
-  This infrastructure calls the error callback functions of the
-  driver when an error happens. But if the driver is not aware of
-  PCI Express, the device might not report its own errors to root
-  port.
-
-Q:
-  What modifications will that driver need to make it compatible
-  with the PCI Express AER Root driver?
-
-A:
-  It could call the helper functions to enable AER in devices and
-  cleanup uncorrectable status register. Pls. refer to section 3.3.
-
 
 Software error injection
 ========================
