Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12FADAABE2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfIETVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:21:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43398 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfIETVf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 15:21:35 -0400
Received: by mail-io1-f65.google.com with SMTP id u185so7268995iod.10;
        Thu, 05 Sep 2019 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e76tWLrZM+eAcaVT9HMnk/sR6DYGUbSHEjtTBEQahDo=;
        b=GGOrsPg+cv0ju7nK//6dVkE+nBizjhdmTO/aZLzMtmWhYjAYK3+OJA+RZO6krIL9Kp
         pHrMDl+cY5vV/AnrAEQ257MV4osprzaCpLMSB24CzerRZ+H0y5pSy6A9vMcJ6crPLrIZ
         OTmj/u/iuO+M0G/i8daNi3647U0r6vJikqZFjaoPudtdTA6QVMeHMhw/X3J+xaIi+T8o
         1oj55GZ2BLDuFbLkt4b0ogeidNyi+upLVJURRME+2ZwLJqU87YIyzoJkcSDfZ2xzY8R0
         qh7Sy+m/1HmSRE5AuNHpDXIaZOHcoKhCROZ9ltT4Po4SkKkH20F8QkQzDXcB/p5i7EKo
         qaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e76tWLrZM+eAcaVT9HMnk/sR6DYGUbSHEjtTBEQahDo=;
        b=HLOYF6n+TA9aCap0nNFcHrCyXRTP7M3FhllgatjXa4zcD2lKhFrqQkQCj9F02B8mrH
         QLs+qEquO78CcgGH6WXU8Kld9slh3fcJ9AOeXmkZ11cOBra0wx/TGBk/O3DSuHsAcJet
         LNyIL3GoMDMRnHWZGbkbN9GtGWbM58M3y1OZmJqUuwy7J2IwdEX9HsxA26g3+uMsdymX
         0QO+MtENW8ba0sajoUxIE8c5iKwmvQeeCxlzK381/dw4rEvkOaj8xCuMg7V5lBJULv7p
         NvHBisG/BN4KaJ8x9g4qVDs+JzgVcN8Kt2bFahxpFF6/MsGTPI+7d7JwBIIK0AyQp+MX
         cSgA==
X-Gm-Message-State: APjAAAXerOTDRq3MVMB5tbuMurhPKoCs240qT11WCfKJLtJgXuOfugrK
        fEEwtz/tiCKRcFj1s+bZ+04=
X-Google-Smtp-Source: APXvYqyQhu/L/cZO3l/V/KLL14jGeNRt5mh9p6Bc4JRbujIU5SyrS/qtvriYjouPgkvxjNpw0hS71w==
X-Received: by 2002:a5e:960a:: with SMTP id a10mr6050735ioq.82.1567711295198;
        Thu, 05 Sep 2019 12:21:35 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id p5sm3223219iom.50.2019.09.05.12.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 12:21:34 -0700 (PDT)
Date:   Thu, 5 Sep 2019 13:21:33 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, berrange@redhat.com,
        ddutile@redhat.com, bodong@mellanox.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Eli Cohen <eli@mellanox.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI/IOV: Make SR-IOV attributes
 with mode 0664 use 0644
Message-ID: <20190905192133.GC22813@JATN>
References: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
 <20190905182938.GD103977@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905182938.GD103977@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 01:29:38PM -0500, Bjorn Helgaas wrote:
> [+cc Bodong, Eli: just FYI since this affects sriov_drivers_autoprobe,
> which you added with 0e7df22401a3]
> 
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
> 
> Applied with Greg's Reviewed-by and Don's Acked-by to pci/misc for
> v5.4, thanks!
>

Appreciate you adding the cc and applying. Thanks, Bjorn!

-Kelsey
 
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
> > -- 
> > 2.20.1
> > 
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
