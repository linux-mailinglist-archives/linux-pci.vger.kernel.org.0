Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8C838C6
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 20:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfHFSlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 14:41:22 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51215 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfHFSlR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2019 14:41:17 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5DF3D6000E;
        Tue,  6 Aug 2019 18:41:13 +0000 (UTC)
Date:   Tue, 6 Aug 2019 20:49:46 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ellie Reeves <ellierevves@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Wait for endpoint to be ready before
 training link
Message-ID: <20190806184945.GU12859@voidbox.localdomain>
References: <20190522213351.21366-2-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522213351.21366-2-repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 11:33:50PM +0200, Remi Pommarel wrote:
> When configuring pcie reset pin from gpio (e.g. initially set by
> u-boot) to pcie function this pin goes low for a brief moment
> asserting the PERST# signal. Thus connected device enters fundamental
> reset process and link configuration can only begin after a minimal
> 100ms delay (see [1]).
> 
> Because the pin configuration comes from the "default" pinctrl it is
> implicitly configured before the probe callback is called:
> 
> driver_probe_device()
>   really_probe()
>     ...
>     pinctrl_bind_pins() /* Here pin goes from gpio to PCIE reset
>                            function and PERST# is asserted */
>     ...
>     drv->probe()
> 
> [1] "PCI Express Base Specification", REV. 4.0
>     PCI Express, February 19 2014, 6.6.1 Conventional Reset
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
> Changes since v1:
>   - Add a comment about pinctrl implicit pin configuration
>   - Use more legible msleep
>   - Use PCI_PM_D3COLD_WAIT macro
> 
> Please note that I will unlikely be able to answer any comments from May
> 24th to June 10th.
> ---
>  drivers/pci/controller/pci-aardvark.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 134e0306ff00..d998c2b9cd04 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -324,6 +324,14 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  	reg |= PIO_CTRL_ADDR_WIN_DISABLE;
>  	advk_writel(pcie, reg, PIO_CTRL);
>  
> +	/*
> +	 * PERST# signal could have been asserted by pinctrl subsystem before
> +	 * probe() callback has been called, making the endpoint going into
> +	 * fundamental reset. As required by PCI Express spec a delay for at
> +	 * least 100ms after such a reset before link training is needed.
> +	 */
> +	msleep(PCI_PM_D3COLD_WAIT);
> +
>  	/* Start link training */
>  	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
>  	reg |= PCIE_CORE_LINK_TRAINING;
> -- 
> 2.20.1

Gentle ping.

-- 
Remi
