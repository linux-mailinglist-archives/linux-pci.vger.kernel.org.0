Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8097322F9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 01:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjFOXD6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 19:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFOXD5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 19:03:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEEF270E;
        Thu, 15 Jun 2023 16:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686870236; x=1718406236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9SJ0J7T6a9jiQYsr6lYSjoumu7Hdh9US7+P+SI4SqMw=;
  b=T80V+A75H8gRVdG5yWxxZNnrgV+y7JoumeN9T4LZh0nE8OGN61xm6lQm
   FOLGqFR1w3eW2Iz2fcFWb51xZ5MtfhbAFwQxCEJY9zH2nihfO2VUJUCC9
   JamSoEK67ukS3L9zq/XHwQJQdwdVv17ikpJxV6ysShY2fExGUhKpebvUX
   mVOHFHaXA7AcDztsHSlJ+Ky3xU2SKZ+7UZ7pXd41IZItjzlpiHn96u4wb
   tGS3t3ib06Bv5FAseo2lKPGc8PZeEb3cPXiblszenjm/1PC6r0P6WF1X2
   +hVxIX176/l+kKwdXWkMB753s67vZlVvrHXtVTOfzkkwCsaQBbTeGOkcv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357935205"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="357935205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 16:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="857162818"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="857162818"
Received: from brhacker-mobl26.amr.corp.intel.com (HELO [10.212.148.133]) ([10.212.148.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 16:03:55 -0700
Message-ID: <713d71dc-c4a5-cd7b-2deb-343c244dd14d@linux.intel.com>
Date:   Thu, 15 Jun 2023 16:03:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1] PCI: pciehp: Make sure DPC trigger status is reset in
 PDC handler
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230615062559.1268404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230615183550.GA9773@wunner.de>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230615183550.GA9773@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Thanks for the review.

On 6/15/23 11:35 AM, Lukas Wunner wrote:
> On Wed, Jun 14, 2023 at 11:25:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> During the EDR-based DPC recovery process, for devices with persistent
>> issues, the firmware may choose not to handle the DPC error and leave
>> the port in DPC triggered state. In such scenarios, if the user
>> replaces the faulty device with a new one, the OS is expected to clear
>> the DPC trigger status in the hotplug error handler to enable the new
>> device enumeration.
> 
> You're clearing the DPC trigger status upon a PDC event, yet are saying
> here the purpose is to reset port state for a future hotplugged device.

Sorry, it is a typo. I meant "hotplug interrupt handler".

The goal is to ensure that when a new device presence is detected, the
old DPC trigger status is cleared.

> 
> A PDC event may be synthesized, e.g. to trigger slot bringup via
> sysfs, so using a PDC event to clear DPC trigger status feels wrong.

IMO, it is harmless. We just want to make sure the previous DPC trigger
status is cleared before enumerating a new device.

> pciehp_unconfigure_device() seems like a more appropriate place to me.
> 

I initially thought to add it there. Spec also recommends clearing it
when removing the device. But I wasn't sure if pciehp_unconfigure_device()
would be called only during device removal. 

Let me test this path and get back to you.

> 
>> More details about this issue can be found in PCIe
>> firmware specification, r3.3, sec titled "DPC Event Handling"
>> Implementation note.
> 
> That Implementation Note contains a lot of text and a fairly complex
> flow chart. If you could point to specific paragraphs or numbers in
> the Implementation Note that would make life easier for a reviewer
> to make the connection between your code and the spec.

It is the text at the end of the flowchart. Copied it here for reference.

For devices with persistent errors, a port may be kept in the DPC triggered
state (disabled) to keep those devices from continuing to generate errors. For
hot-plug slots, the errant device may be removed and replaced with a new device.
If the DPC trigger state is not cleared, then the port above the newly inserted
device will still be disabled and will be non-operational. Therefore, operating
systems may need to modify their hot-plug interrupt handling code to clear DPC
Trigger Status when a device is removed so that a subsequent insertion
will succeed.

> 
> 
>> Similar issue might also happen if the DPC or EDR recovery handler
>> exits before clearing the trigger status. To fix this issue, clear the
>> DPC trigger status in PDC interrupt handler.
> 
> I was about to ask why the code is added to dpc.c, not edr.c,
> and why it's not constrained to CONFIG_PCIE_EDR, but I assume
> that's the reason?  Because it "might" happen for OS-native DPC
> as well?

Yes. There are code paths in the DPC driver where error recover handler
can exit before clearing the DPC trigger status. So I think this fix is
applicable for native code as well.

> 
> 
>> +/**
>> + * pci_reset_trigger - Clear DPC trigger status
>> + * @pdev: PCI device
>> + *
>> + * It is called from the PCIe hotplug driver to clean the DPC
>> + * trigger status in the PDC interrupt handler.
>> + */
>> +void pci_dpc_reset_trigger(struct pci_dev *pdev)
>> +{
>> +	if (!pdev->dpc_cap)
>> +		return;
>> +
>> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
>> +			      PCI_EXP_DPC_STATUS_TRIGGER);
>> +}
> 
> This may run concurrently to dpc_reset_link(), so I'd expect that
> you need some kind of serialization.  What happens if pciehp clears
> trigger status behind the DPC driver's back while it is handling an
> error?

Currently, we only call pci_dpc_reset_trigger() in PDC interrupt handler.

Do you think there would be a race between error handler and PDC handler?

> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
