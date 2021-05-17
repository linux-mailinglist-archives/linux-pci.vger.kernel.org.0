Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBEC383B2A
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbhEQRWn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbhEQRWn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 13:22:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEA3C061756
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 10:21:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b25so10363958eju.5
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSak/9y8LWCPIDO3G6CswSdOFb8LMwY6kG8ALECOcQ4=;
        b=FAoQU13gvykSeVPaT8SD0dcXsm4yCutPyV3HXGbrkMqJURqJJ1TpCC2N9Sby2v9Quu
         SxEDs9LDJrwAQ7+xPzYiZmHAFww2P6PNBPs5s2nkSPuZp+MTzuMyyZ5beiPs+5UfN2mT
         xGKwFWY4bNQ2WSd4YF6rlGmI5eoa++Lymx2PKTFoCA2kXd33AOOPsMGvM+KJzM90Skwn
         5DNpXxhL0Iras7qtd/gCMDz9CGnp2/wSFPpmt4GoEVGvWKxYmlsaSE1cjNQSje8OFsiE
         ++BQ+plVjguBvcA0RzBTh+3tH0tiGrNYLkZ2uh0afF6wM6z2X+T9p0fmruHcfs/C/ekM
         EYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSak/9y8LWCPIDO3G6CswSdOFb8LMwY6kG8ALECOcQ4=;
        b=WKNWEM9QH0nUaqmEwhEkQkNMMy06TD5YVKf7xP4VkniX/QPtHVHGKpw9/lPuo3twaE
         hB7j5RzYqZ/k6rMqOuBrNkoTTLV4dHlTHiiiHNbK7sTZeeVqP+3Cq0wUkQia+r2/aTeB
         FVuCvvyYGg3DbAyYPQ9mVmglkRmGgEgamObd7P4Nsp0Bbo91ehye/qCgtPjQtJWuKMe5
         zHhiMThQ+tyfGEZPOEjma7SEBuQ0+cUMXdn+1eqJmhdW6+lFjNqYNXkkO7lk+we5CJN6
         QaJaFnkpjatrOcRMs0hOGuK4KQuQL/yjXkNAurCk62bkojpEuenPdhWtlUA2mIV4MLvz
         uh4Q==
X-Gm-Message-State: AOAM532h00tHzUqous3RdY3nbMDJKrXFvR3Clk10e5hIp1P0hk5gXQ98
        ci6FzI00UjxI1Zim0IJ2b5Lb9PNBrBZsmiWj0bshvg==
X-Google-Smtp-Source: ABdhPJwDSuY1Ew65cNeQBqF/NU4BCq0/RPemhz48ePAYjbpwvuGcrf2z9Kf9uaXqxeWBtzA0bGQ4GodiWR5b72do9Cs=
X-Received: by 2002:a17:907:3e28:: with SMTP id hp40mr1001966ejc.523.1621272085131;
 Mon, 17 May 2021 10:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com> <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
 <20210511175006.00007861@Huawei.com> <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
 <20210514094755.00002081@Huawei.com> <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
 <20210517094045.00004d58@Huawei.com>
In-Reply-To: <20210517094045.00004d58@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 May 2021 10:21:14 -0700
Message-ID: <CAPcyv4iQcV_U1qmQhXKM0RG9v-sAEPwtTxnv=P86yJrCH25k+w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 1:42 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 14 May 2021 11:37:12 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Fri, May 14, 2021 at 1:50 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > [..]
> > > > If it simplifies the kernel implementation to assume single
> > > > kernel-initiator then I think that's more than enough reason to block
> > > > out userspace, and/or provide userspace a method to get into the
> > > > kernel's queue for service.
> > >
> > > This last suggestion makes sense to me. Let's provide a 'right' way
> > > to access the DOE from user space. I like the idea if it being possible
> > > to run CXL compliance tests from userspace whilst the driver is loaded.
> >
> > Ah, and I like your observation that once the kernel provides a
> > "right" way to access DOE then userspace direct-access of DOE is
> > indeed a "you get to keep the pieces" event like any other unwanted
> > userspace config-write.
> >
> > > Bjorn, given this would be a generic PCI thing, any preference for what
> > > this interface might look like?   /dev/pcidoe[xxxxxx].i with ioctls similar
> > > to those for the BAR based CXL mailboxes?
> >
> > (warning, anti-ioctl bias incoming...)
>
> I feel very similar about ioctls - my immediate thought was to shove this in
> debugfs, but that feels the wrong choice if we are trying to persuade people
> to use it instead of writing code that directly accesses the config space.
>
> >
> > Hmm, DOE has an enumeration capability, could the DOE driver use a
> > scheme to have a sysfs bin_attr per discovered object type? This would
> > make it simliar to the pci-vpd sysfs interface.
>
> We can discover the protocols, but anything beyond that is protocol
> specific.  I don't think there is a enough info available by any standards
> defined method. Also part of the reason to allow a safe userspace interface
> would be to provide a generic interface for vendor protocols and things like
> CXL compliance tests where we will almost certainly never provide a more
> specific kernel interface.
>
> Whilst sysfs would work for CDAT, some protocols are challenge response rather
> than simple read back and that really doesn't fit well for sysfs model.
> If we get other protocols that are simple data read back, then I would
> advocate giving them a simple sysfs interface much like proposed for CDAT
> as it will always be simpler to use + self describing.
>
> On a lesser note it might be helpful to provide sysfs attrs for
> what protocols are supported.  The alternative is to let userspace run
> the discovery protocol. Perhaps we can do this as a later phase.
>
> >
> > Then the kernel could cache objects like CDAT that don't change
> > outside of some invalidation event.
>
> It's been a while since I last saw any conversation on sysfs bin_attrs
> but mostly I thought the feeling was pretty strongly against them for anything
> but a few niche usecases.
>
> Feels to me like it would break most of the usual rules in a way vpd does
> not (IIRC VPD is supposed to be a simple in the sense that if you write a value
> to a writable part, you will read back the same value).
>
> +CC Greg who is a fount of knowledge in this area (and regularly + correctly
> screams at the ways I try to abuse sysfs :)  Note I don't think Dan was
> suggesting implementing response / request directly, but I think that is
> all we could do given DOE protocols can be vendor specific and the standard
> discovery protocol doesn't let us know the fine grained support (what commands
> within a given protocol).

I'm not all that interested in supporting vendor defined DOE
shenanigans. There's more than enough published DOE protocols that the
kernel could limit its support to the known set. This is similar to
how ACPI DSMs are not generically supported, but when they appear in a
published specification the kernel may then grow the support. The
supported protocols could be limited to: CDAT, PCIe IDE, CXL
Compliance, etc...

Vendor specific DOE is in the same class as unfettered /dev/mem
access, first you need to disable the kernel's integrity and
confidentiality protections, and then you can do whatever you want. If
a vendor wants a DOE protocol supported in the "trusted" set they can
simply publish the specification and send the proper support patches.
