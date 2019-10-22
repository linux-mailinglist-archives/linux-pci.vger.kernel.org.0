Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C525DFD81
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 08:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfJVGGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 02:06:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43544 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfJVGGg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Oct 2019 02:06:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id o44so13160180ota.10
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xOSIfdif9uKUdsI/EsdRrws7YarLncuD2LCby+lKnE=;
        b=dJ9U4UecP2Pgdci01tKyvW1Qe9dAeX42IiNDZhvDqJAbelwHlIXRoXnlVfi78vGBWP
         UsIG5BbRPlBSTCVtyy6cIcDyaUFyQQ0uVy5OCsPpnc/NGhZ8mv8UWfpuavrZ60iR8oRX
         vO6+4Zmcf4byzziL3xBQUGKmHvXccPboO7PXlqF6H2GCWIQYL7u5bwdkJQmZs3omBTFx
         Ujv4Cdw9cMl7MKDTtMCCSGVK95vWLm32eSw2j9a+TpdDInRGAp944EE36lGUhcKtfpXa
         7N3csYdoj9s208Bzus7FlQW4tqT1IASRYyeL+vRK6BGm8+WHUve6OH0jwGULHq2O1dda
         BJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xOSIfdif9uKUdsI/EsdRrws7YarLncuD2LCby+lKnE=;
        b=UrskskGXqs0MqANFX4JdSBarefRG2xhFmtF1bEjcuT5b+SzIcjd6uRQ1m+t/rJpetO
         J9+P9LvcjqEA+lVgGisrQz5ySKWKTXvXEK8sxsV6/wUPwDOTVfYyd3GSzBPMu8PHkvAM
         M76BHU7GRZJpHkeI6Of66uGCiF+mxRoB+xjxrOYGmuZA9KJZai06OPH+IEcl7+wS/2Iy
         GFIzxI0mNfwm25VNLSX+epZONnP1ewPr12GggnAyu4Ln8rAkotMJ2IBWH9V3ixfuSL+c
         LQjO2DCPfyv/FrRdc0yVFhF4xAJs75NjV41V9IQE0KGRwTFnoQXMRs2usehupuZasI2k
         jMCA==
X-Gm-Message-State: APjAAAW/ims+XdXVJrW+jAn01I2c2j9CoE1lfSTa1T2HbgJh1Dq4Hsir
        4XaXL4ip3AIiNYF+4+sBNxQ4d6l1o5f6LpNNjrY=
X-Google-Smtp-Source: APXvYqySfGk/L78n7YLo+SKXZH3+oyxsNH0VcwMuC36kYmbGQrmm1Gi4jewTt2CnfSMU8ScpS394wd0MJjDtW/8VnJI=
X-Received: by 2002:a9d:3e4e:: with SMTP id h14mr1412284otg.198.1571724395575;
 Mon, 21 Oct 2019 23:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8sCjSCgj_WKeEtxRwjF+PM392zeTQ3F3ZwQR=nPavFyXQ@mail.gmail.com>
 <b91c3f6e-cef5-c06d-4282-84c24d616533@ti.com> <CA+V-a8tFB=giGvcLNhfTaaQ-R8svXijcoQ_QUdRMX3Hb4Ur95Q@mail.gmail.com>
 <CA+V-a8vR+xar-TsTOiBtNfbYuP8Wb_ktuf-i7tOkQ+==rs7Rug@mail.gmail.com> <1ccb98e7-837d-059a-1292-f001b4bb66c6@ti.com>
In-Reply-To: <1ccb98e7-837d-059a-1292-f001b4bb66c6@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 22 Oct 2019 07:06:09 +0100
Message-ID: <CA+V-a8tesARYDpZ8n6=DJ2DMCuykikWfXx2bKe9XPRSq1yfZgg@mail.gmail.com>
Subject: Re: [Query] : PCIe - Endpoint Function
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,


On Tue, Oct 15, 2019 at 8:53 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Prabhakar,
>
> On 11/10/19 7:07 PM, Lad, Prabhakar wrote:
> > Hi Kishon
> >
> > On Fri, Oct 11, 2019 at 8:35 AM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> >>
> >> Hi Kishon,
> >>
> >> On Thu, Oct 10, 2019 at 12:32 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>>
> >>> Hi Prabhakar,
> >>>
> >>> On 10/10/19 4:57 PM, Lad, Prabhakar wrote:
> >>>> Hello,
> >>>>
> >>>> I am currently working on adding pcie-endpoint support for a
> >>>> controller, this controller doesn't support outbound- inbound address
> >>>> translations, it has 1-1 mapping between the CPU and PCI addresses,
> >>>> the current endpoint framework is based on  outbound-inbound
> >>>> translations, what is the best approach to add this support, or is
> >>>> there any WIP already for it ?
> >>>
> >>> How will the endpoint access host buffer without outbound ATU? I assume the PCI
> >>> address reserved for endpoint is not the full 32-bit or 64-bit address space?
> >>> In that case, the endpoint cannot directly access the host buffer (unless the
> >>> host already knows the address space of the endpoint and gives the endpoint an
> >>> address in its OB address space).
> >>>
> > I lied in my previous mail.
> >
> > a] The controller needs the cpu_address before starting the link, ie
> > with the current implementation,the bars physical address in endpoint
> > are assigned
> > using dma_alloc_coherent(), but I what I actually want here is the
> > phys_addr returned by pci_epc_mem_alloc_addr().
> >
> > b] In the pci_endpoint_test driver, the pci_address sent to the
> > endpoint driver is again dma_alloc_coherent(), but the address which I
> > actually want to
> > send to endpoint is the BAR's assigned regions in the RC.
>
> The BAR assigned regions are usually used by RC to access EP memory.
> dma_alloc_coherent() is used in pci_endpoint_test to allocate buffer in host
> memory to be accessed by EP. Can you again check if statement 'b' is accurate?
>
yes you were correct, I misread the manual I have a rough driver
working now, will post as
soon as I tidy it up.

Cheers,
--Prabhakar
