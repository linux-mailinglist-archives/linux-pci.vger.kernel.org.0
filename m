Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265B733F9A7
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 21:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhCQUCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 16:02:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:48306 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233279AbhCQUCO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Mar 2021 16:02:14 -0400
IronPort-SDR: /JLA53h4Vv5v/zobNCxzY/HQeSdNXZjg/BNOCRAj7qas/6hlLyuYZaF/cuGZu2GF9xW5/8S3/z
 AEoJAA7ndj4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="189629667"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="189629667"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 13:02:11 -0700
IronPort-SDR: wGccyWSV5yIdO3sr0yZgkKuk9jnYa4gmrVlRqDRxxD4I3pDrqOV/Gzh79WCjR5qQe/YLkg4RVl
 oh2qdv4IRXHA==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="388965698"
Received: from fnumohax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.29.23])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 13:02:10 -0700
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
To:     Lukas Wunner <lukas@wunner.de>,
        Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de>
 <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
 <20210317053114.GA32370@wunner.de>
 <CAPcyv4j8t4Y=kpRSvOjOfVHd107YemiRcW0BNQRwp-d9oCddUw@mail.gmail.com>
 <CAC41dw8sX4T-FrwBju2H3TbjDhJMLGw_KHqs+20qzvKU1b5QTA@mail.gmail.com>
 <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
 <CAC41dw_BJBMdwyccdvWNZsdAzzh7ko=q4oSpQXo-jJDTfQGkZw@mail.gmail.com>
 <20210317190151.GA27146@wunner.de>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0a020128-80e8-76a7-6b94-e165d3c6f778@linux.intel.com>
Date:   Wed, 17 Mar 2021 13:02:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210317190151.GA27146@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/17/21 12:01 PM, Lukas Wunner wrote:
> On Wed, Mar 17, 2021 at 10:54:09AM -0700, Sathyanarayanan Kuppuswamy Natarajan wrote:
>> Flush of hotplug event after successful recovery, and a simulated
>> hotplug link down event after link recovery fails should solve the
>> problems raised by Lukas. I assume Lukas' proposal adds this support.
>> I will check his patch shortly.
> 
> Thank you!
> 
> I'd like to get a better understanding of the issues around hotplug/DPC,
> specifically I'm wondering:
> 
> If DPC recovery was successful, what is the desired behavior by pciehp,
> should it ignore the Link Down/Up or bring the slot down and back up
> after DPC recovery?
> 
> If the events are ignored, the driver of the device in the hotplug slot
> is not unbound and rebound.  So the driver must be able to cope with
> loss of TLPs during DPC recovery and it must be able to cope with
> whatever state the endpoint device is in after DPC recovery.
> Is this really safe?  How does the nvme driver deal with it?
During DPC recovery, in pcie_do_recovery() function, we use
report_frozen_detected() to notify all devices attached to the port
about the fatal error. After this notification, we expect all
affected devices to halt its IO transactions.

Regarding state restoration, after successful recovery, we use
report_slot_reset() to notify about the slot/link reset. So device
drivers are expected to restore the device to working state after this
notification.
> 
> Also, if DPC is handled by firmware, your patch does not ignore the
> Link Down/Up events, 
Only for pure firmware model. For EDR case, we still ignore the Link
Down/Up events.
so pciehp brings down the slot when DPC is
> triggered, then brings it up after succesful recovery.  In a code
> comment, you write that this behavior is okay because there's "no
> race between hotplug and DPC recovery". 
My point is, there is no race in OS handlers (pciehp_ist() vs pcie_do_recovery())
  However, Sinan wrote in
> 2018 that one of the issues with hotplug versus DPC is that pciehp
> may turn off slot power and thereby foil DPC recovery.  (Power off =
> cold reset, whereas DPC recovery = warm reset.)  This can occur
> as well if DPC is handled by firmware.
I am not sure how pure firmware DPC recovery works. Is there a platform
which uses this combination? For firmware DPC model, spec does not clarify
following points.

1. Who will notify the affected device drivers to halt the IO transactions.
2. Who is responsible to restore the state of the device after link reset.

IMO, pure firmware DPC does not support seamless recovery. I think after it
clears the DPC trigger status, it might expect hotplug handler be responsible
for device recovery.

I don't want to add fix to the code path that I don't understand. This is the
reason for extending this logic to pure firmware DPC case.

> 
> So I guess pciehp should make an attempt to await DPC recovery even
> if it's handled by firmware?  Or am I missing something?  We may be
> able to achieve that by polling the DPC Trigger Status bit and
> DLLLA bit, but it won't work as perfectly as with native DPC support.
> 
> Finally, you write in your commit message that there are "a lot of
> stability issues" if pciehp and DPC are allowed to recover freely
> without proper serialization.  What are these issues exactly?
In most cases, I see failure of DPC recovery handler (you can see the
example dmesg in commit log). Other than this, we also noticed some
extended delay or failure in link retraining (while waiting for LINK UP
in pcie_wait_for_link(pdev, true)).
In some cases, we noticed slot power on failures and that card will not
be detected when running lscpi.

Above mentioned cases are just observations we have made. we did not dig
deeper on why the race between pciehp and DPC leads to such issues.
> (Beyond the slot power issue mentioned above, and that the endpoint
> device's driver should presumably not be unbound if DPC recovery
> was successful.)
> 
> Thanks!
> 
> Lukas
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
