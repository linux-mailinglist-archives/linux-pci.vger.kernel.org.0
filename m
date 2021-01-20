Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA02FC54E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 01:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbhATACR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 19:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbhATABb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2021 19:01:31 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A86C061757
        for <linux-pci@vger.kernel.org>; Tue, 19 Jan 2021 16:00:50 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x78so13273399ybe.11
        for <linux-pci@vger.kernel.org>; Tue, 19 Jan 2021 16:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXowcYDvZcXKMzrFe9FqqTDON419/OKr3sdTZYFlcNc=;
        b=j0I/oY65AvJ7CU54ULhJ1qeloJ+tUy7Suv13S/8UGRdct5S1U8jqJtgzxSw4bqgHo0
         yrK3A/QwKI/9olI6wVBRt2hybEi1JNg5UciXh8FDI9oyJqGr4kiAc6bZq48259pH9cpX
         gd1k93jSKgdDgnpcNnX/C73ZSypJxkVZUOHBO48boKgjMvSsPr1EDj6vsQdL9axQLRrc
         /T9nB0wQRj1MlR7RxqmLvOKSgoyko5pIvX7rcpazCz4FXZxcCfzIn5VY9zfwABcTcn07
         g/eariP4frZx7HX41ZYN8COsV2lZk0Yg3ygglu2ORdvSh6nAzSQrZCHIGkIzxBcFmSlY
         uO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXowcYDvZcXKMzrFe9FqqTDON419/OKr3sdTZYFlcNc=;
        b=RrTeo3dqMjBtID5Zg087HmyYNFMmo/LLMPAulfteevzdoi/1DpLIJpb/LnyQTdrw19
         9YztW1invL02u1PdV27vm6Dz2WC8oUlPXkJjwjlzFDeRoiDyT2110fhCDFwO5EXJorHl
         liFDqyHfSMq0vUi3G1ot0eT8o8CPb+SG99UQErnopFz7VMgjgK07sX8eTMojFuzHbjoj
         ubia1P6GaNiUEPXrJgKVFZ2QKUDG4pWjjMVSul2VWzq525NwHFU4sxMcr9iWdjAPa8ef
         iim/9TZek+QCLtxEtT10+dDypbsqMhshHzBPQ2VdIcNPDfxXNiWe1d45M1sLWxy94Vn5
         eZDQ==
X-Gm-Message-State: AOAM5323GWT0j058Pehphijsv/2mlxc7CUMiCTfaTMi/xk/dlTFtvorX
        +CxPmISeK+/HewihoUlGQHTCO2mANKF+n+qJhpYxwg==
X-Google-Smtp-Source: ABdhPJw5WAIHI4c3zIOTDPo9BjXenLy0BPhFyl4vUZqVjWpXCCRqzn59hUQZuomKdzC+jWBZv9W9ZAJt+QV+jZKyzb8=
X-Received: by 2002:a25:77d4:: with SMTP id s203mr10670708ybc.32.1611100849671;
 Tue, 19 Jan 2021 16:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-6-saravanak@google.com>
 <20210117230134.32042-1-michael@walle.cc> <CAGETcx9=6fPAHLuMyfxfXTGxeSUO8FwHVU_F4bfqLTfK6c+eXw@mail.gmail.com>
 <4b9ae679b6f76d2f7e340e2ec229dd53@walle.cc>
