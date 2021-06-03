Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3A39AD01
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 23:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCVi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 17:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhFCVi4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 17:38:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0E3A611C9;
        Thu,  3 Jun 2021 21:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622756230;
        bh=uyLxTk6jgWKx7UFc6YfXO8WlYBcqIb4Xx7+GzDwcgg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CvvHok/1DA8whkFQxS4ufFX5vi2HD+5v33n7fCiMUy5CtaBbWnt7UJH+KSOj9IKUg
         FoYQjNGdRTRwbAN5e2xVh/dLzT3ibYZRGl9X8yPypCeFhkifpjgaO8Xlw4EOPq5VlL
         BpO/jIsLg9nsffanOwdJWCYPSXu4FHxBCIqS/llBzgSEq/2wSrjHBBq2JEPPPYHfFb
         2SF000Ma/gTXFIXPZcIhTr+p/Y2M2suT2PYnm+B6FMpJmC13RatKgytGZA65odUuGc
         YDGAMyZGX1a4NXfGEcz7zYYaGKiJqF+kQerdv3uTV6f8VGhxJ9zopaxd1u6mwIfBwX
         gp0D6aB2yvRxQ==
Date:   Thu, 3 Jun 2021 16:37:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 5/6] PCI/sysfs: Only show value when driver_override
 is not NULL
Message-ID: <20210603213703.GA2143496@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603211741.GA2141918@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 03, 2021 at 04:17:41PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 03, 2021 at 12:01:11AM +0000, Krzysztof Wilczyński wrote:
> > Only expose the value of the "driver_override" variable through the
> > corresponding sysfs object when a value is actually set.
> 
> What's the reason for this change?  The above tells me what it *does*,
> but not *why* or whether it affects users.
> 
> Is this to avoid trying to print a NULL pointer as %s?  Do we print
> "(null)" or something in that case now?  I assume sprintf() doesn't
> actually oops.  If we change what appears in sysfs, we should mention
> that here.  And maybe consider whether there's any chance of breaking
> user code that might know what to do with "(null)" but not with an
> empty string.
> 
> There are six other driver_override_show() methods.  Five don't check
> the ->driver_override pointer at all; one (spi.c) checks like this:
> 
>   len = snprintf(buf, PAGE_SIZE, "%s\n", spi->driver_override ? : "");
> 
> Do the others need similar fixes?  Most of them still use sprintf()
> also.

I can't remember if there's a reason for holding device_lock() around
this.  Of the seven: amba, platform, vmbus, pci, s390, and spi hold
it, while fsl-mc does not.

Since we're only reading a single scalar, I don't see the reason for
device_lock().  If we do need it, it would be nice to have a brief
comment explaining why.  Obviously not an issue with this patch :)

> > Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> >  drivers/pci/pci-sysfs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5d63df7c1820..4e9f582ca10f 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -580,10 +580,11 @@ static ssize_t driver_override_show(struct device *dev,
> >  				    struct device_attribute *attr, char *buf)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> > -	ssize_t len;
> > +	ssize_t len = 0;
> >  
> >  	device_lock(dev);
> > -	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
> > +	if (pdev->driver_override)
> > +		len = sysfs_emit(buf, "%s\n", pdev->driver_override);
> >  	device_unlock(dev);
> >  	return len;
> >  }
> > -- 
> > 2.31.1
> > 
