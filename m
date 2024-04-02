Return-Path: <linux-pci+bounces-5566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE1B895AAF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 19:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6011F2563D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4E159912;
	Tue,  2 Apr 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ9HYqDy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54050133283;
	Tue,  2 Apr 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079083; cv=none; b=gFCwe3DhVe6tqKGOpHftquEU44FxUT87I0OKyj2juTWimEww8WIw1F2wIqlqes1r9foZX7euoMp2JeKaZ1Lpy79/qf5tWNCkYqskAZgFeEF9kD38ZDvPUmKiCSeg0C9uvcg+Kbx951iAS+AgLbzPI+tBRyKJbrOcPGlJ/jN4U4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079083; c=relaxed/simple;
	bh=lrf2H0YQAGtvMv18gh40GOdVnYqcnYKmW5VFDLEhDT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GrYwr/q1ddzDPlTx/qWljcUOLizwYkX/FK7m0rVy0/dg/iQfRe7NLeFdy+urPzyNI9DPJ467NGUmodnbngUMlVJprA1OX9Xzx3O7LUEQOwLJn/2saYT9EpSin16cAji0H1UJ8mRCDGs6OR1JDzJidGD0j4h1SmH4cbvw9eeU96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ9HYqDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49F9C433F1;
	Tue,  2 Apr 2024 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079082;
	bh=lrf2H0YQAGtvMv18gh40GOdVnYqcnYKmW5VFDLEhDT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CJ9HYqDy4b4jUl4HOUQpoeh9rNv2qhvhMunZ0p3zd70XBx2e4NIrrLi7avEG55rQP
	 qbTizpQGpmibLUJh9G8IjuNwM/oO2B9E5J/7b2Zx3rHcTWpr1+TiwT3yF6Nrifmdvq
	 WVQA2RreXD4jYpaPBU/9XUT9tqKIAGPRRkyEdgHytU/v5PLy1V4RbY67bbchvmJSvK
	 krohOg8WwmIs7tIj1r3S5yApyfTRB7EhpAiDh2j13eAWctrSCMOUbKXjT+Mb+qxzSX
	 XPhNLm1qJJnajdBuNM9UYfVtOuSuFsP93FcARb9OqW2ydUR1K/QWNEpCZd4EHEBdz8
	 DK5b3G0QkC4gA==
Date: Tue, 2 Apr 2024 12:31:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI: dwc: keystone: Fix potential NULL dereference
Message-ID: <20240402173121.GA1819268@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329051947.28900-1-amishin@t-argos.ru>

On Fri, Mar 29, 2024 at 08:19:47AM +0300, Aleksandr Mishin wrote:
> In ks_pcie_setup_rc_app_regs() resource_list_first_type() may return
> NULL which is later dereferenced. Fix this bug by adding NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 844de4418724..00d616654171 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -392,7 +392,11 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  	struct resource *mem;
>  	int i;
>  
> -	mem = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM)->res;
> +	struct resource_entry *ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +	if (!ft)
> +		return;

Like the other one
(https://lore.kernel.org/all/20240328180126.23574-1-amishin@t-argos.ru/),
I think this potentially avoids a NULL pointer dereference (though I
didn't do the analysis in this case to see whether that's actually
possible), but fails to consider the implication of simply skipping
the rest of ks_pcie_setup_rc_app_regs().

"start" and "end" are used only for the loop about "Using Direct 1:1
mapping of RC <-> PCI memory space".  If there's no IORESOURCE_MEM
resource, obviously that loop makes no sense.  The function would
probably be improved by moving the resource_list_first_type() so it's
next to the loop that uses the result.

But the rest of the function doesn't depend on that IORESOURCE_MEM
resource, and it's not at all clear that the rest of the function
should be skipped.

> +	mem = ft->res;
>  	start = mem->start;
>  	end = mem->end;
>  
> -- 
> 2.30.2
> 

