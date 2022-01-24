Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63424498378
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 16:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiAXPYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 10:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiAXPYd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 10:24:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B57BC06173B;
        Mon, 24 Jan 2022 07:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C13E661480;
        Mon, 24 Jan 2022 15:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D7C340EA;
        Mon, 24 Jan 2022 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643037872;
        bh=4FOVymSBLDFQAUqFaQOAK2kBFZDCor01RaScWJF5qNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cODq/k6VDP7ljKDn3MJp5FNFm2MCyfsMLDmIYM4AvqFATOV5PODAGp2436Yv/N2pI
         VmPtSU6yY8SJwkAjgYITv/xFu0axoW27LNO7eYmgtUQ58kO0naeZXAkOt1CIToWDzC
         vhRTc+V5/C+etRsCqKZyGllGiIkuZJVfPi0K+Fo+TReFvppIyvAoXUJezVuSj10O+S
         SUEbuJLWpaYEkCTBTuBbQNADww5ksf+0S1EVuwFlk116eidg1kEH8wd7kXpz3MZaQK
         NDHT/BuVITqGNjn9mMHSOoHumwY9hrSXccr9piaFF2XnbPWsOq9IyEJS+DivWh5O/G
         VS+Dg4FZZZGxw==
Received: by mail-ej1-f45.google.com with SMTP id d10so22361158eje.10;
        Mon, 24 Jan 2022 07:24:32 -0800 (PST)
X-Gm-Message-State: AOAM530//oSfKC+fwdMJcIw8Kxwsfxw/4zPg3bhqCmZs4rv5+LaYKS3V
        BQaiBGXpQ+TMiT4jyW+iSQTh4MxD048YWDcGog==
X-Google-Smtp-Source: ABdhPJypLe3fQux9GhZfMQpZMZZVEASZHTXgPIIufJUZqKUSy3aayx1eCyItPpD7FF+WT3SVbvaFncSGiQsKqKP/auM=
X-Received: by 2002:a17:906:1dc3:: with SMTP id v3mr12891842ejh.264.1643037870455;
 Mon, 24 Jan 2022 07:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20220124122132.435743-1-christian.gmeiner@gmail.com>
In-Reply-To: <20220124122132.435743-1-christian.gmeiner@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 24 Jan 2022 09:24:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLwFvLJg+LCgANU6Mdx_=RkkLWPk+8nxsTNxb_sLi+nwQ@mail.gmail.com>
Message-ID: <CAL_JsqLwFvLJg+LCgANU6Mdx_=RkkLWPk+8nxsTNxb_sLi+nwQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "PCI: j721e: Drop redundant struct device *"
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 24, 2022 at 6:21 AM Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
>
> This reverts commit 19e863828acf6d8ac8475ba1fd93c0fe17fdc4ef.
>
> Fixes the following oops:

Perhaps explain why the 2nd struct device was not redundant. Is this
not just a case of the dev pointer not getting set early enough?

>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
>  Internal error: Oops: 96000004 [#1] PREEMPT SMP
>  Modules linked in:
>  CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.17.0-rc1-00086-ge38b27816fea-dirty #71
>  Hardware name: CPE0108 (DT)
>  Workqueue: events_unbound deferred_probe_work_func
>  pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : j721e_pcie_probe+0x184/0x600
>  lr : j721e_pcie_probe+0x170/0x600
>  sp : ffff80000957bae0
>  x29: ffff80000957bae0 x28: ffff800009357000 x27: ffff00000000c078
>  x26: ffff00003fe047a8 x25: 0000000000000000 x24: ffff0000000f5280
>  x23: ffff800008c98f78 x22: ffff800008f90ff0 x21: ffff000000231410
>  x20: ffff000002ef2780 x19: 0000000000000021 x18: 0000000000000001
>  x17: 0000000000000000 x16: 0000000000058c00 x15: ffffffffffffffff
>  x14: ffffffffffffffff x13: 0000000000000010 x12: 0101010101010101
>  x11: 0000000000000040 x10: ffff8000093e06c8 x9 : ffff8000093e06c0
>  x8 : ffff000000400270 x7 : 0000000000000000 x6 : ffff000000231590
>  x5 : ffff80000957b9e0 x4 : 0000000000000000 x3 : ffff0000002314f4
>  x2 : 0000000000000000 x1 : ffff0000000f5280 x0 : 0000000000000000
>  Call trace:
>   j721e_pcie_probe+0x184/0x600
>   platform_probe+0x68/0xe0
>   really_probe+0x144/0x320
>   __driver_probe_device+0xc4/0xe0
>   driver_probe_device+0x7c/0x110
>   __device_attach_driver+0x90/0xe0
>   bus_for_each_drv+0x78/0xd0
>   __device_attach+0xf0/0x150
>   device_initial_probe+0x14/0x20
>   bus_probe_device+0x9c/0xb0
>   deferred_probe_work_func+0x88/0xc0
>   process_one_work+0x1bc/0x340
>   worker_thread+0x1f8/0x420
>   kthread+0x110/0x120
>   ret_from_fork+0x10/0x20
>  Code: f9400280 a90573fb d0005396 913fc2d6 (f9400800)
>
> Fixes: 19e863828acf ("PCI: j721e: Drop redundant struct device *")
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 489586a4cdc7..cd43d1898482 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -51,10 +51,11 @@ enum link_status {
>  #define MAX_LANES                      2
>
>  struct j721e_pcie {
> -       struct cdns_pcie        *cdns_pcie;
> +       struct device           *dev;
>         struct clk              *refclk;
>         u32                     mode;
>         u32                     num_lanes;
> +       struct cdns_pcie        *cdns_pcie;
>         void __iomem            *user_cfg_base;
>         void __iomem            *intd_cfg_base;
>         u32                     linkdown_irq_regfield;
> @@ -98,7 +99,7 @@ static inline void j721e_pcie_intd_writel(struct j721e_pcie *pcie, u32 offset,
>  static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
>  {
>         struct j721e_pcie *pcie = priv;
> -       struct device *dev = pcie->cdns_pcie->dev;
> +       struct device *dev = pcie->dev;
>         u32 reg;
>
>         reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
> @@ -164,7 +165,7 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
>  static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
>                                unsigned int offset)
>  {
> -       struct device *dev = pcie->cdns_pcie->dev;
> +       struct device *dev = pcie->dev;
>         u32 mask = J721E_MODE_RC;
>         u32 mode = pcie->mode;
>         u32 val = 0;
> @@ -183,7 +184,7 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
>  static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
>                                      struct regmap *syscon, unsigned int offset)
>  {
> -       struct device *dev = pcie->cdns_pcie->dev;
> +       struct device *dev = pcie->dev;
>         struct device_node *np = dev->of_node;
>         int link_speed;
>         u32 val = 0;
> @@ -204,7 +205,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
>  static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
>                                      struct regmap *syscon, unsigned int offset)
>  {
> -       struct device *dev = pcie->cdns_pcie->dev;
> +       struct device *dev = pcie->dev;
>         u32 lanes = pcie->num_lanes;
>         u32 val = 0;
>         int ret;
> @@ -219,7 +220,7 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
>
>  static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
>  {
> -       struct device *dev = pcie->cdns_pcie->dev;
> +       struct device *dev = pcie->dev;
>         struct device_node *node = dev->of_node;
>         struct of_phandle_args args;
>         unsigned int offset = 0;
> @@ -376,6 +377,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>         if (!pcie)
>                 return -ENOMEM;
>
> +       pcie->dev = dev;
>         pcie->mode = mode;
>         pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
>
> --
> 2.34.1
>
