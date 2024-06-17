Return-Path: <linux-pci+bounces-8870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6490AE8E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 15:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758411C23E6E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F75194A61;
	Mon, 17 Jun 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsElOoC5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CA17FAA4;
	Mon, 17 Jun 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629391; cv=none; b=WC7QGRuJgRdLMYfxdqyhn2XqbOzsG0MCyAwTH85g2mFRMHeqGh2ioN0qBarjvjms41JbMhPuUqCEgghLknyHSj9r2XKtwO53telgTuzArfe4qbW/lth0rGhVXwoW2fiUrVZKQ8TDkJtnnJDXE9EqArRkhKACCojPT5iHnZSK60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629391; c=relaxed/simple;
	bh=M7VLjVNrIB50tU6t1nZPg0R5+ccYl0nZK24JAKpUyGA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agO92kYsVImS09udgJGdWeit8onnv4lRTz6G6oAIbKfBZah3/I3kzvsHApyDZfERRgI+RFr7hCzubJeoR7FuafzaauGPirKUDQrK25guz6WD2QiTiDfWjJXoOw616BW4TYH3J8Z9yguPwb/eMLTeF7NjNmNTiZVLym2VACQcSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsElOoC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AA1C2BD10;
	Mon, 17 Jun 2024 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718629390;
	bh=M7VLjVNrIB50tU6t1nZPg0R5+ccYl0nZK24JAKpUyGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gsElOoC5Re9d+pr1YwYIbWAqs0jcEb8b9D3zbWSWoKQmulj0zAzNwtAXGk6qcZMXW
	 LxUnKTFOvwT/jytTzKiu32J3hw5JzND/mubc1g98vHM0xh3ZtmWWD7x3QouH+KaO20
	 GA0a6UGFP6mISSKKHn3yttKaKylK2r6GzUFI3uXUomBk3TpOsk1t43pOmtFcjGWmn9
	 /ufVatJxmgzlU5/RcUjQQzuiVLkzmdyq98N3pp8goVtzEd31A+6nSIsjjHWuGuWCdj
	 jlAkof1uOnGtfGxWUo3K4/trtjhcS2rZ85cIl/SqoXpDhV3rrvc1vnMUs9ftKnenHy
	 eC19HNvl9PJCQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sJC0p-004b1B-Ra;
	Mon, 17 Jun 2024 14:03:07 +0100
Date: Mon, 17 Jun 2024 14:03:06 +0100
Message-ID: <86h6drk9h1.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Shivamurthy Shastri
 <shivamurthy.shastri@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	anna-maria@linutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	bhelgaas@google.com,
	rdunlap@infradead.org,
	vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	apatel@ventanamicro.com,
	kevin.tian@intel.com,
	nipun.gupta@amd.com,
	den@valinux.co.jp,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	alex.williamson@redhat.com,
	will@kernel.org,
	lorenzo.pieralisi@arm.com,
	jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org,
	robin.murphy@arm.com,
	lpieralisi@kernel.org,
	nm@ti.com,
	kristo@kernel.org,
	vkoul@kernel.org,
	okaya@kernel.org,
	agross@kernel.org,
	andersson@kernel.org,
	mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	yuzenghui@huawei.com
Subject: Re: [PATCH v3 14/24] genirq/gic-v3-mbi: Remove unused wired MSI mechanics
In-Reply-To: <87plsfu3sz.ffs@tglx>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
	<20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
	<86le36jf0q.wl-maz@kernel.org>
	<87plsfu3sz.ffs@tglx>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, shivamurthy.shastri@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com, rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org, lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org, vkoul@kernel.org, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 17 Jun 2024 13:55:24 +0100,
Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Sat, Jun 15 2024 at 18:24, Marc Zyngier wrote:
> > On Fri, 14 Jun 2024 11:23:53 +0100,
> > Shivamurthy Shastri <shivamurthy.shastri@linutronix.de> wrote:
> >>  static struct msi_domain_info mbi_pmsi_domain_info = {
> >> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> >> -		   MSI_FLAG_LEVEL_CAPABLE),
> >> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
> >>  	.ops	= &mbi_pmsi_ops,
> >>  	.chip	= &mbi_pmsi_irq_chip,
> >>  };
> >
> > This patch doesn't do what it says. It simply kills any form of level
> > MSI support for *endpoints*, and has nothing to do with any sort of
> > "wire to MSI".
> >
> > What replaces it?
> 
> Patch 9/24 switches the wire to MSI with level support over. This just
> removes the leftovers.

That's not what I read.

Patch 9/24 rewrites the mbigen driver. Which has nothing to do with
what the gic-v3-mbi code does. They are different blocks, and the sole
machine that has the mbigen IP doesn't have any gic-v3-mbi support.
All they have in common are 3 random letters.

What you are doing here is to kill any support for *devices* that need
to signal level-triggered MSIs in that driver, and nothing to do with
wire-MSI translation.

So what replaces it?

	M.

-- 
Without deviation from the norm, progress is not possible.

