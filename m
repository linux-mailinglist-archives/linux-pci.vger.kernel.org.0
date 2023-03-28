Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C06CC9B7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 19:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjC1RyD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 13:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjC1RyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 13:54:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86BE05C;
        Tue, 28 Mar 2023 10:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F158B81E34;
        Tue, 28 Mar 2023 17:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AEDC433EF;
        Tue, 28 Mar 2023 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680026032;
        bh=2YiRa5zMmLavggXXj54qS1KpalIDFc2G9Mo2Yjx/i+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d1Jz9mFoMyg/YgxPBKDO/yvKkTgt8/GT8XBPbHu5QOP0cMWOODHX2SQJDx0RdhGIY
         PfEuHxmKwpNeM9/KWDoVOMIoXWvmhOAqZSGMPi+6INV0NfxFXJwPdZBt8bSrcZSBHo
         wh22JAu/Wb4hPdSUzNHGBlTpHi6wScwSpz3Is8zW40fZryc+CaFp/6gC+LKaKqmyuk
         fR7v0xIKH0mLrldmBA+vdsx4I/XCskuJrnKE/Ab++MVgVttm4ZUb3PtRAfYRvj0x0Y
         vMnxxs4qigE3avnh6Rfqkon9vbMm9aY7cvnNWLI6ziYfohWeQRgj88fWQd7txEnLl+
         sK+wMk++drGmg==
Date:   Tue, 28 Mar 2023 12:53:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v4 10/10] PCI: tegra194: add interconnect support in
 Tegra234
Message-ID: <20230328175350.GA2953686@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327161426.32639-11-sumitg@nvidia.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Capitalize subject line please, to match pcie-tegra194.c history.

On Mon, Mar 27, 2023 at 09:44:26PM +0530, Sumit Gupta wrote:
> Add support to request DRAM bandwidth with Memory Interconnect
> in Tegra234 SoC. The DRAM BW required for different modes depends
> on speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
> 
> Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 40 +++++++++++++++++-----
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 09825b4a075e..d2513c9d3feb 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -15,6 +15,7 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
> +#include <linux/interconnect.h>

Almost alphabetized, swap interrupt.h and interconnect.h.

>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -287,6 +288,7 @@ struct tegra_pcie_dw {
>  	unsigned int pex_rst_irq;
>  	int ep_state;
>  	long link_status;
> +	struct icc_path *icc_path;
>  };
>  
>  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> @@ -309,6 +311,24 @@ struct tegra_pcie_soc {
>  	enum dw_pcie_device_mode mode;
>  };
>  
> +static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	u32 val, speed, width;
> +
> +	val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
> +
> +	val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
> +
> +	if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
> +		dev_err(pcie->dev, "can't set bw[%u]\n", val);
> +
> +	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);

Array bounds violation; PCI_EXP_LNKSTA_CLS is 0x000f, so possible
speed (CLS) values are 0..0xf and "speed - 1" values are -1..0xe.

pcie_gen_freq[] is of size 4 (valid indices 0..3).

I see that you're just *moving* this code, but might as well fix it.

> +}
> +
>  static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -452,14 +472,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  	struct tegra_pcie_dw *pcie = arg;
>  	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  	struct dw_pcie *pci = &pcie->pci;
> -	u32 val, speed;
> +	u32 val;
>  
>  	if (test_and_clear_bit(0, &pcie->link_status))
>  		dw_pcie_ep_linkup(ep);
>  
> -	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> -		PCI_EXP_LNKSTA_CLS;
> -	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> +	tegra_pcie_icc_set(pcie);
