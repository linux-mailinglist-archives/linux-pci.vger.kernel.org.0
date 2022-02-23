Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F904C1D5A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 21:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiBWUwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 15:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiBWUwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 15:52:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60AE13CE7;
        Wed, 23 Feb 2022 12:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63017B81F52;
        Wed, 23 Feb 2022 20:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7A7C340E7;
        Wed, 23 Feb 2022 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645649503;
        bh=0SqsE3SLzZsa9zyLElBqmrdwV4hoS7Iv9GFhoTF5g+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=US2/PMGO61W+lOicS973HTneLBfltUYIiOJIZb1wtOLIwUTPj6Gnph1e7FOwQSuGi
         /PnPoWjy3WAY+SUhu10zHzi/mWd/WKR6oaL/5aCz451OFJQ7rtJRDiQ2I77VgG57xN
         HOkUA4JGMIy8wO6jfwr+lb35/8ZI9ncNk9N9Lp9bCciYyx61eQfh3Yz79i30SKzBa4
         9TAG82cqPFV19zcc3KCeT+DpeTRyXIbhXHZHcqOiy1hKyYpXpSYOCPVjTQxDIcBhnn
         AUJtM40N7L8LDmQBgdgJWe+3wSI0gfZL3k5+RkDIOhaxvoPNu7wPpR5b/VkYPeWOO0
         bucANLzVXGOHw==
Date:   Wed, 23 Feb 2022 14:51:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCHv4 2/2] PCI: fu740: Force gen1 for initial device probe
Message-ID: <20220223205141.GA149346@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221210347.1335004-2-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 21, 2022 at 09:03:47PM +0000, Ben Dooks wrote:
> The fu740 PCIe core does not probe any devices on the SiFive Unmatched
> board without this fix from U-Boot (or having U-Boot explicitly start
> the PCIe via either boot-script or user command).
> 
> The fix claims to set the link-speed to gen1 to get the probe
> to work. As this is a copy from U-Boot, the code is assumed to be
> correct and does fix the issue on the Unmatched. The code is at:

Maybe something like:

  Limit the link to Gen1 speed.

since "the fix claims" and "the code is assumed" is sort of
weasel-worded.

The subject says "for initial device probe," but if you change
PCI_EXP_LNKCAP, I assume that limits the link speed forever, even
after a retrain?

> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c#L271

Maybe use this so the link doesn't become stale when more things are
added to pcie_dw_sifive.c:

  https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271

> The code has been this way since the driver was commited in:
> https://source.denx.de/u-boot/u-boot/-/commit/416395c772018c6bf52aad36aca163115001793f

s/commited/committed/

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/pci/controller/dwc/pcie-fu740.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> index 842b7202b96e..19501ec8c487 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -177,11 +177,30 @@ static void fu740_pcie_init_phy(struct fu740_pcie *afp)
>  	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE3_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
>  }
>  
> +/* This is copied from u-boot. Force system to gen1 otherwise nothing probes
> + * as found on the SiFive Unmatched board.
> + */

s/u-boot/U-Boot/

Use usual multi-line comment style.

> +static void fu740_pcie_force_gen1(struct dw_pcie *dw, struct fu740_pcie *afp )
> +{
> +	unsigned val;

u32, since that's what dw_pcie_readl_dbi() returns and
dw_pcie_writel_dbi() expects.

> +
> +	dw_pcie_dbi_ro_wr_en(dw);
> +
> +	val = dw_pcie_readl_dbi(dw, 0x70 + PCI_EXP_LNKCAP);

I assume 0x70 is the offset of the PCIe Capability.  There should be a
#define for that.

> +	pr_info("%s: link-cap was %08x\n", __func__, val);

  dev_info(pci->dev, "...");

> +	dw_pcie_writel_dbi(dw, 0x70 + PCI_EXP_LNKCAP, val | 0xf);

I don't understand this.  Per PCIe r6.0, sec 7.5.3.6, 1111b is a
reserved encoding for the low four bits of PCI_EXP_LNKCAP.

If you want PCI_EXP_LNKCAP to advertise only 2.5 GT/s, the low four
bits should be 0001b to indicate Supported Link Speeds Vector field
bit 0, which is defined as 2.5 GT/s.

> +	dw_pcie_dbi_ro_wr_dis(dw);
> +}
> +
>  static int fu740_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct device *dev = pci->dev;
>  	struct fu740_pcie *afp = dev_get_drvdata(dev);
>  
> +	/* Force PCIe gen1 otherwise Unmatched board does not probe */
> +	fu740_pcie_force_gen1(pci, afp);

I guess the "Unmatched" board is the only thing we need to care about
here?  Are there or will there be other boards that don't need this?

>  	/* Enable LTSSM */
>  	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
>  	return 0;
> -- 
> 2.34.1
> 
