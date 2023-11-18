Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617817EFC7B
	for <lists+linux-pci@lfdr.de>; Sat, 18 Nov 2023 01:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjKRAVW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 19:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRAVV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 19:21:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA3DD7E;
        Fri, 17 Nov 2023 16:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700266877; x=1731802877;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YwE0djNRVOJyQD5YpQ1RgaJQX8nki9S4PrCPacBpTSw=;
  b=IeU8UQ34FDAxQm47JglpnmNwlkNWuAkNyPdB9Y5M6lkQUBygu8UeuVvr
   vm/4cMWXp+Hk31vgRK4vncEBmLo2HhRC91hNlIv75mUQpqQzmbtrwazFr
   DiVeiA1gxaAOhxY6u0m1VOtrHjI3b/k2G53vOoFCSgGvnlB0RqX6mZTs6
   ZiciH/vGY3Yc+n3OPAylHkWlWQk1AYXCzB71b9W8Jxgy8BG5uwlXIidf1
   a2u0ghDM7CMIWUhOCRBj+dE59pgSpMjZ80CQ7152sL0x2SIzV2JO0uvU0
   qCGkLawLYYiyX/PtOq67CHEif5M+xIrellnphl6x+ef8u4Bndh9C67/Fy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="394240482"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="394240482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 16:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="836230521"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="836230521"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 16:21:16 -0800
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
        by linux.intel.com (Postfix) with ESMTP id 2F18C580DB4;
        Fri, 17 Nov 2023 16:21:16 -0800 (PST)
Message-ID: <57f31eb90e4027f0da8718f76cae9be9eec19974.camel@linux.intel.com>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>, vidyas@nvidia.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com,
        andrea.righi@canonical.com, vicamo.yang@canonical.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Witt <kernel@witt.link>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Fri, 17 Nov 2023 16:21:16 -0800
In-Reply-To: <20231116231812.GA57394@bhelgaas>
References: <20231116231812.GA57394@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2023-11-16 at 17:18 -0600, Bjorn Helgaas wrote:
> [+cc Matthew, author of 41cd766b0659 ("PCI: Don't enable aspm before driv=
ers
> have had a chance to veto it")]
>=20
> On Thu, Nov 16, 2023 at 12:10:02PM -0800, David E. Box wrote:
> > On Tue, 2023-11-07 at 13:15 +0200, Mika Westerberg wrote:
> > > On Mon, Nov 06, 2023 at 12:11:07PM -0600, Bjorn Helgaas wrote:
> > > > On Sat, Nov 04, 2023 at 10:13:24AM -0700, Kenneth R. Crudup wrote:
> > > > >=20
> > > > > I have a Dell XPS-9320 with an Alderlake chipset, and the NVMe
> > > > > behind a VMD device:
> > > > >=20
> > > > > ----
> > > > > [=C2=A0=C2=A0=C2=A0 0.127342] smpboot: CPU0: 12th Gen Intel(R) Co=
re(TM) i7-1280P
> > > > > (family:
> > > > > 0x6, model: 0x9a, stepping: 0x3)
> > > > > ----
> > > > > 0000:00:0e.0 0104: 8086:467f
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: 1028:0af3
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fas=
t devsel, latency 0, IOMMU group 9
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 603c000000 (=
64-bit, non-prefetchable) [size=3D32M]
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 72000000 (32=
-bit, non-prefetchable) [size=3D32M]
> > > > > a7152be79b6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 6=
040100000 (64-bit, non-prefetchable)
> > > > > [size=3D1M]
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access =
denied>
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: =
vmd
> > > > > ----
> > > > >=20
> > > > > The only release kernel that was able to get this laptop to
> > > > > fully get into low-power (unfortunately only s0ix) was the
> > > > > Ubuntu-6.2.0- ... series from Ubuntu (remote
> > > > > git://git.launchpad.net/~ubuntu-
> > > > > kernel/ubuntu/+source/linux/+git/lunar).
> > > > >=20
> > > > > I'd bisected it to the following commits (in this order):
> > > > >=20
> > > > > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for
> > > > > suspend/resume
> > > > > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register
> > > > > programming
> > > > > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under=
 VMD
> > > > > domain
> > > > > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints be=
hind
> > > > > VMD
> > > > > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name
> > > > > instead
> > > >=20
> > > > Thanks for these.=C2=A0 You don't happen to have URLs for those Ubu=
ntu
> > > > commits, do you?=C2=A0 E.g., https://git.kernel.org/linus/4ff116d0d=
5fd
> > > > (which was reverted by a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM
> > > > Substates Capability for suspend/resume"")).
> > > >=20
> > > > > Without the patches I never see Pkg%PC8 or higher(? lower?),
> > > > > nor i915 states DC5/6, all necssary for SYS%LPI/CPU%LPI. I've
> > > > > attached a little script I use alongside turbostat for
> > > > > verifying low-power operation (and also for seeing what
> > > > > chipset subsystem may be preventing it).
> > > > >=20
> > > > > The first two are in Linus' trees, but were reverted
> > > > > (4ff116d0d5fd in a7152be79b6, 5e85eba6f50d in ff209ecc376a).
> > > > > The last three come from Ubuntu's Linux trees (see remote spec
> > > > > above). The first two remain reverted in the Ubuntu trees, but
> > > > > if I put them back, I get increased power savings during
> > > > > suspend/resume cycles.
> > > > >=20
> > > > > Considering the power draw is really significant without these
> > > > > patches (10s of %s per hour) and I'd think Dell would have
> > > > > sold some decent number of these laptops, I'd been patiently
> > > > > waiting for these patches, or some variant to show up in the
> > > > > stable trees, but so far I'm up to the 6.6 stable kernel and
> > > > > still having to manually cherry-pick these, so I thought maybe
> > > > > I could bring this to the PM maintainers' attention so at
> > > > > least start a discussion about this issue.
> > > >=20
> > > > Thank you very much for raising this again.=C2=A0 We really need to=
 make
