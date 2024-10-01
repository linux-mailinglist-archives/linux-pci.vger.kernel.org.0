Return-Path: <linux-pci+bounces-13695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EBA98C53B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 20:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA6C1F242C9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8F1CC155;
	Tue,  1 Oct 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3xgr0CY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14915E97
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806797; cv=none; b=U0DSgCE/diPvDFej7fBKWQ5517LarnFKf9m7X8j6CHaoWWwixogGtPTPdd6wO7UtLnKtWl4o+PuTtl8G9iKs9w4//IVOww6TcROKamjT1Ri1l/zp/iOe4n4DrGmXIo82lUYVXUaBe1RckoK/mdczlx0gfOuetmCFWw1fh3XumXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806797; c=relaxed/simple;
	bh=+bvhVSDWKQNeFNpy++B5FBSa4AoHfWqoHDc21X43B6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKApdwu84n/THlTw0obD+L2mCcpSUhfy2sQTQ9jLeBZHBQkl2/XqsIYHAQEQW/cVr7gkMwRhfERitP+/T6x2UpTskAXrgR5jt1hSLWRRows9rYFHKgFkS8sb3k2a61XsyntxjhIQRcXA13Ce7JOA6RXiNC+UCefz9SrTmyUkiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3xgr0CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866C3C4CEC6;
	Tue,  1 Oct 2024 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727806796;
	bh=+bvhVSDWKQNeFNpy++B5FBSa4AoHfWqoHDc21X43B6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3xgr0CYiHejOwxrzJ4aTxmw4jmTKp9/jcGbZM+MIWKcnapx2ipZrES/0CqWosjrR
	 EH+5Smwh/ghPWjmRJ79PDHj37QQtA8A2wL1opbyd7RiM8KNdQXONfHsENkthjzlMLB
	 OS0cogPMQXfkITBjOhNiTgJXDQnEra6VjCbHXhVJJO+xPCDPtEETGLp7QoW9XRLMGC
	 hdM0qjHNBtiPBKvvmkMksZO+l1ABHWim7yO5KML3K0DjbEka3rwT3TKi5lkbbog0Oj
	 Xz7/gzcmCiFg6tLdFmPVAnuY2jO68YlOAkitLjngHknLRLZrGc+SzmCAWqqoX9C6aI
	 OSaauKQWRaAoA==
Date: Tue, 1 Oct 2024 12:19:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maverickk 78 <maverickk1778@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: pcie hotplug driver probe is not getting called
Message-ID: <Zvw9SnYICUvbDhuZ@kbusch-mbp.mynextlight.net>
References: <CALfBBTsmKYf5FT-pxLfM-C1EgdrKKhQU43OhMDBz2ZPtKcxaLQ@mail.gmail.com>
 <20240930192834.GA187120@bhelgaas>
 <CALfBBTv3_4_x3aXfoDgQ93LCAbfC-2djnfwbHS+hqmOff8+8+g@mail.gmail.com>
 <CALfBBTtdtzL4TatBOOzc=c+k9YdNDPd=UPppbo5U5fuK+YscvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALfBBTtdtzL4TatBOOzc=c+k9YdNDPd=UPppbo5U5fuK+YscvQ@mail.gmail.com>

On Tue, Oct 01, 2024 at 11:39:33PM +0530, Maverickk 78 wrote:
> I was able to trigger an interrupt, the pciehp_isr was triggered and
> there are "Timeouts" while processing the hotplug,
> I suspect this is due to the slowness of the simulation platform, is
> my assumption correct?

That usually means the slot does not generate software notification, but
for whatever reason decided not set the "No Command Completed Support"
in the slot capability structure.

> [26599.580420] pcieport 0000:02:01.0: pciehp: pending interrupts 0x0001 from Slot Status
> [26599.580575] pcieport 0000:02:01.0: pciehp: Slot(0): Button press: will power on in 5 sec
> [26599.593768] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x17e1 (issued 42213 msec ago)
> [26599.598920] pcieport 0000:02:01.0: pciehp: pciehp_set_indicators: SLOTCTRL 80 write cmd 2c0
> [26605.104802] pcieport 0000:02:01.0: pciehp: pciehp_check_link_active: lnk_status = 2025
> [26605.104840] pcieport 0000:02:01.0: pciehp: Slot(0): Link Up
> [26605.109616] pcieport 0000:02:01.0: pciehp: pciehp_get_power_status: SLOTCTRL 80 value read 16e1
> [26605.126589] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x16e1 (issued 5528 msec ago)
> [26606.458516] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x12e1 (issued 1327 msec ago)
> [26606.458554] pcieport 0000:02:01.0: pciehp: pciehp_power_on_slot: SLOTCTRL 80 write cmd 0
> [26606.475509] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x12e1 (issued 1344 msec ago)
> [26606.481024] pcieport 0000:02:01.0: pciehp: pciehp_set_indicators: SLOTCTRL 80 write cmd 200
> [26606.618088] pcieport 0000:02:01.0: pciehp: pciehp_check_link_status: lnk_status = 2025
> [26606.674790] pci 0000:03:00.0: [abcd:0000] type 00 class 0x000000 PCIe Endpoint
> [26606.725288] pci 0000:03:00.0: BAR 0 [mem 0xf8000000-0xf9ffffff]
> [26607.867503] pci 0000:03:00.0: 63.014 Gb/s available PCIe bandwidth, limited by 32.0 GT/s PCIe x2 link at 0000:02:01.0 (capable of 1024.000 Gb/s with 64.0 GT/s PCIe x16 link)
> [26608.386085] pci 0000:03:00.0: vgaarb: pci_notify
> [26608.491596] pcieport 0000:02:01.0: distributing available resources
> [26608.491637] pcieport 0000:02:01.0: PCI bridge to [bus 03]
> [26608.495947] pcieport 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
> [26608.513041] pcieport 0000:02:01.0:   bridge window [mem 0xf8000000-0xf9ffffff]
> [26608.521771] pcieport 0000:02:01.0:   bridge window [mem 0xfe200000-0xfe3fffff 64bit pref]
> [26608.647492] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x12e1 (issued 2167 msec ago)
> [26608.652270] pcieport 0000:02:01.0: pciehp: pciehp_set_indicators: SLOTCTRL 80 write cmd 1c0

