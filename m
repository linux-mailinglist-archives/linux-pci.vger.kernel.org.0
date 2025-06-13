Return-Path: <linux-pci+bounces-29647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57528AD8316
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 08:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E49A7AA98F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430122DF9E;
	Fri, 13 Jun 2025 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ents2dGN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F92F4311;
	Fri, 13 Jun 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795440; cv=none; b=fBM/2vQzzzg3SW+hT/wAqcH4EddX7DGNJ5diHPudGMqH4rz8J4MDz2xk8l3MhgOX3mA7piPZLlxfRAORY4+6XdgYZUp9Ilud0x375kPkB9/ia16ImZ/SP7qlXGLqws714rPipwwhTqnc/uBL9ev23+QhI0XBAXV14cBU7k91fCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795440; c=relaxed/simple;
	bh=7uMJRBkZTwSojUVs3ahTYNVgJZbMZtxufQ23KVSHhVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTuLeFoF503hcTzJaZLgW75tkZqAA0oXHkqO6xVjqDN3/BzA3SvOR3cHCSxSsNHhC/7gBOTPpSLbrJjzTOc9jNMtkxqJv3lyZd3aWMIivXRohkPPGsBY5NfKnMiiRJewszfbLYe1CEIT7ALxiobiB45L4dVD8LO0cCfen7qE2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ents2dGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D517C4CEE3;
	Fri, 13 Jun 2025 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749795439;
	bh=7uMJRBkZTwSojUVs3ahTYNVgJZbMZtxufQ23KVSHhVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ents2dGNfB23pNE1ivbyQHn7NoDaRtC7gaOQQYrZRea4T3Ryhav8R/BiPHK6ycket
	 5k7wITWgPyhYqf2wdlLYxqJzcHlGV6e4HrK4ZYQDvNJWl5U8zumJyn9v0XuF2FMIoD
	 b5aUZzaa13PY1gygiP3Qa4/K0YooL4qt2wZAXgF3390YYNbxI/oH3Ayy8CW0QKyy0q
	 TY8EomBnEh26TIe+iORQjC7ILgznQX7nCfnU7jZ1v42DgSeYyY8NSryD7JQq/FRQ1T
	 vxrbiCBihl6ygke0c+sQMJNLWIO3Uy9j0BEFeFXZaLmHbdRbTXWWqIw4rTz8590D8R
	 fsHioFynjJ1Yg==
Date: Fri, 13 Jun 2025 11:47:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: webgeek1234@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCI: tegra: Allow building as a module
Message-ID: <nz76wk5yqytag255jijxlyuodzpo3fm6d5coxutqrd7tgomzxm@pwzvpv4frjxu>
References: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>

On Wed, May 07, 2025 at 10:25:51PM -0500, Aaron Kling via B4 Relay wrote:

You should always add the context of the series in the cover letter.

> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
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

I need an ACK from the cpuidle maintainers to take these 3 patches through PCI
tree.

- Mani

>       PCI: tegra: Allow building as a module
> 
>  drivers/cpuidle/cpuidle-tegra.c    |  1 +
>  drivers/pci/controller/Kconfig     |  2 +-
>  drivers/pci/controller/pci-tegra.c | 35 ++++-------------------------------
>  kernel/irq/irqdomain.c             |  1 +
>  4 files changed, 7 insertions(+), 32 deletions(-)
> ---
> base-commit: 18352e73612d60b81790d2437845276ae499b64a
> change-id: 20250313-pci-tegra-module-7cbd1c5e70af
> 
> Best regards,
> -- 
> Aaron Kling <webgeek1234@gmail.com>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

