Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE4B61ED2F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 09:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKGIn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 03:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiKGIny (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 03:43:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463BC2626;
        Mon,  7 Nov 2022 00:43:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 885D5B80B8D;
        Mon,  7 Nov 2022 08:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78A9C433D6;
        Mon,  7 Nov 2022 08:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667810630;
        bh=s4O1eWmHOa86wpGByLAydZl7UeUpyu0CzKU4kzn7HJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhgD1Pf/z4Zk/gdeXMJs9kUIANWO+7c+0fmALFzCB9LukvqLiTjzOSmgRrhynTJZc
         RUZgdQr7bkstW75ta9UD5I3kWWlDhXX75e12JHmjjjDgVl/2Hqx+8xZLntzFr0iU+o
         WXJr2KfNVz/5fI9xzxfXNlp4WZwYJQ+VM5ZWxZDgYopfm28mrbQFRWOEnwILXM8YVh
         GHqJzJY1XKp+DwD4Xws+0TBmD19aE6Gq3sqxl3fVVxOeaGj/Pa7dj9G9Rabm4Tel4O
         TVsROk5+fwJyVe3lipwoT1L9zsYpCt/9N3lEsVy9jGKydUKig19xJN7P2UfdQqyskZ
         1sGeWlfHwTtRA==
Received: by pali.im (Postfix)
        id EE84489B; Mon,  7 Nov 2022 09:43:46 +0100 (CET)
Date:   Mon, 7 Nov 2022 09:43:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: mvebu: Set Target Link Speed for 2.5GT downstream
 devices
Message-ID: <20221107084346.ksdhcxk7bppvpmqc@pali>
References: <20221107081327.336239-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107081327.336239-1-nathan@nathanrossi.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 07 November 2022 08:13:27 Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> There is a known issue with the mvebu PCIe controller when triggering
> retraining of the link (via Link Control) where the link is dropped
> completely causing significant delay in the renegotiation of the link.
> This occurs only when the downstream device is 2.5GT and the upstream
> port is configured to support both 2.5GT and 5GT.
> 
> It is possible to prevent this link dropping by setting the associated
> link speed in Target Link Speed of the Link Control 2 register. This
> only needs to be done when the downstream is specifically 2.5GT.
> 
> This change applies the required Target Link Speed value during
> mvebu_pcie_setup_hw conditionally depending on the current link speed
> from the Link Status register, only applying the change when the link
> is configured to 2.5GT already.
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 1ced73726a..6a869a33ba 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -248,7 +248,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
>  
>  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  {
> -	u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl;
> +	u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl, lnksta, lnkctl2;
>  
>  	/* Setup PCIe controller to Root Complex mode. */
>  	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
> @@ -339,6 +339,22 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  	unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
>  		  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
>  	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> +
> +	/*
> +	 * Set Target Link Speed within the Link Control 2 register when the
> +	 * linked downstream device is connected at 2.5GT. This is configured
> +	 * in order to avoid issues with the controller when the upstream port
> +	 * is configured to support 2.5GT and 5GT and the downstream device is
> +	 * linked at 2.5GT, retraining the link in this case causes the link to
> +	 * drop taking significant time to retrain.
> +	 */
> +	lnksta = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL) >> 16;
> +	if ((lnksta & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {

This code does not work because at this stage endpoint device does not
have to be ready and therefore link is not established yet.

Also this code is not running when kernel issue PCIe Hot Reset via
PCI Secondary Bus Reset bit.

And it does not handle possible hot-plug situation.

That check that code below has to be done _after_ kernel enumerate
device. PCI core code has already logic to handle delays for "slow"
devices.

And reverse operation (setting lnkctl2 target speed to original value)
has to be called after unplugging device - when link goes down.

If you want to work on this stuff, I can try to find my notes which I
done during investigation of this issue... where is probably the best
place in kernel pci core code for handling this issue.

> +		lnkctl2 = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
> +		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> +		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
> +		mvebu_writel(port, lnkctl2, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
> +	}
>  }
>  
>  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
> ---
> 2.37.2
