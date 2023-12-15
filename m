Return-Path: <linux-pci+bounces-1055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C3481446C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DFB1C210A2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162517986;
	Fri, 15 Dec 2023 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om2XEVnU"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262416418
	for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702632566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlzH05gePiJDbwDlpysWL7+Cb3sV3fowzqJkjYEHj9E=;
	b=Om2XEVnUpVF95N1oVV2GhCZgDmNf9fIiC88lzbyfp+bcJxiv3fXN6rL5VBQ2rBo+parkS/
	PVp6rt97NEP7muCut7q/W/t3TwDyIQD89ns8OkmT8gSlW7IqkjsWIfuGGFybqHHcTkLtSf
	KAu77asrj7Yc9Ns8QG1gD+jvpQXhwSU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-umZMMbdrNZenyqPMkI2opw-1; Fri, 15 Dec 2023 04:29:24 -0500
X-MC-Unique: umZMMbdrNZenyqPMkI2opw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1f99db3dd0so29186066b.0
        for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 01:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702632563; x=1703237363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlzH05gePiJDbwDlpysWL7+Cb3sV3fowzqJkjYEHj9E=;
        b=IzIj5IhXA6PN+pQUBKXgQz25z5cInIrl9mjr274v3R9jJVFyxwZcYFegJlbrTvNsoi
         CQgwRvgwdl5086SeopFo2NRnjM2T+mSM+PuT8272FPdjAvPoDCjd/fbe9euUtL+cv8J3
         xX/npc/XUForLliPjOAmzkx6y+GLJ6BdYBhUgYFDIdo9GbnIEvGQ50JmjzweOxX/EMZk
         Rx9U8g9drbgo5aTxtzerypXiqWBLEfCmy6ahvfVbPM+Pqne19YcAPYJObY0JK1V2tlxW
         O2eSPw06+yG07dbEq47MCgKh9eXVrXGIliDq11FwLOvd8T0qGz8Vblp/qML24SeZROqX
         1Mdg==
X-Gm-Message-State: AOJu0YzDC4NE54GyVuivMnPJi3vklbVsbPAEk3yolhX+Dgg76cQXQYdq
	ru+RaL1S0wX5jBP880HVe1p6EkKfTjIsqtyWsvOVIf94S9bGDca7hQ5pVOYNuqznyX2yZsYFetq
	hoCIuh4px85aGY9i/kI7H
X-Received: by 2002:a17:906:6c81:b0:a19:a19a:eaa7 with SMTP id s1-20020a1709066c8100b00a19a19aeaa7mr5327691ejr.96.1702632562864;
        Fri, 15 Dec 2023 01:29:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuUTG6manj1CqrmhK8aaase4KkhFf5qY+v+gbegmurj0X846CD8zybpKetqHCeOybOHfnFtQ==
X-Received: by 2002:a17:906:6c81:b0:a19:a19a:eaa7 with SMTP id s1-20020a1709066c8100b00a19a19aeaa7mr5327686ejr.96.1702632562520;
        Fri, 15 Dec 2023 01:29:22 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id mn6-20020a1709077b0600b00a1dbda310f4sm10530551ejc.158.2023.12.15.01.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:29:22 -0800 (PST)
Date: Fri, 15 Dec 2023 10:29:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <20231215102921.587a9857@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
	<20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
	<ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 08:43:27 +1030
Jonathan Woithe <jwoithe@just42.net> wrote:

