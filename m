Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FEB4BAC68
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 23:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbiBQWP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 17:15:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbiBQWP6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 17:15:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5FB15C9D1;
        Thu, 17 Feb 2022 14:15:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 956FAB82486;
        Thu, 17 Feb 2022 22:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494A4C340F4;
        Thu, 17 Feb 2022 22:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645136140;
        bh=GBYoaw2tBZF8CRFTfO1PblUnjWOKK0INv/L0daco7Q4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GCiUxJ9c8Wj0PF4S/1pn4vCCO5IpEUUpZ5yQRS0qeG8aJofb3lgmgi6LaJkDGVBem
         c6k9LuLVwt290S/fcIAUYojpfKa/RXb4J7Jz/FioMWubUyWXVz1EUxwCReqyldBfEZ
         WN/dYefOiyS7eNLEQfkjZeEK+J8BAHNVrvLM/Q5j184kTy0GmDW8aYTv+hVBPQJer0
         +cstJHE1nqS2Zm1IZzX37PCKHJfutNHR9uCk1F130WSOi419Nb+pUss5wiSBvrMQh+
         05hk9695uiyQO1pjK0b7c/omkMCTZQrJqLnl+bp9AxbscfmHWdtUroJVW+U0MUNT1f
         ZWqae8vDzEGEg==
Received: by mail-ed1-f41.google.com with SMTP id m3so6179598eda.10;
        Thu, 17 Feb 2022 14:15:40 -0800 (PST)
X-Gm-Message-State: AOAM532KxuBbMZw9KUtGuVk3Jfta94ZqAjVjDIWYtd1ngFgs7G/26bN3
        CNaGsitjCdx46QUy2riHazj0IJwz/48wDnUZnw==
X-Google-Smtp-Source: ABdhPJz4v7ODE+oQTt4ltcW1M3PvqSbwA+PBE65RFbf5/OGc1Fx/Ze9Ka2RMfFebYqBY2iVhF7SeRkkiWeWCda/0hgI=
X-Received: by 2002:a50:f144:0:b0:40f:29ce:c68e with SMTP id
 z4-20020a50f144000000b0040f29cec68emr4988846edl.307.1645136138489; Thu, 17
 Feb 2022 14:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20220214082144.1176084-2-ben.dooks@codethink.co.uk> <20220214160556.GA9253@bhelgaas>
In-Reply-To: <20220214160556.GA9253@bhelgaas>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Feb 2022 16:15:26 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+hrQG5YwPBTOg-nt2pJ-ZgsEcSqL+BYaeVaj19ckJEhQ@mail.gmail.com>
Message-ID: <CAL_Jsq+hrQG5YwPBTOg-nt2pJ-ZgsEcSqL+BYaeVaj19ckJEhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: fu740: fix finding GPIOs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bhelgaas@google.comv, PCI <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        david.abdurachmanov@gmail.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 10:05 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rob for possible DT/kernel match issue,
> Lorenzo (native host bridge driver maintainer)]
>
> s/fix finding/Fix finding/ (in subject)
> Or even better, say something specific about the DT properties in
> question, e.g., look for "reset" instead of "reset-gpios".

This is purely a kernel issue. The gpio API appends '-gpios' (and a
fallback to '-gpio') to the name passed. So passing 'reset-gpios'
looks for 'reset-gpios-gpios' property. This happens enough, there
should probably be a check for this mistake.

>
> On Mon, Feb 14, 2022 at 08:21:43AM +0000, Ben Dooks wrote:
> > The calls to devm_gpiod_get_optional() have the -gpios at the end of
> > the name. This means the pcie driver is not finding the necessary
> > reset or power GPOOs to allow the PCIe devices on the SiFive Unmatched
> > boards.
>
> s/pcie/PCIe/
> s/GPOOs/GPIOs/
> "to allow the PCIe devices ...?"  Something is missing from this
> sentence.  "To allow the devices <to do what>"?  Or maybe the driver
> needs these GPIOs to power up the PCIe devices?
>
> I guess the implication is that the code looks for "reset-gpios" and
> "pwren-gpios", but the DT contains "reset" and "pwren"?
>
> But both Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> and arch/riscv/boot/dts/sifive/fu740-c000.dtsi actually do contain
> "reset-gpios" and "pwren-gpios".
>
> If we *do* want to change the code, please change the error messages
> to match.
>
> > This has not been a noted bug as the PCIe probe from u-boot has been
> > required to get the PCIe working due to other issues with the system
> > setup. It could have been broken since the driver inclusion, and not
> > been noticed as it is not necessary for the driver to funciton.
>
> s/u-boot/U-Boot/
> s/funciton/function/
>
> Please add a line about what the connection between U-Boot and this
> issue is, e.g., maybe U-Boot powers up the devices, so we wouldn't
> notice the kernel's inability to do so?
>
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> >  drivers/pci/controller/dwc/pcie-fu740.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> > index 00cde9a248b5..842b7202b96e 100644
> > --- a/drivers/pci/controller/dwc/pcie-fu740.c
> > +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> > @@ -259,11 +259,11 @@ static int fu740_pcie_probe(struct platform_device *pdev)
> >               return PTR_ERR(afp->mgmt_base);
> >
> >       /* Fetch GPIOs */
> > -     afp->reset = devm_gpiod_get_optional(dev, "reset-gpios", GPIOD_OUT_LOW);
> > +     afp->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> >       if (IS_ERR(afp->reset))
> >               return dev_err_probe(dev, PTR_ERR(afp->reset), "unable to get reset-gpios\n");
> >
> > -     afp->pwren = devm_gpiod_get_optional(dev, "pwren-gpios", GPIOD_OUT_LOW);
> > +     afp->pwren = devm_gpiod_get_optional(dev, "pwren", GPIOD_OUT_LOW);
> >       if (IS_ERR(afp->pwren))
> >               return dev_err_probe(dev, PTR_ERR(afp->pwren), "unable to get pwren-gpios\n");
> >
> > --
> > 2.34.1
> >
