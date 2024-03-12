Return-Path: <linux-pci+bounces-4762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0BF879A5A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD73E1C21EF8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6D413848C;
	Tue, 12 Mar 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="devtnbWI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455921272D0;
	Tue, 12 Mar 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263351; cv=none; b=NW/jP4q9m0LDcXbXMLwiScKhcMg3ZP+fquhNrQiohglKLJjW174N1HRsIyDuMkykPJ0/fXggvxhUOk/UccuJDvjgFaR/jsKAOWc4dV2Lfdm5Lsxv3eg9VfR+pO+XR1+MsXiMGX3jCUtW4oBa8lAymTjoU15iBYm8x1BGGvEV/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263351; c=relaxed/simple;
	bh=1jA03QW9AFvjOJhcOZGMu3kdX8qPXMuBJ+eiBAtPS+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mhX4MLcIndNk/mv1SbHhIzbQikqX1vFaqKealJLRLAlTWdcP8QGTdiNj0ZjWNV+6uhUv/YvTaBxGUoo71vvpyCZm0DhjbQeI13TuVmbfwIov7rdvrQetQjko+Y2s2P8jLrNVso4X9zzX2Lepdzh7fwjyMPw0626ke/L4kDrEj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=devtnbWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850A7C433C7;
	Tue, 12 Mar 2024 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710263350;
	bh=1jA03QW9AFvjOJhcOZGMu3kdX8qPXMuBJ+eiBAtPS+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=devtnbWIbz3pDe7o6Lbc2wO3rFU/mFmuDdiTUvzYqeZJw6u137ySWznv+7MZDpzTD
	 +6zQeww9Q7QvoxDwiLFPz11TGqhQIyOs4+WIJwOpqQtIv6id4Kao0fhICZGe7fs4Bd
	 v0kwC5USz1HceWiDRA3+FQ7feHsnQ+GLdZb5uHXo4bg25UwhQyYMTTgO6xKpcMKweC
	 KONQZNlMp5kNQkALF2ufFmfAJm/d34XAKgBsTR8Nt5OiecSxP/PUJF+PaS1GCmtdCA
	 0lH5DtiZbEcOsJbPt4i4po2FD+Ru175iQuz32Ie0YX7VaivcvKvWvELIkCo01UooBX
	 olwsB3zz4cqIg==
Date: Tue, 12 Mar 2024 12:09:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "tasev.stefanoska" <tasev.stefanoska@skynet.be>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
Message-ID: <20240312170908.GA851847@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <482b5ee6-5581-4e57-8ca3-8aec0d974c6d@skynet.be>

On Tue, Mar 12, 2024 at 06:03:21PM +0100, tasev.stefanoska wrote:
> Le 7/03/24 à 23:25, Bjorn Helgaas a écrit :
> > On Tue, Mar 05, 2024 at 03:46:56PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Feb 23, 2024 at 02:58:46PM -0600, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > 
> > > > This is some rework of David's series to preserve ASPM L1 substate
> > > > configuration across suspend/resume.
> > > > ...
> > > > David E. Box (5):
> > > >    PCI/ASPM: Move pci_configure_ltr() to aspm.c
> > > >    PCI/ASPM: Always build aspm.c
> > > >    PCI/ASPM: Move pci_save_ltr_state() to aspm.c
> > > >    PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
> > > >    PCI/ASPM: Call pci_save_ltr_state() from pci_save_pcie_state()
> > > > 
> > > >   drivers/pci/pci.c         |  89 ++++------------
> > > >   drivers/pci/pci.h         |  13 ++-
> > > >   drivers/pci/pcie/Makefile |   2 +-
> > > >   drivers/pci/pcie/aspm.c   | 215 ++++++++++++++++++++++++++++++++++++++
> > > >   drivers/pci/probe.c       |  62 +----------
> > > >   include/linux/pci.h       |   2 +-
> > > >   6 files changed, 252 insertions(+), 131 deletions(-)
> > >
> > > I applied these as pci/aspm for v6.9, replacing the original unlabeled
> > > v6 that has been in -next.
> >
> > Would anybody be able to test this, particularly to make sure it works
> > for the bugs we're claiming to fix with this series?
> > 
> >    https://bugzilla.kernel.org/show_bug.cgi?id=217321
> >    https://bugzilla.kernel.org/show_bug.cgi?id=216782
> >    https://bugzilla.kernel.org/show_bug.cgi?id=216877
> > 
> > This series is headed for v6.9, and I hope we can finally claim
> > victory over these issues.
> > 
> > This is in -next as of the Mar 7 tree.  Or if you want just the ASPM
> > changes, based on v6.8-rc1, you can use the branch at
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=aspm
> 
> I just tested the patch v7 from Bjorn, it works on my Asus UX305FA.
> Tested on kernel v6.8-rc1.

Thank you very much!  I added the following to the "PCI/ASPM: Save L1
PM Substates Capability for suspend/resume" patch:

  Tested-by: Tasev Nikola <tasev.stefanoska@skynet.be> # Asus UX305FA

