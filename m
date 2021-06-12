Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771E83A4CD6
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jun 2021 06:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFLEdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Jun 2021 00:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLEdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Jun 2021 00:33:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5CC061574
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 21:31:19 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t6so7064599iln.8
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 21:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bt56qcGX0CyLRbpCZFZTQlCbWy17WE9TIiGo+O/YCq8=;
        b=UZ6dtJ3GOCPKTRI78F1b4p2PVP6RzIzfX2aItDgzqXvNL3Eq2B75zzecGiDmDqjha7
         b5flhO/jpenwffVnYyF8IQe6L9iCypQTm0k+0mZegR5Y3UXBgSKzIhiscYtXHA1RiUKb
         NnnSeTFS/IjmBEAYqSbQb2qJ53hy0zaP3czxo7ZoghqZDWxybjLUn6LnaTChftdBXhPf
         +TRAC0STk7iEf0/gT4J1E5Okdld/7j3MwEtgrjld6tvloorv1CnupPh0vc96dU7owxBr
         XdEZ+xUmaC5ocpwBr2rGbVLJeO47ES3O+BOia1+SvnfqXe50pxOWHvK6wDAdsiO2A4XM
         i9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bt56qcGX0CyLRbpCZFZTQlCbWy17WE9TIiGo+O/YCq8=;
        b=YZrULPgDu3J13C9nKUZ8Lf4QGqYq2Ohia/dlEpsdZKHGMt7ZjoxJ5KnS3i7wtQfqHZ
         hmvK4mBrFjQBRlK2uzE0eIO/+jpsp6dX2F6jswiCo3ityHptKGmcGmeu1n7hU1Nq+asf
         LIp3YcQU4ZstTcqBIi5m8GetkFQ59qhb+01xZYG+PEJUJNRElN/ut8qOseaY/SSFbXA+
         hubTjApdyQUlocvY72L1oraXhz3E4aEqc4/ZAjQIodSM30kBpeKAVyZXIYz5nXW1jpYg
         OHhrKQPOA1H24hrrVoMZN1xHAf4yykQm74qXxNzzatdbfdRUPQMCx39XetghSOzBSLl2
         aacw==
X-Gm-Message-State: AOAM5305UbR1LLLtw+P861wy4ZDWwD+CmGssAu47UWEWot6GOfqQJ/tV
        7w16t6JnwXPVnmzUdxjBSbMZddvjVOCR3hiCW3Q=
X-Google-Smtp-Source: ABdhPJxa4L0SpXYJP/iI5MSbC9TEzAmq/ldKXAFJfHWLqF5cu4rVegel2gxuV5Qkrii2K7DHsVR3Ee6zp3mgPFo7zS8=
X-Received: by 2002:a92:260b:: with SMTP id n11mr5599576ile.134.1623472278563;
 Fri, 11 Jun 2021 21:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210528071503.1444680-2-chenhuacai@loongson.cn>
 <20210528214309.GA1523480@bjorn-Precision-5520> <CAAhV-H4paNzoF4tEJd1_Z2VgBr64t3evfjdmrrA3CZMw=AXrGw@mail.gmail.com>
 <21b1495f-689f-2d75-d896-2a33c03b186b@kernel.org>
In-Reply-To: <21b1495f-689f-2d75-d896-2a33c03b186b@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 12 Jun 2021 12:31:06 +0800
Message-ID: <CAAhV-H7jadY0J80oydRq73d5+GGHuqWv9Y0R7N_e_tbSBrrhiQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] PCI/portdrv: Don't disable device during shutdown
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, huangshuai@loongson.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn and Sinan,

On Tue, Jun 8, 2021 at 4:43 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 6/4/2021 12:24 PM, Huacai Chen wrote:
> >> So you need to explain why we need to allow DMA from those devices
> >> even after we shutdown the port.  "It makes reboot work" is not a
> >> sufficient explanation.
> > I think only the designer of LS7A can tell us why. So, Mr. Shuai
> > Huang, could you please explain this?
> >
>
> Could there be some kind of a shutdown/init problem on your graphics
> card driver?
>
> During shutdown, remove() callback of all endpoints get called. This is
> the opportunity for your graphics driver to put hardware into safe
> state.
>
> If there is a problem with the hardware/driver, it should be a quirk as
> opposed to changing the default safe behavior for all devices.
I have had an offline discussion with Mr. Shuai Huang, he told me that
CPU is still writing data to framebuffer while poweroff/reboot, and if
we clear Bus Master Bit at this time, CPU will wait ack from device,
but never return, so deadlock.

More or less, we can modify the GPU driver to avoid this, as I said in
the commit message:

"The poweroff/reboot failures could easily be reproduced on Loongson
platforms. I think this is not a Loongson-specific problem, instead, is
a problem related to some specific PCI hosts. On some x86 platforms,
radeon/amdgpu devices can cause the same problem [1][2], and commit
faefba95c9e8ca3a ("drm/amdgpu: just suspend the hw on pci shutdown")
can resolve it.

Radeon driver is more difficult than amdgpu due to its confusing symbol
names, and I have maintained an out-of-tree patch for a long time [4]."

[1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
[2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
[4] https://github.com/chenhuacai/linux/commit/8da06f9b669831829416a3e9f4d1c57f217a42f0

Modifing every GPU driver is impossible for me, and I found some RAID
controllers have problems, too.

>
> The port driver here prevents memory from getting corrupted by rogue
> hardware. There is a window during kexec where hardware can write to
> system memory addresses if IOVA addresses and system memory addresses
> overlap.
>
KEXEC has no problems, as discussed before:
http://patchwork.ozlabs.org/project/linux-pci/patch/1600680138-10949-1-git-send-email-chenhc@lemote.com/

static void pci_device_shutdown(struct device *dev)
{
  ...
         if (drv && drv->shutdown)
                 drv->shutdown(pci_dev);

         /*
          * If this is a kexec reboot, turn off Bus Master bit on the
          * device to tell it to not continue to do DMA. Don't touch
          * devices in D3cold or unknown states.
          * If it is not a kexec reboot, firmware will hit the PCI
          * devices with big hammer and stop their DMA any way.
          */
         if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
                 pci_clear_master(pci_dev);
}

Huacai
