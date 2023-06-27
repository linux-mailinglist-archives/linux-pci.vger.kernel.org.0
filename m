Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666E173F8DE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjF0Jj4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjF0Jjz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 05:39:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57581BFF
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 02:39:53 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so4310077276.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687858793; x=1690450793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn0C7O9nMZ5Wi0Zbye67I3FQVecNp26TCCl9fOKO3fM=;
        b=YBN3YsU7R4hLm+8i90ByP5RtYnRRHQ4PQVyd6G6gG4ZiZ/O8xT5dBTg+NeUhJjjWO3
         I9kvpKeiY885IKxtF3pmHfmjjxovdzzhlzfOtRomKRDXAwODiLSl4lFaOnjRxuLHYxgU
         QGiWUGT0eyzkyaZoaWRqKxn8tHnqN3wjYI19a4+EUKFSRe11lZj2qU/7fGGEhuO5qqal
         qJVOkFBfbb8hjAE8L4u2mXqfkUv6NjgBmSDg2xcWZgLId293JVXqEkUQYf3h5NYGpu7Y
         fTyme6s5plR+Xf78CacjPsbiEpLFXPg191xs5++tZjODYe9Fo08gOpyOsDeFLmM57SPG
         SL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687858793; x=1690450793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn0C7O9nMZ5Wi0Zbye67I3FQVecNp26TCCl9fOKO3fM=;
        b=S3xr0UD7tD7QQvx4GqsIHfhWDIUrvBLxSlEMBQdHxsSVkGRl6WH5EwM4y3BkHw94CU
         Z2KZYgiyCRKY8Z11bfb7OgDtEbJTQonOmvt+WUN4mL18hcZE5eYDZDv2ImSkssc4gmx/
         wMGETvzlrFI939IdncLBAwRnVDgbFDjonN4e1wFBWhr/FGnfII/fY2tR2qwRdC3PD1/9
         9Wgi/m+6oTagio0LMkc0k/LOlLwTAmcxZermRLmeUVE7ctYghFcz6y/55rOrQKUFNlSx
         EEaBfLel2lQG5u5zuP69iGUoUJaT9wdCoPpBzUuUlPjSvfN/AfzYIUMYZuvD0TC5Mb89
         nJBA==
X-Gm-Message-State: AC+VfDz3ttuIyGK4q/AIvSaILxpjj1TXQvMxVzPo4YbWtK72dCvE+xo+
        vYZpFIUftc9Kw/TDJkW708drFHXC2iD55tx99CI=
X-Google-Smtp-Source: ACHHUZ4GwLk1MnFYAlYiY+swMAKYo2lTq0u4epT328hHehGUsFjiL7jJ5mSXDpSgJebctlYAsXktSJfqSsZVhlVzqF0=
X-Received: by 2002:a25:ad9f:0:b0:bc6:91e5:7b4e with SMTP id
 z31-20020a25ad9f000000b00bc691e57b4emr27550432ybi.13.1687858792871; Tue, 27
 Jun 2023 02:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <8d19e5b7-8fa0-44a4-90e2-9bb06f5eb694@moroto.mountain>
