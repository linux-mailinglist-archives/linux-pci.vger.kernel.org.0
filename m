Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0152F6B81D9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCMTsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 15:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMTsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 15:48:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D79FF13;
        Mon, 13 Mar 2023 12:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3C6861485;
        Mon, 13 Mar 2023 19:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0959C433D2;
        Mon, 13 Mar 2023 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678736884;
        bh=G2Dygv9h1k+AsQjs6iEoGo+aHQ82JlNoZoMwg+tfTdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ThIzozSw+qA+WbXZ5ZEUZMLXLp74nrCv6P5181EvRezMgzJlos3qJmki256PPKMxX
         WDnRBx6in5H551XdcqfD6ynszY6OtG2WFMEWbbwMsmvMi1Gm/yc8bBUgGnEkas2L2p
         zrc/lJUXnvSvL1e1M1+dKoPP0q+tQFYIMmmpVjxUnSwx8HTclzh4A1OUlTKomPFyUw
         SzoANoHq1Dk3hfGgs4VBKSvlL/WXqhgOJTOPw3Q1TSynu7u7Hxh+/Rr54MtO3sJadY
         Vjl3zt8X7NI73YNsAths7QSOAenXLqB+nDzJT+Z8LlOQcDHDOud1vKclR4NSQqR/yn
         daLi1fGQJCmJQ==
Date:   Mon, 13 Mar 2023 14:48:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v4 8/8] PCI: dwc: Introduce region limit from DT
Message-ID: <20230313194802.GA1531673@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124016.17102-9-enachman@marvell.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Serge, who has done most of the recent work in this file]

On Mon, Mar 13, 2023 at 02:40:16PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Allow dts override of region limit for SOCs with older Synopsis
> Designware PCIe IP but with greater than 32-bit address range support,
> such as the Armada 7020/7040/8040 family of SOCs by Marvell,
> when the DT file places the PCIe window above the 4GB region.
> The Synopsis Designware PCIe IP in these SOCs is too old to specify the
> highest memory location supported by the PCIe, but practically supports
> such locations. Allow these locations to be specified in the DT file.
> DT property is called num-regionmask , and can range between 33 and 64.

s/Synopsis/Synopsys/ (several occurrences)

s/Designware/DesignWare/ (several occurrences)

Remove space before comma.

> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
> v4:
>    1) Fix blank lines removal / addition
> 
>    2) Remove usage of variable with same name as dt binding property
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 53a16b8b6ac2..9773c110c733 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -735,8 +735,10 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
>  	int max_region, ob, ib;
> -	u32 val, min, dir;
> +	u32 val, min, dir, ret;
>  	u64 max;
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
>  
>  	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
>  	if (val == 0xFFFFFFFF) {
> @@ -781,7 +783,13 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  		dw_pcie_writel_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT, 0xFFFFFFFF);
>  		max = dw_pcie_readl_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT);
>  	} else {
> -		max = 0;
> +		/* Allow dts override of region limit for older IP with above 32-bit support: */

Reflow comment to fit in 80 columns.

> +		ret = of_property_read_u32(np, "num-regionmask", &val);
> +		if (!ret && val > 32) {
> +			max = GENMASK(val - 33, 0);
> +			dev_info(pci->dev, "Overriding region limit to %u bits\n", val);
> +		} else
> +			max = 0;
>  	}
>  
>  	pci->num_ob_windows = ob;
> -- 
> 2.17.1
> 
