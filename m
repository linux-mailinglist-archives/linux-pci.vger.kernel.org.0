Return-Path: <linux-pci+bounces-28337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD5FAC27B5
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7079189FA66
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766BB22256E;
	Fri, 23 May 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tejpb5wF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77FEC2;
	Fri, 23 May 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018032; cv=none; b=M9/MgrtlL3+E+xcbJFI7FeQF8XqnN6qzp2V1JfQjoFSCPn0vkioIp5s/95ikI5u6EzAKTyE2l1fScNs0s0XNBZbt71vP6Ple7Ew8uPbkeE/mHQN/946X1f8O+hA2kW26yM1qsvea8fquLZjGr0XXzaFFD2LUaU07INMI9/Lz6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018032; c=relaxed/simple;
	bh=TUwV5DtK2nuZFfbaXwitecvMLPb7B0LHIHp+CdFEYnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bQMLmoF1cws5oRjjeRSfp9ITOT9mrOxpQvZ9ONLkGUyx7/HCTQovy5LRcoyIooiq8fmnWReHTEnEqb27hbgxuKgZPmT9RjlUm7sAzR0oqogePAVkouk3+cC77gNSoS/z6V99hRra3qi7uRF7bUdmYXGU7Pa77dQt14MpNCasfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tejpb5wF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9769C4CEE9;
	Fri, 23 May 2025 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748018031;
	bh=TUwV5DtK2nuZFfbaXwitecvMLPb7B0LHIHp+CdFEYnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Tejpb5wFbSO4TIH9TFf8Fbi0332ZKxLYqrPFS6UV+ejxMl42h2+0TBkILAFJg6uLD
	 dwGhRoItD1Ci4i/T3yq4hASEzumOtp44FKJCcWK8UGakDeTb2lOmRMeSF8CnRVx8gE
	 i2YqoLjBDH8A4oI+Ixm31DcN3EbdYDlRkcLgQCbtOVE81g8osAJQn9Kgu8Izis1q3d
	 PvNtU2ZfI0LUc5ghwWlFdilUqk5fDFLU9WSDqIUAH5FwVWC2dogbH4BBlW1KHnYOzP
	 pmJE6bKYKtW0QvaUPGcm+eJuFD+9KOyEWt0lKLfI1E2y/AWiuQgVgb9GS5IxtGwjxa
	 RjkHw34IxJkmQ==
Date: Fri, 23 May 2025 11:33:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: altera: remove unused 'node' variable
Message-ID: <20250523163350.GA1566256@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521163329.2137973-1-arnd@kernel.org>

On Wed, May 21, 2025 at 06:29:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This variable is only used when CONFIG_OF is enabled:
> 
> drivers/pci/controller/pcie-altera.c: In function 'altera_pcie_init_irq_domain':
> drivers/pci/controller/pcie-altera.c:855:29: error: unused variable 'node' [-Werror=unused-variable]
>   855 |         struct device_node *node = dev->of_node;
> 
> Use dev_fwnode() in place of of_node_to_fwnode() to avoid this.
> 
> Fixes: bbc94e6f72f2 ("PCI: Switch to irq_domain_create_linear()")

Deferring this until bbc94e6f72f2 is merged.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> I checked the other PCI host bridge drivers as well, this is the
> only one with that problem.
> ---
>  drivers/pci/controller/pcie-altera.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index 0fc77176a52e..3dbb7adc421c 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -852,10 +852,9 @@ static void aglx_isr(struct irq_desc *desc)
>  static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
> -	struct device_node *node = dev->of_node;
>  
>  	/* Setup INTx */
> -	pcie->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), PCI_NUM_INTX,
> +	pcie->irq_domain = irq_domain_create_linear(dev_fwnode(dev), PCI_NUM_INTX,
>  					&intx_domain_ops, pcie);
>  	if (!pcie->irq_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -- 
> 2.39.5
> 

