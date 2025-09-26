Return-Path: <linux-pci+bounces-37140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B15BA532B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F993B3F75
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D7280338;
	Fri, 26 Sep 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9ANDHgy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2581ACA;
	Fri, 26 Sep 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921921; cv=none; b=RJgYR+azV4jA7AYZ8YawTNw9Pzq4u2mmnLjCzBOoH52eaCAya+KRTgvSPEkAcpkSvnxiUgZz7PEkgeX4DsdnYwFWH7Th6Y1VEXTC7eCFTirrtB/v686WTogq9e6+Vl6BNPwvBze1PTdgrP7+hwqMHNga6/qiHOHBOtdJAOKyrgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921921; c=relaxed/simple;
	bh=PQumnt7XyXrVYC0j2mqUHUvbODDCGmvh8dmipPDpD7o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RRMWyB5Md3z88xd18XgyBENj+mEWclrGg28RXS70p7F4PaAqcvpmn/OV4Zx2pry2zxifD9+74KWmEeIDwBoO7hUqwSdimsfEejO23oP4lSFN0HLnzCZ73GgRhtqEyzQh72AASDBo9LBld0BwO4jbv6iEYEWTa1lgs70z7lC35TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9ANDHgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15B4C4CEF4;
	Fri, 26 Sep 2025 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758921921;
	bh=PQumnt7XyXrVYC0j2mqUHUvbODDCGmvh8dmipPDpD7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t9ANDHgyhv0ECBteSk6v9OQDSzqchAwI26CuEpIlcgrTJPfqA3gjwDp54B7Pkq56T
	 gX8pE5rN8XWYHRdh9WoNdzgzAZLLZLRb0/BhI9TUGnhJZ8Rnp+Zbl0oq7MtrSttBap
	 /85PM93NuKCnaeaLpeJzFL3UuGctNgWCJKSgV8+BUZY2JVX4vdqWNHtkkfb27xJCOF
	 IfGgdyuWZ7BXaTAeFOSWMmNWtd9oKXidcKmHM6nFdcScB/u0ERfk/k/K5zGy0pvjv9
	 vdEu4VAz6kzpbWoVbo+1qZDS5t0JK7u5iBk+IBVvHr64OeB9RzBeaVYs3LigM930hI
	 cChXC1+T2nI4Q==
Date: Fri, 26 Sep 2025 16:25:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 2/3] cpuidle: tegra: Export
 tegra_cpuidle_pcie_irqs_in_use
Message-ID: <20250926212519.GA2268653@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-pci-tegra-module-v7-2-cad4b088b8fb@gmail.com>

[cc->to: Rafael, Daniel, any feedback or ack?  Would like to resolve
this (part of Aaron's series at
https://lore.kernel.org/r/20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com)]

On Thu, Jul 31, 2025 at 04:59:25PM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Add export for tegra_cpuidle_pcie_irqs_in_use() so that drivers like
> pci-tegra can be loaded as a module.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-tegra.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index b203a93deac5f378572be90e22c73e7417adb99e..aca907a62bb5de4ee4c71c1900eacedd4b90bc0a 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -336,6 +336,7 @@ void tegra_cpuidle_pcie_irqs_in_use(void)
>  	pr_info("disabling CC6 state, since PCIe IRQs are in use\n");
>  	tegra_cpuidle_disable_state(TEGRA_CC6);
>  }
> +EXPORT_SYMBOL_GPL(tegra_cpuidle_pcie_irqs_in_use);

tegra_cpuidle_pcie_irqs_in_use() looks like a workaround for a Tegra20
hardware defect, and having no knowledge of typical Tegra20 systems,
my questions would be "Why do we even bother with this?  Should
cpuidle-tegra.c just disable CC6 always, unconditionally?  The whole
thing, and all of include/soc/tegra/cpuidle.h, looks like it might be
more trouble than it's worth."

Bjorn

