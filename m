Return-Path: <linux-pci+bounces-33266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4187B17CB5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 08:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1AB4E116A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720461F03D8;
	Fri,  1 Aug 2025 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgSEXUb3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76ABA27;
	Fri,  1 Aug 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754028064; cv=none; b=QIk/drhW488CffNtjSPof9548kCPPz2yERYcyp2DqYM7tCt5scpdXQ819OeSiWnskcFdObJ6FvdxZ1xBsTBsfochrl7O8V2WMKJpnEuOax2LxhahqjDQQ02E0eFppME37/k04P1mrhUkYIWsATT5Bce/EgH1Q1xIz4656SxDL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754028064; c=relaxed/simple;
	bh=/263uIWcvhc0I5wZ3WHa0/u1tV91vOaXPF5PpqenmT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy11vegT6wBZxQDK2IRc1ulmgvzfELgSHJlbnmbdGqko0F8oEhm5W9lNmXfCknGr/giHwUYko2zoWaoc2kz69ZpUWauuEhsz27yC1hOYJ2E9denKH4DadVlELh7v7/VnIy9HvJAaWyc/5kiQ4UFr5WIBi5KIG1+UtBIkH827CKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgSEXUb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FCDC4CEE7;
	Fri,  1 Aug 2025 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754028063;
	bh=/263uIWcvhc0I5wZ3WHa0/u1tV91vOaXPF5PpqenmT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgSEXUb30+pWs5GoXv2VA0qaCXKyTl3k2ikLLryeXh2n9LZXECRSptTzAhDl97YkC
	 py21gmJ+O3NPGbEKvZuF1VJgpKc5n0ObYWneRIVLWRujqdbF1CZlfkE/FWH6VLFWpg
	 PREbWhaHPMdM5oJKelqLHF9TFxDYfxSkjrihZ9lR8PnwEeKzelv45XkXVHPOGuTNh8
	 Ls8jGZRlAilSMGH8Bxj6GEAQ0yLOlfJziWvoClU6L1wdhIkqLV3DCNjLEyaU3gz3Bj
	 7+y/G/kAjcq1mcpgYkAWVt8SlAlkOwn+Ky4kXVYU+iUwkGN83mdd6ELcAfxAbDiZZL
	 +s2+fki20RAqg==
Date: Fri, 1 Aug 2025 11:30:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/3] PCI: tegra: Allow building as a module
Message-ID: <omchhpbmsydfcsm6mzmbdiupsrxmxxvkxqf33fgi563akn76vf@vkc7k2zhlvee>
References: <20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com>
 <CALHNRZ9tOJccZ5sQjvkoPe4-+VUtWRxAzAOUainGUCs4+_RBCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ9tOJccZ5sQjvkoPe4-+VUtWRxAzAOUainGUCs4+_RBCw@mail.gmail.com>

On Thu, Jul 31, 2025 at 05:01:55PM GMT, Aaron Kling wrote:
> On Thu, Jul 31, 2025 at 4:59 PM Aaron Kling via B4 Relay
> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> > Changes in v7:
> > - Rebased on 6.16
> > - Updated mailing address list
> > - Link to v6: https://lore.kernel.org/r/20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com
> >
> > Changes in v6:
> > - Remove unused debugfs cleanup function, as caught by kernel ci
> > - Link to v5: https://lore.kernel.org/r/20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com
> >
> > Changes in v5:
> > - Copy commit message exactly word for word on patch 1, as required by reviewer
> > - Delete remove callback in patch 3, per request
> > - Don't clean up debugfs, per request, which drops patch 4 entirely
> > - Link to v4: https://lore.kernel.org/r/20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com
> >
> > Changes in v4:
> > - Updated commit messages for patches 1 and 2, per review
> > - Link to v3: https://lore.kernel.org/r/20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com
> >
> > Changes in v3:
> > - Add patch to drop remove callback, per request
> > - Link to v2: https://lore.kernel.org/r/20250428-pci-tegra-module-v2-0-c11a4b912446@gmail.com
> >
> > Changes in v2:
> > - Add patch to export tegra_cpuidle_pcie_irqs_in_use as required when
> >   building pci-tegra as a module for arm
> > - Drop module exit to prevent module unloading, as requested
> > - Link to v1: https://lore.kernel.org/r/20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com
> >
> > ---
> > Aaron Kling (3):
> >       irqdomain: Export irq_domain_free_irqs
> >       cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use
> >       PCI: tegra: Allow building as a module
> >
> >  drivers/cpuidle/cpuidle-tegra.c    |  1 +
> >  drivers/pci/controller/Kconfig     |  2 +-
> >  drivers/pci/controller/pci-tegra.c | 35 ++++-------------------------------
> >  kernel/irq/irqdomain.c             |  1 +
> >  4 files changed, 7 insertions(+), 32 deletions(-)
> > ---
> > base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> > change-id: 20250313-pci-tegra-module-7cbd1c5e70af
> >
> > Best regards,
> > --
> > Aaron Kling <webgeek1234@gmail.com>
> >
> >
> 
> Continuing the conversation from the last revision [0]. Is there any
> path forward for this series?
> 

Daniel, could you please look into the cpufreq patch?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

