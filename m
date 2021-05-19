Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60AF389A19
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 01:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhESXxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhESXxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 19:53:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BA3C06175F
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 16:51:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i7so4620917ejc.5
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVoBMaI0GwGtaYoKzmIr4922Id3E65a6BTx3LFwZWRk=;
        b=ReJ1N3XK2j0uu0sd75SJlG4JrRwVcqiVWKKAm6uHfUSmLas6m3qmqn0w1/1hVKQA1L
         AdYJNSfVnHxInu48wHMa0+V+xu8wExeljZY297Kd/tRzEY3J/C+z3jNUdAYzUVPFjO2F
         PFD3qjLT1Uz3XsU78atT6FQaDct5hSQwmy1gDHGKbZgf4Hzr+KVdQjRJSabipL12N5y1
         sDentQn5/UquLp1ZbxaRxPJXutOtww8gYnYOqcj0GPmWB4Q4HR+/9PdBjBUBh1aXped1
         pJ7p4ev5yeM33ljgmn9SBmcl69JorvsAnCUE51ICNF+cCGU17HuXhf/iXQZm7uB1CZxS
         pOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVoBMaI0GwGtaYoKzmIr4922Id3E65a6BTx3LFwZWRk=;
        b=GeMi3voHkj+YWybOzQidQmDJDdbtOl56K15HytuMf2EQUmCpW5APF7QLKExCZgRSBD
         tosK7Uf3/R1nBUrZfOMeDoWHql2JJZ3bpC7REVBffN1S7s+Sj4wMb+DNfmfCkAfgviWi
         h57hOQznpLZ3dV5c2hxfyad3P8NfQRxM01rNfabOFh0BJ6v59YoDZ/0TV4K2NCH1/o9X
         SixK9YyzXvZbso6sv7n+jDHCq+PVGkOHvJUuSSnm+67JzCpX/+QS7yzLp7u4cyua/h5/
         hiki1NZuG60h0xnGgc8nvf0XynMCCy3CmTltY/cRMwvsjmsqEFxg9ctdXIGN7efNIryd
         pY4A==
X-Gm-Message-State: AOAM533JKdXEcoRV08LwT/L/z4As4kRmgCACkhehjWy46i7e/zwJaHuJ
        qdlk09V+V3QFXKHqOy0xNzMbGL4d4VYrE9rwmcS60w==
X-Google-Smtp-Source: ABdhPJx8ix2K1zcTT1uwJnnqS4H4ljqDrqiR5i5DDmY5S8ZVeMmy2N9u/STSoeX+SRfH/K/NJX8MQSaVyGX/N02Y22M=
X-Received: by 2002:a17:906:d285:: with SMTP id ay5mr1687691ejb.418.1621468306605;
 Wed, 19 May 2021 16:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com> <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
 <20210511175006.00007861@Huawei.com> <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
 <20210514094755.00002081@Huawei.com> <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
 <20210517094045.00004d58@Huawei.com> <CAPcyv4iQcV_U1qmQhXKM0RG9v-sAEPwtTxnv=P86yJrCH25k+w@mail.gmail.com>
 <20210518110403.000013e6@Huawei.com> <CAPcyv4g3JPtAHzemKdQiM44ZkZ_0u+U-UJ5mfeU3fKzRWuaDyQ@mail.gmail.com>
 <20210519161156.00003bf9@Huawei.com> <CAPcyv4j_oEWG1NG1wYryVt3-Gx8q2WwzP7_xhchsDARDR0zBEA@mail.gmail.com>
 <20210519172052.00002124@Huawei.com> <20210519173352.000026fe@Huawei.com>
 <CAPcyv4gUy0nNh-3y2wWVwM4AtO4F8OOJCtWz_ZH7Eu0H=oymuw@mail.gmail.com>
 <20210519180057.00002ac3@Huawei.com> <CAPcyv4ii3KC6MBBxJrnCUCm_JGS7ugL+JTFUu9QTBnPUhQFtfQ@mail.gmail.com>
 <20210519211818.00002acf@Huawei.com>
In-Reply-To: <20210519211818.00002acf@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 16:51:36 -0700
Message-ID: <CAPcyv4hCCqEPzGKh4hyjHEBE3jDn9iTA_WUOZMFptHKrX-2J_A@mail.gmail.com>
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

