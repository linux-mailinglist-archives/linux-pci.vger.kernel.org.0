Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E01B786BC8
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404191AbfHHUmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 16:42:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46680 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfHHUmJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 16:42:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so5619993otk.13;
        Thu, 08 Aug 2019 13:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPx3oxQe9mnn97sFiVMnQ+/paC/GNRx7B//ee5f5G+w=;
        b=ugYUBcK+EN5qAowjCobddOV5hfi0mnhAPmOFo0ZYFUxnhvg95duSbiYtF1z2naP2+V
         q2xd/dANW+KpuStXLVn9Ve4FW4CZPLhiGE4HSv63DtyP0FMwYW2IPckzs2qs0Hu6yHDS
         je+Xw7Yn6zGIPrIbvP6tlvCrKtSC9MVwQA+kQhqR67GANpQ28XqxTKOeXB/Ds8e+BIuD
         MpUGVD60OZ+desjBlnCJ+39Lb4FU7qCM/SpM2TDp1db0Zz0M3Vz1UmajJIif0Y2m/pOX
         dawfTkSsc9d2EnTiXLfpFCH4TlOMPTFMEq2vSbwNggmDq387GmUKYYogpIdB3qeTOa98
         tMWQ==
X-Gm-Message-State: APjAAAUgrd0PZWefls767rRfSToKzAJeWV7G0D89YUOEdu17av7w5mvu
        ZXtwaSGuIpOX5C6c/4Lz103ZEQgGXxrLqSyi8Mo=
X-Google-Smtp-Source: APXvYqwI9N0vho3Kstoj/H4iMj4aMw65wU5o8DrhhcaHfjfCflP5uRJ/sVsJbHZuSDGKa7kedtXjfG4YYWD9/H6BxTQ=
X-Received: by 2002:aca:5a41:: with SMTP id o62mr4004626oib.110.1565296927852;
 Thu, 08 Aug 2019 13:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain> <1921165.pTveHRX1Co@kreacher>
 <1870928.r7tBYyfqdz@kreacher> <20190808134356.GF151852@google.com>
 <CAJZ5v0h=nz8yXwOOGBUB9m1GtJPOqBwtNK7zXPNMJjzPhMWd9w@mail.gmail.com> <20190808183954.GG151852@google.com>
