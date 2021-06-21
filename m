Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E113AF1BA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFURRh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFURRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 13:17:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FCDC061756;
        Mon, 21 Jun 2021 10:15:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x22so7399281pll.11;
        Mon, 21 Jun 2021 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vLkEnphqch5/WsWN5BRAkVt/dJhdo5e4NycFb+xafoc=;
        b=Zr9qeffP4/VadNftyoFyjTDDcmPPnrndlfggU4nx8o9YhRmuqQvaulEHfFoowz3pfh
         67XtAU2P/g73012xgRX+nSi2Fd2nh/lWpzsC2LpzGnVD8TA7GV1el6LySVB3uUfnK4kU
         Xd8Yplh59MRnpU5b+obQne9STok8tDIe+2rOJ4lRAoEkt/Vu0b3IfqXXnZmb/VT+kE2o
         dpR0/Uc9lyvCTnOPyLg29ph89hcL8tdpQOE2m8MCcCWMl6KeZvMM+Kk2jNkY3EOyyuy5
         5f31931GmksXnzW03/qoLb9K+fli/kMAnG0pnytbFOXGJBvB5XxdhhrsTzPlz89AQ+6p
         uI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vLkEnphqch5/WsWN5BRAkVt/dJhdo5e4NycFb+xafoc=;
        b=Ts/NZ37xpQ5VRvk///krST4Lab4mtHUYrjEoXlgDByP5/0A8fOpvO1iXSuSmhSf230
         4/AYxkxy3NJ/GI2Us1SCyIs8XeUs9XKqqY07UsJNf6Ws+/1s3fDuE+bnoxW0VFVXAwWb
         Zek0nYB0JWtS8JJcXBe1XWNga0XXQfib8XWnvfJWP6MbVZK28dnj+h6GtgyF6GGKIidm
         UVKeHwf3ialyTgQwMUTi1U7xZlvmJhOviSt9jCD4k2uECdiR3sIhrHd6jjlkZTdZbEMU
         p5hLXY5bHTCQlsEQaihOQy2MZ1qYYkZ3lGHZW4j6denzQdStSowlyXE6ya+YUmlUL/NS
         O8cQ==
X-Gm-Message-State: AOAM532tfNAOErAiSs7BLDdyd9IHepjfY7DirSWj3/b/lYnRMwPHLnu4
        3pE1NqaB5+UHm98tCJFD/hs=
X-Google-Smtp-Source: ABdhPJwvOIA9ogwRcnjSdum17wLFfB+m+5aYA6iAJBPiIuAoSStO88zQf6F3E183cvxrYGY7p0CCkA==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr28166990pju.31.1624295721539;
        Mon, 21 Jun 2021 10:15:21 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id i20sm900484pfo.130.2021.06.21.10.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:15:21 -0700 (PDT)
Date:   Mon, 21 Jun 2021 22:45:18 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Message-ID: <20210621171518.vs4h4y6ag2benlwp@archlinux>
References: <20210608054857.18963-3-ameynarkhede03@gmail.com>
 <20210617231305.GA3139128@bjorn-Precision-5520>
 <20210618172242.vs3qwimjpcicb4m4@archlinux>
 <1fb0a184-908c-5f98-ef6d-74edc602c2e0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fb0a184-908c-5f98-ef6d-74edc602c2e0@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/21 10:02AM, Shanker R Donthineni wrote:
