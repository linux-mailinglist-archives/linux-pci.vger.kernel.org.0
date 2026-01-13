Return-Path: <linux-pci+bounces-44616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADFFD19A6C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D699300B914
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B42C0269;
	Tue, 13 Jan 2026 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQOyjrxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB83A1C9;
	Tue, 13 Jan 2026 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316006; cv=none; b=EAXg0IlRMllvpIGvdtk9pB2+0fQbgly+xGC0kC6AurD109ldEN8tcWmJUz9Zym9UvneoC5/bRRM8fE0bwusR4qOkzvw6AZzMp7Xkz86SK2hBEIjkHG7tQpYyRvd31w827atBZPTnhGxLjxDzZCNE/b4V7HbeZounP2memWlG7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316006; c=relaxed/simple;
	bh=13J+pQIw/u+4RI4SvEvhIXQHkqwOSYCQ1h7z8QKPu1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKVNMDuJJWOVSDNIHxUZh3hLWiDmqFCyiFx8CYUIsm/kOovtVTrJFZ/WOQL/BKHcbgOe7tpIxzLiNignfLrzXFiORPkRHERMKFO2suXdeKNc6GSHzXd74QaIC8ngDtn5HSSgCmSuI9GFyGaDf1W7TRrbiPTLchvvKszbIuKnvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQOyjrxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2DCC16AAE;
	Tue, 13 Jan 2026 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768316006;
	bh=13J+pQIw/u+4RI4SvEvhIXQHkqwOSYCQ1h7z8QKPu1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQOyjrxZ5a0ku/vfgo4KCnm3vlKCtmm/3Q+XetNcFzhdWd83ncKqQLDk3tvVF/1vJ
	 SvP0AQNe1oZ+Gg24NkVNHlJ7f343T21+1EsbHVPoHt7D79NujcNAmydM/IjsOasxo/
	 IfTlR9bDbU00ssBCLel9MTX+QGF+2zKto0giU5nVz1gTJPP4Sgs8W6qDeSS9hexvFX
	 PPbfPzSeernXaMRSGKQ/DClW0DpdIUClQZJhaPNGHd7oo0bwqzTvLf8/6SHXbEVef+
	 9rxXx7B4Gpo3Wqu3ejb33nSJdHS6fCdcy4TCyUUq3OBAUJOA61b5722yeWoraGHCLA
	 6EsJYuG4kB9CQ==
Date: Tue, 13 Jan 2026 20:23:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Han Gao <rabenda.cn@gmail.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH] PCI/sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root
 Ports
Message-ID: <rbypcgy3laht64wrjdnpo2xgjcuriy2avmeo5kxlpqdw5mk4lk@lwyjoq5p62iq>
References: <20260109040756.731169-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109040756.731169-2-inochiama@gmail.com>

On Fri, Jan 09, 2026 at 12:07:54PM +0800, Inochi Amaoto wrote:
> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms") force enable ASPM on all device tree
> platform, the SG2042 root port breaks as it advertises L0s and L1
> capabilities without supporting it.
> 
> Override the L0s and L1 Support advertised in Link Capabilities in
> the LINKCTL register of SG2042 Root Ports, so it doesn't try to enable
> those states.
> 

You need to disable L0s and L1 capabilities in LNKCAP. LNKCTL change is
volatile, since both PCI core and userspace can override it as long as the
capabilities are supported.

- Mani

> Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <gaohan@iscas.ac.cn>
> ---
> Change from original patch:
> 1. use driver to mask the ASPM advertisement
> 
> Separate from the folloing patch
> - https://lore.kernel.org/all/20251225100530.1301625-1-inochiama@gmail.com
> ---
>  drivers/pci/controller/cadence/pcie-sg2042.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> index 0c50c74d03ee..9c42e05d3c46 100644
> --- a/drivers/pci/controller/cadence/pcie-sg2042.c
> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> @@ -32,6 +32,15 @@ static struct pci_ops sg2042_pcie_child_ops = {
>  	.write		= pci_generic_config_write,
>  };
> 
> +static void sg2042_pcie_disable_l0s_l1(struct cdns_pcie *pcie)
> +{
> +	u32 val;
> +
> +	val = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCTL);
> +	val &= ~PCI_EXP_LNKCTL_ASPMC;
> +	cdns_pcie_rp_writew(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCTL, val);
> +}
> +
>  static int sg2042_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -68,6 +77,8 @@ static int sg2042_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
> 
> +	sg2042_pcie_disable_l0s_l1(pcie);
> +
>  	return 0;
>  }
> 
> --
> 2.52.0
> 

-- 
மணிவண்ணன் சதாசிவம்

