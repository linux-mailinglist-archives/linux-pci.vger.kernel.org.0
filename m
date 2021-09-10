Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C87406F40
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhIJQOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 12:14:07 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:50703 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhIJQN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 12:13:29 -0400
Received: by mail-wm1-f47.google.com with SMTP id m2so1612436wmm.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 09:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1lu1w8OFikc7s5G+s5eBhCJefd8/Nk2KFr2XWwwe3c=;
        b=OhFs38dCsZmA8Ngj2IhZl2pkUZaTjJKizpsj+eex46KsmtZc65ngMAGNYuHMrfhevq
         TMv0qtmP9wH/yEavDif3YWH3xiqFY3h4iWBNZ96i69kuk/kqohsMy5lgWl7blw9pUv0h
         uT1cf5a1h53D2hwXBMcj9zYkF1mStaQsnO0M/Q6oTkHuqtUfL2zX8tWByT7L2+LZNBiQ
         GrnSFP76Q2ViMuaz1W0xGxedkzipYvpnMm7f0IRj4VLI6lOad856DHXPgym+FROuokT9
         oOxEWEKnR1Mr4Bx3hlULnHPLXLClYGew0btIpLGC8J51DqOHs6GYfqUNWk6rtWjtAF00
         /D9Q==
X-Gm-Message-State: AOAM533IOfpvXZ93hu8hk5JWzdJbOyj6y6NCE4lg8jopbBC+eUQhWeUh
        n66eWJW42zC/kQ2NyZLnq8Y=
X-Google-Smtp-Source: ABdhPJwqsMi1C/UTrXUI2F+2sISfGJMqsnL28oXN3shQMkv7BpGoZRfgcEMNk9E6xqCREUo4nVBJPA==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr9028876wmh.114.1631290337237;
        Fri, 10 Sep 2021 09:12:17 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z19sm5306658wma.0.2021.09.10.09.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:12:16 -0700 (PDT)
Date:   Fri, 10 Sep 2021 18:12:15 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/sysfs: Add pci_dev_resource_attr_is_visible()
 helper
Message-ID: <20210910161215.GA1310191@rocinante>
References: <YSjWWWVC6ImWA5Qe@kroah.com>
 <20210827222331.GA3896976@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210827222331.GA3896976@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn and Greg,

Thank you both for adding more details here!

