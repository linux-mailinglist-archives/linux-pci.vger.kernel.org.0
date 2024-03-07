Return-Path: <linux-pci+bounces-4627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B95C875A3A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 23:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1684B21810
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FD013EFE4;
	Thu,  7 Mar 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccTGVKEM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065713E7F4;
	Thu,  7 Mar 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850348; cv=none; b=kz2XL4e1lSIPuBgMIZBCYcxJLzuDufGz/OHGs8dHxllxysfZVHA+AtwpNYax1mhBLR1YHGdCJbcg6z6RHt/ThnhnTqNEPZUwnR60lrwKasoo3VQBg17uFTRCVfpHLSkMRqb0zPwVM8xuFgey166oNoj6zBARYVont/9cFyF2v2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850348; c=relaxed/simple;
	bh=TOXR+EDXAVd4J1XWgqy4st5avJH4c6BcdZwNi55Vyr4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BiArEPSW5OvezEOKwy8Grq1BODdHLU5+jMkczBYBcMcwRx9EjZoOSGEJCNfGYqQ1m1jlzQJsSwzF3dbyd6Ay+BVz08BmVWpLC7dMMuDz0nghLrSqMNQv8c0Y3xobn1AAZ5aAPbHpT/zkAqL3v/+cSC+WYTg641Y29vfAZOjwVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccTGVKEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CB7C433C7;
	Thu,  7 Mar 2024 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709850347;
	bh=TOXR+EDXAVd4J1XWgqy4st5avJH4c6BcdZwNi55Vyr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ccTGVKEMPay0KoRXj5r8JTMwSPADQfp0xosy8gfOZAmLigE76OlZGlKJAb4QooJHf
	 uUYll1ow3BHPFx0IQSSQdYH974FqLMwJPf/2fwcPRCQe74ef6uEcykyrAtwUBXqRH/
	 R893hlTWMmx+QCxwz/ynYkh/sA5D3pCVNE67YDvs9RhNBa52XtKqu10kC65SRCAI6n
	 RxuhWZFn5AxGHY4gQjXenJQfpRumgFVGUz8VjGDZsdaZFSS0BUqnep43D27sX39VKx
	 XxTGeGoadR17ZsVvSvwHvjUVYJ6OJkmv+nr9eKKL5FvUEXkcP3FTJmzRiOmjpiwa5n
	 R3GIKxHtKaHDQ==
Date: Thu, 7 Mar 2024 16:25:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tasev Nikola <tasev.stefanoska@skynet.be>,
	Mark Enriquez <enriquezmark36@gmail.com>,
	Thomas Witt <kernel@witt.link>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Koba Ko <koba.ko@canonical.com>
Subject: Re: [PATCH v7 0/5] PCI/ASPM: Save/restore L1 PM Substates for
 suspend/resume
Message-ID: <20240307222545.GA655965@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305214656.GA550701@bhelgaas>

[+cc Koba Ko]

On Tue, Mar 05, 2024 at 03:46:56PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 23, 2024 at 02:58:46PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This is some rework of David's series to preserve ASPM L1 substate
> > configuration across suspend/resume.
> > ...

> > David E. Box (5):
> >   PCI/ASPM: Move pci_configure_ltr() to aspm.c
> >   PCI/ASPM: Always build aspm.c
> >   PCI/ASPM: Move pci_save_ltr_state() to aspm.c
> >   PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
> >   PCI/ASPM: Call pci_save_ltr_state() from pci_save_pcie_state()
> > 
> >  drivers/pci/pci.c         |  89 ++++------------
> >  drivers/pci/pci.h         |  13 ++-
> >  drivers/pci/pcie/Makefile |   2 +-
> >  drivers/pci/pcie/aspm.c   | 215 ++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/probe.c       |  62 +----------
> >  include/linux/pci.h       |   2 +-
> >  6 files changed, 252 insertions(+), 131 deletions(-)
> 
> I applied these as pci/aspm for v6.9, replacing the original unlabeled
> v6 that has been in -next.

Would anybody be able to test this, particularly to make sure it works
for the bugs we're claiming to fix with this series?

  https://bugzilla.kernel.org/show_bug.cgi?id=217321
  https://bugzilla.kernel.org/show_bug.cgi?id=216782
  https://bugzilla.kernel.org/show_bug.cgi?id=216877

This series is headed for v6.9, and I hope we can finally claim
victory over these issues.

This is in -next as of the Mar 7 tree.  Or if you want just the ASPM
changes, based on v6.8-rc1, you can use the branch at
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=aspm

Bjorn

