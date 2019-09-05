Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611FFAABD2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfIETQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:16:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33992 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfIETQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 15:16:41 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so7349937ioa.1;
        Thu, 05 Sep 2019 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SeNhzZJnbTj4DW4++p0vK7Bp7AcJgIkbPLU7cUgS82Y=;
        b=trHCi8aaOFYCtIIbjw99+xFl3hanazQ81YvOunKQeR3rGonw1QhRzR3vb074+7QYst
         frU5K92RhvZBg3yYZI50naNHvYj4u1jVo/O18jNA1AQmHgvL9IKENRMa2tYWkZheQuxV
         R3FUCXxCK8ifhcMNfqRZfSEZ5G+KtDPyIGPi9Hq3wdZKxRA2hMxLTK6/eTE1NlML8YHc
         ia/E0ts8NlJBOXvQgTmGcHAX3lkcz4Ri666fuoo/RHcUl8muazj4j+XUNNqBfix3rSQs
         HLAxFaMGeWU0FGHsRT347oGieJh2DawFoEgetnTMkBHEZfcshZ7vGqKv5LXEPdRmGxMh
         iCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SeNhzZJnbTj4DW4++p0vK7Bp7AcJgIkbPLU7cUgS82Y=;
        b=ancVdNkpv8kfbwsyfHf7mNiL7av8kkRpiI4IBQoJslf7mOm/KPll7jFN3Xof2y4Lq3
         +/ZICQnzKmFpNGIqouNqQmnFYgMgI/7+EynkPQTKRzVu4QfMybC0AaJIgDdu4fXIElCU
         0dsFz884+g175aIxhAx7JQ6HFmpDsV+8eo4fJF8AanG8TKxyHx1KsIVSd29NXGlgaubJ
         t75aLHjOsQzsY4hFGLWf78g07ji1zA0yrnOE75/pKC8zUrC04jZbnDKXm+vsFrX2gfMJ
         vK0Y3EzeGk7x7uA1WPcLRInGnHWiEA61/HiJvcHdgz4fO9NyvEsUatbLv+JO6pXoHRrG
         x/mw==
X-Gm-Message-State: APjAAAWx0W7QXAKvN7j/1L32gdWIj7gznPLsY5s1WECMzHIEowbsWhFl
        nmO9ttuHu/lfi+ccP9xGqRQ=
X-Google-Smtp-Source: APXvYqx9tHLXz1eLp/4aXO/Vef4AWTvUfN/xQL/YJmMXhTNtvCiEqccIipw8UN5VprCIcdbCvTviRw==
X-Received: by 2002:a02:2e54:: with SMTP id u20mr5991984jae.5.1567710999653;
        Thu, 05 Sep 2019 12:16:39 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id h70sm5177098iof.48.2019.09.05.12.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 12:16:38 -0700 (PDT)
Date:   Thu, 5 Sep 2019 13:16:37 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bodong@mellanox.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ddutile@redhat.com, berrange@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH] PCI/IOV: Make SR-IOV attributes with mode 0664 use 0644
Message-ID: <20190905191637.GA22813@JATN>
References: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
 <20190905073416.GC29933@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905073416.GC29933@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 09:34:16AM +0200, Greg KH wrote:
> On Thu, Sep 05, 2019 at 12:32:26AM -0600, Kelsey Skunberg wrote:
> > sriov_numvfs and sriov_drivers_autoprobe have "unusual" permissions (0664)
> > with no reported or found reason for allowing group write permissions.
> > libvirt runs as root when dealing with PCI, and chowns files for qemu
> > needs. There is not a need for the "0664" permissions.
> > 
> > sriov_numvfs was introduced in:
> > 	commit 1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> > 
> > sriov_drivers_autoprobe was introduced in:
> > 	commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to
> > 			      control VF driver binding")
> > 
> > Change sriov_numvfs and sriov_drivers_autoprobe from "0664" permissions to
> > "0644" permissions.
> > 
> > Exchange DEVICE_ATTR() with DEVICE_ATTR_RW() which sets the mode to "0644".
> > DEVICE_ATTR() should only be used for "unusual" permissions.
> > 
> > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > ---
> >  drivers/pci/iov.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index b335db21c85e..b3f972e8cfed 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -375,12 +375,11 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
> >  }
> >  
> >  static DEVICE_ATTR_RO(sriov_totalvfs);
> > -static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
> > +static DEVICE_ATTR_RW(sriov_numvfs);
> >  static DEVICE_ATTR_RO(sriov_offset);
> >  static DEVICE_ATTR_RO(sriov_stride);
> >  static DEVICE_ATTR_RO(sriov_vf_device);
> > -static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> > -		   sriov_drivers_autoprobe_store);
> > +static DEVICE_ATTR_RW(sriov_drivers_autoprobe);
> >  
> >  static struct attribute *sriov_dev_attrs[] = {
> >  	&dev_attr_sriov_totalvfs.attr,
> 
> 
> Nice!!!
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for reviewing!

-Kelsey
