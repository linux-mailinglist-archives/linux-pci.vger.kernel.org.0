Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0CE43AA4F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 04:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhJZCbZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 22:31:25 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42176
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234042AbhJZCbZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 22:31:25 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 048EA40257
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 02:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635215334;
        bh=tOLRBMY0jX7YDTdVmLEtwDdMQyVf9kqHb0/MM3F783U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=moEcbkViFSqZdV2BxT0V4QhOzYA9tSatlc2fUHt7SwP3EA2hXNFUEGcRd/AZiiYbn
         IDXPlA1FrPr8DGWCJzg9vZVlr1i3SH3894uDqyOBlZwGqr8lBkjLWbOXZR6j9wqmwD
         QbbogD1izZrl9FPS8dFbBvsdHkafEhUDD66+d+ZhPNFfRBCTWZJh2LJ0QzvF7SvMCm
         Uoozb/nxeYkp8Fsvu+CpIlxI0IXbwiVWjLF2/qvhXHNtyLotaRkS7+RVS/vimipy6d
         so6ZDlaHQMTARUY9yqd2ZOAAZOeOd+rfY+Nn+SrPYIHd3M/f7I/8xSNiXqdsMb4mD3
         kKuyBeMALKPaA==
Received: by mail-ot1-f69.google.com with SMTP id y22-20020a9d4616000000b0054e84ab2a68so8144753ote.16
        for <linux-pci@vger.kernel.org>; Mon, 25 Oct 2021 19:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOLRBMY0jX7YDTdVmLEtwDdMQyVf9kqHb0/MM3F783U=;
        b=nvaUve35ShjI0bsAMOxUd41oY30BjOpF9960TPX9Gp6zTsYWRdL9sHJZ3jF9kVNIXH
         Ct3dpRYfs9rt6oDmDe7duPEPp3yRuL8g6pZj5oGoSXYH/rp2NTyu6uFUHfd/5dq4PRot
         WcuKQJYIe9qzfT53AZJuSm15BW2DcPJM11S48GV++DnWrCHAjfd2IxO8kke7BvEpVrR+
         Ljhrv9LQpV/60DLiS4qFEbIQglskOEXY7/SKY865yZZJkKWvkbP+DAtUt4xO2gw90eXc
         0TXZ+O04ssmGWoe+tjiH8408MAotnCZrDsx4572t31E6HoUcXz02nMMd0tETUlZnl0Sm
         KdNA==
X-Gm-Message-State: AOAM530hJXsZqX6rJBIzvay37nlhKCbqhKfiCZtAUzIbnPUfuyS5dnFn
        VMD7lMgbSPLtoIfg5ZLQfSoeQJZKL8TPK0xoKAsa4ccRqMsHc+oi3qHr+AWyLtAFrbqp2BxnFMC
        Y5Vbgr6P6j+mVlzXQp0W/JRMvARHCgpFbpJ3R5AgGd3c39fWHoeITfQ==
X-Received: by 2002:a05:6830:1f55:: with SMTP id u21mr17426657oth.233.1635215332612;
        Mon, 25 Oct 2021 19:28:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhZxTtM9ayNN7IIpZ/th7pv8MT3IEz0ghG7Pxi/HTHuHHN8QLWnXWhqSHcpul2szT3/z4peIprv5V2VSHN9sM=
X-Received: by 2002:a05:6830:1f55:: with SMTP id u21mr17426636oth.233.1635215332344;
 Mon, 25 Oct 2021 19:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p4L+NGQE_Z8u5MBN4X3-3Jmj+FdWp+hGo8mumqsQNoxNg@mail.gmail.com>
 <20211025173117.GA7566@bhelgaas>
In-Reply-To: <20211025173117.GA7566@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 26 Oct 2021 10:28:38 +0800
Message-ID: <CAAd53p7cqnGmySsxSz1xTmUp=_O_vApMuvcg-cBFUHButpva7Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI/ASPM: Add LTR sysfs attributes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 1:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Oct 25, 2021 at 06:33:50PM +0800, Kai-Heng Feng wrote:
> > On Thu, Oct 21, 2021 at 11:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Oct 21, 2021 at 11:51:59AM +0800, Kai-Heng Feng wrote:
> > > > Sometimes BIOS may not be able to program ASPM and LTR settings, for
> > > > instance, the NVMe devices behind Intel VMD bridges. For this case, both
> > > > ASPM and LTR have to be enabled to have significant power saving.
> > > >
> > > > Since we still want POLICY_DEFAULT honor the default BIOS ASPM settings,
> > > > introduce LTR sysfs knobs so users can set max snoop and max nosnoop
> > > > latency manually or via udev rules.
> > >
> > > How is the user supposed to figure out what "max snoop" and "max
> > > nosnoop" values to program?
> >
> > Actually, the only way I know is to get the value from other OS.
>
> I don't see how this can be a workable solution.  IIUC this is
> specifically related to ASPM L1.2.  L1.2 depends on LTR (the max
> snoop/nosnoop values) and the TPOWER_ON and Common_Mode_Restore_Time
> values.  PCIe r5.0, sec 5.5.4, says:
>
>   Prior to setting either or both of the enable bits for L1.2, the
>   values for TPOWER_ON, Common_Mode_Restore_Time, and, if the ASPM
>   L1.2 Enable bit is to be Set, the LTR_L1.2_THRESHOLD (both Value and
>   Scale fields) must be programmed.
>
>   The TPOWER_ON and Common_Mode_Restore_Time fields must be programmed
>   to the appropriate values based on the components and AC coupling
>   capacitors used in the connection linking the two components. The
>   determination of these values is design implementation specific.
>
> I do not think collecting values from some other OS is a reasonable
> way to set these.  The values would apparently depend on the
> electrical design of the particular machine.

What if we fallback to the original approach and use the VMD driver to
enable ASPM and LTR values?
At least I think Intel should be able to provide correct values for their SoC.

>
> > > If we add this, I'm afraid we'll have people programming random things
> > > that seem to work but are not actually reliable.
> >
> > IMO users need to take full responsibility for own doings.
> > Also, it's already doable by using setpci...
>
> I don't think it currently does, but setpci should taint the kernel.
>
> If users want to write setpci scripts to fiddle with stuff, that's
> great, but that moves it outside the supportable realm.  If we provide
> a sysfs interface to do this, then it becomes more of *our* problem to
> make it work correctly, and I don't think that's practical in this
> case.

OK.

>
> > If we don't want to add LTR sysfs, what other options do we have to
> > enable VMD ASPM and LTR by default since BIOS doesn't do it for us?
> > 1) Enable it in the PCI or VMD driver, however this approach violates
> > POLICY_DEFAULT.
> > 2) Use `setpci` directly in udev rules to enable VMD ASPM and LTR.
> >
> > I think 2) is bad, and since 1) isn't so good either, the approach in
> > this patch may be the best compromise.
>
> I do not know how to safely enable L1.2.  It's likely that I'm just
> missing something, but I don't see enough information in PCI config
> space and the PCI Firmware interface (_DSM for Latency Tolerance
> Reporting) to enable L1.2.  It's possible that a new firmware
> interface is required.

I was told by Intel that they didn't use _DSM to get LTR values, at
least not the VMD case.

>
> I don't think it's wise to enable L1.2 unless we have good confidence
> that we know how to do it correctly.  It's hard enough to debug ASPM
> issues as it is.

So what other options do we have if we want to enable VMD ASPM while
keeping CONFIG_PCIEASPM_DEFAULT=y?
Right now we enabled the VMD ASPM/LTR bits in downstream kernel, but
other distro users may want to have upstream support for this.

Kai-Heng

>
> Bjorn
