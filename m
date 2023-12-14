Return-Path: <linux-pci+bounces-994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD38131A4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 14:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A99281D1C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA25455C29;
	Thu, 14 Dec 2023 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyxacbqD"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F047111
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 05:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702560730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppXqCki9R+S5vznWaW7NFayx/hURpreMrDa/yN04s5g=;
	b=HyxacbqD/LsM+NDnaMjld68CUZ2oX6BzbQ4g/2ClZpfOqhQ2CMnISuIzR+8mDYqDGw+lmG
	MLJPelC5eHnWEGc3/TFhIqJXZ7n1Hypc1CJikT2ocI/O03ZGOPlIp/c8rJEguEaLEfHBq0
	NDvsSQrTBv2r5hqFNdIp4V8SfoGQQ7c=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-nS3kbmNwNGqdInumvW7IDw-1; Thu, 14 Dec 2023 08:32:09 -0500
X-MC-Unique: nS3kbmNwNGqdInumvW7IDw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50bec8466b6so6187340e87.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 05:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560727; x=1703165527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppXqCki9R+S5vznWaW7NFayx/hURpreMrDa/yN04s5g=;
        b=Ki//8jpm5l6Z8Z4KpA63TfPnJ78ZeFZoFC4yl2s6/939VdSfH1yWt9aWD1WRkyAkTO
         yLl3sTYT+4BZMTDPR1IL9hrE+d7cz/uZQLszoLLxTEKIJRQGwcioSUiWDat4IuiyIuVh
         diPJQtACzrGayb5rlQ3lOPHNocBbiSGrl93uDlC0fx7dF6Y4Ditt9qsZBRW/jJJGLnfo
         v7qTSPkBE3OVmgBKtizSZ+IoLrVwPkUSp7osqN+y7Elp8uPYqi/KSMY+SkaAH9DxdTFg
         ejrcjGeoKwGc6c5WMK5azZV7U9gCeOuHv2DN5VPPVZaFLxhoTbX8jtfsOQ33ClnBzEMs
         T5jw==
X-Gm-Message-State: AOJu0YwPQRAlFiN6evMtJDiAdbODanHqhvt/U3V1vBELh7KQNGNOfWIu
	Xk5R0M8ZxI+gSd/qlv8GPf0a2w4ey5LsD4bud9/0tNG1L1ucBDufd8CC21tbkEpqCOwkNB65Cp+
	5j/hPiON1VspDGSnGT+us
X-Received: by 2002:a05:6512:3194:b0:50e:16ed:7164 with SMTP id i20-20020a056512319400b0050e16ed7164mr711757lfe.109.1702560727648;
        Thu, 14 Dec 2023 05:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHI6Ur7Ya7/fIJTAvdsntTHHABvqEtCuS9ADdvIVmZEA74U5aI+1UwN5xJWU1xcANDL6NUjQ==
X-Received: by 2002:a05:6512:3194:b0:50e:16ed:7164 with SMTP id i20-20020a056512319400b0050e16ed7164mr711747lfe.109.1702560727236;
        Thu, 14 Dec 2023 05:32:07 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id mt29-20020a170907619d00b00a0a5a794575sm9412036ejc.216.2023.12.14.05.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:32:06 -0800 (PST)
Date: Thu, 14 Dec 2023 14:32:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 11:58:20 +1030
Jonathan Woithe <jwoithe@just42.net> wrote:

> Hi
> 
> Following an update from 5.15.72 to 5.15.139 on one of my machines, the

looks like you are running downstream kernel, can you file bug report
with distro that you use (with a link posed here as well).

For now offending patches are being reverted, so downstream bug will help
with tracking it and reverting it there. 

