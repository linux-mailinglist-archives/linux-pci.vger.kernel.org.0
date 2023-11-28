Return-Path: <linux-pci+bounces-198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C34A7FB132
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 06:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1C8B20F39
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 05:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B3E101DE;
	Tue, 28 Nov 2023 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="MWN6zfzT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dT8V0GJS"
X-Original-To: linux-pci@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F03E1;
	Mon, 27 Nov 2023 21:24:37 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B38AA5C0258;
	Tue, 28 Nov 2023 00:24:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 Nov 2023 00:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701149074; x=1701235474; bh=j/
	kPqcYndSCOmoY28HkcVqru2o7xDw2fZ6FyDxPFLZg=; b=MWN6zfzTaULv/jcTpx
	dairjdgFtFGa75C9rjV2ckBz5kqPTkDzqm4XQKhJL1CQrIOtmTA2OKH7FuLctEX1
	gltak6Ez/Zdc+iyMaJ3CwIJmX4qEpKYScMKrKyFkI8zpcI03vKDOWjVg7OS6qmsC
	NKzRVZap0L3OxgckOrzv1n4Yp6glV7TnmTnbPn2C8KfLvQOYUxcz6Gt8pSh7m8lv
	F+OFb7MVg/LoSUrqQoynyJUzAiLQkzdjApYoApkkS2DbFkJqlY9T+qro92tynOYT
	cIUi/YELsmwu2ImWotKqZlOfPL6EFzfVW/0QcNuS+2M8Dmv6oXfE+GHx0G4r/SLC
	nJLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701149074; x=1701235474; bh=j/kPqcYndSCOm
	oY28HkcVqru2o7xDw2fZ6FyDxPFLZg=; b=dT8V0GJS0WHv9GGOln6Khl1VBwp31
	acwT1UCRc+C48u8fX6OXvEOcwcTGpXFZvMYQuJdFezZ+IALpa1/Vf5iCOMISvoWm
	qx4/xU05wT/DJduJ/4EGJjLU5d9NlVu8Ed4qBEtwp2DkZJggoyM7dsUyOSuK4CGn
	9LBAowjyw27Nd8VNrQPjDijv0lxca6TKQCJV/c+Czs/ntQkhS3VXdjaJaFaEttJ5
	fJyCy69Izucuh0CuVcbt7WoMpP90UZquaXZOMUFUFQoOloqqOQUG2a+BTJDe2BFv
	aElAlxc/ITxzs1FDJnNMbd1c7pUb3VstKM+u7/jqg2jasBbbUYt+vR+bw==
X-ME-Sender: <xms:knllZeMOqMlz_TFsaZ6BSlKNN9tAuee8Y8EwtYNh69rWGRmK4pOMjg>
    <xme:knllZc9kKLW1h_xvXBJAMzpqEDdGXWRI8hvENVIWL_JkEZunzE-HSGynKSkQPUZUU
    php4aZHLZhm7IRO1xM>
X-ME-Received: <xmr:knllZVQ--dRPX38-Dwik5lOApcXH_dAdM4zjVB4I7WZC9XE2dHklte8QCSFNZfMMBIG_KZh5X1U4-D7CAh_Q4INtQxEVOPvdKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeivddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeejueevkefggfevgfffffehueeuhedvgeekkeefgeei
    jeduvddvffejkeevvdffveenucffohhmrghinheptddqfeejqdhgvghnvghrihgtrdhith
    dpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:knllZettci65TzbvQv07YpQLBMpXSkmK6N1YEI1RUX2zkZvg-XMeKg>
    <xmx:knllZWezYfCXZRolVqAqvyI7yeSvKTwLtq5MFQWvVo966vyMxrXPiA>
    <xmx:knllZS2Jolb1Q5eHiK2-f1X1-rJ2u1h3_MjwgAkRP1_RhDOOoY_70g>
    <xmx:knllZcvAQJBj25g2F2A764WAqIrkFASghJspcTZwT45X9vyhpZSqYg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 00:24:32 -0500 (EST)
