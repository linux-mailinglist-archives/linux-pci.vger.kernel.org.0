Return-Path: <linux-pci+bounces-18780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327C09F7D07
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 15:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC4B188BF56
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B3225404;
	Thu, 19 Dec 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpzxZ6GU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6352248AC
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618125; cv=none; b=mbGXO1O2x/jNhb897+MaKP0ekSrDKSxDIz1ddRRcRrA4JTXnPMOcvsFQ13b94A3ms62hxN7gbTBU+AICa3AStlN3diWibETHuRz9IruFIubT/iCYANMSfyYg+LidAU7Eb4/hafDCIrlGNAyzupPR3jHtwrfKcmVyIZMo4Our/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618125; c=relaxed/simple;
	bh=EZZZYJUvUvtfyv5YN1EPSiV40YrW4jh3h61IvL87zD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+whbVI9kvh3S/FQyW8lTXfBhSpqEEpFRAC58CfTzL1w1eELGOKIA5xfzh+sD6tIjQcADyHCeOQ5sD2KldlrkEq7IJcRu4mPfIPE8XFEMzi7YAkq7MmzrbDSmpY4WuNaD+kFwpWW2QM/ff540wAR3QQDrWJNsmdeugad/vBWNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpzxZ6GU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB632C4CECE;
	Thu, 19 Dec 2024 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734618125;
	bh=EZZZYJUvUvtfyv5YN1EPSiV40YrW4jh3h61IvL87zD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpzxZ6GUMX3FCI9mPHzO2mV7npwK4bTOgJLGJsziBQ3MDWekZPMP29U9YdvPMHrfn
	 XPxRSDcPcB0yLim+uN8h5zOVUW/auCN9tetlK7+Swk0pFl6GKnW94oo72L5Iy2UD4e
	 NNIJDooaKXgyB649f2uxyHUPG2ndMwFXB+uHiiPAwR5Y7jW2cltGFA9jkVuPTUZ5BI
	 1kIih1kf+o8u33LkgLeDQ0OBQ2hkmYH4Ajyw1CLGExJO59sbTEGkUXmJYMMd76an+W
	 lRGLo9LAGjyVMHsShe1jPEeTnVksLjgu5rIJmMCl6RUOJHIkQw5J1Nl6By/aoDGGYT
	 VCmgFrAocZj0w==
Date: Thu, 19 Dec 2024 15:22:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enumerate endpoints based on
 dll_link_up irq in the combined sys irq
Message-ID: <Z2QsCI60fK038OEv@ryzen>
References: <20241127145041.3531400-2-cassel@kernel.org>
 <20241211053104.7sgo5bmmjnolwvhh@thinkpad>
 <Z1qY_K57lamVxqRm@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1qY_K57lamVxqRm@ryzen>

On Thu, Dec 12, 2024 at 09:04:12AM +0100, Niklas Cassel wrote:
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks for the review!
> 
> Could this patch please be picked up?

Another week has past, hence another ping :)


Kind regards,
Niklas

