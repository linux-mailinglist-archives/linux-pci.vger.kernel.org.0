Return-Path: <linux-pci+bounces-11453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3297294AE2C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 18:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625CA1C20FEC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9524313AD0F;
	Wed,  7 Aug 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keIhy56N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D213A899;
	Wed,  7 Aug 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048269; cv=none; b=pTTsq3bITK7fXyefAXKQosOU2IfiktGw8+LTjB7eZZxeRkOnP6XMcQ1bYEeFHAtZRyybtUczI+iYNCrLCryAOu3WQfswmcTI8teP5MJMdywtp6wL7kEwOaWHiwPWxnVx0rFlLXFIMn453R0IiVHvEpG8qD2t4nqhnYsOztogkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048269; c=relaxed/simple;
	bh=2e+tvdvnlJd7UATAhp/GJlLecWbDRVPYL2/x3pyVJ0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZVSstUApcrrUN+6whO+AfN56Zvv4Auj1h0lvyM/uZb0VhcXZXvlYEYsqorTR6hehpXnOsrremln3OezWsG+wPGNBGzwBUp2uGKPaL/RZiml7IlarQYFkiJbAlEACbxll60yVAtmTduVWyzwY2okR/vI00ldLmsVfpstdcm2je44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keIhy56N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEEBC32781;
	Wed,  7 Aug 2024 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723048269;
	bh=2e+tvdvnlJd7UATAhp/GJlLecWbDRVPYL2/x3pyVJ0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=keIhy56NccKd3cSYOWoIYBMx0wp5cSwr+5tt3fGWDAvug1H2LN7tiOrQIN0E/3V2w
	 OS/DOKg0R03XxmD7+96PKgCTJdOxCK+k2zSYEpMwb12kSRItPmKS/UQuwT+3W2TUTJ
	 yMi798279uizDzmJPqMJRQgiYOf4Hzk5l62Uo6fR7CD6d+eOspzUZtuW8evLoON/07
	 L9i6IVbJp4jwod2jXyJ7ONwuJYqJrDNDPllpUym44mVN9rGMBmCp0zRadv2v6gO1Hs
	 NNaXB2lQN7LlD2VGkREoAtORj4kF40HPXZ63BqLM7w/3hcVlVy32gTUd5EpXR/imLl
	 2gSWO113S2OnA==
Date: Wed, 7 Aug 2024 11:31:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linu-next v1] PCI: dw-rockchip: Enable async probe by
 default
Message-ID: <20240807163106.GA101420@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625155759.132878-1-linux.amoon@gmail.com>

On Tue, Jun 25, 2024 at 09:27:57PM +0530, Anand Moon wrote:
> Rockchip PCIe driver lets waits for the combo PHY link like PCIe 3.0,
> PCIe 2.0 and SATA 3.0 controller to be up during the probe this
> consumes several milliseconds during boot.

This needs some wordsmithing.  "driver lets waits" ... I guess "lets"
is not supposed to be there?  I'm not sure what the relevance of "PCIe
3.0, PCIe 2.0, SATA 3.0" is.  I assume the host controller driver
doesn't know what downstream devices might be present, and the async
probing is desirable no matter what they might be?

> Establishing a PCIe link can take a while; allow asynchronous probing so
> that link establishment can happen in the background while other devices
> are being probed.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 61b1acba7182..74a3e9d172a0 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -367,6 +367,7 @@ static struct platform_driver rockchip_pcie_driver = {
>  		.name	= "rockchip-dw-pcie",
>  		.of_match_table = rockchip_pcie_of_match,
>  		.suppress_bind_attrs = true,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe = rockchip_pcie_probe,
>  };
> -- 
> 2.44.0
> 

