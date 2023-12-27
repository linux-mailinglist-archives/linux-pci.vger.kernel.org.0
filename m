Return-Path: <linux-pci+bounces-1395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F4381EAD9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 01:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3D12832B5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37498622;
	Wed, 27 Dec 2023 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk11qKhm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD563AD;
	Wed, 27 Dec 2023 00:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64777C433C8;
	Wed, 27 Dec 2023 00:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703635420;
	bh=B1YU6Z//abG7ywAgEviDCHYEJW3306hDtGtRh7TtSCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Kk11qKhmxi7OwqP/DjfVaplCr3uO8d7rH6JC/KcYSF+YjhpCFelK2Vu+4Np8g1AFL
	 QEGk1sRPAmBHP9zrHZyW/DwlO6D8DVZR3d6Cbb6whMU6+LCEeX0YaoI6afj/DmYR31
	 ptUMKoUk0geXUhoA1yYZzyimgMNsl59/ihJDFA+awsPteOXbI+FZHIaVl9vMgkWRXT
	 SsUjyVqXgNQey2vCWF78ZSrUy8lICWl375DUyr615fP2T85vSZ5ZnrozOn8PgADzkQ
	 IjbmO1NkmgH01p8Tb7sGQsDGMJA8JhoZhI+R9Bm7HlvqOlHd2bG4ESNam1CsKAVaRc
	 irw1q0DxwggZQ==
Date: Tue, 26 Dec 2023 18:03:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Kenneth R. Crudup" <kenny@panix.com>, vidyas@nvidia.com,
	bhelgaas@google.com, kai.heng.feng@canonical.com,
	andrea.righi@canonical.com, vicamo.yang@canonical.com,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	Thomas Witt <kernel@witt.link>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
Message-ID: <20231227000338.GA1484308@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a6d5b9688ff8f0a08da7dd6ecf00fc386ac37f8.camel@linux.intel.com>

