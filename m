Return-Path: <linux-pci+bounces-38918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BBEBF7768
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0043A120B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FA23396F0;
	Tue, 21 Oct 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDAFYe4z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2773FC2;
	Tue, 21 Oct 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061531; cv=none; b=D98kEvK3DqYvr8umoozjZsyHEjuVDSNI5S1CL1MONautsSAgZQEje3ZKwBmdwdjCPVxv5EZ5ay2FGuZY+0s/BFfrWuV8yyFUH/ynO1Z6NOqjul9D0vZBbDcfGpXda3VTcTjjHrt2B2NvID2Z9Jr9jTEw5GFuC9Xr3xGwgpWQpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061531; c=relaxed/simple;
	bh=dlcvFtDb6OWOoHzfzh8r4khgVAAzJlONTZXsa6DBayk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tXCJLxiinoeYm7xGUp3rwFpZazeSnIrZUSUGk7YDwXgvPsFsvpzxe0bL9kTO1bp+Aqa1nlX9iho1BgHayKngbdCRPL8b6N43ntUTDsoci0zxBU+bwH1PQd6GesC+BFcYVkm1q/ClcwxlYLbX9qFaTwDDez+j7daweB0HWiFWERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDAFYe4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39119C4CEF1;
	Tue, 21 Oct 2025 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061531;
	bh=dlcvFtDb6OWOoHzfzh8r4khgVAAzJlONTZXsa6DBayk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lDAFYe4zauOxm0ztpPeoaTFpH+ptcIs3FnZjeFSTMg1PKwu2LGzLqEOJEtlEONbTl
	 tqTTRXbE1NgxbjCRU2lxwchhMEMZbFbAPhUBJrpxMYYU8GBiPGWhV/rLul5d+isNQc
	 X/I+brRNwBetrzgcZiO84FF2bP8+XXVlDqCw4A3F5iXKJI21eujGXea5uAK6DVMGmV
	 phcPPxU0HbX1eeyDEfeOkBfDBXkVW2o4sUsSUZRp15wKS2Q+SJFazMG1XRO5i0t94F
	 Fs+cfYpeGmXFdSOi3SZDF1webtGEOOlQ7ffVW14p+H7Cnz9hO3boNQpE4q2o2R3thg
	 djeA1fhcseOEw==
Date: Tue, 21 Oct 2025 10:45:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>, Scott Branden <sbranden@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 4/5] PCI: iproc: Implement MSI controller node
 detection with of_msi_xlate()
Message-ID: <20251021154529.GA1191613@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021124103.198419-5-lpieralisi@kernel.org>

On Tue, Oct 21, 2025 at 02:41:02PM +0200, Lorenzo Pieralisi wrote:
> The functionality implemented in the iproc driver in order to detect an
> OF MSI controller node is now fully implemented in of_msi_xlate().
> 
> Replace the current msi-map/msi-parent parsing code with of_msi_xlate().
> 
> Since of_msi_xlate() is also a deviceID mapping API, pass in a fictitious
> 0 as deviceID - the driver only requires detecting the OF MSI controller
> node not the deviceID mapping per-se (of_msi_xlate() return value is
> ignored for the same reason).
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this is material for Rob or Thomas?

> ---
>  drivers/pci/controller/pcie-iproc.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 22134e95574b..ccf71993ea35 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -17,6 +17,7 @@
>  #include <linux/irqchip/arm-gic-v3.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
> @@ -1337,29 +1338,16 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pcie,
>  
>  static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
>  {
> -	struct device_node *msi_node;
> +	struct device_node *msi_node = NULL;
>  	int ret;
>  
>  	/*
>  	 * Either the "msi-parent" or the "msi-map" phandle needs to exist
>  	 * for us to obtain the MSI node.
>  	 */
> -
> -	msi_node = of_parse_phandle(pcie->dev->of_node, "msi-parent", 0);
> -	if (!msi_node) {
> -		const __be32 *msi_map = NULL;
> -		int len;
> -		u32 phandle;
> -
> -		msi_map = of_get_property(pcie->dev->of_node, "msi-map", &len);
> -		if (!msi_map)
> -			return -ENODEV;
> -
> -		phandle = be32_to_cpup(msi_map + 1);
> -		msi_node = of_find_node_by_phandle(phandle);
> -		if (!msi_node)
> -			return -ENODEV;
> -	}
> +	of_msi_xlate(pcie->dev, &msi_node, 0);
> +	if (!msi_node)
> +		return -ENODEV;
>  
>  	/*
>  	 * Certain revisions of the iProc PCIe controller require additional
> -- 
> 2.50.1
> 

