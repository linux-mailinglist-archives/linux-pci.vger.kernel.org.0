Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE53B95EF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 20:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhGASJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 14:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhGASJw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 14:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 509896140D;
        Thu,  1 Jul 2021 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625162841;
        bh=agtTRmyWXB9kEbONbwNsqiEDAWJkJ50/g6gaMLYdm98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I58Og3y7Xjz/8RFEAADuFy6sVCWZNSgiIrmCizpmoJDPxwIqMT+wUKM+m+/iiT8BS
         28dwwd4IvFnUf63JPpLWE34/6qggR0BJ9SdfXql9FqwuxmcsfFrtAecjEfc+kR05Zy
         bo2vMYPbPACT4FhgEfj1h2Cac78t7q/j3ma2U/tMTOuPJSC62zLwIgZsijU4zotLHt
         IudifaknX8yWr+WDHrGZG1vVpEm5PXZ+nIBTKI9sfkMzqVkbY0XNWU8O6/nSkDdAVG
         qlydlHEDoeadfvjokisfxWAPKxK0ouaGTWGSBevuB47AN8SE6+uSQDtle+AsH0g1Gw
         H8LKiDim+W72Q==
Date:   Thu, 1 Jul 2021 13:07:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siyu Jin <jinsiyu940203@163.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Fix timeout in
 rockchip_pcie_host_init_port()
Message-ID: <20210701180720.GA74228@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421083115.30213-1-jinsiyu940203@163.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 21, 2021 at 04:31:15PM +0800, Siyu Jin wrote:
> In function rockchip_pcie_host_init_port(), it defines a timeout
> value of 500ms to wait for pcie training. However, it is not enough
> for samsung PM953 SSD drive and realtek RTL8111F network adapter,
> which leads to the following errors:
> 
> 	[    0.879663] rockchip-pcie f8000000.pcie: PCIe link training gen1 timeout!
> 	[    0.880284] rockchip-pcie f8000000.pcie: deferred probe failed
> 	[    0.880932] rockchip-pcie: probe of f8000000.pcie failed with error -110

s/pcie/PCIe/ (also below)
s/samsung/Samsung/
s/realtek/Realtek/

Remove the timestamps because they're not useful here.

Indent quoted material like the error messages by two spaces.

When you repost, add these recipients (found by
"./scripts/get_maintainer.pl drivers/pci/controller/pcie-rockchip-host.c"):

  Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
  Shawn Lin <shawn.lin@rock-chips.com>
  Rob Herring <robh@kernel.org>
  Krzysztof Wilczyński <kw@linux.com> (since he commented on this post)

> The pcie spec only defines the min time of training, not the max
> one. So set a proper timeout value is important. Change the value
> to 1000ms will fix this bug.

Can you include the spec reference about where it defines the minimum
training time?

I guess this is actually a Rockchip-specific thing, since I assume
these devices work fine on other systems?  So maybe this is not a PCIe
thing but a Rockchip thing?

> Signed-off-by: Siyu Jin <jinsiyu940203@163.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index f1d08a1b1591..aa42e28b49a8 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -329,10 +329,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  
>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>  
> -	/* 500ms timeout value should be enough for Gen1/2 training */
> +	/* 1000ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
>  				 status, PCIE_LINK_UP(status), 20,
> -				 500 * USEC_PER_MSEC);
> +				 1000 * USEC_PER_MSEC);
>  	if (err) {
>  		dev_err(dev, "PCIe link training gen1 timeout!\n");
>  		goto err_power_off_phy;
> @@ -349,7 +349,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  
>  		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
>  					 status, PCIE_LINK_IS_GEN2(status), 20,
> -					 500 * USEC_PER_MSEC);
> +					 1000 * USEC_PER_MSEC);
>  		if (err)
>  			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
>  	}
> -- 
> 2.17.1
> 