In-Reply-To: <8d19e5b7-8fa0-44a4-90e2-9bb06f5eb694@moroto.mountain>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 27 Jun 2023 11:39:16 +0200
Message-ID: <CAAEEuhrYr3ejHXH0TdvUJjXp+0cTnhsPJD6eUR1+Y=+ycjy+yA@mail.gmail.com>
Subject: Re: [bug report] PCI: rockchip: Fix window mapping and address
 translation for endpoint
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 9:19=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Rick Wertenbroek,
>
> The patch dc73ed0f1b8b: "PCI: rockchip: Fix window mapping and
> address translation for endpoint" from Apr 18, 2023, leads to the
> following Smatch static checker warning:
>
>         drivers/pci/controller/pcie-rockchip-ep.c:405 rockchip_pcie_ep_se=
nd_msi_irq()
>         warn: was expecting a 64 bit value instead of '~4294967040'
>
> drivers/pci/controller/pcie-rockchip-ep.c
>     351 static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep =
*ep, u8 fn,
>     352                                          u8 interrupt_num)
>     353 {
>     354         struct rockchip_pcie *rockchip =3D &ep->rockchip;
>     355         u32 flags, mme, data, data_mask;
>     356         u8 msi_count;
>     357         u64 pci_addr;
>                 ^^^^^^^^^^^^^
>
>     358         u32 r;
>     359
>     360         /* Check MSI enable bit */
>     361         flags =3D rockchip_pcie_read(&ep->rockchip,
>     362                                    ROCKCHIP_PCIE_EP_FUNC_BASE(fn)=
 +
>     363                                    ROCKCHIP_PCIE_EP_MSI_CTRL_REG)=
;
>     364         if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
>     365                 return -EINVAL;
>     366
>     367         /* Get MSI numbers from MME */
>     368         mme =3D ((flags & ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK) >>
>     369                         ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET);
>     370         msi_count =3D 1 << mme;
>     371         if (!interrupt_num || interrupt_num > msi_count)
>     372                 return -EINVAL;
>     373
>     374         /* Set MSI private data */
>     375         data_mask =3D msi_count - 1;
>     376         data =3D rockchip_pcie_read(rockchip,
>     377                                   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) =
+
>     378                                   ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
>     379                                   PCI_MSI_DATA_64);
>     380         data =3D (data & ~data_mask) | ((interrupt_num - 1) & dat=
a_mask);
>     381
>     382         /* Get MSI PCI address */
>     383         pci_addr =3D rockchip_pcie_read(rockchip,
>     384                                       ROCKCHIP_PCIE_EP_FUNC_BASE(=
fn) +
>     385                                       ROCKCHIP_PCIE_EP_MSI_CTRL_R=
EG +
>     386                                       PCI_MSI_ADDRESS_HI);
>     387         pci_addr <<=3D 32;
>
> The high 32 bits are definitely set.
>
>     388         pci_addr |=3D rockchip_pcie_read(rockchip,
>     389                                        ROCKCHIP_PCIE_EP_FUNC_BASE=
(fn) +
>     390                                        ROCKCHIP_PCIE_EP_MSI_CTRL_=
REG +
>     391                                        PCI_MSI_ADDRESS_LO);
>     392
>     393         /* Set the outbound region if needed. */
>     394         if (unlikely(ep->irq_pci_addr !=3D (pci_addr & PCIE_ADDR_=
MASK) ||
>     395                      ep->irq_pci_fn !=3D fn)) {
>     396                 r =3D rockchip_ob_region(ep->irq_phys_addr);
>     397                 rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
>     398                                              ep->irq_phys_addr,
>     399                                              pci_addr & PCIE_ADDR=
_MASK,
>     400                                              ~PCIE_ADDR_MASK + 1)=
;
>     401                 ep->irq_pci_addr =3D (pci_addr & PCIE_ADDR_MASK);
>     402                 ep->irq_pci_fn =3D fn;
>     403         }
>     404
> --> 405         writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MA=
SK));
>
> PCIE_ADDR_MASK is 0xffffff00 (which is unsigned int).  What Smatch is
> saying here is that pci_addr is a u64 it looks like the intention was to
> zero out the last byte, but instead we are zeroing the high 32 bits as
> well as the last 8 bits.

Hello,
You are right there is a problem.

The warning at line 405, however, seems to be a false positive. Because the
mask is 0xffffff00 (which is unsigned int) and the ~ is applied before prom=
otion
this results in 0xff, which is then promoted to 0x00000000000000ff when app=
lied
to pci_addr so this is fine.

What you describe about zeroing the upper 32 bits and not only the lower 8
refers to line 399 where we apply the PCI_ADDR_MASK 0xffffff00 with the
& operator to pci_addr, this is the real issue, as you said this
zeroes the upper
32-bits, which is not the intended behavior. Thank you for pointing this ou=
t.

The original function had the mask constant as a u64 variable (with inverte=
d
logic) :
https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/pcie-=
rockchip-ep.c#L415

I replaced this with a constant and thought it would be promoted, but since
it is promoted to unsigned it isn't sign-extended, therefore the upper 32-b=
its
are zeroed which is not the intended behavior

The simplest way to fix this would be to revert to the initial logic with t=
he
variable as linked above. Or to replace set the constant to 0xfffffffffffff=
f00
and revert the two changes in drivers/pci/controller/pcie-rockchip.h :

-#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR    0xffffff00
+#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR    PCIE_ADDR_MASK

-#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR    0xffffff00
+#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR    PCIE_ADDR_MASK

>
>     406         return 0;
>     407 }
>
> regards,
> dan carpenter

Thank you very much for spotting this.

I will prepare the patch for this in a few days (I am currently out of offi=
ce),
I'll add the "reported-by" tag and fix this, unless you want to fix and sub=
mit
it right away.

Thanks.
Best regards,
Rick Wertenbroek
