Return-Path: <linux-pci+bounces-33513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D1B1D1DE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4267F564A14
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 05:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5271E285A;
	Thu,  7 Aug 2025 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="XGpK3uHp"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6B1DF73A;
	Thu,  7 Aug 2025 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754543621; cv=none; b=kUekWmcTZtxuPJPjw5qvoh5Efh0Z0LMJKf9V+EM+Fn9hhzgoL/4kVvmFZe3Wt7HWE6KM+LaS9PrLo+NU9HHPOGrc+A9znDkNGNOdcsYa5gqPkibF1Di0n3mD3Gr6nX73pQjAm1rW2VyDoKpExGdlMAMEs3Q9LST7ahVZOS07YsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754543621; c=relaxed/simple;
	bh=rS31D5/HfWJNHKPfhcFL7sfeglexx2Eafj0XwRXL/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyDn3RHU37d+onyYx/8e+kO19XTzRPgcvULrWYAc/UgYBM6I30V7mJ+73mnlx38U5b9Rhwb+ApRdBTPMnVe0N6dMlNyc11B7LTI55VLJJuihLjRWylJAqHzNyfCIVhzpMo17a6uw513rm131Jnff0Z5DnXL2j/nPMFP6s+6S9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=XGpK3uHp; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754543617;
	bh=rS31D5/HfWJNHKPfhcFL7sfeglexx2Eafj0XwRXL/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=XGpK3uHp+FMEmXGSGDToohlqEr0f4/GM4ypLoCR0MR+glMgE7zVzn1lpFfw/x5NtA
	 W8ms1ymELrK8POszG4L9ZKl3fQ5DQyiZ2icp8hzApzPZcVv++G2eFq9k2i0ogTEMqQ
	 Wt3dn5D6QxPIcq6yMCsPK32+yMIzkRI73vYnomxBceqn1QPcLXyrf3HxgTGkvPLARZ
	 1aoWfPFYhylWiUg5zdfNoef2ZTBaqD+ZZngCj/75Aq+98PjtU49fRhdDQOZj4VEK09
	 IaeOmoT3mIvWYH+EJjg7tijL8a1ywprrI1y5CJvogi3lhl6agFJNidfCBbwhEpBhns
	 o5JoJ6S+EHrsA==
Received: from linux.gnuweeb.org (unknown [36.72.212.139])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 8765F3127C8C;
	Thu,  7 Aug 2025 05:13:34 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Thu, 7 Aug 2025 12:13:25 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PCI Mailing List <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	gwml@vger.gnuweeb.org
Subject: Re: [GIT PULL v2] PCI changes for v6.17
Message-ID: <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
 <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807050350.FyWHwsig@linutronix.de>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Thu, Aug 07, 2025 at 07:03:50AM +0200, Nam Cao wrote:
> Does the diff below help?
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9bbb0ff4cc15..b679c7f28f51 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -280,10 +280,12 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
>  static void vmd_msi_free(struct irq_domain *domain, unsigned int virq,
>  			 unsigned int nr_irqs)
>  {
> +	struct irq_data *irq_data;
>  	struct vmd_irq *vmdirq;
>  
>  	for (int i = 0; i < nr_irqs; ++i) {
> -		vmdirq = irq_get_chip_data(virq + i);
> +		irq_data = irq_domain_get_irq_data(domain, virq + i);
> +		vmdirq = irq_data->chip_data;
>  
>  		synchronize_srcu(&vmdirq->irq->srcu);
>  

Yes, it works.

Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Thank you for the fix!

-- 
Ammar Faizi


