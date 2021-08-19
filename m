Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0B23F224F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 23:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhHSVje (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 17:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230112AbhHSVjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 17:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629409136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBzgR7XCkOLtoH5Yvb/WeoEepDn8l0sH9+YEvlAnXq8=;
        b=BUsfa/KbICVSIWLFPOcrRjSpdB8hZwraSsI8VEWysRlQJrWhBA5+j+TYPPUcM2qIy2Q0rY
        D9OpOnRR2EUYcEiK8sT2MScR3a3/Bqz2j9VHFuROScBiCGKVo8ZsCQ3SvdHIm61XdG4CfM
        uEO70PwLHgH7TUz+fc1xltE1Gbf1Vuw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-bmhEz83uNqCHSwaKIlis0w-1; Thu, 19 Aug 2021 17:38:52 -0400
X-MC-Unique: bmhEz83uNqCHSwaKIlis0w-1
Received: by mail-oi1-f199.google.com with SMTP id n64-20020acabd430000b029025a4350857eso2744422oif.8
        for <linux-pci@vger.kernel.org>; Thu, 19 Aug 2021 14:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBzgR7XCkOLtoH5Yvb/WeoEepDn8l0sH9+YEvlAnXq8=;
        b=U8P9cC35YfBgKt6lC25Bba51OOMxoWikS2OiejuSBrdXsWyMZh+HbEKB65wOi5/VcN
         Rx2z76l2oVk5yHGrYkPd+EL/U4eAcKKpEcGCQcG/96WyINa9PXc58e9TW4vK5Lhz0Gfv
         FET35pN7G2yHJDaw5vPwgoJZXd72V6UKw9wNPM0kEzZcN9YkaqGFqZNBh9CfxsTID8Vq
         2nR/4le5u9v8EfSyGMYF2/7Df13cHSXv9XMvI+pjVtQ2J27wwCYkN2GFLm+PQkjDiELu
         U4RfJISDsApR2qK2Fp62bIvzR7fC6p1bAxcoqS7xoZwzLFLuj99DH9IgLSrHaoozrbyN
         0H0Q==
X-Gm-Message-State: AOAM530JBK8yomIDiBGW5jytL8appcIgoSvloRMQryGKeAlwijFpamO5
        0nJUmQL5VOhbVBwfZsitGZZecuwFo1ys8Apl6l7X8GGdCGsmbwsACVL5yb0mYkkJtYbgpWdbTBv
        wgpjzgtMV8unizcRrXcz6
X-Received: by 2002:a05:6830:25ce:: with SMTP id d14mr13997888otu.87.1629409131793;
        Thu, 19 Aug 2021 14:38:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXo86cMZwiteRgztCDTbYxT83N7YNWeCuTuo1Gafd50BVVBx8Z/pbVTsnabs0y+xWiACesDA==
X-Received: by 2002:a05:6830:25ce:: with SMTP id d14mr13997878otu.87.1629409131629;
        Thu, 19 Aug 2021 14:38:51 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id g16sm968289otr.20.2021.08.19.14.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 14:38:51 -0700 (PDT)
Date:   Thu, 19 Aug 2021 15:38:49 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <corbet@lwn.net>,
        <diana.craciun@oss.nxp.com>, <kwankhede@nvidia.com>,
        <eric.auger@redhat.com>, <masahiroy@kernel.org>,
        <michal.lkml@markovi.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <mgurtovoy@nvidia.com>, <jgg@nvidia.com>, <maorg@nvidia.com>,
        <leonro@nvidia.com>
Subject: Re: [PATCH V2 06/12] vfio/pci: Split the pci_driver code out of
 vfio_pci_core.c
Message-ID: <20210819153849.1e1ffc83.alex.williamson@redhat.com>
In-Reply-To: <20210819151235.6fe61269.alex.williamson@redhat.com>
References: <20210818151606.202815-1-yishaih@nvidia.com>
        <20210818151606.202815-7-yishaih@nvidia.com>
        <20210819151235.6fe61269.alex.williamson@redhat.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 19 Aug 2021 15:12:35 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 18 Aug 2021 18:16:00 +0300
> Yishai Hadas <yishaih@nvidia.com> wrote:
> > +
> > +static int vfio_pci_sriov_configure(struct pci_dev *pdev, int nr_virtfn)
> > +{
> > +	might_sleep();  
> 
> vfio_pci_core_sriov_configure() retained the might_sleep(), it
> shouldn't be needed here.
> 
> > +
> > +	if (!enable_sriov)
> > +		return -ENOENT;
> > +
> > +	return vfio_pci_core_sriov_configure(pdev, nr_virtfn);
> > +}  
> ...
> > @@ -509,7 +449,7 @@ static struct vfio_pci_core_device *get_pf_vdev(struct vfio_pci_core_device *vde
> >  	if (!pf_dev)
> >  		return NULL;
> >  
> > -	if (pci_dev_driver(physfn) != &vfio_pci_driver) {
> > +	if (pci_dev_driver(physfn) != pci_dev_driver(vdev->pdev)) {  
> 
> I think this means that the PF and VF must use the same vfio-pci
> "variant" driver, it's too bad we're not enabling vfio-pci to own the
> PF while vfio-vendor-foo-pci owns the VF since our SR-IOV security
> model remains in the core.  We can work on that later though, no loss
> of functionality here.
> 
> ...
> > @@ -1795,12 +1723,12 @@ static int vfio_pci_bus_notifier(struct notifier_block *nb,
> >  		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
> >  			 pci_name(pdev));
> >  		pdev->driver_override = kasprintf(GFP_KERNEL, "%s",
> > -						  vfio_pci_ops.name);
> > +						  vdev->vdev.ops->name);
> >  	} else if (action == BUS_NOTIFY_BOUND_DRIVER &&
> >  		   pdev->is_virtfn && physfn == vdev->pdev) {
> >  		struct pci_driver *drv = pci_dev_driver(pdev);
> >  
> > -		if (drv && drv != &vfio_pci_driver)
> > +		if (drv && drv != pci_dev_driver(vdev->pdev))
> >  			pci_warn(vdev->pdev,
> >  				 "VF %s bound to driver %s while PF bound to vfio-pci\n",  
> 
> "vfio-pci" is hardcoded in this comment.  There are a few other user
> visible instances of this in vfio-pci-core.c as well:
> 
> MODULE_PARM_DESC(disable_vga, "Disable VGA resource access through vfio-pci");

I see this one is resolved in a later patch.  Thanks,

Alex

> 
>                 ret = pci_request_selected_regions(pdev,
>                                                    1 << index, "vfio-pci");
> 
>                         pci_info_ratelimited(vdev->pdev,
>                                 "VF token incorrectly provided, PF not bound to vfio-pci\n");
> 
> We should try to fix or reword as many of these as we reasonably can.
> Thanks,
> 
> Alex

