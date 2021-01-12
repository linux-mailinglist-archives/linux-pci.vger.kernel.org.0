Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0E2F3F67
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394513AbhALWU1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 17:20:27 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:20688 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404681AbhALWUX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 17:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=UrCG2cAhmYVBHHKgDsAqGEtAmexHEK3Q88mALPSyHEk=;
        b=JHOwza5yYexuhRRDwc9M9aOl3+6jCRjSW8gIDSeZ38/ofY9m+yQ7ZbOtInJPskYmwGk4QWhfE2gPa
         0n9NjfS9IqYb6bvFIB2ps76UScxrl5DwS7iRZTf1TvPRQZvjNCAx0saqFlyXEdUccpKzBTBfd2Rdbu
         3AHirr7LjFnKF7jD247HBv/xKg06o+J4hviqJ/qCWsGh6faTDb+ufZZzPirgRmmhyvXDuXw/5xJlGj
         ABrTG5qXNce/Ka9f+Pa+Gxud6wtjIlBtmYrkUJe34dWt8FQttsejUWrh34cgEBUq9s+eqLmQokr4MS
         i9W5jROGY5Umw9dvkjqMMOEWVLl64Dg==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 3fae735f-5524-11eb-93c8-005056a66d10;
        Tue, 12 Jan 2021 23:19:34 +0100 (CET)
Received: from [192.168.0.6] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 23:19:37 +0100
Subject: Re: [PATCHv2 0/5] aer handling fixups
To:     Keith Busch <kbusch@kernel.org>
CC:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
 <20210105183302.GA1278205@dhcp-10-100-145-180.wdc.com>
 <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
 <20210107214236.GA1284006@dhcp-10-100-145-180.wdc.com>
 <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
 <c3117c51-144f-ae59-ad68-bdc5532d12cb@ess.eu>
 <20210111163708.GA1458209@dhcp-10-100-145-180.wdc.com>
 <6783d09d-1431-15fd-961e-3820b14e001e@ess.eu>
 <20210111220951.GA1472929@dhcp-10-100-145-180.wdc.com>
 <ed8256dd-d70d-b8dc-fdc0-a78b9aa3bbd9@ess.eu>
 <20210112192758.GB1472929@dhcp-10-100-145-180.wdc.com>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <8650281b-4430-1938-5d45-53f09010497b@ess.eu>
Date:   Tue, 12 Jan 2021 23:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210112192758.GB1472929@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-2.esss.lu.se (10.0.42.132) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/12/21 8:27 PM, Keith Busch wrote:
> On Tue, Jan 12, 2021 at 06:20:55PM +0100, Hinko Kocevar wrote:
>> On 1/11/21 11:09 PM, Keith Busch wrote:
>>
>> Here is the log after applying the patch.
>>
>> What sticks out are the numerous "VC buffer not found in pci_save_vc_state"
>> messages, AFAICT from vc.c pci_save_vc_state(), which I have not spotted
>> before:
>>
>> [dev@bd-cpu18 ~]$ dmesg | grep vc_
>> [  336.960749] pcieport 0000:00:01.1: VC buffer not found in pci_save_vc_state
>> [  338.125683] pcieport 0000:01:00.0: VC buffer not found in pci_save_vc_state
>> [  338.342504] pcieport 0000:02:01.0: VC buffer not found in pci_save_vc_state
>> [  338.569035] pcieport 0000:03:00.0: VC buffer not found in pci_save_vc_state
>> [  338.775696] pcieport 0000:04:01.0: VC buffer not found in pci_save_vc_state
>> [  338.982599] pcieport 0000:04:03.0: VC buffer not found in pci_save_vc_state
>> [  339.189608] pcieport 0000:04:08.0: VC buffer not found in pci_save_vc_state
>> [  339.406232] pcieport 0000:04:0a.0: VC buffer not found in pci_save_vc_state
>> [  339.986434] pcieport 0000:04:12.0: VC buffer not found in pci_save_vc_state
> 
> Ah, that's happening because I added the cap caching after the cap
> buffer allocation. The patch below on top of the previous should fix
> those warnings.

Right. With this little change applied, the warnings are gone now, and I 
can see the VC related debug messages you introduced with the first patch.