Date: Tue, 28 Nov 2023 14:24:29 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
	LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
	bagasdotme@gmail.com,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Message-ID: <20231128052429.GA25379@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
	LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
	bagasdotme@gmail.com,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
 <20231107121756.GA168964@workstation.local>
 <318cc8da-f8d2-4307-866e-8c302dacf094@amd.com>
 <20231108051638.GA194133@workstation.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108051638.GA194133@workstation.local>

Hi Mario

Following up on our last conversation, I purchase some hardware to
attempt to retrieve outputs from serial port. Finally, I bought another
mother board in used market which provides serial port from Super I/O
chip (ASUS TUF Gaming X570-Plus). However, I have retrieved no helpful
outputs yet when encountering the system reboot.

As you mentioned, I check whether PCIe AER is enabled or not in the
running kernel (Ubuntu 23.04 linux-image-6.2.0-37-generic). It is
certainly enabled, however I can see nothing in the output as I noted.

I experienced extra troubles relevant to AMD Ryzen machine and the issued
PCIe device:

* ASRock X570 Phantom Gaming 4 with AMD Ryzen 5 3600X does not detect
  the card. We can see no corresponding entry in lspci.
* After associating the card to vfio-pci, lspci command can reboot the
  system even if firewire-ohci driver is not loaded. I can regenerate it
  in both Gigabyte AX370-Gaming 5/ASUS TUF Gaming X570-plus with AMD
  Ryzen 2400G.

I'm plreased to see if you have extra ideas to get helpful output from
the system. But I guess that I should start finding some workaround to
avoid the issued access to register instead of investigating the reboot
mechanism, sigh...

Anyway, thanks for your help.


Takashi Sakamoto