> > > > some progress, and Mika recently posted a patch to add the
> > > > 4ff116d0d5fd functionality again:
> > > > https://lore.kernel.org/r/20231002070044.2299644-1-mika.westerberg@=
linux.intel.com
> > > >=20
> > > > The big problem is that it works on *most* systems, but it still
> > > > seems to break a few.=C2=A0 So Mika's current patch relies on a
> > > > denylist of systems where we *don't* restore the substates.
> > >=20
> > > According to latest reports it is just that one system where this
> > > is still an issue. The latest patch works in Asus UX305FA even if
> > > it is not in the denylist. That would leave that one system only
> > > to the denylist, at least the ones we are aware about.
> >=20
> > I've been working with Thomas, whose system is the last known to
> > have problems with Mika's patch. It turns out that his config sets
> > aspm_policy to 'powersave'.=C2=A0 If he sets it to any other policy,
> > Mika's patch works [1]. It's possible that others may see the same
> > issue if they use 'powersave' as well.
> >=20
> > The theory right now is that enabling L1SS in pci_restore_state() is
> > too early.=C2=A0=20
>=20
> I'd really like to figure out what "too early" means.=C2=A0 We can make i=
t
> later by enabling L1SS somewhere else, but unless we know exactly what
> needs to happen first, we're likely to break it again.=C2=A0 And if we kn=
ow
> what's required, we can probably figure out a cleaner way to restore
> it.

Still trying to understand this particular failure. The current patch to Th=
omas
more closely mimics how ASPM is enabled during boot when powersave is set. =
If it
works we can at least prove that we can get it to work again by using a sim=
ilar
flow.

David

>=20
> > During boot, if ASPM policy is 'powersave' or
> > 'powersupersave', ASPM enabling is deferred. The comment in
> > pcie_aspm_init_link_state() that skips it state that:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * At this stage driver=
s haven't had an opportunity to change the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * link policy setting.=
 Enabling ASPM on broken hardware can cripple
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it even before the d=
river has had a chance to disable ASPM, so
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * default to a safe le=
vel right now. If we're enabling ASPM beyond
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the BIOS's expectati=
on, we'll do so once pci_enable_device() is
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * called.
>=20
> This is from 41cd766b0659 ("PCI: Don't enable aspm before drivers have
> had a chance to veto it") [3].=C2=A0 I assume the idea is that driver pro=
be
> methods can use pci_disable_link_state() to veto certain link states.
>=20
> I think this would be better as a quirk instead of a driver probe
> method because I don't think ASPM really has anything to do with the
> driver probe.=C2=A0 We do most ASPM configuration at enumeration (before
> driver probe), so now we have this exception that we delay it until
> probe time if the policy is POLICY_POWERSAVE or
> POLICY_POWER_SUPERSAVE.
>=20
> There are only about a dozen callers of pci_disable_link_state(), so
> it doesn't seem impossible to change them to use quirks instead, e.g.,
> quirk_disable_aspm_l0s() and quirk_disable_aspm_l0s_l1().
>=20
> > While pci_enable_device() is called by the PCI core before
> > pci_restore_state() on resume, it is called again later by the nvme
> > driver in nvme_pci_enable().=C2=A0 This stage seems the intended
> > intercept mentioned in the comment. This ends up calling
> > pcie_aspm_powersave_config_link() to configure ASPM at that time.
> > During boot we see ASPM enabling is indeed happening for powersave
> > during nvme_pci_enable(). With the save/restore patch however it is
> > being restored before nvme_pci_enable(). I've asked Thomas not to
> > apply Mika's patch, but instead use a different patch [2] that waits
> > until pcie_aspm_powersave_config_link() is called to configure ASPM.
> > The need for this is mentioned below. Hopefully it will fix the hang
> > observed on his system.
> >=20
> > Whether that patch works for him, we can address his problem with
> > the current L1SS save/restore patch by removing the current denylist
> > and instead only do the save/restore if ASPM policy is 'default'
> > which doesn't hang his system. This makes sense since it's only the
> > BIOS config that we care to preserve since it can be lost during
> > suspend, particularly during s2idle. All other policies are OS
> > controlled if allowed. Instead of save/restore for those we can let
> > it be configured later when pcie_aspm_powersave_config_link() is
> > called.
> >=20
> > The only issue with this is that pcie_aspm_powersave_config_link()
> > will not configure ASPM if aspm_policy has not changed. This is a
> > problem because we observed that after resume from S3, BIOS has
> > reenabled L1SS. So we can boot with powersave (which disables L1SS)
> > but resume with L1SS enabled and policy still set to powersave. This
> > is a preexisting bug. I've observed this behavior on Thomas's system
> > and with mainline on our desktop systems. This is the reason for
> > patch [2]. It will force ASPM to be configured in
> > pcie_aspm_powersave_config_link() even if the policy is the same. It
> > works on my system. I'm hoping that it will work on his system to
> > resume successfully with the correct policy enabled.
> >=20
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D216877#c33
> > [2] https://bugzilla.kernel.org/attachment.cgi?id=3D305395&action=3Ddif=
f
>=20
> [3] https://git.kernel.org/linus/41cd766b0659

