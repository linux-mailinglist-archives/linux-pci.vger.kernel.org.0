Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47DD543E6C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 23:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiFHVSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 17:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiFHVSd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 17:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A6F7FBE;
        Wed,  8 Jun 2022 14:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0331F60C09;
        Wed,  8 Jun 2022 21:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D12BC34116;
        Wed,  8 Jun 2022 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654723110;
        bh=hMm08CtBQN4ZsNXmDVpg42397czG7FG+G1VypAwyesg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l7+Zbyj72xk/E2x7bjf+Y4uIn4Te23X8ICtETR/NIwt2tlaZuKpJGMwlAbVy7HXxQ
         tHkCRKoFY9t2IcuPMzfoctJ47ex6CdLuH6oTdZxUG177FSd13j07kSrQmpQBl/IZxn
         oWASGRnnO6ou7E1B0WvpSiK34rkqpIafssyB2tGfrGeTLudpfDcQ0GY3vs86wX2DOi
         F2b9tdqx9w1N2oiAKZjTo6i8LpasyRjPy9AAPXvD3F3Z+s3ChjYYjd3Xhg8yIRMm0K
         sh52CidWhkYUZOdID8uORImDvwamzCP3ovsHxpZ137JJ0cKsZVbpjqkGYPNvR8dMGL
         7HgaXdZXbusTQ==
Date:   Wed, 8 Jun 2022 16:18:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Fix PM error handling in
 tegra_pcie_config_ep
Message-ID: <20220608211828.GA424008@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602031910.55859-1-linmq006@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 07:19:08AM +0400, Miaoqian Lin wrote:
> The pm_runtime_enable() will increase power disable depth.
> if dw_pcie_ep_init() fails, we should use pm_runtime_disable()
> to balance it pm_runtime_enable().
> Add missing pm_runtime_disable() for tegra_pcie_config_ep()
> 
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied with Vidya's ack to pci/ctrl/tegra194 for v5.20, thanks!

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index cc2678490162..d992371a36e6 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1949,6 +1949,7 @@ static int tegra_pcie_config_ep(struct tegra194_pcie *pcie,
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize DWC Endpoint subsystem: %d\n",
>  			ret);
> +		pm_runtime_disable(dev);
>  		return ret;
>  	}
>  
> -- 
> 2.25.1
> 
