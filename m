Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01AD30156
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfE3R4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 13:56:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45435 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3R4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2019 13:56:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id m14so5698274lfp.12
        for <linux-pci@vger.kernel.org>; Thu, 30 May 2019 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kznmoz7C+qs9+fS1R4x2KVGpxZXkzNDQtpMYN/bgS0w=;
        b=JT/fEl27W7OW7rJcwHTFEDIgpayKw/JcKZrccKW+R06f8yFn9Sfmqh1Y1+4eFFmINj
         APEMuKyil8NOFpMdzz9O3cIulvqjkdaZ2tOVr4o7IKRKHWjlMU10TWN403QDqTiF8GE+
         YMUDO7iGJIUsV3W1TTBlJHn341cr9XU4HEjMADWS4Hwpvt+DlNAxnMEGK68wm14STPK3
         V6OlCCKBbjh8qEkuB8VASZ4IEKTRT8ja3iIGVWU1VQ5qEJm8cjXWDNruPlhZRD2G2JfP
         wqXec1kI3sSfJPSkEVYF+NXpHw36TbeTGAPmx4rdsXx16WXyPtJjTNzE5VZuZKQPqe0F
         k/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kznmoz7C+qs9+fS1R4x2KVGpxZXkzNDQtpMYN/bgS0w=;
        b=m5zCjK54tZ9DqiefIbrCk3ZNaHFmuPSLUh4ItB2sF4oMa9swgVSI69X/MXLW8sYOyx
         Vu0nqTkY+Vfha6eznG713ZOf68F/duPZMK6qdSImISwCExKjV8hR2v/pupt30kw2reCF
         0mt57pcjuJ9V+XfVWQp8T2Pf5Gj0ImBfmlVABzghogiM1hTIOEM5pURMyfehlO6srWCb
         vRrAJWKkDxKo+s3bxjnd/6RvpMqKzwWPBlSowv43kmH+k7H27FH7gDRkNS5kHbv1xWFZ
         6QovtKpVMV3wZvor2yq3V1nHQowEmKYSJuL/EoJnTzuBEuUvvwVsccWG+61wEeYU3ddU
         jmLg==
X-Gm-Message-State: APjAAAVTDjjoGrsVnnTgcF4YzAMeJdHkHxY0zAdyf/h+m4YRp2NvSQ2o
        zUOxQAHy8ypbSSXrwFWatzAaYZQckTNO0n349XuazQ==
X-Google-Smtp-Source: APXvYqyQiWOytOWvETmZ/lX6mjAxJtO7J/9HNjyUp8rLndIVDE+TYfD/IMExAYni2I/+EKIHlCwpa/JO2Z2EXi0B4Gc=
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr2829996lfl.1.1559238981944;
 Thu, 30 May 2019 10:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com> <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com>
In-Reply-To: <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Thu, 30 May 2019 10:56:10 -0700
Message-ID: <CABEDWGxLeD-K8PjkD5hPSTFGJKs2hxEaAVO+nE5eC9Nx2yw=ig@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 29, 2019 at 10:48 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> +Vinod Koul
>
> Hi,
>
> >>> On Fri, May 24, 2019 at 1:59 AM Gustavo Pimentel
> >>> <Gustavo.Pimentel@synopsys.com> wrote:
> >>>>
> >>>> Hi Alan,
> >>>>
> >>>> This patch implementation is very HW implementation dependent and
> >>>> requires the DMA to exposed through PCIe BARs, which aren't always the
> >>>> case. Besides, you are defining some control bits on
> >>>> include/linux/pci-epc.h that may not have any meaning to other types of
> >>>> DMA.
> >>>>
> >>>> I don't think this was what Kishon had in mind when he developed the
> >>>> pcitest, but let see what Kishon was to say about it.
> >>>>
> >>>> I've developed a DMA driver for DWC PCI using Linux Kernel DMAengine API
> >>>> and which I submitted some days ago.
> >>>> By having a DMA driver which implemented using DMAengine API, means the
> >>>> pcitest can use the DMAengine client API, which will be completely
> >>>> generic to any other DMA implementation.
>
> right, my initial thought process was to use only dmaengine APIs in
> pci-epf-test so that the system DMA or DMA within the PCIe controller can be
> used transparently. But can we register DMA within the PCIe controller to the
> DMA subsystem? AFAIK only system DMA should register with the DMA subsystem.
> (ADMA in SDHCI doesn't use dmaengine). Vinod Koul can confirm.
>
> If DMA within the PCIe controller cannot be registered in DMA subsystem, we
> should use something like what Alan has done in this patch with dma_read ops.
> The dma_read ops implementation in the EP controller can either use dmaengine
> APIs or use the DMA within the PCIe controller.
>
> I'll review the patch separately.
>
> Thanks
> Kishon

Hi Kishon,

I have some improvements in mind for a v2 patch in response to
feedback from Gustavo Pimentel that the current implementation is HW
specific. I hesitate from submitting a v2 patch because it seems best
to seek comment on possible directions this may be taking.

One alternative is to wait for or modify test functions in
pci-epf-test.c to call DMAengine client APIs, if possible. I imagine
pci-epf-test.c test functions would still allocate the necessary local
buffer on the endpoint side for the same canned tests for everyone to
use. They would prepare the buffer in the existing manner by filling
it with random bytes and calculate CRC in the case of a write test.
However, they would then initiate DMA operations by using DMAengine
client APIs in a generic way instead of calling memcpy_toio() and
memcpy_fromio(). They would post-process the buffer in the existing
manner such as the checking for CRC in the case of a read test.
Finally, they would release the resources and report results back to
the user of pcitest across the PCIe bus through the existing methods.

Another alternative I have in mind for v2 is to change the struct
pci_epc_dma that this patch added to pci-epc.h from the following:

struct pci_epc_dma {
        u32     control;
        u32     size;
        u64     sar;
        u64     dar;
};

to something similar to the following:

struct pci_epc_dma {
        size_t  size;
        void *buffer;
        int flags;
};

The 'flags' field can be a bit field or separate boolean values to
specify such things as linked-list mode vs single-block, etc.
Associated #defines would be removed from pci-epc.h to be replaced if
needed with something generic. The 'size' field specifies the size of
DMA transfer that can fit in the buffer.

That way the dma test functions in pci-epf-test.c can simply kmalloc
and prepare a local buffer on the endpoint side for the DMA transfer
and pass its pointer down the stack using the 'buffer' field to lower
layers. This would allow different PCIe controller drivers to
implement DMA or not according to their needs. Each implementer can
decide to use DMAengine client API, which would be preferable, or
directly read or write to DMA hardware registers to suit their needs.

I would appreciate feedback and comment on such choices as part of this review.

Regards,
Alan Mikhak
