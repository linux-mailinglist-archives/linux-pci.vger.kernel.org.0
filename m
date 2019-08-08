Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E0867A9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404123AbfHHRHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 13:07:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37232 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404096AbfHHRHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 13:07:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id s20so55968756otp.4;
        Thu, 08 Aug 2019 10:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARqNURKzyY/2pv9kl0jf6GLnPWlYlVLfWEiji5JD+Cw=;
        b=FuoNA2Pu7pxrGd6CMh9laavuH9jTKzi6GN8PcwxKNBB3xqHgP2ZEHkXFPXjqwM2Y0L
         w5Sh9U5JXsoc87ocMygj2s/GVdnmvoqkVmfk2f6GZBIXuk9ZPyAgooePNYhDot7Guabb
         81eEcgCOZ7ixJVGq+rfMAVXwT2lG3cMb67pSchhHtx4yQ8puS23plPRy6whUKb4Cb6bc
         mv+69wFiTLcQ/KVi4KLojvCTYqlk4365qWpP8qbtyX6yo58LyJi6xJi0NCB4CMrOOfT3
         8pSvj8OulyWZxoFtSoCvI9q1vjkw6hgXucPZJzVIFpZt1TMlj+23jzeJB4TxFG6VOPDl
         ixkQ==
X-Gm-Message-State: APjAAAWuxgkhZF1lvKggsskARkiiDME16xRkkAn1P3K6g7Xc3FeygTP5
        oN1NqGPQVuOU65mPQPpjmwYBB9oLJrkO4cvmqxM=
X-Google-Smtp-Source: APXvYqxKQjrWNqdYgtwv6uf02uNQamTdoSoBuHKNMXECbC/m2b9pI1UYwInAJhCmYRrXvoGGIyRPFzVsb7d/7r10wWc=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr3044755oig.115.1565284029519;
 Thu, 08 Aug 2019 10:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain> <1921165.pTveHRX1Co@kreacher>
 <1870928.r7tBYyfqdz@kreacher> <20190808134356.GF151852@google.com> <CAJZ5v0h=nz8yXwOOGBUB9m1GtJPOqBwtNK7zXPNMJjzPhMWd9w@mail.gmail.com>
In-Reply-To: <CAJZ5v0h=nz8yXwOOGBUB9m1GtJPOqBwtNK7zXPNMJjzPhMWd9w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Aug 2019 19:06:58 +0200
Message-ID: <CAJZ5v0jJBceekiOmBUJsAJZRkLYgzuUjoNBpdO_uBoh0RY7EmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-nvme <linux-nvme@lists.infradead.org>,
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

