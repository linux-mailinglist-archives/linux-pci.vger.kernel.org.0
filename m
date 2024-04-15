Return-Path: <linux-pci+bounces-6299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269688A5E17
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 01:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC2FB21906
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDDE15887C;
	Mon, 15 Apr 2024 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6cKqEvB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8737163;
	Mon, 15 Apr 2024 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713222925; cv=none; b=UfX0OSeIjTcqEaNZOfgbd4sCCKL5StHA8L08ka7jQ8fvAA17s+O03B5bRPGmLY8XOQTZNi8vpKqnkt4lHCf1iv7zfvnyGF1hcnJcnbRQTdZLN/qmUAE/xMrvzslxEPT/XFi2dYT9UTHmEyCAwocsOURyqBdgjMsr4ELaRwyzgGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713222925; c=relaxed/simple;
	bh=g/+U37u84szEx/7PZiBV5MUYHjoIlyB1hUCoTjwWbPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bdhEaDAzUPlwtmYM7ffnJ5WN6nYxFdOPolWvFUIofhjsO7BNL3wVmHVDT0WWs0q0/iRRkknkXqIu2DKcCjHusVnaQkybMlX1Q2rdgaeA3EdpKm6w5KrB2qOE405NN8NP8u4ArJBRl5L+Jp5szAjxWG8/d63WJ58fyavjr7e2GOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6cKqEvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82CBC2BD11;
	Mon, 15 Apr 2024 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713222925;
	bh=g/+U37u84szEx/7PZiBV5MUYHjoIlyB1hUCoTjwWbPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p6cKqEvBtdkXDLHMpexoT3q0o5wpBwL9yufwCM7y/K2OWhX2p2yO3SS+pIOOvJ/0k
	 EvKTPpKgOKs9JyFFQRwOISlc2zpXCHMASoRpHNE/emJQ8/VP1tnNa0LFcsYkIx2fgD
	 6/E4Fn3eTDMJV0SUn6lH0nKjASXmhSRhzypyfYT4KWtG2sDrSSMPvtzsYgY1DZ0Cdd
	 n3LYvKqv+KqegGjjdXIzmv+j2R1WQb7OaMnJsAqCw6b8ZB4A8MIiILf8SChFHHLshL
	 lO9o/ffpYt21j+Joczzy/+1atdVBrrpFojYeTfDkFOJ4LPX/EyqA1dA8mI9PYnyl2g
	 2wPeEU90TsBpw==
Date: Mon, 15 Apr 2024 18:15:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [RFC PATCH v4 03/20] PCI: Make pci_create_root_bus() declare its
 reliance on MSI domains
Message-ID: <20240415231523.GA139682@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415170113.662318-4-sunilvl@ventanamicro.com>

On Mon, Apr 15, 2024 at 10:30:56PM +0530, Sunil V L wrote:
> Similar to commit 9ec37efb8783 ("PCI/MSI: Make
> pci_host_common_probe() declare its reliance on MSI domains"), declare
> this dependency for PCI probe in ACPI based flow.
> 
> This is required especially for RISC-V platforms where MSI controller
> can be absent. However, setting this for all architectures seem to cause
> issues on non RISC-V architectures [1]. Hence, enabled this only for
> RISC-V.
> 
> [1] - https://lore.kernel.org/oe-lkp/202403041047.791cb18e-oliver.sang@intel.com
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/pci/probe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1325fbae2f28..e09915bee2ee 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3048,6 +3048,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  	bridge->sysdata = sysdata;
>  	bridge->busnr = bus;
>  	bridge->ops = ops;
> +#ifdef CONFIG_RISCV
> +	bridge->msi_domain = true;
> +#endif

Ugh.  I looked at [1], but that's not a very good justification for
this #ifdef.  The fault mentioned in [1] would need to be fixed, but
not this way.

>  	error = pci_register_host_bridge(bridge);
>  	if (error < 0)
> -- 
> 2.40.1
> 

