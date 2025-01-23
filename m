Return-Path: <linux-pci+bounces-20292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC16A1A81F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 17:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6957A22ED
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B51448C7;
	Thu, 23 Jan 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS2LwihU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEDD13FD83;
	Thu, 23 Jan 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650986; cv=none; b=MqZ0o9bHjj1z/yaBtENjWnF5seKf6WnF1RB7J8puPTbgsrp76kuNyEN/pUyg/gKmTI+VGeOZWsC8uetCIKh6Kg/cjemtI3P5/kRpQZZGeh/TXXhzs+DbpSHms5mBu105e8X690E8FGwPrtgLBuhZMakQINpDoJwQDUDNsirjxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650986; c=relaxed/simple;
	bh=if5XEYf8bEzYx6h8ieIdLzxVQFF3QB0ZViaZLrzU4Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X2gjSgbcCEmHPlFG0ZzR8B6HlRNAs08O23mCDFEhtIpjttwU0JJxUv+N4vAErnzWdGpnwmxhIVp344Pk5P/riplx46yuYFRdyigDnzTuQ0wqacPSD6+3TBxwExCdKRs1CSvYoO+JykQl7qJySIvlrp7GF6P6pRelfCYU9oA6fxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS2LwihU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E045C4CED3;
	Thu, 23 Jan 2025 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737650986;
	bh=if5XEYf8bEzYx6h8ieIdLzxVQFF3QB0ZViaZLrzU4Mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QS2LwihU+ZZeQDh7W8SbUgCnlvJ8LrDlmlFMgkeg4WPGbIvNrA1lKl8/QNlbSsGDs
	 6A78SoldIZLHFGppESWD+M6ieUqzwGXKNwV5qAXh/LcB6TUVtcCLBV4BtvvYvRNiiY
	 Wz2ggALvjVO/Wyu0iYRcVGXceMuVdvpir97OQFUZ4l6/ysxFOBSdvdMLk1QPgqGBqv
	 aYhbiZDpcmjh8Z7XjWqrLzGcuG8NXlaOCpc+eo2DwyDnIPa3KA6dtln6Q79Bf0xF9U
	 594GVewKLMnl675OF44CKdUIvquR8ZZNDpPUCZFQuwr0CZrpKOon1vWKzlnN2NiJ3W
	 xpIeLpcnjeDlA==
Date: Thu, 23 Jan 2025 10:49:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [PATCH] PCI: dwc: Add the sysfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <20250123164944.GA1223935@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123071326.1810751-1-18255117159@163.com>

On Thu, Jan 23, 2025 at 03:13:26PM +0800, Hans Zhang wrote:
> Add the sysfs property to provide a view of the current link's LTSSM
> status from the root port device.
> 
>   /sys/bus/pci/devices/<dev>/ltssm_status

Would need a rationale, i.e., what benefit this provides.  Obviously
this is currently only implemented for DWC-based controllers and
probably not ever available for ACPI or other generic host bridges.

Also documentation somewhere in
Documentation/ABI/testing/sysfs-bus-pci*.

LTSSM is applicable to all Downstream Ports, including both Root Ports
and Switch Downstream Ports, but in general I doubt this information
is available for Switches in any generic way.

> +++ b/drivers/pci/pci-sysfs.c
> @@ -1696,6 +1696,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>  #endif
>  #ifdef CONFIG_PCIEASPM
>  	&aspm_ctrl_attr_group,
> +#endif
> +#ifdef CONFIG_PCIE_DW_HOST
> +	&dw_ltssm_status_attr_group,
>  #endif

I'm not convinced of the value of potentially dozens of device- or
vendor-specific additions like this.

Bjorn

