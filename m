Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34FC29958D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 19:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790185AbgJZSl5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 14:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785156AbgJZSl5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 14:41:57 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9762222C;
        Mon, 26 Oct 2020 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603737716;
        bh=ZHnDVzqCmHdL0T1F4BO4Y47EykJ5PDqzneLTnwI6ZRA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KdhX4ntAZx6gfgYbRCwmS5ZXbSIhAStlI4WxQZxVot2A6EgEa6Ne+sSA1Jra+zi1C
         f/EHeO6pkRwGxtqsXP9yTgRA6dUyW+E5MXoSJPn2h0UOmqWCQD/Bako7xNmpTSJwo/
         L43WN4dpKVOSrCCK72KNcygSYxZkExCxtE2dTy54=
Received: by mail-ot1-f49.google.com with SMTP id k3so8355984otp.1;
        Mon, 26 Oct 2020 11:41:56 -0700 (PDT)
X-Gm-Message-State: AOAM531mtYIMj6PqohlQ5PeVx6q8wObdlwF7gR3GzcGsk3Lf1DKPEj+B
        GRbxUHDVawr9IunB16pxd1z9Vn9EIVm11rajIQ==
X-Google-Smtp-Source: ABdhPJyVlgX3wTNwjznavSrjvPKZgPsLOcYRv5S/5h+cGUJY0F3WJM+ZuvefjhUv5JIG7coKD86JdQgouxe51pp7RDU=
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr15737889otk.192.1603737715454;
 Mon, 26 Oct 2020 11:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201026065459.28509-1-vidyas@nvidia.com> <20201026065459.28509-3-vidyas@nvidia.com>
In-Reply-To: <20201026065459.28509-3-vidyas@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Oct 2020 13:41:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJdwF26_2Fpz5=jGeLCGkySpdC0ZCJGaMvHFoGwJ898aQ@mail.gmail.com>
Message-ID: <CAL_JsqJdwF26_2Fpz5=jGeLCGkySpdC0ZCJGaMvHFoGwJ898aQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: tegra: Map configuration space as strongly ordered
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, amanharitsh123@gmail.com,
        dinghao.liu@zju.edu.cn, Krzysztof Wilczynski <kw@linux.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 26, 2020 at 1:55 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> As specified in the comment for pci_remap_cfgspace() define in
> arch/arm64/include/asm/io.h file, PCIe configuration space should be
> mapped as strongly ordered. Hence changing to dev_pci_remap_cfgspace()

Strictly speaking, strongly ordered is ARMv6/7 terminology. For v8,
it's 'nGnRnE' which is what the comment says.

> from devm_ioremap_resource() for mapping DBI space as that is nothing
> but the root port's own configuration space.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index b172b1d49713..7a0c64436861 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2108,7 +2108,9 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>         }
>         pcie->dbi_res = dbi_res;
>
> -       pci->dbi_base = devm_ioremap_resource(dev, dbi_res);
> +       pci->dbi_base = devm_pci_remap_cfgspace(dev,
> +                                               dbi_res->start,
> +                                               resource_size(dbi_res));

This is all going to get removed anyways as I'm working on moving DBI
and other region setup into the DWC core. I guess better to do this
change first and make it explicit.

Rob
