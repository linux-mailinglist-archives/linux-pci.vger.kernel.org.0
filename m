Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27EA7873A1
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 10:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405239AbfHIIAx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 04:00:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38681 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfHIIAw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 04:00:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so129502271oth.5;
        Fri, 09 Aug 2019 01:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvmuOMegXGyoZoAVbYJEjhJdJHb/HkNFFGNS7y3IwZI=;
        b=tISWeRqNfle2pMQquYdjr3Ccb1Cs3sBx56sfI0jfJq641B+jYE6G/WhPIA7PeN7FMX
         /phxRK4vIhGQxBFwnRxtFILDnDzjUUNZfHajDAwDUUBbIulkhpmAON5uyvH1JXqtXP5i
         Fbc92PcC6w4RgfA6VteFj4kZGR6DrEeMWQtHZZJYQcfVm4wjHFzEwIBtt5Tc8v04NSjK
         5uSWRrN8deJ74d5cvf9Sz44tDPZD7W1GX3U3YqYlzM29WkPHvHgJIAprxTa4JGycTpme
         VTCwN7LdyfoIvD7BXd08MjgxlWc6d3aHwUm7Y61KMkVQWsSjp84vBzVX8UNhrtlsMnmx
         199A==
X-Gm-Message-State: APjAAAUCNWy+Jvj3yCbLfRyNV99GMtcb/NyuZsQIDqzXSSQ4V1WXc1bm
        q2qJzynkFaejIfd4n2bhu1ChrElLYSrCfK9VfVE=
X-Google-Smtp-Source: APXvYqybdxurf5JCgFnVgFRlNNteHx+/jN3ZkSQs93AnC48rBlzxUL09kEEXqLZe0rOCiS9V4aor+P2ybINju+sDcVs=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr17340509otq.262.1565337651853;
 Fri, 09 Aug 2019 01:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain> <2184247.yL3mcj2FRQ@kreacher>
 <1618955.HVa0YQSOW5@kreacher> <20190809045058.GE7302@google.com>
In-Reply-To: <20190809045058.GE7302@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Aug 2019 10:00:41 +0200
Message-ID: <CAJZ5v0jZiKDrq_Mzxf_evbkYYxyEZGgkbn7NRNJX9AepONbABg@mail.gmail.com>
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
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 9, 2019 at 6:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> s|PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()|PCI/ASPM: Add pcie_aspm_enabled()|

Will change.

>
> to match previous history.
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
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

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
>
> The typical name in this file is "pdev".

OK, will change.

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
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
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
> > +bool pcie_aspm_enabled(struct pci_dev *pci_device);
> >  #else
> >  static inline bool pcie_aspm_support_enabled(void) { return false; }
> > +static inline bool pcie_aspm_enabled(struct pci_dev *pci_device)
> > +{ return false; }
> >  #endif
> >
> >  #ifdef CONFIG_PCIEAER
> >
> >
> >
