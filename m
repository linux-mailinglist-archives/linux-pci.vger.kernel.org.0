Return-Path: <linux-pci+bounces-6583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E478AEB4B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FDE1C21BEA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2F13BAFE;
	Tue, 23 Apr 2024 15:41:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF413BACF
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886878; cv=none; b=N0+4CclfZr3t69JiW3l4WH4f7d+fSgHIgvF6rv9okbovTa4qu8Ht5fdwMNXa03hOWcavTwS95TjCiherVYDpLTGkV/DT5gveF/DibDjbbAaBFOXc01pbPFyHTLqbPdDj3ej7sWiUXrDNBnLV4C8yaqeq2HFfodtZMihDF1rUABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886878; c=relaxed/simple;
	bh=uoGspbq94loW2asPzj0yT6cjfVSQmiJ7oJmjAntAZ7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q22NqTsxBovc9uAVOtTc+o2RFYaBVEX6Oyyu+xI03URT+9TXr0iV2/DrilJnTByQacvoSizj4yas4vYUsp+pBpowFH0lw5Lw9rhAVC4yFTqvbfehiRurUF6bUsbC5zJKeXNjmxiK0WztTdNkHBcWo1Tnecd4XZCoPcPJLHXGNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6344F61E5FE06;
	Tue, 23 Apr 2024 17:40:56 +0200 (CEST)
Message-ID: <884be16f-1f01-4002-a825-797e6c68e95e@molgen.mpg.de>
Date: Tue, 23 Apr 2024 17:40:55 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 218765] New: broken device,
 retraining non-functional downstream link at 2.5GT/s]
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-pci@vger.kernel.org
References: <20240423152330.GA441398@bhelgaas>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240423152330.GA441398@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Bjorn,


Thank you for your instant reply.

Am 23.04.24 um 17:23 schrieb Bjorn Helgaas:
> FYI.  The retraining was added by a89c82249c37 ("PCI: Work around PCIe
> link training failures").
> 
> Paul, is this a regression?  a89c82249c37 appeared in v6.5.  I
> *assume* whatever is below bus 01 did actually work before v6.5, in
> spite of the fact that apparently PCI_EXP_LNKSTA_DLLLA was not set
> when we enumerated the 00:1c.0 Root Port?

Only used 6.5 and onward on the Dell XPS 9360, so I cannot say if it 
worked before. I have to find time to boot an old Linux kernel image. 
(I’d like to emphasize again, that this only happens having USB-C 
adapter connected during system firmware phase, and disconnecting it 
before Linux boots – for example, when in GRUB.)


Kind regards,

Paul


> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=218765
> 
> Created attachment 306199
>    --> https://bugzilla.kernel.org/attachment.cgi?id=306199&action=edit
> Linux 6.9-rc5+ messages (output of `dmesg`)
> 
> I noticed a one second delay with Linux 6.9-rc5+:
> 
> ```
> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> […]
> [    0.201109] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
> [    0.201109] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
> [    0.201109] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [    0.201109] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    0.201109] pci 0000:00:1c.0: broken device, retraining non-functional downstream link at 2.5GT/s
> [    1.209109] pci 0000:00:1c.0: retraining failed
> [    1.209143] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    1.209677] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400 PCIe Root Port
> [    1.209700] pci 0000:00:1c.4: PCI bridge to [bus 3a]
> [    1.209705] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
> [    1.209771] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> […]
> ```
> 
> Looking through all the logs since March 2024, I only found *one* other
> occurrence with Linux 6.9-rc4+.
> 
> ```
> $ lspci -tvnn
> -[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:5904]
>             +-02.0  Intel Corporation HD Graphics 620 [8086:5916]
>             +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903]
>             +-14.0  Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller [8086:9d2f]
>             +-14.2  Intel Corporation Sunrise Point-LP Thermal subsystem [8086:9d31]
>             +-15.0  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 [8086:9d60]
>             +-15.1  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61]
>             +-16.0  Intel Corporation Sunrise Point-LP CSME HECI #1 [8086:9d3a]
>             +-1c.0-[01-39]----00.0-[02-39]--+-00.0-[03]--
>             |                               +-01.0-[04-38]--
>             |                               \-02.0-[39]----00.0  Intel Corporation DSL6340 USB 3.1 Controller [Alpine Ridge] [8086:15b5]
>             +-1c.4-[3a]----00.0  Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter [168c:003e]
>             +-1d.0-[3b]----00.0  SK hynix PC300 NVMe Solid State Drive 512GB [1c5c:1284]
>             +-1f.0  Intel Corporation Sunrise Point-LP LPC Controller [8086:9d58]
>             +-1f.2  Intel Corporation Sunrise Point-LP PMC [8086:9d21]
>             +-1f.3  Intel Corporation Sunrise Point-LP HD Audio [8086:9d71]
>             \-1f.4  Intel Corporation Sunrise Point-LP SMBus [8086:9d23]
> ```
> 
> The adapter wasn’t plugged in, when Linux started.
> 
> It could be related to unplugging an Dell DA300 USB Type-C adapter during
> system firmware (UEFI) to avoid a five second delay in Linux (ACPI). I need to
> test that later, but maybe you already have an idea.
> 
> ----- End forwarded message -----

