Return-Path: <linux-pci+bounces-39733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA6C1DACB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DCA14E4A2A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0448299AB1;
	Wed, 29 Oct 2025 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFPw5cOc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AE222562;
	Wed, 29 Oct 2025 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779860; cv=none; b=FA/FOamV9zRNqZ5orkWPW0dOS9VJ00U6B4V/OShzGYRnQxEI5MXQNAC4RrLvh7o7p226R3pPHcear0KoRCG0cPl18bwb+KoBGs5BTbx72QzNxTgWVKFqkbtmYvviSBkahcwtg1MZFdP9an9bz68k2aRM98eBW6gFwkkFl8vbWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779860; c=relaxed/simple;
	bh=aFz6dNrVlKIsZLpN20nJ2pqC29DlAbSGUScdk1UfEz8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l9cOzqGPx6c5qqNPgFrmmLdTMxLnWUMtrXIBtM7p7tj4hTaW6Us8yGtgry8tNmTW1c9TPSYfSon2XRO5Rk311WAuZwjMIHX2LUAobuRlGLBMgwU9yZH+9+yBfew0RxJHdI4cQWDOf5/O5R3ToRZVI7f9SvOkMVW6TrSFBPYUCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFPw5cOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126F7C4CEF7;
	Wed, 29 Oct 2025 23:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761779860;
	bh=aFz6dNrVlKIsZLpN20nJ2pqC29DlAbSGUScdk1UfEz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bFPw5cOcCeFltvMCeaFuRH9GwUMurde5R12RYt+oJg3qbctMpxuK5FXdcZ6ygBwLS
	 9VDIdDWrNlpnvsTL+FeMImz7l6LF3AGWv9MC2RM7YeV3NyuTmVaYowz2oFdvIAa6Q0
	 Gqqnm60U7PCSxtUKbus8yFgeae/L7bVwy2gs+dPXFROrxO9dHFZW4dYvhI9GacMf4d
	 4YGszKJGMSs6hWZHUNq9qFaYSsAfKWnRiWMTAlHIy0NksgYmzmchkRna1ba62HWwqE
	 b3lUz9uzLuOYisZfBFpOSuGv48ZaQTEUOy7ZGVyJ5dhWiIFMi6HZS23JUd9eyyrROP
	 I9Ui74I1Y8SCg==
Date: Wed, 29 Oct 2025 18:17:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v4 9/9] PCI: dwc: support missing PCIe device on resume
Message-ID: <20251029231738.GA1601908@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-9-ce2e1b0692d2@collabora.com>

On Wed, Oct 29, 2025 at 06:56:48PM +0100, Sebastian Reichel wrote:
> When dw_pcie_resume_noirq() is called for a PCIe root complex for a PCIe
> slot with no device plugged on Rockchip RK3576, dw_pcie_wait_for_link()
> will return -ETIMEDOUT. During probe time this does not happen, since
> the platform sets 'use_linkup_irq'.
> 
> This adds the same logic from dw_pcie_host_init() to the PM resume
> function to avoid the problem.

s/PCI: dwc: support/PCI: dwc: Support/  (in subject; capitalize first word)
s/This adds/Add/

Can you mention 8d3bf19f1b58 ("PCI: dwc: Don't wait for link up if
driver can detect Link Up event") here?  I think that's what added the
similar probe-time code.

I see you did copy the comment from 8d3bf19f1b58, thanks for that!

Maybe also word your subject and commit log along the same lines so
the two commits are easier to connect to each other.

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda5..f25f1c136900 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1215,9 +1215,16 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>  
> -	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Note: Skip the link up delay only when a Link Up IRQ is present.
> +	 * If there is no Link Up IRQ, we should not bypass the delay
> +	 * because that would require users to manually rescan for devices.
> +	 */
> +	if (!pci->pp.use_linkup_irq) {
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return ret;
>  }
> 
> -- 
> 2.51.0
> 

