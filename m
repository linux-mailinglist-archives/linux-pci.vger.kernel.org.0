Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784134C1AF2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 19:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiBWScz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 13:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbiBWScd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 13:32:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF79BC36;
        Wed, 23 Feb 2022 10:32:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C635B8212D;
        Wed, 23 Feb 2022 18:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E49CC340E7;
        Wed, 23 Feb 2022 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645641119;
        bh=AkDY5SFZ//EjjzonkJWDtmO5oUw7EK4mfwf5idhETV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rI8es7ID4IB366nvV/gM1u66kvmBnvSnp4QAzayAkT3VHBnUbYrVDFb2UGXUnRLPo
         6vNnIBGyYYKQ5qOZseAjxqX5SvSVehoEYSqu4KbzLYFStIACex/PczjatZKLMQRq3O
         kPWvgI8QHfUo+BK35JPNidrRygOy54DwJFELi3Dol+U7suyeTtljArP7g3Dy6ajOij
         +eNVkQAAiLV14st+QPFl7dJUkH1K/gAQ4xY7SId/XRPMwUl26Nb7KqtBpi3L58zcub
         ONtz/OHx9YkURuPD5CORCe745V2Rx60IfuNmEvz/dql9xAc32+4yHlEnLcT1AczoXP
         L0qGU1LOl2NiQ==
Date:   Wed, 23 Feb 2022 12:31:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH] PCI: imx6: Override the CLKREQ low in the initialization
Message-ID: <20220223183157.GA142509@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645605513-7731-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, maybe:

  PCI: imx6: Assert i.MX8MM CLKREQ# even if no device present

On Wed, Feb 23, 2022 at 04:38:33PM +0800, Richard Zhu wrote:
> The CLKREQ# signal is an open drain, active low signal that is driven
> low by the remote Endpoint device. But it might not be driven low if no
> Endpoint device is connected.
> 
> On i.MX8MM PCIe, phy_init() would be failed and system boot hang if the
> reference clock is not toggled.

s/would be failed/may fail/
s/boot hang/boot may hang/
s/if the reference clock is not toggled/if no Endpoint is connected to assert CLKREQ#/

> Follow with i.MX8MQ PCIe, to make sure the reference clock on, override
> the CLKREQ# low during initialization to fix this issue.

  Handle this as on i.MX8MQ, where we explicitly assert CLKREQ# so the
  PHY can be initialized.

(I don't really understand the hardware here, so disregard if this
doesn't say what it needs to.)

> Fixes: 178e244cb6e2 ("PCI: imx: Add the imx8mm pcie support")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index d7f0db01f3c3..a334341a1789 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -447,10 +447,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  	case IMX7D:
>  		break;
>  	case IMX8MM:
> -		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> -		if (ret)
> -			dev_err(dev, "unable to enable pcie_aux clock\n");
> -		break;
>  	case IMX8MQ:
>  		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
>  		if (ret) {
> -- 
> 2.25.1
> 
