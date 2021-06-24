Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E333B3256
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhFXPPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhFXPPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 11:15:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0D8C061574;
        Thu, 24 Jun 2021 08:12:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c7-20020a17090ad907b029016faeeab0ccso6102212pjv.4;
        Thu, 24 Jun 2021 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I++4uMEcTuGw2BfmtX3AQuuRG9WweA+grH1hO3oOMI0=;
        b=LIaRvG4u4m0ZkmLFuNXfahT2MJggIPMzzsoiUFMm30HNCFVQRYTiqDqfJPWiBdG6rE
         ZF8ADuOtzJabCG7cCVkWFiFSDa1J15p+jTLtGe7HklPYHyGo6AGaL0kbwsl6h4sRVf1M
         8/bz8mbmT6mxhuK3et4euwzK7oUYmMdBafpbAqrxaDgxUN+8j24o+Gn+oubxGunBJ4kA
         ND025OxQA88vvfO8Suwdw530Fl2Tn7NAhY5uY+bzcKt/AlbqbiD5G0bS+qAIN5CW2uXc
         G3f41AvGEpQOs81ne03tbvnkqARlG3HAyvSG1YIrJa2YbRyN4IG8s4SErR1HCGLl4Jwc
         5WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I++4uMEcTuGw2BfmtX3AQuuRG9WweA+grH1hO3oOMI0=;
        b=I5u/GTcHavxKSd9d+A6O6UXh4tyc/QzS9XdJJZ616Z0/XO9UGA/G16fSkHl2KrGn11
         Jg6ywbIpgK8pxzAv2LuVtxWgfwXl/tjLbKrX/YWS/eSFxIPr37GIgBnMjqZy6U1ycOKj
         hqMie3Fia8djl1mqH9+3OusxHAEmyX6KvNO7njiDvevrtZLMdvkiHau54kLKfPJIljeS
         Owma2tXMPwFqdLN1biGpZ7HmDqbVO6cBCnb0GfmYYagWWt7x3U9PmUlxqFo1Pzn5V/20
         ej8imjbSJi46FOmpLp9TUJOBCS/2EUWsDS3n2as0HLm4bwghcxFBkz0h0VMACf+pMavj
         Pdzw==
X-Gm-Message-State: AOAM530CsQ/uDawMVbgOhUFpGTHR+cEZAEYzGrpr6pPUCWqkg/QdX4Z7
        jlTcDMAEo4bK0JAkOE3BHf8=
X-Google-Smtp-Source: ABdhPJwrN7EokPvZOFe7BEvJUtMJ+OMCroyVIeTW/0sbVX59L1m0TRG+nxZkvMFen37/cMkmyfAh9w==
X-Received: by 2002:a17:90a:d082:: with SMTP id k2mr16179928pju.15.1624547565615;
        Thu, 24 Jun 2021 08:12:45 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id t2sm3191465pfg.73.2021.06.24.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 08:12:45 -0700 (PDT)
Date:   Thu, 24 Jun 2021 20:42:42 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210624151242.ybew2z5rseuusj7v@archlinux>
References: <20210608054857.18963-5-ameynarkhede03@gmail.com>
 <20210624121521.GA3518338@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624121521.GA3518338@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/24 07:15AM, Bjorn Helgaas wrote:
> On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > Add reset_method sysfs attribute to enable user to
> > query and set user preferred device reset methods and
> > their ordering.
>
> > +		Writing the name or comma separated list of names of any of
> > +		the device supported reset methods to this file will set the
> > +		reset methods and their ordering to be used when resetting
> > +		the device.
>
> > +	while ((name = strsep(&options, ",")) != NULL) {
> > +		if (sysfs_streq(name, ""))
> > +			continue;
> > +
> > +		name = strim(name);
> > +
> > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> > +			if (reset_methods[i] &&
> > +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> > +				reset_methods[i] = prio--;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (i == PCI_RESET_METHODS_NUM) {
> > +			kfree(options);
> > +			return -EINVAL;
> > +		}
> > +	}
>
> Asking again since we didn't get this clarified before.  The above
> tells me that "reset_methods" allows the user to control the *order*
> in which we try reset methods.
>
> Consider the following two uses:
>
>   (1) # echo bus,flr > reset_methods
>
>   (2) # echo flr,bus > reset_methods
>
> Do these have the same effect or not?
>
They have different effect.
> If "reset_methods" allows control over the order, I expect them to be
> different: (1) would try a bus reset and, if the bus reset failed, an
> FLR, while (2) would try an FLR and, if the FLR failed, a bus reset.
Exactly you are right.

Now the point I was presenting was with new encoding we have to write
list of *all of the supported reset methods* in order for example, in
above example flr,bus or bus,flr. We can't just write 'flr' or 'bus'
then switch back to writing flr,bus/bus,flr(these have different effect
as mentioned earlier).

Basically with new encoding an user can't write subset of reset methods
they have to write list of *all* supported methods everytime.

Thanks,
Amey
