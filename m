Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DBC4845B2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiADP5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:57:48 -0500
Received: from foss.arm.com ([217.140.110.172]:33186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232467AbiADP5s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jan 2022 10:57:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75A0613A1;
        Tue,  4 Jan 2022 07:57:47 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 751FA3F774;
        Tue,  4 Jan 2022 07:57:46 -0800 (PST)
Date:   Tue, 4 Jan 2022 15:57:41 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: keystone: Add quirk to mark AM654 RC BAR
 flag as IORESOURCE_UNSET
Message-ID: <20220104155741.GA28358@lpieralisi>
References: <20211126083119.16570-1-kishon@ti.com>
 <20211126083119.16570-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126083119.16570-5-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 26, 2021 at 02:01:18PM +0530, Kishon Vijay Abraham I wrote:
> AM654 RootComplex has a hard coded 64 bit BAR of size 1MB and also has
> both MSI and MSI-X capability in it's config space. If PCIEPORTBUS is
> enabled, it tries to configure MSI-X and msix_mask_all() adds about 10
> Second boot up delay when it tries to write to undefined location.
> 
> Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET so that
> msix_map_region() returns NULL for Root Complex and avoid un-desirable
> writes to MSI-X table.

I don't think this is the right fix (it is not even a fix, just a
plaster to workaround an issue).

What do you mean by "writing to an undefined location" ?

What does "a hard coded BAR" mean ?

What happens if we _rightly_ write into it (ie to size it) ?

Lorenzo

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 52d20fe17ee9..73e6626a0d8f 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -557,8 +557,14 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>  		{ 0, },
>  	};
>  
> -	if (pci_is_root_bus(bus))
> +	if (pci_is_root_bus(bus)) {
>  		bridge = dev;
> +		if (pci_match_id(am6_pci_devids, bridge)) {
> +			struct resource *r = &dev->resource[0];
> +
> +			r->flags |= IORESOURCE_UNSET;
> +		}
> +	}
>  
>  	/* look for the host bridge */
>  	while (!pci_is_root_bus(bus)) {
> -- 
> 2.17.1
> 
