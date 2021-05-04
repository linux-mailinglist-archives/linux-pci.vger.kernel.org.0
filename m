Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71C3726A1
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 09:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhEDHjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 03:39:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhEDHjj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 03:39:39 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MVrXh-1m5VXq3JsT-00RtKS for <linux-pci@vger.kernel.org>; Tue, 04 May 2021
 09:38:43 +0200
Received: by mail-wr1-f50.google.com with SMTP id l14so8216520wrx.5
        for <linux-pci@vger.kernel.org>; Tue, 04 May 2021 00:38:43 -0700 (PDT)
X-Gm-Message-State: AOAM531O8Z3cjjXW7hsU/oOk/ThBA8lVP1mccBGact54VEcHyUKSUfkx
        fV/OARIzR1ZmrsWqpYUQ7jwDi30m3uCP3Hnr2+M=
X-Google-Smtp-Source: ABdhPJy/PLg85qe+tELF8CiCMULGw8CmLjaQh6B4KQDvEe6Nzd0MKq4dD8b7Vp6q6w6wwtp+vCevzl5yt4x3J/k0HPs=
X-Received: by 2002:adf:c70b:: with SMTP id k11mr30476861wrg.165.1620113923438;
 Tue, 04 May 2021 00:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210503211649.4109334-1-linus.walleij@linaro.org> <20210503211649.4109334-2-linus.walleij@linaro.org>
In-Reply-To: <20210503211649.4109334-2-linus.walleij@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 May 2021 09:38:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a26RU=9waCmLgfjy3DA0BKuE5=gda=7vmeJGMtDRjdz7g@mail.gmail.com>
Message-ID: <CAK8P3a26RU=9waCmLgfjy3DA0BKuE5=gda=7vmeJGMtDRjdz7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM/ixp4xx: Move the UART and exp bus virtbases
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NCVgW3jPzPFV8mOUztWcfktvR0Mkh7Ya8yYNXr3A3xqQ+uliIF9
 RAqC3D35mjev7TJyVLT3SQ624a2yZZrhAV0neY5g2SLkteL/HZALePhQtwiHsj+PGjPXHar
 mbMnqVkt64WZVKCYovIH8n9HBa0xm1piyAZHizglDXLJuXS2icSrqRUz61ZYWakLpTrRvlt
 YmMV3IosaGCIh0X+9IaAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+5axUCIvhIo=:ReuPQzO/dusah7716auyrm
 QnJTMKsSCTAK+guoYB6RbyqFLqs8xv+7vmB8WrBpFK28Vxn2XaZTA7AD4Hg7g/V5sAz9GbUtH
 OxR01dUnNRrpkEqaMfAW42VQBcYJsCGBqRtYypx1ZdC2YlruVcewVT7TY2NOjkTKAlwD2Tc2y
 bP1pdpgGM7C5HN/mJsxgL0dFilS0VYo3eqx/3f8V+xyKFqwpRkWtUqQKWiNlqwi52CLEwxeDQ
 LnkT+2jIXsEwhtDa0LSwnKNdQLLfNr3jAEXr2/IUQovRclqPCufy82ZoY3melGjX9ZdXBcAk0
 5Ko5a3F/OXBKMUfmb2H3DbQ94B2VYmgOAq0JLsBfWsiF7GDYNWkxmHWREQrxWX5cjHTRWc9yE
 SzZTwpMQTY2VWjiAwZ2dHExo5z2hSuRn6lqVCRy6eZCMG4QFhThGq+jMqC68oA5xGjf+PgpZP
 zmfaIG+SZScj0jGtCfASQIT3LCVxWd76uRxfam1y+5oRczfYmQZXTPrVrz6YalqyLrur8bceg
 sqO8XnL5Qe2l0gCdkfKkJvoCHOo5RAcSntaiRlRQyfSwIhzn46S8YDdEHZh6zvTBfMh6IkrDU
 PF4f47ecw6TSab2NRSgv3RuNgi13UuOrSVHrfpdOOmjHCGGQfLRwfDKqDoIysuSNh0xIqIaWd
 Rue8=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 3, 2021 at 11:16 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> UART1, UART2 and the expansion bus config registers
> are the only registers mapped in a fixed location
> when using device tree.
>
> For device tree we also want to get rid of the custom
> <mach/io.h> for IXP4xx. So we need to undefine
> CONFIG_NEED_MACH_IO_H. Doing that activates the fixed
> mapping of the PCI IO space to PCI_IO_VIRT_BASE which
> is hardcoded to 0xFEE00000 and this would collide with
> the old fixed mappings.
>
> Move the UART1 and UART2 to the beginning of the fixmap
> region at 0xFFC80000-0xFFC81FFF and move the expansion
> bus base to 0xFFC82000-0xFFC81FFF in order to be able to
> accommodate for the fixed PCI virtual IO space.

This doesn't feel right to me, for multiple reasons:

- I don't think putting something into fixmap is valid unless you assign
  a fixmap constant in arch/arm/include/asm/fixmap.h for it and
  use that constant.
  We do have FIX_EARLYCON_MEM_BASE already, and we could
  in theory use the same constant for both debug_ll and earlycon
  (I think), or we could have adjacent pages for the two.

- IIRC, DEBUG_LL always uses a section map, so if you just need
  a single page, it doesn't work right.

Would it be sufficient if you just move IXP4XX_*_BASE_VIRT
from 0xFEF????? to 0xFEC????? ?

Idea I've had in the past was to treat DEBUG_UART_VIRT==0
as a special case that automatically picks a reasonable fixed
address, such as (0xfec00000 | (DEBUG_UART_PHYS & 0x1fffff)
and document that area in Documentation/arm/memory.txt as
the default place for debug_ll.

        Arnd

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Zoltan HERPAI <wigyori@uid0.hu>
> Cc: Raylynn Knight <rayknight@me.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> PCI maintainers: this patch is mostly FYI, will be
> merged through ARM SoC
> ---
>  arch/arm/Kconfig.debug                          | 4 ++--
>  arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h | 7 ++++---
>  arch/arm/mach-ixp4xx/ixp4xx-of.c                | 8 ++++++--
>  3 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 9e0b5e7f12af..bbe799f6bc03 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1803,8 +1803,8 @@ config DEBUG_UART_VIRT
>         default 0xfedc0000 if DEBUG_EP93XX
>         default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
>         default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
> -       default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
> -       default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
> +       default 0xffc80000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
> +       default 0xffc80003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
>         default 0xfef36000 if DEBUG_HIGHBANK_UART
>         default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1

Please keep these sorted numerically

        Arnd
