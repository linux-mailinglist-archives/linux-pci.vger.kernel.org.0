Return-Path: <linux-pci+bounces-31112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26344AEE979
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 23:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366F61BC135D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 21:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BEC22425E;
	Mon, 30 Jun 2025 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="kXPOClJk"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDF1D7E41;
	Mon, 30 Jun 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751319214; cv=none; b=o5J3kasucIZFhZJ79XBqQTED83rMy9LW2gzKcwJi55LGQN/mRPoXRvjcy02vjAZL30xdQ8WbzC95nqfFboxwCrdW4Q97/wMKlqPptabNdrGR6Vw7+MFnD93BtHW6jegUcKg74F9bZfofj4D1rRx8WLFAvRKLTNULrERN6DRJW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751319214; c=relaxed/simple;
	bh=203ZgCZh+qPPesbZd4Z294GUTkzv22U70O3LqGCjSCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+Dd2BeR3lBxynOsVXqM9WmknT/yFukaizchrl1OKz86BKB8ofGrF4ZT2Y1baqiyqodmwUU+OeOQ2rgKgw9AfFVfBaZbxm0+9gOF2XG9S/FCRZNei112YlCH+anSCiHGNV5/DFj+xuPAKXggqTPcAEPgSi6rzS4XGxwAAILQVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=kXPOClJk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=BTJWDoX6+dZpqVbCI05HYOZjmWwxTYx7suIMcGN7BKI=; b=kXPOClJk1Kmb/DiiyBtViPQ7s4
	BtvZG0K9yDMyQ4fGAOW0in3ubCmp2jBQZQuvmSkNvuRkZoBH5+Cd9uXGWaJLcrZnzwTlI6ctkPg0E
	MPCtQMCm0MxNBF+z6YN3VNCvT0Y5AP4nvgRmrHCPBIAzCPyr/yGFufXgaB7zRpS5fSshucWqrdNkz
	cTRAN+LkSxuoc10IY9ad5dILrvGnMUn61DobyKVq28TF0PSvch2asNQdHHgXEZLWQArucI5zeklKY
	dl7HGTSabPyPOfaLNFCCXbNHXk2/MWobnlFcqn2HpHbxaBkwOcjzD90tFzh6Nld+AGVo80RkSVSmM
	XfhReTgw==;
Received: from i53875bfd.versanet.de ([83.135.91.253] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uWM7s-00084a-BS; Mon, 30 Jun 2025 23:33:20 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
 Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Rick wertenbroek <rick.wertenbroek@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v8 3/4] phy: rockchip-pcie: Enable all four lanes if required
Date: Mon, 30 Jun 2025 23:33:19 +0200
Message-ID: <4006908.X513TT2pbd@diego>
In-Reply-To:
 <d3e7dc38bd287aa93a5d6bba87bf3c428ae92ca4.1751307390.git.geraldogabriel@gmail.com>
References:
 <cover.1751307390.git.geraldogabriel@gmail.com>
 <d3e7dc38bd287aa93a5d6bba87bf3c428ae92ca4.1751307390.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 30. Juni 2025, 20:22:01 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Geraldo Nascimento:
> Current code enables only Lane 0 because pwr_cnt will be incremented on
> first call to the function. Let's reorder the enablement code to enable
> all 4 lanes through GRF.
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>=20
> Signed-off-by: Valmantas Paliksa <walmis@gmail.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>

hmm, if Valmantas is the original author you should probably keep that auth=
orship
  git commit --amend --author=3D"Valmantas Paliksa <walmis@gmail.com>"
should do the trick.

The first signed-off should be from the patch author, then your signed-off
indicates you handling the patch later as part of this series.

[or, if you modified the code of the patch heavily, Co-developed-by could
 also be appropriate]

Heiko

> ---
>  drivers/phy/rockchip/phy-rockchip-pcie.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockc=
hip/phy-rockchip-pcie.c
> index bd44af36c67a..f22ffb41cdc2 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -160,6 +160,12 @@ static int rockchip_pcie_phy_power_on(struct phy *ph=
y)
> =20
>  	guard(mutex)(&rk_phy->pcie_mutex);
> =20
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->phy_data->pcie_laneoff,
> +		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> +				   PHY_LANE_IDLE_MASK,
> +				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> +
>  	if (rk_phy->pwr_cnt++) {
>  		return 0;
>  	}
> @@ -176,12 +182,6 @@ static int rockchip_pcie_phy_power_on(struct phy *ph=
y)
>  				   PHY_CFG_ADDR_MASK,
>  				   PHY_CFG_ADDR_SHIFT));
> =20
> -	regmap_write(rk_phy->reg_base,
> -		     rk_phy->phy_data->pcie_laneoff,
> -		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> -				   PHY_LANE_IDLE_MASK,
> -				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> -
>  	/*
>  	 * No documented timeout value for phy operation below,
>  	 * so we make it large enough here. And we use loop-break
>=20





