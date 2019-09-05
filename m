Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06380AAE01
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfIEVrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 17:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfIEVrO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 17:47:14 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A939206DE;
        Thu,  5 Sep 2019 21:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567720034;
        bh=kfe2TGoSTMVF1/lVPOYosFc6NnbRFTGJzAeJes9ucdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJrk1arZaeNOtOpuajdQpPAcomvfAw0ARumnmmzubiwh+8xg/NmKgMjIy6AU98gg4
         YCaEtpw71IjfGteEK2wL6fnZ6vySMSYo/GmDlBh89oZXh01azrjYFs2R6C4rV8i9gI
         /Xym/nOejdfvTsNlZPhXXqirp8wOWajjR0oqhdvU=
Date:   Thu, 5 Sep 2019 16:47:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: Use GFP_ATOMIC in resource_alignment_store()
Message-ID: <20190905214712.GJ103977@google.com>
References: <20190831124932.18759-1-yuehaibing@huawei.com>
 <20190902075006.GB754@infradead.org>
 <9d2094f7-eb71-4975-eb9b-166a1483afa0@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d2094f7-eb71-4975-eb9b-166a1483afa0@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 03, 2019 at 09:51:05AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-09-02 1:50 a.m., Christoph Hellwig wrote:
> > On Sat, Aug 31, 2019 at 12:49:32PM +0000, YueHaibing wrote:
> >> When allocating memory, the GFP_KERNEL cannot be used during the
> >> spin_lock period. It may cause scheduling when holding spin_lock.
> >>
> >> Fixes: f13755318675 ("PCI: Move pci_[get|set]_resource_alignment_param() into their callers")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/pci/pci.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 484e35349565..0b5fc6736f3f 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -6148,7 +6148,7 @@ static ssize_t resource_alignment_store(struct bus_type *bus,
> >>  	spin_lock(&resource_alignment_lock);
> >>  
> >>  	kfree(resource_alignment_param);
> >> -	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
> >> +	resource_alignment_param = kstrndup(buf, count, GFP_ATOMIC);
> >>  
> >>  	spin_unlock(&resource_alignment_lock);
> > 
> > Why not move the allocation outside the lock? Something like this
> > seems much more sensible:
> 
> Yes, that seems like a good way to do it. Bjorn, can you squash
> Christoph's patch or do you want me to resend a new one?

I folded Christoph's fix into it, thanks!

> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 484e35349565..fe205829f676 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6145,14 +6145,16 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
> >  static ssize_t resource_alignment_store(struct bus_type *bus,
> >  					const char *buf, size_t count)
> >  {
> > -	spin_lock(&resource_alignment_lock);
> > +	char *param = kstrndup(buf, count, GFP_KERNEL);
> >  
> > -	kfree(resource_alignment_param);
> > -	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
> > +	if (!param)
> > +		return -ENOMEM;
> >  
> > +	spin_lock(&resource_alignment_lock);
> > +	kfree(resource_alignment_param);
> > +	resource_alignment_param = param;
> >  	spin_unlock(&resource_alignment_lock);
> > -
> > -	return resource_alignment_param ? count : -ENOMEM;
> > +	return count;
> >  }
> >  
> >  static BUS_ATTR_RW(resource_alignment);
> > 