On Wed, May 19, 2021 at 1:20 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 19 May 2021 12:20:17 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Wed, May 19, 2021 at 10:03 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > [..]
> > > > > "The DOE Busy bit can be used to indicate that the DOE responder is
> > > > >  temporarily unable to accept a data object. It is necessary for a
> > > > >  DOE requester to ensure that individual data object transfers are
> > > > >  completed, and that a request/response contract is completed, for
> > > > >  example using a mutex mechanism to block other conflicting traffic
> > > > >  for cases where such conflicts are possible."
> > > >
> > > > I read that as the specification mandating my proposal to disallow
> > > > multi-initiator access. My only mistake was making the exclusion apply
> > > > to reads and not limiting it to the minimum of config write exclusion.
> > >
> > > Key thing is even that isn't enough.   The mutex isn't about stopping
> > > temporary access, it's about ensuring "request/response contract is completed".
> > > So you would need userspace to be able to take a lock to stop the kernel
> > > from using the DOE whilst it completes it's request/response pair and
> > > userspace to guarantee it doesn't do anything stupid.
> >
> > A userspace lockout of the kernel is not needed if userspace is
> > outright forbidden from corrupting the kernel's state machine. I.e.
> > kernel enforced full disable of user initiated config-write to DOE
> > registers, not the ephemeral pci_cfg_access_lock() proposal.
>
> That would work but I thought was ruled out as an approach.
> @Bjorn would this be acceptable?
>

It sounded like Bjorn needed more convincing:

    "I don't know how hard we should work to protect against that."

...and I'm advocating that yes, DOE config-writes are in a different
class than other critical register writes, and that class is analogous
to what Linux does for driver managed MMIO exclusion.

> >
> > > Easiest way to do that is provide proper interfaces that allows the
> > > kernel to fully mediate the access + don't support direct userspace access
> > > for normal operation. (treat it the same as an other config space write)
> >
> > Again, it's the parenthetical at issue. I struggle to see this as just
> > another errant / unwanted config-write when there is legitimate reason
> > for userspace to expect that touching the DOE is not destructive to
> > device operation as opposed to writes to other critical registers.
>
> True for specific protocols (CDAT). I'm fairly sure, with IDE you can take down
> the link encryption to the device, potentially (worst case?) resulting a memory
> access failure and a machine reboot or corruption of persistent memory.

No, that does not sound right. My reading of the PCI IDE spec
highlights a few exclusions that apply here:

1/ A DOE instance that implements the CMA/SPDM protocol will support
"no other data object protocol(s)".

2/ An SPDM session once established arranges for "requests that are
received through a different secure [SPDM] session must be discarded
by the Responder, and must not result in a response"

>
> > Where the kernel's legitimate-access and userspace's legitimate-access
> > to a resource collide, the kernel provides a mediation interface that
> > precludes conflicts. Otherwise, I don't understand why the kernel is
> > going through the trouble of /dev/mem and pci-mmap restrictions if it
> > is not supposed to be concerned about userspace corrupting driver
> > state.
>
> The short answer is that lock requirement, in the above note, rules
> out safe direct userspace use of the DOE (unless we can tell the kernel
> is not going to ever use it).

Linux has the mitigation for that situation defined already. It's the
mechanism for /dev/mem and pci-mmap exclusion: disable the driver to
enable unfettered userspace access (modulo kernel-lockdown is
disabled).

> Mediation must be done. Even if we safely
> protect the kernel side via aborts, userspace transactions can be
> interrupted in a fashion that is invisible to userspace (beyond maybe
> a timeout if the userspace code is hardened against this).

Right, ephemeral per-transaction lockout is more complicated to handle
than coarse lockout bounded to driver attach lifetime.

> So there is no
> legitimate use that is not fully mediated by the kernel. So ioctl
> or defined per protocol interfaces are the way forwards.

Agree, and Linux has historically tried to wrap specific protocols
around capabilities like this rather than defining raw passthroughs.
I.e. I'm equating DOE enabling policy to ACPI DSM enabling policy. So
per-protocol enabling is my expectation regardless of sysfs or ioctl.
In fact. for SPDM and IDE key establishment that is probably neither
ioctl nor sysfs, but instead a cooperation with the Linux keys api.

> Perhaps that's putting it rather strongly :)

No major disagreement on the big picture... just quibbling with
details at this point.
