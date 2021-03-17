Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669E633EE42
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 11:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCQKZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 06:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhCQKZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 06:25:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B4C06174A;
        Wed, 17 Mar 2021 03:25:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1094468pjv.1;
        Wed, 17 Mar 2021 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oVrVd+qi36HQPmG6ITfzcisy1O/tpiI7VBj47jWX51A=;
        b=MpCRCzsKUzrwvCCuxVQQ+IBzxTocR+NF6hplvBOvlC4/ytCfOpUcEXn7wgssX13FEa
         ncA/TZ0uxGer+ChmhtrAuccBmZWHHEbep+n5WSF5BOjkCqJz9eqeYbFYILWeDVVhmEZB
         D740H9I6RoNZ68cmEC91RnXJTcdGAQoANnDQiP7ZRHtJNbbfLWZ4Oqh0ydDKPN0xAWWN
         SngCEmlqUveOZHneyN2YyrUFS3QNAXWGm/XvEe9xj+LpVUxYizBJ8fJAS58YxRLJJ5IJ
         /8frduQ26q2xhQT1/8CKa6AX1Itu/55Ozqh/iBSnUERFlzdbU2kgowscsDHvrmbS+aVL
         4Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oVrVd+qi36HQPmG6ITfzcisy1O/tpiI7VBj47jWX51A=;
        b=SPRIOCZyyaQVmkuzux2BVg+F1cGAdihVQ5FhUTyEYPPS/StqN9utfk7FN/gt0iT/2b
         KYjal2fiv2rvFkZdJzKKQYmwRvzVxakspVJafot5gd2CKhOBVN0M72DsPQ+wAk96mKeU
         q2mFcCpdkYMuLHj6ODINF8YHYSV+tU2xFDQj3TohWx4/EXvdN0w983S0frLULpcyAQon
         WAYRFyySuFhh12HlTUVwZh9N8KqNgELQnJA6FWifqk5p+8Pk3XUslBiZ0SMcimJUbbY0
         luWawI//8ra10YckJO3gV75T626sVGvynuihgddnq4qp6ihS7IrcSxSSqbXAnOLrXP8G
         b/dQ==
X-Gm-Message-State: AOAM5328KmiCHJOTURLfL8+7Tw+gtEZhs9IFFSqbc4leg5nSuS6y/oSC
        tkpKptHWLpj8LYZKZVPxgbQ=
X-Google-Smtp-Source: ABdhPJyyI3jQUZ4p4T4snyt7cOoYUJM9DQyPa7B3seh6DpBjVyLXEeJpNM5n4Q5uBEIInPrgFEkrYw==
X-Received: by 2002:a17:90a:b392:: with SMTP id e18mr3861406pjr.66.1615976729893;
        Wed, 17 Mar 2021 03:25:29 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id t22sm2284301pjo.45.2021.03.17.03.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:25:29 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:54:47 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, alay.shah@nutanix.com,
        suresh.gumpula@nutanix.com, shyam.rajendran@nutanix.com,
        felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210317102447.73no7mhox75xetlf@archlinux>
References: <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
 <20210315134323.llz2o7yhezwgealp@archlinux>
 <20210315135226.avwmnhkfsgof6ihw@pali>
 <20210315083409.08b1359b@x1.home.shazbot.org>
 <YE94InPHLWmOaH/b@unreal>
 <20210315153341.miip637z35mwv7fv@archlinux>
 <20210315102950.230de1d6@x1.home.shazbot.org>
 <20210315183226.GA14801@raphael-debian-dev>
 <YFGDgqdTLBhQL8mN@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFGDgqdTLBhQL8mN@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/17 06:20AM, Leon Romanovsky wrote:
> On Mon, Mar 15, 2021 at 06:32:32PM +0000, Raphael Norwitz wrote:
> > On Mon, Mar 15, 2021 at 10:29:50AM -0600, Alex Williamson wrote:
> > > On Mon, 15 Mar 2021 21:03:41 +0530
> > > Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> > >
> > > > On 21/03/15 05:07PM, Leon Romanovsky wrote:
> > > > > On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Williamson wrote:
> > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > >
> > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> > > > > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > > > > warm reset respectively.
> > > > > > >
> > > > > > > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > > > > > > type of reset, which is currently implemented only for PCIe hot plug
> > > > > > > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > > > > > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > > > > > kernel and therefore drivers do not export this type of reset via any
> > > > > > > kernel function (yet).
> > > > > >
> > > > > > Warm reset is beyond the scope of this series, but could be implemented
> > > > > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > > > > defined here.  Note that with this series the resets available through
> > > > > > pci_reset_function() and the per device reset attribute is sysfs remain
> > > > > > exactly the same as they are currently.  The bus and slot reset
> > > > > > methods used here are limited to devices where only a single function is
> > > > > > affected by the reset, therefore it is not like the patch you proposed
> > > > > > which performed a reset irrespective of the downstream devices.  This
> > > > > > series only enables selection of the existing methods.  Thanks,
> > > > >
> > > > > Alex,
> > > > >
> > > > > I asked the patch author here [1], but didn't get any response, maybe
> > > > > you can answer me. What is the use case scenario for this functionality?
> > > > >
> > > > > Thanks
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unreal/
> > > > >
> > > > Sorry for not responding immediately. There were some buggy wifi cards
> > > > which needed FLR explicitly not sure if that behavior is fixed in
> > > > drivers. Also there is use a case at Nutanix but the engineer who
> > > > is involved is on PTO that is why I did not respond immediately as
> > > > I don't know the details yet.
> > >
> > > And more generally, devices continue to have reset issues and we
> > > impose a fixed priority in our ordering.  We can and probably should
> > > continue to quirk devices when we find broken resets so that we have
> > > the best default behavior, but it's currently not easy for an end user
> > > to experiment, ie. this reset works, that one doesn't.  We might also
> > > have platform issues where a given reset works better on a certain
> > > platform.  Exposing a way to test these things might lead to better
> > > quirks.  In the case I think Pali was looking for, they wanted a
> > > mechanism to force a bus reset, if this was in reference to a single
> > > function device, this could be accomplished by setting a priority for
> > > that mechanism, which would translate to not only the sysfs reset
> > > attribute, but also the reset mechanism used by vfio-pci.  Thanks,
> > >
> > > Alex
> > >
> >
> > To confirm from our end - we have seen many such instances where default
> > reset methods have not worked well on our platform. Debugging these
> > issues is painful in practice, and this interface would make it far
> > easier.
> >
> > Having an interface like this would also help us better communicate the
> > issues we find with upstream. Allowing others to more easily test our
> > (or other entities') findings should give better visibility into
> > which issues apply to the device in general and which are platform
> > specific. In disambiguating the former from the latter, we should be
> > able to better quirk devices for everyone, and in the latter cases, this
> > interface allows for a safer and more elegant solution than any of the
> > current alternatives.
>
> So to summarize, we are talking about test and debug interface to
> overcome HW bugs, am I right?
>
> My personal experience shows that once the easy workaround exists
> (and write to generally available sysfs is very simple), the vendors
> and users desire for proper fix decreases drastically. IMHO, we will
> see increase of copy/paste in SO and blog posts, but reduce in quirks.
>
> My 2-cents.
>
I agree with your point but at least it gives the userspace ability
to use broken device until bug is fixed in upstream.
This is also applicable for obscure devices without upstream
drivers for example custom FPGA based devices.
Another main application which I forgot to mention is virtualization
where vmm wants to reset the device when the guest is reset,
to emulate machine reboot as closely as possible.

Thanks,
Amey
