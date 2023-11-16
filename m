Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D825E7EE820
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 21:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjKPUKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 15:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjKPUKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 15:10:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC79DD57;
        Thu, 16 Nov 2023 12:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700165403; x=1731701403;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UHMUFTzNXD8Z4l7Z/deqaWmcu4TQBogG2OItLvcCirs=;
  b=K/YLEjPaPTFsRnKVoH8up3B4rrwZtWUzAn0aEo6tnBa4ms+SznWwtPSt
   iCSKkw5m7DBp9NNUvVGvjh4kOzCcnLzyUkyanziq8z1yUMWC+UM0R6+14
   AJmonXjeHmUH2btdBWdSEQvI1U02ji9uAe2hNbPg8FNCsggYc86Tl5XLD
   d6fB+0Cna2Y1h6pPfief4ekVi6QqC7gRqOgSb19er34FLzmnk4FZGmp7j
   MrLqJ7hAqI4sKPQOHn/9o5Yc8KABncpsiVyfNyB3YgvdfFhagg3uxf5+D
   p63Ssovg4rVYVzkKH6m0tCfZpCnDv1vFCpbTLA57sux37pDJ+wTzo0Slo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="457670158"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="457670158"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 12:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="6639539"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 12:10:03 -0800
Received: from bjrichar-mobl.amr.corp.intel.com (unknown [10.212.139.126])
        by linux.intel.com (Postfix) with ESMTP id A3723580DAB;
        Thu, 16 Nov 2023 12:10:02 -0800 (PST)
Message-ID: <70ec50bab17ec112641f01a122e389e71b470270.camel@linux.intel.com>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>, vidyas@nvidia.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com,
        andrea.righi@canonical.com, vicamo.yang@canonical.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Witt <kernel@witt.link>
Date:   Thu, 16 Nov 2023 12:10:02 -0800
In-Reply-To: <20231107111530.GW17433@black.fi.intel.com>
References: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
         <20231106181107.GA255535@bhelgaas>
         <20231107111530.GW17433@black.fi.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika, Bjorn,

On Tue, 2023-11-07 at 13:15 +0200, Mika Westerberg wrote:
> Hi,
>=20
> On Mon, Nov 06, 2023 at 12:11:07PM -0600, Bjorn Helgaas wrote:
> > [+cc Mika, Sathy, Rafael, David, Ilpo, Ricky, Mario, linux-pci]
> >=20
> > On Sat, Nov 04, 2023 at 10:13:24AM -0700, Kenneth R. Crudup wrote:
> > >=20
> > > I have a Dell XPS-9320 with an Alderlake chipset, and the NVMe behind=
 a
> > > VMD device:
> > >=20
> > > ----
> > > [=C2=A0=C2=A0=C2=A0 0.127342] smpboot: CPU0: 12th Gen Intel(R) Core(T=
M) i7-1280P (family:
> > > 0x6, model: 0x9a, stepping: 0x3)
> > > ----
> > > 0000:00:0e.0 0104: 8086:467f
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: 1028:0af3
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast de=
vsel, latency 0, IOMMU group 9
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 603c000000 (64-b=
it, non-prefetchable) [size=3D32M]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 72000000 (32-bit=
, non-prefetchable) [size=3D32M]
> > > a7152be79b6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 60401=
00000 (64-bit, non-prefetchable)
> > > [size=3D1M]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access deni=
ed>
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: vmd
> > > ----
> > >=20
> > > The only release kernel that was able to get this laptop to fully get=
 into
> > > low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... series =
from
> > > Ubuntu
> > > (remote git://git.launchpad.net/~ubuntu-
> > > kernel/ubuntu/+source/linux/+git/lunar).
> > >=20
> > > I'd bisected it to the following commits (in this order):
> > >=20
> > > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/re=
sume
> > > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register
> > > programming
> > > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
> > > domain
> > > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind=
 VMD
> > > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name ins=
tead
> >=20
> > Thanks for these.=C2=A0 You don't happen to have URLs for those Ubuntu
> > commits, do you?=C2=A0 E.g., https://git.kernel.org/linus/4ff116d0d5fd
> > (which was reverted by a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM
> > Substates Capability for suspend/resume"")).
> >=20
> > > Without the patches I never see Pkg%PC8 or higher(? lower?), nor i915
> > > states
> > > DC5/6, all necssary for SYS%LPI/CPU%LPI. I've attached a little scrip=
t I
> > > use
> > > alongside turbostat for verifying low-power operation (and also for s=
eeing
> > > what chipset subsystem may be preventing it).
> > >=20
> > > The first two are in Linus' trees, but were reverted (4ff116d0d5fd in
> > > a7152be79b6, 5e85eba6f50d in ff209ecc376a). The last three come from
> > > Ubuntu's
> > > Linux trees (see remote spec above). The first two remain reverted in=
 the
