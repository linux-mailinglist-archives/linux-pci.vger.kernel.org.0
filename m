Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148002F4031
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733237AbhALXS1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 18:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733217AbhALXS1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 18:18:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32CB623123;
        Tue, 12 Jan 2021 23:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610493466;
        bh=AdgN6R873ysKeaHkrQmMiOjH22/g+KC6yFxPw/TKI3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zki3hQaVP7+x5/RySXM+YrlytYd8osX3G8gBR1ER90wRkUCkA8XyjvwifR5SKKhef
         u9UmLjAEeJ/4TWFLdBa2f55dMzM+CcZzGWDrkIfA+xol5meQQu+4ry1+hKqHh6yrOZ
         kEkQsaNUu5LtzxyBxXnnaCkXkadtzRkgWuwDb0MWjRxRHMLt+K7z7QeEEKkxlHzepE
         sM51tI2vANFbYelI6eftYxC6BCjo54Yblwx9GzTlHDYqs0LyuSM/nc3yGqSHc+OkNT
         runsgLm12HZ+lUYQVrMuZW06O3J1ATvOTDVycbOxI0cvkj+BoUlkoOKfSJ25GsV6uH
         TUQI2pLn7d8rA==
Date:   Tue, 12 Jan 2021 15:17:44 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Hinko Kocevar <hinko.kocevar@ess.eu>
Cc:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210112231744.GB1508433@dhcp-10-100-145-180.wdc.com>
References: <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
 <20210107214236.GA1284006@dhcp-10-100-145-180.wdc.com>
 <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
 <c3117c51-144f-ae59-ad68-bdc5532d12cb@ess.eu>
 <20210111163708.GA1458209@dhcp-10-100-145-180.wdc.com>
 <6783d09d-1431-15fd-961e-3820b14e001e@ess.eu>
 <20210111220951.GA1472929@dhcp-10-100-145-180.wdc.com>
 <ed8256dd-d70d-b8dc-fdc0-a78b9aa3bbd9@ess.eu>
 <20210112192758.GB1472929@dhcp-10-100-145-180.wdc.com>
 <8650281b-4430-1938-5d45-53f09010497b@ess.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8650281b-4430-1938-5d45-53f09010497b@ess.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 11:19:37PM +0100, Hinko Kocevar wrote:
> I feel inclined to provide a little bit more info about the system I'm
> running this on as it is not a regular PC/server/laptop. It is a modular
> micro TCA system with a single CPU and MCH. MCH and CPU are separate cards,
> as are the other processing cards (AMCs) that link up to CPU through the MCH
> PEX8748 switch. I can power each card individually, or perform complete
> system power cycle. The normal power up sequence is: MCH, AMCs, CPU. The CPU
> is powered 30 sec after all other cards so that their PCIe links are up and
> ready for Linux.
> 
> All buses below CPU side 02:01.0 are on MCH PEX8748 switch:
> 
> [dev@bd-cpu18 ~]$ sudo /usr/local/bin/pcicrawler -t
> 00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
>  ├─01:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
>  │  ├─02:01.0 downstream_port, slot 1, device present, power: Off, speed 8GT/s, width x4
>  │  │  └─03:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (8748)
>  │  │     ├─04:01.0 downstream_port, slot 4, power: Off
>  │  │     ├─04:03.0 downstream_port, slot 3, power: Off
>  │  │     ├─04:08.0 downstream_port, slot 5, power: Off
>  │  │     ├─04:0a.0 downstream_port, slot 6, device present, power: Off, speed 8GT/s, width x4
>  │  │     │  └─08:00.0 endpoint, Xilinx Corporation (10ee), device 8034
>  │  │     └─04:12.0 downstream_port, slot 1, power: Off
>  │  ├─02:02.0 downstream_port, slot 2
>  │  ├─02:08.0 downstream_port, slot 8
>  │  ├─02:09.0 downstream_port, slot 9, power: Off
>  │  └─02:0a.0 downstream_port, slot 10
>  ├─01:00.1 endpoint, PLX Technology, Inc. (10b5), device 87d0
>  ├─01:00.2 endpoint, PLX Technology, Inc. (10b5), device 87d0
>  ├─01:00.3 endpoint, PLX Technology, Inc. (10b5), device 87d0
>  └─01:00.4 endpoint, PLX Technology, Inc. (10b5), device 87d0
> 
> 
> The lockups most frequently appear after the cold boot of the system. If I
> restart the CPU card only, and leave the MCH (where the PEX8748 switch
> resides) powered, the lockups do *not* happen. I'm injecting the same error
> into the root port and the system card configuration/location/count is
> always the same.
> 
> Nevertheless, in rare occasions while booting the same kernel image after
> complete system power cycle, no lockup is observed.
> 
> So far I observed that the lockups seem to always happen when recovery is
> dealing with the 02:01.0 device/bus.
> 
> If the system recovers from a first injected error, I can repeat the
> injection and the system recovers always. If the first recovery fails I have
> to either reboot the CPU or power cycle the complete system.
> 
> To me it looks like this behavior is somehow related to the system/setup I
> have, and for some reason is triggered by VC restoration (VC is not is use
> by my system at all, AFAIK).
 
> Are you able to tell which part of the code the CPU is actually spinning in
> when the lockup is detected? I added many printk()s in the
> pci_restore_vc_state(), in the AER IRQ handler, and around to see something
> being continuously printed, but nothing appeared..

It sounds like your setup is having difficulting completing config
cycles timely after a secondary bus reset. I don't see right now how
anything I've provided in this series is causing that.

All the stack traces you've provided so far are all within virtual
channel restoration. Subsequent stack traces are never the same though,
so it does not appear to be permanently stuck; it's just incredibly
slow. This particular capability restoration happens to require more
config cycles than most other capabilities, so I'm guessing it happens
to show up in your observation because of that rather than anything
specific about VC.

The long delays seem like a CTO should have kicked in, but maybe your
hardware isn't doing it right. Your lspci says Completion Timeout
configuration is not supported, so it should default to 50msec maximum,
but since it's taking long enough to trigger a stuck CPU watchdog, and
you appear to be getting valid data back, it doesn't look like CTO is
happening.
