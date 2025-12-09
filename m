Return-Path: <linux-pci+bounces-42863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 133EACB0DBC
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 19:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02CB23014103
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570B6302769;
	Tue,  9 Dec 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw0bblF9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666A22A7E4;
	Tue,  9 Dec 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765305611; cv=none; b=TLsOzOaLiaKHwauDGHCabxNrzPiZtpFWkwK215hEZzhMVXmSadYGjVG8g3d9F26/t5cfluTqG5wxQPVsPXKhwHScvxSXs3m0XeM0CPzvwdTaxvjjHbB/n8M40aaFEb4m/Vwq3wR86rEtBTuoMbF5hPKzRox9KIH5izbEEGFAh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765305611; c=relaxed/simple;
	bh=mAAQ2XEU3FJSJ42Ec76LqZ8Hpt6mlQDTicz+AuY7Qho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HNhcAFc2DeBe9xdEXt7pzxOJwQ9pCM5QOwfBfIV120UACScQjY9ovksbGoL9kxLcMIAZa5ilDw8hx0Ef2PU5Vjhgtshvn2KKKxbdvnK+A+E7rvCFLF5y0dYu+IUZub7x8F5x5R1JcmZxXUcC/wAyxlUWY9OTNwjFMR6LkotqZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw0bblF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF4CC4CEF5;
	Tue,  9 Dec 2025 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765305610;
	bh=mAAQ2XEU3FJSJ42Ec76LqZ8Hpt6mlQDTicz+AuY7Qho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Rw0bblF9LKzUTuJGsLZ5iws9Tne0Y1C69K2WtY2wIoYZwgW5XDSck+OUoCBa4gTOq
	 7PhAvdg/dYqEq6BC/EdsniDtDZ4/Wm0xfBuL9aFhIjJ4Y0b3pVSBMMivWLTtPmwOHq
	 yuefPlUx7vmU9uRU72JzC/4ib8E38O3Q+DNJvhVyqsJARLOoPprXpzv1MJTdyydswa
	 +Wo49Fghg84J8vneiQxygttADx6cq5v+65fIta4pTW5rGnlREwUJuvgnHXbQGCR3yp
	 ynFwOJWXvlIt0GMGTJzcC/Dnj6CP+u2wpbkUsNUnFNEUDKIpcYJvlydhBbF2QXd+27
	 FbMj6dMy942kg==
Date: Tue, 9 Dec 2025 12:40:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: webgeek1234@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/3] PCI: tegra: Allow building as a module
Message-ID: <20251209184009.GA3471346@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com>

On Thu, Jul 31, 2025 at 04:59:23PM -0500, Aaron Kling via B4 Relay wrote:
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v7:
> - Rebased on 6.16
> - Updated mailing address list
> - Link to v6: https://lore.kernel.org/r/20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com
> 
> Changes in v6:
> - Remove unused debugfs cleanup function, as caught by kernel ci
> - Link to v5: https://lore.kernel.org/r/20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com
> 
> Changes in v5:
> - Copy commit message exactly word for word on patch 1, as required by reviewer
> - Delete remove callback in patch 3, per request
> - Don't clean up debugfs, per request, which drops patch 4 entirely
> - Link to v4: https://lore.kernel.org/r/20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com
> 
> Changes in v4:
> - Updated commit messages for patches 1 and 2, per review
> - Link to v3: https://lore.kernel.org/r/20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com
> 
> Changes in v3:
> - Add patch to drop remove callback, per request
> - Link to v2: https://lore.kernel.org/r/20250428-pci-tegra-module-v2-0-c11a4b912446@gmail.com
> 
> Changes in v2:
> - Add patch to export tegra_cpuidle_pcie_irqs_in_use as required when
>   building pci-tegra as a module for arm
> - Drop module exit to prevent module unloading, as requested
> - Link to v1: https://lore.kernel.org/r/20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com
> 
> ---
> Aaron Kling (3):
>       irqdomain: Export irq_domain_free_irqs
>       cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use
>       PCI: tegra: Allow building as a module
> 
>  drivers/cpuidle/cpuidle-tegra.c    |  1 +
>  drivers/pci/controller/Kconfig     |  2 +-
>  drivers/pci/controller/pci-tegra.c | 35 ++++-------------------------------
>  kernel/irq/irqdomain.c             |  1 +
>  4 files changed, 7 insertions(+), 32 deletions(-)

Tidied commit logs per previous reviews and applied to
pci/controller/tegra for v6.20, thanks.

This branch will be rebased after v6.19-rc1.

