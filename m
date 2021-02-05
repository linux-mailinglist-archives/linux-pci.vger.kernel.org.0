Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAADB310F64
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhBEQUv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 11:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbhBEQS1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 11:18:27 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CEFC06174A
        for <linux-pci@vger.kernel.org>; Fri,  5 Feb 2021 10:00:08 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id v193so2940971oie.8
        for <linux-pci@vger.kernel.org>; Fri, 05 Feb 2021 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MXe1FrklPEy6TwlDAvZBmuTyGOc2DfnArPbV8rOP2tg=;
        b=Z2ORrOBi3R2pgbKMuBO72sNwbrAv+zZbNWuiGUefBu2+LNTjE6P7lfH0L9tniiZgno
         1SRO6Q95NQrIIpaJ+JT84hnB2pA1KXVeCH3aBbxybOg497Ee4I3V/l6w2/A76RuifHY3
         TT9SdUxPqfWpeiopSirnrGwMU8Q9uKIWxxwfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MXe1FrklPEy6TwlDAvZBmuTyGOc2DfnArPbV8rOP2tg=;
        b=d0mXcMhAbPuZ2rT9qZh4coPC4IGMMdHM/LtuD+BNVuTXAzPDaVZvDEeusQ9JJ+ET24
         L1KQjpbjEduFtS4IIarBborbiLGB/bycOiUd8yocCWnunu2YMZJzC+TRbzZaT/yXO49I
         UGHICzMgrSJdQm3pnPMNtxiC1ytWU5DVn2QEDPCghxka7TJGoNCsrL8FiloJulWuajUc
         7wrRDQmAoaRu9XHxvuXsLdMOcfVNB10MouLW4VunRuBuHRDEzYbL8ox6EX+lFAKZbHDT
         IJcvKyO4AMJCZI8oSn8WtaPvy9TrjBD2deCZbkqSiMC8Vs7WSPQYPkIguDvqI9kZw631
         lTfA==
X-Gm-Message-State: AOAM530x+LFmN7aF/paSmZETD1mz3dIM3dxtU7mcvJ4O2eFvnxB0HFUf
        RoS4ydIfdq+IcPgNFDyhMK7ESILhRCBSSYh8EOeZDQ==
X-Google-Smtp-Source: ABdhPJxXT5hwaK7XSrrJvyCqC83QJvaoYFYnp5faHrLma5xGzEBnozos9SCq5rXszWQmDQploWFir+3CMO05PnkA1T4=
X-Received: by 2002:aca:df42:: with SMTP id w63mr3902017oig.128.1612548006852;
 Fri, 05 Feb 2021 10:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20210205153809.GA179207@bjorn-Precision-5520> <423067e5-9d65-5f0f-bedc-9c5939a63be7@amd.com>
In-Reply-To: <423067e5-9d65-5f0f-bedc-9c5939a63be7@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 5 Feb 2021 18:59:55 +0100
Message-ID: <CAKMK7uHX=8LferSxaj5vdm4h1worDv_dxs=krurYvtzzBnbsVw@mail.gmail.com>
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
To:     Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 5, 2021 at 5:08 PM Andrey Grodzovsky
<Andrey.Grodzovsky@amd.com> wrote:
>
> + Daniel
>
>
> On 2/5/21 10:38 AM, Bjorn Helgaas wrote:
> > On Thu, Feb 04, 2021 at 11:03:10AM -0500, Andrey Grodzovsky wrote:
> >> + linux-pci mailing list and a bit of extra details bellow.
> >>
> >> On 2/2/21 12:51 PM, Andrey Grodzovsky wrote:
> >>> Bjorn, Sergey I would also like to use this opportunity to ask you a
> >>> question on a related topic - Hot unplug.
> >>> I've been working for a while on this (see latest patchset set here
> >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058595.html&amp;=
data=3D04%7C01%7CAndrey.Grodzovsky%40amd.com%7Ccb508648cdca4144b0af08d8c9ec=
0c9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481362958887459%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;sdata=3DIZgVF3%2Bq0vGwXBJo5gh8%2BaYEgYnXWqIhnfI3swFDCX=
U%3D&amp;reserved=3D0).
> >>> My question is specifically regarding this patch
> >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058606.html&amp;=
data=3D04%7C01%7CAndrey.Grodzovsky%40amd.com%7Ccb508648cdca4144b0af08d8c9ec=
0c9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481362958887459%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;sdata=3DARrUqyg%2F3NoCOs0l6hgaR3Fktqt2nz6Ab0FP9zSVx04%=
3D&amp;reserved=3D0
> >>> - the idea here is to
> >>> prevent any accesses to MMIO address ranges still mapped in kernel pa=
ge
> >
> > I think you're talking about a PCI BAR that is mapped into a user
> > process.
>
> For user mappings, including MMIO mappings, we have a reliable approach w=
here
> we invalidate device address space mappings for all user on first sign of=
 device
