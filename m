Return-Path: <linux-pci+bounces-6690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC89A8B3785
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 14:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4331C21660
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFCD146A87;
	Fri, 26 Apr 2024 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctkGUOGd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65883145B0D;
	Fri, 26 Apr 2024 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136064; cv=none; b=NjIrFlzfN8AqDZ/fGQrp04r4ZLDfBer0cIXaajHzojAZnA6E0hq7HqOl5qgf6Wfd9L5oKlhX/qFQCGE2xkJ/BdOlaMTon4BSyj0WAt995d3Yw8WyeZ2yA50QXSoM0QLHhN8kaAzp9Qaqtwe9+wIMH0gcgTl2CQMhUIO2FR8X6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136064; c=relaxed/simple;
	bh=DPENCEemGcuwngQHS5gjSGOwgLntDWYjDhwGkvHF7n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6U3/QqqFQoTBw2HL6qFApy/DcAO3g54FzeF6BKWPP+7Cgd5HoVWq3lRxa+detd9cYF5Wm6AGIbl7G8AtjtZb/JFTheBN/0onNEmHi69FjuNYYSsO+yRLTwm7pyd5JhPdUk8TbpRXGJZfL2mMBBb/mQTBEh9NHjjn6i8THU+3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctkGUOGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7735C113CD;
	Fri, 26 Apr 2024 12:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714136063;
	bh=DPENCEemGcuwngQHS5gjSGOwgLntDWYjDhwGkvHF7n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctkGUOGd7nyrdMI2Q/lEHL3Fx0SMBMZ63qqRtsrR1Qa0CcLW+3BhNuEMF0Ekb6S4z
	 CH5l1ScKWr5+3sSOESaiCii+th7lH8Ym9asmF0UTbhPX4MN5T8tG1qoYujcD5v7ROZ
	 GlLQ3MdaUBqD/7q5q4mABw3WEizfKJxB37WqDYmoGqed3emzJITXP+o3P9u9oIR+Vo
	 CXz4dhGjzZ6LWsHXJUlyAbQDizXm+Z/j5ka616R6rO3HwKP4UQr3UeQ9c1aaEKRx5a
	 GR4rOK4R5wa3UW/DMwtd2aT5N/m7MsfLI6qjvmxZ2jbU1KhRX3/YtubdD6dwttO8tG
	 WuwUmmSnew+3A==
Date: Fri, 26 Apr 2024 14:54:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH] PCI: tegra194: Set address alignment for endpoint mode
Message-ID: <Ziuj-mSFQ8xPutXX@ryzen.lan>
References: <20240426122731.42499-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426122731.42499-1-jonathanh@nvidia.com>

On Fri, Apr 26, 2024 at 01:27:31PM +0100, Jon Hunter wrote:
> Tegra194 and Tegra234 devices require that the endpoint address is
> aligned on a 64kB boundary and therefore, set the endpoint address
> alignment to 64kB in the Tegra194 PCIe driver.

Hello Jon,

While I think the change in this patch looks good,
I think you need to rephrase your commit message.

The 'align' of pci_epc_features represents inbound ATU constraints.
(So for BAR access.)
See Kishon reply at:
https://lore.kernel.org/linux-pci/dccb87db-d826-43fa-a499-cf36ea9b10d5@amd.com/T/#m7697d1d745d8499fc6b8db855b7f93dafd7ed5b3


Kind regards,
Niklas

> 
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 93f5433c5c55..4537313ef37a 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2015,6 +2015,7 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
>  	.bar[BAR_3] = { .type = BAR_RESERVED, },
>  	.bar[BAR_4] = { .type = BAR_RESERVED, },
>  	.bar[BAR_5] = { .type = BAR_RESERVED, },
> +	.align = SZ_64K,
>  };
>  
>  static const struct pci_epc_features*
> -- 
> 2.34.1
> 

