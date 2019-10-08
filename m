Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA663CF600
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfJHJ2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 05:28:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41441 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbfJHJ2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2019 05:28:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id g13so13456005otp.8;
        Tue, 08 Oct 2019 02:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKKY+n0fqxvornYxomfHtDCFFUAFeT4prYVwRJVInPM=;
        b=ckY+zNExIcUC5NBoOi2JKR9eIikARZcuG92gDxOfzx1zts/euVMNQnLPCRrMvePtP+
         BmCK5G3edgMkC4rtHWGidd8P8AIMDxauNtNoEQz1VpcuGsH1FkxWzn/bi+tahuGrYRVU
         HFN8t9qyoVdVm31Byif4xyjoNspGCdO+169HC6WNhkKDxjNO+IIl4SCrGzrKUYBOwzQq
         T/k/KQzonObASrwnHnr9vdw8vw3RUl8EGxp74gW/eFrEIo8rFMHTelUd0uz0xHbpQJM3
         /UT2s0mqzY4krZrk0NtgGP/LQ06PqsK/AbzC+foD0Z4rv/1qoeT+VTIGcZzoicb8nta9
         KPSw==
X-Gm-Message-State: APjAAAXCyXopY+au3ZExm7O6xW+PDMIZe6GGC9S/MogsQeiObdkeXm4d
        RGUrxDOC/6eADp4hYXSl4xwFOtbIcZGEA++2O68=
X-Google-Smtp-Source: APXvYqwQBIjj/f9VAfJwpHSCImUUYHgrpGtnMscXEcYAppVnL05e8hrF/hWaXl6pQAYZTJGneIWYEkNVNtdguXb8Mqg=
X-Received: by 2002:a9d:664:: with SMTP id 91mr3454984otn.189.1570526882896;
 Tue, 08 Oct 2019 02:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <1618955.HVa0YQSOW5@kreacher> <20191007223428.GA72605@google.com>
In-Reply-To: <20191007223428.GA72605@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Oct 2019 11:27:51 +0200
Message-ID: <CAJZ5v0iL4Rv=AQ-Qnma=wWaqBBbOdfRqu9uS9Gesa-G75oQpzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        Linux PCI <linux-pci@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 8, 2019 at 12:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Heiner]
>
> On Thu, Aug 08, 2019 at 11:55:07PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add a function checking whether or not PCIe ASPM has been enabled for
> > a given device.
> >
> > It will be used by the NVMe driver to decide how to handle the
> > device during system suspend.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3:
> >   * Make the new function return bool.
> >   * Change its name back to pcie_aspm_enabled().
> >   * Fix kerneldoc comment formatting.
> >
> > -> v2:
> >   * Move the PCI/PCIe ASPM changes to a separate patch.
> >   * Add the _mask suffix to the new function name.
> >   * Add EXPORT_SYMBOL_GPL() to the new function.
> >   * Avoid adding an unnecessary blank line.
> >
> > ---
> >  drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
> >  include/linux/pci.h     |    3 +++
> >  2 files changed, 23 insertions(+)
> >
> > Index: linux-pm/drivers/pci/pcie/aspm.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pcie/aspm.c
> > +++ linux-pm/drivers/pci/pcie/aspm.c
> > @@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
> >  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
> >       NULL, 0644);
> >
> > +/**
> > + * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
> > + * @pci_device: Target device.
> > + */
> > +bool pcie_aspm_enabled(struct pci_dev *pci_device)
> > +{
> > +     struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> > +     bool ret;
> > +
> > +     if (!bridge)
> > +             return false;
> > +
> > +     mutex_lock(&aspm_lock);
> > +     ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> > +     mutex_unlock(&aspm_lock);
>
> Why do we need to acquire aspm_lock here?  We aren't modifying
> anything, and I don't think we're preventing a race.  If this races
> with another thread that changes aspm_enabled, we'll return either the
> old state or the new one, and I think that's still the case even if we
> don't acquire aspm_lock.

Well, if we can guarantee that pci_remove_bus_device() will never be
called in parallel with this helper, then I agree, but can we
guarantee that?
