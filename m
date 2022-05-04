Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05A151AB1B
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 19:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358862AbiEDRml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358558AbiEDRlb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 13:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F094704B;
        Wed,  4 May 2022 10:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F3D9619C0;
        Wed,  4 May 2022 17:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52846C385A4;
        Wed,  4 May 2022 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651684020;
        bh=GLYjDWr+192rxC48wQ8VgGspiNE5r/eo1X3Mg9YC2x8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H8Hoc5qYMvP4u27oz6zF7hCsz/eCyjoMiZuqzCfI6Tpar5ffkEgHLTBGdSLb4gliO
         rYXBbqd5/BTm7yApdjTQAdZ3KO3xyFIf060yv+VwBsSvu3aXe5Er1TLM75832BnuRN
         hoMd1RF50MYKELSn9odqDU8d8J2wdY9v+Eh28KZbkIgLaHmF0uhmTKY5IfYzDBEJ6a
         QXwpOZ4szXJMlLAmUaqmz/Z+DP6QBFa1HyNBp9TIRWl5ExYZh2fqDWKz53Lew5rASp
         HQhKuS/3hAfAptQ261aPe+LLlHkvVbDXjjV2vRQcT2fpSlnaC5EaTE+EZbJkUEB9pL
         9He7Nm+83TMDg==
Date:   Wed, 4 May 2022 12:06:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek-gen3: change driver name to mtk-pcie-gen3
Message-ID: <20220504170658.GA453994@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504100555.96007-1-nbd@nbd.name>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 12:05:55PM +0200, Felix Fietkau wrote:
> This allows it to coexist with the other mtk pcie driver in the same kernel

I assume this is a v3 of [1].  Please:

  - Follow the subject line capitalization convention, i.e.,
    "PCI: mediatek-gen3: Change ..."

  - Expand the commit log to say why this is important.  From a C
    language level, using the same "mtk-pcie" string in both drivers
    is no problem.  So please mention where it *is* a problem, e.g.,
    if it's a problem with modprobe or similar, say that.  Or if it's
    to make log messages in dmesg have different driver names, say
    that.

  - s/pcie/PCIe/ in commit log and other English text.

  - Add a period at the end of the commit log sentence.

[1] https://lore.kernel.org/r/20220422070908.14043-1-jianjun.wang@mediatek.com

> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 3e8d70bfabc6..2e665cd7e735 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1021,7 +1021,7 @@ static struct platform_driver mtk_pcie_driver = {
>  	.probe = mtk_pcie_probe,
>  	.remove = mtk_pcie_remove,
>  	.driver = {
> -		.name = "mtk-pcie",
> +		.name = "mtk-pcie-gen3",
>  		.of_match_table = mtk_pcie_of_match,
>  		.pm = &mtk_pcie_pm_ops,
>  	},
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
