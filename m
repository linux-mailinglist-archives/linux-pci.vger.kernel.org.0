Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2847EE9EE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 00:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKPXST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 18:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPXSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 18:18:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38918EA;
        Thu, 16 Nov 2023 15:18:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8472DC433C7;
        Thu, 16 Nov 2023 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700176694;
        bh=k1R+GEUCPmHvEtLSAm28tPe2phQIllTVV+lzsVOEzC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hpci31rAnVHKAJcvapIw3r/R4Ozj1z/4xk3fmS3DT5MEwCE8W7lqmsqxgdJSdbdJ1
         SNSjLExyvSoWKbofB9Ag4lvgeZ8h0iT8T3JYNUFTBn4+FkIs8CBrckWvMturHhj2Hn
         tPLdfbBX47wkCWP4625Alh16srUuqJ6ZgaHe2ZELMK/QDCTqbNAym43OEEHSHzGg2I
         Q0vjMl6X1qaHUSDIBHYkHPeCC4D9RBmxtpj2uI89ZJH/RVAMrdQyrtW9p7e70z3Vvy
         H42+96jOLCSJqFPIolJDD6J2FlKsEV11H6EhwkEWz7FdsoPJ6HpE2RFezSDGNWzp17
         hz22SeF/hFUow==
Date:   Thu, 16 Nov 2023 17:18:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>, vidyas@nvidia.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com,
        andrea.righi@canonical.com, vicamo.yang@canonical.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Witt <kernel@witt.link>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
Message-ID: <20231116231812.GA57394@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70ec50bab17ec112641f01a122e389e71b470270.camel@linux.intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Matthew, author of 41cd766b0659 ("PCI: Don't enable aspm before drivers have had a chance to veto it")]

On Thu, Nov 16, 2023 at 12:10:02PM -0800, David E. Box wrote:
> On Tue, 2023-11-07 at 13:15 +0200, Mika Westerberg wrote:
> > On Mon, Nov 06, 2023 at 12:11:07PM -0600, Bjorn Helgaas wrote:
> > > On Sat, Nov 04, 2023 at 10:13:24AM -0700, Kenneth R. Crudup wrote:
> > > > 
> > > > I have a Dell XPS-9320 with an Alderlake chipset, and the NVMe
> > > > behind a VMD device:
> > > > 
> > > > ----
> > > > [    0.127342] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P (family:
> > > > 0x6, model: 0x9a, stepping: 0x3)
> > > > ----
> > > > 0000:00:0e.0 0104: 8086:467f
> > > >         Subsystem: 1028:0af3
> > > >         Flags: bus master, fast devsel, latency 0, IOMMU group 9
> > > >         Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
> > > >         Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
> > > > a7152be79b6        Memory at 6040100000 (64-bit, non-prefetchable)
> > > > [size=1M]
> > > >         Capabilities: <access denied>
> > > >         Kernel driver in use: vmd
> > > > ----
> > > > 
> > > > The only release kernel that was able to get this laptop to
> > > > fully get into low-power (unfortunately only s0ix) was the
> > > > Ubuntu-6.2.0- ... series from Ubuntu (remote
> > > > git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar).
> > > > 
> > > > I'd bisected it to the following commits (in this order):
> > > > 
> > > > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
> > > > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register
> > > > programming
> > > > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
> > > > domain
> > > > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
> > > > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead
> > > 
> > > Thanks for these.  You don't happen to have URLs for those Ubuntu
> > > commits, do you?  E.g., https://git.kernel.org/linus/4ff116d0d5fd
> > > (which was reverted by a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM
> > > Substates Capability for suspend/resume"")).
> > > 
> > > > Without the patches I never see Pkg%PC8 or higher(? lower?),
> > > > nor i915 states DC5/6, all necssary for SYS%LPI/CPU%LPI. I've
> > > > attached a little script I use alongside turbostat for
> > > > verifying low-power operation (and also for seeing what
> > > > chipset subsystem may be preventing it).
> > > > 
> > > > The first two are in Linus' trees, but were reverted
> > > > (4ff116d0d5fd in a7152be79b6, 5e85eba6f50d in ff209ecc376a).
> > > > The last three come from Ubuntu's Linux trees (see remote spec
> > > > above). The first two remain reverted in the Ubuntu trees, but
> > > > if I put them back, I get increased power savings during
> > > > suspend/resume cycles.
> > > > 
> > > > Considering the power draw is really significant without these
> > > > patches (10s of %s per hour) and I'd think Dell would have
> > > > sold some decent number of these laptops, I'd been patiently
> > > > waiting for these patches, or some variant to show up in the
> > > > stable trees, but so far I'm up to the 6.6 stable kernel and
> > > > still having to manually cherry-pick these, so I thought maybe
> > > > I could bring this to the PM maintainers' attention so at
> > > > least start a discussion about this issue.
> > > 
> > > Thank you very much for raising this again.  We really need to make
> > > some progress, and Mika recently posted a patch to add the
> > > 4ff116d0d5fd functionality again:
> > > https://lore.kernel.org/r/20231002070044.2299644-1-mika.westerberg@linux.intel.com
> > > 
> > > The big problem is that it works on *most* systems, but it still
> > > seems to break a few.  So Mika's current patch relies on a
> > > denylist of systems where we *don't* restore the substates.
> > 
> > According to latest reports it is just that one system where this
> > is still an issue. The latest patch works in Asus UX305FA even if
> > it is not in the denylist. That would leave that one system only
> > to the denylist, at least the ones we are aware about.
> 
> I've been working with Thomas, whose system is the last known to
> have problems with Mika's patch. It turns out that his config sets
> aspm_policy to 'powersave'.  If he sets it to any other policy,
> Mika's patch works [1]. It's possible that others may see the same
> issue if they use 'powersave' as well.
> 
> The theory right now is that enabling L1SS in pci_restore_state() is
> too early.  

