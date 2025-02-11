Return-Path: <linux-pci+bounces-21172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 912EAA31432
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4E47A0FA8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B991E5018;
	Tue, 11 Feb 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG6xjop0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AFE26158B;
	Tue, 11 Feb 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299141; cv=none; b=u0UB3xP9QztjpiVNWHFN+p/8ro2ajetuMrM923/zIGO5+A4c+9roT4SDdh8YWsKenxihgC+lZnbZ0GL/rB510gHT0kqOOSjdxFrfDT8srVMc0rX3hkUxzK32kXBSWWCL8FTCoQfOAXOyf5YckxsIhMph5zI35Q8G4aNK6ETBVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299141; c=relaxed/simple;
	bh=UjPseOykj150ap2A82AXlyzLL7VjyLqfhCLNQl3q9mU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QQFPhTRX+O7ylIwc/9ED7WFcjjZbPgP0a5nx3KnyGX6iPcm1FlAylk7qIiZ8JarLPY6kAXJCvKCOdIFCZIHO6EbOjQAaPGJRr6DkJeDoorB05LxJVhHXvOoQC9OSqouFEPYvJH7GF/6ApCynozwe8mowEcGT5EnL9fGf/petSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG6xjop0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB540C4CEDD;
	Tue, 11 Feb 2025 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739299141;
	bh=UjPseOykj150ap2A82AXlyzLL7VjyLqfhCLNQl3q9mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GG6xjop0+yvkXJXrvVpSh9bybz9GTl+ALhlFqMXVtBTunrlb1LWlRQc7pf4v+dvLO
	 J41AJTxKxWdg8AIpNHgEdMRcA5Klvp6IXxZ2dXklOfiho1JCBlw0iQd8hIo4qbf4la
	 CKrbTKH5yr8mQO/NnMVkIWSHFBN8budFN+9OxATFuOAe86akTLvg8GumJsX6O3EYYl
	 HP0PNCN/CqUCfeZnkOkl2x3B+k62K+2oM8/F7h2UUH5oC4/jhawoV5yfvpzZ98ghKg
	 7OoRSyOdtePRljCUHaGx6sM1K6GsbRrDpkFxsr+U4TJcMw1ZtuF9jqC6laFAYLvfQC
	 7Ml7rCUZwblBA==
Date: Tue, 11 Feb 2025 12:38:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Janne Grunau <j@jannau.net>
Subject: Re: [PATCH] PCI: apple: Add depends on PAGE_SIZE_16KB
Message-ID: <20250211183859.GA51030@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-pci-16k-v1-1-7fc7b34327f2@rosenzweig.io>

On Tue, Feb 11, 2025 at 01:03:52PM -0500, Alyssa Rosenzweig wrote:
> From: Janne Grunau <j@jannau.net>
> 
> The iommu on Apple's M1 and M2 supports only a page size of 16kB and is
> mandatory for PCIe devices. Mismatched page sizes will render devices
> useless due to non-working DMA. While the iommu prints a warning in this
> scenario, it seems a common and hard to debug problem, so prevent it at
> build-time.

Can we include a sample iommu warning here to help people debug this
problem?

> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>  drivers/pci/controller/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 9800b768105402d6dd1ba4b134c2ec23da6e4201..507e6ac5d65257578e4eec74b459f6605c9c2907 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -39,6 +39,7 @@ config PCIE_APPLE
>  	depends on ARCH_APPLE || COMPILE_TEST
>  	depends on OF
>  	depends on PCI_MSI
> +	depends on PAGE_SIZE_16KB || COMPILE_TEST
>  	select PCI_HOST_COMMON
>  	help
>  	  Say Y here if you want to enable PCIe controller support on Apple
> 
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250211-pci-16k-4c391a5dcd18
> 
> Best regards,
> -- 
> Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 

