Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C133D94CC
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhG1R75 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 13:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG1R75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 13:59:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12E9C061757;
        Wed, 28 Jul 2021 10:59:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so5245942pji.5;
        Wed, 28 Jul 2021 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KklQJMU2Fgefevf9VpkrECZdIoTO7jzAXK1VIukHwu8=;
        b=L1nZGZ2+3K2hafMuqZUgd9pui3wAkl7iK6MiSms5oPEBe0UCuzAFUrxzbtmMfImK8t
         +9Bv/V0iJL0KzghVUji8cRZfaiL1NfRpcFzqMLa4lwUJqMBwKn3aSQT6kPXvoztWRmNt
         8LG31tC58P3EmzVzKfnBxbvY4Ws1XdA22FJJp1PiuvZprV2yNJlmqa6oBWjb62j2/0uh
         GMKFcblwcIOnycE5NFafVAkLENmhicjubA50LHdd9uva/VO2hs9/VJ092o3GHYeN5Je0
         0WIBm3/Uq3CgKbLK1lh9weqcWo6jIDDrVCXSUzlUYRUG+ivG1x1okYMNxXgWeuwd2CWf
         MsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KklQJMU2Fgefevf9VpkrECZdIoTO7jzAXK1VIukHwu8=;
        b=WDknvmqT6vxcVf1q1OqEPMOPjOnZ6E3KbQ0sDTN/DSHC14+ITWoIoVYR52wQ6c4BNx
         xNv3kVYG2dF6wuJCOl+cm0CyYWKMq59I9EIuFECff/OytctN68dfwhCtWUGj4DaeyEAy
         dOtGKl/9k1OBI2oRoPY0qi2p9SaSIPsiimeFkdOalpS7evQMUv4gb4AIpVvlT+VSu1H2
         InFxAGQmUQwalCow/n1ErNlWu+bOebBgYCCjHAWY/EliLto5hhtlit99KwQa6FU0CL3K
         E0FDaZi+x+tcqJFylruqG0k3NzWb+NHwe2BuwKnU5Q+2QjZAU2HfgU/9nAi3/493dlcB
         55nQ==
X-Gm-Message-State: AOAM533vi2DpPvRw2z+xDe2woMRQ3Y5VBFZudbWc///oTbkoVmJIqEN/
        yUCOWBs29KDCCP6XL86XKHw=
X-Google-Smtp-Source: ABdhPJwvj2PGbfi3GzICBrSRhi0mCLdBpmHzIBdpfoA+rKu4q7f5T8RCu24ii8Rcy0/HDvQtfY25og==
X-Received: by 2002:a17:902:f68f:b029:12c:228a:5226 with SMTP id l15-20020a170902f68fb029012c228a5226mr878072plg.61.1627495194359;
        Wed, 28 Jul 2021 10:59:54 -0700 (PDT)
Received: from localhost ([49.32.197.231])
        by smtp.gmail.com with ESMTPSA id a35sm466501pgm.66.2021.07.28.10.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:59:54 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:29:50 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210728175950.q75qcrfas5mcjych@archlinux>
References: <20210709123813.8700-5-ameynarkhede03@gmail.com>
 <20210727232808.GA754831@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727232808.GA754831@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/27 06:28PM, Bjorn Helgaas wrote:
> On Fri, Jul 09, 2021 at 06:08:09PM +0530, Amey Narkhede wrote:
> > Add reset_method sysfs attribute to enable user to query and set user
> > preferred device reset methods and their ordering.
> >
> > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
> >  drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
> >  2 files changed, 122 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index ef00fada2..43f4e33c7 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -121,6 +121,25 @@ Description:
> >  		child buses, and re-discover devices removed earlier
> >  		from this part of the device tree.
> >
> > +What:		/sys/bus/pci/devices/.../reset_method
> > +Date:		March 2021
> > +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> > +Description:
> > +		Some devices allow an individual function to be reset
> > +		without affecting other functions in the same slot.
> > +
> > +		For devices that have this support, a file named
> > +		reset_method will be present in sysfs. Initially reading
> > +		this file will give names of the device supported reset
> > +		methods and their ordering. After write, this file will
> > +		give names and ordering of currently enabled reset methods.
> > +		Writing the name or comma separated list of names of any of
> > +		the device supported reset methods to this file will set
> > +		the reset methods and their ordering to be used when
> > +		resetting the device. Writing empty string to this file
> > +		will disable ability to reset the device and writing
> > +		"default" will return to the original value.
> > +
> >  What:		/sys/bus/pci/devices/.../reset
> >  Date:		July 2009
> >  Contact:	Michael S. Tsirkin <mst@redhat.com>
>
[...]

> > +		int i;
> > +
> > +		if (sysfs_streq(name, ""))
> > +			continue;
> > +
> > +		name = strim(name);
> > +
> > +		for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> > +			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
> > +			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
> > +				reset_methods[n++] = i;
>
> Can we build this directly in pdev->reset_methods[] so we don't need
> the memcpy() below?
>
This is to avoid writing partial values directly to dev->reset_methods.
So for example if user writes flr,unsupported_value then
dev->reset_methods should not be modified even though flr is valid reset
method in this example to avoid partial writes. Either operation(in this
case writing supported reset methods to reset_method attr) succeeds
completely or it fails othewise.

Thanks,
Amey

[...]
