Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983FD5FA697
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 22:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJJUxr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJJUxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 16:53:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858AD6DFB0;
        Mon, 10 Oct 2022 13:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B3460FEC;
        Mon, 10 Oct 2022 20:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355FFC433C1;
        Mon, 10 Oct 2022 20:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435224;
        bh=U40ZhDhgjkMFAWq1C9vPEDnFwF9FZwsPexHHtIbXFpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iKiKKaxAdd4bvCbm41s8jnud/2PY6mm5xJhX+z4EYJVi2UZpUhLGwAPgurbQZQRQM
         u+iPJhMwmmcRwbgW+AOUVJ5H4zkBJt1FsdZ/L0oxaIjx/wpO1V5zRNrrrh1OLnAgxH
         4KC+dsWCYaYSebuwazSXvpS/Z7HZ5Vxhbux76DlqBtOFY8TH059H8cxq8NK7G42mZV
         TTldCf2tbA8iwxpEGYpKx8uGdbGO/xQViiR8J0e0xq3XZFvWUyqBaCP3NeKIBBtYS4
         TDH0unsxLwzYo9p1HPvn07xknu1YqjiL3FjGigEq2S3ZxqFE7euxr4wgmPLFaHbgro
         wZzDPfxBWqP5w==
Date:   Mon, 10 Oct 2022 15:53:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH] PCI: mediatek-gen3: change driver name to mtk-pcie-gen3
Message-ID: <20221010205342.GA2935945@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008164211.112944-1-linux@fw-web.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 08, 2022 at 06:42:11PM +0200, Frank Wunderlich wrote:
> From: Felix Fietkau <nbd@nbd.name>
> 
> This allows it to coexist with the other mtk pcie driver in the same
> kernel.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Looks like Lorenzo already applied this:

https://lore.kernel.org/all/166125958529.60702.17839683437013330997.b4-ty@kernel.org/#t

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 11cdb9b6f109..b8612ce5f4d0 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1071,7 +1071,7 @@ static struct platform_driver mtk_pcie_driver = {
>  	.probe = mtk_pcie_probe,
>  	.remove = mtk_pcie_remove,
>  	.driver = {
> -		.name = "mtk-pcie",
> +		.name = "mtk-pcie-gen3",
>  		.of_match_table = mtk_pcie_of_match,
>  		.pm = &mtk_pcie_pm_ops,
>  	},
> -- 
> 2.34.1
> 
