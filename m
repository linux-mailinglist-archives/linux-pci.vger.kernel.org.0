Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455113AD11A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhFRRY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 13:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbhFRRY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 13:24:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A92FC061574;
        Fri, 18 Jun 2021 10:22:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k22-20020a17090aef16b0290163512accedso7512272pjz.0;
        Fri, 18 Jun 2021 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8mQ/XRQMI47rqD8TzEfQbV5u9s+Givq02FTiXw3BSO8=;
        b=P0DJxbrGknizlqTMW18crlPzWWfMhRxDuFAJ4tQ2SVIbLy8SW4nSJu/v9DzP1AMZEb
         n5dUP47YIdWkriLrn4lcTsK6uCOM+Z7s6Yrf7oNx4HxFWlTCec9NAZ1DjDOWBNg/eyRL
         y1SB8Snr5yixXKREuBHS1ZDDm4KEEXT4XZVcCCCesX6ifbfSipfS75TT4TbP1uv/ud9E
         Uuqut3+s83fc0Zk2UJp3gUBToPQTV6roHnK21O4xm3I2L7FVk91NGIAhfaC0ZvAN5wry
         G857VmxW/MUipP265iya6kZ8wGR4G1k6Aj/HV6qG+MNaq/iT8A8YkXAOrqq+4YMoTRir
         dLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8mQ/XRQMI47rqD8TzEfQbV5u9s+Givq02FTiXw3BSO8=;
        b=lc+ZkKQ9cUrGrj70A5oEH71NXTuacdT1MIIANo2Aefo2m2XUdsfr+qwL9E+wYl6ueW
         QhSkX0cUv9NCzwZ9yve6QcFnFbdkOTpGwBsfJrU8Atq2UDUgFCUiNcSAibkVHI+yQMgM
         yiKO18dZKCqY6xzqzorygbHa7a1D0jQg2mYCYM87PW2UlE5reozcJ8Yy2nQ5NccU8B7v
         qz54jBlNdkCjiggXg9YzmQIybidtgJPAdCJ6PnixPOg3ekQCowUzv3yR+N53QRunVcsj
         r9ehazCTR2NwPlRVL7liLv+4tuxUkHl4zFnSObeMvnt7SxM0g8fZXkA7LchUiHgOCvlM
         iwvQ==
X-Gm-Message-State: AOAM530Op9sQKoxWYa8QN/5zzAcynqJ1U2zQ4+TED9Y3kkykdJiIl/yQ
        ZsFK09YSZFI7xF8rIEzbTNk=
X-Google-Smtp-Source: ABdhPJyfrZmANPu5yb8zUReiJJwoCJ96xhpxitOYc9HNeTH+Jp55GW3Jc9r9eHPA7FX/IXtAM2YzFQ==
X-Received: by 2002:a17:90a:694d:: with SMTP id j13mr12168101pjm.99.1624036965828;
        Fri, 18 Jun 2021 10:22:45 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id v69sm2636114pfc.18.2021.06.18.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:22:45 -0700 (PDT)
Date:   Fri, 18 Jun 2021 22:52:42 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Message-ID: <20210618172242.vs3qwimjpcicb4m4@archlinux>
References: <20210608054857.18963-3-ameynarkhede03@gmail.com>
 <20210617231305.GA3139128@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617231305.GA3139128@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/17 06:13PM, Bjorn Helgaas wrote:
