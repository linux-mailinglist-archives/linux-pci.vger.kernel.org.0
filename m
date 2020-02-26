Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9B170B49
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 23:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBZWOi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 17:14:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:55011 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbgBZWOi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 17:14:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 14:14:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="410779776"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 26 Feb 2020 14:14:37 -0800
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 44C9258052E;
        Wed, 26 Feb 2020 14:14:37 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v15 4/5] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200226213233.GA168850@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <6cabd520-f974-2c33-4ecb-3cfd2dfb00a4@linux.intel.com>
Date:   Wed, 26 Feb 2020 14:11:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226213233.GA168850@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/26/20 1:32 PM, Bjorn Helgaas wrote:
> On Wed, Feb 26, 2020 at 10:42:27AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/25/20 5:02 PM, Bjorn Helgaas wrote:
>>> On Thu, Feb 13, 2020 at 10:20:16AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> ...
>
>> Yes, we could remove it. But it might need some more changes to
>> dpc driver functions. I can think of two ways,
>>
>> 1. Re-factor the DPC driver not to use dpc_dev structure and just use
>> pci_dev in their functions implementation. But this might lead to
>> re-reading following dpc_dev structure members every time we
>> use it in dpc driver functions.
>>
>> (Currently in dpc driver probe they cache the following device parameters )
>>
>>    9         u16                     cap_pos;
>>   10         bool                    rp_extensions;
>>   11         u8                      rp_log_size;
>>   12         u16                     ctl;
>>   13         u16                     cap;
> I think this is basically what I proposed with the sample patch in my
> response to your 3/5 patch.  But I don't see the ctl/cap part, so
> maybe I missed something.
if its costly to carry it in pci_dev, we can always re-read them.
if its ok to use pci_dev, If you want, I can extend your patch to
include the cap and ctl.
> This message should be expanded somehow.  I think the point is that we
> got an EDR notification, but firmware couldn't tell us where the
> containment event occurred.  Should that ever happen?  Or is it a
> firmware defect if it *does* happen?
Yes, if we hit this error then its a firmware defect. Either
firmware sent wrong BDF value or used invalid return type.

I was planning to add some extra error info in acpi_locate_dpc_port()

166 +       if (obj->type != ACPI_TYPE_INTEGER) {
167 +               ACPI_FREE(obj);
168 +               return NULL;
169 +       }

>
> In any event, I think the message should say something like "Can't
> identify source of EDR notification".
I will use your suggestion here along with above mentioned change.
>
>>> This seems...  I'm not sure what.  I guess it's really just reading
>>> the DPC capability for use by dpc_process_error(), so maybe it's OK.
>>> But it's a little strange to read.
> I *think* maybe if we move the DPC info into the struct pci_dev it
> will solve this issue too?  I.e., we won't have a struct dpc_dev, so
> we won't have this funny-looking dpc_dev_init().
Yes, your patch will resolve this issue.
>
>> No this is a valid case. it will only happen if we have a non-acpi
>> based switch attached to root port.
> I agree this is a valid case (as I mentioned below).  My point was
> just that if it is a valid case, we might not want to use pci_warn()
> here.  Maybe pci_info() if you think it's important, or maybe no
> message at all.  I don't think "Initializing dpc again" is going to be
> useful to a user.
Got it. Adding pci_info here will be helpful to understand the flow.
Since EDR is a rare case, it should not pollute the dmesg. So I will add it.
>
>> Yes, ownership should be based on _OSC negotiation. I will add necessary
>> comments here.
> Why are we not doing this via _OSC negotiation in this series?  It
> would be much better if we could just do it instead of adding a
> comment that we *should* do it.  Nobody knows more about this than you
> do, so probably nobody else is going to come along and finish this
> up :)
Actually Alex G already proposed a patch to fix it.

https://lkml.org/lkml/2018/11/16/202

But that discussion never reached a conclusion. Since a proper fix
for it would affect some legacy hardwares which solely relies on
HEST tables, it did not make everyone happy. So it might take a
lot to convince all the stake holders to merge such patch. So its
better not to mix both of these patch sets together.

Once this patch set is done, If Alex G is no longer working on it,
I can work on it.
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

