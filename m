Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14B33FA176
	for <lists+linux-pci@lfdr.de>; Sat, 28 Aug 2021 00:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhH0WYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 18:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbhH0WYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 18:24:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CC8660E78;
        Fri, 27 Aug 2021 22:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630103012;
        bh=UMUKr8u8fx/iC1KAPAlncCS7IABNiA/dxBeiQorFB5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GaB/0PGzWA7ST1sci4uPKHrhuSFZuuzusci9d4P9oJLAGeyMcVNyzQZ1i2aNSTc3b
         dLCXRe8YKHgvSChtCO4IBOqAIlOz5GLyEUiWyXvBMbGxoo0Se3RIoQsHeb+19HUHgm
         9OiIO6bWm62pywpv9K1ixMAYqf5c/+Vq6sz9oKOv2tHL6yVuI3rdRARo11cLGS2N9h
         1FQ877P3xNjaqbDWn0m8NwX9Vmj6hLxJvyYtnJE7fR1YP00ycbHjAXasNxdFEEGvk3
         vMtSGEFZgXfKQuMbu/2TRM/ZcavsK2rEqdMTCVtWXYD/DwNwr2rRbRbYsMMf3XLtve
         YoWy1s1WcvhYg==
Date:   Fri, 27 Aug 2021 17:23:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/sysfs: Add pci_dev_resource_attr_is_visible()
 helper
Message-ID: <20210827222331.GA3896976@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YSjWWWVC6ImWA5Qe@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 27, 2021 at 02:11:05PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 26, 2021 at 06:35:34PM -0500, Bjorn Helgaas wrote:
> > [+cc Greg, sorry for the ill-formed sysfs question below]
> > 
> > On Wed, Aug 25, 2021 at 09:22:52PM +0000, Krzysztof Wilczyński wrote:
> > > This helper aims to replace functions pci_create_resource_files() and
> > > pci_create_attr() that are currently involved in the PCI resource sysfs
> > > objects dynamic creation and set up once the.
> > > 
> > > After the conversion to use static sysfs objects when exposing the PCI
> > > BAR address space this helper is to be called from the .is_bin_visible()
> > > callback for each of the PCI resources attributes.
> > > 
> > > Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> > > ---
> > >  drivers/pci/pci-sysfs.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index b70f61fbcd4b..c94ab9830932 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -1237,6 +1237,46 @@ static int pci_create_resource_files(struct pci_dev *pdev)
> > >  	}
> > >  	return 0;
> > >  }
> > > +
> > > +static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
> > > +						struct bin_attribute *attr,
> > > +						int bar, bool write_combine)
> > > +{
> > > +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> > > +	resource_size_t resource_size = pci_resource_len(pdev, bar);
> > > +	unsigned long flags = pci_resource_flags(pdev, bar);
> > > +
> > > +	if (!resource_size)
> > > +		return 0;
> > > +
> > > +	if (write_combine) {
> > > +		if (arch_can_pci_mmap_wc() && (flags &
> > > +		    (IORESOURCE_MEM | IORESOURCE_PREFETCH)) ==
> > > +			(IORESOURCE_MEM | IORESOURCE_PREFETCH))
> > > +			attr->mmap = pci_mmap_resource_wc;
> > 
> > Is it legal to update attr here in an .is_visible() method?  Is attr
> > the single static struct bin_attribute here, or is it a per-device
> > copy?
> 
> It is whatever was registered with sysfs, that was up to the caller.
> 
> > I'm assuming the static bin_attribute is a template and when we add a
> > device that uses it, we alloc a new copy so each device has its own
> > size, mapping function, etc.
> 
> Not that I recall, I think it's just a pointer to the structure that the
> driver passed to the sysfs code.
> 
> > If that's the case, we only want to update the *copy*, not the
> > template.  I don't see an alloc before the call in create_files(),
> > so I'm worried that this .is_visible() method might get the template,
> > in which case we'd be updating ->mmap for *all* devices.
> 
> Yes, I think that is what you are doing here.
> 
> Generally, don't mess with attribute values in the is_visible callback
> if at all possible, as that's not what the callback is for.

Unfortunately I can't find any documentation about what the
.is_visible() callback is for and what the restrictions on it are.

I *did* figure out that bin_attribute.size is updated by some
.is_bin_visible() callbacks, e.g., pci_dev_config_attr_is_visible()
and pci_dev_rom_attr_is_visible().  These are static attributes, so
there's a single copy per system, but that size gets copied to the
inode eventually, so it ends up being per-sysfs file.

This is all done inside device_add(), which means there should be some
mutex so the .is_bin_visible() "size" updates to that single static
attribute inside concurrent device_add() calls don't stomp on each
other.

I could have missed it, but I don't see that mutex, which makes me
suspect we rely on the bus driver to serialize device_add() calls.

Maybe there's nothing to be done here, except that we need to do some
more work to figure out how to fix the "sysfs_initialized" ugliness in
pci_sysfs_init().

Here are the details of the single static attribute and the
device_add() path I mentioned above:

  pci_dev_config_attr_is_visible(..., struct bin_attribute *a, ...)
  {
    a->size = PCI_CFG_SPACE_SIZE;    # <-- set size in global attr
    ...
  }

  static struct bin_attribute *pci_dev_config_attrs[] = {
    &bin_attr_config, NULL,
  };
  static const struct attribute_group pci_dev_config_attr_group = {
    .bin_attrs = pci_dev_config_attrs,
    .is_bin_visible = pci_dev_config_attr_is_visible,
  };

  pci_device_add
    device_add
      device_add_attrs
        device_add_groups
          sysfs_create_groups
            internal_create_groups
              internal_create_group
                create_files
                  grp->is_bin_visible()
                  sysfs_add_file_mode_ns
                    size = battr->size      # <-- copy size from attr
                    __kernfs_create_file(..., size, ...)
                      kernfs_new_node
                        __kernfs_new_node

