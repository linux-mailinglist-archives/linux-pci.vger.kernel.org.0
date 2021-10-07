Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0020425774
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbhJGQPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbhJGQPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 12:15:50 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84C4C061570;
        Thu,  7 Oct 2021 09:13:56 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id p18so7244828vsu.7;
        Thu, 07 Oct 2021 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/o8NPJje5ot5/aF0XpJWy6+VB0DZerHIS0Mf5Yxj4U=;
        b=C3UJQDCwjR5x6GYe1QTlKeSpX2Hc8klUILtPKHXL9f8hKudZ6kSz68Z2HuTIi2ZrUU
         +sLxLGahfxkiEHdUO/Jyqc25pNntYlfCJfR/5SmsQtSHGsyqrDjmV+kLQ5ip+5nFqKl8
         Wbsubk5jxn7y65882ZJN3NCL8t2DliV8pFnICx7bMrVRQZaiK1chGImdx41rfvRBA0wU
         v23J++kq54HgKMvWudK+sYrqM6MG182rQ2JK01XttZA13xeAIwcuW4Iy1GarUhNjTULC
         hvWVQycFn7eTU+I0XHzjEyC4zZ9S4HikwX9TQRZgxrSbC1rA8UZRCf9J4v7Q4RCK5b0P
         oL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/o8NPJje5ot5/aF0XpJWy6+VB0DZerHIS0Mf5Yxj4U=;
        b=mZTjCGKcMfuKDw/wwW2/DgIqn+pqP3qVydDlJZRHi8OBemfM0Qs+296HzvSIMF7rPO
         UJYf6M9g83jYJ5vEUN/N8ui586V1d8SyPxm1fy3puWN/gmp5dV1adIMNPhf7DIoW6Y39
         JQeEgLpxxHFFV9vDB/Bfv7NErmNVOYBtToqWFyrLdngzriPIxO0+S2X3UfJylXCfmlWv
         sd6Y2pHbS8vUbxYudo+vAwTy7//lVEJxSVZ0MFXWSwWIwQLaLuZtaY+TurFHXUeXh1cD
         Cvs+oVrOPGn+iZAo3l7QhUZEVe8m/ds+drUy6VayGRkRmA8grLGsoA4d09IEtr5O1Gvp
         kTWA==
X-Gm-Message-State: AOAM530tTgzOTBfMCzYnSyvZH0eBTn0yD9KO8TmvwPNCKvenk2MPKYtc
        cgCZyvaWhOcmFmiEsaYx+WlkDJZgIPVXL4bD1Q==
X-Google-Smtp-Source: ABdhPJwQa1uclhiiXKUPPeTGSMuc8RzY07oYdohLHz56SYEA0XbsKsBkx8qgthulXazx3F0Q+pHYlztaQQs7EiELKfE=
X-Received: by 2002:a67:e192:: with SMTP id e18mr5379758vsl.26.1633623234759;
 Thu, 07 Oct 2021 09:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <87ee8yquyi.wl-maz@kernel.org> <CALjTZvakX8Hz+ow3UeAuQiicVXtbkXEDFnHU-+n8Ts6i1LRyHQ@mail.gmail.com>
 <87bl41qkrh.wl-maz@kernel.org> <CALjTZvbsvsD6abpw0H5D4ngUXPrgM2mDV0DX5BQi0z8cd-yxzA@mail.gmail.com>
 <878rz5qbee.wl-maz@kernel.org> <CALjTZvZZf25tqoQWM_HsBb84JgKpMKAxqfhUdpD_e5M-Bc_yzA@mail.gmail.com>
 <875yu8rj5t.wl-maz@kernel.org> <CALjTZvbZK3vxexyoEHmh9TPoceckvGV7ACHjOa0rJ9HH=YAyYA@mail.gmail.com>
 <874k9sri65.wl-maz@kernel.org>
In-Reply-To: <874k9sri65.wl-maz@kernel.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 7 Oct 2021 17:13:43 +0100
Message-ID: <CALjTZvYZcDS5HB=3h8u68jaTRNTXENQGV96reOeDS544fVceew@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Marc,

On Thu, 7 Oct 2021 at 16:03, Marc Zyngier <maz@kernel.org> wrote:
>
> Duh. Make that:
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dc7741431bf3..89c7c99cd1bb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5798,6 +5798,6 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>
>  static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>  {
> -       pdev->dev_flags |= PCI_MSI_FLAGS_MASKBIT;
> +       pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
>
>         M.
>
> --

The previous patch with this fixup on top also fixes the problem for
me. No issues on the GPU side (other than the existing ones, due to
NVIDIA uncooperativeness, regarding nouveau). Feel free to add my

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks,
Rui
