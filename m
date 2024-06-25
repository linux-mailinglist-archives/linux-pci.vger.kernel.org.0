Return-Path: <linux-pci+bounces-9215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6533916023
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 09:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38091C20E60
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E9146D60;
	Tue, 25 Jun 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIqWOP8M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF21DFFD;
	Tue, 25 Jun 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301032; cv=none; b=u6WT95OKMLUaZBe9IsdGZlnWicNsXjeI6ngem8mBEriEsKLQ3tnDletnT9N0TtPMlyHH49DtUD2BkUtXFnOuCSSo50234XMUU4cI0uapnO10BpnRyeUgnq49/VGNdxSpqB7TGmfeX3MkGxzR4g2Zl3DA4Ch63tbHgG7uFvah2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301032; c=relaxed/simple;
	bh=GQZtXhAEg7WxvHsN/Xrc9fpa1acHEuQJQTIAFZ+PqC0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVxZAlElAy13uqTgdkrdeUfWMF35zmum7GHKTqdr0fxbEXGk+p77+V0JbJvWV7mxFdzzOWtRebZ+pb8+KBbd3d4XsULKudSfa8R3gja70siwQQ5AqD3R41I6/8C1EF5iPDtQHqr7bgZNtTVvSSxKQEQNI2AP3tJXhuSKJ4e9xLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIqWOP8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C79C32789;
	Tue, 25 Jun 2024 07:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719301032;
	bh=GQZtXhAEg7WxvHsN/Xrc9fpa1acHEuQJQTIAFZ+PqC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qIqWOP8Mz4OTpTU6AINxjUUFnVqAa143m+m+ERwfP/SPXlVSTWNOvXO7cICeK+iFO
	 BBexpH+vnbumu3dR/YLAi4qxtqEARjYyPbiEBtrdz4vrWYnIAYlKWrJUrczLNKYYxq
	 60/AbTm47++9XaDu82f1swvovvgEdr1lkPJK7IphSQNr3vGEvsmmuwYPIQoYs/bCM4
	 UpyDCykoJtZfEyVS4Puf6S3v72zdTAuOYA6Uov53flqirOp6OwjY1VpdYN06Y0sWBi
	 WL8hR0DJ9oq6Wy5GpdZaDVArEhopVXrBvSvD8DGmgOAb/wSoP+SKD4tlZe7t24jf67
	 3GGXM//DpiJVQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sM0jl-0074Fn-Jx;
	Tue, 25 Jun 2024 08:37:09 +0100
Date: Tue, 25 Jun 2024 08:37:09 +0100
Message-ID: <86y16tiica.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
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
In-Reply-To: <87ed8vu033.ffs@tglx>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
	<20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
	<86le36jf0q.wl-maz@kernel.org>
	<87plsfu3sz.ffs@tglx>
	<86h6drk9h1.wl-maz@kernel.org>
	<87h6dru0pb.ffs@tglx>
	<87ed8vu033.ffs@tglx>
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

On Mon, 17 Jun 2024 15:15:44 +0100,
Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Mon, Jun 17 2024 at 16:02, Thomas Gleixner wrote:
> > On Mon, Jun 17 2024 at 14:03, Marc Zyngier wrote:
> >> Patch 9/24 rewrites the mbigen driver. Which has nothing to do with
> >> what the gic-v3-mbi code does. They are different blocks, and the sole
> >> machine that has the mbigen IP doesn't have any gic-v3-mbi support.
> >> All they have in common are 3 random letters.
> >>
> >> What you are doing here is to kill any support for *devices* that need
> >> to signal level-triggered MSIs in that driver, and nothing to do with
> >> wire-MSI translation.
> >>
> >> So what replaces it?
> >
> > Hrm. I must have misread this mess. Let me stare some more.
> 
> Ok. Found my old notes.
> 
> AFAICT _all_ users of platform_device_msi_init_and_alloc_irqs():
> 
>         ufs_qcom_config_esi()
>         smmu_pmu_setup_msi()
>         flexrm_mbox_probe()
>         arm_smmu_setup_msis()
>         hidma_request_msi()
>         mv_xor_v2_probe()
> 
> just install their special MSI write callback. I don't see any of those
> setting up LEVEL triggered MSIs.
> 
> But then I'm might be missing something. If so can you point me please
> to the usage instance which actually uses level signaled MSI?

Good question. I'm pretty sure we had *something* at some point that
used it, or that was planning on using it. I even vividly remember who
was asking for this.

But either that never really made it upstream, or they decided to move
away from the kernel setting the MSI up and relied on firmware for
that (which is fine as long as the device isn't behind an IOMMU).

In the end, it begs the question of what we want to do with this
feature.  I don't think it is a big deal to keep it around, but maybe
we should plan for it to be retired. That's independent of this
series, IMO.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

