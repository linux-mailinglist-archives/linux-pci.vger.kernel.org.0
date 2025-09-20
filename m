Return-Path: <linux-pci+bounces-36593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73851B8CB7F
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062DC1BC222A
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7F219301;
	Sat, 20 Sep 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIX0LMHj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66420FAA4;
	Sat, 20 Sep 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382293; cv=none; b=toIMISjUeuPPRqXbaPhQgfWqzmcPiWf2HQahpD2LC9zSLTCrC4DgprETC0CK8oOxSFKdKNyKm/YJtCnle0+5jhKS4LDDmo9i3WvDn9Qj9+da0/78ZPhrJVGsCBr6qF/0PvKn6HM4JyHrmR1Kpb6CMVS9SnTsc0U9rO768ikke1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382293; c=relaxed/simple;
	bh=gZqX2H7n0UEtTkfIc/RuIFUydJoKJ53JhCKjq8fs61I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dszTiz+BPn9SwKKgdwW5wbZvaLbpN0yMX6w8yl95UCWrZwNv7gUpX8cxLopK9koSNyM6y4UuOoVu5CJw8qyBz4IgDUaXAyhCopDFb0t8xOSkrC4QC4a/LL0krRwNKQNb4ZvtxWm4lSv4jZfkrcCsSDeBO131R4nUOl0iL+OXNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIX0LMHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4053C4CEEB;
	Sat, 20 Sep 2025 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758382293;
	bh=gZqX2H7n0UEtTkfIc/RuIFUydJoKJ53JhCKjq8fs61I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIX0LMHjsoHEyzTGaCYxixYg/Gw83ThsAZygSvEaBKxB3QAttPZRy5Z5T6IClHXRC
	 olHdCvvT6rKD4clpBS4qlS04R4l3x8CVtMi4eXr5xOdsPwsbtVQwkuhI0iCCStPnIK
	 N7mJHmHsspXygmYRaj80SyI6wixBkhQRIM/1nvln5Pm9ES1nS2DVELgScy9p8GgNVl
	 ptIIqHMZJy6wF6b4BsKaFNAicBYBm4KQf6aflaSJ3m56dcsEd6oyDeWmNRpWQLb+XZ
	 K8k0Cz9iDa/i4/SgNKr30Gu6rliPyEZ1F1bNQcQ7Bs1X0e4oHtQX3RCs/ddWw7eqiL
	 riIc565RExgYA==
Date: Sat, 20 Sep 2025 21:01:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Handle errors in BPMP response
Message-ID: <lvchydppqdxm4hy4kogkzinz4w2hllvsihg2ehvueth25sxi53@feqxeedvrs2o>
References: <20250911122728.1465254-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911122728.1465254-2-cassel@kernel.org>

On Thu, Sep 11, 2025 at 02:27:29PM +0200, Niklas Cassel wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> The return value from tegra_bpmp_transfer() indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> 
> If a host deasserts PERST without providing a refclock, enabling the PHY
> (via a tegra_bpmp_transfer() call) will silently fail, however, because
> we are lacking error handling, pex_ep_event_pex_rst_deassert() will still
> set pcie->ep_state = EP_STATE_ENABLED.
> 

How can a host deassert PERST# without providing refclk? As per the CEM spec
r4.0, sec 2.2, refclk should be active at least TPERST-CLK before PERST# is
deasserted.

So does this controller violate the spec? Even so, I don't know how an endpoint
could function if it relies on the host for refclk.

- Mani

> Because of this, any succeeding PERST deassertion will incorrectly be a
> no-op (because of the pcie->ep_state == EP_STATE_ENABLED check in
> pex_ep_event_pex_rst_deassert()), even if the host does provide a refclock
> during the succeeding PERST deassertion.
> 
> Add error handling to tegra_bpmp_transfer(), such that the pcie->ep_state
> can not get out of sync with reality, which will incorrectly cause the
> driver to think that it has been successfully initialized, which
> incorrectly makes future calls to pex_ep_event_pex_rst_deassert() a no-op.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> [cassel: improve commit log]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 0c0734aa14b68..8c5c370dbba5e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1214,6 +1214,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
>  	struct mrq_uphy_response resp;
>  	struct tegra_bpmp_message msg;
>  	struct mrq_uphy_request req;
> +	int err;
>  
>  	/*
>  	 * Controller-5 doesn't need to have its state set by BPMP-FW in
> @@ -1236,7 +1237,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
>  	msg.rx.data = &resp;
>  	msg.rx.size = sizeof(resp);
>  
> -	return tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	if (err)
> +		return err;
> +	if (msg.rx.ret)
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
> @@ -1245,6 +1252,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
>  	struct mrq_uphy_response resp;
>  	struct tegra_bpmp_message msg;
>  	struct mrq_uphy_request req;
> +	int err;
>  
>  	memset(&req, 0, sizeof(req));
>  	memset(&resp, 0, sizeof(resp));
> @@ -1264,7 +1272,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
>  	msg.rx.data = &resp;
>  	msg.rx.size = sizeof(resp);
>  
> -	return tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	if (err)
> +		return err;
> +	if (msg.rx.ret)
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

