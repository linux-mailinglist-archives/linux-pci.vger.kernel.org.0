Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6285696DA5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 20:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBNTQK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 14:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBNTQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 14:16:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5A25E2B
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676402166; x=1707938166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zQ3Sc2gkCNSsIS25bCpvOopFFho+sIkO7Q0S8KShPww=;
  b=TaI7f7YFTksFn+J3Vop1Tv8oAy/I77TTtlF1IJ3k/sWl8rDdVEnhOWj/
   deICt1aSS4ppgN03aU9JO2J5iQLsgtPoiefMXW1cV24xtx21I4EWqJrwi
   RqcVWsixvLrV8dGLFJ+xe1fqOcc9X7QmCH/ZH9JEWI6DDtLU3wj3CRpl+
   UTiCVy2W5ad5cLbWw0oh8D3vBSMYlcpkwsEvEQ522aHnnaDQpmzwPHCA5
   l0rN5mh78jGSyCO8unskULmq/GdyAJjiyD5NRO1Z9IQ7uhyNfrP7Weved
   yqOks3SBmnAfUZkzdK/6kdqdM/mMUPVRf5XC9ksNYzLKZg6ceAk3ikjoh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417464334"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="417464334"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:16:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="758100910"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="758100910"
Received: from mmerajah-mobl1.amr.corp.intel.com (HELO [10.209.112.27]) ([10.209.112.27])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:16:05 -0800
Message-ID: <142aee8d-58da-8db9-6c86-ca61e4d7006a@linux.intel.com>
Date:   Tue, 14 Feb 2023 11:16:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI/AER: Remove deprecated documentation for
 pcie_enable_pcie_error_reporting()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        bhelgaas@google.com, lukas@wunner.de, Stefan Roese <sr@denx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20230214172831.GA3046378@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230214172831.GA3046378@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/14/23 9:28 AM, Bjorn Helgaas wrote:
> [+cc Stefan, Sathy, Jonathan]
> 
> On Tue, Feb 14, 2023 at 09:48:55AM -0700, Dave Jiang wrote:
>> With commit [1] upstream that enables AER reporting by default for all PCIe
>> devices, the documentation for pcie_enable_pcie_error_reporting() is no
>> longer necessary. Remove references to the helper function.
>>
>> [1]: commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks!  I'll attach my work-in-progress patch from yesterday for your
> comments.  I think we can go even a little further because I don't
> think we need to encourage drivers to configure AER registers (if they
> do, they almost certainly don't pay attention to ownership via _OSC),
> and if they don't use pci_enable_pcie_error_reporting(), they
> shouldn't use pci_disable_pcie_error_reporting() either.
> 
>> ---
>>  Documentation/PCI/pcieaer-howto.rst |   18 ------------------
>>  1 file changed, 18 deletions(-)
>>
>> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
>> index 0b36b9ebfa4b..a82802795a06 100644
>> --- a/Documentation/PCI/pcieaer-howto.rst
>> +++ b/Documentation/PCI/pcieaer-howto.rst
>> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
>>  errors because device specific errors will still get sent directly to
>>  the device driver.
>>  
>> -Configure the AER capability structure
>> ---------------------------------------
>> -
>> -AER aware drivers of PCI Express component need change the device
>> -control registers to enable AER. They also could change AER registers,
>> -including mask and severity registers. Helper function
>> -pci_enable_pcie_error_reporting could be used to enable AER. See
>> -section 3.3.
>> -
>>  Provide callbacks
>>  -----------------
>>  
>> @@ -214,15 +205,6 @@ to mmio_enabled.
>>  
>>  helper functions
>>  ----------------
>> -::
>> -
>> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>> -
>> -pci_enable_pcie_error_reporting enables the device to send error
>> -messages to root port when an error is detected. Note that devices
>> -don't enable the error reporting by default, so device drivers need
>> -call this function to enable it.
>> -
>>  ::
>>  
>>    int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> 
> 
> commit d7b36abe72db ("Remove AER Capability configuration")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Mon Feb 13 11:53:42 2023 -0600
> 
>     Remove AER Capability configuration
> 

Looks good to me.

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
