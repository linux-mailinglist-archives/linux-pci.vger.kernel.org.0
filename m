Return-Path: <linux-pci+bounces-5352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F0890861
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737A21C2124D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876701369AC;
	Thu, 28 Mar 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7wY2/Sl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB42131753;
	Thu, 28 Mar 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650745; cv=none; b=EBmGxceWwtdDtqX/Dbsa1virHZI5GEOWkUjMVi0gYwHooLQew6xlA0BqIFA5MRmmveya2ikWnjMoJUN/T9Z85RIaJ8w0YQdEhdCw+hNd9knKtSRFNRE/V7LTPZVIrwv16weIcFncLBdKQiWQs+8PHpJS7UMCEdnX4OAgNZ0/a5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650745; c=relaxed/simple;
	bh=hg6PwlbaPT4C5AHUB1lGhPAl6f+A+kPebtQkzZI08ys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qD91vw4jcKjAUH5/7rEDlhkvXxd4TJ+1C0ZKIste5LLh9T7qMGdMVFnUDBSxhfd0FklE3vdqVgqRE8cTdjv2P3O8rj+Amq6zgQu8SPJqE6x/NZExy7FC9wcAYp2I7rmbpMSsNbvZ5tU8M3X3GNCUVd5QLsyqZvsSPERHLoefGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7wY2/Sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AA2C433C7;
	Thu, 28 Mar 2024 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711650744;
	bh=hg6PwlbaPT4C5AHUB1lGhPAl6f+A+kPebtQkzZI08ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g7wY2/Slf5uIyl47Rc/xg17pM4iEw1CCbZWM3zZmUqEretMUP40JBjp3VGuaEE+80
	 eJb2SpPGJsjFFD8ilbj2EDoNn2wD6O1znQyUZwM1onts0sUfLT2OD2NoN3ImC9H4Vy
	 2wG6WO05IA/s4PU89r2q2VPlbLq3OEd/4AWs8w/npIvzVpyLKSgVpzNHZS6aRowJoE
	 13ELyfO83HegHr8AJ/jQfIkdFqKAJB7XFZgiQhODc0HBTr5wSL2f3XG2MrdF4aOOeO
	 J+BcI5S3Iinl0jWiCvygkcEpEglKw6en4fcnfR5ypO4+ZQC2alOEZCj3lMuMNWaK6h
	 alSETf9sipEWA==
Date: Thu, 28 Mar 2024 13:32:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Jonathan Chocron <jonnyc@amazon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI: dwc: Fix potential NULL dereference
Message-ID: <20240328183223.GA1575271@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328180126.23574-1-amishin@t-argos.ru>

The subject line should be:

  PCI: al: ...

since this fix is specific to the "al" driver, not generic to "dwc".

On Thu, Mar 28, 2024 at 09:01:26PM +0300, Aleksandr Mishin wrote:
> In al_pcie_config_prepare() resource_list_first_type() may return
> NULL which is later dereferenced. Fix this bug by adding NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/pci/controller/dwc/pcie-al.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
> index 6dfdda59f328..29bc99d48295 100644
> --- a/drivers/pci/controller/dwc/pcie-al.c
> +++ b/drivers/pci/controller/dwc/pcie-al.c
> @@ -252,7 +252,12 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
>  	u8 secondary_bus;
>  	u32 cfg_control;
>  	u32 reg;
> -	struct resource *bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
> +
> +	struct resource_entry *ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS); 
> +	if (!ft)
> +		return;

I don't think this is right.  If we don't have an IORESOURCE_BUS
resource and we just silently return here, we will not write the
CFG_CONTROL register.  It looks essential that CFG_CONTROL be set, so
if we can't do that, the .probe() should fail.

But I think we are actually guaranteed that there is an IORESOURCE_BUS
resource because this path fabricates one if the "bus-range" DT
property doesn't exist:

 al_pcie_probe
    dw_pcie_host_init
      devm_pci_alloc_host_bridge
        devm_of_pci_bridge_init
          pci_parse_request_of_pci_ranges
            devm_of_pci_get_host_bridge_resources
              err = of_pci_parse_bus_range
                if (err)
                  bus_range->flags = IORESOURCE_BUS  # <--

I wouldn't necessarily object to doing something like other drivers
do:

  gen_pci_init
    bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
    if (!bus)
      return ERR_PTR(-ENODEV);

  xilinx_cpm_pcie_probe
    bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
    if (!bus)
      return -ENODEV;

But it would have to lead to .probe() failing, not just a silent
skipping of CFG_CONTROL setup.

> +	struct resource *bus = ft->res;
>  
>  	target_bus_cfg = &pcie->target_bus_cfg;
>  
> -- 
> 2.30.2
> 

