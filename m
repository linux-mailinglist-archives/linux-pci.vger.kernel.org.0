Return-Path: <linux-pci+bounces-34323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4DB2CCC1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 21:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6FE3BD5C2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43532BDC19;
	Tue, 19 Aug 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4QrDKEm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376E2BD586;
	Tue, 19 Aug 2025 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630442; cv=none; b=RBnIsEmrIISTiMEBvKD9t8PLkkfVDc2sga9jHmVCQLy/OemNOzL4HVGSIi100rEws7kuuhk5QB0gaRXEaKZZTGFK6sdjwBoVS7l6kuYS75r33k7P0vlcZfN32TiEM55bA5H5HfqfKfSvo/kLv0GJVmIFNGoNmFB/XtR3PaT8POI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630442; c=relaxed/simple;
	bh=EhPwi7uM8bEX6mz/D+2QkJ4QnZQxgt8yu80Tgm2qqx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B1tyaEFxWSchM/OpOZFJvjM2JZufBGtiWXiTyRFhJPjgKlpQIEp7p+K2Qb4boS/3Fjd7E0aDb+L9+V8TdVq5JTvyIFPuTNXmwmZl1miljfZg4aZ8ojQ+Djela7tuREmZMBD+SztlmkE/AIrPMTbr77G898qMk/H1noPrL0AyT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4QrDKEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1622AC4CEF1;
	Tue, 19 Aug 2025 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755630441;
	bh=EhPwi7uM8bEX6mz/D+2QkJ4QnZQxgt8yu80Tgm2qqx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U4QrDKEmu+cy0+u+n9LbZ/mdyRzNpo/0x7oc1EXA6v0Jl1rmMOMgZ0dREPMp63n73
	 qoT2zeChi7GzvWa8XuqJ8uMpKi7FEECSuyv3XQWjICn9xVCYl50OpNAOPPPgtx2VkD
	 UALIyZWElFbpx7PBzJswhu0yRQc5GsWbJNoxhcFKnxq3UqocWPK/+rKgY1QtjKkrmp
	 gVl1/UixsC7wf5gRZGViFIjpSoKkmCSQr/3Qy9K+3d+4YIoUOcy6pkuiPZmuUJoqvP
	 ePgUZ9uZbRzaNIq2IMtLjjiR/4J04V4jaydHaasX3QQNswoS0M/x2+tGpcIgNMVsAR
	 XSQL7Q0fl/uqA==
Date: Tue, 19 Aug 2025 14:07:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v3 4/5] PCI: dwc: Skip PME_Turn_Off message if there is
 no endpoint connected
Message-ID: <20250819190719.GA553003@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818073205.1412507-5-hongxing.zhu@nxp.com>

On Mon, Aug 18, 2025 at 03:32:04PM +0800, Richard Zhu wrote:
> Skip PME_Turn_Off message if there is no endpoint connected.

What's the value of doing this?  Is this to make something faster?  If
so, what and by how much?

Or does it fix something that's currently broken?

Seems like the discussion at
https://lore.kernel.org/linux-pci/20241107084455.3623576-1-hongxing.zhu@nxp.com/t/#u
might be relevant.

This commit log only restates what the code does.  In my opinion we
need actual justification for making this change.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20a7f827babbf..868e7db4e3381 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1016,12 +1016,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  
> -	if (pci->pp.ops->pme_turn_off) {
> -		pci->pp.ops->pme_turn_off(&pci->pp);
> -	} else {
> -		ret = dw_pcie_pme_turn_off(pci);
> -		if (ret)
> -			return ret;
> +	/* Skip PME_Turn_Off message if there is no endpoint connected */
> +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_WAIT) {
> +		if (pci->pp.ops->pme_turn_off) {
> +			pci->pp.ops->pme_turn_off(&pci->pp);
> +		} else {
> +			ret = dw_pcie_pme_turn_off(pci);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>
>  	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> -- 
> 2.37.1
> 

