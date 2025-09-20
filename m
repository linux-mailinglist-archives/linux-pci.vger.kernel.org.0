Return-Path: <linux-pci+bounces-36563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E807B8C0BE
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3327A1B66
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 06:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FA2D540B;
	Sat, 20 Sep 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXEh1rNT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185DC1EF09D;
	Sat, 20 Sep 2025 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758350016; cv=none; b=pF6R8eoadqjFL2n4h7RL5N0GUlmGDHe/LyKwrwq4iWUi8cctngpmGYzjmusW5NeHp99CyXGHgYGNkokbiBJ0Zl28zn5FW+GSTueJLKAuY0jjp82qv6OhGXlQqMYmj/V3JE4OZ0xF6S/snlSw7ovGMiAf8NupmUjooKBKY/8tIvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758350016; c=relaxed/simple;
	bh=/hfRLVAeokLS0Eaci1siv6XXPrGjW6em2vhHoSS4P1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvDdVGck6EcQH7Bsmx/QiygLLPOaaSpHjGNR0J7fYdu5qAPX7xLphfxgt21k/udMLuCjk06J311VYDm6PxRe6pG2EFPC+LmQT7BGm52Ofc2f/zxodkoP3CYDhVyAE/6DJy4FSyqZa3hVbI8LX02PF7XK2hQ2uwEGrFVKEeHR9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXEh1rNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD6DC4CEEB;
	Sat, 20 Sep 2025 06:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758350015;
	bh=/hfRLVAeokLS0Eaci1siv6XXPrGjW6em2vhHoSS4P1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXEh1rNTPXo0CvHjqmIIik0cDV6bJzExvo1c6+UV7IQS3EmwygQBhV/5atHDtFIiB
	 hkIb8NaRAO1NEEbdxnjdqDRK6PG10UTtnVs1XgrR+NllqukfloO8i/IWJvfMwANPuC
	 z1uAut/qwgYeiY/lKrk2diq4CLnlOLVPHLGmjm5VkBk4Epb4YcN2mDUa23xQhvZYZT
	 tbClM3VJJV1Pa5WvG87kLBBt7nwYD5eJvlDka6ruwKDSZeTV4Kh+og/OB+VowVkCt+
	 GOicLbBGId/gWgj/+OsCC9yoWGmi/ENssyQCFjsYu+K0ZftjVEzk5dOzAOTSmtLsdI
	 hJr3oyJKBRgLA==
Date: Sat, 20 Sep 2025 12:03:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] PCI: dwc: Skip PME_Turn_Off message if there is
 no endpoint connected
Message-ID: <7imm2xtisu5vlogdf3k2xb6phh4qfaaruwdafzfvl6xm3byfdu@iyjmvo2cyxjf>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-6-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902080151.3748965-6-hongxing.zhu@nxp.com>

On Tue, Sep 02, 2025 at 04:01:50PM +0800, Richard Zhu wrote:
> A chip freeze is observed on i.MX7D when PCIe RC kicks off the PM_PME
> message and no any devices are connected on the port.
> 

Is it because the controller waits indefinitely for the arrival of the
PME_To_Ack response?

> To workaroud such kind of issue, skip PME_Turn_Off message if there is
> no endpoint connected.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Fixes tag is needed and stable list should be CCed.

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 57a1ba08c427..b303a74b0fd7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1008,12 +1008,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	u32 val;
>  	int ret;
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

-- 
மணிவண்ணன் சதாசிவம்