In-Reply-To: <4b9ae679b6f76d2f7e340e2ec229dd53@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 19 Jan 2021 16:00:13 -0800
Message-ID: <CAGETcx-s1Hc8iiForpoeqP6Tf-syOYvxHMui+3vRJFmqArL+-A@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
To:     Michael Walle <michael@walle.cc>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 19, 2021 at 2:41 AM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-01-18 22:01, schrieb Saravana Kannan:
> > On Sun, Jan 17, 2021 at 3:01 PM Michael Walle <michael@walle.cc> wrote:
> >> > Cyclic dependencies in some firmware was one of the last remaining
> >> > reasons fw_devlink=on couldn't be set by default. Now that cyclic
> >> > dependencies don't block probing, set fw_devlink=on by default.
> >> >
> >> > Setting fw_devlink=on by default brings a bunch of benefits (currently,
> >> > only for systems with device tree firmware):
> >> > * Significantly cuts down deferred probes.
> >> > * Device probe is effectively attempted in graph order.
> >> > * Makes it much easier to load drivers as modules without having to
> >> >   worry about functional dependencies between modules (depmod is still
> >> >   needed for symbol dependencies).
> >> >
> >> > If this patch prevents some devices from probing, it's very likely due
> >> > to the system having one or more device drivers that "probe"/set up a
> >> > device (DT node with compatible property) without creating a struct
> >> > device for it.  If we hit such cases, the device drivers need to be
> >> > fixed so that they populate struct devices and probe them like normal
> >> > device drivers so that the driver core is aware of the devices and their
> >> > status. See [1] for an example of such a case.
> >> >
> >> > [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> >> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>
> >> This breaks (at least) probing of the PCIe controllers of my board.
> >> The
> >> driver in question is
> >>   drivers/pci/controller/dwc/pci-layerscape.c
> >> I've also put the maintainers of this driver on CC. Looks like it uses
> >> a
> >> proper struct device. But it uses builtin_platform_driver_probe() and
> >> apparently it waits for the iommu which uses module_platform_driver().
> >> Dunno if that will work together.
> >
> > Yeah, the builtin vs module doesn't matter. I've had fw_devlink work
> > multiple times with the consumer driver being built in and the
> > supplier actually loaded as a module. Making that work is one of the
> > goals of fw_devlink.
>
> Ok.

Hi Michael,

My bad, I spoke too soon. I thought you were talking about builtin_ vs
module_. My response is correct in that context. But the problem here
is related to builtin_platform_driver_probe(). That macro expects the
device (PCI) to be added and ready to probe by the time it's called.
If not, it just gives up and frees the code. That's why it's not
getting called after the first attempt. Can you please convert it into
builtin_platform_driver()? It should be a pretty trivial change.

-Saravana

>
> >> The board device tree can be found here:
> >>   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> >>
> >> Attached is the log with enabled "probe deferral" messages enabled.
> >
> > I took a look at the logs. As you said, pci seems to be waiting on
> > iommu, but it's not clear why the iommu didn't probe by then. Can you
> > add initcall_debug=1 and enable the logs in device_link_add()? Btw, I
> > realize one compromise on the logs is to send them as an attachment
> > instead of inline. That way, it's still archived in the list, but I
> > don't have to deal with log lines getting wrapped, etc.
> >
> > Thanks for reporting the issues. Also, could you try picking up all of
> > these changes and giving it a shot. It's unlikely to help, but I want
> > to rule out issues related to fixes in progress.
> >
> > https://lore.kernel.org/lkml/20210116011412.3211292-1-saravanak@google.com/
> > https://lore.kernel.org/lkml/20210115210159.3090203-1-saravanak@google.com/
> > https://lore.kernel.org/lkml/20201218210750.3455872-1-saravanak@google.com/
>
> Did pick them up, the last one had a conflict due some superfluous
> lines.
> Maybe they got reordered in that arrray.
>
> Issue still persist. I've enabled the debug in device_link_add(), in
> device_links_check_suppliers() and booted with initcall_debug. Please
> see attached log. Lets see how that goes ;)
>
> [    0.132687] calling  ls_pcie_driver_init+0x0/0x38 @ 1
> [    0.132762] platform 3400000.pcie: probe deferral - supplier
> 5000000.iommu not ready
> [    0.132777] platform 3500000.pcie: probe deferral - supplier
> 5000000.iommu not ready
> [    0.132818] initcall ls_pcie_driver_init+0x0/0x38 returned -19 after
> 119 usecs
>
> After that, ls_pcie_driver_init() is never called again.
>
> -michael