> "Add new" in subject and below is slightly redundant.
>
> On Tue, Jun 08, 2021 at 11:18:51AM +0530, Amey Narkhede wrote:
> > Introduce a new array reset_methods in struct pci_dev to keep track of
> > reset mechanisms supported by the device and their ordering.
> > Also refactor probing and reset functions to take advantage of calling
> > convention of reset functions.
> >
> > Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> > Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/pci/pci.c   | 108 ++++++++++++++++++++++++++------------------
> >  drivers/pci/pci.h   |   8 +++-
> >  drivers/pci/probe.c |   5 +-
> >  include/linux/pci.h |   7 +++
> >  4 files changed, 81 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 3bf36924c..39a9ea8bb 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
> >  		msleep(delay);
> >  }
> >
> > +bool pci_reset_supported(struct pci_dev *dev)
> > +{
> > +	u8 null_reset_methods[PCI_RESET_METHODS_NUM] = { 0 };
> > +
> > +	return memcmp(null_reset_methods,
> > +		      dev->reset_methods, PCI_RESET_METHODS_NUM);
>
> memcmp() doesn't actually return a bool.  Either just return int
> and rely on the C "anything non-zero is true, zero is false" or
> convert the memcmp result to bool, i.e., something like:
>
>   if (memcmp(...) == 0)
>     return true;
>   return false;
>
> > +}
> > +
> >  #ifdef CONFIG_PCI_DOMAINS
> >  int pci_domains_supported = 1;
> >  #endif
> > @@ -5107,6 +5115,18 @@ static void pci_dev_restore(struct pci_dev *dev)
> >  		err_handler->reset_done(dev);
> >  }
> >
> > +/*
> > + * The ordering for functions in pci_reset_fn_methods is required for
> > + * reset_methods byte array defined in struct pci_dev.
>
> I'm not quite sure what this comment is telling me.  What breaks if I
> change the order?  If I add a new method, how do I know where to put
> it?
>
> By reading the code, I infer that:
>
>   - Each dev has dev->reset_methods[PCI_RESET_METHODS_NUM]
>
>   - dev->reset_methods[i] corresponds to pci_reset_fn_methods[i]
>
>   - dev->reset_methods[i] == 0 means dev doesn't support that method
>
>   - Otherwise, dev->reset_methods[i] is a value in the range of
>     [1, PCI_RESET_METHODS_NUM], and the higher the number, the higher
>     the reset method priority
>
>   - The order in pci_reset_fn_methods[] determines the initial
>     priority via pci_init_reset_methods(), but the priority can be
>     changed via sysfs
>
Correct. I agree the comment is not clear. Adding new reset method won't break
anything unless default order is changed and user has some assumptions from
previous versions of kernel.
> > + */
> > +const struct pci_reset_fn_method pci_reset_fn_methods[] = {
> > +	{ &pci_dev_specific_reset, .name = "device_specific" },
> > +	{ &pcie_reset_flr, .name = "flr" },
> > +	{ &pci_af_flr, .name = "af_flr" },
> > +	{ &pci_pm_reset, .name = "pm" },
> > +	{ &pci_reset_bus_function, .name = "bus" },
> > +};
> > +
> >  /**
> >   * __pci_reset_function_locked - reset a PCI device function while holding
> >   * the @dev mutex lock.
> > @@ -5129,65 +5149,67 @@ static void pci_dev_restore(struct pci_dev *dev)
> >   */
> >  int __pci_reset_function_locked(struct pci_dev *dev)
> >  {
> > -	int rc;
> > +	int i, rc = -ENOTTY;
> > +	u8 prio;
> >
> >  	might_sleep();
> >
> > -	/*
> > -	 * A reset method returns -ENOTTY if it doesn't support this device
> > -	 * and we should try the next method.
> > -	 *
> > -	 * If it returns 0 (success), we're finished.  If it returns any
> > -	 * other error, we're also finished: this indicates that further
> > -	 * reset mechanisms might be broken on the device.
> > -	 */
> > -	rc = pci_dev_specific_reset(dev, 0);
> > -	if (rc != -ENOTTY)
> > -		return rc;
> > -	rc = pcie_reset_flr(dev, 0);
> > -	if (rc != -ENOTTY)
> > -		return rc;
> > -	rc = pci_af_flr(dev, 0);
> > -	if (rc != -ENOTTY)
> > -		return rc;
> > -	rc = pci_pm_reset(dev, 0);
> > -	if (rc != -ENOTTY)
> > -		return rc;
> > -	return pci_reset_bus_function(dev, 0);
> > +	for (prio = PCI_RESET_METHODS_NUM; prio; prio--) {
> > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> > +			if (dev->reset_methods[i] == prio) {
> > +				/*
> > +				 * A reset method returns -ENOTTY if it doesn't
> > +				 * support this device and we should try the
> > +				 * next method.
> > +				 *
> > +				 * If it returns 0 (success), we're finished.
> > +				 * If it returns any other error, we're also
> > +				 * finished: this indicates that further reset
> > +				 * mechanisms might be broken on the device.
> > +				 */
> > +				rc = pci_reset_fn_methods[i].reset_fn(dev, 0);
> > +				if (rc != -ENOTTY)
> > +					return rc;
>
> Maybe leave the comment outside the loop where it used to be so the
> text lines are longer and it's easier to read.
>
> > +				break;
> > +			}
> > +		}
> > +		if (i == PCI_RESET_METHODS_NUM)
> > +			break;
> > +	}
> > +	return rc;
>
> I wonder if this would be easier if dev->reset_methods[] contained
> indices into pci_reset_fn_methods[], highest priority first, with the
> priority being determined when dev->reset_methods[] is updated.  For
> example:
>
>   const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>     { },                                                     # 0
>     { &pci_dev_specific_reset, .name = "device_specific" },  # 1
>     { &pci_dev_acpi_reset, .name = "acpi" },                 # 2
>     { &pcie_reset_flr, .name = "flr" },                      # 3
>     { &pci_af_flr, .name = "af_flr" },                       # 4
>     { &pci_pm_reset, .name = "pm" },                         # 5
>     { &pci_reset_bus_function, .name = "bus" },              # 6
>   };
>
>   dev->reset_methods[] = [1, 2, 3, 4, 5, 6]
>     means all reset methods are supported, in the default priority
>     order
>
>   dev->reset_methods[] = [1, 0, 0, 0, 0, 0]
>     means only pci_dev_specific_reset is supported
>
>   dev->reset_methods[] = [3, 5, 0, 0, 0, 0]
>     means pcie_reset_flr and pci_pm_reset are supported, in that
>     priority order
>
> Then we wouldn't need the nested loop and the return value would be
> easier to analyze:
>
>   for (i = 0; i < PCI_RESET_METHODS_NUM && (m = dev->reset_methods[i]); i++) {
>     rc = pci_reset_fn_methods[m].reset_fn(dev, 0);
>     if (rc == 0)
>       return 0;
>     if (rc != -ENOTTY)
>       return rc;
>   }
>   return -ENOTTY;
>
> pci_init_reset_methods() would be something like:
>
>   n = 0;
>   for (i = 1; i < PCI_RESET_METHODS_NUM; i++) {
>     rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
>     if (!rc)
>       dev->reset_methods[n++] = i;
>     if (rc != -ENOTTY)
>       return;
>   }
>
I had similar idea initially but couldn't put it in words nicely
thanks for this. I'll update this.
[...]

Thanks,
Amey