I'd really like to figure out what "too early" means.  We can make it
later by enabling L1SS somewhere else, but unless we know exactly what
needs to happen first, we're likely to break it again.  And if we know
what's required, we can probably figure out a cleaner way to restore
it.

> During boot, if ASPM policy is 'powersave' or
> 'powersupersave', ASPM enabling is deferred. The comment in
> pcie_aspm_init_link_state() that skips it state that:
> 
>         /*
>          * At this stage drivers haven't had an opportunity to change the
>          * link policy setting. Enabling ASPM on broken hardware can cripple
>          * it even before the driver has had a chance to disable ASPM, so
>          * default to a safe level right now. If we're enabling ASPM beyond
>          * the BIOS's expectation, we'll do so once pci_enable_device() is
>          * called.

This is from 41cd766b0659 ("PCI: Don't enable aspm before drivers have
had a chance to veto it") [3].  I assume the idea is that driver probe
methods can use pci_disable_link_state() to veto certain link states.

I think this would be better as a quirk instead of a driver probe
method because I don't think ASPM really has anything to do with the
driver probe.  We do most ASPM configuration at enumeration (before
driver probe), so now we have this exception that we delay it until
probe time if the policy is POLICY_POWERSAVE or
POLICY_POWER_SUPERSAVE.

There are only about a dozen callers of pci_disable_link_state(), so
it doesn't seem impossible to change them to use quirks instead, e.g.,
quirk_disable_aspm_l0s() and quirk_disable_aspm_l0s_l1().

> While pci_enable_device() is called by the PCI core before
> pci_restore_state() on resume, it is called again later by the nvme
> driver in nvme_pci_enable().  This stage seems the intended
> intercept mentioned in the comment. This ends up calling
> pcie_aspm_powersave_config_link() to configure ASPM at that time.
> During boot we see ASPM enabling is indeed happening for powersave
> during nvme_pci_enable(). With the save/restore patch however it is
> being restored before nvme_pci_enable(). I've asked Thomas not to
> apply Mika's patch, but instead use a different patch [2] that waits
> until pcie_aspm_powersave_config_link() is called to configure ASPM.
> The need for this is mentioned below. Hopefully it will fix the hang
> observed on his system.
> 
> Whether that patch works for him, we can address his problem with
> the current L1SS save/restore patch by removing the current denylist
> and instead only do the save/restore if ASPM policy is 'default'
> which doesn't hang his system. This makes sense since it's only the
> BIOS config that we care to preserve since it can be lost during
> suspend, particularly during s2idle. All other policies are OS
> controlled if allowed. Instead of save/restore for those we can let
> it be configured later when pcie_aspm_powersave_config_link() is
> called.
> 
> The only issue with this is that pcie_aspm_powersave_config_link()
> will not configure ASPM if aspm_policy has not changed. This is a
> problem because we observed that after resume from S3, BIOS has
> reenabled L1SS. So we can boot with powersave (which disables L1SS)
> but resume with L1SS enabled and policy still set to powersave. This
> is a preexisting bug. I've observed this behavior on Thomas's system
> and with mainline on our desktop systems. This is the reason for
> patch [2]. It will force ASPM to be configured in
> pcie_aspm_powersave_config_link() even if the policy is the same. It
> works on my system. I'm hoping that it will work on his system to
> resume successfully with the correct policy enabled.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216877#c33
> [2] https://bugzilla.kernel.org/attachment.cgi?id=305395&action=diff

[3] https://git.kernel.org/linus/41cd766b0659
