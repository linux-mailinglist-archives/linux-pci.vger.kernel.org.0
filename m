Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D059A546B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfIBKvA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 06:51:00 -0400
Received: from foss.arm.com ([217.140.110.172]:52090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731347AbfIBKu7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Sep 2019 06:50:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E7AF28;
        Mon,  2 Sep 2019 03:50:59 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AA023F246;
        Mon,  2 Sep 2019 03:50:58 -0700 (PDT)
Date:   Mon, 2 Sep 2019 11:50:56 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Don't rely on jiffies while holding
 spinlock
Message-ID: <20190902105056.GF9720@e119886-lin.cambridge.arm.com>
References: <20190901142303.27815-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901142303.27815-1-repk@triplefau.lt>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 01, 2019 at 04:23:03PM +0200, Remi Pommarel wrote:
> advk_pcie_wait_pio() can be called while holding a spinlock (from
> pci_bus_read_config_dword()), then depends on jiffies in order to
> timeout while polling on PIO state registers. In the case the PIO
> transaction failed, the timeout will never happen and will also cause
> the cpu to stall.
> 
> This decrements a variable and wait instead of using jiffies.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
>  drivers/pci/controller/pci-aardvark.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index fc0fe4d4de49..1fa6d04ad7aa 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -175,7 +175,8 @@
>  	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))	| \
>  	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))
>  
> -#define PIO_TIMEOUT_MS			1
> +#define PIO_RETRY_CNT			10
> +#define PIO_RETRY_DELAY			100 /* 100 us*/
>  
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
> @@ -383,17 +384,16 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
>  static int advk_pcie_wait_pio(struct advk_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
> -	unsigned long timeout;
> +	size_t i;
>  
> -	timeout = jiffies + msecs_to_jiffies(PIO_TIMEOUT_MS);
> -
> -	while (time_before(jiffies, timeout)) {
> +	for (i = 0; i < PIO_RETRY_CNT; ++i) {
>  		u32 start, isr;
>  
>  		start = advk_readl(pcie, PIO_START);
>  		isr = advk_readl(pcie, PIO_ISR);
>  		if (!start && isr)
>  			return 0;
> +		udelay(PIO_RETRY_DELAY);
>  	}
>  
>  	dev_err(dev, "config read/write timed out\n");
> -- 
> 2.20.1
> 
