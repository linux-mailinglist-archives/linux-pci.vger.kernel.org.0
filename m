Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20021152D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgGAVeo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 17:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGAVeo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 17:34:44 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B578620772;
        Wed,  1 Jul 2020 21:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593639284;
        bh=1IXZOrZkYM9neavpCctk0wMLNeZPLPq2m53FYeI7R3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rF3Ewa/DKeKRd7U/VwQDI9QcjPY5MWYOBR0LJpIBp1SLRkn2QT4i7qTZTG07NxK1m
         M8q+xoldII2dJ92U815VFStWbt9B4ALxER1mY7dMl9lJsDDNOWiGAido654S2MhuPr
         dz5UVbYgCqY+bpKJZjkWsv7Vtv7Pagr86fKv0BjQ=
Date:   Wed, 1 Jul 2020 16:34:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200701213442.GA3662456@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701082044.4494-1-pali@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 01, 2020 at 10:20:44AM +0200, Pali Rohár wrote:
> When there is no PCIe card connected and advk_pcie_rd_conf() or
> advk_pcie_wr_conf() is called for PCI bus which doesn't belong to emulated
> root bridge, the aardvark driver throws the following error message:
> 
>   advk-pcie d0070000.pcie: config read/write timed out
> 
> Obviously accessing PCIe registers of disconnected card is not possible.
> 
> Extend check in advk_pcie_valid_device() function for validating
> availability of PCIe bus. If PCIe link is down, then the device is marked
> as Not Found and the driver does not try to access these registers.
> 
> This is just an optimization to prevent accessing PCIe registers when card
> is disconnected. Trying to access PCIe registers of disconnected card does
> not cause any crash, kernel just needs to wait for a timeout. So if card
> disappear immediately after checking for PCIe link (before accessing PCIe
> registers), it does not cause any problems.

Thanks, this is good.  I'd really like a short comment in the code as
well, because this sort of link-up check tends to get copied to new
drivers where it shouldn't be used, e.g., something like this:

  /*
   * If the link goes down after we check for link-up, nothing bad
   * happens but the config access times out.
   */

> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in V2:
> * Update commit message, mention that this is optimization
> ---
>  drivers/pci/controller/pci-aardvark.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 90ff291c24f0..53a4cfd7d377 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -644,6 +644,9 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
>  	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
>  		return false;
>  
> +	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
> +		return false;
> +
>  	return true;
>  }
>  
> -- 
> 2.20.1
> 
