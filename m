Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E0197C7E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgC3NKR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 09:10:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37616 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgC3NKQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 09:10:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id g23so17923629otq.4
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2020 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGlDXdBHMw1qoy2zN/RQsEFlUWvXjas4etDdjz865Ak=;
        b=Cp0OrNxSarOR54AxbhUxsgBtbID45Novdh5RPJp1Li4GdhRXfWeuGXVYsUn0qXXgqT
         buClIU91hQmxhz9wXPKrQwUxUqLP4TFl139gRaAAzR41fsWyuOfLtBvrSlWuRZRWaNyU
         fynb2HSTToTF07+XCwrNQoFMFWkOnlCXWkkiqL+H5C1VjsMvovk1cuv0Urrj0WAWOTxU
         A4RTbIzBPPbhAbt9D0KGXsNCkvBIpwsC3fNONbZ5CYpDmqdqLfyp5sxrPFou7JfCcpa8
         cjdzuAOkv6OWz7Sq3I65NIj0+lfvDRJD/hJHD1xTmpIFAfv99p/Vxo/A2DfBbq/LG1yN
         8oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGlDXdBHMw1qoy2zN/RQsEFlUWvXjas4etDdjz865Ak=;
        b=oHj7/3XOIRhROqzRe9F4qfSc+z+zWZ00HMeltDXcD8g6aPup9LMDhEUP8Adqj5tjUG
         DDw4wHBUhgOJlTLkEB+pFLpskMS46rDfUN3qxMvkQ4XzvrmlvmJt9a2nx3r3JnfBocg+
         8hYjkz0TLRXW70XHRZ51MVadDLk3AX9XCDb9oUvFBiyqheURK1SArfoTF12XV2zurZrq
         sq4y2fwnhpp7m6kU44+800Sg9A+0vMKUkss+KrqwXI7OfFZRNdOvJdFGRUsTLo21NT+H
         jyYYjOfPsV3MivA/bR2TMsangHTSzyaQLdDYRwoyyXCJcbDMSzHOpD0Lu94wSYQAlsJI
         F/Fw==
X-Gm-Message-State: ANhLgQ1m3zXKpsJlP0kbyWzP4cQCVIYdHvgOYnRBLXUZRsx5hYAGsXc0
        jUnH+AlHRL1ivKJ6LphJrCc8yGC9G7x+GXdBFPE=
X-Google-Smtp-Source: ADFU+vu3oaPdXG8s5bLmEqpy1iMZCzdGmZ0lgleJ3oy5FbvlUEsVqOWi/m2SWCVeYeFgz9q2WxPt1QUptWpfdxk+Jo0=
X-Received: by 2002:a9d:64cd:: with SMTP id n13mr9092038otl.274.1585573815578;
 Mon, 30 Mar 2020 06:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com> <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com> <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
 <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
 <CA+V-a8sNcdC8SO6pXGUH3TkM7B6dX-xxcqtZjRZ_496qyG1h+Q@mail.gmail.com> <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com>
