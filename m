Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451E53D95A7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhG1S6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 14:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG1S6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 14:58:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFFBC061757;
        Wed, 28 Jul 2021 11:58:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so11517217pja.5;
        Wed, 28 Jul 2021 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H3d8ZU/3s9mJnVZ38Nbhf4c96oMtxjv/JXd1CeLPtLI=;
        b=F7lAeSaIz2WZ5JhuPhWiOUVMltOuLas0bslRg9Jk92txIQ4p5iPL/ku2nO30QlNgos
         FqHudcHLxQvVCvbl+qvoazCwFNVfKgBUsvSKMFvzm2VnZuSPCPXyrpBQ9SiAljxxskd6
         50ftaKTJq7vTGp1Tz87AKjVnAv7UHA0MRnjFUDp9PhTumfyz0JMIVQGvlKeP42Btd+Wj
         acmDX53fdAXhJgL6V1bsMlBEL7QM6tTuOYpxqCRtDVMnKk72U2JTrqS9r7LUWtEpoxkS
         EP3KUvdm+aVX8o505wymbqIfanbGsTsyyrSp0OtDwfLc3e2nEH0zSc7rUoHtiHr14HNc
         sG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H3d8ZU/3s9mJnVZ38Nbhf4c96oMtxjv/JXd1CeLPtLI=;
        b=t/pCRGkgrckR4gCa7RwMN824RFnuvp7Ms49PIhosX8uynHbwffCxBPwT//mJk5I1Ya
         CIg4EejIfWMVh73McctQIG6TnnmW+HDtw+xjuIOs1UIkxNZr38j7/yPuomw6YoZIYxsl
         j+Tg0QBu/KZFHrfLmCaLSPyWkoT4pVEmpdmyt5vTWWwekA6Hw3rdgFNCMasuhg9QynsW
         oWs9+amLKSdOukV5QZdMy9xtYnUKmZF4chiahhT6ZZe7joehGPUcT4MKg3fPAdJygpxH
         jxtjJrVKZCiNReCwcumo5nJT1105gBqn8D0jaquzk7svZY/qwQVpya9jHZWAYzZ5PPJH
         9qYA==
X-Gm-Message-State: AOAM530eh/vv4AgTv/F30BZMQGB7s+yMrD3A79cgQbEW7csgrmkE1GPJ
        dyxXTDvq+4nMjLud7JSimI4=
X-Google-Smtp-Source: ABdhPJzQNiqXcE4gUcE6XA6V3tXwK65VrKZnHeVWRQSJYSYOw/rgTYvYyi5ft4CgJJNQQwDac6jsKQ==
X-Received: by 2002:a65:5b4d:: with SMTP id y13mr353307pgr.84.1627498715124;
        Wed, 28 Jul 2021 11:58:35 -0700 (PDT)
Received: from localhost ([49.32.197.231])
        by smtp.gmail.com with ESMTPSA id q13sm6563931pjq.10.2021.07.28.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:58:34 -0700 (PDT)
Date:   Thu, 29 Jul 2021 00:28:31 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210728185831.isdqa5t5oxxjfhnv@archlinux>
References: <20210728175950.q75qcrfas5mcjych@archlinux>
 <20210728181333.GA836307@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728181333.GA836307@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/28 01:13PM, Bjorn Helgaas wrote:
> On Wed, Jul 28, 2021 at 11:29:50PM +0530, Amey Narkhede wrote:
> > On 21/07/27 06:28PM, Bjorn Helgaas wrote:
> > > On Fri, Jul 09, 2021 at 06:08:09PM +0530, Amey Narkhede wrote:
> > > > Add reset_method sysfs attribute to enable user to query and set user
> > > > preferred device reset methods and their ordering.
> > > >
> > > > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
> > > >  drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
> > > >  2 files changed, 122 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > > > index ef00fada2..43f4e33c7 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > > @@ -121,6 +121,25 @@ Description:
> > > >  		child buses, and re-discover devices removed earlier
> > > >  		from this part of the device tree.
> > > >
> > > > +What:		/sys/bus/pci/devices/.../reset_method
> > > > +Date:		March 2021
> > > > +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> > > > +Description:
> > > > +		Some devices allow an individual function to be reset
> > > > +		without affecting other functions in the same slot.
> > > > +
> > > > +		For devices that have this support, a file named
> > > > +		reset_method will be present in sysfs. Initially reading
> > > > +		this file will give names of the device supported reset
> > > > +		methods and their ordering. After write, this file will
> > > > +		give names and ordering of currently enabled reset methods.
> > > > +		Writing the name or comma separated list of names of any of
> > > > +		the device supported reset methods to this file will set
> > > > +		the reset methods and their ordering to be used when
> > > > +		resetting the device. Writing empty string to this file
> > > > +		will disable ability to reset the device and writing
> > > > +		"default" will return to the original value.
> > > > +
> > > >  What:		/sys/bus/pci/devices/.../reset
> > > >  Date:		July 2009
> > > >  Contact:	Michael S. Tsirkin <mst@redhat.com>
> > >
> > [...]
> >
> > > > +		int i;
> > > > +
> > > > +		if (sysfs_streq(name, ""))
> > > > +			continue;
> > > > +
> > > > +		name = strim(name);
> > > > +
> > > > +		for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> > > > +			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
> > > > +			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
> > > > +				reset_methods[n++] = i;
> > >
> > > Can we build this directly in pdev->reset_methods[] so we don't need
> > > the memcpy() below?
> > >
> > This is to avoid writing partial values directly to dev->reset_methods.
> > So for example if user writes flr,unsupported_value then
> > dev->reset_methods should not be modified even though flr is valid reset
> > method in this example to avoid partial writes. Either operation(in this
> > case writing supported reset methods to reset_method attr) succeeds
> > completely or it fails othewise.
>
> I guess the question is, if somebody writes
>
>   flr junk bus
>
> and we set the supported methods to "flr bus", is that OK?  It seems
> OK to me; obviously we have to protect ourselves from attack, but
> over-zealous checking can make things unnecessarily complicated.
The problem is once we encounter "junk" we return -EINVAL so in your
example we only set flr.

Thanks,
Amey
