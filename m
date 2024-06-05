Return-Path: <linux-pci+bounces-8341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118538FD41B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC6B2818EE
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFE2139D10;
	Wed,  5 Jun 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOieaknk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F517559;
	Wed,  5 Jun 2024 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608486; cv=none; b=kgP2zSMThEKr3fFY/yp0I3z1V55WxHStL8w723gFggcEshgH4kqei1KtQaArNFUll27ZvvJ61Th6oSM1e2YH58iCGv9RHo1ppU9ET6ddbmirBM9uAPnDzockDB9sklFwK4n1GzvyPFoLQXk8FJvGR0DTxC50ZHQzeRw2qW7JF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608486; c=relaxed/simple;
	bh=K0I4cU1U9cg/yjcUfTCVPlrV4fGTSRoE79eHHPCvGvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BCYzzN6ytR1XwuTAcLEASMd3ZzackdXcHlnJ6JgQPFUXbLa3ED1H39apK8hUnCL1rOvtQPQsgupqrqVW0eqMWdjVY0fxZmit6gTg2qZm/QyAac0zKrSGB6nbrH2VzCBTEveYc4hClzrOU2nCNhOOU2+4xhUGXUTxgvAuKJHtIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOieaknk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E54C2BD11;
	Wed,  5 Jun 2024 17:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717608485;
	bh=K0I4cU1U9cg/yjcUfTCVPlrV4fGTSRoE79eHHPCvGvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MOieaknkrAgx9wIISbY7CUO8IuX+8Bj0M0o4uHkGgL0TPfyfxWJH02aCX4VeCjUxf
	 irBkYzOMfSHck/ibvy/GKYpk7GUhS/4G8YsePsWWf0u4JoHXnwvbiRf4+ajyTpI1Oi
	 ZHt5Ibl5R+w6xyphQhymV0hUeVkZTjaL8L56y8NTvOy8nPDoXlSLa4exiwO0O0/jan
	 yDEONwA9eitib2v0MGlNOsAC4MZ9p1cE7A6elGSFIIKsJDAg6CKeapkZX9F0WyrmeH
	 g99MiYAd7UmmZ0icgy8ywIBRhUx81jFdL6CxCkWVfJ1UENqVX961dOOkKOhXMhd7oY
	 F1eGCNMIqU2Gw==
Date: Wed, 5 Jun 2024 12:28:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v8 5/5] misc: pci_endpoint_test: Document a policy about
 adding pci_device_id
Message-ID: <20240605172803.GA766828@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520074300.125969-6-yoshihiro.shimoda.uh@renesas.com>

On Mon, May 20, 2024 at 04:43:00PM +0900, Yoshihiro Shimoda wrote:
> To avoid becoming struct pci_device_id pci_endpoint_test_tbl longer
> and longer, document a policy. For example, if PCIe endpoint controller
> can configure vendor id and/or product id, you can reuse one of
> existing entries to test.

Possible text:

  Add a comment suggesting that if the endpoint controller Vendor and
  Device ID are programmable, an existing entry might be usable for
  testing without having to add an entry to pci_endpoint_test_tbl[].

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index c38a6083f0a7..727db13b6450 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -980,6 +980,7 @@ static const struct pci_endpoint_test_data j721e_data = {
>  	.irq_type = IRQ_TYPE_MSI,
>  };
>  
> +/* Do not add a new entry if the controller can use existing VID:PID combinations */

  /*
   * If the controller's Vendor/Device ID are programmable, you may be
   * able to use one of the existing entries for testing instead of
   * adding a new one.
   */

>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
>  	  .driver_data = (kernel_ulong_t)&default_data,
> -- 
> 2.25.1
> 

