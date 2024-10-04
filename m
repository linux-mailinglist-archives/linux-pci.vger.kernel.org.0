Return-Path: <linux-pci+bounces-13871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D819911E9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 23:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1871B1C2195B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046A014659F;
	Fri,  4 Oct 2024 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtZbb+fh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326A1339B1
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079020; cv=none; b=s8da6TZIZ1kGJvX5VZTwAQAdkaeC/XnumzkGDZqsPxvBNEKePpH8HbPqr1qchGYM1meN+Pknxyp15ZoBQ3F4E4zaXF09Wp3zQoddj2QXWqxYCz+PSs7Ku0ikUgMO/CukUz6WeUKJkLqVXXDoBGEGL4c9/EDDrOD+7c3nmakpeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079020; c=relaxed/simple;
	bh=FeN5PwyXsuoJxcSmW0Dn3v+IkGSYr4jiJL9DqPwwujg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NFxGjwNtaP/U5cx8bLHmPPYK0RnBo7h3B630b9CAxN15pGFxui92jUvR8gT+EhhfvJ288ireYvAIlLb+cRJZFgtYnRAjWMp75jZRFSFHI58oMKQxVsj5d9cmY8bILCHo5SDKm2c4OSepaHOpdh+fPBld6oYR5nWqjnU36fZOul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtZbb+fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAFEC4CEC6;
	Fri,  4 Oct 2024 21:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728079020;
	bh=FeN5PwyXsuoJxcSmW0Dn3v+IkGSYr4jiJL9DqPwwujg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PtZbb+fhBtB/r6lgycHLB+SQzfbqVtIfHpgpIL9CAwR3tP/BMhPpUbnfm77aem6Qi
	 bcIUhZZSxkiBTiJ2b3RbU7g65yBklD0PfuR+DtWu8f4Ew2jgew6afjIASsa6JYtKw0
	 GQaPLD3Ukxipsr68XBWkyNG5BDZllKXztGP+w2zY6hhwMMg9n0Ly1tO7bGz5ZelmFc
	 yYIOg1RtmHG6fuboHL+FcLoW63392BlpoxYFo+2XZ7zoSEH/Isq2yw5YJiSKfdKfAa
	 BH6CgPju4RY5BkjvKl8P5o01fz9v6d3ReHrehJ5j/R4iJbHgtHX1+/MV82s3RjQI2A
	 X3WcZr9U532/g==
Date: Fri, 4 Oct 2024 16:56:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Maverickk 78 <maverickk1778@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: pcie hotplug driver probe is not getting called
Message-ID: <20241004215657.GA362992@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALfBBTuhUcdBAQgKFhGP+9gMqEthA_dOE6V3RGn6HTZm7nNBYg@mail.gmail.com>

On Fri, Oct 04, 2024 at 11:50:28PM +0530, Maverickk 78 wrote:
> The platform I am working on is rtl simulation of pcie switch(Gen6)
> with a backdoor mechanism to trigger the HotPlug event.
> 
> Tried following patches independently to have both hotplug and dpc
> driver register and handle respective events.
> 
> https://patchwork.ozlabs.org/project/linux-pci/patch/20231223212235.34293-2-mattc@purestorage.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20240108194642.30460-1-mattc@purestorage.com/#25680870
> 
> Tried following
> 
> - Trigger hot removal and add, the event is triggered and respective
> msi in /proc/interrupt increments and kernel logs the event(dmesg)
> - Trigger hot removal and add, the event is triggered and respective
> msi in /proc/interrupt increments and kernel logs the event(dmesg)
> - Trigger DPC using "DPC software trigger" in DPC control register
> 
> The kernel hangs, the console is non-responsive.
> 
> Can dpc and pciehp co-exist and handle the events?

Yes, they're intended to coexist.  Your platform firmware doesn't
advertise support for it, though:

[    1.736168] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug LTR DPC]

I don't think there's a kernel parameter to force DPC usage if the
platform doesn't advertise it.  There should be a message like "DPC:
enabled with IRQ X" if the dpc driver is active.

Even if the dpc driver isn't active, I don't think the kernel should
hang if you trigger DPC.  Since this is a QEMU guest, you should be
able to use a debugger to figure out why it's hung.

Bjorn

