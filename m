Return-Path: <linux-pci+bounces-6580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E08AEAF0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5221C2093A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E655820E;
	Tue, 23 Apr 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8+qDRc7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1C19BBA
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885812; cv=none; b=dF8jm28+A9NvqiyMBcuumUtzU1GI+Y/5z+wbYsBH3TDI1T9exRP9e2VXs6QDuAaDse40VQggsClHXp2fhWQOdhhW4Xnj+w+4jVl22EJsFYXPNoJZ4HjfE0itTGQI8QWeqGokNBxoreBnutl4LAWfVgBz+hl1o5jyUUkwSZ1eYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885812; c=relaxed/simple;
	bh=obaC39F9UHO7hU2Ebd6J6YqbN3lCXwS4Fg9DZTsuaxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XytNdKlyim0HEhtrlRaei2uxanbyeBKFahsTRblG3dS5+CkkWNed/wO4h0kV34t8N4KSamTl+5t+iRfTwP54joChTufVOo5J201zi3Ske3q6l9tw9alWYggmWA1XMBtPJ5xIH/7NPSXAQ1kyQF0ZJSGjVopIgAOfoOyPPBfQz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8+qDRc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1B4C116B1;
	Tue, 23 Apr 2024 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885812;
	bh=obaC39F9UHO7hU2Ebd6J6YqbN3lCXwS4Fg9DZTsuaxA=;
	h=Date:From:To:Cc:Subject:From;
	b=h8+qDRc7/yhsHmbS9FA5eGzBwogm4QYG/FNB8+/WXVNefNdzxqiSNrYeWw+b/XbkC
	 DvQaSIk0JvXloNRQcu11Lm9SRMy/pgq2c2ZASq0P870+HZ2Dh2iwzCn5vIEfolkGKA
	 dD2tUBprat31XhWOAnQJzg4OgFwUhHqMEmBVE8JTq0PzUs2p+8fT8mBFbVUYVHfLVe
	 fTrPwKskQ318Mbh52PStyQ6ZurBJcK712TcEiMPE2T2FTaOMoJrl0vMLFclT2CfhXj
	 hve9OxLrOg+laVB7He9TnX77UcmHkCtydC7vR19tDpFOYp070oEfO1T3KoJtTzWsaT
	 viAtlV4ntMjWw==
Date: Tue, 23 Apr 2024 10:23:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-pci@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 218765] New: broken device,
 retraining non-functional downstream link at 2.5GT/s]
Message-ID: <20240423152330.GA441398@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

FYI.  The retraining was added by a89c82249c37 ("PCI: Work around PCIe
link training failures").

Paul, is this a regression?  a89c82249c37 appeared in v6.5.  I
*assume* whatever is below bus 01 did actually work before v6.5, in
spite of the fact that apparently PCI_EXP_LNKSTA_DLLLA was not set 
when we enumerated the 00:1c.0 Root Port?

----- Forwarded message from bugzilla-daemon@kernel.org -----

https://bugzilla.kernel.org/show_bug.cgi?id=218765

Created attachment 306199
  --> https://bugzilla.kernel.org/attachment.cgi?id=306199&action=edit
Linux 6.9-rc5+ messages (output of `dmesg`)

I noticed a one second delay with Linux 6.9-rc5+:

```
[    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
[…]
[    0.201109] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root
Port
[    0.201109] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[    0.201109] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
[    0.201109] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff
64bit pref]
[    0.201109] pci 0000:00:1c.0: broken device, retraining non-functional
downstream link at 2.5GT/s
[    1.209109] pci 0000:00:1c.0: retraining failed
[    1.209143] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.209677] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400 PCIe Root
Port
[    1.209700] pci 0000:00:1c.4: PCI bridge to [bus 3a]
[    1.209705] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
[    1.209771] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[…]
```

Looking through all the logs since March 2024, I only found *one* other
occurrence with Linux 6.9-rc4+.

```
$ lspci -tvnn
-[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor
Host Bridge/DRAM Registers [8086:5904]
           +-02.0  Intel Corporation HD Graphics 620 [8086:5916]
           +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core
Processor Thermal Subsystem [8086:1903]
           +-14.0  Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller
[8086:9d2f]
           +-14.2  Intel Corporation Sunrise Point-LP Thermal subsystem
[8086:9d31]
           +-15.0  Intel Corporation Sunrise Point-LP Serial IO I2C Controller
#0 [8086:9d60]
           +-15.1  Intel Corporation Sunrise Point-LP Serial IO I2C Controller
#1 [8086:9d61]
           +-16.0  Intel Corporation Sunrise Point-LP CSME HECI #1 [8086:9d3a]
           +-1c.0-[01-39]----00.0-[02-39]--+-00.0-[03]--
           |                               +-01.0-[04-38]--
           |                               \-02.0-[39]----00.0  Intel
Corporation DSL6340 USB 3.1 Controller [Alpine Ridge] [8086:15b5]
           +-1c.4-[3a]----00.0  Qualcomm Atheros QCA6174 802.11ac Wireless
Network Adapter [168c:003e]
           +-1d.0-[3b]----00.0  SK hynix PC300 NVMe Solid State Drive 512GB
[1c5c:1284]
           +-1f.0  Intel Corporation Sunrise Point-LP LPC Controller
[8086:9d58]
           +-1f.2  Intel Corporation Sunrise Point-LP PMC [8086:9d21]
           +-1f.3  Intel Corporation Sunrise Point-LP HD Audio [8086:9d71]
           \-1f.4  Intel Corporation Sunrise Point-LP SMBus [8086:9d23]
```

The adapter wasn’t plugged in, when Linux started.

It could be related to unplugging an Dell DA300 USB Type-C adapter during
system firmware (UEFI) to avoid a five second delay in Linux (ACPI). I need to
test that later, but maybe you already have an idea.

----- End forwarded message -----

