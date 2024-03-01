Return-Path: <linux-pci+bounces-4352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB37886EB6A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 22:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3F21C214E7
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D9958AB2;
	Fri,  1 Mar 2024 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpcZkPhC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5B3FE0;
	Fri,  1 Mar 2024 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329910; cv=none; b=NNCnjTLsdlEF0CRf0Rn7+6nGY/7rFp4BJPoza3DxodjFvCJwITJX2YQHMuaygHlukB4uT+D0xPxGp7yvdFBIhrdNMf4OpZUyYjGP+CunCLzUEm2tl/Tfs5pcJOE7BfasbmbHaWDr5sHroeHEuj61V30ANb4YJcpRPqLCfRJh/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329910; c=relaxed/simple;
	bh=IueVPBeP1TnMrc4rxWgtET8MjwCyLuhSfCa0rJmhkSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zl+Dq5zVLHh0XTziN2DTdtWlEf7CgeJtf/yV11Ad/ygdKATXaW+jfOHgHfcwdR1tDii9qdqp9XGB5erS5GpmXFhBWCoMmfFNW9oFc6yKXkTauKaBtLx9b27SX1kNb8HiZBmvxeXhZLDpQxefzqS4o6DWVbdmVDUnDOGcTsE9Xh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpcZkPhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E4BC433F1;
	Fri,  1 Mar 2024 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709329909;
	bh=IueVPBeP1TnMrc4rxWgtET8MjwCyLuhSfCa0rJmhkSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UpcZkPhCQzpCOzRujQNpkoFvMCp/vXmEOuMXhP39z8GTJJxyyFthBIM0PDhrBXo0s
	 pu+65CHZnqXdTkj4kQ1VxeY1fLW5pOzxQKSr575R79rpNrgPSg0TqzWsfv/oV3rTIF
	 7JnzU0aG9xWz6D4pH/BtvLtv67a7bq0B4AXm9CyEwQdXl3XtgbHDo61RZM2Ya7+dHZ
	 o5y4NCdS5x33DBmUi3AHodxMBCBCragd6yx5c7UBGZcsxgvufS9rhGY47JRS8QBFzM
	 6JiL5j5pkhW57KrJ9ByTgQhko+AuRxhJU9AqjunfMJm7s/ajVvRyJwX5G/j4UHSuLA
	 sosPD4sESvv9w==
Date: Fri, 1 Mar 2024 15:51:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: Dell XPS 13 9360: Two PCI devices with disabled power management
 by default
Message-ID: <20240301215148.GA409221@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1861a8e-27a4-4493-9f4c-2a6cf3575c4b@molgen.mpg.de>

On Fri, Mar 01, 2024 at 12:32:12PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> I noticed on the Dell XPS 13 9360 some devices do not have power management
> enabled by default. From PowerTOP:
> 
>        Bad           Runtime PM for PCI Device Intel Corporation Sunrise
> Point-LP PCI Express Root Port #1
>        Bad          Runtime PM for PCI Device Intel Corporation Sunrise
> Point-LP LPC Controller

I don't know what this "Bad" is based on, so I don't know where to
look for something Linux might be doing.  I don't see any code that
mentions 9d10 or 9d58 Device IDs in relation to power.

> These are the two devices below:
> 
> 1.    00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
> Express Root Port #1 [8086:9d10] (rev f1)
> 2.    00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-LP LPC
> Controller [8086:9d58] (rev 21)
> 
>     $ sudo dmesg | grep -e 9d10 -e 9d58
>     [    0.200876] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe
> Root Port
>     [    0.202637] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
> conventional PCI endpoi
> 
> Is that a decision made by the system manufacturer or should the Linux
> kernel enable power management by default?

The complete dmesg log might have a clue.  I try to encourage quirks
to log a breadcrumb when they disable features to workaround a bug or
something.  But code like pci_bridge_d3_possible() is not structured
that way and doesn't leave clues like that.

