Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA72241BB11
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 01:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbhI1XjE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 19:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243302AbhI1XjE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 19:39:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C42996137A;
        Tue, 28 Sep 2021 23:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632872244;
        bh=QVz9TS6fN5Lu3ZMboqlRBGqyZ37OariEqwrf+NlAd0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q8vvG/VTLjz+wkPfyKxRpBn9tB521oXhQlfQZ1sxsEI/eUwWJQnUHuaDqLcdx6lup
         bEY3azlP8zEIgMXdD7/RLYg3MOtk6xbkw0ILrqKvBpCG4D2OK4MyN91p17q3moBlt5
         9x/Bl/QCi3AQMDMkQqIl1HrLxJPvN7S26h2fISZbd7ARO+nfgcmkRZgKiiqA9SxaN8
         vLsWdCEufLwFIx81ce4ht/SwZI5BRAeTKqwj7PoBbDcrIjLmmtERybuNk9fvgboFhr
         TpQQ29craoS7VpaVAAJK5SKF3940BM3Dd/DY+YjmkBjzf4uryWN9WsHr0fO4q7AshQ
         8eK3bbrZxixLw==
Date:   Tue, 28 Sep 2021 18:37:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?utf-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: add write attribute for boot_vga
Message-ID: <20210928233721.GA748816@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70a472b8-7a3e-1792-efe4-125584231824@kylinos.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 27, 2021 at 11:45:59AM +0800, 李真能 wrote:
> 
> 在 2021/9/27 上午4:20, Bjorn Helgaas 写道:
> > On Sun, Sep 26, 2021 at 03:15:39PM +0800, Zhenneng Li wrote:
> > > Add writing attribute for boot_vga sys node,
> > > so we can config default video display
> > > output dynamically when there are two video
> > > cards on a machine.
> > > 
> > > Xorg server will determine running on which
> > > video card based on boot_vga node's value.
> > When you repost this, please take a look at the git commit log history
> > and make yours similar.  Specifically, the subject should start with a
> > capital letter, and the body should be rewrapped to fill 75
> > characters.
> > 
> > Please contrast this with the existing VGA arbiter.  See
> > Documentation/gpu/vgaarbiter.rst.  It sounds like this may overlap
> > with the VGA arbiter functionality, so this should explain why we need
> > both and how they interact.
> 
> "Some "legacy" VGA devices implemented on PCI typically have the same
> hard-decoded addresses as they did on ISA. When multiple PCI devices are
> accessed at same time they need some kind of coordination. ", this is the
> explain of config VGA_ARB, that is to say, some legacy vga devices need use
> the same pci bus address, if user app(such as xorg) want access card A, but
> card A and card B have same bus address,  then VGA agaarbiter will determine
> will card to be accessed.

Yes.  I think the arbiter also provides an interface for controlling
the routing of these legacy resources.

Your patch changes the kernel's idea of the default VGA device, but
doesn't affect the resource routing, AFAICT.

> And xorg will read boot_vga to determine which graphics card is the primary
> graphics output device.

Doesn't xorg also have its own mechanism for selecting which graphics
device to use?

Is the point here that you want to write the sysfs file to select the
device instead of changing the xorg configuration?  If it's possible
to configure xorg directly to use different devices, my inclination
would be to use that instead of doing it via sysfs.

> That is the difference about boot_vga and vgaarbiter.
>
> > > Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
> > > ---
> > >   drivers/pci/pci-sysfs.c | 24 +++++++++++++++++++++++-
> > >   1 file changed, 23 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 7bbf2673c7f2..a6ba19ce7adb 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -664,7 +664,29 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
> > >   			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
> > >   			     IORESOURCE_ROM_SHADOW));
> > >   }
> > > -static DEVICE_ATTR_RO(boot_vga);
> > > +
> > > +static ssize_t boot_vga_store(struct device *dev, struct device_attribute *attr,
> > > +			      const char *buf, size_t count)
> > > +{
> > > +	unsigned long val;
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	struct pci_dev *vga_dev = vga_default_device();
> > > +
> > > +	if (kstrtoul(buf, 0, &val) < 0)
> > > +		return -EINVAL;
> > > +
> > > +	if (val != 1)
> > > +		return -EINVAL;
> > > +
> > > +	if (!capable(CAP_SYS_ADMIN))
> > > +		return -EPERM;
> > > +
> > > +	if (pdev != vga_dev)
> > > +		vga_set_default_device(pdev);
> > > +
> > > +	return count;
> > > +}
> > > +static DEVICE_ATTR_RW(boot_vga);
> > >   static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
> > >   			       struct bin_attribute *bin_attr, char *buf,
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > > No virus found
> > > 		Checked by Hillstone Network AntiVirus
