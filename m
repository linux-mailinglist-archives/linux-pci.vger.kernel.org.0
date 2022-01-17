Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698ED491266
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 00:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiAQXiZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 18:38:25 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:32971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiAQXiY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 18:38:24 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHXSD-1n4sTm14k5-00DWsB; Tue, 18 Jan 2022 00:38:23 +0100
Received: by mail-oi1-f182.google.com with SMTP id bx18so7486623oib.7;
        Mon, 17 Jan 2022 15:38:22 -0800 (PST)
X-Gm-Message-State: AOAM531R/t0O6IZblCK86zf88yPCzEqZj5AEsMh32XCLJXhJa8VmyXGT
        zDmHAoxMOGb/04gfR6ZI6//0X9udBMkHiCNnBxk=
X-Google-Smtp-Source: ABdhPJy8xBuir7Y3TP7f897USxYmGz/RhF8Id1TC/8pZe6yR6GMlKE+Wl2YJMCge4jshYVhmgaMJvT0S9YFfvjIRSx4=
X-Received: by 2002:a05:6808:2206:: with SMTP id bd6mr14673246oib.11.1642462701926;
 Mon, 17 Jan 2022 15:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20220117220355.92575-1-marek.vasut@gmail.com> <20220117220355.92575-2-marek.vasut@gmail.com>
In-Reply-To: <20220117220355.92575-2-marek.vasut@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Jan 2022 00:38:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1vknLE-vfKZbvZDCLZMZk4ezirPeyHGnpkEW2RW1jvbg@mail.gmail.com>
Message-ID: <CAK8P3a1vknLE-vfKZbvZDCLZMZk4ezirPeyHGnpkEW2RW1jvbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: rcar: Return all Fs from read which triggered
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
X-Provags-ID: V03:K1:9DLUmXjttuHAIXkJxm/MC7xl9CXZzZluVHHTAGj+X+flfLdiiSc
 bjSKFDc6WWZIhUDZa0KlvqmVqwy5bT7cKr5INmUHd6TCBEpx9rmmaiZ0AALs3k2uROzyQa3
 aNEDEdmwZs1RWNbSjHazAuei+/yLkfrmL1KI43pRepTffsAbnK2fXplL0U/5Lh0uLtcqn4J
 5aHG5zEkhfcW9zI8YFJAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fWLE8/5HP6s=:7URBqeR9410uRkqfDMxx2T
 QQD5n145lO/0lZLAhwYIenNmveBpyR8WtI/OfxYkPr7jaAQzlyMh/cDcoAMekzlM+BfWpLWyf
 quqO++hqLwyYJgsKuhNUKA+D72VRrvgo5Tbg6tZ626VTr5P8Hyz6o5SF8SiUovOtzHhl+RBq5
 8j4ZfY66QCs2RKcz+oygIjKXEd3JbHJ1EJFL2Ae4mpz1kBFDROqczLCh9mrEbq1sves2z96o0
 vXpUIDsAx29GQFWlgbcOYbUMCiDgrGDkyUtcg018MqhT/pgsbjmicEBYwlPpRpfP+NiNM1r1e
 lB9x8GGFVSqsd1+I9cHjY82hTaEkLQpTlp1IzDtGZSWCKdZ9wo3pk/MP2w1gMQP0yXbwkUju2
 VGBzzTWDiYTdWhD9QU+1sstRBDU+fwVPCQTw5bc+GGArs1kyhgH9LCi2qkQx50umevgD1cZPL
 S4eZ3fTves+G+iVA23pnuz/4O7e47uJAxclwv1LXJZyA+LygW7iMB45COUCAodQ358uQXHL9W
 4TA79KAJzmC+QuSvCpBc1Qn7PTwvcZcQZ6dBFVOkqlyVecgW8PwMC4dfHCMw/W6HvHo0Rp5Zz
 5jRb9YRnsSfWtKH7TPAL1hKZonXjV4jtbcPuIQGWZE+mgxrEFuyuDHFC4TIJ2lOq3TxGb6laN
 hYrthk6HcHnLnWTyepsWOODJKUsXQrygAlH/SAkoY2srSjrKSxx0bGOJ9Q5MtPfHeVi8=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 17, 2022 at 11:03 PM <marek.vasut@gmail.com> wrote:
> It is possible to enforce the fault using 'isb' instruction placed
> right after the read/write instruction which started the faulting
> access. Add custom register accessors which perform the read/write
> followed immediately by 'isb'.
>
> This way, the fault always happens on the 'isb' and in case of read,
> which is located one instruction before the 'isb', it is now possible
> to fix up the return value of the read in the asynchronous external
> abort hook and make that read return all Fs.

Hi Marek,

As mentioned on IRC, I think this can be done a lot simpler, using a .text.fixup
section hack:
> +void rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
> +{
> +#ifdef CONFIG_ARM
> +       asm volatile(
> +               "       str %0, [%1]\n"
> +               "       isb\n"
> +       ::"r"(val), "r"(pcie->base + reg):"memory");


I think this would looks something like

   int error = 0;
   asm volatile(
        "       str %1, [%2]\n"
        "1:       isb\n"
        "2:\n"
        "         pushsection .text.fixup,\"ax\"\n"
        "       .align  2\n"                                    \
        "3:     mov     %0, %3\n"                               \
        "       b       2b\n"                                   \
        "       .popsection\n"                                  \
        "       .pushsection __ex_table,\"a\"\n"                \
        "       .align  3\n"                                    \
        "       .long   1b, 3b\n"                               \
        "       .popsection"                                    \
       : "+r" (error) :"r"(val), "r"(pcie->base + reg), "i" (-ENXIO):"memory");

This saves you from hand-parsing the instruction sequence, which tends
to be even more fragile. After this, you just need to check the
'error' variable,
which remains at 0 normally but contains -ENXIO if an exception hits.

I'm not entirely sure this works for the particular exception you are getting,
and it probably requires not registering the rcar_pcie_aarch32_abort_handler
function, but it seems likely to work.

        Arnd
