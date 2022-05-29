Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4185371CC
	for <lists+linux-pci@lfdr.de>; Sun, 29 May 2022 18:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiE2Qw2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 May 2022 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2Qw1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 May 2022 12:52:27 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977506128D;
        Sun, 29 May 2022 09:52:26 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f314077115so4351396fac.1;
        Sun, 29 May 2022 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcZ1DaHw5AgDwn1rt/1/DpSSQI/ATbdMoEOFrgRgoaU=;
        b=j8lpnedgMvxQJPzPVvk5GPf7XdZKuiL5ICo4yMUHb0g37ee0X9cLzTAa50b4eMyfZ/
         7aPe4TsSZTebdbDdcGmVdR88wO1xlEl+rl3y5EXUPWRQq/yqGpWVxlcfFX/+DmyP9CZI
         QWeXK4e9f2mdgRLI8PqLmzT4si5+O2LhfL+kLQyH5WbC+Yt9purRJPWzxR4bahUGdGw2
         o/n8u5MZlcbKd/d1Fnd3Az9+2FoZrqqhGDgV4EUp+e4th2cvuMsHFiPkeF6oRNgFzmQ3
         fCzgEmtRZ48f3VGWsYCLZOSgMja8+6XXerLPmmugRD01TUQxCYECUbAVJhN7rhIuC6aN
         ymwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcZ1DaHw5AgDwn1rt/1/DpSSQI/ATbdMoEOFrgRgoaU=;
        b=ZuJFUjGjBw4e+xiWYIqzk0TGjX+RS6UrIkhO+v//epaSDxjUT+rfsaaVEc6qjQFy3k
         k+f6v0e1o688ag9R50OTaN7dEUf3BqJQh2SUcsxYpNeWLQw7WVgQ963jtYFds8wSgaKD
         8L/+f48evVdyWv8NxumioJB0nvzssosXDw4Nb8HNgMEIoHA0k2BmnwJdXzuy0l9v6J+G
         HKqzpkp4I9MDGRMGslK/x1WeGH6TWhK9JgkDXzm/TttbFmMdlkGJcBQ8tWQ4b5FkV762
         6i4FHinkXjuktOBL93VbHr5CfhYGu25/i3UrrKFvp+OiqNxACVD26rBxG6J/yzv09XOZ
         c8Ug==
X-Gm-Message-State: AOAM533BdgwLpW/EVd4bbOQNvboP+zliCtOKA+MOJ8MmY2vvNxDMzukF
        QAEWZ5VYoW1WHR/M3NastRIymrZgphyWI2MRhts1CcyU6R4akw==
X-Google-Smtp-Source: ABdhPJxK3ApzYqMhWjZh7OLNc7qcqZFDnaW4m84M+3lVkYQ0E0h7XltyYoovkmKYronKjgiM4i3FZZiD9ydBLb3YWu4=
X-Received: by 2002:a05:6870:b3a4:b0:e9:2370:5e9 with SMTP id
 w36-20020a056870b3a400b000e9237005e9mr8465718oap.73.1653843145680; Sun, 29
 May 2022 09:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220528224423.7017-1-jim2101024@gmail.com> <20220528224423.7017-2-jim2101024@gmail.com>
In-Reply-To: <20220528224423.7017-2-jim2101024@gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Sun, 29 May 2022 12:52:14 -0400
Message-ID: <CANCKTBvyUOHJgh1=kFdyRFxWX5D4POnn0wmHYj-eNUQEP6esvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Fix regression regarding missing
 PCIe linkup
To:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 28, 2022 at 6:44 PM Jim Quinlan <jim2101024@gmail.com> wrote:
>
> commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
> root port DT node described in [2] was missing, no linkup would be attempted,
> and subsequent accesses would cause a panic because this particular PCIe HW
> causes a CPU abort on illegal accesses (instead of returning 0xffffffff).
>
> We fix this by allowing the DT root port node to be missing, as it behaved
> before the original patchset messed things up.
>
> In addition, two small changes are made:
>
>   1. Having pci_subdev_regulators_remove_bus() call
>      regulator_bulk_free() in addtion to regulator_bulk_disable().
>   2. Having brcm_pcie_add_bus() return 0 if there is an
>      error in calling pci_subdev_regulators_add_bus().
>      Instead, we dev_err() and turn on our refusal mode instead.
>
> It would be best if this commit were tested by someone with a Rpi CM4
> platform, as that is how the regression was found.  I have only emulated
> the problem and fix on different platform.
>
> Note that a bisection identified
>
> commit 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
>
> as the first failing commit.  This commit is a regression, but is unrelated
> and was fixed by a subsequent commit in the original patchset.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215925
> [2] Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>
> Fixes: 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> Fixes: 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
Thorston -- I forgot to replace the bugzilla link; I'll get it on V3.  -- Jim

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 43 +++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index ba5c120816b2..0839325f79ab 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -540,29 +540,42 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
>
>  static int brcm_pcie_add_bus(struct pci_bus *bus)
>  {
> -       struct device *dev = &bus->dev;
> -       struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
> +       struct brcm_pcie *pcie;
>         int ret;
>
> -       if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
> +       /*
> +        * Right now we only alloc/enable regulators and initiate pcie link
> +        * when under the root port bus of the current domain.  In the
> +        * future we may want to alloc/enable regulators under any port
> +        * device (e.g. a switch).
> +        */
> +       if (!bus->parent || !pci_is_root_bus(bus->parent))
>                 return 0;
>
>         ret = pci_subdev_regulators_add_bus(bus);
> -       if (ret)
> -               return ret;
> +       if (ret) {
> +               dev_err(pcie->dev, "failed to alloc/enable regulators\n");
> +               goto err;
> +       }
>
> -       /* Grab the regulators for suspend/resume */
> +       /* Save the regulators for RC suspend/resume */
> +       pcie = (struct brcm_pcie *) bus->sysdata;
>         pcie->sr = bus->dev.driver_data;
>
> +       /* Attempt PCIe link-up */
> +       if (brcm_pcie_linkup(pcie) == 0)
> +               return 0;
> +err:
>         /*
> -        * If we have failed linkup there is no point to return an error as
> -        * currently it will cause a WARNING() from pci_alloc_child_bus().
> -        * We return 0 and turn on the "refusal_mode" so that any further
> -        * accesses to the pci_dev just get 0xffffffff
> +        * If we have failed linkup or have an error when turning on
> +        * regulators, there is no point to return an error value to the
> +        * caller (pci_alloc_child_bus()) as it will summarily execute a
> +        * WARNING().  Instead, we turn on our "refusal_mode" and return 0
> +        * so that any further PCIe accesses succeed but do nothing (reads
> +        * return 0xffffffff).  If we do not turn on refusal mode, our
> +        * unforgiving PCIe HW will signal a CPU abort.
>          */
> -       if (brcm_pcie_linkup(pcie) != 0)
> -               pcie->refusal_mode = true;
> -
> +       pcie->refusal_mode = true;
>         return 0;
>  }
>
> @@ -570,13 +583,17 @@ static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
>  {
>         struct device *dev = &bus->dev;
>         struct subdev_regulators *sr = dev->driver_data;
> +       struct brcm_pcie *pcie;
>
>         if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
>                 return;
>
>         if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
>                 dev_err(dev, "failed to disable regulators for downstream device\n");
> +       regulator_bulk_free(sr->num_supplies, sr->supplies);
>         dev->driver_data = NULL;
> +       pcie = (struct brcm_pcie *) bus->sysdata;
> +       pcie->sr = NULL;
>  }
>
>  /* Limits operation to a specific generation (1, 2, or 3) */
> --
> 2.17.1
>
