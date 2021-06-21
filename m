Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D824B3AF528
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhFUSjk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 14:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhFUSjk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 14:39:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A92D56109F;
        Mon, 21 Jun 2021 18:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624300645;
        bh=eTTlwDkeyO67L3bvqEkV/+MwTD0Ip0/Wv5AUnA1irB0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dpgYbklE+Gu7BbGEB+vWxkEh6vJP7kSoxaLN9gbzCKaFYWrzk+s6qJBTy+7ubJZLv
         Omy8HRg6tyTJ0cp/rlfcgO94fO747RrsuSTubk5GcYOCaezkNBx86ZqOtRR8JwgGAA
         pHm4IXh9/vgcM1rNuueJPN39dXsELGPrPnFYGZ0hHAVlFBc+WjUlPYY3McJermwdGC
         hLKPNkdUE3Pk0Ir+AsPeg8VgYx7oeZX2EYcRtgdq+qK7LdlJmxOn+C/elBbWtCxgsz
         9KfbwdPS10/9VjupKZqFRtMnp7FZZgjNUDcY3D2W7ExWH9plXqEBXP9FAoQsjFY8CM
         JvDQoOyMjp0GA==
Date:   Mon, 21 Jun 2021 13:37:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Shanker R Donthineni <sdonthineni@nvidia.com>,
        alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Message-ID: <20210621183724.GA3291108@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210621171518.vs4h4y6ag2benlwp@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 10:45:18PM +0530, Amey Narkhede wrote:
> On 21/06/21 10:02AM, Shanker R Donthineni wrote:
> > On 6/18/21 12:22 PM, Amey Narkhede wrote:
> > > I wonder if this would be easier if dev->reset_methods[] contained
> > > indices into pci_reset_fn_methods[], highest priority first, with the
> > > priority being determined when dev->reset_methods[] is updated.  For
> > > example:
> > >
> > >   const struct pci_reset_fn_method pci_reset_fn_methods[] = {
> > >     { },                                                     # 0
> > >     { &pci_dev_specific_reset, .name = "device_specific" },  # 1
> > >     { &pci_dev_acpi_reset, .name = "acpi" },                 # 2
> > >     { &pcie_reset_flr, .name = "flr" },                      # 3
> > >     { &pci_af_flr, .name = "af_flr" },                       # 4
> > >     { &pci_pm_reset, .name = "pm" },                         # 5
> > >     { &pci_reset_bus_function, .name = "bus" },              # 6
> > >   };
> > >
> > >   dev->reset_methods[] = [1, 2, 3, 4, 5, 6]
> > >     means all reset methods are supported, in the default priority
> > >     order
> > >
> > >   dev->reset_methods[] = [1, 0, 0, 0, 0, 0]
> > >     means only pci_dev_specific_reset is supported
> > >
> > >   dev->reset_methods[] = [3, 5, 0, 0, 0, 0]
> > >     means pcie_reset_flr and pci_pm_reset are supported, in that
> > >     priority order
> >
> > What about keeping two bitmap fields 'resets_supported' and
> > 'resets_enabled' in pci_dev object and mange it through sysfs and
> > probe helper function. We can avoid two loops multiple paces and
> > takes only 2Bytes of memory to keep track resets.
> >
> > resets_supported  ---> initialized during pci_dev setup
> > resets_enabled ---> Exposed to userspace through sysfs by default set to resets_supported
> >
> > include/linux/pci.h:
> > ------------------------
> > /* Different types of PCI resets possible, lower number is higher priority */
> > #define PCI_RESET_METHOD_DEVSPEC     0
> > #define PCI_RESET_METHOD_ACPI            1
> > #define PCI_RESET_METHOD_FLR              2
> > #define PCI_RESET_METHOD_Af_FLR         3
> > #define PCI_RESET_METHOD_PM               4
> > #define PCI_RESET_METHOD_BUS             5
> > #define PCI_RESET_METHOD_MAX            6
> >
> > struct pci_dev {
> >     ...
> >         u8              resets_supported;
> >         u8              resets_enabled;
> > };
> >
> > static inline bool pci_reset_supported(struct pci_dev *dev)
> > {
> >         return !!(dev->resets_supported);
> > }
> >
> >
> > drivers/pci/pci.c:
> > --------------------
> > const struct pci_reset_fn_method pci_reset_fn_methods[PCI_RESET_METHOD_MAX] = {
> >         [PCI_RESET_METHOD_DEVSPEC] = { &pci_dev_specific_reset,
> >                                                                    .name = "device_specific" },
> >         [PCI_RESET_METHOD_ACPI] = { &pci_dev_acpi_reset, .name = "acpi" },
> >         [PCI_RESET_METHOD_FLR] = { &pcie_reset_flr, .name = "flr" },
> >         [PCI_RESET_METHOD_Af_FLR] = { &pci_af_flr, .name = "af_flr" },
> >         [PCI_RESET_METHOD_PM] = { &pci_pm_reset, .name = "pm" },
> >         [PCI_RESET_METHOD_BUS] = { &pci_reset_bus_function, .name = "bus" }
> > };
> >
> >
> > void pci_init_reset_methods(struct pci_dev *dev)
> > {
> >         int i, rc;
> >
> >         BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_RESET_METHOD_MAX);
> >         might_sleep();
> >
> >         for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
> >                 rc = pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_PROBE);
> >                 if (!rc)
> >                         dev->resets_supported |= BIT(i);
> >                 else if (rc != -ENOTTY)
> >                         break;
> >         }
> >         dev->resets_enabled = dev->resets_supported;
> > }
> >
> > int __pci_reset_function_locked(struct pci_dev *dev)
> > {
> >         int i, rc = -ENOTTY;
> >
> >         might_sleep();
> >
> >         for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
> >                 if (dev->resets_enabled & BIT(i)) {
> >                         rc = pci_reset_fn_methods[i].reset_fn(dev, 0);
> >                         if (rc != -ENOTTY)
> >                                 return rc;
> >                 }
> >         }
> >
> >         if (rc == -ENOTTY)
> >                 pci_warn(dev, "No reset happened reason %s\n",
> >                          !!dev->resets_supported ?
> >                          "disabled by user" : "not supported");
> >
> >         return rc;
> > }
> >
> > drivers/pci/pci-sysfs.c
> > ----------------------------
> > static ssize_t reset_method_store(struct device *dev,
> >                                   struct device_attribute *attr,
> >                                   const char *buf, size_t count)
> > {
> >         struct pci_dev *pdev = to_pci_dev(dev);
> >         u8 resets_enabled = 0;
> > ...
> >         if (sysfs_streq(options, "default")) {
> >                 pdev->resets_enabled = pdev->resets_supported;
> >                 goto set_reset_methods;
> >         }
> >
> >         while ((name = strsep(&options, ",")) != NULL) {
> >                 if (sysfs_streq(name, ""))
> >                         continue;
> >                 name = strim(name);
> >
> >                 for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
> >                         if ((pdev->resets_supported & BIT(i)) &&
> >                             sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> >                                 resets_enabled |= BIT(i);
> >                                 break;
> >                         }
> >                 }
> > ...
> >         }
> >
> > set_reset_methods:
> >         kfree(options);
> >         pdev->resets_enabled =  resets_enabled;
> >         return count;
> > }
> >
> > static ssize_t reset_method_show(struct device *dev,
> >                                  struct device_attribute *attr,
> >                                  char *buf)
> > {
> >         struct pci_dev *pdev = to_pci_dev(dev);
> >         ssize_t len = 0;
> >         int i;
> >
> >         for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
> >                 if (pdev->resets_enabled & BIT(i))
> >                         len += sysfs_emit_at(buf, len, "%s%s",
> >                                              len ? "," : "",
> >                                              pci_reset_fn_methods[i].name);
> >         }
> >         len += sysfs_emit_at(buf, len, len ? "\n" : "");
> >
> >         return len;
> > }
> >
> Thank you for the idea.
> Actually that would be coming full circle because Alex, Raphael and
> I tried similar approach earlier while prototyping for v2 but this
> implementation does look better than what I had at that time.

I thought part of the point of this series was to allow the user to
change the *order* of reset types.  I don't think we can control the
ordering if we only keep a bit (or even two) per reset type.
