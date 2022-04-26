Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0781450FCC7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349984AbiDZMVx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349947AbiDZMVo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 08:21:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F53C2D1FB;
        Tue, 26 Apr 2022 05:17:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id j2so32669328ybu.0;
        Tue, 26 Apr 2022 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8bMngWVr0tdDN5yiWTr4GCLxeSgF3V3y+tGLoxVCwE=;
        b=PRM6gHAykZCXpCQH5Wk8cGO282pG77Ww8omQDxG+iNICtf6Y583Iv1oDHwR5jgWxlv
         hAiVerTzW/WBglfZmwOJeATGGNFIGUeSBqNrcr1+yyGzL+Piy9ke9uKErf72U57iZpfB
         ajJOW7YzJzLMQxtZiYmfusltKmmh23XSC/j6g0WP7/Xh7aIB6BHo6cqwSSnGcoOO1y+D
         rjxcH30lURrv6o3dnfN8aydhCKNWBXPMjlg4Kjk+r59/we0DKUZGfhBqhOBpL62mLNDZ
         VcE0iElzzWysREq918Ia6i8+mbxC9Vc36Lo72l1Q51v6XPgU/C/fZjbh78GsiSqTgAls
         i+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8bMngWVr0tdDN5yiWTr4GCLxeSgF3V3y+tGLoxVCwE=;
        b=Epzf7ddvFQ8bmt0gkaZsuPYNWgmaoTFY7vnKNZfgr5TDfgsMGsdKPcGKeIgNJ49Ocm
         /1WlpnJHXuL0Cw6Me1iWQQcgnvF5dbj+g8lpUM16QrgU2nhbqmzJDVv/BPUpj09Nr69n
         Ns9j2nxt7/ODq5QCFAwLn0Kxip+YAJt1VEyKOZ256NM231ESAOERnmHOlAlIB3RUZg3H
         3FjpxPQ7k1ozqxBMrw262F/tAO29rtki7SVlCpYOt42UePPD4eB2d+YYrxgKimZghSBS
         0f+20cyVq1kEKSw6joUkLMH3+fK9arVW7Rq/vREakhlQ7MrSD5ve0VS7w2vN14UphAvl
         IBiQ==
X-Gm-Message-State: AOAM530ybCMvcf6q+BlsGD2iU1G0Jamr5Bj2CVDIrTB5YZHs9wNrHlco
        NS9nfySUlJih/9OOKDsQm5S4wKSCiawIoUU9Lso=
X-Google-Smtp-Source: ABdhPJx0rpcQBG6rCBtHajN61Ati9nYNIN0fnUTzxWuvy/zu9z0hhhANAao1ToRixhOUAakqrY5Nme82QpTApzdY0j0=
X-Received: by 2002:a05:6902:143:b0:628:7cf1:f2a9 with SMTP id
 p3-20020a056902014300b006287cf1f2a9mr19922108ybh.51.1650975458538; Tue, 26
 Apr 2022 05:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220423152403.1681222-1-pgwipeout@gmail.com> <20220423152403.1681222-3-pgwipeout@gmail.com>
 <25fbf4763c28af4c73162dec254af6111e05461b.camel@pengutronix.de>
In-Reply-To: <25fbf4763c28af4c73162dec254af6111e05461b.camel@pengutronix.de>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 26 Apr 2022 08:17:26 -0400
Message-ID: <CAMdYzYpw-vUFTM=pmnASNrWvi0X4mM0hFKX7TRLHhJyehfuHkw@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] PCI: dwc: rockchip: reset core at driver probe
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 25, 2022 at 5:20 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Peter,
>
> On Sa, 2022-04-23 at 11:24 -0400, Peter Geis wrote:
> > The PCIe controller is in an unknown state at driver probe. This can
> > lead to undesireable effects when the driver attempts to configure the
> > controller.
> >
> > Prevent issues in the future by resetting the core during probe.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 22 +++++++------------
> >  1 file changed, 8 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index c9b341e55cbb..d67ed811e752 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -152,7 +152,13 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
> >       if (IS_ERR(rockchip->rst_gpio))
> >               return PTR_ERR(rockchip->rst_gpio);
> >
> > -     return 0;
> > +     rockchip->rst = devm_reset_control_array_get_exclusive(&pdev->dev);
> > +     if (IS_ERR(rockchip->rst))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
> > +                                  "failed to get reset lines\n");
> > +
> > +     return reset_control_assert(rockchip->rst);
>
> This makes "rockchip_pcie_resource_get" a bit of a misnomer, maybe move
> this out into rockchip_pcie_probe()?

Ah, yes that does make sense, thanks.

>
> > +
>
> Superfluous whitespace.
>
> regards
> Philipp
>
