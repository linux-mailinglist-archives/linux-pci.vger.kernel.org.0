Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F455477B95
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 19:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhLPSeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 13:34:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:52644 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239842AbhLPSeM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Dec 2021 13:34:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="220246911"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="220246911"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 10:33:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="546088821"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2021 10:33:48 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 16C21580978;
        Thu, 16 Dec 2021 10:33:48 -0800 (PST)
Message-ID: <415f00ef0770e76ce3aabe17cb18b9ba745cc069.camel@linux.intel.com>
Subject: Re: [PATCH V4 1/2] PCI/ASPM: Add ASPM BIOS override function
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 Dec 2021 10:33:47 -0800
In-Reply-To: <20211216170647.GA773917@bhelgaas>
References: <20211216170647.GA773917@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-12-16 at 11:06 -0600, Bjorn Helgaas wrote:
> On Wed, Dec 15, 2021 at 09:55:59PM -0800, David E. Box wrote:
> > From: Michael Bottini <michael.a.bottini@linux.intel.com>
> > 
> > Devices that appear under the Intel VMD host bridge are not visible to BIOS
> > and therefore not programmed by BIOS with ASPM settings. For these devices,
> > it is necessary for the driver to configure ASPM. 
> 
> The VMD-related parts of this commit log belong in the next patch,
> because this patch has nothing in particular to do with VMD.

Okay, but shouldn't something be said here as to why it's needed? Maybe a more general description?

> 
> > Since ASPM settings are adjustable at runtime by module parameter,
> > use the same mechanism to allow drivers to override the default (in
> > this case never configured) BIOS policy to ASPM_STATE_ALL. Then,
> > reconfigure ASPM on the link. Do not override if ASPM control is
> > disabled.
> 
> The module parameter ("policy") has global effect: it runs
> pcie_aspm_set_policy(), which assigns the global "aspm_policy" and
> then reconfigures all links in the system.
> 
> This is not that; it's a link-based thing that doesn't change
> "aspm_policy" and only affects a single link.  This is more like
> aspm_attr_store_common() for the sysfs "l0s_aspm" and similar
> attributes, or the pci_disable_link_state() interface for drivers.

Yes. I'll clean up the wording.

> 
> > Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > V4
> >  - No changes.
> > V3
> >  - Fix missing semicolon in static inline function.
> > 
> > V2
> >  - Change return type to int so caller can determine if override was
> >    successful.
> >  - Return immediately if link is not found so that lock it not
> >    unecessarily taken, suggested by kw@linux.com.
> >  - Don't override if aspm_disabled is true.
> > 
> >  drivers/pci/pci.h       |  2 ++
> >  drivers/pci/pcie/aspm.c | 19 +++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 3d60cabde1a1..c9c55d43cd8a 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -562,11 +562,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
> >  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> >  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> >  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > +int pcie_aspm_policy_override(struct pci_dev *dev);
> >  #else
> >  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> > +static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL; }
> >  #endif
> >  
> >  #ifdef CONFIG_PCIE_ECRC
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 52c74682601a..e2c61e14e724 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1140,6 +1140,25 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
> >  }
> >  EXPORT_SYMBOL(pci_disable_link_state);
> >  
> > +int pcie_aspm_policy_override(struct pci_dev *pdev)
> > +{
> > +       struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> > +
> > +       if (!link || aspm_disabled)
> > +               return -EINVAL;
> > +
> > +       down_read(&pci_bus_sem);
> > +       mutex_lock(&aspm_lock);
> > +       link->aspm_default = ASPM_STATE_ALL;
> > +       pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > +       pcie_set_clkpm(link, policy_to_clkpm_state(link));
> > +       mutex_unlock(&aspm_lock);
> > +       up_read(&pci_bus_sem);
> 
> This is essentially the inverse of pci_disable_link_state().  Why not
> name it so the connection is obvious?  Probably also make the
> signature ("int state") similar.

Indeed it is the inverse. Will implement as pci_enable_link_state().

Thanks.

> 
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(pcie_aspm_policy_override);
> > +
> >  static int pcie_aspm_set_policy(const char *val,
> >                                 const struct kernel_param *kp)
> >  {
> > -- 
> > 2.25.1
> > 


