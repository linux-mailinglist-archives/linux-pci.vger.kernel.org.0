Return-Path: <linux-pci+bounces-8690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 761DE905C9F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 22:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4101F21A67
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24FB84A51;
	Wed, 12 Jun 2024 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+4dAogs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92DD5025E;
	Wed, 12 Jun 2024 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223276; cv=none; b=uS/tCNWSfY64WICXqtRl2ngyLNbbocVJM+dJAKPzTlYcXAZKADK3YfiVUs8PynIN0Rh5WPcenz8f5qVkA2lAv/PfU6BjbFJklc7p04aC5DpfPhi2ndjxDwV5aN7SvfzBf6Lm8l/ptRP5v6qxDwKa8GqUw3v/SHTec1DdNwY7OZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223276; c=relaxed/simple;
	bh=MM9GEdJsPlXpFb2M3Z4w8ZvYjz6JLC6YXN3uE1YH/CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Nv8Oo+AM5qMeWoBGoTJIq4qrCPFLYB8iZH1OWfYVVGk01ErXIirtEqY6zhMHAkYdBvOFX9j488yHnnBLt7wu/cAoJ7R8aduXhYiJ6gOX8R+9GLoiahjs2Iozxs29mih4RuTYBGICr2rHodyRtdytfFMR1xdkIG0wMbM1j+h+QBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+4dAogs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A3C116B1;
	Wed, 12 Jun 2024 20:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718223276;
	bh=MM9GEdJsPlXpFb2M3Z4w8ZvYjz6JLC6YXN3uE1YH/CQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q+4dAogsM+MDBvicypa93GOR3NSEX3i2GQsRfq/p3UUKrNtBd4zPHl0qvrMGKbsW/
	 /FhIjUu1O9v79CVCpQ9ejrykFNohAGkJR0pp3zkHOT7Dpjq1fd2RUJ6l+3wSMXIrlv
	 BCkT7e4Ofr0RDuxHHH3+gIBv51PyPhqR5st7FKm6moPBO5s1QgqTrhs7SaFcXePO5N
	 oDC70JtqoDVk5KNcSJ101JG5sSl+oGr6wZn2gBP1i7mcLC0HXmtrF6hKi9HyO1WEoU
	 byC6aO3Ct+eqr44MEatPrpmrVAWSToH+apu/dOlomGskNBRprgazh+NbCnxXVQD/2Y
	 y/l7ybteIRVCQ==
Date: Wed, 12 Jun 2024 15:14:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Songyang Li <leesongyang@outlook.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH]  PCI: Cancel compilation restrictions on function
 pcie_clear_device_status
Message-ID: <20240612201432.GA1035119@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB275469F17C8C5389C18313BBB4C02@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>

On Wed, Jun 12, 2024 at 11:15:43PM +0800, Songyang Li wrote:
> On Tue, 11 Jun 2024 17:34:18 -0500, Bjorn Helgaas wrote:
> > Unindent this.
> 
> > Add "()" after function names.
> 
> > Please explain what this patch does and why we want it.  I can see
> > from the patch that it makes it so pcie_clear_device_status() is
> > always compiled, but the commit log should say that and should say why
> > we need that.
> 
> Thank you for reminding to add "()" after function pcie_clear_device_status.
> The following is a revised patch,and it explains why we need that.
> Thanks,
> 
> Songyang Li
> 
> From 3c1340522565a44ef25d2045e5bee2c0bdb72b32 Mon Sep 17 00:00:00 2001
> From: Songyang Li <leesongyang@outlook.com>
> Date: Wed, 12 Jun 2024 22:29:51 +0800
> Subject: [PATCH] PCI: Cancel compilation restrictions on function
>  pcie_clear_device_status()
> 
> Some PCIe devices do not have AER capabilities, but they have
> device status registers. The PCIe device status register and
> AER register are independent PCIe capabilities, so it is
> unreasonable to use CONFIG_PCIEAER for compilation control of
> pcie_clear_device_status(), although which is currently only
> used in the "aer.c", "edr.c", and "err.c". Some operating system
> configurations do not enable the AER feature, but still expect to
> use the device status register for simple RAS. In this case,
> pcie_clear_device_status() can be used to clear the device status
> regs, so this patch can meet the requirements of this scenario.

I think all current any callers of pcie_clear_device_status() are also
under CONFIG_PCIEAER, so I don't think this fixes a current problem.

As you point out, it might make sense to use
pcie_clear_device_status() even without AER, but I think we should
include this change at the time when we add such a use.

If I'm missing a use with the current kernel, let me know.

> Signed-off-by: Songyang Li <leesongyang@outlook.com>
> ---
>  drivers/pci/pci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 drivers/pci/pci.c
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> old mode 100644
> new mode 100755
> index 35fb1f17a589..e6de55be4c45
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2263,7 +2263,12 @@ int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
>  }
>  EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
>  
> -#ifdef CONFIG_PCIEAER
> +/**
> + * pcie_clear_device_status - Clear device status.
> + * @dev: the PCI device.
> + *
> + * Clear the device status for the PCI device.
> + */
>  void pcie_clear_device_status(struct pci_dev *dev)
>  {
>  	u16 sta;
> @@ -2271,7 +2276,6 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> -#endif
>  
>  /**
>   * pcie_clear_root_pme_status - Clear root port PME interrupt status.
> -- 
> 2.34.1
> 

