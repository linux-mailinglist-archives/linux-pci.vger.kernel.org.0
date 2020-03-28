Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE4271968A8
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgC1Sof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 14:44:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46390 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgC1Soe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Mar 2020 14:44:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id 111so13500066oth.13
        for <linux-pci@vger.kernel.org>; Sat, 28 Mar 2020 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehR50XlNmcxtv5tjuGPsO9w5YBevVP65n2VnzD54mSE=;
        b=RoYBbBLvqQEwOEV4b+fsOeP+Yw0vONKs1Z909Sd6YtTQwZ0i+0aE10zJMG3JXUKPHJ
         V4h9RZQRTopmXEnAvXVixiuri5MB+2iK7Q+1lgpHEOOme8/k3gSwKIEi7cjtRzL4WUtB
         qp7bpqOY2kmN3VsrdZRCpTI/q9rvMAmAiWrn4oL1jcOVKruiKg2QIPee1JuGPksY/Z5H
         TKNbPP8xeS9LaueXvftx6A3OzXjCCLbCU9qoSsh9LF6AHacd7lS/H/rm4Tg5cBcpNHgp
         eOxan61JgJQFtEOKDqCXGFOfFDm5jS0TQIqztt0dic3puyuyA7nQA166oOTq9EqJGRsb
         ITVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehR50XlNmcxtv5tjuGPsO9w5YBevVP65n2VnzD54mSE=;
        b=XOsfGC6l77qAqp8k/1LQRH3pI9uJqprShW9Qx4Bybm01MifYMDHqGvLOdCMVgPR7rM
         LxuvXI5fw0B8x3Yb1mqvzv4q1xj8Z8Wg6320eBNdGfT1ugGUl3zDzREvpDanyWqcE3Za
         UDxekOjidL8kXhjvx2Zgd296YuZT5zeMICVk5J2u+MgcsnKKh2l+x2FPdy3sVrbv0j2j
         8uw8e29Gp8EATWwICP2Zu6EOYHursEifMMzaetESV8ywSB4puEpYdI8kuGEM/8LgiBGZ
         u80HDrs0KCzt7iDrAENoIdN1VSAuPacPzDflGHnw9z5F+eTLngFIHcekwpHx70LpJmfD
         t5cA==
X-Gm-Message-State: ANhLgQ2pQXHv+4/eM2+AnrVhoGGYSNg8fRcNgll8vWGus35atvlOT8L7
        AdPWOTLrHmSn3wcbd1AHfUNGPpMLUpuTZr/etzI=
X-Google-Smtp-Source: ADFU+vvafi76idWqcOkU86oM7cdyLC8rMqI6CysVEWBcSfJQoILLtT5Ab3v8jOLwPOtCiipMeWZLj+4P4J5ksYPeWV4=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr3530030otl.44.1585421073808;
 Sat, 28 Mar 2020 11:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com> <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com> <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
