Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C206D17BB
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 08:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCaGqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 02:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaGqr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 02:46:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE310F6;
        Thu, 30 Mar 2023 23:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680245206; x=1711781206;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=EhMCDSwQob+c4u0KaI/ukw2TtiR9tPLGW4cQPSgtyhc=;
  b=a+P0R/MZZy9wrWvMawjnCvdnw/hyhu+JLIlPoopcX9cdMndiGjdNAemE
   MrvQyl6/l+XDLHF/O6460ZRvbLrR/fWO5v4usVbxingSWiVc0gRUSgcet
   jER7b/bFxj1BQQp22oeOW3I4y+75NnNZVh4kcNDuZYjecspBOK1dbCg3R
   Z5VtNIgs7ICddN+zeg2DVVh7dEePmH4LjthlV3xz1IffPfZuPu8UuwtgN
   f+WxrhR6gL6+vJn23n/4TB2I5r0aw7YQUH704EeHvTxJSaOR3ZPq3jpRQ
   pl7EPDyzVbXPe+g3ESsqtz0fhIGtTa6eEqZuhTBkT72O6V21KtxmoA3NE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="321763562"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="321763562"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 23:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635182658"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="635182658"
Received: from trichard-mobl.amr.corp.intel.com (HELO [10.209.38.7]) ([10.209.38.7])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 23:46:46 -0700
Message-ID: <17f5c023-910a-f88f-e7c4-c5a1c3c3ac0e@linux.intel.com>
Date:   Thu, 30 Mar 2023 23:46:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20230330154542.GA3147375@bhelgaas>
Content-Language: en-US
In-Reply-To: <20230330154542.GA3147375@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/30/23 8:45 AM, Bjorn Helgaas wrote:
> On Wed, Mar 29, 2023 at 03:38:04PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 3/29/23 3:09 PM, Bjorn Helgaas wrote:
>>> On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
>>>> OS owns AER") adds support to clear error status in the Device Status
>>>> Register(DEVSTA) only if OS owns the AER support. But this change
>>>> breaks the requirement of the EDR feature which requires OS to cleanup
>>>> the error registers even if firmware owns the control of AER support.
> 
>>> I assume we should have a Fixes: tag here, since this patch should be
>>> backported to every kernel that contains 068c29a248b6.  Possibly even
>>> a stable tag, although it's arguable whether it's "critical" per
>>> Documentation/process/stable-kernel-rules.rst.
>>
>> Yes. But this error is only reproducible in the EDR use case. So I
>> am not sure whether it can be considered a critical fix. 
> 
> I don't know how widespread EDR implementation is.  What is the

I believe it is used by a few vendors (Nvidia, Intel, Dell, etc).
I have seen EDR related messages in some of the posted DPC related
dmesg logs.

> user-visible issue without this fix?  "lspci" shows status bits set
> even after recovery?  Subsequent EDR notifications cause us to report
> errors that were previously reported and recovered?  Spurious EDR
> notifications because of status bits that should have been cleared?
> This kind of information would be useful in the commit log anyway.

I don't think we will get spurious EDR notifications. Since the only
stale entry is in DEVSTA status register, the user will at most see
errors bits set, even after successful recovery. However, if the user
relies on some automation scripts to check the device status after
error recovery, it may have an impact.

> 
> Since the risk is low (the change only affects EDR processing) and the
> the experience without this change might be poor (please clarify what
> that experience is), I think I would be inclined to mark it for
> stable.

Ok. IMO, since it will be visible to the user (although not fatal),
we can send it to the stable. But I will let you decide on it.

> 
>>> It's a little weird to work around a change inside pcie_do_recovery()
>>> by clearing it here, and that means we clear it twice in the AER
>>> native case, but I don't see any simpler way to do this, so this seems
>>> fine as the fix for the current issue.
>>
>> In AER native case, edr_handle_event() will never be triggered. So it
>> won't be cleared twice.
> 
> This sounds like a plausible assumption.  But is there actually spec
> language that says EDR notification is not allowed in the AER native
> case (when OS owns the AER Capability)?  I looked but didn't find
> anything.
> 

In the PCIe firmware specification v3.3, table "Table 4-6: Interpretation of
the _OSC Control Field, Returned Value", field "PCI Express Downstream Port
Containment configuration control", it explains that the firmware can use
EDR notification only when OS DPC control is not requested or denied by
firmware.

>> Other way is to add a new parameter to pcie_do_recovery(..., edr) and use
>> it to conditionally call pcie_clear_device_status(). But I think current
>> way is less complex.
> 
> I agree.
> 
>>> Question though: in the AER native case, pcie_do_recovery() calls
>>> both:
>>>
>>>   pcie_clear_device_status() and
>>>   pci_aer_clear_nonfatal_status()
>>>
>>> In this patch, you only call pcie_clear_device_status().  Do you care
>>> about pci_aer_clear_nonfatal_status(), too?
>>
>> Yes, we care about it. Since we call dpc_process_error() in EDR handler,
>> it will eventually clear error status via pci_aer_clear_nonfatal_status()
>> and pci_aer_clear_fatal_status() within dpc_process_error().
> 
> dpc_process_error() calls pci_aer_clear_nonfatal_status() in *some*
> (but not all) cases.  I didn't try to work out whether those match the
> cases where pcie_do_recovery() called it before 068c29a248b6.  I guess
> we can assume it's equivalent for now.

We also call pci_aer_raw_clear_status() in dpc_process_error() which also
should clear the fatal and non-fatal errors.

> 
>>> The overall design for clearing status has gotten pretty complicated
>>> as we've added error handling methods (firmware-first, DPC, EDR), and
>>> there are so many different places and cases that it's hard to be sure
>>> we do them all correctly.
>>>
>>> I don't really know how to clean this up, so I'm just attaching my
>>> notes about the current state:
>>
>> Good summary! I can see a lot of overlap in clearing
>> PCI_ERR_UNCOR_STATUS and PCI_EXP_DEVSTA.
> 
> Actually I do have one idea: in the firmware-first case, firmware
> collects all the status information, clears it, and then passes the
> status on to the OS.  In this case we don't need to clear the status
> registers in handle_error_source(), pcie_do_recovery(), etc.

So the idea is to get the error info in a particular format using
something like _DSM call? What about the legacy use case? For legacy
firmware, we still need to support the old format, right?

> 
> So I think the OS *should* be able to do something similar by
> collecting the status information and clearing it first, before

Something similar to updating struct aer_stats and struct aer_err_src?

> starting error handling.  This might let us collect the status
> clearing together in one place and also converge the firmware-first
> and native error handling paths.
> 
> Obviously that would be a major future project.

Agree. It would require changes to firmware spec, AER and DPC driver.
Maybe we can start with cleaning up the native mode first. I would be
happy to contribute to it. Let me think about the possible methods
and get back to you.


> 
> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
