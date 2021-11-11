Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AF44DD66
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhKKWAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 17:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhKKWAK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 17:00:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4880261252;
        Thu, 11 Nov 2021 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636667840;
        bh=ticax1p1bJ7oVmYMeKFcEh+6vye+SfczkbikmorTPkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q1eZA77xr96iZ+RsxYzDxqMYvzLNdL0DtUZE1GbbuCdnAWdfN5LkrEcgFKRIekTqC
         bn16QeJN8A1zo3JWq6Z/nH0GFeuSedeYjjxK01OTwMU/X5fo9IONrW37ccTcLnZYg0
         5GRvLoovJnlOXcymAFj4m0wDTy1h441zsmmAWQrhQcSX07hLmKVOfGdC+mCPZZZ6yJ
         id2OC09/wiW3WMdfxPs+YrVP3KVWoCl8pXrorw4evj/z8fXb2qJdNsvpKRY5DwX6I2
         ISAeHsp4x24o1l/MTA3Cylm3jfNiV35Vxq8l4ex/hfnGXjXsdPcLRuk4HKTcMMG2CS
         WPd+/7fC+n0XA==
Date:   Thu, 11 Nov 2021 15:57:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/8] PCI: brcmstb: Change brcm_phy_stop() to return
 void
Message-ID: <20211111215718.GA1353371@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110221456.11977-2-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 10, 2021 at 05:14:41PM -0500, Jim Quinlan wrote:
> We do not use the result of this function so make it void.

I don't get it.  Can you expand on this?

brcm_phy_cntl() can return -EIO, which means brcm_phy_stop() can
return -EIO, which means brcm_pcie_suspend can return -EIO.
brcm_pcie_suspend() is the dev_pm_ops.suspend() method.

So are you saying we never use the result of dev_pm_ops.suspend()?

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index cc30215f5a43..ff7d0d291531 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1111,9 +1111,10 @@ static inline int brcm_phy_start(struct brcm_pcie *pcie)
>  	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
>  }
>  
> -static inline int brcm_phy_stop(struct brcm_pcie *pcie)
> +static inline void brcm_phy_stop(struct brcm_pcie *pcie)
>  {
> -	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
> +	if (pcie->rescal)
> +		brcm_phy_cntl(pcie, 0);
>  }
>  
>  static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> @@ -1143,14 +1144,13 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  static int brcm_pcie_suspend(struct device *dev)
>  {
>  	struct brcm_pcie *pcie = dev_get_drvdata(dev);
> -	int ret;
>  
>  	brcm_pcie_turn_off(pcie);
> -	ret = brcm_phy_stop(pcie);
> +	brcm_phy_stop(pcie);
>  	reset_control_rearm(pcie->rescal);
>  	clk_disable_unprepare(pcie->clk);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int brcm_pcie_resume(struct device *dev)
> -- 
> 2.17.1
> 