> console froze part way through the boot process.  The machine still managed
> to boot: it could be reached via the network and a keyboard-initiated
> shutdown would do the right thing.  The problem was that the screen remained
> static the whole time: the X login did not appear.  Only a reboot would
> restore the display's functionality.
> 
> Comparing boot logs between these two kernels showed that 5.15.139 reported
> the following messages not seen with 5.15.72:
> 
>     thunderbolt 0000:04:00.0: interrupt for TX ring 0 is already enabled
>     WARNING: CPU: 0 PID: 713 at drivers/thunderbolt/nhi.c:139 ring_interrupt_active+0x218/0x270 [thunderbolt]
> 
>     thunderbolt 0000:04:00.0: interrupt for RX ring 0 is already enabled
>     WARNING: CPU: 0 PID: 713 at drivers/thunderbolt/nhi.c:139 ring_interrupt_active+0x218/0x270 [thunderbolt]
> 
>     radeon 0000:4b:00.0: Fatal error during GPU init
>     radeon: probe of 0000:4b:00.0 failed with error -12
> 
> The fatal error during GPU initialisation would be the reason behind the
> frozen screen.  I don't know if the thunderbolt warnings are significant.
> 
> A git bisect resulted in the following report:
> 
>     d9ce077f8b1f731407e6b612b03bba464fd18d9b is the first bad commit
>     commit d9ce077f8b1f731407e6b612b03bba464fd18d9b
>     Author: Igor Mammedov <imammedo@redhat.com>
>     Date:   Mon Apr 24 21:15:57 2023 +0200
> 
>         PCI: acpiphp: Reassign resources on bridge if necessary
>     
>         [ Upstream commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 ]
> 
> It's taken me a while to work through the bisect process due to limited
> access to the machine concerned.  I see that in the last few days there have
> been other reports associated with this commit.  The symptoms on my machine
> are different to the other reporters.  In particular, I note that I'm
> running the Linux kernel on bare metal.
> 
> For what it's worth, I also experienced the same problem when I tested 6.6.4
> last week (the most recent kernel at the time of testing).
> 
> The output of lspci is given at the end of this post[1].  The CPU is an
> "Intel(R) Core(TM) i7-5930K CPU @ 3.50GHz" which is not overclocked.  Please
> let me know if you'd like more information about the affected machine.  I
> can also perform additional tests if required, although for various reasons
> these can only be done on Thursdays at present.
> 
> The kernel configuration file can easily be supplied if that would be
> useful.

full dmesg log and used config might help down the road (preferably with current
upstream kernel), as I will be looking into fixing related issues.

Perhaps a better way for taking this issue and collecting logs,
will be opening a separate bug at https://bugzilla.kernel.org (pls CC me as well)


> Regards
>   jonathan
> 
> [1] lspci output
> 
> 00:00.0 Host bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2 (rev 02)
> 00:01.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> 00:01.1 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> 00:03.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 3 (rev 02)
> 00:05.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Address Map, VTd_Misc, System Management (rev 02)
> 00:05.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Hot Plug (rev 02)
> 00:05.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 RAS, Control Status and Global Errors (rev 02)
> 00:11.0 Unassigned class [ff00]: Intel Corporation C610/X99 series chipset SPSR (rev 05)
> 00:14.0 USB controller: Intel Corporation C610/X99 series chipset USB xHCI Host Controller (rev 05)
> 00:16.0 Communication controller: Intel Corporation C610/X99 series chipset MEI Controller #1 (rev 05)
> 00:19.0 Ethernet controller: Intel Corporation Ethernet Connection (2) I218-V (rev 05)
> 00:1a.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #2 (rev 05)
> 00:1b.0 Audio device: Intel Corporation C610/X99 series chipset HD Audio Controller (rev 05)
> 00:1c.0 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #1 (rev d5)
> 00:1c.3 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #4 (rev d5)
> 00:1d.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #1 (rev 05)
> 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC Controller (rev 05)
> 00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-Port SATA Controller [AHCI mode] (rev 05)
> 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller (rev 05)
> 02:00.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> 03:00.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> 03:01.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> 03:02.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> 03:04.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> 04:00.0 System peripheral: Intel Corporation DSL6540 Thunderbolt 3 NHI [Alpine Ridge 4C 2015]
> 49:00.0 USB controller: Intel Corporation DSL6540 USB 3.1 Controller [Alpine Ridge]
> 4b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cedar [Radeon HD 5000/6000/7350/8350 Series]
> 4b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI Audio [Radeon HD 5400/6300/7300 Series]
> 4d:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
> ff:0b.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> ff:0b.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> ff:0b.2 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> ff:0c.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0c.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0c.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0c.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0c.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0c.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> ff:0f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> ff:0f.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> ff:0f.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> ff:0f.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> ff:0f.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> ff:10.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> ff:10.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> ff:10.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> ff:10.6 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> ff:10.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> ff:12.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> ff:12.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> ff:13.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> ff:13.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> ff:13.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> ff:13.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> ff:13.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> ff:13.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> ff:13.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 0/1 Broadcast (rev 02)
> ff:13.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> ff:14.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 Thermal Control (rev 02)
> ff:14.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 Thermal Control (rev 02)
> ff:14.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 ERROR Registers (rev 02)
> ff:14.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 ERROR Registers (rev 02)
> ff:14.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> ff:14.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> ff:14.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> ff:14.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> ff:15.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 Thermal Control (rev 02)
> ff:15.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 Thermal Control (rev 02)
> ff:15.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 ERROR Registers (rev 02)
> ff:15.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 ERROR Registers (rev 02)
> ff:16.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Target Address, Thermal & RAS Registers (rev 02)
> ff:16.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 2/3 Broadcast (rev 02)
> ff:16.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> ff:17.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Channel 0 Thermal Control (rev 02)
> ff:17.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> ff:17.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> ff:17.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> ff:17.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> ff:1e.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1e.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1e.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1e.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1e.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> ff:1f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)
> ff:1f.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)
> 


