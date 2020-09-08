Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320FB260F2E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 12:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgIHKCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 06:02:40 -0400
Received: from foss.arm.com ([217.140.110.172]:51070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgIHKCj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 06:02:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C2E31B;
        Tue,  8 Sep 2020 03:02:38 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F03FF3F66E;
        Tue,  8 Sep 2020 03:02:37 -0700 (PDT)
Date:   Tue, 8 Sep 2020 11:02:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Fix bus checks in
 rockchip_pcie_valid_device()
Message-ID: <20200908100231.GA22909@e121166-lin.cambridge.arm.com>
References: <20200904140904.944-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904140904.944-1-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 03:09:04PM +0100, Lorenzo Pieralisi wrote:
> The root bus checks rework in:
> 
> commit d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")
> 
> caused a regression whereby in rockchip_pcie_valid_device() if
> the bus parameter is the root bus and the dev value == 0 the
> function should return 1 (ie true) without checking if the
> bus->parent pointer is a root bus because that triggers a NULL
> pointer dereference.
> 
> Fix this by streamlining the root bus detection.
> 
> Fixes: d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")
> Reported-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Hi Bjorn,

this is a fix for a patch we merged in the last merge window, can
we send it for one of the upcoming -rcX please ?

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 0bb2fb3e8a0b..9705059523a6 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -71,16 +71,13 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
>  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>  				      struct pci_bus *bus, int dev)
>  {
> -	/* access only one slot on each root port */
> -	if (pci_is_root_bus(bus) && dev > 0)
> -		return 0;
> -
>  	/*
> -	 * do not read more than one device on the bus directly attached
> +	 * Access only one slot on each root port.
> +	 * Do not read more than one device on the bus directly attached
>  	 * to RC's downstream side.
>  	 */
> -	if (pci_is_root_bus(bus->parent) && dev > 0)
> -		return 0;
> +	if (pci_is_root_bus(bus) || pci_is_root_bus(bus->parent))
> +		return dev == 0;
>  
>  	return 1;
>  }
> -- 
> 2.26.1
> 
