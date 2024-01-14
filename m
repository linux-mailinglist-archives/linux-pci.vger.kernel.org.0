Return-Path: <linux-pci+bounces-2138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8BD82D22F
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jan 2024 23:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0F81F2134C
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jan 2024 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D272225DF;
	Sun, 14 Jan 2024 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A63vyc27"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F1B225DA;
	Sun, 14 Jan 2024 22:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F25C433C7;
	Sun, 14 Jan 2024 22:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705271494;
	bh=hTSJz+G1XtA211Jnofo+R0wXKdoqASJ5wAO62Dsi5rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A63vyc27CxJ8dp+AB136BZws1uryqgpyFCTJppv+P8VK+O12e+Dg65spsr7pL41Y1
	 SKPJj1DtPIAOLL9faVAoHLDtSfltplwBno7rf3HNZRzxce7XLKB/upTc52obb3lM5M
	 UAdzso+ojZAO9RDpWOi33NrpTaDYfNo9VfTuQ449qM9ZK1eJ5mK6NrWAeShtBjLjtz
	 Ui/9IUxK4V/As2GK/x9oIpm5vQwJ2m0cn3GH+fKDxEF9sF8Qx0BLQQ4m3RLTkZCJyX
	 Dxj3slSrVAYsVErwwRmkg0KsqwYTMT3Zp1KKgrXY6JpPrLbZ9VdAfy23s+2QHFvBPK
	 G77FMQMQGWm5w==
Date: Sun, 14 Jan 2024 16:31:32 -0600
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
Message-ID: <20240114223132.GA2358466@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNyLZV42KqeBwYEE-sxhbE3bbwwbSVii3fY4nmrd0W_LkA@mail.gmail.com>

On Sun, Jan 14, 2024 at 05:03:43PM -0500, Jim Quinlan wrote:
> On Thu, Jan 11, 2024 at 3:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jan 11, 2024 at 01:20:48PM -0500, Jim Quinlan wrote:
> > > On Thu, Jan 11, 2024 at 12:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Mon, Nov 13, 2023 at 01:56:06PM -0500, Jim Quinlan wrote:
> ...

> > > > > Note: Since L1 substates are now possible, a modification was made
> > > > > regarding an internal bus timeout: During long periods of the PCIe RC HW
> > > > > being in an L1SS sleep state, there may be a timeout on an internal bus
> > > > > access, even though there may not be any PCIe access involved.  Such a
> > > > > timeout will cause a subsequent CPU abort.
> > > >
> > > > This sounds scary.  If a NIC is put in L1.2, does this mean will we
> > > > see this CPU abort if there's no traffic for a long time?  What is
> > > > needed to avoid the CPU abort?
> > >
> > > I don't think this happens in normal practice as there are a slew
> > > of low-level TLPs and LTR messages that are sent on a regular
> > > basis.
> >
> > OK, I'll have to take your word for this.  I don't know enough about
> > PCIe to know what sort of periodic transmissions are required when a
> > device is idle.
> >
> > LTR messages are required when endpoint service requirements change,
> > but I wouldn't expect those if the device is idle.
> >
> > > The only time this timeout occured is when  a major customer
> > > was doing a hack: IIRC, their endpoint device has to reboot itself
> > > after link-up and driver probe,  so it goes into L1.2 to execute
> > > this to reboot and while doing so the connection is completely
> > > silent.
> >
> > > > What does this mean for users?  L1SS is designed for long periods of
> > > > the device being idle, so this leaves me feeling that using L1SS is
> > > > unsafe in general.  Hopefully this impression is unwarranted, and all
> > > > we need is some clarification here.
> > >
> > > I don't think it will affect most users, if any.
> >
> > I'll try to get this into -next today or tomorrow.
> 
> Bjorn, you are right -- I need to cajole our PCIe HW team to tell me
> why this timeout can never
> happen and/or why it is not a bug.

It'll be good to hear what they have to say.  I will include this
patch in my pull request for v6.8 unless you want me to wait on it.
I hope to send the pull request tomorrow or Tuesday at the latest.

Bjorn

