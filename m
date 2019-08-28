Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3856BA0C30
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 23:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH1VJr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 17:09:47 -0400
Received: from foss.arm.com ([217.140.110.172]:36394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1VJr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 17:09:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B8A6337;
        Wed, 28 Aug 2019 14:09:46 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4B6D3F718;
        Wed, 28 Aug 2019 14:09:45 -0700 (PDT)
Date:   Wed, 28 Aug 2019 22:09:44 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/5] PCI: armada8x: Properly handle optional PHYs
Message-ID: <20190828210943.GE14582@e119886-lin.cambridge.arm.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828163636.12967-3-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 06:36:34PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> devm_of_phy_get_by_index() can fail for a number of resides besides
> probe deferral. It can for example return -ENOMEM if it runs out of
> memory as it tries to allocate devres structures. Propagating only
> -EPROBE_DEFER is problematic because it results in these legitimately
> fatal errors being treated as "PHY not specified in DT".
> 
> What we really want is to ignore the optional PHYs only if they have not
> been specified in DT. devm_of_phy_get_by_index() returns -ENODEV in this
> case, so that's the special case that we need to handle. So we propagate
> all errors, except -ENODEV, so that real failures will still cause the
> driver to fail probe.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 3d55dc78d999..49596547e8c2 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -118,11 +118,10 @@ static int armada8k_pcie_setup_phys(struct armada8k_pcie *pcie)
>  
>  	for (i = 0; i < ARMADA8K_PCIE_MAX_LANES; i++) {
>  		pcie->phy[i] = devm_of_phy_get_by_index(dev, node, i);
> -		if (IS_ERR(pcie->phy[i]) &&
> -		    (PTR_ERR(pcie->phy[i]) == -EPROBE_DEFER))
> -			return PTR_ERR(pcie->phy[i]);
> -
>  		if (IS_ERR(pcie->phy[i])) {
> +			if (PTR_ERR(pcie->phy[i]) != -ENODEV)
> +				return PTR_ERR(pcie->phy[i]);
> +

Once you've applied Bjorn's feedback you can add:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

>  			pcie->phy[i] = NULL;
>  			continue;
>  		}
> -- 
> 2.22.0
> 
