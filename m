Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E724A9FCD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 20:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiBDTM4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 14:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiBDTM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 14:12:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C451C061714;
        Fri,  4 Feb 2022 11:12:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so8296361pjy.1;
        Fri, 04 Feb 2022 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+2vQhaK54H9Hdp01q4kx6TzLMZbpfp4A4zBHmmTnPc=;
        b=kC+yjJYVoYE0SMFrNpOfqbJLywLEVTVjVFXJH5t/nVKAI4qoNmGB2tNJhLvh0K6ZMo
         fZM5nF2Sif+TYJOWv81vRU/v5r5Zdov66tmOZFfmWHJcFw6EKU6UGC9CvV1rJiM/Ph0T
         xxD++0G7RFrHIAcOJrQLb+8i13VDY+jK4NyruwM5ev0Q8d5/oUcS2hKsMgg3LlCxilIi
         OBC7yFC/tXYAEzOYohoifQ5tOVYA+r6Yc9onVPqb/VJJAisIty14jtME3e7WvwqAS2g8
         RbpZl5Mg5xEoOHbnsXF7KddBAvz1eBSy8OYY7+UX0eVtRgLmcuR1XEWh2BX4tB7t7L4z
         gX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+2vQhaK54H9Hdp01q4kx6TzLMZbpfp4A4zBHmmTnPc=;
        b=ObqXIoy5FfdaHMGASSLaLL/MzqN6CvfMjrFaYzPrX8eNSuyJ5oTaSK+j+G1te04y3Q
         t1jVPL0BBo06TujPbRKjoH3T+u4ORD+0/eGs5zUMAM+nrgnYmb796U8qrgjmPMmnFG8e
         5/3uItJWRk+hwvkTVOoBtXmTu5lAcJcc4Zad32kR6aNWhyYm2ePknhwDQgY9HZtc19bf
         iDVXGnQVlRNEYbzYWdeypg+K1ptJHtTCU8g3SE2cl5YzcGt2rZkTjQkcKEWcrmJ+FIVF
         5gSQL2H15SwAVuALXUHCk1vbwWDA3BDZqmzmJZjjMJNCye5pQ0t1yBAAc5mgdA3pG1Zk
         Goyw==
X-Gm-Message-State: AOAM5315tU1v5yVwFJsANPrGvHdx3mApKWcOJI26AS+C6P6etlGZHD79
        LCSei8zZftG11El3MllqkLqZ2OLX91htwllgGpM=
X-Google-Smtp-Source: ABdhPJyPI8usXYMumMnrEQ3nLDq5zjec+fco1omgVZwxBeH6nOTi/fUN2f8Dc8+wqicpUpw+xbOinGtCvbA54nwhPh0=
X-Received: by 2002:a17:90a:df0e:: with SMTP id gp14mr436884pjb.57.1644001975488;
 Fri, 04 Feb 2022 11:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20220204183316.328937-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20220204183316.328937-1-ben.dooks@codethink.co.uk>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Fri, 4 Feb 2022 21:12:19 +0200
Message-ID: <CAEn-LTo96qGWyq7Zp9=VUaJh_kAW2JA7hRKwVzrSyz=xwDT=rg@mail.gmail.com>
Subject: Re: [PATCH] PCI: fu740: RFC: force gen1 and get devices probing
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>, macro@orcam.me.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 4, 2022 at 8:35 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> The dw pcie core does not probe devices unless this fix
> from u-boot is applied. The link must be changed to gen1
> and then the system will see all the other pcie devices
> behind the unmatched board's bridge.
>
> This is a quick PoC to try and get our test farm working
> when a system does not have the pcie initialised by a
> u-boot script.
>
> I will look at a proper patch when I am back in the office

Hi,

Have you looked into the patches posted for Linux and U-Boot from
Maciej W. Rozycki?

On the Linux side (not reviewed yet):
[PATCH v3] pci: Work around ASMedia ASM2824 PCIe link training failures
https://www.spinics.net/lists/linux-pci/msg120112.html

The U-Boot fix was merged a few days ago.

david

> ---
>  drivers/pci/controller/dwc/pcie-fu740.c | 37 +++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> index 960e58ead5f2..44f792764e45 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -181,11 +181,48 @@ static void fu740_pcie_init_phy(struct fu740_pcie *afp)
>         fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE3_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
>  }
>
> +/* u-boot forces system to gen1 otherwise nothing probes... */
> +static void pcie_sifive_force_gen1(struct dw_pcie *dw, struct fu740_pcie *afp )
> +{
> +       unsigned val;
> +
> +#if 0
> +       /* u-boot code */
> +        /* ctrl_ro_wr_enable */
> +        val = readl(sv->dw.dbi_base + PCIE_MISC_CONTROL_1);
> +        val |= DBI_RO_WR_EN;
> +        writel(val, sv->dw.dbi_base + PCIE_MISC_CONTROL_1);
> +
> +        /* configure link cap */
> +        linkcap = readl(sv->dw.dbi_base + PF0_PCIE_CAP_LINK_CAP);
> +        linkcap |= PCIE_LINK_CAP_MAX_SPEED_MASK;
> +        writel(linkcap, sv->dw.dbi_base + PF0_PCIE_CAP_LINK_CAP);
> +
> +        /* ctrl_ro_wr_disable */
> +        val &= ~DBI_RO_WR_EN;
> +        writel(val, sv->dw.dbi_base + PCIE_MISC_CONTROL_1);
> +#endif
> +
> +       val = readl_relaxed(dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
> +       val |= PCIE_DBI_RO_WR_EN;
> +       writel_relaxed(val, dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
> +
> +       val = readl(dw->dbi_base + 0x70 + 0x0c);
> +       val |= 0xf;
> +       writel(val, dw->dbi_base + 0x70 + 0x0c);
> +
> +       val = readl_relaxed(dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
> +       val &= ~PCIE_DBI_RO_WR_EN;
> +       writel_relaxed(val, dw->dbi_base +  PCIE_MISC_CONTROL_1_OFF);
> +}
> +
>  static int fu740_pcie_start_link(struct dw_pcie *pci)
>  {
>         struct device *dev = pci->dev;
>         struct fu740_pcie *afp = dev_get_drvdata(dev);
>
> +       pcie_sifive_force_gen1(pci, afp);
> +
>         /* Enable LTSSM */
>         writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
>         return 0;
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
