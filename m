Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583EE418398
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 19:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhIYReg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 13:34:36 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhIYReg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 13:34:36 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTiHb-1mHlKw471p-00TzWj; Sat, 25 Sep 2021 19:33:00 +0200
Received: by mail-wr1-f46.google.com with SMTP id i24so21423252wrc.9;
        Sat, 25 Sep 2021 10:32:59 -0700 (PDT)
X-Gm-Message-State: AOAM533ZsHyLdLpW9N6lU0jgbmdQj8TvLDtAlIYD9ZaeGC+RJFg4PBdc
        uIFE79wgI258XtH+48L3ibJIeDqJXFoKN+dUHDA=
X-Google-Smtp-Source: ABdhPJy3Bi6jZ9YJhd1Jir95pwQbKf3lgFpAtVfbTLeqV60We3le1OMF5o2WY/XSSxdey4NUYwb7U4KsUjdjgMVoko4=
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr7902480wmf.82.1632591179581;
 Sat, 25 Sep 2021 10:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com> <20210924211139.3477-4-sergio.paracuellos@gmail.com>
In-Reply-To: <20210924211139.3477-4-sergio.paracuellos@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Sep 2021 19:32:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3O+tVZDFDHGtUwm0sDkCHJY3DU13S+KGgMCHyZO1E9Fw@mail.gmail.com>
Message-ID: <CAK8P3a3O+tVZDFDHGtUwm0sDkCHJY3DU13S+KGgMCHyZO1E9Fw@mail.gmail.com>
Subject: Re: [PATCH 3/6] MIPS: ralink: set PCI_IOBASE to 'mips_io_port_base'
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, neil@brown.name,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nRhe4NmScWRcm7zQw5RpI0Ex7D3yMzGM99hvD2Cuume977M5QhB
 hOL3hd+y8gaGTcHfUu4cGu5FuYW1BBzh1PMJx7yXMiEGaqQNlA+z7Rd5v8CAVyfGoNWG4cZ
 bSsbvdGWvBwsUNMsPQduecVI4rOVdiK1O1V+WYLhkjqGaDWiTq3zN0MPsJ7EIc5Zrr9XG9E
 GUvrf7a1yBuLG8/8BWquw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BNeDxW5QH1k=:MJHU6a9l6/nBr07dhf90RG
 fBsaQXzASgNt6j+cvpFhlxej7B7qSrOev+N4o7nQ0ub0JXoTIIm/9epax/5qJMpP0B0UaRvd4
 DeMJQ9AeJfBf8d12EVKI5M3nwskh6LJ3vRircuUDtR/Fk0aHg0oSIg/UzuY3I4shWBL6tMCX1
 6YlTPEGN0uWHK/G9jT6zxh+CVX2nVnxI3VOVwKPf1kgkcnPsgUFTvgwtm/vsbtP45B0yPVJKL
 huKrNTR99+qhJeiSEoTl0AtS3IMcnXMN+rK4m2SO16KSYl6GBGnjOXZV8e+qsLo/LDKNOkaUz
 f78es96bib0Oi50UTdWqvQy6aKbLJ0AXe2iKCnBvwQkra6FBFNhYY2vdwE00DMgbV0Ajl67Gd
 C1TPGoY0TawJ3/A/UTPPNCn3E0/cMMOte2r7Dv2ksKEdcK+RutfUjhlzcRmy2CELxDJGZ2yCo
 3O9JHQe1EWREXzOaX4ytsW2itQ6dR/Gy0pIl9UKsd0sL0WFmrm9S3NZ3KUdj+cdIgk4yrpSJ7
 eO7GCrgy1otd2v7ZTAPD8aZ3+DFiz56T8IkEjHt4AC2pJ0GSCW3oX9AMqh2CbEql0SvGR32Xc
 lcOOtDHeeD/qdCbHuwt/I+OJVSTKcP51g5J71lG6CfHnTa3woy5aaEAXKPg4PmX19K+lIJDEp
 fxb4dmhZD5nBcxVt5gQfZCRdAN+kIzxi4S4rhFi51Vt6T53Mix6Lesvsrk0K46bH0XUxj04hB
 IOx/M6HxosW7/noDmwnzb6Y1o48alyxstoutia4+r0y0TF+jxhfRKMKEBfPtV+qV5UsBR1CoN
 iLXdoaIZ1gyZE0HFRHtzDWQm86ci+6cZXvRkkyaFhGlPqEKX3e21PJMT/9355InwzY5BHUFEQ
 3aSV0eEoAPtyyrgWjZGQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 11:11 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> By default MIPS architecture use function 'set_io_port_base()' to set the
> virtual address of the first IO port. This function at the end sets variable
> 'mips_io_port_base' with the desired address. To align things and allow
> to change first IO port location address for PCI, set PCI_IOBASE definition
> as 'mips_io_port_base'. Also, we only need a size of 64 KB.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/include/asm/mach-ralink/spaces.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
> index 87d085c9ad61..05d14c21c417 100644
> --- a/arch/mips/include/asm/mach-ralink/spaces.h
> +++ b/arch/mips/include/asm/mach-ralink/spaces.h
> @@ -2,8 +2,8 @@
>  #ifndef __ASM_MACH_RALINK_SPACES_H_
>  #define __ASM_MACH_RALINK_SPACES_H_
>
> -#define PCI_IOBASE     _AC(0xa0000000, UL)
> -#define PCI_IOSIZE     SZ_16M
> +#define PCI_IOBASE     mips_io_port_base
> +#define PCI_IOSIZE     SZ_64K
>  #define IO_SPACE_LIMIT (PCI_IOSIZE - 1)

Acked-by: Arnd Bergmann <arnd@arndb.de>
