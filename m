Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F94971E8
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jan 2022 15:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiAWOMi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 23 Jan 2022 09:12:38 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:46099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiAWOMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jan 2022 09:12:37 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MXH3Y-1mmoX40TGg-00YmMA; Sun, 23 Jan 2022 15:12:36 +0100
Received: by mail-ot1-f48.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso2308358otl.8;
        Sun, 23 Jan 2022 06:12:35 -0800 (PST)
X-Gm-Message-State: AOAM533g0oZsbp7Z/anzF7agG3MU4kp3uVYOvgqFhY/w/l7jmhe9cPqD
        SdvCg48ZaJ6U9zTUMvSL1JAMwqpokyzwGt5uVUQ=
X-Google-Smtp-Source: ABdhPJwsxPN5euMvtpK7DNRSulHCrUsUHaRKuofZ2zjhjCoIyYh865xy9dYYLJyS7znZPg5TPtlrfDZCnXkEbwxcBdA=
X-Received: by 2002:a9d:7757:: with SMTP id t23mr885681otl.368.1642947154756;
 Sun, 23 Jan 2022 06:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20220122221554.196311-1-marek.vasut@gmail.com> <20220122221554.196311-2-marek.vasut@gmail.com>
In-Reply-To: <20220122221554.196311-2-marek.vasut@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 23 Jan 2022 15:12:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1vw3n_QbT-aqSzWFavKMmYtBqQptvMxeZmDF+-bO0dGA@mail.gmail.com>
Message-ID: <CAK8P3a1vw3n_QbT-aqSzWFavKMmYtBqQptvMxeZmDF+-bO0dGA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which triggered
 an exception
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:JJAkLKIx9MEQb7WOcNk+/a4wEjdqWd3f5Jcre5K8F3JsdS6Vc0A
 APyKRswQrnmV00pcwLcQaCJ14GXvms8YIyfqoLwT2mLMO4of4D4yGlvHi4V/As1n5HWTC3Y
 /f9Xe8owyCt7B4CLToF92pJJtllQ6rKhizhCYh7s8kNQfZwY+E5Fu3mu5YzTO+pZPjh3sOT
 rEAch7Fs2+yuY3hx6jsLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6CMKSNvHvyg=:Rsaa9CH2shYVghPqlHbSMd
 FNsoHRHj8kUNLkpBmBwWIqFYjYrljs1CJTkBxfWWzTyVf7ebndkXcJ5vlptbK8ZuYW4mIGOXJ
 wDcAoARCXAWIerZaR4/2Uz1zrRkPLY8x+RSlbXX//sdU+TC402Nw0lCeXDyyU8KhTlkGQm3/O
 Gx54g9FQH/+tcbU9HiML+8KDWAFRudvNYPchoGFQ5eDj6YpQ7oz9lQr8+RprbdlhvK1qx8qss
 sm12PDjJJT79NLvTM2oCZxTzawu4L8GCeazHK2BnK3+HcsJhioeiHvBe6mo+tBCVXEWR0kea0
 pszyYRtIAnBjmEvBNN6VwDSQWajUXkCVXrLqNttwO4Gt+zZqibPL5Z9z3+nqxDtDyflNR5MT0
 Dv/97A3954G/ly6vg6x/RhPlq9fpPaprbDzokvuCFI0FCA8Bt+Kbf4ve/8Cz5LJzVJEkCqkdl
 FXJ0stMghY7Kxnwa2+Ks9j/ujimi1sdh47kl4MIS1yJDEHu6/Q4hvsxl4wcNv1mQ/OOkuH2WM
 YxbGNaV86Fxw8w7RHRI67DgNDmaQ+v8foxay6C9aD4rVaQzyy2X4clwvdZ0ac4V5+rc5WIxJk
 1HUQwp3Aewq93Eamo5lyI+fX3+Zd5usB9l11F4yjLb7aJu/UyFDwVopnq8bd2mxq09D8zdg3H
 D+RLSvlYQFUmiJfRd756JNO8lOnzL20R67Pv66oxSIrsIneF9O619wCr5KWiS/7onsHI=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 22, 2022 at 11:15 PM <marek.vasut@gmail.com> wrote:
>
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> any read/write access to PCIECDR triggers asynchronous external abort. This
> is because the transition to L1 link state must be manually finished by the
> driver. The PCIe IP can transition back from L1 state to L0 on its own.
>
> The current asynchronous external abort hook implementation restarts
> the instruction which finally triggered the fault, which can be a
> different instruction than the read/write instruction which started
> the faulting access. Usually the instruction which finally triggers
> the fault is one which has some data dependency on the result of the
> read/write. In case of read, the read value after fixup is undefined,
> while a read value of faulting read should be all Fs.
>
> It is possible to enforce the fault using 'isb' instruction placed
> right after the read/write instruction which started the faulting
> access. Add custom register accessors which perform the read/write
> followed immediately by 'isb'.
>
> This way, the fault always happens on the 'isb' and in case of read,
> which is located one instruction before the 'isb', it is now possible
> to fix up the return value of the read in the asynchronous external
> abort hook and make that read return all Fs.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Wilczyński <kw@linux.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

provided once concern gets resolved:

> +#ifdef CONFIG_ARM
> +#define __rcar_pci_rw_reg_workaround(instr)                            \
> +               "1:     " instr " %1, [%2]\n"                           \
> +               "2:     isb\n"                                          \
> +               "3:     .pushsection .text.fixup,\"ax\"\n"              \
> +               "       .align  2\n"                                    \
> +               "4:     mov     %0, #" __stringify(PCIBIOS_SET_FAILED) "\n" \
> +               "       b       3b\n"                                   \
> +               "       .popsection\n"                                  \
> +               "       .pushsection __ex_table,\"a\"\n"                \
> +               "       .align  3\n"                                    \
> +               "       .long   1b, 4b\n"                               \
> +               "       .long   1b, 4b\n"                               \
> +               "       .popsection\n"
> +#endif

You list the fixup for the ldr/str instruction here twice, (.long 1b,4b), but
no fixup for the isb instruction (.long 2b, 4b). Your description says that
the fault happens on the isb, not the ldr, so I don't understand what is
going on here.

       Arnd
