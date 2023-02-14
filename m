Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06CC696BD5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 18:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjBNRh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 12:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBNRh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 12:37:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D89C5
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 09:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676396246; x=1707932246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9tRS7qUz5baIgujub6urgBDxfr1dFs8D7ambK0yp+V4=;
  b=UeTdfnWRem0DUWOrKg0nbR0VrUOvyJGTrH+8uCPYgzyMoBIdjjR4xxXP
   PEXR5Gcqr8Ma1g9JQ/2IDFjMzvGox7hxzEWA+u9VErJh/t5BFRkR16R4g
   OIZN2+KgS1x4nAm6bv2XqPu5m4Yh70UKqobcbM4oa2sS7YW+EEz8h6rky
   a2UfXZU7Aym2hLiNTVR41fhLu4HiAsE5HJn9UGl+gQbgJa5WaVU5E4gbk
   9SwCnyCMU4aenG448D1klLFJLnzsueUNhD/aoxx48nsNS1fq9MPnLd/R1
   vMYxe4Lk9ROGpEe0juHwmLijaWSZDGvZrHMB9Aj1sblOu4mnV3rNeU9Xt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329843446"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="329843446"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:37:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="998156982"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="998156982"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.93.192]) ([10.212.93.192])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:37:02 -0800
Message-ID: <17f976ba-060e-8ff4-fa9c-bf06e69aa87a@intel.com>
Date:   Tue, 14 Feb 2023 10:37:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] PCI/AER: Remove deprecated documentation for
 pcie_enable_pcie_error_reporting()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        bhelgaas@google.com, lukas@wunner.de, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20230214172831.GA3046378@bhelgaas>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230214172831.GA3046378@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/14/23 10:28 AM, Bjorn Helgaas wrote:
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
>>   Documentation/PCI/pcieaer-howto.rst |   18 ------------------
>>   1 file changed, 18 deletions(-)
>>
>> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
>> index 0b36b9ebfa4b..a82802795a06 100644
>> --- a/Documentation/PCI/pcieaer-howto.rst
>> +++ b/Documentation/PCI/pcieaer-howto.rst
>> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
>>   errors because device specific errors will still get sent directly to
>>   the device driver.
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
>>   Provide callbacks
>>   -----------------
>>   
>> @@ -214,15 +205,6 @@ to mmio_enabled.
>>   
>>   helper functions
>>   ----------------
>> -::
>> -
>> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>> -
>> -pci_enable_pcie_error_reporting enables the device to send error
>> -messages to root port when an error is detected. Note that devices
>> -don't enable the error reporting by default, so device drivers need
>> -call this function to enable it.
>> -
>>   ::
>>   
>>     int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> 
> 
> commit d7b36abe72db ("Remove AER Capability configuration")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Mon Feb 13 11:53:42 2023 -0600
> 
>      Remove AER Capability configuration

The changes LGTM.
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 0b36b9ebfa4b..c98a229ea9f5 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -96,8 +96,8 @@ Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>   Developer Guide
>   ===============
>   
> -To enable AER aware support requires a software driver to configure
> -the AER capability structure within its device and to provide callbacks.
> +To enable AER aware support requires a software driver to provide
> +callbacks.
>   
>   To support AER better, developers need understand how AER does work
>   firstly.
> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
>   errors because device specific errors will still get sent directly to
>   the device driver.
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
>   Provide callbacks
>   -----------------
>   
> @@ -212,31 +203,6 @@ to reset the link. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER
>   and reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
>   to mmio_enabled.
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
>   Frequent Asked Questions
>   ------------------------
>   
> @@ -257,24 +223,6 @@ A:
>     Fatal error recovery will fail if the errors are reported by the
>     upstream ports who are attached by the service driver.
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
>   Software error injection
>   ========================
