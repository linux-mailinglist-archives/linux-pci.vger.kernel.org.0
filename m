Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A176438339
	for <lists+linux-pci@lfdr.de>; Sat, 23 Oct 2021 12:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhJWKmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Oct 2021 06:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhJWKmd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 23 Oct 2021 06:42:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 002FD60FE3;
        Sat, 23 Oct 2021 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634985614;
        bh=3MBPYLWL9O+7m9TCPJ92U2nLKobJyWzIaIxXwvd7Qzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mi7jsVV8qZEOM6YU1gSkUC/miXtGjPCmYqkaEywD8DNghBqYV/oTx+kVrZpsej36p
         2e1SxbXy+7NkTdEx+Vjwfl8v3f33PlHOoGut5WwabZZNQE45rnpuXe9gpu603hXO1h
         84zhgG4Fk6yhJ2K+zrt+X3ZBcm1WmVd3UDN97zJbCvE/jeDdgqSZwJsYwgYUTSWc7d
         XfSoz6qTFW9bpueizE4N5cvsLdBrWctUgiNBhR6Rqk9WuaZI+pKuPqy8xjBduaVt+/
         gUTxLKQsr7zFsc7hdbWihOh6WgrK65YtYcYIBPc/4radtKKtazbRYESLJwff7PULCq
         wPhB/ktjLLvRQ==
Received: by pali.im (Postfix)
        id 7346D883; Sat, 23 Oct 2021 12:40:11 +0200 (CEST)
Date:   Sat, 23 Oct 2021 12:40:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 05/11] PCI: kirin: give more time for PERST# reset to
 finish
Message-ID: <20211023104011.zmj7y7vtplpnmhwd@pali>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
 <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
 <20211022151624.mgsgobjsjgyevnyt@pali>
 <20211023103059.6add00e6@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211023103059.6add00e6@sal.lan>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Saturday 23 October 2021 10:30:59 Mauro Carvalho Chehab wrote:
> Hi Pali,
> 
> Em Fri, 22 Oct 2021 17:16:24 +0200
> Pali Rohár <pali@kernel.org> escreveu:
> 
> > On Tuesday 19 October 2021 07:06:42 Mauro Carvalho Chehab wrote:
> > > Before code refactor, the PERST# signals were sent at the
> > > end of the power_on logic. Then, the PCI core would probe for
> > > the buses and add them.
> > > 
> > > The new logic changed it to send PERST# signals during
> > > add_bus operation. That altered the timings.
> > > 
> > > Also, HiKey 970 require a little more waiting time for
> > > the PCI bridge - which is outside the SoC - to finish
> > > the PERST# reset, and then initialize the eye diagram.  
> > 
> > Hello! Which PCIe port do you mean by PCI bridge device? Do you mean
> > PCIe Root Port? Or upstream port on some external PCIe switch connected
> > via PCIe bus to the PCIe Root Port? Because all of these (virtual) PCIe
> > devices are presented as PCI bridge devices, so it is not clear to which
> > device it refers.
> 
> HiKey 970 uses an external PCI bridge chipset (a Broadcom PEX 8606[1]),

Ok! Now I understood. You have probably one PCIe Root Port on your board
and to this port you have connected (external) PCIe switch card from
Broadcom to increase number of PCIe ports for endpoint cards.
It is classic setup for boards with just one PCIe port.

> with 3 elements connected to the bus: an Ethernet card, a M.2 slot and
> a mini PCIe slot. It seems HiKey 970 is unique with regards to PERST# signal,
> as there are 4 independent PERST# signals there:
> 
> 	- one for PEX 8606 (the PCIe root port);
> 	- one for Ethernet;
> 	- one for M.2;
> 	- one for mini-PCIe.

This is not unique setup, its pretty normal. Every PCIe card has (own)
PERST# pin and obviously you want to control each pin separately via SW.
And because PCIe switch is also (upstream) PCIe device it has also
PERST# pin.

> After sending the PCIe PERST# signals, the device has to wait for 21 ms
> before adjusting the eye diagram.

"the device" which has to wait is HiKey970 or PEX8606?

> [1] https://docs.broadcom.com/docs/PEX_8606_AIC_RDK_HRM_v1.3_06Aug10.pdf
> 
> > Normally PERST# signal is used to reset endpoint card, other end of PCIe
> > link and so PERST# signal should not affect PCIe Root Port at all.
> 
> That's not the case, as PEX 8606 needs to complete its reset sequence
> for the rest of the devices to be visible. If the wait time is reduced
> or removed, the devices behind it won't be detected.

Well, "endpoint card" for HiKey970 PCIe link is here PEX8606. And if you
connect PEX8606 to any other board (which could have totally different
PCIe controller), it means that same wait timeouts are required for that
other board.

So this wait timeout 21 ms is not HiKey970 specific, but rather PEX8606
specific, right?

> > > So, increase the waiting time for the PERST# signals to
> > > what's required for it to also work with HiKey 970.  
> > 
> > Because PERST# signal resets endpoint card, this reset timeout should
> > not be driver or controller specific.
> 
> Not sure if it would be possible to implement it at the core without
> breaking devices like this one where there's a separate chip to actually
> implement the PCIe bus.

