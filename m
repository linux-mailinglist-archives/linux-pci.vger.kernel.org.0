Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14B150DC64
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 11:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiDYJYV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 25 Apr 2022 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiDYJYQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 05:24:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF75B2668
        for <linux-pci@vger.kernel.org>; Mon, 25 Apr 2022 02:21:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1niutp-0003uW-GT; Mon, 25 Apr 2022 11:20:53 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1niuto-0057Sx-PG; Mon, 25 Apr 2022 11:20:51 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1niutm-0004WV-OB; Mon, 25 Apr 2022 11:20:50 +0200
Message-ID: <25fbf4763c28af4c73162dec254af6111e05461b.camel@pengutronix.de>
Subject: Re: [PATCH v8 2/5] PCI: dwc: rockchip: reset core at driver probe
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Peter Geis <pgwipeout@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Apr 2022 11:20:50 +0200
In-Reply-To: <20220423152403.1681222-3-pgwipeout@gmail.com>
References: <20220423152403.1681222-1-pgwipeout@gmail.com>
         <20220423152403.1681222-3-pgwipeout@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Peter,

On Sa, 2022-04-23 at 11:24 -0400, Peter Geis wrote:
> The PCIe controller is in an unknown state at driver probe. This can
> lead to undesireable effects when the driver attempts to configure the
> controller.
> 
> Prevent issues in the future by resetting the core during probe.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 22 +++++++------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c9b341e55cbb..d67ed811e752 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -152,7 +152,13 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>  	if (IS_ERR(rockchip->rst_gpio))
>  		return PTR_ERR(rockchip->rst_gpio);
> 
> -	return 0;
> +	rockchip->rst = devm_reset_control_array_get_exclusive(&pdev->dev);
> +	if (IS_ERR(rockchip->rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
> +				     "failed to get reset lines\n");
> +
> +	return reset_control_assert(rockchip->rst);

This makes "rockchip_pcie_resource_get" a bit of a misnomer, maybe move
this out into rockchip_pcie_probe()?

> +

Superfluous whitespace.

regards
Philipp