In-Reply-To: <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 28 Mar 2020 18:44:07 +0000
Message-ID: <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
Subject: Re: PCIe EPF
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Tue, Mar 24, 2020 at 2:41 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Kishon,
>
> On Tue, Mar 24, 2020 at 1:58 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On 3/22/2020 4:19 AM, Lad, Prabhakar wrote:
> > > Hi Kishon,
> > >
> > > On Fri, Mar 20, 2020 at 5:28 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > >>
> > >> Hi Prabhakar,
> > >>
> > >> On 3/18/2020 5:07 PM, Lad, Prabhakar wrote:
> > >>> Hi Kishon,
> > >>>
> > >>> I rebased my rcar-endpoint patches on endpoint branch, which has
> > >>> support for streaming DMA API support, with this  read/write/copy
> > >>> tests failed, to make sure nothing hasn't changed on my driver I
> > >>> reverted the streaming DMA API patch
> > >>> 74b9b4da84c71418ceeaaeb78dc790376df92fea "misc: pci_endpoint_test: Use
> > >>> streaming DMA APIs for buffer allocation" and tests began to pass
> > >>> again.
> > >>>
> > >>> If add a GFP_DMA flag for kzalloc (with streaming DMA), the test cases
> > >>> for read/write/copy pass as expected.
> > >>>
> > >>> Could you please through some light why this could be happening.
> > >>
> > >> Do you see any differences in the address returned by dma_map_single() like is
> > >> it 32-bit address or 64-bit address?
> > >>
> > > Both return 32 bit address, debugging further I see that with
> > > GFP_KERNEL flag for small buffer
> > > sizes the read/write/copy tests pass(upto 4k), so I am suspecting its
> > > related to caching probably.
> > > Also adding wmb()/rmb() just with GFP_KERNEL flag didn't help. Note I
> > > am using PIO transfers.
> > > Any thoughts on how we tackle it ?
> > >
> > > # With GFP_KERNEL flag
> > > root@hihope-rzg2m:~# pcitest -r
> > > [   46.210649] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > kzalloc:ffff0004b4ae0000 dma:7e99d000 align:ffff0004b4ae0000
> > > READ ( 102400 bytes):           NOT OKAY
> > > root@hihope-rzg2m:~# pcitest -r
> > > [   51.880063] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > kzalloc:ffff0004b4ae0000 dma:7e9c0000 align:ffff0004b4ae0000
> > > READ ( 102400 bytes):           OKAY
> >
> > Here one of the read test is passing and the other is failing.
> > For the 1st case dma:7e99d000, address is aligned to 4K
> > For the 2nd case dma:7e9c0000, address is aligned to 256K
> >
> > I'm suspecting this could be an alignment issue. Does the outbound ATU of your
> > EP has any restrictions? (like the address should be aligned to the size?).
> >
> There isn't any  restriction for outbound ATU on ep,  Although I tried
> alignment from
> SZ_1 - SZ_256K and each failed at several points.
>
> With GFP_KERNEL | GFP_DMA, as in my previous dump here the address too
> is not aligned to 256 but still read passes.
> root@hihope-rzg2m:~# pcitest -r -s 16384
>  [  186.629347] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> kzalloc:ffff00003b848000 dma:7b848000 align:ffff00003b848000
> READ (  16384 bytes):           OKAY
>
> And I have verified with GFP_KERNEL | GFP_DMA on my platform
> everything works as expected,
>
> So how about a patch for pci_endpoint_test.c, where flags are passed
> as  part of driver_data and it defaults to just GFP_KERNEL ?
>
Any thoughts on the above ? I intended to get the endpoint driver for v5.7.

Cheers,
--Prabhakar

> Cheers,
> --Prabhakar
>
> > Thanks
> > Kishon
> >
> > > root@hihope-rzg2m:~# pcitest -r
> > > [   53.354830] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > kzalloc:ffff0004b4ae0000 dma:7e9e2000 align:ffff0004b4ae0000
> > > READ ( 102400 bytes):           NOT OKAY
> > > root@hihope-rzg2m:~# pcitest -r
> > > [   55.307236] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > kzalloc:ffff0004b4ae0000 dma:7ea04000 align:ffff0004b4ae0000
> > > READ ( 102400 bytes):           NOT OKAY
> > > root@hihope-rzg2m:~# pcitest -r
> > > [   57.098626] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > kzalloc:ffff0004b4ae0000 dma:7ea23000 align:ffff0004b4ae0000
> > > READ ( 102400 bytes):           NOT OKAY
> > >
> > > # GFP_KERNEL | GFP_DMA
> > >
> > > root@hihope-rzg2m:~# pcitest -r -s 1024001
> > > [  174.562071] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > kzalloc:ffff00003b900000 dma:7b900000 align:ffff00003b900000
> > > READ (1024001 bytes):           OKAY
> > > root@hihope-rzg2m:~# pcitest -r -s 16384
> > > [  186.629347] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > kzalloc:ffff00003b848000 dma:7b848000 align:ffff00003b848000
> > > READ (  16384 bytes):           OKAY
> > > root@hihope-rzg2m:~# pcitest -r -s 8192
> > > [  190.578335] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > kzalloc:ffff00003b840000 dma:7b840000 align:ffff00003b840000
> > > READ (   8192 bytes):           OKAY
> > > root@hihope-rzg2m:~# pcitest -r -s 128
> > > [  199.428021] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
> > > kzalloc:ffff00003b800000 dma:7b800000 align:ffff00003b800000
> > > READ (    128 bytes):           OKAY
> > > root@hihope-rzg2m:~#
> > >
> > > Cheers,
> > > --Prabhakar
> > >
> > >> Thanks
> > >> Kishon
