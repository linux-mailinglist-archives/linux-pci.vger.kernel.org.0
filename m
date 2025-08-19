Return-Path: <linux-pci+bounces-34270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420D9B2BDF1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F46C524C0D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA731987E;
	Tue, 19 Aug 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t0sru7cj"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA726560A;
	Tue, 19 Aug 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596968; cv=none; b=CGXSi5rvclIDPyroVC5OEclW8cCLAusRWwwaQUBL+0rZlmxNFy2N51g9s/A71EYjXJGKeq4JZNNFISg9eCYNvQWNVyJtLOXWZQ0b1kkJGnkzM2aaCHzHHaVKGqsz1zO1P8b1Fkta6gOYUltNDpn2s3w2I+hYGlVI3PiEjXYxTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596968; c=relaxed/simple;
	bh=QmsCU85exE8ivGxqjNzmk5Y7YhtnUXRXvatQtTn7XnQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7ZNeo/LUdDGrV4ZhHFrjcebkXmapTS0HYbsdTPqgoMMzqvxohrkxySLc9fgtFVqcxEjE+rXg04V/hOK85mW30h/aM4Md4PioGuDVURrrDQORd9+CX0eOmIik3Lwi2ESpRZTBJXKgepuLYNce+5ogd8OYH7qpxOv3QJ02hRlIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t0sru7cj; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57J9nFLA3286514;
	Tue, 19 Aug 2025 04:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755596955;
	bh=wlRI//KB0EuOY+l24O2uC3n8/OTg+wh6L9BOMvOPHYw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=t0sru7cj+g8lkQHQvUVWaDgI/jzjKJkXCl8Y+YUTBlbEkgDdyqRR/GDnxmxEfG/RL
	 eMPFj91lA2m0rwZcd10h5Abb0Pp+/CrmMAbSolnBXiXXBr493e2euwa/CZCNjI9+19
	 KLSPNqznqbMQgaXFSDsa1ekN/y0sqw3TTXzKbh6I=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57J9nFCJ318273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 04:49:15 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 04:49:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 04:49:15 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57J9nDfu2523075;
	Tue, 19 Aug 2025 04:49:14 -0500
Date: Tue, 19 Aug 2025 15:19:13 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam
	<mani@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>,
        Kishon Vijay
 Abraham I <kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Hans Zhang
	<18255117159@163.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: keystone: Use kcalloc() instead of kzalloc()
Message-ID: <f5fb6c50-7576-4b75-bbed-7989f4718daf@ti.com>
References: <20250819085917.539798-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250819085917.539798-1-rongqianfeng@vivo.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Aug 19, 2025 at 04:59:15PM +0800, Qianfeng Rong wrote:

Hello,

> Replace calls of devm_kzalloc() with devm_kcalloc() in ks_pcie_probe() for
> safer memory allocation with built-in overflow protection.

Please add more details by referring to:
https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
and stating that multiplication could lead to an overflow and isn't safe
when it is used to calculate the size of allocation.

> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 7d7aede54ed3..3d10e1112131 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1212,11 +1212,11 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		num_lanes = 1;
>  
> -	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
> +	phy = devm_kcalloc(dev, num_lanes, sizeof(*phy), GFP_KERNEL);
>  	if (!phy)
>  		return -ENOMEM;
>  
> -	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
> +	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
>  	if (!link)
>  		return -ENOMEM;

Regards,
Siddharth.

