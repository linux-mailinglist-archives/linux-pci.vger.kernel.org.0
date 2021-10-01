Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B941F17E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 17:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhJAPvP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 11:51:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:38465 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231649AbhJAPvP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 11:51:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="204958167"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="204958167"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 08:49:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="619225739"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.135.37.9]) ([10.135.37.9])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 08:49:29 -0700
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
Date:   Fri, 1 Oct 2021 08:49:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVaywQLAboZ6b36V@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/1/2021 12:03 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 30, 2021 at 12:04:05PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>>
>> On 9/30/21 8:23 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Sep 30, 2021 at 08:18:18AM -0700, Kuppuswamy, Sathyanarayanan wrote:
>>>>
>>>> On 9/30/21 6:36 AM, Dan Williams wrote:
>>>>>> And in particular, not all virtio drivers are hardened -
>>>>>> I think at this point blk and scsi drivers have been hardened - so
>>>>>> treating them all the same looks wrong.
>>>>> My understanding was that they have been audited, Sathya?
>>>> Yes, AFAIK, it has been audited. Andi also submitted some patches
>>>> related to it. Andi, can you confirm.
>>> What is the official definition of "audited"?
>>
>> In our case (Confidential Computing platform), the host is an un-trusted
>> entity. So any interaction with host from the drivers will have to be
>> protected against the possible attack from the host. For example, if we
>> are accessing a memory based on index value received from host, we have
>> to make sure it does not lead to out of bound access or when sharing the
>> memory with the host, we need to make sure only the required region is
>> shared with the host and the memory is un-shared after use properly.
> You have not defined the term "audited" here at all in any way that can
> be reviewed or verified by anyone from what I can tell.
>
> You have only described a new model that you wish the kernel to run in,
> one in which it does not trust the hardware at all.  That is explicitly
> NOT what the kernel has been designed for so far,

It has been already done for a few USB/TB drivers, but yes not for the 
majority of the kernel.

>   and if you wish to
> change that, lots of things need to be done outside of simply running
> some fuzzers on a few random drivers.

The goal is to do similar work as USB/TB did, but do it for a small set 
of virtio drivers and use a custom allow list for those for the specific 
secure guest cases.

(there are some other goals, but let's not discuss them here for now)


>
> For one example, how do you ensure that the memory you are reading from
> hasn't been modified by the host between writing to it the last time you
> did?

It's similar techniques as we do on user space accesses. For example if 
you bound check some value the code needs to ensure it is cached in 
private memory, not reread from MMIO or shared memory. Of course that's 
a good idea anyways for performance because MMIO is slow.

In the concrete cases of virtio the main problem was the free list in 
shared memory, but that has been addressed now.



>   Do you have a list of specific drivers and kernel options that you
> feel you now "trust"?

For TDX it's currently only virtio net/block/console

But we expect this list to grow slightly over time, but not at a high 
rate (so hopefully <10)


> If so, how long does that trust last for?  Until
> someonen else modifies that code?  What about modifications to functions
> that your "audited" code touches?  Who is doing this auditing?  How do
> you know the auditing has been done correctly?  Who has reviewed and
> audited the tools that are doing the auditing?  Where is the
> specification that has been agreed on how the auditing must be done?
> And so on...

Well, I mean we already have a similar situation with user space APIs. 
So it's not a new problem. For those we've done it for many years, with 
audits and extra fuzzing.

There are people working on the audit and fuzzing today. How exactly it 
will be ensured long term is still be worked out, but I expect we can 
work out something.

>
> I feel like there are a lot of different things all being mixed up here
> into one "oh we want this to happen!" type of thread.



Agreed. The thread ended up about a lot of stuff which is outside the 
scope of the patches.

>    Please let's just
> stick to the one request that I had here, which was to move the way that
> busses are allowed to authorize the devices they wish to control into a
> generic way instead of being bus-specific logic.
>
> Any requests outside of that type of functionality are just that,
> outside the scope of this patchset and should get their own patch series
> and discussion.


Yes that's the intention. This patch kit is only about controlling what 
devices can enumerate.

Also please let's avoid the "trusted" term. It's really misleading and 
confusing in the context of confidential computing.


-Andi

