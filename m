Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD7872A6BB
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 01:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjFIX3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 19:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIX22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 19:28:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34C13C32
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686353284; x=1717889284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w4D6k0q2vu5/T+/+zBtXnybmzHKxbDsgwYqnQVxm7ew=;
  b=eQKkyxXKaj8X8Pk03FABAyyjjBfZa6eKZoJj2h9fMa0rMcKPZudRAGq5
   qxVym2WRJ2bgxf4dxDsjcIgZ5gq6yU+hljm3dPCv0oI0/wtM4GV5jp0LQ
   NNZmPmqVhsDj3cQZ+M3XcJ24olC9kmFFRZNh4c7YS3p4uplTefY/3rZSm
   fY6dsqvwYFgUEsy6cPGu6dTpqCLaHUNWYkgNxFObX/+YYIDByJyRNkX8l
   r3WL+zdY+zIDj2dlwRo9OHwNLFBFKr8mB602wYt+bduKb6Sjs9l0nwCsN
   dr9qvWCMRPlwAsqw2tfp6eKbxsKchlk4/29DrJNVAMgwZosmBWdYRwfeH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="342382172"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="342382172"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 16:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="780477075"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="780477075"
Received: from morganhu-mobl.amr.corp.intel.com (HELO [10.212.133.89]) ([10.212.133.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 16:28:03 -0700
Message-ID: <0b14f065-2960-d015-1bbc-ae361c6bfad8@linux.intel.com>
Date:   Fri, 9 Jun 2023 16:28:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] Documentation: PCI: Drop recommendation to
 configure AER Capability
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230609222500.1267795-1-helgaas@kernel.org>
 <20230609222500.1267795-3-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230609222500.1267795-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/9/23 3:24 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
> the PCI core enables PCIe device error reporting for all devices during
> enumeration, so drivers don't need to do it.
> 
> Remove the recommendation for drivers to configure AER and call
> pci_enable_pcie_error_reporting() themselves.
> 
> Also remove the suggestion that drivers may change AER mask and severity
> registers.  Ownership of these registers is negotiated between the OS and
> platform firmware.  If firmware owns these registers, the OS must not
> change them.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Stefan Roese <sr@denx.de>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  Documentation/PCI/pcieaer-howto.rst | 56 ++---------------------------
>  1 file changed, 2 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 0b36b9ebfa4b..c98a229ea9f5 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -96,8 +96,8 @@ Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>  Developer Guide
>  ===============
>  
> -To enable AER aware support requires a software driver to configure
> -the AER capability structure within its device and to provide callbacks.
> +To enable AER aware support requires a software driver to provide
> +callbacks.
>  
>  To support AER better, developers need understand how AER does work
>  firstly.
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
> @@ -212,31 +203,6 @@ to reset the link. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER
>  and reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
>  to mmio_enabled.
>  
> -helper functions
> -----------------
> -::
> -
> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
> -
> -pci_enable_pcie_error_reporting enables the device to send error
> -messages to root port when an error is detected. Note that devices
> -don't enable the error reporting by default, so device drivers need
> -call this function to enable it.
> -
> -::
> -
> -  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> -
> -pci_disable_pcie_error_reporting disables the device to send error
> -messages to root port when an error is detected.
> -
> -::
> -
> -  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);`
> -
> -pci_aer_clear_nonfatal_status clears non-fatal errors in the uncorrectable
> -error status register.
> -
>  Frequent Asked Questions
>  ------------------------
>  
> @@ -257,24 +223,6 @@ A:
>    Fatal error recovery will fail if the errors are reported by the
>    upstream ports who are attached by the service driver.
>  
> -Q:
> -  How does this infrastructure deal with driver that is not PCI
> -  Express aware?
> -
> -A:
> -  This infrastructure calls the error callback functions of the
> -  driver when an error happens. But if the driver is not aware of
> -  PCI Express, the device might not report its own errors to root
> -  port.
> -
> -Q:
> -  What modifications will that driver need to make it compatible
> -  with the PCI Express AER Root driver?
> -
> -A:
> -  It could call the helper functions to enable AER in devices and
> -  cleanup uncorrectable status register. Pls. refer to section 3.3.
> -
>  
>  Software error injection
>  ========================

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