[...]
> > > > +	if (write_combine) {
> > > > +		if (arch_can_pci_mmap_wc() && (flags &
> > > > +		    (IORESOURCE_MEM | IORESOURCE_PREFETCH)) ==
> > > > +			(IORESOURCE_MEM | IORESOURCE_PREFETCH))
> > > > +			attr->mmap = pci_mmap_resource_wc;
> > > 
> > > Is it legal to update attr here in an .is_visible() method?  Is attr
> > > the single static struct bin_attribute here, or is it a per-device
> > > copy?
> > 
> > It is whatever was registered with sysfs, that was up to the caller.
> > 
> > > I'm assuming the static bin_attribute is a template and when we add a
> > > device that uses it, we alloc a new copy so each device has its own
> > > size, mapping function, etc.
> > 
> > Not that I recall, I think it's just a pointer to the structure that the
> > driver passed to the sysfs code.
> > 
> > > If that's the case, we only want to update the *copy*, not the
> > > template.  I don't see an alloc before the call in create_files(),
> > > so I'm worried that this .is_visible() method might get the template,
> > > in which case we'd be updating ->mmap for *all* devices.
> > 
> > Yes, I think that is what you are doing here.
> > 
> > Generally, don't mess with attribute values in the is_visible callback
> > if at all possible, as that's not what the callback is for.
> 
> Unfortunately I can't find any documentation about what the
> .is_visible() callback is for and what the restrictions on it are.
> 
> I *did* figure out that bin_attribute.size is updated by some
> .is_bin_visible() callbacks, e.g., pci_dev_config_attr_is_visible()
> and pci_dev_rom_attr_is_visible().  These are static attributes, so
> there's a single copy per system, but that size gets copied to the
> inode eventually, so it ends up being per-sysfs file.
> 
> This is all done inside device_add(), which means there should be some
> mutex so the .is_bin_visible() "size" updates to that single static
> attribute inside concurrent device_add() calls don't stomp on each
> other.
> 
> I could have missed it, but I don't see that mutex, which makes me
> suspect we rely on the bus driver to serialize device_add() calls.
> 
> Maybe there's nothing to be done here, except that we need to do some
> more work to figure out how to fix the "sysfs_initialized" ugliness in
> pci_sysfs_init().
> 
> Here are the details of the single static attribute and the
> device_add() path I mentioned above:
> 
>   pci_dev_config_attr_is_visible(..., struct bin_attribute *a, ...)
>   {
>     a->size = PCI_CFG_SPACE_SIZE;    # <-- set size in global attr
>     ...
>   }
> 
>   static struct bin_attribute *pci_dev_config_attrs[] = {
>     &bin_attr_config, NULL,
>   };
>   static const struct attribute_group pci_dev_config_attr_group = {
>     .bin_attrs = pci_dev_config_attrs,
>     .is_bin_visible = pci_dev_config_attr_is_visible,
>   };
> 
>   pci_device_add
>     device_add
>       device_add_attrs
>         device_add_groups
>           sysfs_create_groups
>             internal_create_groups
>               internal_create_group
>                 create_files
>                   grp->is_bin_visible()
>                   sysfs_add_file_mode_ns
>                     size = battr->size      # <-- copy size from attr
>                     __kernfs_create_file(..., size, ...)
>                       kernfs_new_node
>                         __kernfs_new_node

To add more to what Bjorn is talking about here, primarily for posterity as
perhaps someone else might stumble into the same thing we did, a few log
lines illustrating the attribute reuse:

   1 pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
   2 pci 0000:00:01.0: [8086:10d3] type 00 class 0x020000
   3 pci 0000:00:01.0: reg 0x10: [mem 0xfeb80000-0xfeb9ffff]
   4 pci 0000:00:01.0: reg 0x14: [mem 0xfeba0000-0xfebbffff]
   5 pci 0000:00:01.0: reg 0x18: [io  0xc040-0xc05f]
   6 pci 0000:00:01.0: reg 0x1c: [mem 0xfebc0000-0xfebc3fff]
   7 pci 0000:00:01.0: reg 0x30: [mem 0xfeb00000-0xfeb7ffff pref]
   8 pdev @ ffff8880032fd800, bar 0 131072 @ ffff8880032fdb98 [mem 0xfeb80000-0xfeb9ffff], kobject @ ffff8880032fd8c0, attr resource0 @ ffffffff825b2ee0
   9 pdev @ ffff8880032fd800, bar 1 131072 @ ffff8880032fdbd8 [mem 0xfeba0000-0xfebbffff], kobject @ ffff8880032fd8c0, attr resource1 @ ffffffff825b2e20
  10 pdev @ ffff8880032fd800, bar 2 32 @ ffff8880032fdc18 [io  0xc040-0xc05f], kobject @ ffff8880032fd8c0, attr resource2 @ ffffffff825b2d60
  11 pdev @ ffff8880032fd800, bar 3 16384 @ ffff8880032fdc58 [mem 0xfebc0000-0xfebc3fff], kobject @ ffff8880032fd8c0, attr resource3 @ ffffffff825b2ca0
  12 pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100
  13 pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
  14 pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
  15 pci 0000:00:1f.2: reg 0x20: [io  0xc060-0xc07f]
  16 pci 0000:00:1f.2: reg 0x24: [mem 0xfebc4000-0xfebc4fff]
  17 pdev @ ffff8880032fe800, bar 4 32 @ ffff8880032fec98 [io  0xc060-0xc07f], kobject @ ffff8880032fe8c0, attr resource4 @ ffffffff825b2be0
  18 pdev @ ffff8880032fe800, bar 5 4096 @ ffff8880032fecd8 [mem 0xfebc4000-0xfebc4fff], kobject @ ffff8880032fe8c0, attr resource5 @ ffffffff825b2b20
  19 pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
  20 pci 0000:00:1f.3: reg 0x20: [io  0x0700-0x073f]
  21 pdev @ ffff8880032ff000, bar 4 64 @ ffff8880032ff498 [io  0x0700-0x073f], kobject @ ffff8880032ff0c0, attr resource4 @ ffffffff825b2be0

A close look at lines #17 and #21 tells us that .is_bin_visible() is being
called on the static bin_attribute (those are 00:1f.2 BAR 4 and 00:1f.3 BAR 4)
and it would get a pointer to the same bin_attribute.

	Krzysztof
