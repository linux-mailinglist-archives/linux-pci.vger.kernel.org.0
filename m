Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF38D467EF1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 21:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383121AbhLCUvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 15:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhLCUvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 15:51:51 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284BBC061353
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 12:48:27 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso3478829pjb.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Dec 2021 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNT6B9whYmsy184prYD5kMbG4i53/KUJovkWhs7XTLE=;
        b=oIwzaq1zkIWYc/kL//qpxt4ey4dOwJ2Y7PuiAyEegaIW5FA8BPgGDRfu4gtimgVLAe
         q4V0s2sNEARpebMbpJa4JYJ3aooLUgLbr678Su5GOkyAkwwjXtRLOo1yLkqJoN8Gd6UP
         mWlUD02j5GW69PIT5jcU9AU3s/e1ScysUr6nrr7J15RL6D7/Uti3EaXNEMDzdT4qMbSd
         5kwX2cRgQjOFIZuTyjS51ac9HlF9W/Q2cn2IAF43tEbDo93uLDRDiCFTUyjodWL+idvX
         LYjQNp06YACwbRPTV0p0Z7Pz4IRjLrZq6lnNzIC8QgbMPA6bkfKnI7e7n5hWKpmJ5cN9
         9JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNT6B9whYmsy184prYD5kMbG4i53/KUJovkWhs7XTLE=;
        b=3c36AmpCYHRZrnyaWV5daxZVwQiaSOUqtIVfCQ0+fC9uVpRjaIGOlsOaLeLUBQioCd
         QtMQXfuB9coDL7ijSQO4vWYUbUPDqRGiQEa0jVEmHGrPF3AaLRu+enrdGaeuBVuCr1vW
         ssN8atASacq/fyInKc3eDCGWlCtMYRT2h+d4fr2L7wTWiNTNJ5Ec56f/DRQEgQ8GQamB
         Dy7ZA7pfOaRsqN2FGx3deCpdrO4pzol9Zdu2GHgoU0TJ8ctJmWKQw6dsjJZS8qJ/Gcrr
         u8sucTONlc7xtbXsTKo1biMkhypupmSpzt4xjnvuAgTEciUl/rHk2TdT+/wRU62lHOzr
         vnHg==
X-Gm-Message-State: AOAM5328lVEVbtsCo26DZJoPFI5zqxWuk5u3Vt4CqwPcfHvo1sLSxUn/
        v50jy77tOHr5gZWrnZzXwcX+J0opEy6I0QDw2p6aqA==
X-Google-Smtp-Source: ABdhPJxuv6hWNGcnuJgUHi3Fal3yKooDkqABsEv7McGCe709JL8ABuOX3ii0jhRBPgDZzLS5Gn9wrtGIukW6YDChSCs=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr16665852pjb.93.1638564506684;
 Fri, 03 Dec 2021 12:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20211105235056.3711389-3-ira.weiny@intel.com> <20211116234826.GA1598332@bhelgaas>
In-Reply-To: <20211116234826.GA1598332@bhelgaas>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Dec 2021 12:48:18 -0800
Message-ID: <CAPcyv4hDTitnqasVwLTV4QPJqW_ykoJc+hRVRm8aLzG4xBxVag@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI/DOE: Add Data Object Exchange Aux Driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 16, 2021 at 3:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Nov 05, 2021 at 04:50:53PM -0700, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Introduced in a PCI ECN [1], DOE provides a config space based mailbox
> > with standard protocol discovery.  Each mailbox is accessed through a
> > DOE Extended Capability.
> >
> > Define an auxiliary device driver which control DOE auxiliary devices
> > registered on the auxiliary bus.
>
> What do we gain by making this an auxiliary driver?
>
> This doesn't really feel like a "driver," and apparently it used to be
> a library.  I'd like to see the rationale and benefits of the driver
> approach (in the eventual commit log as well as the current email
> thread).
>

I asked Ira to use the auxiliary bus for DOE primarily for the ABI it
offers for userspace to manage kernel vs userspace access to a device.
CONFIG_IO_STRICT_DEVMEM set the precedent that userspace can not
clobber mmio space that is actively claimed by a kernel driver. I
submit that DOE merits the same protection for DOE instances that the
kernel consumes.

Unlike other PCI configuration registers that root userspace has no
reason to touch unless it wants to actively break things, DOE is a
mechanism that root userspace may need to access directly in some
cases. There are a few examples that come to mind.

CXL Compliance Testing (see CXL 2.0 14.16.4 Compliance Mode DOE)
offers a mechanism to set different test modes for a DOE device. The
kernel has no reason to ever use that interface, and it has strong
reasons to want to block access to it in production. However, hardware
vendors also use debug Linux builds for hardware bringup. So I would
like to be able to say that the mechanism to gain access to the
compliance DOE is to detach the aux DOE driver from the right aux DOE
device. Could we build a custom way to do the same for the DOE
library, sure, but why re-invent the wheel when udev and the driver
model can handle this type of policy question already?

Another use case is SPDM where an agent can establish a secure message
passing channel to a device, or paravirtualized device to exchange
protected messages with the hypervisor. My expectation is that in
addition to the kernel establishing SPDM sessions for PCI IDE and
CXL.cachemem IDE (link Integrity and Data Encryption) there will be
use cases for root userspace to establish their own SPDM session. In
that scenario as well the kernel can be told to give up control of a
specific DOE instance by detaching the aux device for its driver, but
otherwise the kernel driver can be assured that userspace will not
clobber its communications with its own attempts to talk over the DOE.

Lastly, and perhaps this is minor, the PCI core is a built-in object
and aux-bus allows for breaking out device library functionality like
this into a dedicated module. But yes, that's not a good reason unto
itself because you could "auxify" almost anything past the point of
reason just to get more modules.

> > A DOE mailbox is allowed to support any number of protocols while some
> > DOE protocol specifications apply additional restrictions.
>
> This sounds something like a fancy version of VPD, and VPD has been a
> huge headache.  I hope DOE avoids that ;)

Please say a bit more, I think DOE is a rather large headache as
evidenced by us fine folks grappling with how to architect the Linux
enabling.