In-Reply-To: <20190808183954.GG151852@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Aug 2019 22:41:56 +0200
Message-ID: <CAJZ5v0h95m=G2T_i7uSygK4H=VLH4Txte_ffKc5JBA33A=N76Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 8, 2019, 20:39 Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Aug 08, 2019 at 04:47:45PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Aug 8, 2019 at 3:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Aug 08, 2019 at 12:10:06PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
> > > > host managed power state for suspend") was adding a pci_save_state()
> > > > call to nvme_suspend() in order to prevent the PCI bus-level PM from
> > > > being applied to the suspended NVMe devices, but if ASPM is not
> > > > enabled for the target NVMe device, that causes its PCIe link to stay
> > > > up and the platform may not be able to get into its optimum low-power
> > > > state because of that.
> > > >
> > > > For example, if ASPM is disabled for the NVMe drive (PC401 NVMe SK
> > > > hynix 256GB) in my Dell XPS13 9380, leaving it in D0 during
> > > > suspend-to-idle prevents the SoC from reaching package idle states
> > > > deeper than PC3, which is way insufficient for system suspend.
> > >
> > > Just curious: I assume the SoC you reference is some part of the NVMe
> > > drive?
> >
> > No, the SoC is what contains the Intel processor and PCH (formerly "chipset").
> >
> > > > To address this shortcoming, make nvme_suspend() check if ASPM is
> > > > enabled for the target device and fall back to full device shutdown
> > > > and PCI bus-level PM if that is not the case.
> > > >
> > > > Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> > > > Link: https://lore.kernel.org/linux-pm/2763495.NmdaWeg79L@kreacher/T/#t
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > -> v2:
> > > >   * Move the PCI/PCIe ASPM changes to a separate patch.
> > > >   * Do not add a redundant ndev->last_ps == U32_MAX check in nvme_suspend().
> > > >
> > > > ---
> > > >  drivers/nvme/host/pci.c |   13 ++++++++++---
> > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/nvme/host/pci.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/nvme/host/pci.c
> > > > +++ linux-pm/drivers/nvme/host/pci.c
> > > > @@ -2846,7 +2846,7 @@ static int nvme_resume(struct device *de
> > > >       struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
> > > >       struct nvme_ctrl *ctrl = &ndev->ctrl;
> > > >
> > > > -     if (pm_resume_via_firmware() || !ctrl->npss ||
> > > > +     if (ndev->last_ps == U32_MAX ||
> > > >           nvme_set_power_state(ctrl, ndev->last_ps) != 0)
> > > >               nvme_reset_ctrl(ctrl);
> > > >       return 0;
> > > > @@ -2859,6 +2859,8 @@ static int nvme_suspend(struct device *d
> > > >       struct nvme_ctrl *ctrl = &ndev->ctrl;
> > > >       int ret = -EBUSY;
> > > >
> > > > +     ndev->last_ps = U32_MAX;
> > > > +
> > > >       /*
> > > >        * The platform does not remove power for a kernel managed suspend so
> > > >        * use host managed nvme power settings for lowest idle power if
> > > > @@ -2866,8 +2868,14 @@ static int nvme_suspend(struct device *d
> > > >        * shutdown.  But if the firmware is involved after the suspend or the
> > > >        * device does not support any non-default power states, shut down the
> > > >        * device fully.
> > > > +      *
> > > > +      * If ASPM is not enabled for the device, shut down the device and allow
> > > > +      * the PCI bus layer to put it into D3 in order to take the PCIe link
> > > > +      * down, so as to allow the platform to achieve its minimum low-power
> > > > +      * state (which may not be possible if the link is up).
> > > >        */
> > > > -     if (pm_suspend_via_firmware() || !ctrl->npss) {
> > > > +     if (pm_suspend_via_firmware() || !ctrl->npss ||
> > > > +         !pcie_aspm_enabled_mask(pdev)) {
> > >
> > > This seems like a layering violation, in the sense that ASPM is
> > > supposed to be hardware-autonomous and invisible to software.
> >
> > But software has to enable it.
> >
> > If it is not enabled, it will not be used, and that's what the check
> > is about.
> >
> > > IIUC the NVMe device will go to the desired package idle state if
> > > the link is in L0s or L1, but not if the link is in L0.  I don't
> > > understand that connection; AFAIK that would be something outside
> > > the scope of the PCIe spec.
> >
> > Yes, it is outside of the PCIe spec.
> >
> > No, this is not about the NVMe device, it is about the Intel SoC
> > (System-on-a-Chip) the platform is based on.
>
> Ah.  So this problem could occur with any device, not just NVMe?  If
> so, how do you address that?  Obviously you don't want to patch all
> drivers this way.

It could, if the device was left in D0 during suspend, but drivers
don't let devices stay in D0 during suspend as a rule, so this is all
academic, except for the NVMe driver that has just started to do it in
5.3-rc1.

It has started to do that becasuse of what can be regarded as a
hardware issue, but this does not even matter here.

>
> > The background really is commit d916b1be94b6 and its changelog is
> > kind of misleading, unfortunately.  What it did, among other things,
> > was to cause the NVMe driver to prevent the PCI bus type from
> > applying the standard PCI PM to the devices handled by it in the
> > suspend-to-idle flow.
>
> This is more meaningful to you than to most people because "applying
> the standard PCI PM" doesn't tell us what that means in terms of the
> device.  Presumably it has something to do with a D-state transition?
> I *assume* a suspend might involve the D0 -> D3hot transition you
> mention below?

By "standard PCI PM" I mean what pci_prepare_to_sleep() does. And yes,
in the vast majority of cases the device goes from D0 to D3hot then.

>
> > The reason for doing that was a (reportedly) widespread failure to
> > take the PCIe link down during D0 -> D3hot transitions of NVMe
> > devices,
>
> I don't know any of the details, but "failure to take the link down
> during D0 -> D3hot transitions" is phrased as though it might be a
> hardware erratum.  If this *is* related to an NVMe erratum, that would
> explain why you only need to patch the nvme driver, and it would be
> useful to mention that in the commit log, since otherwise it sounds
> like something that might be needed in other drivers, too.

Yes, that can be considered as an NVMe erratum and the NVMe driver has
been *already* patched because of that in 5.3-rc1. [That's the commit
mentioned in the changelog of the $subject patch.]

It effectively asks the PCI bus type to leave *all* devices handled by
it in D0 during suspend-to-idle.  Already today.

I hope that this clarifies the current situation. :-)

>
> According to PCIe r5.0 sec 5.3.2, the only legal link states for D3hot
> are L1, L2/L3 Ready.  So if you put a device in D3hot and its link
> stays in L0, that sounds like a defect.  Is that what happens?

For some devices that's what happens. For some other devices the state
of the link in D3hot appears to be L1 or L2/L3 Ready (as per the spec)
and that's when the $subject patch makes a difference.

The underlying principle is that the energy used by the system while
suspended depends on the states of all of the PCIe links and the
deeper the link state, the less energy the system will use.

Now, say an NVMe device works in accordance with the spec, so when it
goes from D0 to D3hot, its PCIe link goes into L1 or L2/L3 Ready.  As
of 5.3-rc1 or later it will be left in D0 during suspend-to-idle
(because that's how the NVMe driver works), so its link state will
depend on whether or not ASPM is enabled for it.  If ASPM is enabled
for it, the final state of its link will depend on how deep ASPM is
allowed to go, but if ASPM is not enabled for it, its link will remain
in L0.

This means, however, that by allowing that device to go into D3hot
when ASPM is not enabled for it, the energy used by the system while
suspended can be reduced, because the PCIe link of the device will
then go to L1 or L2/L3 Ready.  That's exactly what the $subject patch
does.

Is this still not convincing enough?