On Wed, Nov 08, 2023 at 02:16:44PM +0900, Takashi Sakamoto wrote:
> Hi Mario,
> 
> On Tue, Nov 07, 2023 at 03:27:08PM -0600, Mario Limonciello wrote:
> > +linux-pci / Bjorn
> > On 11/7/2023 06:17, Takashi Sakamoto wrote:
> > > Hi Mario,
> > > 
> > > Thanks for the report.
> > > 
> > > I apologize for the inconvenience you and your reporter facing, however
> > > I can not avoid to say that the problem appears to be specific to the AMD
> > > Ryzen machines.
> > 
> > Unfortunately I don't have this 1394 hardware myself.  I was just looking at
> > another completely unrelated issue on Bugzilla and noticed the report come
> > up in my search and wanted to ensure it's on your radar already as the
> > author as it's lingered a while.
> 
> It is your misfortune to face this kind of machine trouble.
> 
> In the report[1], Matthias Schrumpf and Mark Broadworth noted to use AMD
> Ryzen 7 5800X on B550/X570 chipsets, and insert VT6307 in their PCIe bus.
> I guess that the device attends PCI bridge (ASM1083) since VT6307 has PCI
> interface only.
> 
> We can see MCE error in another report[2]. Unfortunately, the reporter,
> Ian Donnelly, have less suspiction about machine architecture, and never
> provides hardware information. But I believe that it comes from AMD Ryzen
> machine. I transcribe the error here:
> 
> ```
> [    0.860834] mce: [Hardware Error]: Machine check events logged
> [    0.860834] microcode: CPU20: patch_level=0x0a201025
> [    0.860835] microcode: CPU21: patch_level=0x0a201025
> [    0.860836] microcode: CPU23: patch_level=0x0a201025
> [    0.860836] microcode: CPU22: patch_level=0x0a201025
> [    0.860837] mce: [Hardware Error]: CPU 17: Machine Check: 0 Bank 0: bc00080001010135
> [    0.860845] fbcon: Taking over console
> [    0.860847] mce: [Hardware Error]: TSC 0 ADDR fca000f0 MISC d012000000000000 IPID 1000b000000000 
> [    0.860854] mce: [Hardware Error]: PROCESSOR 2:a20f10 TIME 1696955537 SOCKET 0 APIC b microcode a201025
> [    0.860860] microcode: CPU0: patch_level=0x0a201025
> [    0.861676] microcode: Microcode Update Driver: v2.2.
> ```
> 
> Additionally, as I note in the PR[3], I observed cache-coherence failure
> over memory dedicated for DMA transmission. The mapping is created by
> `dmam_alloc_coherent()` and no need to have extra care such as streaming
> API. However, the combination of ASM1083 and VT6307 provides me bogus
> values from the memory in AMD Ryzen machine, and I can see no issue in
> Intel machines.
> 
> Essentially, the host system reboots when firewire-ohci module in guest
> system probes the PCI device for 1394 OHCI hardware provided by PCI
> pass-though[4].
> 
> > > I've already received the similar report[1], and have been
> > > investigating it in the last few weeks, then got the insight. Please take
> > > a look at my short report about it in PR to Linus for 6.7-rc1:
> > > https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/
> > > 
> > > I can confirm that I have been abe to reproduce the problem on AMD Ryzen
> > > machine. However, it's important to note that I have not observed the
> > > problem on the following systems:
> > 
> > Any chance you (or anyone with the issue) has a serial output available?
> > I think it would be really good to look at the circumstances surrounding the
> > reboot.
> >
> > > 
> > > * Intel machine (Sandy Bridge and Skylake generations)
> > > * AMD machines predating Ryzen (Sempron 145)
> > > * Machines using different 1394 OHCI hardware from other vendors such as
> > >    TI
> > > * VIA VT6307 connected directly to PCI slot (i.e. without the issued
> > >    PCIe/PCI bridge)
> > > 
> > > Currently, I have not been able to obtain any useful debug output from
> > > the Linux system or any hardware error reports when the system reboots.
> > > It seems that the system reboots spontaneously. My assumption at this
> > > point is that AMD Ryzen machines detect a specific hardware error
> > > triggered by Ryzen machine quirk related to the combination of the Asmedia
> > > ASM1083/1085 and VIA VT6306/6307/6308, leading to power reset.
> > > 
> > 
> > Recent kernels have enabled PCI AER.  Could that be factoring in perhaps?
> 
> I ordered equipments for the workflow, and waiting for shipping, since
> my motherboard has no interface for serial output.
> 
> (However, I predict that we can no helpful output via the interface.)
> 
> > > I genuinely appreciate your assistance in debugging this elusive
> > > hardware issue. If any workaround specific to AMD Ryzen machine quirk is
> > > required in PCI driver for 1394 OHCI hardware, I'm willing to apply it.
> > > However, it is preferable to figure out the reboot mechanism at first,
> > > I think.
> > 
> > Does the BIOS on these machines enable a watchdog timer?  If so, I'd suggest
> > disabling that for a starting point.
>  
> For consumer use, the machine has no such function, I think. For
> your information, this is the machine information I used:
> 
> * Ryzen 5 2400G
> * Gigabyte Technology Co., Ltd. AX370-Gaming 5/AX370-Gaming 5
>     * BIOS F51h 02/09/2023
> 
> > How about if you compile as a module and then modprobe.blacklist the module
> > on kernel command line and load it later.  Can you trigger the fault/reboot
> > this way?  If so, it at least rules out some conditions that happen during a
> > race at boot.
> 
> Nowadays FireWire software stack is optional in the most of
> distributions. I can encounter the same issue at deferred probing enough
> after booting up, even if the load of system is very low.
> 
> > Looking more closely at the change, I would guess the fault is specifically
> > in get_cycle_time().  I can see that the VIA devices do set
> > QUIRK_CYCLE_TIMER which will cause additional reads.
> 
> I've already tested with the driver compiled without these codes, but the
> system reboots again.
> 
> > Another guesses worth looking at is to see if iommu=pt or amd_iommu=off
> > help.
> > 
> > If either of those help it could point at being a problem with
> > get_cycle_time() and IOMMU.  The older systems you mentioned working
> > probably didn't enable IOMMU by default but most AMD Ryzen systems do.
> 
> I already suspect platform IOMMU and kernel implementation, however it
> is helpless to disable AMD SVM and IOMMU in BIOS settings. Of course, it
> is helpless as well to provide any options to iommu in kernel command line.
> 
> If I had any opportunity to access to AMD machines for enterprise-grade
> usage somehow, I would have done it. However, I am a private-time
> contributor and what I can access to is the ones for consumer use
> without any hardware support for RAS reporting.
> 
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217993
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=217994
> [3] https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/
> [4] https://lore.kernel.org/lkml/20231016155657.GA7904@workstation.local/
> 
> Thanks
> 
> Takashi Sakamoto

