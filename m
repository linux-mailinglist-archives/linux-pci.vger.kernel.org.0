Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB9D18E54F
	for <lists+linux-pci@lfdr.de>; Sat, 21 Mar 2020 23:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgCUWt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Mar 2020 18:49:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36412 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCUWt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Mar 2020 18:49:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id k18so10795914oib.3
        for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2020 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwwFDFh3xeJD769PTlVnEGhSYN8vNfCaKDwZ07sfv50=;
        b=k/0/9wmIML3j+YZlSFfuJqH+i/MTufosbpafLJZpqr89vqRHA0HiXHsYq+KhRgI43j
         jV4XEoQPGgmoTqzU6UPUFpD1pjcrRBjKiMs9astkOpaeZWl5h9C2znRX4bkJJCRI+Zrr
         qp+B+Ipjvtps11w1THeL8zoIVeJkFFa1GW61mR1enDo8ix4mOwrKT9ls7roBSk3VJxDD
         mEhm2cMwnFLj2Yqo3vqNuPELZX4R9Cz3osrmv/y5w9GgnxMiNfY994/5oaBsW3MWfLuu
         MY4g/xmDVNXI8uknJ1Z6WEJ2JElzSPiIhZY1pfZsA86BGhoV8qtyeYF5Fy7zV3EuxvaT
         Wf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwwFDFh3xeJD769PTlVnEGhSYN8vNfCaKDwZ07sfv50=;
        b=TStB/ibuTRKqsGcHFg+As73li4qOgnyfCCmN5ObDRiVqGdApNCmryuLtzcxBIQvGwD
         vfC0FgsZTEolVktVGtNvT7TRQTnKOsn+xHzjp255vL9MK/Z8xtIB4f5pnSsWQF+mUctR
         qQT5th2xUHI0KXiNmmeHbqQwTLfFM9qHV5CSY3ix+X7Gm2ZFEGq3AAN3z9ir9+D0veRp
         zqO24tVkYNP35mvIEnJtWUntNJ/6GbCalUGLHF++zYHRsdo3YgOcTDrET1AsKfK99aBX
         7IoPhSXmEeLpjuo7nkktqk9DLu+suIezcz5vJTtKEXDQWw++qLIrD0NrC0fHGqlrPHi5
         3l7w==
X-Gm-Message-State: ANhLgQ1kS+g2Z8CAQlULr/LQbdc8/uebM+xLNOUKQlwju4jKKYXZqyyQ
        12bGo2qIxiQVTuZqVcQzdQHk7tijQTqnSrBV9WA=
X-Google-Smtp-Source: ADFU+vvqrFIN/fOLzF1d8H4llDvaolIOBhc4O2Zzm5CRaSm6bLHmvJyGFC1/o4poXNo90Sck+OLSxeCr7oKsAED7zuo=
X-Received: by 2002:aca:5444:: with SMTP id i65mr6022870oib.101.1584830996513;
 Sat, 21 Mar 2020 15:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com>
In-Reply-To: <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 21 Mar 2020 22:49:30 +0000
Message-ID: <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
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

On Fri, Mar 20, 2020 at 5:28 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Prabhakar,
>
> On 3/18/2020 5:07 PM, Lad, Prabhakar wrote:
> > Hi Kishon,
> >
> > I rebased my rcar-endpoint patches on endpoint branch, which has
> > support for streaming DMA API support, with this  read/write/copy
> > tests failed, to make sure nothing hasn't changed on my driver I
> > reverted the streaming DMA API patch
> > 74b9b4da84c71418ceeaaeb78dc790376df92fea "misc: pci_endpoint_test: Use
> > streaming DMA APIs for buffer allocation" and tests began to pass
> > again.
> >
> > If add a GFP_DMA flag for kzalloc (with streaming DMA), the test cases
> > for read/write/copy pass as expected.
> >
> > Could you please through some light why this could be happening.
>
> Do you see any differences in the address returned by dma_map_single() like is
> it 32-bit address or 64-bit address?
>
Both return 32 bit address, debugging further I see that with
GFP_KERNEL flag for small buffer
sizes the read/write/copy tests pass(upto 4k), so I am suspecting its
related to caching probably.
Also adding wmb()/rmb() just with GFP_KERNEL flag didn't help. Note I
am using PIO transfers.
Any thoughts on how we tackle it ?

# With GFP_KERNEL flag
root@hihope-rzg2m:~# pcitest -r
[   46.210649] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff0004b4ae0000 dma:7e99d000 align:ffff0004b4ae0000
READ ( 102400 bytes):           NOT OKAY
root@hihope-rzg2m:~# pcitest -r
[   51.880063] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff0004b4ae0000 dma:7e9c0000 align:ffff0004b4ae0000
READ ( 102400 bytes):           OKAY
root@hihope-rzg2m:~# pcitest -r
[   53.354830] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff0004b4ae0000 dma:7e9e2000 align:ffff0004b4ae0000
READ ( 102400 bytes):           NOT OKAY
root@hihope-rzg2m:~# pcitest -r
[   55.307236] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff0004b4ae0000 dma:7ea04000 align:ffff0004b4ae0000
READ ( 102400 bytes):           NOT OKAY
root@hihope-rzg2m:~# pcitest -r
[   57.098626] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff0004b4ae0000 dma:7ea23000 align:ffff0004b4ae0000
READ ( 102400 bytes):           NOT OKAY

# GFP_KERNEL | GFP_DMA

root@hihope-rzg2m:~# pcitest -r -s 1024001
[  174.562071] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff00003b900000 dma:7b900000 align:ffff00003b900000
READ (1024001 bytes):           OKAY
root@hihope-rzg2m:~# pcitest -r -s 16384
[  186.629347] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff00003b848000 dma:7b848000 align:ffff00003b848000
READ (  16384 bytes):           OKAY
root@hihope-rzg2m:~# pcitest -r -s 8192
[  190.578335] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff00003b840000 dma:7b840000 align:ffff00003b840000
READ (   8192 bytes):           OKAY
root@hihope-rzg2m:~# pcitest -r -s 128
[  199.428021] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
kzalloc:ffff00003b800000 dma:7b800000 align:ffff00003b800000
READ (    128 bytes):           OKAY
root@hihope-rzg2m:~#

Cheers,
--Prabhakar

> Thanks
> Kishon