On Thu, Aug 8, 2019 at 4:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Aug 8, 2019 at 3:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Aug 08, 2019 at 12:10:06PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
> > > host managed power state for suspend") was adding a pci_save_state()
> > > call to nvme_suspend() in order to prevent the PCI bus-level PM from
> > > being applied to the suspended NVMe devices, but if ASPM is not
> > > enabled for the target NVMe device, that causes its PCIe link to stay
> > > up and the platform may not be able to get into its optimum low-power
> > > state because of that.
> > >
> > > For example, if ASPM is disabled for the NVMe drive (PC401 NVMe SK
> > > hynix 256GB) in my Dell XPS13 9380, leaving it in D0 during
> > > suspend-to-idle prevents the SoC from reaching package idle states
> > > deeper than PC3, which is way insufficient for system suspend.
> >
> > Just curious: I assume the SoC you reference is some part of the NVMe
> > drive?
>
> No, the SoC is what contains the Intel processor and PCH (formerly "chipset").
>
> > > To address this shortcoming, make nvme_suspend() check if ASPM is
> > > enabled for the target device and fall back to full device shutdown
> > > and PCI bus-level PM if that is not the case.
> > >
> > > Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> > > Link: https://lore.kernel.org/linux-pm/2763495.NmdaWeg79L@kreacher/T/#t
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > -> v2:
> > >   * Move the PCI/PCIe ASPM changes to a separate patch.
> > >   * Do not add a redundant ndev->last_ps == U32_MAX check in nvme_suspend().
> > >
> > > ---
> > >  drivers/nvme/host/pci.c |   13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > >
> > > Index: linux-pm/drivers/nvme/host/pci.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/nvme/host/pci.c
> > > +++ linux-pm/drivers/nvme/host/pci.c
> > > @@ -2846,7 +2846,7 @@ static int nvme_resume(struct device *de
> > >       struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
> > >       struct nvme_ctrl *ctrl = &ndev->ctrl;
> > >
> > > -     if (pm_resume_via_firmware() || !ctrl->npss ||
> > > +     if (ndev->last_ps == U32_MAX ||
> > >           nvme_set_power_state(ctrl, ndev->last_ps) != 0)
> > >               nvme_reset_ctrl(ctrl);
> > >       return 0;
> > > @@ -2859,6 +2859,8 @@ static int nvme_suspend(struct device *d
> > >       struct nvme_ctrl *ctrl = &ndev->ctrl;
> > >       int ret = -EBUSY;
> > >
> > > +     ndev->last_ps = U32_MAX;
> > > +
> > >       /*
> > >        * The platform does not remove power for a kernel managed suspend so
> > >        * use host managed nvme power settings for lowest idle power if
> > > @@ -2866,8 +2868,14 @@ static int nvme_suspend(struct device *d
> > >        * shutdown.  But if the firmware is involved after the suspend or the
> > >        * device does not support any non-default power states, shut down the
> > >        * device fully.
> > > +      *
> > > +      * If ASPM is not enabled for the device, shut down the device and allow
> > > +      * the PCI bus layer to put it into D3 in order to take the PCIe link
> > > +      * down, so as to allow the platform to achieve its minimum low-power
> > > +      * state (which may not be possible if the link is up).
> > >        */
> > > -     if (pm_suspend_via_firmware() || !ctrl->npss) {
> > > +     if (pm_suspend_via_firmware() || !ctrl->npss ||
> > > +         !pcie_aspm_enabled_mask(pdev)) {
> >
> > This seems like a layering violation, in the sense that ASPM is
> > supposed to be hardware-autonomous and invisible to software.
>
> But software has to enable it.
>
> If it is not enabled, it will not be used, and that's what the check is about.
>
> > IIUC the NVMe device will go to the desired package idle state if the
> > link is in L0s or L1, but not if the link is in L0.  I don't
> > understand that connection; AFAIK that would be something outside the
> > scope of the PCIe spec.
>
> Yes, it is outside of the PCIe spec.
>
> No, this is not about the NVMe device, it is about the Intel SoC
> (System-on-a-Chip) the platform is based on.
>
> The background really is commit d916b1be94b6 and its changelog is kind
> of misleading, unfortunately.  What it did, among other things, was to
> cause the NVMe driver to prevent the PCI bus type from applying the
> standard PCI PM to the devices handled by it in the suspend-to-idle
> flow.  The reason for doing that was a (reportedly) widespread failure
> to take the PCIe link down during D0 -> D3hot transitions of NVMe
> devices, which then prevented the platform from going into a deep
> enough low-power state while suspended (because it was not sure
> whether or not the NVMe device was really "sufficiently" inactive).
> [I guess I should mention that in the changelog of the $subject
> patch.]  So the idea was to put the (NVMe) device into a low-power
> state internally and then let ASPM take care of the PCIe link.
>
> Of course, that can only work if ASPM is enabled at all for the device
> in question, even though it may not be sufficient as you say below.
>
> > The spec (PCIe r5.0, sec 5.4.1.1.1 for L0s, 5.4.1.2.1 for L1) is
> > careful to say that when the conditions are right, devices "should"
> > enter L0s but it is never mandatory, or "may" enter L1.
> >
> > And this patch assumes that if ASPM is enabled, the link will
> > eventually go to L0s or L1.
>
> No, it doesn't.
>
> It avoids failure in the case in which it is guaranteed to happen
> (disabled ASPM) and that's it.

IOW, after commit d916b1be94b6 and without this patch, nvme_suspend()
*always* assumes ASPM to take the device's PCIe link down, which
obviously is not going to happen if ASPM is disabled for that device.

The rationale for this patch is to avoid the obvious failure.
