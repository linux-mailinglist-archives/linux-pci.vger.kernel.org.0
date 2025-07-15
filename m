Return-Path: <linux-pci+bounces-32162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17B2B061C3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DA8565BF3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13781F4617;
	Tue, 15 Jul 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUDcufFZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260119EEC2;
	Tue, 15 Jul 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590072; cv=none; b=gW46zeD6YA/mw/Vo0yRhZREfFqKzwyNuLNN32PiMN5rxMyvvDVnVvLn0QdxZTbxPzvVJynXo8WXBBiI+f4TCeotEHWYmBDzq+bM2cGnaaL9h5u7r/l/suM7nF4KoVDGqPZNApHxl/IzqW7FPFkZdC7HkRvJyQCbwbzLsh/Cxb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590072; c=relaxed/simple;
	bh=PYwhKe0GMvp7ihfIzBAq9SNNQepK3AlS2xPSvBMLHqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATRVo9CSLP3xM18mI+R8LCyDImLbmWbnm8TnV3uuZS3LTUKLirubg5Gqh8A6O7fDkcLs6IQM0h/OCuGrcNDQw9t1BTbdcd7jc3qeMGc1J1AY9SGWGGSlF3T2zMA/eOJI7uwEN6O+wcM7ue6byiVGBGtrqxYEK2AUks6EE4EJ9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUDcufFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240B7C4CEE3;
	Tue, 15 Jul 2025 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590072;
	bh=PYwhKe0GMvp7ihfIzBAq9SNNQepK3AlS2xPSvBMLHqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUDcufFZ69Kj9Mg4obHeLJ1tqjVc4h81VF8IhZ0URP0Vsi6lLmBn8IYUPKptjuoAs
	 urAIFYKgUEAFIKwEOmgeBlL3njUCYEZC9JjRn+41vFX0QUtiMcRmyLqd8xJ2JrppeG
	 A3timXh4aoqwQetsAL3YoePXI0FLfw6X6LN2uDZ4pSHspKIFINZmg+UqFEDafkXveQ
	 adt+smXAdoyYGIq6LR3QDWlgxQ7jcLBG+/4dAWpw39BDvENsW8hzAySzM4X35NxUCV
	 7QYSunSoNxoCJKlhitjXAvMMhrqmeNYylYknPE8U+MYS/rTrrSBrmL2jr0g0Yq9xTP
	 wWWE2fWP1DytA==
Date: Tue, 15 Jul 2025 16:34:24 +0200
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
Message-ID: <aHZm8BsqV1ighJ+2@lpieralisi>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org>
 <7mhnql75p3l4vaeaipge6m76bw4wivskkpvzy5vx3she3wogk4@k62f5hzgx5wr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7mhnql75p3l4vaeaipge6m76bw4wivskkpvzy5vx3she3wogk4@k62f5hzgx5wr>

On Tue, Jul 15, 2025 at 07:10:29AM -0700, Breno Leitao wrote:
> Hello Lorenzo, Marc,
> 
> On Thu, Jul 03, 2025 at 12:25:08PM +0200, Lorenzo Pieralisi wrote:
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 3b3f6b56e733..2c501e917d38 100644
> 
> > @@ -1046,11 +1068,15 @@ static void ipi_setup(int cpu)
> >  		return;
> >  
> >  	for (i = 0; i < nr_ipi; i++) {
> > -		if (ipi_should_be_nmi(i)) {
> > -			prepare_percpu_nmi(ipi_irq_base + i);
> > -			enable_percpu_nmi(ipi_irq_base + i, 0);
> > +		if (!percpu_ipi_descs) {
> > +			if (ipi_should_be_nmi(i)) {
> > +				prepare_percpu_nmi(ipi_irq_base + i);
> 
> I am testing linux-next on commit 0be23810e32e6d0 ("Add linux-next
> specific files for 20250714") on a Grace (GiCv3), and I am getting
> a bunch of those:
> 
> 	[    0.007992] WARNING: kernel/irq/manage.c:2599 at prepare_percpu_nmi+0x178/0x1b0, CPU#2: swapper/2/0
> 
> 	[    0.007996] pstate: 600003c9 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> 	[    0.007997] pc : prepare_percpu_nmi (kernel/irq/manage.c:2599 (discriminator 1))
> 	[    0.007998] lr : prepare_percpu_nmi (kernel/irq/manage.c:2599 (discriminator 1))
> 
> 	[    0.008011] Call trace:
> 	[    0.008011] prepare_percpu_nmi (kernel/irq/manage.c:2599 (discriminator 1)) (P)
> 	[    0.008012] ipi_setup (arch/arm64/kernel/smp.c:1057)
> 	[    0.008014] secondary_start_kernel (arch/arm64/kernel/smp.c:245)
> 	[    0.008016] __secondary_switched (arch/arm64/kernel/head.S:405)
> 
> I haven't bissected the problem to this patch specifically, but
> I decided to share in case this is a known issue, given you are touching
> this code.
> 
> I would be happy to bissect it, in case it doesn't ring a bell.

Thank you for reporting it.

Does this patch below fix it ?

-- >8 --
diff --git i/arch/arm64/kernel/smp.c w/arch/arm64/kernel/smp.c
index 4797e2c70014..a900835a3adf 100644
--- i/arch/arm64/kernel/smp.c
+++ w/arch/arm64/kernel/smp.c
@@ -1093,7 +1093,7 @@ static void ipi_setup_sgi(int ipi)
 
 	irq = ipi_irq_base + ipi;
 
-	if (ipi_should_be_nmi(irq)) {
+	if (ipi_should_be_nmi(ipi)) {
 		err = request_percpu_nmi(irq, ipi_handler, "IPI", &irq_stat);
 		WARN(err, "Could not request IRQ %d as NMI, err=%d\n", irq, err);
 	} else {