In-Reply-To: <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 30 Mar 2020 14:09:49 +0100
Message-ID: <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
Subject: Re: PCIe EPF
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Mon, Mar 30, 2020 at 12:59 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Prabhakar,
>
> On 3/29/2020 7:34 PM, Lad, Prabhakar wrote:
> > Hi Kishon,
> >
> > On Sat, Mar 28, 2020 at 6:44 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> >>
> >> Hi Kishon,
> >>
> >> On Tue, Mar 24, 2020 at 2:41 PM Lad, Prabhakar
> >> <prabhakar.csengg@gmail.com> wrote:
> >>>
> >>> Hi Kishon,
> >>>
> >>> On Tue, Mar 24, 2020 at 1:58 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>>>
> >>>> Hi Prabhakar,
> >>>>
> >>>> On 3/22/2020 4:19 AM, Lad, Prabhakar wrote:
> >>>>> Hi Kishon,
> >>>>>
> >>>>> On Fri, Mar 20, 2020 at 5:28 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>>>>>
> >>>>>> Hi Prabhakar,
> >>>>>>
> >>>>>> On 3/18/2020 5:07 PM, Lad, Prabhakar wrote:
> >>>>>>> Hi Kishon,
> >>>>>>>
> >>>>>>> I rebased my rcar-endpoint patches on endpoint branch, which has
> >>>>>>> support for streaming DMA API support, with this  read/write/copy
> >>>>>>> tests failed, to make sure nothing hasn't changed on my driver I
> >>>>>>> reverted the streaming DMA API patch
> >>>>>>> 74b9b4da84c71418ceeaaeb78dc790376df92fea "misc: pci_endpoint_test: Use
> >>>>>>> streaming DMA APIs for buffer allocation" and tests began to pass
> >>>>>>> again.
> >>>>>>>
> >>>>>>> If add a GFP_DMA flag for kzalloc (with streaming DMA), the test cases
> >>>>>>> for read/write/copy pass as expected.
> >>>>>>>
> >>>>>>> Could you please through some light why this could be happening.
> >>>>>>
> >>>>>> Do you see any differences in the address returned by dma_map_single() like is
> >>>>>> it 32-bit address or 64-bit address?
> >>>>>>
> >>>>> Both return 32 bit address, debugging further I see that with
> >>>>> GFP_KERNEL flag for small buffer
> >>>>> sizes the read/write/copy tests pass(upto 4k), so I am suspecting its
> >>>>> related to caching probably.
> >>>>> Also adding wmb()/rmb() just with GFP_KERNEL flag didn't help. Note I
> >>>>> am using PIO transfers.
> >>>>> Any thoughts on how we tackle it ?
> >>>>>
> >>>>> # With GFP_KERNEL flag
> >>>>> root@hihope-rzg2m:~# pcitest -r
> >>>>> [   46.210649] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>>>> kzalloc:ffff0004b4ae0000 dma:7e99d000 align:ffff0004b4ae0000
> >>>>> READ ( 102400 bytes):           NOT OKAY
> >>>>> root@hihope-rzg2m:~# pcitest -r
> >>>>> [   51.880063] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>>>> kzalloc:ffff0004b4ae0000 dma:7e9c0000 align:ffff0004b4ae0000
> >>>>> READ ( 102400 bytes):           OKAY
> >>>>
> >>>> Here one of the read test is passing and the other is failing.
> >>>> For the 1st case dma:7e99d000, address is aligned to 4K
> >>>> For the 2nd case dma:7e9c0000, address is aligned to 256K
> >>>>
> >>>> I'm suspecting this could be an alignment issue. Does the outbound ATU of your
> >>>> EP has any restrictions? (like the address should be aligned to the size?).
> >>>>
> >>> There isn't any  restriction for outbound ATU on ep,  Although I tried
> >>> alignment from
> >>> SZ_1 - SZ_256K and each failed at several points.
> >>>
> >>> With GFP_KERNEL | GFP_DMA, as in my previous dump here the address too
> >>> is not aligned to 256 but still read passes.
> >>> root@hihope-rzg2m:~# pcitest -r -s 16384
> >>>  [  186.629347] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>> kzalloc:ffff00003b848000 dma:7b848000 align:ffff00003b848000
> >>> READ (  16384 bytes):           OKAY
> >>>
> >>> And I have verified with GFP_KERNEL | GFP_DMA on my platform
> >>> everything works as expected,
> >>>
> >>> So how about a patch for pci_endpoint_test.c, where flags are passed
> >>> as  part of driver_data and it defaults to just GFP_KERNEL ?
> >>>
> >> Any thoughts on the above ? I intended to get the endpoint driver for v5.7.
> >>
> > Correct me if I am wrong here, streaming DMA API should be used with
> > dma (-d) option so that root device
> > makes sure the data is synced when data is transferred whereas
> > previously with dma_alloc_coherent()
> > we didn't have to care about cache issues. Also for a non-dma (-d)
> > option we don't have a handle to dma
> > in rootpport device so that we can call a sync operation. I say this
> > because on my platform  with streaming
> > DMA api it works for small size buffers but it doesn't work with large
> > size buffers.
>
> Streaming DMA API and DMA support in endpoint can be treated independently.
> dma_alloc_coherent() will give you coherent memory, so you don't have to flush
> or invalidate. This memory is usually limited in a platform.
> The other option was to use streaming DMA APIs which doesn't give coherent
> memory but SW has to take care of flush and invalidate.
>
Agreed. But we don't flush in SW when -d option is not specified I am
assuming  when we us
-d dma engine takes care of flushing it.

