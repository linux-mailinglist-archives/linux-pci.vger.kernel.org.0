Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9007548C64B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354194AbiALOnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 09:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354224AbiALOnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 09:43:09 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF3C06173F;
        Wed, 12 Jan 2022 06:43:09 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id g5so1856527vkg.0;
        Wed, 12 Jan 2022 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YuLML67FvMTXCFOyBy0QsGo20H8VwFueQSoBZ6wWnSQ=;
        b=TWj8wv6JAtkU5obWQkGAQ+Xf5SmvAkdPJCv/mni2+ELsbXLTqo7KXO8vKVA0HKItYE
         1/DgbX77M1BMcAWZAV+/nxU+/NELLORfZW1QeSu8tjt4LN/DRbCFKlFbekwBttY6qg1M
         J4CKVorPvT905ZDZN3ntTPTkKqhNxVe5IUmWKD0VZ4R9NoB/n0jsdj2qSFKVp9+63IRQ
         kDXlZT9lI53tPvqFzy2jQ9UJkJWe2d9xbLC6LTy8Pu4/9NWcJHhg7GHIArQyza4vdgm9
         pQ39+vAl7kM+2T09Oh9RKMjSM5jLUc3x+q1vK+LFO2gt268Y3U3kPzLzTXZs3Eoi5NIY
         hteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YuLML67FvMTXCFOyBy0QsGo20H8VwFueQSoBZ6wWnSQ=;
        b=q9vaFR6tqcZsSQkpTo7grp9whDwyjctyerFV3aySyKuj0O/GaNIjNeQiPH4wH8XfZq
         dihG8heYQ7rtb0lb+xTcpwuF9uUkdbeZ6ubGBBSNgxawaVdPbOsnR2TBB18KaTmC5wih
         97p2xCVQKRGzYpYMtoZskPY5Yc5JFXZ76+PD5RH9GCXQMFN21VXLK2fU6FU+OG8SyhSz
         shVSu49lXVceb9rJ4WKtOmQc///bEVRfko0VHNkM8RQGvuuomvcVox4dVHMMpYzN4n4m
         IBeudOgrRc3Sr1LRma+VmeW8e0qW0KZRXw1sTLf3x5FO+cWvic8LIvpb1JkrZ27/JMGE
         Vyrw==
X-Gm-Message-State: AOAM532ccHmQXH20kW/WN2cN2MiJ7biYgpuUX+o4pYhyVx6vvsY9TIGa
        L5mIW8kmjJK1qlUBHQkgm0PxQpMbuXmszgBTEqxY7yPpiG4=
X-Google-Smtp-Source: ABdhPJwqp7aTaC7M4DpP5Pl8nm2+KXgioYyrJgSrDqRuM4bQ87FjhRqqZvIdJGaEEOP6ggAh2+HZZCLhWxdyYFBn68M=
X-Received: by 2002:a1f:fcc9:: with SMTP id a192mr2733193vki.1.1641998587825;
 Wed, 12 Jan 2022 06:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 12 Jan 2022 15:42:56 +0100
Message-ID: <CAMhs-H886ZPZED-qmMtZcWFabRLNL14Y7SSz_Ko7d45zXL+v2w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PCI: mt7621: Remove specific MIPS code from driver
To:     linux-pci <linux-pci@vger.kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Lorenzo,

On Tue, Dec 7, 2021 at 11:49 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi all,
>
> MIPS specific code can be removed from driver and put into ralink mt7621
> instead which is a more accurate place to do this. To make this possible
> we need to have access to 'bridge->windows' in 'pcibios_root_bridge_prepa=
re()'
> which has been implemented for ralink mt7621 platform (there is no real
> need to implement this for any other platforms since those ones haven't g=
ot
> I/O coherency units). This also allow us to properly enable this driver t=
o
> completely be enabled for COMPILE_TEST. This patchset appoarch:
> - Move windows list splice in 'pci_register_host_bridge()' after function
>   'pcibios_root_bridge_prepare()' is called.
> - Implement 'pcibios_root_bridge_prepare()' for ralink mt7621.
> - Avoid custom MIPs code in pcie-mt7621 driver.
> - Add missing 'MODULE_LICENSE()' to pcie-mt7621 driver to avoid compile t=
est
>   module compilation to complain (already sent patch from Yanteng Si that
>   I have rewrite commit message and long description a bit.
> - Remove MIPS conditional code from Kconfig and mark driver as 'tristate'=
.
>
> This patchset is a real fix for some errors reported by Kernel Test Robot=
 about
> implicit mips functions used in driver code and fix errors in driver when
> is compiled as a module [1] (mips:allmodconfig).
>
> Changes in v3:
>  - Rebase the series on the top of the temporal fix sent for v5.16[3] for
>    the module compilation problem.
>  - Address review comments from Guenter in PATCH 2 (thanks Guenter!):
>     - Address TODO in comment about the hardware does not allow zeros
>       after 1s for the mask and WARN_ON if that's happend.
>     - Be sure mask is real valid upper 16 bits.

What are your plans for this series? Can we merge this?

Best regards,
    Sergio Paracuellos

>
> Changes in v2:
>  - Collect Acked-by from Arnd Bergmann for PATCH 1.
>  - Collect Reviewed-by from Krzysztof Wilczy=C5=84ski for PATCH 4.
>  - Adjust some patches commit subject and message as pointed out by Bjorn=
 in review of v1 of the series[2].
>
> This patchset is the good way of properly compile driver as a module remo=
ving
> all MIPS specific code into arch ralink mt7621 place. To avoid mips:allmo=
dconfig reported
> problems for v5.16 the following patch has been sent[3]. This series are =
rebased onto this patch to provide
> a real fix for this problem.
>
> [0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=3DV36=
5RXN_Kjuj=3DfPFENGJiiw@mail.gmail.com/T/#t
> [1]: https://lkml.org/lkml/2021/11/14/436
> [2]: https://lore.kernel.org/r/20211115070809.15529-1-sergio.paracuellos@=
gmail.com
> [3]: https://lore.kernel.org/linux-pci/20211203192454.32624-1-sergio.para=
cuellos@gmail.com/T/#u
>
> Thanks in advance for your time.
>
> Best regards,
>    Sergio Paracuellos
>
> Sergio Paracuellos (5):
>   PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
>   MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
>   PCI: mt7621: Avoid custom MIPS code in driver code
>   PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
>   PCI: mt7621: Allow COMPILE_TEST for all arches
>
>  arch/mips/ralink/mt7621.c            | 31 ++++++++++++++++++++++
>  drivers/pci/controller/Kconfig       |  4 +--
>  drivers/pci/controller/pcie-mt7621.c | 39 ++--------------------------
>  drivers/pci/probe.c                  |  4 +--
>  4 files changed, 37 insertions(+), 41 deletions(-)
>
> --
> 2.33.0
>
