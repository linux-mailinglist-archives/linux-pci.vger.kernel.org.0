Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5608E3B1F53
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWRXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 13:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhFWRXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 13:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624468873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nec/3bsypUO59txQs+sPa2kgEe/qKYIU32oYciVKOCA=;
        b=jEZfc3bB67WCZPvd8cLRvsTWTKx0CSRQV0ckPg5QTDwlikxsYSgQv7bVthgt8t3Z/3ehKf
        lO+3tHv+mgutJp07Pz0ES6tYnrdtFKw7P8LFX/u02pf1XV8ioLwKDxSrkVpaf1GBlGTs+f
        w0VLsj4KNdwRrLLn/8PEGpGFFlwUEMk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-4nCnxzDEONWCuPh0uXyy8w-1; Wed, 23 Jun 2021 13:21:12 -0400
X-MC-Unique: 4nCnxzDEONWCuPh0uXyy8w-1
Received: by mail-oi1-f198.google.com with SMTP id k11-20020a54440b0000b02901f3e6a011b4so2090315oiw.23
        for <linux-pci@vger.kernel.org>; Wed, 23 Jun 2021 10:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nec/3bsypUO59txQs+sPa2kgEe/qKYIU32oYciVKOCA=;
        b=hbTDGsJRntvBG0eXUo50oahwTxkWEY37rX7htJz3hREsnu9xx+JsNQQCTyGn2So6GM
         /+b5wgw1CJe3fdAGroWEWAHbUVcj6mOnUEuWStdgUz74Zbm/ajePqf39yAYFZwnZTxc2
         GpRPJihCzDCmu0u5cwECMjCxXiK+ko/kAjN3/9pFNSrql0rLAjFVtGL+TKMzhWF3JSqD
         qoM2GzZzj2qZkKh0K6ZIaPrYSWs937bWgn7kwXSDxBgLnKWV76d5W0/QG0fRYVZ8sVH0
         ClB7PVHp3iOc1wkaN+9WMDcUoAVuPGPYTSXBalZoXhYGWctwAjgkTKsQb5BEAaDDMnGi
         8DfQ==
X-Gm-Message-State: AOAM533OF1krDYd/B2rHbbbDQ2Cgejdpbwrt4TsF5lDiDKiwYZpGQ48Z
        lw6+XI2hjevn1qNb5buIANoJQhFliLA8bwwACSAnR47cUtf3cVG+1XPhCBiQzFeGDqxZ90oPaKJ
        jcfLZE1Sr3x0vSFJ+FED9
X-Received: by 2002:aca:5ad4:: with SMTP id o203mr744125oib.87.1624468871290;
        Wed, 23 Jun 2021 10:21:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJV8RNhuhZJetcQl7ZyHsGL3oOKLiUy6sEQcgqpF9xvwkEGuItqwE8BhOWfu/wX3twUIQHAQ==
X-Received: by 2002:aca:5ad4:: with SMTP id o203mr744099oib.87.1624468871047;
        Wed, 23 Jun 2021 10:21:11 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id f36sm109629otf.12.2021.06.23.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:21:10 -0700 (PDT)
Date:   Wed, 23 Jun 2021 11:21:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210623112109.361604bd.alex.williamson@redhat.com>
In-Reply-To: <20210621130135.GA3288360@bjorn-Precision-5520>
References: <20210619135920.h42gp5ie5c2eutfq@archlinux>
        <20210621130135.GA3288360@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Jun 2021 08:01:35 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Sat, Jun 19, 2021 at 07:29:20PM +0530, Amey Narkhede wrote:
> > On 21/06/18 03:00PM, Bjorn Helgaas wrote:  
> > > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:  
> > > > +	while ((name = strsep(&options, ",")) != NULL) {
> > > > +		if (sysfs_streq(name, ""))
> > > > +			continue;
> > > > +
> > > > +		name = strim(name);
> > > > +
> > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> > > > +			if (reset_methods[i] &&
> > > > +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> > > > +				reset_methods[i] = prio--;
> > > > +				break;
> > > > +			}
> > > > +		}
> > > > +
> > > > +		if (i == PCI_RESET_METHODS_NUM) {
> > > > +			kfree(options);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (reset_methods[0] &&
> > > > +	    reset_methods[0] != PCI_RESET_METHODS_NUM)
> > > > +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");  
> > >
> > > Is there a specific reason for this warning?  Is it just telling the
> > > user that he might have shot himself in the foot?  Not sure that's
> > > necessary.
> > >  
> > I think generally presence of device specific reset method means other
> > methods are potentially broken. Is it okay to skip this?  
> 
> We might want a warning at reset-time if all the methods failed,
> because that means we may leak state between users.  Maybe we also
> want one here, if *all* reset methods are disabled.  I don't really
> like special treatment of device-specific methods here because it
> depends on the assumption that "device-specific means all other resets
> are broken."  That's hard to maintain.

I'd say the device specific reset is special.  The device itself can
support a number of resets and they're theoretically all equivalent,
it's a policy decision which to use.  But the device specific reset is
a software provided reset.  Someone has specifically gone to the
trouble to create a reset mechanism that is in some way better than the
other methods.  Not using that one by default sure feels like something
worthy of leaving a breadcrumb in dmesg for debugging.  Thanks,

Alex

