Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75B3459593
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 20:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbhKVT3x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 14:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhKVT3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 14:29:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D4C061574;
        Mon, 22 Nov 2021 11:26:43 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o20so37189380eds.10;
        Mon, 22 Nov 2021 11:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymj4co489Rh/QCrinXJNrU79PFGVqKojC60tGmzG1/w=;
        b=IDJW8OefpBYIk2LKJQ2A1Tdbcj+NLi8ERV/SYw0ksHLT60l3f66/rXeQSLuVPLUpe9
         TLtptZJoj7p6c3yeSprssQkA99HQM4ms5l0eyzymOtrYfARR2PKb0z0uiEHmjSryYY80
         +WT+W4TTDydtAYzj66qxCCy8B1QDhkCmQsgSfxKeou62H+ghxEFal/MhDA+6Nc2FWoKo
         +pAalMdWbUm+ErTRFUAXz6DIG75HgRveBxyiIDFQdNZ1Y0Jf0FXSztqyJSxrxW0iowmm
         0wXvfuOHWS16dU4CeInT6KkMj2iZCdcln9NP9gLL08SKJMq5fLnFug3J1O4jS8Q35fys
         jCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymj4co489Rh/QCrinXJNrU79PFGVqKojC60tGmzG1/w=;
        b=g16D7MNHMBHmoRy8Mvy7kwKP4+IEf9B+djU6BKrGYZXpvt4wfXHLDWzzbPC7etvUa0
         7uOI4MWfnp9rc1vRikLRrCIJWNKgFwoU9CcLFWZ80BRb+aQIZZg02+oPA79+5yna7qLW
         E4l0BxcHLGspJ2QTjlrSS3m7KPnoqaLp5aLVeJd868nbhtRSKN9FEArWgVgIUnZjVpBf
         S5o8ZV9oyv/5JXcSWfA7Ob5FMeLAEvCLTJXnOOov84NhNIek32Jbg5KOMlgYWNNmNCVg
         KckhhNm67neawAzD/6tn4ouSv14E02XfrImwu/MqIRgmf7kGD2/AlKa6JTvVro808G5n
         0Raw==
X-Gm-Message-State: AOAM533d7wzo7CSNWz6E0DsO92lRihnMjuaiP7PVzZ7gP+zhJa9Z2SfG
        l0tQNLBqxtS9peyzlX8zP4pGMTOEe5Cdw6F3kaY=
X-Google-Smtp-Source: ABdhPJyRs8GJwo6CRgnVqMRPcHzlmz9tZwd/ldTsRkCTlDuhqNPK9kIm2X8bgFrwMUOhVjKuFGRN59x0Vd4dAUBHmQY=
X-Received: by 2002:a05:6402:26d4:: with SMTP id x20mr67852808edd.119.1637609201507;
 Mon, 22 Nov 2021 11:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20211122190459.3189616-1-f.fainelli@gmail.com>
In-Reply-To: <20211122190459.3189616-1-f.fainelli@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Nov 2021 21:26:04 +0200
Message-ID: <CAHp75VeFZH9364CK8Z5_uMk2WoqkJB-SWdmKodqAML59i7ckfw@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Do not use __GENMASK
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "maintainer:BROADCOM STB PCIE DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM STB PCIE DRIVER" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 22, 2021 at 9:07 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Define the legacy MSI intterupt bitmask as well as the non-legacy

interrupt

> interrupt bitmask using GENMASK and then use them in brcm_msi_set_regs()
> in place of __GENMASK().

LGTM, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 1fc7bd49a7ad..3391b4135b65 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -144,6 +144,9 @@
>  #define BRCM_INT_PCI_MSI_NR            32
>  #define BRCM_INT_PCI_MSI_LEGACY_NR     8
>  #define BRCM_INT_PCI_MSI_SHIFT         0
> +#define BRCM_INT_PCI_MSI_MASK          GENMASK(BRCM_INT_PCI_MSI_NR - 1, 0)
> +#define BRCM_INT_PCI_MSI_LEGACY_MASK   GENMASK(31, \
> +                                               32 - BRCM_INT_PCI_MSI_LEGACY_NR)
>
>  /* MSI target addresses */
>  #define BRCM_MSI_TARGET_ADDR_LT_4GB    0x0fffffffcULL
> @@ -619,7 +622,8 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
>
>  static void brcm_msi_set_regs(struct brcm_msi *msi)
>  {
> -       u32 val = __GENMASK(31, msi->legacy_shift);
> +       u32 val = msi->legacy ? BRCM_INT_PCI_MSI_LEGACY_MASK :
> +                               BRCM_INT_PCI_MSI_MASK;
>
>         writel(val, msi->intr_base + MSI_INT_MASK_CLR);
>         writel(val, msi->intr_base + MSI_INT_CLR);
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
