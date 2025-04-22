Return-Path: <linux-pci+bounces-26374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF6A965DD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 12:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5B4178CAD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 10:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECEC1EDA2C;
	Tue, 22 Apr 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAhfaXt4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D752D1D799D;
	Tue, 22 Apr 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317590; cv=none; b=MIja9+Epeog0zZf2T3FMPnzV+tbDv3pkt+7ELc3Af9z1KJYOGhl9Xu0SRGTqz4GuMO6Jzq114QHoo7cdVJg3CXMkhk0kjCghoC5j2CNgRtPvZPDZXsKXTtFQ/rRvNVV6zY1QdFsaAGWENEMYEqMpiIny5/J0wmBlEgmavO+WGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317590; c=relaxed/simple;
	bh=a48T1W6ayZnSmBTLl9Hby5irJfOBZFiPxukJ54xS6Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRtA2b8UMorhq2Bt9XKORXjdUmbiAcpMyscC1YfYKSThh0rRKX8PK6UHlUeQyzwla4kncuudr5zmYdJ3FBmFUU5Z4LvkKOsmRbFIRGp7R9UmZIVBSeePn3ejd243PKxXySuRoNGeRJqGb2h10LHGB8mF/TrSGiStxz1NJ837gK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAhfaXt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881A5C4CEE9;
	Tue, 22 Apr 2025 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745317589;
	bh=a48T1W6ayZnSmBTLl9Hby5irJfOBZFiPxukJ54xS6Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAhfaXt4FivY0Ggc8JbjcyVTm5fBgEgFFJ+HJs2jmAcmeivMjfAOuuhJn0rIgcbfD
	 KxP6kQdwbjsGzKn6/6WOUVKSywylazAXEAcMHA7oGsA8Y0I57BdQEMWNp875LvvfNc
	 IV+z7n4+Gopkt4J83v90H2/w514iwInHmnfkTf45b5o9xYaVd7gqAwcqojzCLVQuqK
	 Pq0WCBUWD5Zj3uaeDzuH3ORbFZuD80XBg8GJGQyd6rcsTubFbANc/hl3K71Iu7a6qO
	 p9XQy2QBswSu6Xc9yW13ZN7KhD5YI5PprLcEAWIc124ZZhklfAM/GQeN7Yg56ELQBt
	 JYFYJ7VKBtVVw==
Date: Tue, 22 Apr 2025 12:26:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Fix function call sequence in
 rockchip_pcie_phy_deinit
Message-ID: <aAdu0ODyj7FkVarb@ryzen>
References: <20250417142138.1377451-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142138.1377451-1-didi.debian@cknow.org>

On Thu, Apr 17, 2025 at 04:21:18PM +0200, Diederik de Haas wrote:
> The documentation for the phy_power_off() function explicitly says
> 
>   Must be called before phy_exit().
> 
> So let's follow that instruction.
> 
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Cc: stable@vger.kernel.org	# v5.15+
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c624b7ebd118..4f92639650e3 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -410,8 +410,8 @@ static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
>  
>  static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
>  {
> -	phy_exit(rockchip->phy);
>  	phy_power_off(rockchip->phy);
> +	phy_exit(rockchip->phy);
>  }
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -- 
> 2.49.0
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

