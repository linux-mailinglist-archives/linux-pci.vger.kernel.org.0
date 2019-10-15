Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E8D7292
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 11:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfJOJyF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 05:54:05 -0400
Received: from foss.arm.com ([217.140.110.172]:34004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOJyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 05:54:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8074C28;
        Tue, 15 Oct 2019 02:54:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2BD3F68E;
        Tue, 15 Oct 2019 02:54:03 -0700 (PDT)
Date:   Tue, 15 Oct 2019 10:53:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Wait for endpoint to be ready before
 training link
Message-ID: <20191015095358.GA32431@e121166-lin.cambridge.arm.com>
References: <20190522213351.21366-2-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522213351.21366-2-repk@triplefau.lt>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Applied to pci/aardvark, thanks.

Lorenzo

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
> 
