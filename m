Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9AD2A331D
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgKBSim (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 13:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBSim (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 13:38:42 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269AEC061A48
        for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2020 10:38:42 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id oq3so18404672ejb.7
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2020 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FmL/u76HpkWkIZ1lwZI2iKFfaATl6YIc/lrOPunHtE=;
        b=iBCQpoj52+oKBw/iSV8FEFEkhYmnTwpF0br3WaoOFmTDjMW1+3hQ12M9dZN0CaXESu
         OcPeyy7Z0a9bj1F9+XO/6JUSte9AcZr0pTj1O6ILZG5xUH0JkKFQAXGn4FFTImta43aI
         1sOTcaLgNT7cl5O13xJpxlRnFNLVc4pqyLctA1Lo9xIWYNxLHnj4WLI8edc2azsjAn0o
         qjEVVk9MnknDjl5ervc8CncdTWsNFUr8yj6Fab8chkK7djZ/VnhI1OWj5etCAuZEcBRP
         O86qLh16dGIiFzTWWx9wMf9+DsXdC+DrUBTQ7zJw2+0bd5mbLD7y+G+z6W9ULbVJH9yM
         YepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FmL/u76HpkWkIZ1lwZI2iKFfaATl6YIc/lrOPunHtE=;
        b=gs6xVa5+YSb3gN+rpv/iNwTWdymRXGwYkYbkLDoj1JCVCTeXa6iQmNJ1hfTjYnm7ow
         qQi/MKPLCG1GmxJyF7okSPaiBDkCcwu2IXugfI2E/S5WEl27tZSsmXq0E6sgaTxFEmya
         9c9cS2sIuCaCOCHxLg3zoUw8JCY4rWg9Oea4EoQGR1916pMJ8tCuaQbJ3QehG5JC50Ql
         BM7xXSuin46ySN4Jw9+ZW+/G9i/Uv+nPZHL3TySFDm5mox/E+rPlYjgFn09SLT6SyByS
         qnCn9Ey5n6ux0VZAGo0KxwS2UrlMGamnzH0/G7jcX3UipIFw/kUnngvTEcrhujtifEBJ
         YeJg==
X-Gm-Message-State: AOAM530n2wau08U5jNZ0gfgwQV/VX0echHlrYFJffVCSLWMlFwUFW8gn
        SDf8z0+VQH/rqMnPTr8hHw5FRRXHG+oITl7L4Fqgsg==
X-Google-Smtp-Source: ABdhPJwQt34VTljApUbAXh9zKA1SYJQyXEKz8ZoZ6ADLDk85uBrkBnOH9rKyleaA7zCjqWT1Vx/TpJVBdUll6q7UWQs=
X-Received: by 2002:a17:906:70cf:: with SMTP id g15mr16162410ejk.323.1604342320700;
 Mon, 02 Nov 2020 10:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20201030191706.GK2620339@nvidia.com> <20201030192325.GA105832@otc-nc-03>
 <20201030193045.GM2620339@nvidia.com> <20201030204307.GA683@otc-nc-03>
 <87h7qbkt18.fsf@nanos.tec.linutronix.de> <20201031235359.GA23878@araj-mobl1.jf.intel.com>
 <20201102132036.GX2620339@nvidia.com> <20201102162043.GB20783@otc-nc-03>
 <20201102171909.GF2620339@nvidia.com> <20d7c5fc-91b0-d673-d41a-335d91ca2dce@intel.com>
 <20201102182632.GH2620339@nvidia.com>
In-Reply-To: <20201102182632.GH2620339@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Nov 2020 10:38:28 -0800
Message-ID: <CAPcyv4h8O+boTo-MpGRSC8RpjrsvU-P3AU7_kwbrfDkEp8bH1w@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] Add VFIO mediated device support and DEV-MSI
 support for the idxd driver
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        "Dey, Megha" <megha.dey@intel.com>, maz@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Yi L Liu <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Sanjay K Kumar <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, Jing Lin <jing.lin@intel.com>,
        kwankhede@nvidia.com, eric.auger@redhat.com,
        Parav Pandit <parav@mellanox.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, netanelg@mellanox.com,
        shahafs@mellanox.com, yan.y.zhao@linux.intel.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Samuel Ortiz <samuel.ortiz@intel.com>,
        Mona Hossain <mona.hossain@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 2, 2020 at 10:26 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Nov 02, 2020 at 11:18:33AM -0700, Dave Jiang wrote:
> >
> >
> > On 11/2/2020 10:19 AM, Jason Gunthorpe wrote:
> > > On Mon, Nov 02, 2020 at 08:20:43AM -0800, Raj, Ashok wrote:
> > > > Creating these private interfaces for intra-module are just 1-1 and not
> > > > general purpose and every accelerator needs to create these instances.
> > >
> > > This is where we are going, auxillary bus should be merged soon which
> > > is specifically to connect these kinds of devices across subsystems
> >
> > I think this resolves the aux device probe/remove issue via a common bus.
> > But it does not help with the mdev device needing a lot of the device
> > handling calls from the parent driver as it share the same handling as the
> > parent device.
>
> The intention of auxiliary bus is that the two parts will tightly
> couple across some exported function interface.
>
> > My plan is to export all the needed call via EXPORT_SYMBOL_NS() so
> > the calls can be shared in its own namespace between the modules. Do
> > you have any objection with that?
>
> I think you will be the first to use the namespace stuff for this, it
> seems like a good idea and others should probably do so as well.

I was thinking either EXPORT_SYMBOL_NS, or auxiliary bus, because you
should be able to export an ops structure with all the necessary
callbacks. Aux bus seems cleaner because the lifetime rules and
ownership concerns are clearer.
