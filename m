Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3519577FA7
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2019 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfG1NmB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jul 2019 09:42:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36665 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1NmB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2019 09:42:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so57072285edq.3;
        Sun, 28 Jul 2019 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTBwHNHT3KHAp/UaTaH4Up3YEwsrhkbymBNCkcdraJ4=;
        b=UQWUwAU/aLkzrRJuq7lz6WfmkRCRPcRIkelqPKRkPBmQvdcVxlDWInaTr16xiYUOTh
         LaIL6njzffcFYPhbX3vBZ31RhD8oEUnYxYzGm6URgF9ybzNE3wjQD+Q91qr4QpoP89x/
         7AZ+mKc/2Z03uFx+5PK5F7JsddDDwG8851Ro9yV3keN1CYuu0p24wRy19pNYk0P6i2YX
         l/zE2saf2xRu5aXu/3I3UG3IZKFaKpY44+0qACOrLx5/D1k08/toiQG0I7wjC4ntV3n0
         mXhsVFqhR+jOLJT3+Q5iz0xFOVDJeqJPDwbI+s2WDPn2gxr6HeePvKoF/ToqjaZSBtLa
         M8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTBwHNHT3KHAp/UaTaH4Up3YEwsrhkbymBNCkcdraJ4=;
        b=mQpKveWgg9CG9uIgqGmYufZtm7gd5dMpvToTMDB/njS5o+AQl8avAoqv77VX2IXyQ/
         9EUolbxNCuTjYxXHth0DWEnOzB6grGeStFC4rjVCjQeP904Yqk//IP+/Zi6Vjc/M1fEg
         8y7no3BL2wm4pmm15acbGs9RYCCGXOejkGnqBznB6rSkw7oUr3IAroRHkFztLDnkstOa
         eoXBTJgEe24OrKsvOrYe0bNhFwalOPin3UtC0I5zE4VEpPiL32HIjVmfFu1riy++mDuz
         yrhXVlnsW8oIbzAV2zu51JgcP4Jhs2Uns0HdlnMmvY1ReT3wIjrcb1Zr/6uy7ZfTwTBe
         DJIw==
X-Gm-Message-State: APjAAAXARECJPmxsaKUnzlKFUKhkF+lpFChZKCI7ic/Groq+pa95NDzX
        A50RodTeQ2UwT5nkpqcLHoFNag264bdn4xTokJo=
X-Google-Smtp-Source: APXvYqzBKvd0Qybj93U8jK8asK800I/u667umXFP0VgBlCHZHI45yVtwQGVyY3X1SFkkAX087eMxDRfleptdKbmxNjo=
X-Received: by 2002:a50:94e6:: with SMTP id t35mr91612893eda.137.1564321319323;
 Sun, 28 Jul 2019 06:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1907251426450.32766@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907251426450.32766@viisi.sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 28 Jul 2019 21:41:48 +0800
Message-ID: <CAEUhbmX1vJbm9NNU-5OkSaWDRN0pK0=1D6ZLXHD45PNAqDu6gw@mail.gmail.com>
Subject: Re: [PATCH v2] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default on RISC-V
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, wesley@sifive.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 5:28 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> From: Wesley Terpstra <wesley@sifive.com>
>
> This is part of adding support for RISC-V systems with PCIe host
> controllers that support message-signaled interrupts.
>
> Signed-off-by: Wesley Terpstra <wesley@sifive.com>
> [paul.walmsley@sifive.com: wrote patch description; split this
>  patch from the arch/riscv patch]
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  drivers/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 2ab92409210a..beb3408a0272 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -52,7 +52,7 @@ config PCI_MSI
>            If you don't know what to do here, say Y.
>
>  config PCI_MSI_IRQ_DOMAIN
> -       def_bool ARC || ARM || ARM64 || X86
> +       def_bool ARC || ARM || ARM64 || X86 || RISCV
>         depends on PCI_MSI
>         select GENERIC_MSI_IRQ_DOMAIN
>
> --

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
