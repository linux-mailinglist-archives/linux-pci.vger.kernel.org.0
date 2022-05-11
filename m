Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72079523566
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 16:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244625AbiEKO0s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244662AbiEKO0f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 10:26:35 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5515C63BE7;
        Wed, 11 May 2022 07:26:34 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2f863469afbso23478887b3.0;
        Wed, 11 May 2022 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+G+1F2bko9t4hU/+1Xb4IfFtS046K7mBmLmG7KLIwI=;
        b=RyJjpnDleChRSXg2AZ14MuEalc0yTz97bE/R5PqLRSFtSJlQiCuRc5sJv2+aflzUqN
         JUNrGKjMy25ntO47VJbYHeq/coAI00K5tvvceNU0HXlQAPA02Rlma4gkRHaCe5yFoi7g
         eXgbWjX/Kpi7WBtlcjMAxMA/MEFNEu7nikdph+iO0W0vFPR18epG7CwmbVm2Wl2gdZ2z
         //fvmDc4tgkMrFy6qugrHqHTECqR2GRJYVRsWu8uD9xRdfegqzvOfxux1TZxIMpeOPz8
         NQLVC1bP2a5El5ecbg3WbvACHAuMvTHk/6bzN8ylRZiWYo2+tCcIRUPx56gSPwuF0Auj
         LBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+G+1F2bko9t4hU/+1Xb4IfFtS046K7mBmLmG7KLIwI=;
        b=m5dtSRUP9m879eC+KOeQPWj5PLBOwvHMNUyYM+DVdqmpi3G3aT4foAHeGn5JR9puSV
         YNaOu5C9U45CRiJgo37S+EWYbb4XjGggjQbjg4J/XZEETxp7WpN+YFbVu/BaGW/fCtmb
         PXyJKuJMzDpONpu2C2xR3vIDSVYO8+uIQba0q9Ldm/rtqvl19I03iThWZA2xrGFGakX9
         nTTQvyKShbv4mIycgx1Zec0RUAFAm4r9YTavWjMilarRvuVjrR5g3BZ4IkzMHRR15YP6
         3tu0kIaszppMJKWANA3dvB87g9rhYXCOoTKZitFmUkVJ1cngC7A+unXEX9p3KrMuVPBU
         K/tw==
X-Gm-Message-State: AOAM533ksVuWx6ZeMjvrs7twXWU94VTi8HCXYwqoOqy7oFUPA6WZORSK
        8EOarNylUh6mhMBk3zgLC+7c9wsfoO3wQxcyul4=
X-Google-Smtp-Source: ABdhPJybwJw6ZZcx4u2vxPwqvJS4odhX0N1WECLM3hHbUER7xDfWeRgnIfz2/m7ulVYUFAsckCvGL1v0zfwnuDHF/7o=
X-Received: by 2002:a81:32c1:0:b0:2f7:cda8:50e1 with SMTP id
 y184-20020a8132c1000000b002f7cda850e1mr25481799ywy.519.1652279193361; Wed, 11
 May 2022 07:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220429123832.2376381-1-pgwipeout@gmail.com> <20220429123832.2376381-3-pgwipeout@gmail.com>
 <Ynu/D4hXTRVy9IBF@lpieralisi>
In-Reply-To: <Ynu/D4hXTRVy9IBF@lpieralisi>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 11 May 2022 10:26:20 -0400
Message-ID: <CAMdYzYqdDPUFPhAZqA71dLaf6rT9CwFqQ1dFMRbGpVMyzgT8bg@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] PCI: rockchip-dwc: Reset core at driver probe
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 9:50 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Apr 29, 2022 at 08:38:28AM -0400, Peter Geis wrote:
> > The PCIe controller is in an unknown state at driver probe. This can
> > lead to undesireable effects when the driver attempts to configure the
> > controller.
> >
> > Prevent issues in the future by resetting the core during probe.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 ++++++++-----------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
>
> I fear that the controller reset behaviour is bootloader/firmware
> dependent.
>
> Are we sure we are not triggering any regressions by resetting the
> controller in the middle of probe (aka is the driver implicitly
> relying on existing behaviour on systems that are not the ones
> you are testing on) ?
>
> Just asking, the rockchip maintainers should be able to answer this
> question.

This is a new driver with no current users, this series enables the
first user. It does not support ACPI nor any sort of handoff at this
time.

>
> Thanks,
> Lorenzo
>
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index c9b341e55cbb..faedbd6ebc20 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -152,6 +152,11 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
> >       if (IS_ERR(rockchip->rst_gpio))
> >               return PTR_ERR(rockchip->rst_gpio);
> >
> > +     rockchip->rst = devm_reset_control_array_get_exclusive(&pdev->dev);
> > +     if (IS_ERR(rockchip->rst))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
> > +                                  "failed to get reset lines\n");
> > +
> >       return 0;
> >  }
> >
> > @@ -182,18 +187,6 @@ static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
> >       phy_power_off(rockchip->phy);
> >  }
> >
> > -static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
> > -{
> > -     struct device *dev = rockchip->pci.dev;
> > -
> > -     rockchip->rst = devm_reset_control_array_get_exclusive(dev);
> > -     if (IS_ERR(rockchip->rst))
> > -             return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> > -                                  "failed to get reset lines\n");
> > -
> > -     return reset_control_deassert(rockchip->rst);
> > -}
> > -
> >  static const struct dw_pcie_ops dw_pcie_ops = {
> >       .link_up = rockchip_pcie_link_up,
> >       .start_link = rockchip_pcie_start_link,
> > @@ -222,6 +215,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >       if (ret)
> >               return ret;
> >
> > +     ret = reset_control_assert(rockchip->rst);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* DON'T MOVE ME: must be enable before PHY init */
> >       rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> >       if (IS_ERR(rockchip->vpcie3v3)) {
> > @@ -241,7 +238,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >       if (ret)
> >               goto disable_regulator;
> >
> > -     ret = rockchip_pcie_reset_control_release(rockchip);
> > +     ret = reset_control_deassert(rockchip->rst);
> >       if (ret)
> >               goto deinit_phy;
> >
> > --
> > 2.25.1
> >