> Hi Bjorn,
>
> On 6/18/21 12:22 PM, Amey Narkhede wrote:
> > I wonder if this would be easier if dev->reset_methods[] contained
> > indices into pci_reset_fn_methods[], highest priority first, with the
> > priority being determined when dev->reset_methods[] is updated.  For
> > example:
> >
> >   const struct pci_reset_fn_method pci_reset_fn_methods[] = {
> >     { },                                                     # 0
> >     { &pci_dev_specific_reset, .name = "device_specific" },  # 1
> >     { &pci_dev_acpi_reset, .name = "acpi" },                 # 2
> >     { &pcie_reset_flr, .name = "flr" },                      # 3
> >     { &pci_af_flr, .name = "af_flr" },                       # 4
> >     { &pci_pm_reset, .name = "pm" },                         # 5
> >     { &pci_reset_bus_function, .name = "bus" },              # 6
> >   };
> >
> >   dev->reset_methods[] = [1, 2, 3, 4, 5, 6]
> >     means all reset methods are supported, in the default priority
> >     order
> >
> >   dev->reset_methods[] = [1, 0, 0, 0, 0, 0]
> >     means only pci_dev_specific_reset is supported
> >
> >   dev->reset_methods[] = [3, 5, 0, 0, 0, 0]
> >     means pcie_reset_flr and pci_pm_reset are supported, in that
> >     priority order
> What about keeping two bitmap fields 'resets_supported' and 'resets_enabled' in
> pci_dev object and mange it through sysfs and probe helper function. We can avoid
> two loops multiple paces and takes only 2Bytes of memory to keep track resets.
>
> resets_supported  ---> initialized during pci_dev setup
> resets_enabled ---> Exposed to userspace through sysfs by default set to resets_supported
>
> include/linux/pci.h:
> ------------------------
> /* Different types of PCI resets possible, lower number is higher priority */
> #define PCI_RESET_METHOD_DEVSPEC     0
> #define PCI_RESET_METHOD_ACPI            1
> #define PCI_RESET_METHOD_FLR              2
> #define PCI_RESET_METHOD_Af_FLR         3
> #define PCI_RESET_METHOD_PM               4
> #define PCI_RESET_METHOD_BUS             5
> #define PCI_RESET_METHOD_MAX            6
>
> struct pci_dev {
>     ...
>         u8              resets_supported;
>         u8              resets_enabled;
> };
>
> static inline bool pci_reset_supported(struct pci_dev *dev)
> {
>         return !!(dev->resets_supported);
> }
>
>
> drivers/pci/pci.c:
> --------------------
> const struct pci_reset_fn_method pci_reset_fn_methods[PCI_RESET_METHOD_MAX] = {
>         [PCI_RESET_METHOD_DEVSPEC] = { &pci_dev_specific_reset,
>                                                                    .name = "device_specific" },
>         [PCI_RESET_METHOD_ACPI] = { &pci_dev_acpi_reset, .name = "acpi" },
>         [PCI_RESET_METHOD_FLR] = { &pcie_reset_flr, .name = "flr" },
>         [PCI_RESET_METHOD_Af_FLR] = { &pci_af_flr, .name = "af_flr" },
>         [PCI_RESET_METHOD_PM] = { &pci_pm_reset, .name = "pm" },
>         [PCI_RESET_METHOD_BUS] = { &pci_reset_bus_function, .name = "bus" }
> };
>
>
> void pci_init_reset_methods(struct pci_dev *dev)
> {
>         int i, rc;
>
>         BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_RESET_METHOD_MAX);
>         might_sleep();
>
>         for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
>                 rc = pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_PROBE);
>                 if (!rc)
>                         dev->resets_supported |= BIT(i);
>                 else if (rc != -ENOTTY)
>                         break;
>         }
>         dev->resets_enabled = dev->resets_supported;
> }
>
> int __pci_reset_function_locked(struct pci_dev *dev)
> {
>         int i, rc = -ENOTTY;
>
>         might_sleep();
>
>         for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
>                 if (dev->resets_enabled & BIT(i)) {
>                         rc = pci_reset_fn_methods[i].reset_fn(dev, 0);
>                         if (rc != -ENOTTY)
>                                 return rc;
>                 }
>         }
>
>         if (rc == -ENOTTY)
>                 pci_warn(dev, "No reset happened reason %s\n",
>                          !!dev->resets_supported ?
>                          "disabled by user" : "not supported");
>
>         return rc;
> }
>
> drivers/pci/pci-sysfs.c
> ----------------------------
> static ssize_t reset_method_store(struct device *dev,
>                                   struct device_attribute *attr,
>                                   const char *buf, size_t count)
> {
>         struct pci_dev *pdev = to_pci_dev(dev);
>         u8 resets_enabled = 0;
> ...
>         if (sysfs_streq(options, "default")) {
>                 pdev->resets_enabled = pdev->resets_supported;
>                 goto set_reset_methods;
>         }
>
>         while ((name = strsep(&options, ",")) != NULL) {
>                 if (sysfs_streq(name, ""))
>                         continue;
>                 name = strim(name);
>
>                 for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
>                         if ((pdev->resets_supported & BIT(i)) &&
>                             sysfs_streq(name, pci_reset_fn_methods[i].name)) {
>                                 resets_enabled |= BIT(i);
>                                 break;
>                         }
>                 }
> ...
>         }
>
> set_reset_methods:
>         kfree(options);
>         pdev->resets_enabled =  resets_enabled;
>         return count;
> }
>
> static ssize_t reset_method_show(struct device *dev,
>                                  struct device_attribute *attr,
>                                  char *buf)
> {
>         struct pci_dev *pdev = to_pci_dev(dev);
>         ssize_t len = 0;
>         int i;
>
>         for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
>                 if (pdev->resets_enabled & BIT(i))
>                         len += sysfs_emit_at(buf, len, "%s%s",
>                                              len ? "," : "",
>                                              pci_reset_fn_methods[i].name);
>         }
>         len += sysfs_emit_at(buf, len, len ? "\n" : "");
>
>         return len;
> }
>
Thank you for the idea.
Actually that would be coming full circle because Alex, Raphael and I
tried similar approach earlier while prototyping for v2 but this implementation
does look better than what I had at that time.

Thanks,
Amey