> On Thu, Dec 14, 2023 at 02:32:05PM +0100, Igor Mammedov wrote:
> > On Thu, 14 Dec 2023 11:58:20 +1030 Jonathan Woithe wrote:  
> > > 
> > > Following an update from 5.15.72 to 5.15.139 on one of my machines, the  
> > 
> > looks like you are running downstream kernel, can you file bug report
> > with distro that you use (with a link posed here as well).  
> 
> I am running Slackware64 15.0.  The kernels supplied by that distribution
> are unmodified kernel.org kernels.
> 
> > For now offending patches are being reverted, so downstream bug will help
> > with tracking it and reverting it there.   
> 
> The patches will be reverted in Slackware as a matter of course when a
> kernel.org "-stable" kernel with the fix is adopted.  Slackware does not
> apply any patches to kernel.org kernels.  Nevertheless, I will raise a post
> in the forum, hopefully later today.
> 
> > > console froze part way through the boot process.  The machine still managed
> > > to boot: it could be reached via the network and a keyboard-initiated
> > > shutdown would do the right thing.  The problem was that the screen remained
> > > static the whole time: the X login did not appear.  Only a reboot would
> > > restore the display's functionality.
> > > 
> > > Comparing boot logs between these two kernels showed that 5.15.139 reported
> > > the following messages not seen with 5.15.72:
> > > 
> > >     thunderbolt 0000:04:00.0: interrupt for TX ring 0 is already enabled
> > >     WARNING: CPU: 0 PID: 713 at drivers/thunderbolt/nhi.c:139 ring_interrupt_active+0x218/0x270 [thunderbolt]
> > > 
> > >     thunderbolt 0000:04:00.0: interrupt for RX ring 0 is already enabled
> > >     WARNING: CPU: 0 PID: 713 at drivers/thunderbolt/nhi.c:139 ring_interrupt_active+0x218/0x270 [thunderbolt]
> > > 
> > >     radeon 0000:4b:00.0: Fatal error during GPU init
> > >     radeon: probe of 0000:4b:00.0 failed with error -12
> > > 
> > > The fatal error during GPU initialisation would be the reason behind the
> > > frozen screen.  I don't know if the thunderbolt warnings are significant.
> > > 
> > > A git bisect resulted in the following report:
> > > 
> > >     d9ce077f8b1f731407e6b612b03bba464fd18d9b is the first bad commit
> > >     commit d9ce077f8b1f731407e6b612b03bba464fd18d9b
> > >     Author: Igor Mammedov <imammedo@redhat.com>
> > >     Date:   Mon Apr 24 21:15:57 2023 +0200
> > > 
> > >         PCI: acpiphp: Reassign resources on bridge if necessary
> > >     
> > >         [ Upstream commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 ]
> > > 
> > > It's taken me a while to work through the bisect process due to limited
> > > access to the machine concerned.  I see that in the last few days there have
> > > been other reports associated with this commit.  The symptoms on my machine
> > > are different to the other reporters.  In particular, I note that I'm
> > > running the Linux kernel on bare metal.
> > > 
> > > For what it's worth, I also experienced the same problem when I tested 6.6.4
> > > last week (the most recent kernel at the time of testing).
> > > 
> > > The output of lspci is given at the end of this post[1].  The CPU is an
> > > "Intel(R) Core(TM) i7-5930K CPU @ 3.50GHz" which is not overclocked.  Please
> > > let me know if you'd like more information about the affected machine.  I
> > > can also perform additional tests if required, although for various reasons
> > > these can only be done on Thursdays at present.

can you provide 'lspci -tv' output as well and machine model for the record?

> > > The kernel configuration file can easily be supplied if that would be
> > > useful.  
> > 
> > full dmesg log and used config might help down the road (preferably with current
> > upstream kernel), as I will be looking into fixing related issues.
> > 
> > Perhaps a better way for taking this issue and collecting logs, will be
> > opening a separate bug at https://bugzilla.kernel.org (pls CC me as well)  
> 
> Sure, will do.  I'll be able to get the dmesg log from my earlier tests and
> config easily enough.  Testing with another kernel will have to wait until
> next Thursday as that is when I'll next have physical access to the machine.
> 
> Which upstream kernel would you like me to test with: the latest "-stable",
> or the most recent release?

current master branch that still has offending patches would do
(or any recent one with specifying commit id)