But possibly the dmesg log and "sudo lspci -vv" output would enable us
to figure something out.

Bjorn

> $ lspci -tvnn
> -[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor
> Host Bridge/DRAM Registers [8086:5904]
>            +-02.0  Intel Corporation HD Graphics 620 [8086:5916]
>            +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core
> Processor Thermal Subsystem [8086:1903]
>            +-14.0  Intel Corporation Sunrise Point-LP USB 3.0 xHCI
> Controller [8086:9d2f]
>            +-14.2  Intel Corporation Sunrise Point-LP Thermal subsystem
> [8086:9d31]
>            +-15.0  Intel Corporation Sunrise Point-LP Serial IO I2C
> Controller #0 [8086:9d60]
>            +-15.1  Intel Corporation Sunrise Point-LP Serial IO I2C
> Controller #1 [8086:9d61]
>            +-16.0  Intel Corporation Sunrise Point-LP CSME HECI #1
> [8086:9d3a]
>            +-1c.0-[01-39]----00.0-[02-39]--+-00.0-[03]--
>            |                               +-01.0-[04-38]--
>            |                               \-02.0-[39]----00.0  Intel
> Corporation DSL6340 USB 3.1 Controller [Alpine Ridge] [8086:15b5]
>            +-1c.4-[3a]----00.0  Qualcomm Atheros QCA6174 802.11ac Wireless
> Network Adapter [168c:003e]
>            +-1d.0-[3b]----00.0  SK hynix PC300 NVMe Solid State Drive 512GB
> [1c5c:1284]
>            +-1f.0  Intel Corporation Sunrise Point-LP LPC Controller
> [8086:9d58]
>            +-1f.2  Intel Corporation Sunrise Point-LP PMC [8086:9d21]
>            +-1f.3  Intel Corporation Sunrise Point-LP HD Audio [8086:9d71]
>            \-1f.4  Intel Corporation Sunrise Point-LP SMBus [8086:9d23]
> $ lspci -nn
> 00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen Core
> Processor Host Bridge/DRAM Registers [8086:5904] (rev 02)
> 00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 620
> [8086:5916] (rev 02)
> 00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200
> v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 02)
> 00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP USB 3.0
> xHCI Controller [8086:9d2f] (rev 21)
> 00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise
> Point-LP Thermal subsystem [8086:9d31] (rev 21)
> 00:15.0 Signal processing controller [1180]: Intel Corporation Sunrise
> Point-LP Serial IO I2C Controller #0 [8086:9d60] (rev 21)
> 00:15.1 Signal processing controller [1180]: Intel Corporation Sunrise
> Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
> 00:16.0 Communication controller [0780]: Intel Corporation Sunrise Point-LP
> CSME HECI #1 [8086:9d3a] (rev 21)
> 00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI Express
> Root Port #1 [8086:9d10] (rev f1)
> 00:1c.4 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI Express
> Root Port #5 [8086:9d14] (rev f1)
> 00:1d.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI Express
> Root Port #9 [8086:9d18] (rev f1)
> 00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-LP LPC Controller
> [8086:9d58] (rev 21)
> 00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-LP PMC
> [8086:9d21] (rev 21)
> 00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD Audio
> [8086:9d71] (rev 21)
> 00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus [8086:9d23]
> (rev 21)
> 01:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 Bridge
> [Alpine Ridge 2C 2015] [8086:1576]
> 02:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 Bridge
> [Alpine Ridge 2C 2015] [8086:1576]
> 02:01.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 Bridge
> [Alpine Ridge 2C 2015] [8086:1576]
> 02:02.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 Bridge
> [Alpine Ridge 2C 2015] [8086:1576]
> 39:00.0 USB controller [0c03]: Intel Corporation DSL6340 USB 3.1 Controller
> [Alpine Ridge] [8086:15b5]
> 3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174 802.11ac
> Wireless Network Adapter [168c:003e] (rev 32)
> 3b:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe Solid
> State Drive 512GB [1c5c:1284]

