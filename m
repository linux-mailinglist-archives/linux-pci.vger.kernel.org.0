Return-Path: <linux-pci+bounces-42866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD854CB0E4F
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 19:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB68F30191A9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B6303A0A;
	Tue,  9 Dec 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4HHrk3y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54E1DF248;
	Tue,  9 Dec 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306760; cv=none; b=NCdF3seurqkpbggG2WlKjnfc45ijqt8w4Z2+I0nSDdrcL6Fj7KTDEscj5DfPATIr+28qcRRfjvIBGP9xE+Q5sKc43Tua2nR5g9KyVG6MIvtDJYeUdqItI3D/iTuI5Y64s2q6LsKZr/loyjspMMIdNLQvyfxyN+oZJHkGDLijWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306760; c=relaxed/simple;
	bh=u+0q6KEIw2uu1QxHux2h5LtoGWkW8Fj3YPG9mR/cSaI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QnqaMQ4+TnNpnAyf6qZ87PS1HoPpwPqSC4mSeZQVAxbDToGetR8bESlMVCMKpgNQey4MCX9deN8amjFMETEolxB311uaoKK/f1zYvrlhJHC7XtjXsRSkYYkH4TibFUJgybADA3ViY376ebUA8Ty7cZwO3/eV/7Bvb1cBPhmWSNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4HHrk3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584EEC4CEF5;
	Tue,  9 Dec 2025 18:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765306759;
	bh=u+0q6KEIw2uu1QxHux2h5LtoGWkW8Fj3YPG9mR/cSaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O4HHrk3yKHnVBlXnbs8NB3+MyN2vGPNt8WYDBozF/tXlbP+RX+zBtmMbBEYIchBqp
	 kvp3mrY/+zh7Ai2fpCUq7SVjusqZ/x2A1mvMs+nbRNzCW/GYElfTkqpMwsQpq9Qp9U
	 qAn68Zg7y4c+EcLMrQ0y42JM2DcxLJJR0N6AmdcUKvBZg19s/zncCfFLriBzXU14g0
	 YAkHT3VT25xSdYSc27iR+JLMv8KxlbQuF0EqoRWeu8IhjN699IUcKl7qGdGoB8DkUw
	 zAJHiFW46dIF3WVt6VSnYFOZd09KduYYgJ/5A8YnTrEb2AZIKcG/5t3r2zY2COGpIh
	 CEDdgNjEGnc9Q==
Date: Tue, 9 Dec 2025 12:59:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: rzg3s-host: Fix compilation warning
Message-ID: <20251209185918.GA3477210@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209125122.304129-1-claudiu.beznea.uj@bp.renesas.com>

On Tue, Dec 09, 2025 at 02:51:22PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Fix "bitmap is used uninitialized" compilation warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202512070218.XVMUQCl7-lkp@intel.com
> Closes: https://lore.kernel.org/all/202512061812.Xbqmd2Gn-lkp@intel.com
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Updated commit log as below (the problem is the use of initialized
data, not the warning itself) and applied to pci/for-linus for v6.19,
thanks!

  PCI: rzg3s-host: Initialize MSI status bitmap before use

  Initialize rzg3s_pcie_msi_irq() MSI status bitmap before use.

  Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")

> ---
>  drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 667e6d629474..83ec66a70823 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -479,7 +479,7 @@ static void rzg3s_pcie_intx_irq_handler(struct irq_desc *desc)
>  static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
>  {
>  	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
> -	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR);
> +	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR) = {0};
>  	struct rzg3s_pcie_host *host = data;
>  	struct rzg3s_pcie_msi *msi = &host->msi;
>  	unsigned long bit;
> -- 
> 2.43.0
> 

