Return-Path: <linux-pci+bounces-586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2F8074F9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2481D1F21267
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577AA3EA6D;
	Wed,  6 Dec 2023 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Okyf9gZw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927C46547
	for <linux-pci@vger.kernel.org>; Wed,  6 Dec 2023 16:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8949FC433C8;
	Wed,  6 Dec 2023 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701880228;
	bh=54nqvAC06q7MZop7IUNr1tWlx3uaNvOvbO3JbUJUtMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Okyf9gZwGyOJHJIZHahbqv2GEc/XS6v9NzPgJ7+FGYnf4Rv40P42iiKoPA40Imgoj
	 sW1qyfqiPeJpQbLUx4nX4KPK5UkKZefKrN68bOYoHTfu/w20FC/yONuGYdZ+AkVD9i
	 YD8aKwE268WZwFy7RnNKMXw8th9gfvAOcyzrgFY/MMJKoFCaC9LqksUSx13xeE/3Bf
	 tyGhFcwh/VYVODiXyFUkz5lyH7TUROPjtbkXFtIlCZyHgrxvti8i1oetE4FOIo+qX+
	 sGuqgSxmLL9/0dQgoEHVRkxvFuG5VCZe69RT7Dy4G6DJE4czyY0kbnYQq1pkgjU7dQ
	 tIyaN8ZS3/i+Q==
Date: Wed, 6 Dec 2023 10:30:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, linux-pci@vger.kernel.org,
	orden.e.smith@intel.com, samruddh.dhope@intel.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Grant Grundler <grundler@chromium.org>,
	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
	Rajat Jain <rajatja@chromium.org>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20231206163026.GA716688@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p5+x44XLLXYDKceZrgO0z-bCbFPqwR1Qw6Esjv+dUjh2w@mail.gmail.com>

[+cc Grant, Rajat, Rajat]

On Wed, Dec 06, 2023 at 10:18:56AM +0800, Kai-Heng Feng wrote:
> On Wed, Nov 15, 2023 at 5:00 AM Nirmal Patel <nirmal.patel@linux.intel.com> wrote:
> > On Wed, 2023-11-08 at 16:49 +0200, Kai-Heng Feng wrote:
> > > On Wed, Nov 8, 2023 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> ...

> > > > I assume you mean to revert 04b12ef163d1 ("PCI: vmd: Honor
> > > > ACPI _OSC on PCIe features").  That appeared in v5.17, and it
> > > > fixed (or at least prevented) an AER message flood.  We can't
> > > > simply revert 04b12ef163d1 unless we first prevent that AER
> > > > message flood in another way.
> > >
> > > The error is "correctable".  Does masking all correctable AER
> > > error by default make any sense? And add a sysfs knob to make it
> > > optional.
> >
> > I assume sysfs knob requires driver reload. right? Can you send a
> > patch?
> 
> What I mean is to mask Correctable Errors by default on *all*
> rootports, and create a new sysfs knob to let user decide if
> Correctable Errors should be unmasked.

I don't think we should mask Correctable Errors by default.  Even
though they've been corrected by hardware and no software action is
required, I think these errors are valuable signals about Link
integrity.

I think rate-limiting and/or reporting on the *frequency* of
Correctable Errors would make a lot of sense.  We had some work toward
this recently, but it hasn't quite gotten finished yet.

The most recent work I'm aware of is this:
https://lore.kernel.org/r/20230606035442.2886343-1-grundler@chromium.org

Bjorn