> disconnect
> and then on all subsequent page faults from the users accessing those ran=
ges we
> insert dummy zero page
> into their respective page tables. It's actually the kernel driver, where=
 no
> page faulting can be used
> such as for user space, I have issues on how to protect from keep accessi=
ng
> those ranges which already are released
> by PCI subsystem and hence can be allocated to another hot plugging devic=
e.

Hm what's the access here? At least on the drm side we should be able
to tear everything down when our ->remove callback is called.

Or I might also be missing too much of the thread context.

> > It is impossible to reliably *prevent* MMIO accesses to a BAR on a
> > PCI device that has been unplugged.  There is always a window where
> > the CPU issues a load/store and the device is unplugged before the
> > load/store completes.
> >
> > If a PCIe device is unplugged, an MMIO read to that BAR will complete
> > on PCIe with an uncorrectable fatal error.  When that happens there is
> > no valid data from the PCIe device, so the PCIe host bridge typically
> > fabricates ~0 data so the CPU load instruction can complete.
> >
> > If you want to reliably recover from unplugs like this, I think you
> > have to check for that ~0 data at the important points, i.e., where
> > you make decisions based on the data.  Of course, ~0 may be valid data
> > in some cases.  You have to use your knowledge of the device
> > programming model to determine whether ~0 is possible, and if it is,
> > check in some other way, like another MMIO read, to tell whether the
> > read succeeded and returned ~0, or failed because of PCIe error and
> > returned ~0.
>
> Looks like there is a high performance price to pay for this approach if =
we
> protect at every possible junction (e.g. register read/write accessors ),=
 I
> tested this by doing 1M read/writes while using drm_dev_enter/drm_dev_exi=
t which
> is DRM's RCU based guard against device unplug and even then we hit perfo=
rmance
> penalty of 40%. I assume that with actual MMIO read (e.g. pci_device_is_p=
resent)
>   will cause a much larger performance
> penalty.

Hm that's surprising much (for the SRCU check), but then checking for
every read/write really is a bit overkill I think.
-Daniel


> Andrey
>
> >
> >>> table by the driver AFTER the device is gone physically and from the
> >>> PCI  subsystem, post pci_driver.remove
> >>> call back execution. This happens because struct device (and struct
> >>> drm_device representing the graphic card) are still present because s=
ome
> >>> user clients which  are not aware
> >>> of hot removal still hold device file open and hence prevents device
> >>> refcount to drop to 0. The solution in this patch is brute force wher=
e
> >>> we try and find any place we access MMIO
> >>> mapped to kernel address space and guard against the write access wit=
h a
> >>> 'device-unplug' flag. This solution is obliviously racy because a dev=
ice
> >>> can be unplugged right after checking the falg.
> >>> I had an idea to instead not release but to keep those ranges reserve=
d
> >>> even after pci_driver.remove, until DRM device is destroyed when it's
> >>> refcount drops to 0 and by this to prevent new devices plugged in
> >>> and allocated some of the same MMIO address  range to get accidental
> >>> writes into their registers.
> >>> But, on dri-devel I was advised that this will upset the PCI subsyste=
m
> >>> and so best to be avoided but I still would like another opinion from
> >>> PCI experts on whether this approach is indeed not possible ?
> >>>
> >>> Andrey



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