Also add:

dyndbg="file drivers/pci/access.c +p; file drivers/pci/hotplug/acpiphp_glue.c +p; file drivers/pci/bus.c +p; file drivers/pci/pci.c +p; file drivers/pci/setup-bus.c +p" ignore_loglevel

to kernel command line to get more data from PCI/acpiphp enumeration process
 
> Regards
>   jonathan
> 
> > > [1] lspci output



> > > 
> > > 00:00.0 Host bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2 (rev 02)
> > > 00:01.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> > > 00:01.1 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> > > 00:03.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 3 (rev 02)
> > > 00:05.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Address Map, VTd_Misc, System Management (rev 02)
> > > 00:05.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Hot Plug (rev 02)
> > > 00:05.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 RAS, Control Status and Global Errors (rev 02)
> > > 00:11.0 Unassigned class [ff00]: Intel Corporation C610/X99 series chipset SPSR (rev 05)
> > > 00:14.0 USB controller: Intel Corporation C610/X99 series chipset USB xHCI Host Controller (rev 05)
> > > 00:16.0 Communication controller: Intel Corporation C610/X99 series chipset MEI Controller #1 (rev 05)
> > > 00:19.0 Ethernet controller: Intel Corporation Ethernet Connection (2) I218-V (rev 05)
> > > 00:1a.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #2 (rev 05)
> > > 00:1b.0 Audio device: Intel Corporation C610/X99 series chipset HD Audio Controller (rev 05)
> > > 00:1c.0 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #1 (rev d5)
> > > 00:1c.3 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #4 (rev d5)
> > > 00:1d.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #1 (rev 05)
> > > 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC Controller (rev 05)
> > > 00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-Port SATA Controller [AHCI mode] (rev 05)
> > > 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller (rev 05)
> > > 02:00.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 03:00.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 03:01.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 03:02.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 03:04.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 04:00.0 System peripheral: Intel Corporation DSL6540 Thunderbolt 3 NHI [Alpine Ridge 4C 2015]
> > > 49:00.0 USB controller: Intel Corporation DSL6540 USB 3.1 Controller [Alpine Ridge]
> > > 4b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cedar [Radeon HD 5000/6000/7350/8350 Series]
> > > 4b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI Audio [Radeon HD 5400/6300/7300 Series]
> > > 4d:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
> > > ff:0b.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> > > ff:0b.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> > > ff:0b.2 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> > > ff:0c.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> > > ff:0f.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> > > ff:0f.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> > > ff:0f.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> > > ff:0f.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> > > ff:10.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> > > ff:10.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> > > ff:10.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> > > ff:10.6 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> > > ff:10.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> > > ff:12.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> > > ff:12.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> > > ff:13.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> > > ff:13.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> > > ff:13.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > > ff:13.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > > ff:13.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > > ff:13.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > > ff:13.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 0/1 Broadcast (rev 02)
> > > ff:13.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> > > ff:14.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 Thermal Control (rev 02)
> > > ff:14.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 Thermal Control (rev 02)
> > > ff:14.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 ERROR Registers (rev 02)
> > > ff:14.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 ERROR Registers (rev 02)
> > > ff:14.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > > ff:14.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > > ff:14.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > > ff:14.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > > ff:15.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 Thermal Control (rev 02)
> > > ff:15.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 Thermal Control (rev 02)
> > > ff:15.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 ERROR Registers (rev 02)
> > > ff:15.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 ERROR Registers (rev 02)
> > > ff:16.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Target Address, Thermal & RAS Registers (rev 02)
> > > ff:16.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 2/3 Broadcast (rev 02)
> > > ff:16.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> > > ff:17.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Channel 0 Thermal Control (rev 02)
> > > ff:17.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > > ff:17.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > > ff:17.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > > ff:17.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > > ff:1e.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1e.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1e.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1e.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1e.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)
> > > ff:1f.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)  
> 


