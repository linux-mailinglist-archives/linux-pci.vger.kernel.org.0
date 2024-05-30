Return-Path: <linux-pci+bounces-8084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2014F8D5000
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 18:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56927284727
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F79A21350;
	Thu, 30 May 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWEshGzs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DE3D3BC
	for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087349; cv=none; b=klSArUJFDxXMp8xPR2fLndScQ1XeyF/f5K28j1ovc/+/tCMlgk2AZvRNrdh4VvS8q+u4/CVp6pVqXvr7BSlJ5v5GmxCDYbSU5ubNybE/rUr9dOM1cAWNlWnENSeGCXDsK+fnca+CjXWZlyxwGSOsmBn1+2ILkgsNe26w62YoqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087349; c=relaxed/simple;
	bh=0dLZR7E5oKp84UdjpgU9+xrQH9dWMGNNbHW3aibuRLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d7NYOiGRwlzIvyCySS9SsANTVccm11zxtG6fNFtsBTQcj9S0p7sqKsUV4sIEkwYzNvQiYZ49NRtn40hLaviuW02RvM6XewNCrZfpKZF/pVjLtCTjLYABxcKydqZDNkfcPDTV9w2YnnRZyvTjJXEtWK7c3OHMT9eKlpGgv5bdc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWEshGzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98529C2BBFC;
	Thu, 30 May 2024 16:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717087348;
	bh=0dLZR7E5oKp84UdjpgU9+xrQH9dWMGNNbHW3aibuRLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OWEshGzsUQnWA7DWaY96TZRjvxcpw45CwlzVYBmCQ9RGabDaYp2eoxQV8tJQOcXzx
	 blLU9+fJH4EC38RQmg8u93Yuf083lfaU46sFwhfLnVlMcbIgkRFJ8l0HpAng2ru2qE
	 XlL+qQSJqXDygXnvdmwXd0RvOdUyyWBW5Sqmv/t2Lk3a0qghcTJQGMbxpjC5DD5ZtD
	 V2LClagvE3xmqphXeBEDCL7ZTm6N7v2CVEQ9LuCIgohD7Q7F8UgJRM1NjqtUBYAn0y
	 Zva8STI9ImMw30THqyGM+EDxhLqM2N+7C9d/TFphujokr6ZBFcGjQcIWCT7fFE4nKF
	 UeQVBxWaS6gVQ==
Date: Thu, 30 May 2024 11:42:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: daire.mcnamara@microchip.com
Cc: conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 7/7] PCI: microchip: Re-partition code between probe()
 and init()
Message-ID: <20240530164226.GA550240@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728131401.1615724-8-daire.mcnamara@microchip.com>

On Fri, Jul 28, 2023 at 02:14:01PM +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Continuing to use pci_host_common_probe() for the PCIe Root Complex on
> PolarFire SoC was leading to an extremely large _init() function and
> some unnatural code flow. Re-partition so some tasks are done in
> a _probe() routine, which calls pci_host_common_probe() and then use a
> much smaller _init() function, mainly to enable interrupts after address
> translation tables are set up.
> ...

> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -384,6 +384,8 @@ static struct {
>  
>  static char poss_clks[][5] = { "fic0", "fic1", "fic2", "fic3" };
>  
> +static struct mc_pcie *port;
> ...

> +static int mc_host_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
>  	void __iomem *bridge_base_addr;
>  	int ret;
>  	u32 val;
> @@ -1112,13 +1141,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);

Saving this per-device pointer in a static singleton is kind of
problematic.  We may know there can only be a single instance right
now, but even if that remains true forever for this driver, we don't
want this pattern to be be copied elsewhere.

I didn't look hard enough to figure out exactly what problem this
singleton solves, but is there any other way to address it?

I suspect it's related to using pci_host_common_probe(), and it's
great to share that code, but it seems like that basically forces some
non-ECAM initialization into the struct pci_ecam_ops.init() method
where it doesn't really fit very well.

Bjorn

