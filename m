Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB1365A5D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhDTNmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 09:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhDTNmh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 09:42:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CB746113C;
        Tue, 20 Apr 2021 13:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618926126;
        bh=wOcgrREubiHfbL01aIGXmwpp3fzaqzvs0JU635iNdoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=irFkel9vWOajGYsLV90EI0+u5kOkuln2S0r2OVjJi3suCvbtbInNDcbdqoyCewFnM
         iD+YqUluxJqxarPsj2BUrL7TRg/h0LnU8Le5gA80KLFQ44klHL5wz81TvnIy2U0MwZ
         e2KNsO+TkG+4eHjpy+MEXf19+ValtcyxbZsHiSKGkOcUMUupGUuRdTfBULf//2uXNR
         Ht+b3Zb57b+Lpc2amSrOgWOxZgFKHkbpIYeUKT3TOUOEhoadKGx4GRJsjuQtn9ELPU
         fOVNRcFsxl09kLi78h9Gt/kHMZNRPSIgIgwytwI9wnhEEswoLWrff3hhkfMxi6jvS3
         TI/4d+pGnWGYQ==
Date:   Tue, 20 Apr 2021 08:42:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siyu Jin <jinsiyu940203@163.com>
Cc:     linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] Bug fix: 500ms is not enough for pcie training
Message-ID: <20210420134204.GA2811908@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419112218.10921-1-jinsiyu940203@163.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc rockchip maintainers]

On Mon, Apr 19, 2021 at 07:22:18PM +0800, Siyu Jin wrote:

Thanks for this.  Before this can be applied:

- Run "git log --oneline drivers/pci/controller/pcie-rockchip-host.c"
  and make your subject line match in structure and style.

- Add a commit log.  It should explain the problem this fixes.  Since
  this changes a timeout, you should be able to cite something in the
  spec (either the PCIe spec or the Rockchip spec) that describes the
  time needed.

- Add a signed-off-by: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361

- CC the relevant maintainers (use ./scripts/get_maintainer.pl)

> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index f1d08a1b1591..9da831b2b7c2 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -332,7 +332,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	/* 500ms timeout value should be enough for Gen1/2 training */
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
