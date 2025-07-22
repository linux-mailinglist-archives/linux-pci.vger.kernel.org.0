Return-Path: <linux-pci+bounces-32762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8BB0E6DC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 01:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6FF7B632D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517025A32C;
	Tue, 22 Jul 2025 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dke1QX+a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4F19DF62;
	Tue, 22 Jul 2025 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225403; cv=none; b=Ty+Z8BtTtptqXHWVJKSgPB/vs40dq3SUxm8TQY4TOBNvF1HQgyxxU6/kKlAK3MBNfafPFH2VrwbZBTYxbQ9ZIoGt+dHpyfU3CFGrpD2SeXeBHOQI3h27JbZ+kl36q8dr5TmkExmxBfms/zgHXGDAyMXy8lZWcIXQ9GirnjWCUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225403; c=relaxed/simple;
	bh=H4/Fw/YMMr0MMtlaU/LX3CjtnXZ0L6wq4mkRrxSMTNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uyb0mO83ocy+dT4eyZr3UHAmdNZc4O6fsCi+SWobVzUEZmEqjTycToK/spFZUy5qJGYb2q343hYcmsaZ0HU9gBGAG9BfbeJCWiw7TlQPce7ig1305NKMcR6TGVkAj7WuUHi30bhz6A6aPMFtr7h4VZVl5CB1Nyhv94JPVTv/SlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dke1QX+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A27C4CEEB;
	Tue, 22 Jul 2025 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753225403;
	bh=H4/Fw/YMMr0MMtlaU/LX3CjtnXZ0L6wq4mkRrxSMTNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Dke1QX+a+FR7P/hDbBEi1WxSbuHdxEb91hDy/7lOn8xOFpSytQgbqTUxnNf2cXPKF
	 z5Rl2nM5IUObXDSbi/j/pvgdcCXW3lweVx1yKK1UYQUKki9ZL3cLyKBNKfHnTDXFAr
	 iXYcO6bx3woIrlTswLh/oglT2XjesWnv37NMr5NGcWGJfEbHZE5/XWw58PfyfaK8If
	 Z64RaAaIjn1UDHel+QGoY7nffWy9uPzye8t/oPKix3ZiBUVjmvmLTTaNrVpp3+2kNQ
	 vkNuCoSlKf9ouoMShWHIKMTiHoPkdW9M/rsImNAgnmkYGPUyr3P+t/mRk6H5fd2QEi
	 8ThN+5bYvlLPg==
Date: Tue, 22 Jul 2025 18:03:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Vipin Sharma <vipinsh@google.com>,
	Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH v2] PCI: Support Immediate Readiness on devices without
 PM capabilities
Message-ID: <20250722230321.GA2861805@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722155926.352248-1-seanjc@google.com>

On Tue, Jul 22, 2025 at 08:59:26AM -0700, Sean Christopherson wrote:
> Query support for Immediate Readiness irrespective of whether or not the
> device supports PM capabilities, as nothing in the PCIe spec suggests that
> Immediate Readiness is in any way dependent on PM functionality.
> 
> Fixes: d6112f8def51 ("PCI: Add support for Immediate Readiness")
> Cc: David Matlack <dmatlack@google.com>
> Cc: Vipin Sharma <vipinsh@google.com>
> Cc: Aaron Lewis <aaronlewis@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Applied to pci/enumeration for v6.17, thanks!

> ---
> 
> v2: Move logic to pci_init_capabilities() instead of piggybacking the
>     PM initialization code. [Vipin, Bjorn]
> 
> v1 [RFC]:  https://lore.kernel.org/all/20250624171637.485616-1-seanjc@google.com
> 
>  drivers/pci/pci.c   |  4 ----
>  drivers/pci/probe.c | 10 ++++++++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9e42090fb108..4a1ba5c017cd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3205,7 +3205,6 @@ void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
>  void pci_pm_init(struct pci_dev *dev)
>  {
>  	int pm;
> -	u16 status;
>  	u16 pmc;
>  
>  	device_enable_async_suspend(&dev->dev);
> @@ -3266,9 +3265,6 @@ void pci_pm_init(struct pci_dev *dev)
>  		pci_pme_active(dev, false);
>  	}
>  
> -	pci_read_config_word(dev, PCI_STATUS, &status);
> -	if (status & PCI_STATUS_IMM_READY)
> -		dev->imm_ready = 1;
>  poweron:
>  	pci_pm_power_up_and_verify_state(dev);
>  	pm_runtime_forbid(&dev->dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..d33b8af37247 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2595,6 +2595,15 @@ void pcie_report_downtraining(struct pci_dev *dev)
>  	__pcie_print_link_status(dev, false);
>  }
>  
> +static void pci_imm_ready_init(struct pci_dev *dev)
> +{
> +	u16 status;
> +
> +	pci_read_config_word(dev, PCI_STATUS, &status);
> +	if (status & PCI_STATUS_IMM_READY)
> +		dev->imm_ready = 1;
> +}
> +
>  static void pci_init_capabilities(struct pci_dev *dev)
>  {
>  	pci_ea_init(dev);		/* Enhanced Allocation */
> @@ -2604,6 +2613,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	/* Buffers for saving PCIe and PCI-X capabilities */
>  	pci_allocate_cap_save_buffers(dev);
>  
> +	pci_imm_ready_init(dev);	/* Immediate Ready */
>  	pci_pm_init(dev);		/* Power Management */
>  	pci_vpd_init(dev);		/* Vital Product Data */
>  	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
> 
> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

