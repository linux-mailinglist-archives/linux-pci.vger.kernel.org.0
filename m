Return-Path: <linux-pci+bounces-36813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8094B977DB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 22:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2052A3A42
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BA22E1F06;
	Tue, 23 Sep 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB/fUGeY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6C23FC41;
	Tue, 23 Sep 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659223; cv=none; b=e44l1AZfo5+CAjYxmUUpkKLGzkkhHulbFobU3aPUmvoLhLIpDq6eKuLva6LmcCntLlBmHIHrKpbTG6Wqt40cWkjAdD9KdFQNaOBVf9/ukiQOWlvVGagQpAaFsvf00AtVXCbvSuwxLH/8xKsaHpXuEXdNbh8p8m8wHJc5mFRm4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659223; c=relaxed/simple;
	bh=5R1UgSJEvi2l7Eky/zK0SWAZ6XGW6n1hioaDt4+Pst0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tmFHUcOggF1xFQIgOyzUUR/UYl6kkrFha2SZcAXIeNDqQFHIjxB9fbZUa0M/2O957J7ERUlhCQcNSL+c64x9OkcMOhz72VmsP/NieiMrZ/weK6mouKkuaMtpS20ZkJv7HzXOeqry6nYs6/2fVtlgzTn3qGateJ5TLTNm0H4LF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB/fUGeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF24C4CEF5;
	Tue, 23 Sep 2025 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758659223;
	bh=5R1UgSJEvi2l7Eky/zK0SWAZ6XGW6n1hioaDt4+Pst0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kB/fUGeY9zXTc4xPBZoZWjD3qp6VSnfAqGsuI8BUOqwXv+4EuypaIp/21qo0AezRk
	 yxVGTVgxYyfwkUdl2FiFp958j2mhNZAXdFn9bDGTQGRkv2f5WUjCGuu1WvFY0QsAX8
	 LRzDfs9CAzDu1EUm86IzUyq3T5qbZFi+mod4jpABZNu+LXGCxQCXFDU//T4xBLvY4n
	 SrxWQ8K2rqus9E/6EQ3aUZL4HHVqxfBA6ro9THUrzfwOmLL65Hxk6OQjXrV7Jt+vHh
	 NesA3/VJ1fWliqJLHfSdJDnDDzNKWBbNUwadOp7KOVaq14azf5xBl1x1UyWJ0+X9LZ
	 2Agmeiu2uVyvA==
Date: Tue, 23 Sep 2025 15:27:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/of: Call pci_request_acs() before enumerating
 the Root Port device
Message-ID: <20250923202701.GA2055736@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-pci-acs-v1-2-fe9adb65ad7d@oss.qualcomm.com>

On Wed, Sep 10, 2025 at 11:09:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
> 
> When booting with devicetree, ACS is enabled for all ACS capable PCI
> devices except the first Root Port enumerated in the system. This is due to
> calling pci_request_acs() after the enumeration and initialization of the
> Root Port device. 

I suppose you're referring to a path like below, where we *check*
pci_acs_enable during PCI enumeration, but we don't *set* it until we
add the device and look for a driver for it?

  pci_host_common_init
    devm_pci_alloc_host_bridge
      devm_of_pci_bridge_init
        pci_request_acs
          pci_acs_enable = 1                    # ++ new set here
    pci_host_probe
      pci_scan_root_bus_bridge
        pci_scan_device
          pci_init_capabilities
            pci_enable_acs
              if (pci_acs_enable)               # test here
                ...
      pci_bus_add_devices
        driver_probe_device
          pci_dma_configure
            of_dma_configure
              of_dma_configure_id
                of_iommu_configure
                  pci_request_acs
                    pci_acs_enable = 1          # -- previously set here

> But afterwards, ACS is getting enabled for the rest of the PCI
> devices, since pci_request_acs() sets the 'pci_acs_enable' flag and
> the PCI core uses this flag to enable ACS for the rest of the ACS
> capable devices.

I don't quite understand why ACS would be enabled for *any* of the
devices because we generally enumerate all of them, which includes the
pci_init_capabilities() and pci_enable_acs(), before adding and
attaching drivers to them.

But it does seem kind of dumb that we set the system-wide "enable ACS"
property in a per-device place like an individual device probe.

> Ideally, pci_request_acs() should only be called if the 'iommu-map' DT
> property is set for the host bridge device. Hence, call pci_request_acs()
> from devm_of_pci_bridge_init() if the 'iommu-map' property is present in
> the host bridge DT node. This aligns with the implementation of the ARM64
> ACPI driver (drivers/acpi/arm64/iort.c) as well.
> 
> With this change, ACS will be enabled for all the PCI devices including the
> first Root Port device of the DT platforms.
> 
> Cc: stable@vger.kernel.org # 5.6
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> [mani: reworded subject, description and comment]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/pci/of.c         | 8 +++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 6b989a62def20ecafd833f00a3a92ce8dca192e0..c31369924944d36a3afd3d4ff08c86fc6daf55de 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -141,7 +141,6 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  			.np = master_np,
>  		};
>  
> -		pci_request_acs();
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     of_pci_iommu_init, &info);
>  		of_pci_check_device_ats(dev, master_np);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f119845637e163d9051437c89662762f8..98c2523f898667b1618c37451d1759959d523da1 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -638,9 +638,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>  
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  {
> -	if (!dev->of_node)
> +	struct device_node *node = dev->of_node;
> +
> +	if (!node)
>  		return 0;
>  
> +	/* Enable ACS if IOMMU mapping is detected for the host bridge */
> +	if (of_property_read_bool(node, "iommu-map"))
> +		pci_request_acs();

I'm not really convinced that the existence of 'iommu-map' in
devicetree is a clear signal that ACS should be enabled, so I'm a
little hesitant about this part.

Is it possible to boot using a devicetree with 'iommu-map', but with
the IOMMU disabled or the IOMMU driver not present?  Or other
situations where we don't need ACS?

>  	bridge->swizzle_irq = pci_common_swizzle;
>  	bridge->map_irq = of_irq_parse_and_map_pci;
>  
> 
> -- 
> 2.45.2
> 
> 

