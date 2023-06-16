Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB9733CE3
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jun 2023 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjFPX1g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 19:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFPX1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 19:27:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A171835A6;
        Fri, 16 Jun 2023 16:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686958054; x=1718494054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FGfxtfy0aidyjE9gkUqEaRlyzzbrnA1NRYJeU3yFcXI=;
  b=C1N9dGUzywKD8YQM9pH8X5sLgyRdDzSK/ip05JpDdf6o92cg7c2zdz9E
   8u2uTjfnc95mKA2rKV6F4ASfzeYSUk+GnKw5oFkYJ6FRn0TPOvxPz3uKm
   j+hW4OPPi/nCQddl8nw2lPyIEe2oCf9+iDaLeEvD+DYM1+/uY03QWntqH
   wFUUyly4Ln010D12J5y6ZFNw3qR/CQJ8X0GdrsLLNuXFhmoqWdvkdFQRh
   2Wqb04l7Dd9Nys0mpUQta3TqED3pCV2Js+LkAEMF4W/I8fILg3zDludX+
   qtlq/08lxcOV9l0eMSBNVlKFAE3qyV1lhzsuUOGdhoOyLVyMttDC6JoLD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="358209065"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="358209065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 16:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="825923054"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="825923054"
Received: from jdickins-mobl1.amr.corp.intel.com (HELO [10.209.25.26]) ([10.209.25.26])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 16:27:34 -0700
Message-ID: <c2d0c925-ffe1-4431-2d39-8cd6919486f0@linux.intel.com>
Date:   Fri, 16 Jun 2023 16:27:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1] PCI: pciehp: Make sure DPC trigger status is reset in
 PDC handler
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
References: <20230615062559.1268404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230615183550.GA9773@wunner.de>
 <713d71dc-c4a5-cd7b-2deb-343c244dd14d@linux.intel.com>
 <20230616090635.GA17565@wunner.de>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230616090635.GA17565@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On 6/16/23 2:06 AM, Lukas Wunner wrote:
> [cc += Smita]
> 
> On Thu, Jun 15, 2023 at 04:03:54PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 6/15/23 11:35 AM, Lukas Wunner wrote:
>>> On Wed, Jun 14, 2023 at 11:25:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>> During the EDR-based DPC recovery process, for devices with persistent
>>>> issues, the firmware may choose not to handle the DPC error and leave
>>>> the port in DPC triggered state. In such scenarios, if the user
>>>> replaces the faulty device with a new one, the OS is expected to clear
>>>> the DPC trigger status in the hotplug error handler to enable the new
>>>> device enumeration.
> [...]
>>>
>>> pciehp_unconfigure_device() seems like a more appropriate place to me.
>>>
>>
>> I initially thought to add it there. Spec also recommends clearing it
>> when removing the device. But I wasn't sure if pciehp_unconfigure_device()
>> would be called only during device removal.
> 
> It is.

Do you know how pciehp_unconfigure_device() will be called when the device is
removed? Is it due to a DLLSC event or a PDC state change? If it is DLLSC,
pciehp_unconfigure_device() may not be called because we ignore the DLLSC event
if there is an active DPC trigger.


> 
> 
>>>> More details about this issue can be found in PCIe
>>>> firmware specification, r3.3, sec titled "DPC Event Handling"
>>>> Implementation note.
>>>
>>> That Implementation Note contains a lot of text and a fairly complex
>>> flow chart. If you could point to specific paragraphs or numbers in
>>> the Implementation Note that would make life easier for a reviewer
>>> to make the connection between your code and the spec.
>>
>> It is the text at the end of the flowchart. Copied it here for reference.
>>
>> For devices with persistent errors, a port may be kept in the DPC triggered
>> state (disabled) to keep those devices from continuing to generate errors.
>> For hot-plug slots, the errant device may be removed and replaced with a new
>> device.
>> If the DPC trigger state is not cleared, then the port above the newly
>> inserted device will still be disabled and will be non-operational.
>> Therefore, operating systems may need to modify their hot-plug interrupt
>> handling code to clear DPC Trigger Status when a device is removed so that
>> a subsequent insertion will succeed.
> 
> Please add that excerpt to the commit message.

Ok. I will add it.

> 
> 
>>> This may run concurrently to dpc_reset_link(), so I'd expect that
>>> you need some kind of serialization.  What happens if pciehp clears
>>> trigger status behind the DPC driver's back while it is handling an
>>> error?
>>
>> Currently, we only call pci_dpc_reset_trigger() in PDC interrupt handler.
>>
>> Do you think there would be a race between error handler and PDC handler?
> 
> Yes I think so.
> 
> We need to differentiate between two cases:
> 
> (1) DPC handled by firmware, hotplug handled by OS:
> 
>     In this case clearing DPC trigger status from pciehp device removal
>     code path seems reasonable.  But it must be constrained to
>     !host_bridge->native_dpc.

Agree.

> 
> (2) DPC handled by OS:
> 
>     In this case clearing DPC trigger status from pciehp could race with
>     the dpc interrupt handler so must not be done.  Instead, I recommend

If we clear the DPC trigger status in the DLLSC state change handler, I
agree there could be a race. However, if we clear the DPC trigger in the
PDC state change handler, I believe it will not race because the device
has already been removed. Is my understanding correct?

>     clearing trigger status from the dpc interrupt handler.  You should
>     see a Surprise Down error handled by the dpc interrupt handler.
>     Make sure DPC trigger status is *always* cleared in that case.
>     
>     Note that Smita Koralahalli is currently working on something similar:
>     
>     https://lore.kernel.org/linux-pci/20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com/
> 
>     (@Smita sorry for the delay, I'll get to your patches ASAP.)
> 
> I recommend splitting the two cases above into two commits, one for
> firmware-handled DPC and one for OS-native DPC.  IIUC, you only need
> the former to address Dell's finding.
> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
