Return-Path: <linux-pci+bounces-1393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 531BD81EAD3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 00:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033BF1F21ADB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 23:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809C6127;
	Tue, 26 Dec 2023 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZmb+/AR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87E5C9C;
	Tue, 26 Dec 2023 23:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60DEC433C8;
	Tue, 26 Dec 2023 23:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703635189;
	bh=qL1wC5X84nPiUycGi2oBV74C3XrBRi70qn0cE9NjEuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oZmb+/ARlpg5Vk9sAtF9KzheCjXEuUzBHt4QSukwKfevMLwNuA718EHgKWkezuSap
	 FnpUUIw2CJIWFLQPekgw2XMyfGkCwvlN8pNx7oh6R/opBliTvtAUC/rSEnYzVtU3z7
	 nVzgIA6Df0IdTnlg2I+Ij9sWbQl5JhwO9Acj9+ZtIe8qs7+3bqRGL7HG0WYOrwz4l+
	 HBNoxyb9vP1WtIXzoa9a2mNY+lJqGmWlg4l4FeBdNWane0edoijGuRna4lt9hm33vI
	 a944CVCRqrBPPfgCkbca+6pU4km9DzyULAF8AWehhec5vtEMv7iV4I+G0PghkeoRfp
	 AppR4fTl7e5MA==
Date: Tue, 26 Dec 2023 17:59:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Joseph <tjoseph@cadence.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: Fix TI J721E PCIe SoC dependencies
Message-ID: <20231226235947.GA1483922@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220113214.413632-1-pbrobinson@gmail.com>

On Wed, Dec 20, 2023 at 11:32:08AM +0000, Peter Robinson wrote:
> The J721E PCIe is hardware specific to the TI SoC parts
> so add a depenency on that so it's available for those

dependency

> SoC parts and for compile testing but not necessarily
> everyone who enables the Cadence PCIe controller.

Wrap to fill 75 columns.

The subject could possibly be more specific than "fix", e.g.,

  PCI: cadence: Make TI J721E depend on ARCH_K3

> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/pci/controller/cadence/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 291d12711363..1d5a70c9055e 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -47,6 +47,7 @@ config PCI_J721E
>  
>  config PCI_J721E_HOST
>  	bool "TI J721E PCIe controller (host mode)"
> +	depends on ARCH_K3 || COMPILE_TEST
>  	depends on OF
>  	select PCIE_CADENCE_HOST
>  	select PCI_J721E
> @@ -57,6 +58,7 @@ config PCI_J721E_HOST
>  
>  config PCI_J721E_EP
>  	bool "TI J721E PCIe controller (endpoint mode)"
> +	depends on ARCH_K3 || COMPILE_TEST
>  	depends on OF
>  	depends on PCI_ENDPOINT
>  	select PCIE_CADENCE_EP
> -- 
> 2.43.0
> 