>   
>> I do not see the lockup anymore, and the recovery seems to have successfully
>> been performed.
> 
> Okay, that kind of indicates the frequent capability lookups are taking
> a while. We cache other capability offsets for similar reasons in the
> past, but I don't recall them ever taking so long that it triggers the
> CPU lockup watchdog.

Now that the VC restore is being invoked again, I see the lockups are back.

> 
> ---
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 56992a42bac6..a12efa87c7e0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2385,6 +2385,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_ea_init(dev);		/* Enhanced Allocation */
>   	pci_msi_init(dev);		/* Disable MSI */
>   	pci_msix_init(dev);		/* Disable MSI-X */
> +	pci_vc_init(dev);		/* Virtual Channel */
>   
>   	/* Buffers for saving PCIe and PCI-X capabilities */
>   	pci_allocate_cap_save_buffers(dev);
> @@ -2401,7 +2402,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_aer_init(dev);		/* Advanced Error Reporting */
>   	pci_dpc_init(dev);		/* Downstream Port Containment */
>   	pci_rcec_init(dev);		/* Root Complex Event Collector */
> -	pci_vc_init(dev);		/* Virtual Channel */
>   
>   	pcie_report_downtraining(dev);
>   
> --
> 

I feel inclined to provide a little bit more info about the system I'm 
running this on as it is not a regular PC/server/laptop. It is a modular 
micro TCA system with a single CPU and MCH. MCH and CPU are separate 
cards, as are the other processing cards (AMCs) that link up to CPU 
through the MCH PEX8748 switch. I can power each card individually, or 
perform complete system power cycle. The normal power up sequence is: 
MCH, AMCs, CPU. The CPU is powered 30 sec after all other cards so that 
their PCIe links are up and ready for Linux.

All buses below CPU side 02:01.0 are on MCH PEX8748 switch:

[dev@bd-cpu18 ~]$ sudo /usr/local/bin/pcicrawler -t
00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
  ├─01:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
  │  ├─02:01.0 downstream_port, slot 1, device present, power: Off, 
speed 8GT/s, width x4
  │  │  └─03:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 8748 
48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (8748)
  │  │     ├─04:01.0 downstream_port, slot 4, power: Off
  │  │     ├─04:03.0 downstream_port, slot 3, power: Off
  │  │     ├─04:08.0 downstream_port, slot 5, power: Off
  │  │     ├─04:0a.0 downstream_port, slot 6, device present, power: 
Off, speed 8GT/s, width x4
  │  │     │  └─08:00.0 endpoint, Xilinx Corporation (10ee), device 8034
  │  │     └─04:12.0 downstream_port, slot 1, power: Off
  │  ├─02:02.0 downstream_port, slot 2
  │  ├─02:08.0 downstream_port, slot 8
  │  ├─02:09.0 downstream_port, slot 9, power: Off
  │  └─02:0a.0 downstream_port, slot 10
  ├─01:00.1 endpoint, PLX Technology, Inc. (10b5), device 87d0
  ├─01:00.2 endpoint, PLX Technology, Inc. (10b5), device 87d0
  ├─01:00.3 endpoint, PLX Technology, Inc. (10b5), device 87d0
  └─01:00.4 endpoint, PLX Technology, Inc. (10b5), device 87d0


The lockups most frequently appear after the cold boot of the system. If 
I restart the CPU card only, and leave the MCH (where the PEX8748 switch 
resides) powered, the lockups do *not* happen. I'm injecting the same 
error into the root port and the system card 
configuration/location/count is always the same.

Nevertheless, in rare occasions while booting the same kernel image 
after complete system power cycle, no lockup is observed.

So far I observed that the lockups seem to always happen when recovery 
is dealing with the 02:01.0 device/bus.

If the system recovers from a first injected error, I can repeat the 
injection and the system recovers always. If the first recovery fails I 
have to either reboot the CPU or power cycle the complete system.

To me it looks like this behavior is somehow related to the system/setup 
I have, and for some reason is triggered by VC restoration (VC is not is 
use by my system at all, AFAIK).

Are you able to tell which part of the code the CPU is actually spinning 
in when the lockup is detected? I added many printk()s in the 
pci_restore_vc_state(), in the AER IRQ handler, and around to see 
something being continuously printed, but nothing appeared..

I'll continue testing your patches and try to come up with more info.

Thank you for your time!
