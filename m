Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16B14E31C5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 21:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353333AbiCUUan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 16:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiCUUan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 16:30:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D5340CE;
        Mon, 21 Mar 2022 13:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E476B819D5;
        Mon, 21 Mar 2022 20:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08E6C36AE5;
        Mon, 21 Mar 2022 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647894554;
        bh=0t3di4frHw4wef47Rc5l5X8PkzcS5T+5paso1xex7hs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ptM/44lFY5Xmt/PQ4iD4vJ6Xn1vhW/pwoPjQPSaBTDmnnKqih2lNfjkUsqWB5FMLt
         PvjW3onauXv6V9oi3raECGxU7o7OrNA0R7RuRvNa2YoQg8UPDKMrt0Ql+U/a8EKptH
         hE3dM1xl8s/6oPs+zSvtKmMGNHhM3V00FZInZO3juH9OXLwo07uD/2DJVsR2q0ZvZa
         2UWZdMKgeuxhsWjO/Zr5JRjQ045fUAP9I+Yymuiuguq6THcKS6Vl2MFrzaDY9hqcs1
         wDsJH2sxFZv93XOgd0V3o5oHuzlljP8Wg9dLhXaGcSLCq7k3ceC3gKfeJ4gnXG4fRW
         V5lzDyAtxVgRg==
Date:   Mon, 21 Mar 2022 15:29:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [V3] PCI: fu740: Drop to 2.5GT/s to fix initial device probing
 on some boards
Message-ID: <20220321202912.GA1120443@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318152430.526320-1-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 18, 2022 at 03:24:30PM +0000, Ben Dooks wrote:
> The fu740 PCIe core does not probe any devices on the SiFive Unmatched
> board without this fix (or having U-Boot explicitly start the PCIe via
> either boot-script or user command). The fix is to start the link at
> 2.5GT/s speeds and once the link is up then change the maximum speed back
> to the default.
> 
> The U-Boot driver claims to set the link-speed to 2.5GT/s to get the probe
> to work (and U-Boot does print link up at 2.5GT/s) in the following code:
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Lorenzo has an old version of this patch on his pci/fu740 branch.

Since we're now in the merge window, I applied this V3 patch to my
pci/host/fu740 branch so we can try to get this in for v5.18.

> --
> Note, this patch has had significant re-work since the previous 4
> sets, including trying to fix style, message, reliance on the U-Boot
> fix and the comments about usage of LINK_CAP and reserved fields.
> 
> v2:
> - fix issues with Gen1/2.5GTs
> - updated comment on the initial probe
> - run tests with both uninitialised and initialsed pcie from uboot
> ---
>  drivers/pci/controller/dwc/pcie-fu740.c | 52 ++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> index 842b7202b96e..ecac0364178a 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -181,10 +181,60 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct device *dev = pci->dev;
>  	struct fu740_pcie *afp = dev_get_drvdata(dev);
> +	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	int ret;
> +	u32 orig, tmp;
> +
> +	/*
> +	 * Force 2.5GT/s when starting the link, due to some devices not
> +	 * probing at higher speeds. This happens with the PCIe switch
> +	 * on the Unmatched board when U-Boot has not initialised the PCIe.
> +	 * The fix in U-Boot is to force 2.5GT/s, which then gets cleared
> +	 * by the soft reset does by this driver.
> +	 */
> +
> +	dev_dbg(dev, "cap_exp at %x\n", cap_exp);
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	tmp = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCAP);
> +	orig = tmp & PCI_EXP_LNKCAP_SLS;
> +	tmp &= ~PCI_EXP_LNKCAP_SLS;
> +	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> +	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
>  
>  	/* Enable LTSSM */
>  	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
> -	return 0;
> +
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret) {
> +		dev_err(dev, "error: link did not start\n");
> +		goto err;
> +	}
> +
> +	tmp = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCAP);
> +	if ((tmp & PCI_EXP_LNKCAP_SLS) != orig) {
> +		dev_dbg(dev, "changing speed back to original\n");
> +
> +		tmp &= ~PCI_EXP_LNKCAP_SLS;
> +		tmp |= orig;
> +		dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
> +
> +		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +		tmp |= PORT_LOGIC_SPEED_CHANGE;
> +		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> +
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret) {
> +			dev_err(dev, "error: link did not start at new speed\n");
> +			goto err;
> +		}
> +	}
> +
> +	ret = 0;
> +err:
> +	WARN_ON(ret);	/* we assume that errors will be very rare */
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +	return ret;
>  }
>  
>  static int fu740_pcie_host_init(struct pcie_port *pp)
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