I think it should be possible. Probably not so easy, would need more
testing, etc... But as I wrote above, this setup is not unique, it is
really normal and kernel is prepared to work PCI and PCIe topologies
when one or more PCIe switches, PCIe-to-PCI bridges or even more
PCI-to-PCI bridges are used and connected to system board.

I send email with proposal / idea how could be PCI subsystem extended to
handle initialization of native PCIe controller drivers:
https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/
(if you have some more points, feel free to reply)

> > Mauro, if you understand this issue more deeply, could you look at my
> > email? https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> > 
> > I think that kernel PCI subsystem does not properly handle PCIe Warm
> > Reset and correct initialization of endpoint cards. Because similar
> > "random PERST# timeout patches" were applied to lot of native controller
> > drivers.
> 
> I don't know enough about PCIe documentation in order to help with that.
> Yet, if the PCI/PCIe specs doesn't define a maximum time for PERST# to
> finish, hardware manufacturers will do whatever they please. So, finding
> a common value is impossible. 

Well, it is possible that just I was not able to "find and decode" this
timeout from specifications. So I'm just asking if somebody else was
able to do it :-)

> Well, even if specs define it, vendors may still violate that. So, whatever 
> implementation is done, some quirks may be needed.

Of course, we know it and kernel has hooks and corrections for such
situation. Fixes are in most cases in one place: drivers/pci/quirks.c

> Sending PERST# signals to the devices connected to the bridge too early
> will cause the bridge to not detect the devices behind it. That's what
> happens with HiKey 970: lower reset values cause it to miss devices.

Just to make sure, that I understand your problem. Is your setup looks
like this?

          +-------------------------------------PERST#--+---+
          |                                             |eth|
          |                 +------PERST#--+  +--PCIe---+---+
          |                 |              |  |
  +-------------+ +-------------+        +-------+      +---+
  |GPIO-HiKey970| |PCIe-HiKey970|--PCIe--|PEX8606|-PCIe-|m.2|
  +-------------+ +-------------+        +-------+      +---+
          |           |          +-----+        |         |
          |           +--PERST#--|mPCIe|--PCIe--+         |
          |                      +-----+                  |
          +---------------------------------------PERST#--+

And if yes, in which order you need to assert individual PERST# signals
and in which order to de-assert them?

> Looking from harware perspective, I'd say that the reset time pretty
> much depends on how the PCIe bridges are implemented: if it is FPGA, it is 
> probably slower than if it is a dedicated hardware. It can be even slower
> if the bridge uses a microcontroller and needs to read the firmware from 
> some place.
> 
> > PS: I'm not opposing this patch, I'm just trying to understand what is
> > happening here and why particular number "21000" was chosen. It is
> > defined in some standard? Or was it just randomly chosen and measures
> > that with this number is initialization working fine?
> 
> It is the value used by the HiKey 970 PCIe out-of-tree driver. The patch
> which added support for it at the pcie-kirin increased the time out there.
> 
> I tried to preserve the previous value, but that cause some devices to
> be missed during PCI probe time.
> 
> Btw, PEX 8606 datasheet says:
> 
> 	`Reset Circuit
> 
> 	 The PEX 8606BA-AIC1U1D RDK accepts a PERST# from the host PC via card edge connector P1. This signal is
> 	 OR’d with a manual reset circuit. The manual reset circuit consists of a pushbutton (SW7, upper left corner) that
> 	 feeds into a reset timer. The reset timer monitors its power rail and reset input. If the reset input is low or the
> 	 supply rail is out of range, the reset output is held. Once both conditions no longer exist, the reset output will de-
> 	 assert after a programmable reset timeout period (capacitor adjustable, default value 128 msec). The OR’d reset
> 	 signal goes to the PEX 8606 device’s PEX_PERST# input pin, and the downstream slots’ PERST# connector
> 	 pins. PERST# to Slot J1 can be controlled by the PEX 8606 device’s Hot-Plug interface.'
> 
> If I understood it well, the PERST# time is hardware-configurable, by
> changing the value of a capacitor.

Hm... this is something different. It says: "Once both conditions no
longer exist, the reset output will de-assert after a programmable reset
timeout period (capacitor adjustable, default value 128 msec)."

I understand this part that if signal is no longer in reset that then
this capacitor cause that reset is held for another 128 ms. So if host
stops reset signal then it has to wait 128 ms prior doing something
(to ensure that reset finished), right?

> Regards,
> Mauro
> > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > > 
> > > See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/
> > > 
> > >  drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > index de375795a3b8..bc329673632a 100644
> > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > @@ -113,7 +113,7 @@ struct kirin_pcie {
> > >  #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
> > >  
> > >  /* Time for delay */
> > > -#define REF_2_PERST_MIN		20000
> > > +#define REF_2_PERST_MIN		21000
> > >  #define REF_2_PERST_MAX		25000
> > >  #define PERST_2_ACCESS_MIN	10000
> > >  #define PERST_2_ACCESS_MAX	12000
> > > -- 
> > > 2.31.1
> > >   
