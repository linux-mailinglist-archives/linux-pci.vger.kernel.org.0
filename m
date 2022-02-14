Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087374B55D4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 17:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiBNQMV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 11:12:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiBNQMU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 11:12:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE5C20;
        Mon, 14 Feb 2022 08:12:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8114B80E6C;
        Mon, 14 Feb 2022 16:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60642C340E9;
        Mon, 14 Feb 2022 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644855129;
        bh=4dZnpaRwK5MeVsN5xFfeGIeYJIqAH3iT0DDVOoXtb+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P/uzoknyecs665CyWr1d4eKDhbkZge2DaygEM9f4eKRnMcKubLFy2YflibYkrJvRu
         dEzxPxTtrLHzBFcVunZLACIbCbkiEN+SdC5UqE7cMdEegLv+ypePJ271tRJN0w/pKS
         RkvwZD5qNXN5t2DU/t1Ob8jT83IkIGB5MvDSxO3lhM/QPh1Eywhtlf7FaUvG7rlOVL
         QY0HYcxWlfAYQOtMqEJIXcsNwi1csQosngGTr9el6mYZDltoDV5LsQVlofjVbDeO6P
         X/6f8ThShIgU4C9mIl/+Oy3b9XkZH2+JVPGdFXnc+OKKz+51F9/k3v5FqUb1/zE4xd
         1QYs9APpa3OeA==
Date:   Mon, 14 Feb 2022 10:12:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.comv,
        linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, david.abdurachmanov@gmail.com
Subject: Re: [PATCH 2/2] PCI: fu740: Force gen1 for initial device probe
Message-ID: <20220214161207.GA10207@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214082144.1176084-3-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 08:21:44AM +0000, Ben Dooks wrote:
> The fu740 dw pcie core does not probe devices without this fix from
> U-boot. The fix claims to set the link-speed to gen1 to get the probe
> to work. As this is a copy from U-boot, the commentary is assumed to
> be correct.

s/dw/DW/ (to match below)
s/pcie/PCIe/
s/U-boot/U-Boot/ (twice, and again below)

Is there a stable URL to the place in U-Boot where this is copied
from?

> Without this in, and without U-boot starting the PCIe the Unmatched
> board does not show any PCIe devices after the DW root port.
> 
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

Use this comment style to match the rest of the file:

  /*
   * Comment...
   */

> +static void fu740_pcie_force_gen1(struct dw_pcie *dw, struct fu740_pcie *afp )
> +{
> +	unsigned val;
> +
> +	dw_pcie_dbi_ro_wr_en(dw);
> +
> +	val = dw_pcie_readl_dbi(dw, 0x70 + PCI_EXP_LNKCAP);
> +	pr_info("%s: link-cap was %08x\n", __func__, val);
> +	dw_pcie_writel_dbi(dw, 0x70 + PCI_EXP_LNKCAP, val | 0xf);
> +
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

Is Unmatched the *only* board with this controller, i.e., do we want
to do this for every single FU740 device?

If this is an FU740 defect that will affect anything that uses it, we
should say that, and we shouldn't call out "Unmatched" specifically.

> +
>  	/* Enable LTSSM */
>  	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
>  	return 0;
> -- 
> 2.34.1
> 
