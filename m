Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB7392DA0
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhE0MKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 08:10:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34943 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbhE0MKG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 08:10:06 -0400
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lmEoS-0005iJ-Dw
        for linux-pci@vger.kernel.org; Thu, 27 May 2021 12:08:32 +0000
Received: by mail-lj1-f199.google.com with SMTP id h1-20020a2e9ec10000b02900edf305c2e1so142756ljk.12
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 05:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kncaMdHs6rlLGylUk3Wdwf3tcaKjfAxUxb/GAcKWx7A=;
        b=nixz+TqirP8gei5tDONhrWRwQJfu/0Ad48KpGPa+1XKpnRDXFAXd0iNIzPtcfSWhKV
         KyyydXxZfwhtZN7UipcpLbGLqs6lM4TdonS6/sFbtp8tECKUv9LHj+zV4XorjdGLOfil
         2EyLBtUKTwZQFAvWtkfD8IBqL3PrvHg0B2kjgJVjv0vrpbEqkQmfpVU+eNbg+RA+iWCM
         z4rwrYOknwo2kNogLk/GbcDyZTw473n/c6TOdKwiW4XsBZOcykJFaFwTtwpdjQ1uSuSW
         sQLHh17kylkzOOl4CgQHrhB1hmsJ9i+519eQbOIHsouMrCUDk5acu7CJDrmInA7Dlbjh
         k66w==
X-Gm-Message-State: AOAM530bhxA1M077rXkODODHU8YhzCx9r4aDP2qsyT0xthJD6vFCBO8c
        c10dljimFvAws72h85ULwCvcox+M1pl5nUcO3aQDUmBTElALklraCNp/0iE/5e5RLDbLWTbWUxv
        utgQkdkM7fF1tIsZ118KWfdZyHX0rlU5m3fTrqP9/h4UW6fy+/5cELA==
X-Received: by 2002:a05:651c:3c9:: with SMTP id f9mr2316716ljp.403.1622117311910;
        Thu, 27 May 2021 05:08:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMy+4w+3mOLCUbgnvd7jc4HyGXspeCGlk4iS6hlGENYk15Z40+kFFkwbWsZI6VxoKOYx3o+IEQ9FOv/BtKb+E=
X-Received: by 2002:a05:651c:3c9:: with SMTP id f9mr2316678ljp.403.1622117311449;
 Thu, 27 May 2021 05:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6TJev=LgdvGxC92A9HOy3B6jbPLymAqeB5bDe2=5Fdsw@mail.gmail.com>
 <20210526150633.GA1291513@bjorn-Precision-5520> <CAAd53p7Mnv6HUv8hfjnsCpGeaSPXVAiA4D8gMxxdn6Bz8Z1fBQ@mail.gmail.com>
 <20210527114029.GC17266@lst.de>
In-Reply-To: <20210527114029.GC17266@lst.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 27 May 2021 20:08:19 +0800
Message-ID: <CAAd53p5cF6i_5MiKXva+cpYBxCrVJJVT2ir=2ZiNHafUvO1oWQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Koba Ko <koba.ko@canonical.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 7:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, May 27, 2021 at 12:24:06AM +0800, Kai-Heng Feng wrote:
> > Yes, that's exactly what they said. Because Windows Modern Standby
> > always keep the NVMe at D0, so D3hot is untested by the vendors.
>
> So all the problems we've deal with latetly are that platforms cut the
> power off.  So it is not kept always at D0 which would be the right thing,
> but moved into D3cold.

It's still okay to use D3cold under s2idle if nvme_acpi_storage_d3()
check passes.

Otherwise D0 should be used. I am unsure how to proceed with HMB NVMes
if we can't setup DMA after resume...

>
> Which makes this patch to disable D3cold rather counterintuitive.

The intention of this patch is indeed very unclear.

Kai-Heng
