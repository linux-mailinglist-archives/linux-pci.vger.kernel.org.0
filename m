Return-Path: <linux-pci+bounces-39029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF854BFC611
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EE4B4ED72C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994534AAE7;
	Wed, 22 Oct 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STCa7qfp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A777342C81;
	Wed, 22 Oct 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141908; cv=none; b=SX6sdV/EfOeFjplHiJeqEFaphvYW+OplerVevJYJXVqC8DH65IdbNTASYbBUPt2x1FY3nAw3U9pnNUx0oVPWUafAz8gOtUN3y3+t21o6Fb60qxAZn59tWVvLGcICIBwxLmYw4DpustUyoLOE9PVXX/uvR2FhUh/klr7t/MM60jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141908; c=relaxed/simple;
	bh=Z2fhMvuqsJ3srCnp+0oTmljFG+7/qaPNlbN0encLOvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsrCWLyssKILYQp/9OoJWioYkz+XKPlUYPKD0vWs3s+pQBCg+vBGEdpnpcdZmIvDa5ZIwzaQhLDY7EBYJYLWBAJHCgsUx4x/OutK+1QCowfHBxtqjFNp0ZuVwlQtIE1swDLfz6U0Ia1itgnHzFvSFhdFyHrze560OADflVXmuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STCa7qfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D67BC4CEF5;
	Wed, 22 Oct 2025 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761141903;
	bh=Z2fhMvuqsJ3srCnp+0oTmljFG+7/qaPNlbN0encLOvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STCa7qfpl6r6uM36aHFZSqIEcjThWmFFBHbZeEBZwFO8JG1xNRTCUnIFxQwB6AxUZ
	 hFGYpNVAxqNd/I5p46l4Cy2SAgYZFO0TyIto+xhaTBnNIYsfvM/lV4ldsIP/iNifBq
	 gE58Huk8mbgwiMyUZjii1IrxZV9ADPPrUHDNf9Y9C6QY8lTjbU3B0+w6cMcKIOu8Xa
	 bEYRm1nNNEslseeSK3INJlTQ8i4LbnZT3sU3ZVCPUj+1muSl74dFB/aY2Q27r29DTd
	 +kYcYEV9n/v4mMHuLHXl3qqCPIavBR6pW4a+gaAyKZDIdI3kb7suetdkM1v/xj4A3b
	 Rwp0XZcyISUcg==
Date: Wed, 22 Oct 2025 09:05:01 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 3/5] of/irq: Export of_msi_xlate() for module usage
Message-ID: <20251022140501.GA3390144-robh@kernel.org>
References: <20251021124103.198419-1-lpieralisi@kernel.org>
 <20251021124103.198419-4-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021124103.198419-4-lpieralisi@kernel.org>

On Tue, Oct 21, 2025 at 02:41:01PM +0200, Lorenzo Pieralisi wrote:
> of_msi_xlate() is required by drivers that can be configured
> as modular, export the symbol.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)

I guess just iproc needs this, so:

Acked-by: Rob Herring (Arm) <robh@kernel.org>

