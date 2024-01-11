Return-Path: <linux-pci+bounces-2070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430CA82B642
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 21:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B5A1C2392A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9285810E;
	Thu, 11 Jan 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbOyGKW4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B75810C;
	Thu, 11 Jan 2024 20:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67F0C433F1;
	Thu, 11 Jan 2024 20:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705006446;
	bh=sGQ9xfiElfr9WLheKjuIG2GD8xXWVTgndIz/Kd416kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rbOyGKW4GKfzwEw0tgladwm0RofFYMRRw2Lz2zC+oFm7bWJNMEnS2rDxKQmvCq8St
	 C46r5FeXMDC8hBjxSKDj8CIUvy/RFEj/9je7fQXUsuthVYPXfB5F474JCef8oie6m8
	 Vj7RwRblFN/p13pm2zwoV/RW54vctr7ehpVoW/T2QO36EE84SpHfFBOK/IHgsvDq5Q
	 FwP3VcnnJqiG7mPHkPoTLDD22n1epiRAW2zjA/CgdborC7VDTJwYKljHADeCEiAuRs
	 TC3BfxW6N/t3bRR87Z/2mhJYQjD7eEQ83ri01IetanUauRi/ZmxGW1OFIhvrOPXhn4
	 s8ddRKzTHeagw==
Date: Thu, 11 Jan 2024 14:54:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
Message-ID: <20240111205404.GA2190297@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNy03Bz1-Wftf4PpuVFF0FS01d2Yo6coG+gHqwwwpRdFMw@mail.gmail.com>

On Thu, Jan 11, 2024 at 01:20:48PM -0500, Jim Quinlan wrote:
> On Thu, Jan 11, 2024 at 12:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 13, 2023 at 01:56:06PM -0500, Jim Quinlan wrote:

> > > Previously, this driver always set the mode to "no-l1ss", as almost all
> > > STB/CM boards operate in this mode.  But now there is interest in
> > > activating L1SS power savings from STB/CM customers, which requires "aspm"
> > > mode.
> >
> > I think this should read "default" mode, not "aspm" mode, since "aspm"
> > is not a mode implemented by this patch, right?
> 
> Correct.

Thanks, I changed that locally.

> > > In addition, a bug was filed for RPi4 CM platform because most
> > > devices did not work in "no-l1ss" mode.
> >
> > I think this refers to bug 217276, mentioned below?
> 
> I guess you are saying I should put a footnote marker there.

I added a hint here.

> > > Note: Since L1 substates are now possible, a modification was made
> > > regarding an internal bus timeout: During long periods of the PCIe RC HW
> > > being in an L1SS sleep state, there may be a timeout on an internal bus
> > > access, even though there may not be any PCIe access involved.  Such a
> > > timeout will cause a subsequent CPU abort.
> >
> > This sounds scary.  If a NIC is put in L1.2, does this mean will we
> > see this CPU abort if there's no traffic for a long time?  What is
> > needed to avoid the CPU abort?
> 
> I don't think this happens in normal practice as there are a slew
> of low-level TLPs and LTR messages that are sent on a regular
> basis.

OK, I'll have to take your word for this.  I don't know enough about
PCIe to know what sort of periodic transmissions are required when a
device is idle.

LTR messages are required when endpoint service requirements change,
but I wouldn't expect those if the device is idle.

> The only time this timeout occured is when  a major customer
> was doing a hack: IIRC, their endpoint device has to reboot itself
> after link-up and driver probe,  so it goes into L1.2 to execute
> this to reboot and while doing so the connection is completely
> silent.

> > What does this mean for users?  L1SS is designed for long periods of
> > the device being idle, so this leaves me feeling that using L1SS is
> > unsafe in general.  Hopefully this impression is unwarranted, and all
> > we need is some clarification here.
> 
> I don't think it will affect most users, if any.

I'll try to get this into -next today or tomorrow.

Bjorn

