Return-Path: <linux-pci+bounces-24148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEEA6962F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 18:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77FB3B9515
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BAC1F4C97;
	Wed, 19 Mar 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN+fkhgu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD91DF974;
	Wed, 19 Mar 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404700; cv=none; b=q/Yg55mUr0/kTUFTHIoTUC0421tYu1BQUwkFRV9vWEQmbRdY7Th6iOIcAoPDI0ub3A9xiZ3OC0/Qwnh0QtsuEizlIKpM4263Mcxb+IYczDfxQwaK9Y7Iwz7rmKgnhO+PddSW7Qx2a1AlTnjGyuwHBadTujp3lM3Rhy6r0LR49Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404700; c=relaxed/simple;
	bh=COjKKKAqWXituygICdph37IpjXioLyTXC6fIjGlTMXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VdF47If+Rh/2JWWQ9QOy5mmBxaqcmj/A9VfD1FRm/swsZ/u8aCLhwFxuC4JHh/XlHekMASl7IiYqfP7lh91smgsdGgjX9cJ++pqcgavT7RiMv4vkbcCGEWC1tlcHlxETwDXpsrmg3qeyPovHoTf3+fJLxeQL0Nd+VDeMFVCIusc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN+fkhgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CE0C4CEE4;
	Wed, 19 Mar 2025 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742404696;
	bh=COjKKKAqWXituygICdph37IpjXioLyTXC6fIjGlTMXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hN+fkhgurN/IueLqN6PdoCYfbQSzh6iSavYQ0C1MqHICYRuRHFSUMvPPhZzbc1FlJ
	 368ETyJ+DGSDbyOl7gw+chPSRqzHnWVPirFuccak/k/+CNAM6RzWxMtOzqXWdZ1oSo
	 c7I0ZZD4R/Cfsa7HLXEEUEdk0IuBbGSj3vLLfzfLrC9iNfhxzYwSCaRmv3onqwNPhk
	 ZCfVS47LV2QzsnSmzHAccp7a6AEDGFkWxGNR2Gc/3dHM1l8UhNdiNnfxh0TGrM4w1P
	 TgCTLjtsQNhpGSSe+OBtKi2dWTA4VO21poz805pniZDr8o5yFZitBlp1i+zdowjL7d
	 IT8jtFkvgmk9Q==
Date: Wed, 19 Mar 2025 12:18:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: don't assume the ops field in dw_pcie always
 exists
Message-ID: <20250319171814.GA1047025@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319134339.3114817-1-ioana.ciornei@nxp.com>

On Wed, Mar 19, 2025 at 03:43:39PM +0200, Ioana Ciornei wrote:
> The blamed commit assumes that the ops field from dw_pcie is always
> populated. This is not the case for the layerscape-pcie driver which
> does not provide a dw_pcie_ops structure. The newly added
> dw_pcie_parent_bus_offset() function tries to dereference pci->ops
> which, in this case, is NULL.
> 
> Fix this by first checking if pci->ops is valid before dereferencing it.
> 
> Fixes: ed6509230934 ("PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thank you very much!  Squashed into the "PCI: dwc: Add
dw_pcie_parent_bus_offset() checking and debug" commit so there will
be no bisection hole for this.

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index e68e2aac210f..b5fd44c0d6ad 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1170,7 +1170,7 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  
>  	of_property_read_reg(np, index, &reg_addr, NULL);
>  
> -	fixup = pci->ops->cpu_addr_fixup;
> +	fixup = pci->ops ? pci->ops->cpu_addr_fixup : 0;
>  	if (fixup) {
>  		fixup_addr = fixup(pci, cpu_phy_addr);
>  		if (reg_addr == fixup_addr) {
> -- 
> 2.34.1
> 

