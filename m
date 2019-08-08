Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C69864BF
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 16:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfHHOsy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 10:48:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34677 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHOsy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 10:48:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so119696164otk.1;
        Thu, 08 Aug 2019 07:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caUqW1nXomqfVjusrC+uUr1xTT4+ugnM/o3XPle10NY=;
        b=ksyizlDcCANIKVUS2Fgd3BDld0JD1QLn1UZD/2myPheJOf/f25ExGCRgf+fJkkdCmx
         JwLIAP21TVDeJeFS69UP/8vhepAVCerS8m3Q3L/tqLoA0cTGU5YLGpbB+BcuRoJGTN83
         wAT1dG317vwuZNvf3S62wh5sbh5dCuMfi8RtW+I/omaodw5yvQ3EjVgPFhMcsJYhDaa6
         /nol+aGX3y3ZysHrKrWY3nmLT2yqsiTceq5p++6mfUg5B8QYY9+PXuvN0SOiCa2eN7Ny
         f6/3tTK86bQg7paPe013i5v7Qx2APsJ+GCfdsXIrkgxzRho2VAI1+2DykEQDEil3Y389
         ux+w==
X-Gm-Message-State: APjAAAX6UAmMpv32OEJjR8VmH9QSB0YnleXZBd5yq+mJHsjbsvBvO9mx
        HKxq9WAgLBE++UlI4dVqEa+e251ob3NmMfUPiJA=
X-Google-Smtp-Source: APXvYqzwi1A/BvfGLyfn7w7S85oFN2mOEJoA3/6P3esAa5V9Bgq00NAFIeHcYu1B5uIbd0r9EO1m9doSsXNbCAXyztM=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr2617816oig.115.1565275733346;
 Thu, 08 Aug 2019 07:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain> <1921165.pTveHRX1Co@kreacher>
 <3714448.mG7dE8Q3Fs@kreacher> <20190808131536.GE151852@google.com>
In-Reply-To: <20190808131536.GE151852@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Aug 2019 16:48:42 +0200
Message-ID: <CAJZ5v0gMzVYdC-xZYLWYmBZ-a3-R8LND=11YJFCXdzrtyyZW=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled_mask()
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
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 8, 2019 at 3:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Aug 08, 2019 at 12:06:52PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add a function returning the mask of currently enabled ASPM link
> > states for a given device.
> >
> > It will be used by the NVMe driver to decide how to handle the
> > device during system suspend.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
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
> > +/*
> > + * pcie_aspm_enabled_mask - Return the mask of enabled ASPM link states.
> > + * @pci_device: Target device.
> > + */
> > +u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device)
> > +{
> > +     struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> > +     u32 ret;
> > +
> > +     if (!bridge)
> > +             return 0;
> > +
> > +     mutex_lock(&aspm_lock);
> > +     ret = bridge->link_state ? bridge->link_state->aspm_enabled : 0;
>
> This returns the "aspm_enabled" mask, but the values of that mask are
> combinations of:
>
>   ASPM_STATE_L0S_UP
>   ASPM_STATE_L0S_DW
>   ASPM_STATE_L1
>   ...
>
> which are defined internally in drivers/pci/pcie/aspm.c and not
> visible to the caller of pcie_aspm_enabled_mask().  If there's no need
> for the actual mask (the current caller doesn't seem to use it), maybe
> this could be a boolean?

Yes, it can be a boolean.

>
> > +     mutex_unlock(&aspm_lock);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pcie_aspm_enabled_mask);
> > +
> >  #ifdef CONFIG_PCIEASPM_DEBUG
> >  static ssize_t link_state_show(struct device *dev,
> >               struct device_attribute *attr,
> > Index: linux-pm/include/linux/pci.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/pci.h
> > +++ linux-pm/include/linux/pci.h
> > @@ -1567,8 +1567,11 @@ extern bool pcie_ports_native;
> >
> >  #ifdef CONFIG_PCIEASPM
> >  bool pcie_aspm_support_enabled(void);
> > +u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device);
> >  #else
> >  static inline bool pcie_aspm_support_enabled(void) { return false; }
> > +static inline u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device)
> > +{ return 0; }
> >  #endif
> >
> >  #ifdef CONFIG_PCIEAER
> >
> >
> >
