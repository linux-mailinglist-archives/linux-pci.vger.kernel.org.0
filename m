Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE98E3888F2
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 10:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhESIHv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 04:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235381AbhESIHv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 May 2021 04:07:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84223611BF;
        Wed, 19 May 2021 08:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621411591;
        bh=KnUP4pbDB1v5P9lFsxoFeNygHudhxC0V615et8+QNIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYejWY7fAJBv7pX9xt9unm/0dh/EdBPyqLXHJw9DmrHigvoA9OzXROd6rE99Rsymx
         y4YQ3kBQ2gbfMdnUOIjhg4DSpsA7tXWRy9MT194ib1RdkkRlKHWpBznR+Cc/yyPugV
         KYbtJG8a1DGQNeDmx2dVWFkxcSFqHc6FX5VaSt3Cnon5UrcxreK6Xmk+XkOCnG8Pq1
         9iNSo9d+eJvSPXcySh9k/4nAw1Henvqr7kKmSFc36yXv7Mm72UL/h994ymSp/BJt2r
         bF2gXZLeDvWq8NU+U76Ps8J+p+SDVJPsLu8BPcFQxig24YE010Rzpx/BcoOSWgOpOt
         raoKqq7PjuhKw==
Received: by pali.im (Postfix)
        id D03A2857; Wed, 19 May 2021 10:06:27 +0200 (CEST)
Date:   Wed, 19 May 2021 10:06:27 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/42] PCI: aardvark: Fix kernel panic during PIO transfer
Message-ID: <20210519080627.sfs74d2zxopkarfl@pali>
References: <20210506153153.30454-1-pali@kernel.org>
 <20210506153153.30454-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506153153.30454-2-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 06 May 2021 17:31:12 Pali Rohár wrote:
> Trying to start a new PIO transfer by writing value 0 in PIO_START register
> when previous transfer has not yet completed (which is indicated by value 1
> in PIO_START) causes an External Abort on CPU, which results in kernel
> panic:
> 
>     SError Interrupt on CPU0, code 0xbf000002 -- SError
>     Kernel panic - not syncing: Asynchronous SError Interrupt
> 
> To prevent kernel panic, it is required to reject a new PIO transfer when
> previous one has not finished yet.
> 
> If previous PIO transfer is not finished yet, the kernel may issue a new
> PIO request only if the previous PIO transfer timed out.
> 
> In the past the root cause of this issue was incorrectly identified (as it
> often happens during link retraining or after link down event) and special
> hack was implemented in Trusted Firmware to catch all SError events in EL3,
> to ignore errors with code 0xbf000002 and not forwarding any other errors
> to kernel and instead throw panic from EL3 Trusted Firmware handler.
> 
> Links to discussion and patches about this issue:
> https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=3c7dcdac5c50
> https://lore.kernel.org/linux-pci/20190316161243.29517-1-repk@triplefau.lt/
> https://lore.kernel.org/linux-pci/971be151d24312cc533989a64bd454b4@www.loen.fr/
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/1541
> 
> But the real cause was the fact that during link retraning or after link
> down event the PIO transfer may take longer time, up to the 1.44s until it
> times out. This increased probability that a new PIO transfer would be
> issued by kernel while previous one has not finished yet.
> 
> After applying this change into the kernel, it is possible to revert the
> mentioned TF-A hack and SError events do not have to be caught in TF-A EL3.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Cc: stable@vger.kernel.org # 7fbcb5da811b ("PCI: aardvark: Don't rely on jiffies while holding spinlock")

Hello! Could you please review at least this patch? It is fixing kernel
panic and to prevent future kernel crashes I would really suggest to
merge this one patch into 5.13 queue.

> ---
>  drivers/pci/controller/pci-aardvark.c | 49 ++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 051b48bd7985..e3f5e7ab7606 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -514,7 +514,7 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
>  		udelay(PIO_RETRY_DELAY);
>  	}
>  
> -	dev_err(dev, "config read/write timed out\n");
> +	dev_err(dev, "PIO read/write transfer time out\n");
>  	return -ETIMEDOUT;
>  }
>  
> @@ -657,6 +657,35 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
>  	return true;
>  }
>  
> +static bool advk_pcie_pio_is_running(struct advk_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +
> +	/*
> +	 * Trying to start a new PIO transfer when previous has not completed
> +	 * cause External Abort on CPU which results in kernel panic:
> +	 *
> +	 *     SError Interrupt on CPU0, code 0xbf000002 -- SError
> +	 *     Kernel panic - not syncing: Asynchronous SError Interrupt
> +	 *
> +	 * Functions advk_pcie_rd_conf() and advk_pcie_wr_conf() are protected
> +	 * by raw_spin_lock_irqsave() at pci_lock_config() level to prevent
> +	 * concurrent calls at the same time. But because PIO transfer may take
> +	 * about 1.5s when link is down or card is disconnected, it means that
> +	 * advk_pcie_wait_pio() does not always have to wait for completion.
> +	 *
> +	 * Some versions of ARM Trusted Firmware handles this External Abort at
> +	 * EL3 level and mask it to prevent kernel panic. Relevant TF-A commit:
> +	 * https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=3c7dcdac5c50
> +	 */
> +	if (advk_readl(pcie, PIO_START)) {
> +		dev_err(dev, "Previous PIO read/write transfer is still running\n");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  			     int where, int size, u32 *val)
>  {
> @@ -673,9 +702,10 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  		return pci_bridge_emul_conf_read(&pcie->bridge, where,
>  						 size, val);
>  
> -	/* Start PIO */
> -	advk_writel(pcie, 0, PIO_START);
> -	advk_writel(pcie, 1, PIO_ISR);
> +	if (advk_pcie_pio_is_running(pcie)) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_SET_FAILED;
> +	}
>  
>  	/* Program the control register */
>  	reg = advk_readl(pcie, PIO_CTRL);
> @@ -694,7 +724,8 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	/* Program the data strobe */
>  	advk_writel(pcie, 0xf, PIO_WR_DATA_STRB);
>  
> -	/* Start the transfer */
> +	/* Clear PIO DONE ISR and start the transfer */
> +	advk_writel(pcie, 1, PIO_ISR);
>  	advk_writel(pcie, 1, PIO_START);
>  
>  	ret = advk_pcie_wait_pio(pcie);
> @@ -734,9 +765,8 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	if (where % size)
>  		return PCIBIOS_SET_FAILED;
>  
> -	/* Start PIO */
> -	advk_writel(pcie, 0, PIO_START);
> -	advk_writel(pcie, 1, PIO_ISR);
> +	if (advk_pcie_pio_is_running(pcie))
> +		return PCIBIOS_SET_FAILED;
>  
>  	/* Program the control register */
>  	reg = advk_readl(pcie, PIO_CTRL);
> @@ -763,7 +793,8 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	/* Program the data strobe */
>  	advk_writel(pcie, data_strobe, PIO_WR_DATA_STRB);
>  
> -	/* Start the transfer */
> +	/* Clear PIO DONE ISR and start the transfer */
> +	advk_writel(pcie, 1, PIO_ISR);
>  	advk_writel(pcie, 1, PIO_START);
>  
>  	ret = advk_pcie_wait_pio(pcie);
> -- 
> 2.20.1
> 
