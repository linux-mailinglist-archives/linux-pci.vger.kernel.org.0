Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3DC3F98E4
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbhH0ML7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 08:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245089AbhH0ML7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 08:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F67360295;
        Fri, 27 Aug 2021 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630066270;
        bh=lW7f6PhFOdBYcWJ8ZOZrGIhMpuHag2baM3yolu9JhKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoXLM73c0rY/R7LFb3m0Qk19LprIYC3yH+wGOOp8CpVdA7Bghye74xcVs9/IA4La7
         k8lTdaZCcovdUu8skOfydAc3WTcf1jC8bG0NFNxHEeeeq9ng0RwLTvkcp7z23xY+gl
         Z28FPFK7h1Dvbw473ZJQKbyDZQfDY36HR9Mmx5rQ=
Date:   Fri, 27 Aug 2021 14:11:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/sysfs: Add pci_dev_resource_attr_is_visible()
 helper
Message-ID: <YSjWWWVC6ImWA5Qe@kroah.com>
References: <20210825212255.878043-2-kw@linux.com>
 <20210826233534.GA3726492@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210826233534.GA3726492@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 06:35:34PM -0500, Bjorn Helgaas wrote:
> [+cc Greg, sorry for the ill-formed sysfs question below]
> 
> On Wed, Aug 25, 2021 at 09:22:52PM +0000, Krzysztof Wilczyński wrote:
> > This helper aims to replace functions pci_create_resource_files() and
> > pci_create_attr() that are currently involved in the PCI resource sysfs
> > objects dynamic creation and set up once the.
> > 
> > After the conversion to use static sysfs objects when exposing the PCI
> > BAR address space this helper is to be called from the .is_bin_visible()
> > callback for each of the PCI resources attributes.
> > 
> > Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> > ---
> >  drivers/pci/pci-sysfs.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index b70f61fbcd4b..c94ab9830932 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1237,6 +1237,46 @@ static int pci_create_resource_files(struct pci_dev *pdev)
> >  	}
> >  	return 0;
> >  }
> > +
> > +static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
> > +						struct bin_attribute *attr,
> > +						int bar, bool write_combine)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> > +	resource_size_t resource_size = pci_resource_len(pdev, bar);
> > +	unsigned long flags = pci_resource_flags(pdev, bar);
> > +
> > +	if (!resource_size)
> > +		return 0;
> > +
> > +	if (write_combine) {
> > +		if (arch_can_pci_mmap_wc() && (flags &
> > +		    (IORESOURCE_MEM | IORESOURCE_PREFETCH)) ==
> > +			(IORESOURCE_MEM | IORESOURCE_PREFETCH))
> > +			attr->mmap = pci_mmap_resource_wc;
> 
> Is it legal to update attr here in an .is_visible() method?  Is attr
> the single static struct bin_attribute here, or is it a per-device
> copy?

It is whatever was registered with sysfs, that was up to the caller.

> I'm assuming the static bin_attribute is a template and when we add a
> device that uses it, we alloc a new copy so each device has its own
> size, mapping function, etc.

Not that I recall, I think it's just a pointer to the structure that the
driver passed to the sysfs code.

> If that's the case, we only want to update the *copy*, not the
> template.  I don't see an alloc before the call in create_files(),
> so I'm worried that this .is_visible() method might get the template,
> in which case we'd be updating ->mmap for *all* devices.

Yes, I think that is what you are doing here.

Generally, don't mess with attribute values in the is_visable callback
if at all possible, as that's not what the callback is for.

thanks,

greg k-h