> > > Ubuntu trees, but if I put them back, I get increased power savings d=
uring
> > > suspend/resume cycles.
> > >=20
> > > Considering the power draw is really significant without these patche=
s
> > > (10s
> > > of %s per hour) and I'd think Dell would have sold some decent number=
 of
> > > these laptops, I'd been patiently waiting for these patches, or some
> > > variant
> > > to show up in the stable trees, but so far I'm up to the 6.6 stable k=
ernel
> > > and still having to manually cherry-pick these, so I thought maybe I =
could
> > > bring this to the PM maintainers' attention so at least start a discu=
ssion
> > > about this issue.
> >=20
> > Thank you very much for raising this again.=C2=A0 We really need to mak=
e
> > some progress, and Mika recently posted a patch to add the
> > 4ff116d0d5fd functionality again:
> > https://lore.kernel.org/r/20231002070044.2299644-1-mika.westerberg@linu=
x.intel.com
> >=20
> > The big problem is that it works on *most* systems, but it still seems
> > to break a few.=C2=A0 So Mika's current patch relies on a denylist of
> > systems where we *don't* restore the substates.
>=20
> According to latest reports it is just that one system where this is
> still an issue. The latest patch works in Asus UX305FA even if it is not
> in the denylist. That would leave that one system only to the denylist,
> at least the ones we are aware about.

I've been working with Thomas, whose system is the last known to have probl=
ems
with Mika's patch. It turns out that his config sets aspm_policy to 'powers=
ave'.
If he sets it to any other policy, Mika's patch works [1]. It's possible th=
at
others may see the same issue if they use 'powersave' as well.

The theory right now is that enabling L1SS in pci_restore_state() is too ea=
rly.
During boot, if ASPM policy is 'powersave' or 'powersupersave', ASPM enabli=
ng is
deferred. The comment in pcie_aspm_init_link_state() that skips it state th=
at:

        /*
         * At this stage drivers haven't had an opportunity to change the
         * link policy setting. Enabling ASPM on broken hardware can crippl=
e
         * it even before the driver has had a chance to disable ASPM, so
         * default to a safe level right now. If we're enabling ASPM beyond
         * the BIOS's expectation, we'll do so once pci_enable_device() is
         * called.
         */

While pci_enable_device() is called by the PCI core before pci_restore_stat=
e()
on resume, it is called again later by the nvme driver in nvme_pci_enable()=
.
This stage seems the intended intercept mentioned in the comment. This ends=
 up
calling pcie_aspm_powersave_config_link() to configure ASPM at that time. D=
uring
boot we see ASPM enabling is indeed happening for powersave during
nvme_pci_enable(). With the save/restore patch however it is being restored
before nvme_pci_enable(). I've asked Thomas not to apply Mika's patch, but
instead use a different patch [2] that waits until
pcie_aspm_powersave_config_link() is called to configure ASPM. The need for=
 this
is mentioned below. Hopefully it will fix the hang observed on his system.

Whether that patch works for him, we can address his problem with the curre=
nt
L1SS save/restore patch by removing the current denylist and instead only d=
o the
save/restore if ASPM policy is 'default' which doesn't hang his system. Thi=
s
makes sense since it's only the BIOS config that we care to preserve since =
it
can be lost during suspend, particularly during s2idle. All other policies =
are
OS controlled if allowed. Instead of save/restore for those we can let it b=
e
configured later when pcie_aspm_powersave_config_link() is called.

The only issue with this is that pcie_aspm_powersave_config_link() will not
configure ASPM if aspm_policy has not changed. This is a problem because we
observed that after resume from S3, BIOS has reenabled L1SS. So we can boot=
 with
powersave (which disables L1SS) but resume with L1SS enabled and policy sti=
ll
set to powersave. This is a preexisting bug. I've observed this behavior on
Thomas's system and with mainline on our desktop systems. This is the reaso=
n for
patch [2]. It will force ASPM to be configured in
pcie_aspm_powersave_config_link() even if the policy is the same. It works =
on my
system. I'm hoping that it will work on his system to resume successfully w=
ith
the correct policy enabled.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D216877#c33
[2] https://bugzilla.kernel.org/attachment.cgi?id=3D305395&action=3Ddiff

David
