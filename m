Return-Path: <linux-pci+bounces-19688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B26A0C289
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 21:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA30165BBB
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 20:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD461CBE94;
	Mon, 13 Jan 2025 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHWuHhHn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856ED1BD9D8;
	Mon, 13 Jan 2025 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736799749; cv=none; b=YgMMPWP6nzf8+5l/Lqpjf11uokFTrL/+wUuRdPAoqHvHr0Cuzbhil/Ar1kv6qyCxALzkzZttdhVOFh74XQAagE1K1ytXqWMeVUdgHGis1SImDwygOpmwuXBKNdVK1t0dDV/gJYIxhoMG8f6XM57Y84nYQoSSWcfbTL1Ink8HFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736799749; c=relaxed/simple;
	bh=4XBsIsziAr422cRjy/WKCVKgVG1YXMwN58TxJtr6+5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=unP856KtcgymhVstset0sl3OMfgS8k6Rp4rc9Awf4XEyhSS7mreKLS12i3ObHJ13cNR73Rq5X38dP0QKzvMDF/EgZBdxR+FUXrReS1VPARyWfqoM0QhVT9SjngLNESq5XP8M0iGTxwGYVG91Cpcbn1H0Gr3sCY2LxNBoUIkl74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHWuHhHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE748C4CED6;
	Mon, 13 Jan 2025 20:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736799749;
	bh=4XBsIsziAr422cRjy/WKCVKgVG1YXMwN58TxJtr6+5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AHWuHhHnfKQrdFZTiZDwYEjqgFR6aq6ew0yAp3HDahpOWJMmbsvyso/AZlw4SrZph
	 hKRufIBPagMUNxFbWZ9Qjvo3+DFt5ufFZHxAhaU6Y0+sDfJhDbfVCiZnPKuR8Nk0TC
	 4bSigVWPsRMlrYwWC9BvWbcm2VIcGF0SL03eO37EqIM1/3nByWnMrnCBp51ZGv3BqI
	 UyWRmxz375UMEUqN68pVzZKeBa6JFZ/bDglBmsL/TsUjm8qqLdOMJsCWobg7LE4oLF
	 jyd2EEMUPKNcxZgZFJGrKsPfolj8ob7uCNb+xlqaNFGIo3P6Aw3wslqZOA0sns9r1G
	 ghu4BfDWwF6qA==
Date: Mon, 13 Jan 2025 14:22:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
Message-ID: <20250113202226.GA420041@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>

On Mon, Jan 13, 2025 at 11:59:34AM +0100, Niklas Cassel wrote:
> The Root Complex specific device tree binding for pcie-dw-rockchip has the
> 'sys' interrupt marked as required.
> 
> The driver requests the 'sys' IRQ unconditionally, and errors out if not
> provided.
> 
> Thus, we can unconditionally set use_linkup_irq before calling
> dw_pcie_host_init().
> 
> This will skip the wait for link up (since the bus will be enumerated once
> the link up IRQ is triggered), which reduces the bootup time.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to pci/controller/dwc for v6.14, thanks!

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 1170e1107508bd793b610949b0afe98516c177a4..62034affb95fbb965aad3cebc613a83e31c90aee 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -435,6 +435,7 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
>  
>  	pp = &rockchip->pci.pp;
>  	pp->ops = &rockchip_pcie_host_ops;
> +	pp->use_linkup_irq = true;
>  
>  	return dw_pcie_host_init(pp);
>  }
> 
> ---
> base-commit: 2adda4102931b152f35d054055497631ed97fe73
> change-id: 20250113-rockchip-no-wait-403ffbc42313
> 
> Best regards,
> -- 
> Niklas Cassel <cassel@kernel.org>
> 

