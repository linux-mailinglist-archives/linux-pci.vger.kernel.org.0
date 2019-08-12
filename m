Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21EE89C4A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfHLLFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 07:05:48 -0400
Received: from foss.arm.com ([217.140.110.172]:48528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfHLLFr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 07:05:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6A0915AB;
        Mon, 12 Aug 2019 04:05:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0851F3F706;
        Mon, 12 Aug 2019 04:05:45 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:05:43 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Add of_node_put() before return to fix
 reference leak
Message-ID: <20190812110543.GC20861@e121166-lin.cambridge.arm.com>
References: <20190724082412.9943-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724082412.9943-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 24, 2019 at 01:54:12PM +0530, Nishka Dasgupta wrote:
> Each iteration of for_each_child_of_node() puts the previous node, but
> in the case of a return from the middle of the loop, there is no put,
> thus causing a reference leak.
> 
> Hence store these mid-loop return values in variable err and add a new
> label err_node_put which puts the previous node and returns err. Change
> six mid-loop return statements to point to this new label instead.
> 
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
> Changes in v2: 

If you are sending a v2 make it explicit in the patch $SUBJECT and send
the patch --in-reply-to=<message-ID-previous-version> otherwise *I* have
to fish out of mailing lists previous patches to understand what you are
doing.

> - Edit subject line to better reflect changes and match other patches on
>   this driver.
> - Edit commit message for readability and accuracy.
> 
>  drivers/pci/controller/pci-tegra.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Applied to pci/tegra, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 9a917b2456f6..673a1725ef38 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2237,14 +2237,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		err = of_pci_get_devfn(port);
>  		if (err < 0) {
>  			dev_err(dev, "failed to parse address: %d\n", err);
> -			return err;
> +			goto err_node_put;
>  		}
>  
>  		index = PCI_SLOT(err);
>  
>  		if (index < 1 || index > soc->num_ports) {
>  			dev_err(dev, "invalid port number: %d\n", index);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto err_node_put;
>  		}
>  
>  		index--;
> @@ -2253,12 +2254,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		if (err < 0) {
>  			dev_err(dev, "failed to parse # of lanes: %d\n",
>  				err);
> -			return err;
> +			goto err_node_put;
>  		}
>  
>  		if (value > 16) {
>  			dev_err(dev, "invalid # of lanes: %u\n", value);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto err_node_put;
>  		}
>  
>  		lanes |= value << (index << 3);
> @@ -2272,13 +2274,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		lane += value;
>  
>  		rp = devm_kzalloc(dev, sizeof(*rp), GFP_KERNEL);
> -		if (!rp)
> -			return -ENOMEM;
> +		if (!rp) {
> +			err = -ENOMEM;
> +			goto err_node_put;
> +		}
>  
>  		err = of_address_to_resource(port, 0, &rp->regs);
>  		if (err < 0) {
>  			dev_err(dev, "failed to parse address: %d\n", err);
> -			return err;
> +			goto err_node_put;
>  		}
>  
>  		INIT_LIST_HEAD(&rp->list);
> @@ -2330,6 +2334,10 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		return err;
>  
>  	return 0;
> +
> +err_node_put:
> +	of_node_put(port);
> +	return err;
>  }
>  
>  /*
> -- 
> 2.19.1
> 
