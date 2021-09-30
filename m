Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA441E21B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 21:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245359AbhI3TRE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 15:17:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:31673 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhI3TRB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 15:17:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="212343991"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="212343991"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 12:15:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="438151438"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.134.229]) ([10.252.134.229])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 12:15:17 -0700
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org> <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930103537-mutt-send-email-mst@kernel.org> <YVXOc3IbcHsVXUxr@kroah.com>
 <20210930105852-mutt-send-email-mst@kernel.org> <YVXWIVZupeAzT6bO@kroah.com>
 <f4b5a269-843f-6911-24fe-ebffb2bd4f9e@linux.intel.com>
 <YVXyqBGa5Ix5MzmD@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <bb27af8d-d4ba-fa70-8893-5b9939f9280a@linux.intel.com>
Date:   Thu, 30 Sep 2021 12:15:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVXyqBGa5Ix5MzmD@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/30/2021 10:23 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 30, 2021 at 10:17:09AM -0700, Andi Kleen wrote:
>>>> The "it" that I referred to is the claim that no driver should be
>>>> touching hardware in their module init call. Andi seems to think
>>>> such drivers are worth working around with a special remap API.
>>> Andi is wrong.
>> While overall it's a small percentage of the total, there are still quite a
>> few drivers that do touch hardware in init functions. Sometimes for good
>> reasons -- they need to do some extra probing to discover something that is
>> not enumerated -- sometimes just because it's very old legacy code that
>> predates the modern driver model.
> Are any of them in the kernel today?
>
> PCI drivers should not be messing with this, we have had well over a
> decade to fix that up.


It's not just PCI driver, it's every driver that can do io port / MMIO / 
MSR / config space accesses.


Maybe read the excellent article from Jon on this:

https://lwn.net/Articles/865918/


>
>> The legacy drivers could be fixed, but nobody really wants to touch them
>> anymore and they're impossible to test.
> Pointers to them?

For example if you look over old SCSI drivers in drivers/scsi/*.c there 
is a substantial number that has a module init longer than just 
registering a driver. As a single example look at drivers/scsi/BusLogic.c

There were also quite a few platform drivers like this.


>
>> The drivers that probe something that is not enumerated in a standard way
>> have no choice, it cannot be implemented in a different way.
> PCI devices are not enumerated in a standard way???

The pci devices are enumerated in a standard way, but typically the 
driver also needs something else outside PCI that needs some other 
probing mechanism.


>
>> So instead we're using a "firewall" the prevents these drivers from doing
>> bad things by not allowing ioremap access unless opted in, and also do some
>> filtering on the IO ports The device filter is still the primary mechanism,
>> the ioremap filtering is just belts and suspenders for those odd cases.
> That's horrible, don't try to protect the kernel from itself.  Just fix
> the drivers.

I thought we had already established this last time we discussed it.

That's completely impractical. We cannot harden thousands of drivers, 
especially since it would be all wasted work since nobody will ever need 
them in virtual guests. Even if we could harden them how would such a 
work be maintained long term? Using a firewall and filtering mechanism 
is much saner for everyone.

-Andi




