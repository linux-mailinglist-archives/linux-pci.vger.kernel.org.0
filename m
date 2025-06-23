Return-Path: <linux-pci+bounces-30400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AE7AE46AE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C87A5AE9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091B132122;
	Mon, 23 Jun 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgp1kFzI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665BF6136;
	Mon, 23 Jun 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688842; cv=none; b=L5no7iyJb9a83Q58eTJ/GCDi8m4LINTGG2scmNdWT3eMTDwosdGaI6nyeVdik78swgyb1E8VdbkSbqdICKjpYSixKfsPIptYo6kR7vZAjwG6zwYCcfpHqt27eZGl2Cphf8B4G77+t6FJIH85MB1tqsCLd72VbGGQFYF4fViihTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688842; c=relaxed/simple;
	bh=obH5Dm7/m7+LGG+XQUGVJ6QnqlXlUijJvUcYAnwt9Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS3K4OAaX50m2Y28y24kZmwdD083ifpKbexDQt+8b7MiNSUiNCtUbYv4arW53w4iEyvhLLRwIjLwFkRp9KtNhSaLsGfsxIk05meKv2/L09uG4+MHDAAFdHvqvVfdWWC7w1KXL8M3OaoDiK1z4xMGxBu+llv7QRvi/PNXrW31f58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgp1kFzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B330C4CEEA;
	Mon, 23 Jun 2025 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750688841;
	bh=obH5Dm7/m7+LGG+XQUGVJ6QnqlXlUijJvUcYAnwt9Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgp1kFzIgvBjqGQ6C7HoQFhrnC+4KUs4LI0n80N78e4X3B9D9WybLTCqoNk9sXoyA
	 xLWlzftVceySiFFceBgfTfRrvvdLtJ5wVglWvkPN/GBguzEK/OggZoD184zIcjsOp/
	 mUuxkUikNCPCQPLiXAGprm+PDB14IjBMu24hOPflfXMxbX16tdbTmbTGbuYINeuXVe
	 my6pUb3OtL59Y++4NFNifJSZW4wecLBPlqfRj1s0PmE8SuNHXTGHnF1xS0q1NE4QNP
	 TWYBHrAMyxTnT9cWcgUMp180tSOxtQg4GYRLLMhvKbw048A1Aldyxw5TkB08dHV3u0
	 ecgR5EbiuusEg==
Date: Mon, 23 Jun 2025 08:27:19 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after
 link-up IRQ
Message-ID: <ebrnndrw7kifuyixh4umos6ozhg3a45ya2ooxrf44xytdpiczs@qtd2l4tc63kt>
References: <20250613124839.2197945-8-cassel@kernel.org>
 <20250613124839.2197945-12-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613124839.2197945-12-cassel@kernel.org>

On Fri, Jun 13, 2025 at 02:48:43PM +0200, Niklas Cassel wrote:
> Per PCIe r6.0, sec 6.6.1, software must generally wait a minimum of
> 100ms (PCIE_RESET_CONFIG_WAIT_MS) after Link training completes before
> sending a Configuration Request.
> 
> Prior to 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect
> Link Up"), qcom used dw_pcie_wait_for_link(), which waited between 0
> and 90ms after the link came up before we enumerate the bus, and this
> was apparently enough for most devices.
> 
> After 36971d6c5a9a, qcom_pcie_global_irq_thread() started enumeration
> immediately when handling the link-up IRQ, and devices (e.g., Laszlo
> Fiat's PLEXTOR PX-256M8PeGN NVMe SSD) may not be ready to handle config
> requests yet.
> 
> Delay PCIE_RESET_CONFIG_WAIT_MS after the link-up IRQ before starting
> enumeration.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")

Shouldn't 36971d6c5a9a be the fixes commit?

- Mani

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c789e3f85655..9b12f2f02042 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1564,6 +1564,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
>  
>  	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
>  		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
>  		/* Rescan the bus to enumerate endpoint devices */
>  		pci_lock_rescan_remove();
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

