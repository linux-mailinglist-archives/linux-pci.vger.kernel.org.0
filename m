Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93F3D9481
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhG1Rp2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG1Rp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 13:45:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8552C061757;
        Wed, 28 Jul 2021 10:45:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso5177167pjf.4;
        Wed, 28 Jul 2021 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lHno4MBHdbeNB3Xoyjpjs0nK+RqfS/5Vq8ywuXowvEo=;
        b=oPiCpJ0+KE12qvrF6DoO9oTW6F5QrtH88Gvsjk1WkOVoTfB+s3UvVnNk1PxIpPLwYS
         Qs6dEEVi2kJT0MgSwO6Q1IZ5749gDmqn5d3B+RmdhFTK/Azhchv397ITdgAgiIsfw89n
         y4FCmAa6NydTbXzkQijaXo4jE4aQatxI3M61tqtayiHeLAYGynu+C6j+vQHBE2VUsYzb
         ABFyX61Q9Tdy0XXLLg5jp95aMw9nrDZaenaVo3dgcbBUnz378LuzLYjnlxuXLQQJDiMq
         5q92s3UFE6vgt9u5IO83JjDWVrUvDa9ErF8MkWKJTS9p4bQt336/0HRNw/uYJlUZIXVH
         OO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lHno4MBHdbeNB3Xoyjpjs0nK+RqfS/5Vq8ywuXowvEo=;
        b=LFkrNuYzcopufv5Ao7cvZDQQzLNX3n9+5Q8Of/45t9tlEDts2/qyJzbuslLb0LNTFU
         Qllhn+DdgnexiWBDEVdnEeWsQbd78Zk8B2ByGhi77thPXg4zl13/6FujltW3drFuxFYj
         HFv7t/YwCcxX6zkTSXULil+3LUfTkYTkfOFCaQQsUOsIIxatyCGyqhRai3t26f20BHNr
         KgFjMCONann8Eisr+pIoqZfiW2Fk0psoB1eDqTAkYIyfxS+WKuHGy8Qzr+Jmps7nTLaa
         EDoEzAVcDQAYqHfRnBMCwRTsWTtTOILqMDnMxLiGPozUevkFQv4Z4JQ5CuG3a35BrtPE
         Zt/A==
X-Gm-Message-State: AOAM533699Oepe80omzcMKA/mriamPfb2Rdvgcb431TxsOxfFDlAFKEO
        H4AxGp51MVxJIMtR4udu9dI=
X-Google-Smtp-Source: ABdhPJywg3BdJt2bL95wX4f1jtyhZgV7P75wKzntseU8CT642veM14oRIeQth7wFiibhrrJB8vkOPw==
X-Received: by 2002:a17:90b:215:: with SMTP id fy21mr862166pjb.203.1627494323096;
        Wed, 28 Jul 2021 10:45:23 -0700 (PDT)
Received: from localhost ([49.32.196.184])
        by smtp.gmail.com with ESMTPSA id f24sm1492735pjj.45.2021.07.28.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:45:22 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:15:19 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Message-ID: <20210728174519.has5xvy6rksbukup@archlinux>
References: <20210709123813.8700-3-ameynarkhede03@gmail.com>
 <20210727225951.GA752728@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727225951.GA752728@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/27 05:59PM, Bjorn Helgaas wrote:
> On Fri, Jul 09, 2021 at 06:08:07PM +0530, Amey Narkhede wrote:
> > Introduce a new array reset_methods in struct pci_dev to keep track of
> > reset mechanisms supported by the device and their ordering.
> >
> > Also refactor probing and reset functions to take advantage of calling
> > convention of reset functions.
> >
> > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/pci/pci.c   | 92 ++++++++++++++++++++++++++-------------------
> >  drivers/pci/pci.h   |  9 ++++-
> >  drivers/pci/probe.c |  5 +--
> >  include/linux/pci.h |  7 ++++
> >  4 files changed, 70 insertions(+), 43 deletions(-)
> >
>
[...]
> > +	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
> >
> >  	might_sleep();
> >
> > -	rc = pci_dev_specific_reset(dev, 1);
> > -	if (rc != -ENOTTY)
> > -		return rc;
> > -	rc = pcie_reset_flr(dev, 1);
> > -	if (rc != -ENOTTY)
> > -		return rc;
> > -	rc = pci_af_flr(dev, 1);
> > -	if (rc != -ENOTTY)
> > -		return rc;
> > -	rc = pci_pm_reset(dev, 1);
> > -	if (rc != -ENOTTY)
> > -		return rc;
> > +	for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> > +		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
> > +		if (!rc)
> > +			reset_methods[n++] = i;
>
> Why do we need this local reset_methods[] array?  Can we just fill
> in dev->reset_methods[] directly and skip the memcpy() below?
>
This is for avoiding caching of previously supported reset methods.
Is it okay if I use memset(dev->reset_methods, 0,
sizeof(dev->reset_methods)) instead to clear the values in
dev->reset_methods?

Thanks,
Amey
> > +		else if (rc != -ENOTTY)
> > +			break;
> > +	}
> >
> > -	return pci_reset_bus_function(dev, 1);
> > +	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
> >  }
> >
> >  /**
[...]