> >
> > Could you please confirm with streaming DMA api without DMA (-d)
> > option for large buffers read/write/copy
> > still passes for you.
>
> root@j7-evm:~# ./pcitest -r
> READ ( 102400 bytes):           OKAY
> root@j7-evm:~# ./pcitest -r -s 1024000
> READ (1024000 bytes):           OKAY
> root@j7-evm:~# ./pcitest -w -s 1024000
> WRITE (1024000 bytes):          OKAY
> root@j7-evm:~# ./pcitest -c -s 1024000
> COPY (1024000 bytes):           OKAY
> root@j7-evm:~# ./pcitest -c -s 10240000
> COPY (10240000 bytes):          OKAY
> root@j7-evm:~# ./pcitest -r -s 10240000
> READ (10240000 bytes):          OKAY
> root@j7-evm:~# ./pcitest -w -s 10240000
> WRITE (10240000 bytes):         OKAY

Thank you for testing is this on Jacinto ?

> >
> > Although I am not sure why adding GFP_KERNEL | GFP_DMA flag for
> > kzalloc  on my platform fixes everything.
>
> Which host do you use? If this is only a host side limitation, you could try
> using a different host.
>
I am trying this on  Renesas RZ/G2N as host and RZ/G2E as an endpoint.
ATM I can only test this on
Renesas platforms only and all of them have same PCIe controller :(

How about adding flags as part of driver data and defaulting it GFP_KERNEL ?

Cheers,
--Prabhakar

> Thanks
> Kishon
>
> >
> > Cheers,
> > --Prabhakar
> >
> >
> >> Cheers,
> >> --Prabhakar
> >>
> >>> Cheers,
> >>> --Prabhakar
> >>>
> >>>> Thanks
> >>>> Kishon
> >>>>
> >>>>> root@hihope-rzg2m:~# pcitest -r
> >>>>> [   53.354830] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>>>> kzalloc:ffff0004b4ae0000 dma:7e9e2000 align:ffff0004b4ae0000
> >>>>> READ ( 102400 bytes):           NOT OKAY
> >>>>> root@hihope-rzg2m:~# pcitest -r
> >>>>> [   55.307236] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>>>> kzalloc:ffff0004b4ae0000 dma:7ea04000 align:ffff0004b4ae0000
> >>>>> READ ( 102400 bytes):           NOT OKAY
> >>>>> root@hihope-rzg2m:~# pcitest -r
> >>>>> [   57.098626] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>>>> kzalloc:ffff0004b4ae0000 dma:7ea23000 align:ffff0004b4ae0000
> >>>>> READ ( 102400 bytes):           NOT OKAY
> >>>>>
> >>>>> # GFP_KERNEL | GFP_DMA
> >>>>>
> >>>>> root@hihope-rzg2m:~# pcitest -r -s 1024001
> >>>>> [  174.562071] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>>>> kzalloc:ffff00003b900000 dma:7b900000 align:ffff00003b900000
> >>>>> READ (1024001 bytes):           OKAY
> >>>>> root@hihope-rzg2m:~# pcitest -r -s 16384
> >>>>> [  186.629347] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>>>> kzalloc:ffff00003b848000 dma:7b848000 align:ffff00003b848000
> >>>>> READ (  16384 bytes):           OKAY
> >>>>> root@hihope-rzg2m:~# pcitest -r -s 8192
> >>>>> [  190.578335] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>>>> kzalloc:ffff00003b840000 dma:7b840000 align:ffff00003b840000
> >>>>> READ (   8192 bytes):           OKAY
> >>>>> root@hihope-rzg2m:~# pcitest -r -s 128
> >>>>> [  199.428021] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> >>>>> kzalloc:ffff00003b800000 dma:7b800000 align:ffff00003b800000
> >>>>> READ (    128 bytes):           OKAY
> >>>>> root@hihope-rzg2m:~#
> >>>>>
> >>>>> Cheers,
> >>>>> --Prabhakar
> >>>>>
> >>>>>> Thanks
> >>>>>> Kishon
