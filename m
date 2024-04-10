Return-Path: <linux-pci+bounces-6082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB888A0195
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2691C22CD5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5581181CEC;
	Wed, 10 Apr 2024 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRrjZkxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9C181BBC;
	Wed, 10 Apr 2024 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782763; cv=none; b=kBwfS/C8zmJumtCthnKBJHSIwm3+wtfR2HB0tvH54xd7VMJOlcc4SySHTUYE8aAVMNdbqyoUFRwDTdzOnjZlzRkZbsaA0prYnbnMY4ImdCicU43QzUjbTRs6jGMpl2E/LoTvBrxydtbCYCOxFlotD1eXvI2P0XJWoXF70OZqSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782763; c=relaxed/simple;
	bh=zGAh4ICKgST7UhxvjpeVE4w+WnC0LVCFrEni6OL7qNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CvNJ29JrN8l/W+y43T/P0n4qo7BIDHTzTDjqepaqa6ZsXv3BrlEHgWkPyzwvu4wN4cjdRV75TwDODltNZ7zB9ZWyqFgK/spf/kjc8cWsetrb8PDY95gtmLsjQKpMU6qEmqqWIWUU3V2cqxlh6c4lv8qcomzopFFIl9+gMfZBBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRrjZkxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0D2C433F1;
	Wed, 10 Apr 2024 20:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782763;
	bh=zGAh4ICKgST7UhxvjpeVE4w+WnC0LVCFrEni6OL7qNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RRrjZkxAzgBqCzAqbahkK2QhXFqCH5r83Fxt9TbKx8//6Qtfqln3qBWMyyUPRq0Sj
	 +e29zeARUs6Lqc9bcLAro54EJ4/2/E6ahXlsyk9h5qKTeHCz0qo4V5Abr7H8UcYYYp
	 v1QgQNd9W1ZaxOVzFzuw+bPIKW3NkCZTX9NtQocnhpsYR5kA3nQ/dmqPk2H/b8+0xN
	 9tXAjwjVPKuVMpRWYhjC0UkRcxXGTE0VxgL/szUoWMKc/4z0ZbMi5sihaMnfdcys/s
	 gLR4qlFHAFmJE59iyHPbm/xt8AzVuLV7gorDESfkYvsfsGil+/tLCzPUdeGWkKJpPF
	 tLg2WOtQvD3IA==
Date: Wed, 10 Apr 2024 15:59:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	gloriouseggroll@gmail.com, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
Message-ID: <20240410205921.GA2156865@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p6hH1=pchRidgMg2Go21tG=nJz+nz+6w++9hGSgFOcVgQ@mail.gmail.com>

On Wed, Apr 10, 2024 at 02:20:31PM +0800, Kai-Heng Feng wrote:
> On Sat, Mar 30, 2024 at 9:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Nov 01, 2023 at 06:45:41AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> > > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > > >
> > > > > On Kernel 6.4 rc1 and higher if you put the Steam Deck into
> > > > > suspend then press the power button again it will not wake up.
> > > > >
> > > > > I don't have a clue as to -why- this commit breaks wake from
> > > > > suspend on steam deck, but it does. Bisected to:
> > > > >
> > > > > ```
> > > > > 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> > > > > commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> > > > > Author: Bjorn Helgaas <bhelgaas@google.com>
> ...

> > silverspring attached lspci output and a dmesg log from v6.8 to the
> > bugzilla and also noted that "pci=noaer" works around the problem.
> >
> > The problem commit is 1ad11eafc63a ("nvme-pci: drop redundant
> > pci_enable_pcie_error_reporting()")
> > (https://git.kernel.org/linus/1ad11eafc63a)
> >
> > 1ad11eafc63a removed pci_disable_pcie_error_reporting() from the
> > nvme_suspend() path, so we now leave the PCIe Device Control error
> > enables set when we didn't before.  My theory is that the PCIe link
> > goes down during suspend, which causes an error interrupt, and the
> > interrupt causes a problem on Steam Deck.  Maybe there's some BIOS
> > connection.
> >
> > "pci=noaer" would work around this because those error enables would
> > never be set in the first place.
> >
> > I asked reporters to test the debug patches below to disable those
> > error interrupts during suspend.
> >
> > I don't think this would be the *right* fix; if we need to do this, I
> > think it should be done by the PCI core, not by individual drivers.
> > Kai-Heng has been suggesting this for a while for a different
> > scenario.
> 
> Should I send the patch to mailing list again to stir more discussion?

Yes, please.  Include the folks from this thread, too, and the Steam
Deck bugzilla link since we have more more problem reports now.

Bjorn

