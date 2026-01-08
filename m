Return-Path: <linux-pci+bounces-44303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83ED065EB
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 22:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D5DF301004C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374AB320CCC;
	Thu,  8 Jan 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUT2l1JC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123607494;
	Thu,  8 Jan 2026 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767909008; cv=none; b=TYpCVExIUpQ54hGIZN8kmKc3n8frDXroGTWkq92VddYjqLM+Za3XPclDh8VL7LfinVNmZFSHusXzNkdzbAsA0donmRViEPZH0+OxtTnsf2tHjaaAk3y2spiftfb/r7fYK7TPt95Xj2XpFDx6ma8O9bj+ztxnLg6uqBytcZYAGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767909008; c=relaxed/simple;
	bh=ujqWTzFk9nolBdZNDjtupYATI3vdeJZCz+XdzgKg28s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QnQdD3ecY7vX2GVUoKwprPsLbUa8ZzZfSm/vnLnDgnbEK4+AOG9BZ1gKnUBfwSlnqS48/WaqmC7DQw4nul2TP7Sad0llL60oprXYfenggm/JXdAmUrkYn8OoM5NAhqATJtYX+xZCoOlNmKmOuJsgfgi8Cg3bpF7k2ZCr0Jsd4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUT2l1JC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C72C116C6;
	Thu,  8 Jan 2026 21:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767909007;
	bh=ujqWTzFk9nolBdZNDjtupYATI3vdeJZCz+XdzgKg28s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PUT2l1JCTusoAIgJ7ZrrASS1i+Aj7iPocBvdiYs3Gk/NMz7wzH31SJLr0//KsOHEm
	 z5KjxU7jHoCbmXMSc/jvBBDbUHjLWmaPAz4eKTYO19rmFBGjNXLHEFzJSWE3qKSoxR
	 IpQ+zl8laZ7+vF1vMcYWWdQiu1qeYgeytokrU6sam5BDnirzsqRK6Q4bX7Dx3BR9Xs
	 manamF5HmsOmVjeVljuWYUDvfX9p0EHWVIplpC/1E/2XRj7TfxNEAmw2PMz2pLwL3E
	 W1FKIX4cJc2F/aR6sRRvei/r/Xuhl6yjzi8OT52PQ6gnOgs1EBccvvcoE5Kdk9vXVN
	 QPSFgOMLtAMlA==
Date: Thu, 8 Jan 2026 15:50:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/11] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Message-ID: <20260108215006.GA500164@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-9-hongxing.zhu@nxp.com>

On Wed, Oct 15, 2025 at 11:04:25AM +0800, Richard Zhu wrote:
> If the ops has post_init callback, invoke it in dw_pcie_resume_noirq().

I'm trying to write the merge commit log for this branch, and I don't
quite understand this.

The effect is to apply the GEN3_ZRXDC_NONCOMPL workaround for the
ERR051586 erratum, and Mani added the hint that this enables REFCLK
during resume.  But it seems weird that we apply a REFCLK workaround
after the link is already up.

During probe, .post_init() is run after pci_host_probe(), so we apply
the workaround after enumerating all the devices, which means REFCLK
must already be valid and the link is already up.

Is "enabling REFCLK" actually what imx_pcie_host_post_init() does?

Could the workaround be done in imx_pcie_host_init() before the link
is brought up?  If it could, it looks like we wouldn't need
imx_pcie_host_post_init() at all.

For now, I put this in the merge commit log:

  - Apply i.MX95 ERR051586 erratum workaround for REFCLK issue during
    resume (Richard Zhu)

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c4..2b59e7d2e6179 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1199,6 +1199,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>  
> +	if (pci->pp.ops->post_init)
> +		pci->pp.ops->post_init(&pci->pp);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> -- 
> 2.37.1
> 