On Wed, Dec 20, 2023 at 05:19:34PM -0800, David E. Box wrote:
> On Fri, 2023-11-17 at 16:21 -0800, David E. Box wrote:
> > On Thu, 2023-11-16 at 17:18 -0600, Bjorn Helgaas wrote:
> > > [+cc Matthew, author of 41cd766b0659 ("PCI: Don't enable aspm before drivers
> > > have had a chance to veto it")]
> > > 
> > > On Thu, Nov 16, 2023 at 12:10:02PM -0800, David E. Box wrote:
> > > > On Tue, 2023-11-07 at 13:15 +0200, Mika Westerberg wrote:
> > > > > On Mon, Nov 06, 2023 at 12:11:07PM -0600, Bjorn Helgaas wrote:
> > > > > > On Sat, Nov 04, 2023 at 10:13:24AM -0700, Kenneth R. Crudup wrote:
> > > > > > > 
> > > > > > > I have a Dell XPS-9320 with an Alderlake chipset, and the NVMe
> > > > > > > behind a VMD device:
> > > > > > > 
> > > > > > > ----
> > > > > > > [    0.127342] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P
> > > > > > > (family:
> > > > > > > 0x6, model: 0x9a, stepping: 0x3)
> > > > > > > ----
> > > > > > > 0000:00:0e.0 0104: 8086:467f
> > > > > > >         Subsystem: 1028:0af3
> > > > > > >         Flags: bus master, fast devsel, latency 0, IOMMU group 9
> > > > > > >         Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
> > > > > > >         Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
> > > > > > > a7152be79b6        Memory at 6040100000 (64-bit, non-prefetchable)
> > > > > > > [size=1M]
> > > > > > >         Capabilities: <access denied>
> > > > > > >         Kernel driver in use: vmd
> > > > > > > ----
> > > > > > > 
> > > > > > > The only release kernel that was able to get this laptop to
> > > > > > > fully get into low-power (unfortunately only s0ix) was the
> > > > > > > Ubuntu-6.2.0- ... series from Ubuntu (remote
> > > > > > > git://git.launchpad.net/~ubuntu-
> > > > > > > kernel/ubuntu/+source/linux/+git/lunar).
> > > > > > > 
> > > > > > > I'd bisected it to the following commits (in this order):
> > > > > > > 
> > > > > > > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for
> > > > > > > suspend/resume
> > > > > > > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register
> > > > > > > programming
> > > > > > > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under
> > > > > > > VMD
> > > > > > > domain
> > > > > > > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints
> > > > > > > behind
> > > > > > > VMD
> > > > > > > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name
> > > > > > > instead
> > > > > > 
> > > > > > Thanks for these.  You don't happen to have URLs for those Ubuntu
> > > > > > commits, do you?  E.g., https://git.kernel.org/linus/4ff116d0d5fd
> > > > > > (which was reverted by a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM
> > > > > > Substates Capability for suspend/resume"")).
> > > > > > 
> > > > > > > Without the patches I never see Pkg%PC8 or higher(? lower?),
> > > > > > > nor i915 states DC5/6, all necssary for SYS%LPI/CPU%LPI. I've
> > > > > > > attached a little script I use alongside turbostat for
> > > > > > > verifying low-power operation (and also for seeing what
> > > > > > > chipset subsystem may be preventing it).
> > > > > > > 
> > > > > > > The first two are in Linus' trees, but were reverted
> > > > > > > (4ff116d0d5fd in a7152be79b6, 5e85eba6f50d in ff209ecc376a).
> > > > > > > The last three come from Ubuntu's Linux trees (see remote spec
> > > > > > > above). The first two remain reverted in the Ubuntu trees, but
> > > > > > > if I put them back, I get increased power savings during
> > > > > > > suspend/resume cycles.
> > > > > > > 
> > > > > > > Considering the power draw is really significant without these
> > > > > > > patches (10s of %s per hour) and I'd think Dell would have
> > > > > > > sold some decent number of these laptops, I'd been patiently
> > > > > > > waiting for these patches, or some variant to show up in the
> > > > > > > stable trees, but so far I'm up to the 6.6 stable kernel and
> > > > > > > still having to manually cherry-pick these, so I thought maybe
> > > > > > > I could bring this to the PM maintainers' attention so at
> > > > > > > least start a discussion about this issue.
> > > > > > 
> > > > > > Thank you very much for raising this again.  We really need to make
> > > > > > some progress, and Mika recently posted a patch to add the
> > > > > > 4ff116d0d5fd functionality again:
> > > > > > https://lore.kernel.org/r/20231002070044.2299644-1-mika.westerberg@linux.intel.com
> > > > > > 
> > > > > > The big problem is that it works on *most* systems, but it still
> > > > > > seems to break a few.  So Mika's current patch relies on a
> > > > > > denylist of systems where we *don't* restore the substates.
> > > > > 
> > > > > According to latest reports it is just that one system where this
> > > > > is still an issue. The latest patch works in Asus UX305FA even if
> > > > > it is not in the denylist. That would leave that one system only
> > > > > to the denylist, at least the ones we are aware about.
> > > > 
> > > > I've been working with Thomas, whose system is the last known to
> > > > have problems with Mika's patch. It turns out that his config sets
> > > > aspm_policy to 'powersave'.  If he sets it to any other policy,
> > > > Mika's patch works [1]. It's possible that others may see the same
> > > > issue if they use 'powersave' as well.
> > > > 
> > > > The theory right now is that enabling L1SS in pci_restore_state() is
> > > > too early.  
> > > 
> > > I'd really like to figure out what "too early" means.  We can
> > > make it later by enabling L1SS somewhere else, but unless we
> > > know exactly what needs to happen first, we're likely to break
> > > it again.  And if we know what's required, we can probably
> > > figure out a cleaner way to restore it.
> > 
> > Still trying to understand this particular failure. The current
> > patch to Thomas more closely mimics how ASPM is enabled during
> > boot when powersave is set. If it works we can at least prove that
> > we can get it to work again by using a similar flow.
> 
> With some free time I was able to find a system in our lab that
> reproduces the same failure reported on the last problem report from
> Thomas. That is, with powersave selected, the nvme fails to come up
> after resume from S3 with this patch without a quirk. It's actually
> obvious when you can see the flow. We observed that on S3 resume,
> BIOS has enabled L1.2 (likely back to preboot setting). Restoring
> powersave will therefore disable L1.2. Per spec, L1.2 must be
> disabled on the downstream first. But pci_restore_state() gets
> called on upstream devices first. Indeed, on my system, clearing the
> L1.2 state on the root port makes the nvme device inaccessible by
> the time pci_aspm_restore_state() is called for it. I've modified
> the patch to defer L1SS restore until the downstream component so
> they can be done together. The patch clears L1.2 on the child first
> before the parent, restores both configs and then reenables them in
> reverse on the parent then the child. This works on my system.  I've
> posted the patch as a V5 and on the bugzilla and appreciate if
> anyone here can test.

This is FANTASTIC!  Thank you so much for getting to the bottom of
this!

Bjorn

