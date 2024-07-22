Return-Path: <linux-pci+bounces-10624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BC693969F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 00:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B72E1C213A5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 22:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B703BBCC;
	Mon, 22 Jul 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH3WVAKM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678FD512;
	Mon, 22 Jul 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721687897; cv=none; b=aZHQoqTdZqaxfu3PCh2Me5BcqmXeePG1e6wKWckRVnoOsK9Ktf4QvABevbG543g10GNk5TDEIDpX7llwFlL/Z8KFpVhzTrRpPRs22RL3r8vaB50f3UJkoZ0Kva8lsS9ETfHpsm0yMA7OYwm99Gl8rqFtfQbsRRyzS+Kt5CjWxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721687897; c=relaxed/simple;
	bh=zxNYwrFa6LhkKHTA0im0Ydgymd4rZUJv61OoqQvLUlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ca+rv9neNyYG/qlaqR/S8+84OIPuyT7XMMXZrpfE2RK+4ffXicqN6G+IkQJx0MZMRps9E87CTwCs223+r2WY4ngSYHEwg+ZdSiyVK5CLskuQBMNra7Ap9nJZadMCGes4ecjuamckbsuh0BtwguR3Z3RZqkA20RCWtRrRkjhE6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH3WVAKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2A9C116B1;
	Mon, 22 Jul 2024 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721687897;
	bh=zxNYwrFa6LhkKHTA0im0Ydgymd4rZUJv61OoqQvLUlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VH3WVAKMFrMVlW4ejo2TqEtTogPI7ko+uhjdVJJaHnnhnHKBt8bQx2IhPk1SywTFG
	 fY7TcyA95gldwGueX0S7Ucdr9iR9UGFfNGyoRAi2DT7cCQwGXgT+veB3abkJzlxVsc
	 btiN5UnKP8kBpDFmJIr28p4TT8IHnT6C79RlsbeQsOHo4MdEzlmczXKTgMECYL/+8u
	 tbTqMLhfSnv2gU5FRdNkCXQx/g2onAUpL/P/60F9VVs5YvcHHCawumMSYX8gwEwY8x
	 B9aRDgv3yPblQctWHWM1mePtL6N+kqRFjV9ojSTx3i+tgT/fxN47bgb429318K/apV
	 RP40v1qOKQjGw==
Date: Mon, 22 Jul 2024 17:38:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
	Jon Hunter <jonathanh@nvidia.com>, Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
	Rob Herring <robh@kernel.org>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI/rcar-host: Silence set affinity failed warning
Message-ID: <20240722223814.GA740637@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715122012.35222-2-marek.vasut+renesas@mailbox.org>

In subject, to match history:

s|PCI/rcar-host|PCI: rcar-host|

On Mon, Jul 15, 2024 at 02:19:27PM +0200, Marek Vasut wrote:
> Use newly introduced MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity unset
> and allows migrate_one_irq() code in cpuhotplug.c to exit right away, without
> printing "IRQ...: set affinity failed(-22)" warning.
> 
> Remove .irq_set_affinity implementation which only return -EINVAL from this
> controller driver.

This would be a nice improvement; thanks for working on it.

As you allude to at [1], there are many more PCI controller drivers
that could benefit from similar changes.  I'd like to do them all at
once if possible.

[1] https://lore.kernel.org/r/d5efcb28-dd5a-4b96-aabd-c73c95dff8e7@mailbox.org

> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Nipun Gupta <nipun.gupta@amd.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> ---
> V3: - New patch
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index c01efc6ea64f6..3dd653f3d7841 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -658,11 +658,6 @@ static void rcar_msi_irq_unmask(struct irq_data *d)
>  	spin_unlock_irqrestore(&msi->mask_lock, flags);
>  }
>  
> -static int rcar_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
> -{
> -	return -EINVAL;
> -}
> -
>  static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  	struct rcar_msi *msi = irq_data_get_irq_chip_data(data);
> @@ -678,7 +673,6 @@ static struct irq_chip rcar_msi_bottom_chip = {
>  	.irq_ack		= rcar_msi_irq_ack,
>  	.irq_mask		= rcar_msi_irq_mask,
>  	.irq_unmask		= rcar_msi_irq_unmask,
> -	.irq_set_affinity 	= rcar_msi_set_affinity,
>  	.irq_compose_msi_msg	= rcar_compose_msi_msg,
>  };
>  
> @@ -725,8 +719,8 @@ static const struct irq_domain_ops rcar_msi_domain_ops = {
>  };
>  
>  static struct msi_domain_info rcar_msi_info = {
> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		   MSI_FLAG_MULTI_PCI_MSI),
> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_MULTI_PCI_MSI,
>  	.chip	= &rcar_msi_top_chip,
>  };
>  
> -- 
> 2.43.0
> 

