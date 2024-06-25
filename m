Return-Path: <linux-pci+bounces-9218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C11916513
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40CE1C21BD0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 10:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6B148319;
	Tue, 25 Jun 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sNM4XF5m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3D11CA0;
	Tue, 25 Jun 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310658; cv=none; b=HaBGlHXoR2JGUVFTIFkjR+10r9y4WNtaXgJLBS7fAWDBpwp/9w+VWAY/STt1+AG8INgXXCUWoLG7pzTf+f6bLI6kN55ux/fDJMDWASfDauWlyI7MeHYIdt1WUQJhi/iiMDWcHkrupkhtrCtCOAVmAEIEcvAqjvVdWvrB0gmSW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310658; c=relaxed/simple;
	bh=wHH0ta67Z428cvOxUV9XYcSAVwOXjDszZqP0r61/GJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSASYP2Mc+GPYLKsWW1TvACh8tyqsRZ3R+GLMky9rhsD3Myp9RCsw4ka2XT5Y4zGG79jzcEbu0tD/Vjw3UyRnS/JvYZOXsz5KqCxmkFs6oKscwO1xWO3uEFKqDNfynqMbBmK5P61EmuafiYXN0s53wmb+2h80I47MLEJ0ATTW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sNM4XF5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F93CC32781;
	Tue, 25 Jun 2024 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719310657;
	bh=wHH0ta67Z428cvOxUV9XYcSAVwOXjDszZqP0r61/GJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNM4XF5mv7dCN3PxF5jObv8cstx+JGiqdbpD07LG5ZCqA5m9AhWuq8oA3wSnmRC5O
	 GZdrZ3o8hk7RuA7DG3u2PQt+6ekqOxjVNUSfxoULkDevLOmR2BVHEoPjO7AAtGPCQ5
	 IcmbbJa9bBwhIp7fk0u43ISqozCK91h9zdNpL0C0=
Date: Tue, 25 Jun 2024 12:02:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	maz@kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
	rdunlap@infradead.org, vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
	kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, rafael@kernel.org,
	alex.williamson@redhat.com, will@kernel.org,
	lorenzo.pieralisi@arm.com, jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org, robin.murphy@arm.com,
	lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
	vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
	andersson@kernel.org, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 20/21] genirq/msi: Remove platform MSI leftovers
Message-ID: <2024062506-iron-scapegoat-2377@gregkh>
References: <20240623142137.448898081@linutronix.de>
 <20240623142235.943295676@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623142235.943295676@linutronix.de>

On Sun, Jun 23, 2024 at 05:19:05PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> No more users!
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Yeah!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

