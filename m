Return-Path: <linux-pci+bounces-37599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66689BB908E
	for <lists+linux-pci@lfdr.de>; Sat, 04 Oct 2025 19:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 622323462FB
	for <lists+linux-pci@lfdr.de>; Sat,  4 Oct 2025 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B56222FE10;
	Sat,  4 Oct 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCjJKPd2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B71450FE;
	Sat,  4 Oct 2025 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759599299; cv=none; b=gdwODxE8t9ZXVic7YayrAflk1sT31OQqYjWnhl1PjJP2Flrs3MYOALMxyKbAmnr1/32nhmwkLdTEbfJztoYrw3pxmWzqeGe43xv/zcAsXzj7/0cG90nkrVkcaHVZIzfMT/FOTYJkW569MGNOrY3i6nVcPMWwJ27eNmgiFzmCP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759599299; c=relaxed/simple;
	bh=QrmbzFWdXVjrkXP1XKgkDdSN8NwVcE41VeySN7cDksE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5O68sdoNZFgyP1dr00YTfDjhlbM45aFf4DQj3Ej/TYhbBigP9fl6OS5N288nfmm3A4BlDIu70GxAAbajibnVvq8nmxUraIIB8RPOMR9aRF6077lpzZXayMoWApyIYjlrlLXBWHWA/aeJK98sYnLt6N6AvM8xcrE+vuWAHqBvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCjJKPd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02629C4CEF1;
	Sat,  4 Oct 2025 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759599298;
	bh=QrmbzFWdXVjrkXP1XKgkDdSN8NwVcE41VeySN7cDksE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCjJKPd2kPpbJvaqPjAXAInrSnxBDV5nb0AMICsS9hQMMliN3fJvCdbrmwXy3fIUV
	 ohrVoxpkW+be4EVH/w9nbxZM7Ak/E6/EDK9Lp0NCknVpI1GCETARXpO07wmg2ZpD/+
	 DByXFfpXXyYeZlQkVVLtzRVnyK8TVARObjp8O7/bLifZSMLL3hFAVhw59jraHJGJSU
	 jJr5Bwc/tv5Yfh1bMT1CVVujvmV4wENVMTyccM7ocR9rWZd+tiM8xB2zSxYZLMMv7w
	 gkh7Ny1wYGPxEy8eZ5XMWwF7ZVqYYm7f++8qAjKK70TwSHcLWR4seTowQlJ4Il6NDN
	 EngbGLHwMM0Sg==
Date: Sat, 4 Oct 2025 23:04:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
	Xingang Wang <wangxingang5@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/of: Call pci_request_acs() before enumerating
 the Root Port device
Message-ID: <5f4uclyawwh57u5pdwlk5q36keeg3oyhk5hw42xgnryz6xs7ph@rrkulj4ex2xb>
References: <20250924185750.GA2128243@bhelgaas>
 <b8a871d8-d84b-4c86-8f63-f4e1b2a5fccf@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8a871d8-d84b-4c86-8f63-f4e1b2a5fccf@arm.com>

On Wed, Sep 24, 2025 at 08:49:26PM +0100, Robin Murphy wrote:

[...]

> > I don't doubt that the current code doesn't detect presence or use of
> > IOMMU until later.  But that feels like an implementation defect
> > because logically the IOMMU is upstream of any PCI device that uses
> > it, so architecturally I would expect it to be *possible* to detect it
> > before PCI enumeration.
> > 
> > More to the point, it's not at all obvious how to infer that
> > 'iommu-map' in the devicetree means the IOMMU will be used.
> 
> Indeed, I would say the way to go down that route would be to echo what we
> do for "iommus", and defer probing the entire host controller driver until
> the targets of an "iommu-map" are either present or assumed to never be
> appearing. (And of course an ACPI equivalent for that would be tricky...)
> 

Maybe we should just call pci_enable_acs() only when the iommu is detected for
the device? But ofc, this is not possible for non-OF platforms as they tend to
call pci_request_acs() pretty early.

> However, even that isn't necessarily the full solution, as just as it's not
> really appropriate for PCI to force ACS without knowing whether an IOMMU is
> actually present to make it meaningful, it's also not strictly appropriate
> for an IOMMU driver to request ACS globally without knowing that it actually
> serves any relevant PCIe devices. Even in the ideal scenario, I think the
> point of actually knowing is still a bit too late for the current API
> design:
> 
>   pci_device_add
>     pci_init_capabilities
>       pci_acs_init
>         pci_enable_acs
>     device_add
>       iommu_bus_notifier
>         iommu_probe_device
>           //logically, request ACS for dev here
> 
> (at the moment, iommu_probe_device() will actually end up calling into the
> same of_iommu_configure()->pci_request_acs() path, but the plan is still to
> eventually shorten and streamline that.)
> 

What is worrying me is that of_iommu_configure() is called for each PCI device,
as opposed to just one time on other platforms. But I think that's a good thing
to have as the IOMMU driver can have a per-device ACS policy, instead of a
global one.

> I guess we might want to separate the actual ACS enablement from the basic
> capability init, or at least perhaps just call pci_enable_acs() again after
> the IOMMU notifier may have changed the policy?
> 

Is this applicable to other platforms as well? Not just OF?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

