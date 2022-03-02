Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5F34C9F08
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 09:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiCBITG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 03:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiCBITE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 03:19:04 -0500
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9142B185;
        Wed,  2 Mar 2022 00:18:21 -0800 (PST)
Received: from [167.98.27.226] (helo=[10.35.6.178])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nPKBe-0005Nk-TK; Wed, 02 Mar 2022 08:18:18 +0000
Message-ID: <3b29f372-bfe4-2527-d074-0e589442c3da@codethink.co.uk>
Date:   Wed, 2 Mar 2022 08:18:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC] PCI: fu740: Force Gen1 to fix initial device probing on
 some boards
Content-Language: en-GB
To:     helgaas@kernel.org, linux-pci@vger.kernel.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220228232206.2928784-1-ben.dooks@codethink.co.uk>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20220228232206.2928784-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/02/2022 23:22, Ben Dooks wrote:
> The fu740 PCIe core does not probe any devices on the SiFive Unmatched
> board without this fix (or having U-Boot explicitly start the PCIe via
> either boot-script or user command). The fix is to start the link at
> Gen1 speeds and once the link is up then change the speed back.
> 
> The U-Boot driver claims to set the link-speed to Gen1 to get the probe
> to work (and U-Boot does print link up at Gen1) in the following code:
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> Note, this patch has had significant re-work since the previous 4
> sets, including trying to fix style, message, reliance on the U-Boot
> fix and the comments about usage of LINK_CAP and reserved fields.

So the pci-imx6.c driver does wait after the setting of
PCIE_LINK_WIDTH_SPEED_CONTROL for the PCIE_LINK_WIDTH_SPEED_CONTROL
to show PORT_LOGIC_SPEED_CHANGE. Not sure if this is needed in this
case.

I have put this driver in to our CI and it so far seems to be working
in our case. I'm not sure if there's anything we could do better to
detect already initialised values from U-Boot and avoid this. Also I
am questioning if we need some sort of hardware property to control
the behaviour.

Does anyone at SiFive have any more information about whether this fix
is now correct? It is very annoying for us as we network boot and thus
the PCIe does not come up without this fix in.

Note, it is possible the pci-imx6.c driver does not build, could not
find a field called linl in the struct dw_pcie. I will try and see if
this driver is being built or not.

> ---
>   drivers/pci/controller/dwc/pcie-fu740.c | 51 ++++++++++++++++++++++++-
>   1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> index 842b7202b96e..16ad52f53490 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -181,10 +181,59 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
>   {
>   	struct device *dev = pci->dev;
>   	struct fu740_pcie *afp = dev_get_drvdata(dev);
> +	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	int ret;
> +	u32 orig, tmp;
> +
> +	/*
> +	 * Force Gen1 when starting link, due to some devices not
> +	 * probing at higher speeds. This happens with the PCIe switch
> +	 * on the Unmatched board. The fix in U-Boot is to force Gen1
> +	 * and hope later resets will clear this capaility.
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
>   	/* Enable LTSSM */
>   	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
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
> +	// todo - if we do have an unliekly error, what do we do here?
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +	return ret;
>   }
>   
>   static int fu740_pcie_host_init(struct pcie_port *pp)


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
