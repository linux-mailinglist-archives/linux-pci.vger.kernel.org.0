Return-Path: <linux-pci+bounces-10461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE81934309
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9508281F9C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7130B188CC7;
	Wed, 17 Jul 2024 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWJNkQYf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46830186E2C;
	Wed, 17 Jul 2024 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247007; cv=none; b=p5rqOVPa6Kh4vMJzqajDbErBBfZh9GU9uD+4pfcpQF+CQ7DqMRYMBUuRqtFXzfoFoQEDiGzs3963Q64dm+pev5bSql/EpsyZ+HeKvmoM+3ZAo6q+We5Wbid+lPtVNraoiIQPZc/fy3FlZotfZS8HcNwrqGbBLvf9qAzeAcqe+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247007; c=relaxed/simple;
	bh=H7bipx0BC5U9g7+AcvbQjNGf4f4pyEW50P6weN56IjY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqG9K4X1nROIiusJJjQQ0OfRQnfMp3B5TtQrGAbn52AjA8z45DBoxYBhcRtENs9HxGrao8vLYpTOLdSOvKb3Ia71Il4xjueQW2xHR9D2LvR5yfklTEpUd/qY2jX5a3KQWta23ts+ATwx7MIMlU2Y4zAEBngFkeomGXqKOa3cYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWJNkQYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04A1C2BD10;
	Wed, 17 Jul 2024 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247006;
	bh=H7bipx0BC5U9g7+AcvbQjNGf4f4pyEW50P6weN56IjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bWJNkQYfb1YUy/brOAIdQUtUcYkSxEIKgp5H7vhqCN08QaQbwJ4kYe+qXGjSWwX0Y
	 ehhBT1mgqyQjtnRNMq7HIQTat95EtVjtTFYbNl+LRBiHQN68IOsWQmgmDY7dsW5cvM
	 h8cLh/wGjpkGV6i15OJMjF96RS7ou7FxFpCayRwtdU7Wu4r1/SPJkdb4fKl4IMcAiX
	 XXyPAZA/qieAJulRnFq6RZbLIumm5kBsz6zcZeUlSOUs9IFWQUbw96FS+SEjMYm8q+
	 UDUW5aALwE+z5rcp6XxUU+/toluJZvQLMQg/gQLUQGvZIaswqA3AqLficK9RdodS96
	 6PgXduSHqpdoA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sUAyR-00DFMy-Ub;
	Wed, 17 Jul 2024 21:10:04 +0100
Date: Wed, 17 Jul 2024 21:10:02 +0100
Message-ID: <86jzhj3hlx.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to per device MSI domains
In-Reply-To: <ZpfJc80IInRLbRs5@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
	<ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
	<878qy26cd6.wl-maz@kernel.org>
	<ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
	<86r0bt39zm.wl-maz@kernel.org>
	<ZpaJaM1G721FdLFn@hovoldconsulting.com>
	<86plrd2o5o.wl-maz@kernel.org>
	<Zpdxe4ce-XwDEods@hovoldconsulting.com>
	<86msmg2n73.wl-maz@kernel.org>
	<ZpfJc80IInRLbRs5@hovoldconsulting.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.3
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: johan@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com, rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org, lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org, vkoul@kernel.org, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 17 Jul 2024 14:38:59 +0100,
Johan Hovold <johan@kernel.org> wrote:
> 
> On Wed, Jul 17, 2024 at 01:54:40PM +0100, Marc Zyngier wrote:
> > On Wed, 17 Jul 2024 08:23:39 +0100,
> > Johan Hovold <johan@kernel.org> wrote:
> 
> > > [    8.692011] Reusing ITT for devID 0
> > > [    8.693668] Reusing ITT for devID 0
> > 
> > This is really odd. It indicates that you have several devices sharing
> > the same DeviceID, which I seriously doubt it is the case in a
> > laptop. Do you have any non-transparent bridge here? lspci would help.
> 
> Yeah, and these messages do not show up without the series (see log
> below). They are there in the previous synchronous log however.

I think I've finally nailed the sucker, and posted a potential fix[1].

It definitely restore my TX1 to a state that is no worse than normal,
so something must be less wrong there.  I'm pretty sure that the
platform-msi equivalent is equally broken, but I don't have the energy
to verify/debug that tonight.

Thomas, feel free to squash this into your series or keep it as is, as
you prefer.

	M.

[1] https://lore.kernel.org/r/20240717195937.2240400-1-maz@kernel.org

-- 
Without deviation from the norm, progress is not possible.

