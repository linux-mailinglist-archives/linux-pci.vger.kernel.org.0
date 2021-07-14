Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075B63C93F8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 00:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhGNWqX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 18:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhGNWqW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 18:46:22 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B58C06175F
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 15:43:30 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id e11so1129166oii.9
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKdMPRaHG9zg/8mmbatzWuo8Xg06TAfgtbZsirE/45Y=;
        b=E+iXOOttCyz5hrR6Z/XbL7oj5jIG+m50w1OELc/WorMjYqeTsD3qDvfkrlNuFAcKmC
         Xcw4Jh9051S3ZxCAM+mrwOjLib6dVIdDoO9Upmv/7NeR/CAo8IE1dtxr4DAqwZY5fr1I
         +962sLbCEWb0MsOqhoVYgQvO9/Nj4kUgNmhF7WrLH/QbAT0g6GjqDr9tPS2pDXo4Hrju
         P0LoSUXtALoCMfRmKbOViJWk73wO29MFgCk5hlhMM4UfpZHsGLtXzSuls8Y3iTpkhJsV
         F4ukfNSuC4Nf9/xANIJF9sWCW7EMvOzzXExO8jMwTZNki9ThbA+hNUeYK/7QD4Hk7WKz
         zuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKdMPRaHG9zg/8mmbatzWuo8Xg06TAfgtbZsirE/45Y=;
        b=TPLfHEQQiZ8SX+k5qR2Y5VOsGyfoJuSTUf2bc4G+UdPNc5VTSZR08weK/Uz+3mCqZJ
         lwwJBZXebYgcO2BOqdZATyT3jikU9s7KZmJtBGQK09STYHIbdrJk4fZKtlVfe4hfdL56
         wUh+sFFngmauY037f6J7Ka8NWemr1/zDlFzjL5rwkas6Bc8MSzZXUHuw4B8fzmoN1V0Q
         DSzXb+FuO7vScNAI8B1bna9OgBpnnk8087xm0nYfEw+KG0eUJV2tcYFqb0fZxFefMdCm
         lGOpq2XNXbHdeQdKPKaMHWrOdeZMoyUatV3g2QVE7/OKNH3NMpDbjkrUBtIZPcaw9B6W
         SXmQ==
X-Gm-Message-State: AOAM531aDgQKdtaZyGAXPrjhGeJC+uheu5XYP9lIi6pwsP8EHXBppjWw
        a/RzcBR0AIuyIE2HFYG60BA5FucG6XXpu4h3WEg=
X-Google-Smtp-Source: ABdhPJxyXtu8K06FOhemIrwS7w1C02VPh1VIereYaigDCyxUkrzhAl1YTGli3syg1Up4WynMYHEB41XSKRnEzREKENY=
X-Received: by 2002:aca:c346:: with SMTP id t67mr1756721oif.124.1626302610077;
 Wed, 14 Jul 2021 15:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <CALdZjm7v3WaaS_ispa20PkjUnLq1t1Zdr29wKw_rZkQYExK-3w@mail.gmail.com>
 <20210714160350.1bef2778.alex.williamson@redhat.com>
In-Reply-To: <20210714160350.1bef2778.alex.williamson@redhat.com>
From:   Ruben <rubenbryon@gmail.com>
Date:   Thu, 15 Jul 2021 01:43:17 +0300
Message-ID: <CALdZjm6TsfsaQZRxJvr5YDh9VRn28vQjFY+JfZv-daU=gQu_Uw@mail.gmail.com>
Subject: Re: [question]: BAR allocation failing
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No luck so far with "-global q35-pcihost.pci-hole64-size=2048G"
("-global q35-host.pci-hole64-size=" gave an error "warning: global
q35-host.pci-hole64-size has invalid class name").
The result stays the same.

When we pass through the NVLink bridges we can have the (5 working)
GPUs talk at full P2P bandwidth and is described in the NVidia docs as
a valid option (ie. passing through all GPUs and NVlink bridges).
In production we have the bridges passed through to a service VM which
controls traffic, which is also described in their docs.

Op do 15 jul. 2021 om 01:03 schreef Alex Williamson
<alex.williamson@redhat.com>:
>
> On Thu, 15 Jul 2021 00:32:30 +0300
> Ruben <rubenbryon@gmail.com> wrote:
>
> > I am experiencing an issue with virtualizing a machine which contains
> > 8 NVidia A100 80GB cards.
> > As a bare metal host, the machine behaves as expected, the GPUs are
> > connected to the host with a PLX chip PEX88096, which connects 2 GPUs
> > to 16 lanes on the CPU (using the same NVidia HGX Delta baseboard).
> > When passing through all GPUs and NVLink bridges to a VM, a problem
> > arises in that the system can only initialize 4-5 of the 8 GPUs.
> >
> > The dmesg log shows failed attempts for assiging BAR space to the GPUs
> > that are not getting initialized.
> >
> > Things that were tried:
> > Q35-i440fx with and without UEFI
> > Qemu 5.x, Qemu 6.0
> > Host Ubuntu 20.04 host with Qemu/libvirt
> > Now running proxmox 7 on debian 11, host kernel 5.11.22-2, VM kernel 5.4.0-77
> > VM kernel parameters pci=nocrs pci=realloc=on/off
> >
> > ------------------------------------
> >
> > lspci -v:
> > 01:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
> >         Memory at db000000 (32-bit, non-prefetchable) [size=16M]
> >         Memory at 2000000000 (64-bit, prefetchable) [size=128G]
> >         Memory at 1000000000 (64-bit, prefetchable) [size=32M]
> >
> > 02:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
> >         Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
> >         Memory at 4000000000 (64-bit, prefetchable) [size=128G]
> >         Memory at 6000000000 (64-bit, prefetchable) [size=32M]
> >
> > ...
> >
> > 0c:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
> >         Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
> >         Memory at <ignored> (64-bit, prefetchable)
> >         Memory at <ignored> (64-bit, prefetchable)
> >
> > ...
> >
> ...
> >
> > ------------------------------------
> >
> > I have (blindly) messed with parameters like pref64-reserve for the
> > pcie-root-port but to be frank I have little clue what I'm doing so my
> > question would be suggestions on what I can try.
> > This server will not be running an 8 GPU VM in production but I have a
> > few days left to test before it goes to work. I was hoping to learn
> > how to overcome this issue in the future.
> > Please be aware that my knowledge regarding virtualization and the
> > Linux kernel does not reach far.
>
> Try playing with the QEMU "-global q35-host.pci-hole64-size=" option for
> the VM rather than pci=nocrs.  The default 64-bit MMIO hole for
> QEMU/q35 is only 32GB.  You might be looking at a value like 2048G to
> support this setup, but could maybe get away with 1024G if there's room
> in 32-bit space for the 3rd BAR.
>
> Note that assigning bridges usually doesn't make a lot of sense and
> NVLink is a proprietary black box, so we don't know how to virtualize
> it or what the guest drivers will do with it, you're on your own there.
> We generally recommend to use vGPUs for such cases so the host driver
> can handle all the NVLink aspects for GPU peer-to-peer.  Thanks,
>
> Alex
>
