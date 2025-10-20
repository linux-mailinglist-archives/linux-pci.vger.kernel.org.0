Return-Path: <linux-pci+bounces-38824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FBDBF4045
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 01:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E63448566B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 23:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CFB2F90E9;
	Mon, 20 Oct 2025 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyJGrgUA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A22BE636;
	Mon, 20 Oct 2025 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002714; cv=none; b=I/DzczGMUfZMhZtXAf2/94IaVSGMEXsKDC5Vymo/EO65GyccqcaYsVoPR7/PSvWBCHEaGrfZAfF2c4TX/6GHy141iTNHfxWrgTDvgOYdQVrWBjWQS8VVQynicw/BL+rcuO1A+OH6qQkxQ6ScuXMhmbomiBaderz1szNbRnogR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002714; c=relaxed/simple;
	bh=E+52/7en/d5Toakw/wtgcZpoYienlVtWpUdghbjPqGI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TZaW1wVAI1VuL3oie8rUwQHHJ9BHXemQIKTmu/hswxJlBhzL0okxFgDdX1YJ7MMWj3GulwzyQDAvL22Prr2yQtriwUnP8e/2VDSJZhg2jGgIe2pjz3HXWMcyeBtN3Hz61D9gYrR3BsG5A6zyQ+ExeBkMDv1UU5CcSw6uBsRYZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyJGrgUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB21C4CEFB;
	Mon, 20 Oct 2025 23:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761002712;
	bh=E+52/7en/d5Toakw/wtgcZpoYienlVtWpUdghbjPqGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AyJGrgUAvA2nZnflPbH0xMWFDN4afhdmo+PeoFehmeB3XsX71EbhjZyG4vjzCI62w
	 GuDfI5THZfrirWvofQgim4v5sba+JkABWAsE0aPNXXNvnWP66csBJFsOJleyElCwKh
	 1FuSEVz9IrYDmjk/2622EYglArkurLnVqXr16M5pddqBzSZW9QLGXFS6W16I3pyuvZ
	 LOeeL4BPIxN/1rz1BzcOAbCQaOXYhgkKJmKnS0YyZZHIrjMjVu5+0VWfdhlxpFpX/4
	 YXbN5fKKUiFXZ+HEpTkZL8XeZQCkVMTHr2+YYuLeglLyOlcCkYL/5ccM/p9e8CHHb2
	 VA0MIqOSz/HvQ==
Date: Mon, 20 Oct 2025 18:25:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: =?utf-8?Q?Adri=C3=A0_Vilanova_Mart=C3=ADnez?= <me@avm99963.com>,
	Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <20251020232510.GA1167305@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>

[+cc Lukas, beginning of thread with complete dmesg log:
https://lore.kernel.org/r/owewi3sswao4jt5qn3ntm533lvxe3jlovhjbdufq3uedbuztxt@76nft22vboxv]

On Mon, Oct 20, 2025 at 11:37:43AM -0500, Mario Limonciello (AMD) (kernel.org) wrote:
> On 10/20/2025 7:56 AM, Adrià Vilanova Martínez wrote:
> > On Sun, Oct 19, 2025 at 07:25:08PM -0500, Mario Limonciello wrote:
> > > Thanks, knowing that pcie_aspm=off helps I think we should compare output
> > > for:
> > > 
> > > # sudo lspci -vvnn
> > 
> > Sure, I'm attaching the outputs of this command for all the scenarios.
> > There are some differences, so it seems promising.
> 
> Surprisingly there is nothing different about ASPM though.  It's all PCI-PM
> differences.
> 
> Looking at your log again I noticed this from the bridge:
> 
> pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
> pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
> pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
> ...
> pcieport 0000:00:1c.0: pciehp: Slot(0): No device found
> ...
> (suspend)
> ...
> pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
> pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up

This seems wrong.  The PCI core definitely enumerated the wifi device,
but it seems like there's some pciehp confusion about presence/link
up/etc, and we couldn't actually use it until after the
suspend/resume:

  [    0.113379] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
  [    0.113403] pci 0000:00:1c.0: PCI bridge to [bus 01]
  [    0.113409] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x910fffff]
  [    0.115692] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
  [    0.115830] pci 0000:01:00.0: BAR 0 [mem 0x91000000-0x91001fff 64bit]
  [    0.196539] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
  [    0.196802] pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
  [    0.196925] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
  [    0.196927] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
  [    1.400127] pcieport 0000:00:1c.0: pciehp: Slot(0): No device found
  [   50.295404] ACPI: PM: Preparing to enter system sleep state S3

  [   50.314754] ACPI: PM: Waking up from system sleep state S3
  [   50.328910] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
  [   50.328914] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
  [   50.454011] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
  [   50.454135] pci 0000:01:00.0: BAR 0 [mem 0x91000000-0x91001fff 64bit]
  [   50.833621] iwlwifi 0000:01:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
  [   50.833632] iwlwifi 0000:01:00.0: PCI dev 095a/9e10, rev=0x210, rfid=0xd55555d5
  [   50.833636] iwlwifi 0000:01:00.0: Detected Intel(R) Dual Band Wireless-AC 7265

I don't have any good ideas.

Bjorn

