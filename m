Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1476572153
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2019 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfGWVLH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 17:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbfGWVLH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jul 2019 17:11:07 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCB42238C;
        Tue, 23 Jul 2019 21:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563916266;
        bh=AoX+WdU4hi3SajaebzX866AE/L77/H0R0yqjY+Ea8rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HsYtcMuBXAY+b91QM5TYQxf9CTW6rX5KYSJYp2MVp4mrFlCDwNRrYnDjvWeTZkPyN
         YDTepnXtw5MPUYipFfNkX21sIogmAkC6m2HzYRPTH1/jzaWjAJ7XMv00ipFCxaTKO5
         S6pguh4v7xsVrff/Ne48m2US9b9OXej/42mpAsqQ=
Date:   Tue, 23 Jul 2019 16:11:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: controller: pci-tegra: Add of_node_put() before
 return
Message-ID: <20190723211102.GA9742@google.com>
References: <20190716054047.2671-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716054047.2671-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the fix!

Please pay attention to the subject line convention and make yours
match, e.g.,

  $ git log --oneline drivers/pci/controller/pci-tegra.c  | head -5
  7be142caabc4 PCI: tegra: Enable Relaxed Ordering only for Tegra20 & Tegra30
  4b16a8227907 PCI: tegra: Change link retry log level to debug
  dbdcc22c845b PCI: tegra: Add support for GPIO based PERST#
  2d8c7361585f PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
  adb2653b3d2e PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of SoC struct

I think this actually fixes a *reference* leak (not a memory leak as
you say below).  The subject line should mention that.  We can tell by
looking at the patch that it adds of_node_put(); the subject and
commit log should tell us *why*.

On Tue, Jul 16, 2019 at 11:10:47AM +0530, Nishka Dasgupta wrote:
> Each iteration of for_each_child_of_node puts the previous node, but in
> the case of a return from the middle of the loop, there is no put, thus
> causing a memory leak.
> Hence store these mid-loop return values in variable err and add a new
> label err_node_put which puts the previous node and returns err. Change
> six mid-loop return statements to point to this new label instead.

This sort of looks like two paragraphs and sort of looks like one.
Please either rewrap it so it's clearly one paragraph, or add a blank
line so it's clearly two paragraphs.

s/for_each_child_of_node/for_each_child_of_node()/
(as you already did for of_node_put() in the subject, thanks for that)

> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
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
