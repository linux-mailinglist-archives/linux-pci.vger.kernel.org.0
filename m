Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453FD122C13
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 13:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfLQMmm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 07:42:42 -0500
Received: from foss.arm.com ([217.140.110.172]:35818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbfLQMml (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 07:42:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DFF531B;
        Tue, 17 Dec 2019 04:42:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D143F718;
        Tue, 17 Dec 2019 04:42:40 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:42:39 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 08/13] PCI: cadence: Use local management register to
 configure Vendor ID
Message-ID: <20191217124238.GE24359@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-9-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-9-kishon@ti.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:42PM +0530, Kishon Vijay Abraham I wrote:
> PCI_VENDOR_ID in root port configuration space is read-only register
> and writing to it will have no effect. Use local management register to
> configure Vendor ID and Subsystem Vendor ID.

Is this a bug fix? Can you add a Fixes tag and make that clearer?

Thanks,

Andrew Murray

> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index cf817be237af..afb2c96a6538 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -71,6 +71,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
>  	u32 value, ctrl;
> +	u32 id;
>  
>  	/*
>  	 * Set the root complex BAR configuration register:
> @@ -90,8 +91,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
>  
>  	/* Set root port configuration space */
> -	if (rc->vendor_id != 0xffff)
> -		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
> +	if (rc->vendor_id != 0xffff) {
> +		id = CDNS_PCIE_LM_ID_VENDOR(rc->vendor_id) |
> +			CDNS_PCIE_LM_ID_SUBSYS(rc->vendor_id);
> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
> +	}
> +
>  	if (rc->device_id != 0xffff)
>  		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
>  
> -- 
> 2.17.1
> 
