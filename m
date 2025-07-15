Return-Path: <linux-pci+bounces-32177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADEBB063EA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 18:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE411885DED
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED22459E5;
	Tue, 15 Jul 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsD31o2g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980684A3E;
	Tue, 15 Jul 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595678; cv=none; b=bcvlcDRvQ/PqpfzoglCmD858jSsZEzR3aK+aYXvAy5JFc7AhqRrozD++agA9uXCPKZ9hbEW4tD8rCKQBL9bVX2PiuBABhjeuRMFva7AHb6FKFHAQpfpo92j32yrTJ7jPgbiNVxSlDt+dPxBxCkEnVJy7YgKdyreaBW1zFB4U83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595678; c=relaxed/simple;
	bh=92vM89H319kLp8p2XpLxnfznxqmrIenWM4aQHIRBrXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPqPylPKORWFZITBlfgOlkYB1cJE4IDGxQpnjw5Qqw7sTr+IJHN/obCQVeBPXmOyPwPkdBTMzDk24IPaQ3LKs51QdzsOk34siAO+gBCaIh/fIbP0sC32GtmivCreBxscoODS3+daO078Ik3yhROq4jhrleA74A101pBjZoKOK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsD31o2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42207C4CEE3;
	Tue, 15 Jul 2025 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752595676;
	bh=92vM89H319kLp8p2XpLxnfznxqmrIenWM4aQHIRBrXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsD31o2gsWD6TDtzTl/d0SS/6Wdo0kSKjMBctHAM1NDaebqlaca+1uuOoIck8uMOF
	 E70n5fZ/HPplENYVwPGdXbce3jpHOW+TunUtS7a4aoBhVa9vCqG/VlP7TQ5ptyshKa
	 yNRSGCG0r8TbjcewNDjuIfyQNw14hGBh4acuozbXUzqYzvM1YsJ8Xy3jq24YDZOxZ7
	 dSlTAKpzE9i8BknUdnvaJNVGvvzdGfYquGD+e5j3+BXyzyctJv5T4gUS+6RIxn5Ucm
	 tlBzg7qisEOUECilZV2mOu1ZwWsFApvH78c1T1bRya0d0FOs5dwR1CyAYH60l81S46
	 BHFoBKWweUwGQ==
Date: Tue, 15 Jul 2025 18:07:48 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 18/31] arm64: smp: Support non-SGIs for IPIs
Message-ID: <aHZ81Kah1Uaa184N@lpieralisi>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org>
 <7mhnql75p3l4vaeaipge6m76bw4wivskkpvzy5vx3she3wogk4@k62f5hzgx5wr>
 <aHZm8BsqV1ighJ+2@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZm8BsqV1ighJ+2@lpieralisi>

On Tue, Jul 15, 2025 at 04:34:24PM +0200, Lorenzo Pieralisi wrote:
> On Tue, Jul 15, 2025 at 07:10:29AM -0700, Breno Leitao wrote:
> > Hello Lorenzo, Marc,
> > 
> > On Thu, Jul 03, 2025 at 12:25:08PM +0200, Lorenzo Pieralisi wrote:
> > > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > > index 3b3f6b56e733..2c501e917d38 100644
> > 
> > > @@ -1046,11 +1068,15 @@ static void ipi_setup(int cpu)
> > >  		return;
> > >  
> > >  	for (i = 0; i < nr_ipi; i++) {
> > > -		if (ipi_should_be_nmi(i)) {
> > > -			prepare_percpu_nmi(ipi_irq_base + i);
> > > -			enable_percpu_nmi(ipi_irq_base + i, 0);
> > > +		if (!percpu_ipi_descs) {
> > > +			if (ipi_should_be_nmi(i)) {
> > > +				prepare_percpu_nmi(ipi_irq_base + i);
> > 
> > I am testing linux-next on commit 0be23810e32e6d0 ("Add linux-next
> > specific files for 20250714") on a Grace (GiCv3), and I am getting
> > a bunch of those:
> > 
> > 	[    0.007992] WARNING: kernel/irq/manage.c:2599 at prepare_percpu_nmi+0x178/0x1b0, CPU#2: swapper/2/0
> > 
> > 	[    0.007996] pstate: 600003c9 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > 	[    0.007997] pc : prepare_percpu_nmi (kernel/irq/manage.c:2599 (discriminator 1))
> > 	[    0.007998] lr : prepare_percpu_nmi (kernel/irq/manage.c:2599 (discriminator 1))
> > 
> > 	[    0.008011] Call trace:
> > 	[    0.008011] prepare_percpu_nmi (kernel/irq/manage.c:2599 (discriminator 1)) (P)
> > 	[    0.008012] ipi_setup (arch/arm64/kernel/smp.c:1057)
> > 	[    0.008014] secondary_start_kernel (arch/arm64/kernel/smp.c:245)
> > 	[    0.008016] __secondary_switched (arch/arm64/kernel/head.S:405)
> > 
> > I haven't bissected the problem to this patch specifically, but
> > I decided to share in case this is a known issue, given you are touching
> > this code.
> > 
> > I would be happy to bissect it, in case it doesn't ring a bell.
> 
> Thank you for reporting it.
> 
> Does this patch below fix it ?

FWIW it does for me. I think you are booting with pseudo-nmi enabled and
the below is a silly thinko (mea culpa) that is causing the IPI IRQ descs not
to be set-up correctly for NMI and the prepare_percpu_nmi() call rightly
screams on them.

If you confirm I hope it can be folded into the relevant patch.

Thanks,
Lorenzo

> -- >8 --
> diff --git i/arch/arm64/kernel/smp.c w/arch/arm64/kernel/smp.c
> index 4797e2c70014..a900835a3adf 100644
> --- i/arch/arm64/kernel/smp.c
> +++ w/arch/arm64/kernel/smp.c
> @@ -1093,7 +1093,7 @@ static void ipi_setup_sgi(int ipi)
>  
>  	irq = ipi_irq_base + ipi;
>  
> -	if (ipi_should_be_nmi(irq)) {
> +	if (ipi_should_be_nmi(ipi)) {
>  		err = request_percpu_nmi(irq, ipi_handler, "IPI", &irq_stat);
>  		WARN(err, "Could not request IRQ %d as NMI, err=%d\n", irq, err);
>  	} else {

