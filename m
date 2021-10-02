Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390DB41FC76
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhJBOWM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 10:22:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:27557 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233274AbhJBOWK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Oct 2021 10:22:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10125"; a="205845445"
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; 
   d="scan'208";a="205845445"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 07:20:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; 
   d="scan'208";a="565773947"
Received: from unknown (HELO [10.134.107.90]) ([10.134.107.90])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 07:20:23 -0700
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
 <20211002070218-mutt-send-email-mst@kernel.org> <YVg/F10PCFNOtCnL@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
Date:   Sat, 2 Oct 2021 07:20:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVg/F10PCFNOtCnL@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/2/2021 4:14 AM, Greg Kroah-Hartman wrote:
> On Sat, Oct 02, 2021 at 07:04:28AM -0400, Michael S. Tsirkin wrote:
>> On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
>>>>    Do you have a list of specific drivers and kernel options that you
>>>> feel you now "trust"?
>>> For TDX it's currently only virtio net/block/console
>>>
>>> But we expect this list to grow slightly over time, but not at a high rate
>>> (so hopefully <10)
>> Well there are already >10 virtio drivers and I think it's reasonable
>> that all of these will be used with encrypted guests. The list will
>> grow.
> What is keeping "all" drivers from being on this list?

It would be too much work to harden them all, and it would be pointless 
because all these drivers are never legitimately needed in a virtualized 
environment which only virtualize a very small number of devices.

>   How exactly are
> you determining what should, and should not, be allowed?

Everything that has had reasonable effort at hardening can be added. But 
if someone proposes to add a driver that should trigger additional 
scrutiny in code review. We should also request them to do some fuzzing.

It's a bit similar to someone trying to add a new syscall interface. 
That also triggers much additional scrutiny for good reasons and people 
start fuzzing it.


>    How can
> drivers move on, or off, of it over time?

Adding something is submitting a patch to the allow list.

I'm not sure the "off" case would happen, unless the driver is 
completely removed, or maybe it has some unfixable security problem. But 
that is all rather unlikely.


>
> And why not just put all of that into userspace and have it pick and
> choose?  That should be the end-goal here, you don't want to encode
> policy like this in the kernel, right?

How would user space know what drivers have been hardened? This is 
really something that the kernel needs to determine. I don't think we 
can outsource it to anyone else.

Also BTW of course user space can still override it, but really the 
defaults should be a kernel policy.

There's also the additional problem that one of the goals of 
confidential guest is to just move existing guest virtual images into 
them without much changes. So it's better for such a case if as much as 
possible of the policy is in the kernel. But that's more a secondary 
consideration, the first point is really the important part.


-Andi

