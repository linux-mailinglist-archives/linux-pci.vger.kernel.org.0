Return-Path: <linux-pci+bounces-20821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841EFA2AEEE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C859188ABC9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E7515B54A;
	Thu,  6 Feb 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gadxXX3K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9223958D;
	Thu,  6 Feb 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863181; cv=none; b=b8lYLnNHLHBZf+BtdaEhDYXjbs0jc9QoQXcfRtzCRlMuBvyTdMU9bvPqBQzklt5rA+v3amv0sZDecd8VFbLV8RHMUm8w9os3KVB08szRGBK+YFHQaPn4TYnpLpnE9eAptnQ3t6HQqrWYSV8kg6DVQ8cpFx7EAK5jR7g/7HM6OWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863181; c=relaxed/simple;
	bh=z9GAocz8DODcIKXLrUrORxsX+oxn+vboEuxbPCGncwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p9SqC+Zg1vhQH6SEF4ySoFTwzUw/sURGVOdoXktYvCnFmfZvZ3uWiEZkK9P3E4JyfCVkfxG9XgroHMJWcSQ7JGAqhQ1PU0y0QiAppmi+j2XiAaGMSlKIVO23TYJXDtidFI4U2E6h0xFLeWs37ktOipl6IsXQyTRiNjsEEuqawSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gadxXX3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7D5C4CEDD;
	Thu,  6 Feb 2025 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738863181;
	bh=z9GAocz8DODcIKXLrUrORxsX+oxn+vboEuxbPCGncwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gadxXX3KKjq1UP9zGVooJUv+QtyRdjAnVrI+e8Hmt27c5V9C/3OyhHzCqJJT7wlOJ
	 EgYtKtB3f+E2yIjm2IU+PCK6rjcWAuVM/xR2lPi8VQl2KeM21iNyT/NqMhjwKXbMue
	 RHKK4jIYqPnaNXeZEqKDodl6gni/UrHr7u4ZRZ4qegwAekIg5L8uFcpKjrqyAlXJR8
	 Qff8lr4peg3OXr1iva9Md8JzQ9L3ZjS0FeXQRwNceygZgRnETbKwAhVxzlp1pm873D
	 i3Bzvaqcq2UXIBLHQp/vhVjcDmABGp+5LL/RBnPMBIvq9P7rTLpzQ2OENUykdrWacx
	 HZyoLuELrGxHQ==
Date: Thu, 6 Feb 2025 11:32:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/6] PCI: brcmstb: Fix potential premature regluator
 disabling
Message-ID: <20250206173259.GA991437@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205191213.29202-4-james.quinlan@broadcom.com>

In subject,

s/regluator/regulator/

On Wed, Feb 05, 2025 at 02:12:03PM -0500, Jim Quinlan wrote:
> Our system for enabling and disabling regulators is designed to work
> only on the port driver below the root complex.  The conditions to
> discriminate for this case should be the same when we are adding or
> removing the bus.  Without this change the regulators may be disabled
> prematurely when a bus further down the tree is removed.

What did the user do to cause the bus to be removed?  I'm wondering if
we turn off the power while the link is still up.  If we do, how does
it get turned back on?  Does that require a manual rescan, and the
scan of the child bus gets the power turned back on?

> Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index bf919467cbcd..4f5d751cbdd7 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1441,7 +1441,7 @@ static void brcm_pcie_remove_bus(struct pci_bus *bus)
>  	struct subdev_regulators *sr = pcie->sr;
>  	struct device *dev = &bus->dev;
>  
> -	if (!sr)
> +	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
>  		return;
>  
>  	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
> -- 
> 2.43.0
> 

