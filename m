Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94737FA3D
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhEMPFR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 11:05:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbhEMPEx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 11:04:53 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MORN0-1lrgz52F4w-00PwLd for <linux-pci@vger.kernel.org>; Thu, 13 May 2021
 17:03:33 +0200
Received: by mail-ot1-f53.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so17509355oth.8
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 08:03:33 -0700 (PDT)
X-Gm-Message-State: AOAM5304+P5fLUZI/nu6S1wjhABFxl+F5i3zXDbslAnD+rXq1ckJu8Mn
        Xt603X+bKXp8e1OPIqgFgS9ilL/pIaW6hMcAOXg=
X-Google-Smtp-Source: ABdhPJyHwElcAb7dTrZJ7xJbxeajaKkAJI5KqkPhGNksluWOy4D4xNvEQ+2HJis93kkeCXGgLlRQndZa/ocz4HAu3yw=
X-Received: by 2002:a05:6830:1f52:: with SMTP id u18mr22697094oth.298.1620918212279;
 Thu, 13 May 2021 08:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <E1lhCAV-0002yb-50@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1lhCAV-0002yb-50@rmk-PC.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 May 2021 17:02:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0TxtWn7Ua05=XsG5QK853C9SMDLdTOV_6rLB8cE49qXg@mail.gmail.com>
Message-ID: <CAK8P3a0TxtWn7Ua05=XsG5QK853C9SMDLdTOV_6rLB8cE49qXg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dynamically map ECAM regions
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rbSxf5c45OrVbAqvhgdTkPvB58e9BY6PRrCquLiYthgRpjq1God
 aGcfDBOwWRd1axo7vbGkdUYbX7Vd1jmkneOlTJpWEUBL3y2OCZL2UtGLqL3rGWS3loGYl8y
 t1M0R41QJnCWdybaUVxDp24EDTyFECMOPjmaWUOBLx2J2cgrzlwqTwkI4zDDjV7wx81FhAq
 P6E0orae2nVKonebw7xtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:serDlGyVHRg=:xBjAan5R8gxVprNF5HQX0n
 MPdewNXKOZlkM+8WGEArO4eZXMHAIlmQa1Vs56k0nOWEg7PSIxqLMKG2qqR3Hhu+N4jTOknXL
 /zhmCdaDmLRS5v95mslTA0q8ShCiNWLqY4KdHDSw44mtQPqU1LJ6l0wGmJJ3E+jkbAJFZzIgM
 IOz+X6nlcWYil4a6OzneoanGh4LWvh/C/Kj/z/8Txo4defwjwuBeibre4NY6uGdJ+T+rFcPCa
 B+iWQybyBo1U6ymXjhh68AhAeBBK+1VvN+e5NWImvUSjzvMrII9ZqJTDaKnP2Z5XuBbuEpFQr
 T6H5XFECHQwIr8rhLGLfXEf1S95uayN5qtIZYmhCEggITuLrcaAAmjoTxSNNHnRaohydPMOOj
 iOkQmPtgjbe6Odny5jHl8tGjFzbXy17hbVzhliX5VmBk5caRbIDaH1smlVu6CLrNDVOCd40lr
 S9VAXfzUhG7R67wAng7MNvDdoXInn2CB+3nggLlBOm9toFrzJaoKy2BVscmZdpJLhKRID5y2U
 nawcUWHhun/j3eet6odlKo=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 4:18 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
>
> Attempting to boot 32-bit ARM kernels under QEMU's 3.x virt models
> fails when we have more than 512M of RAM in the model as we run out
> of vmalloc space for the PCI ECAM regions. This failure will be
> silent when running libvirt, as the console in that situation is a
> PCI device.
>
> In this configuration, the kernel maps the whole ECAM, which QEMU
> sets up for 256 buses, even when maybe only seven buses are in use.
> Each bus uses 1M of ECAM space, and ioremap() adds an additional
> guard page between allocations. The kernel vmap allocator will
> align these regions to 512K, resulting in each mapping eating 1.5M
> of vmalloc space. This means we need 384M of vmalloc space just to
> map all of these, which is very wasteful of resources.
>
> Fix this by only mapping the ECAM for buses we are going to be using.
> In my setups, this is around seven buses in most guests, which is
> 10.5M of vmalloc space - way smaller than the 384M that would
> otherwise be required. This also means that the kernel can boot
> without forcing extra RAM into highmem with the vmalloc= argument,
> or decreasing the virtual RAM available to the guest.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Looks good to me. I wonder if we should actually mark this for stable
backports. It is a somewhat invasive change, so there is a regression
risk, but it's also likely that others will run into this problem on distro
kernels.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
