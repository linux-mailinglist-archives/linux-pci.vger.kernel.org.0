Return-Path: <linux-pci+bounces-30286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1760AE27C9
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 09:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382CC17D2EC
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 07:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F91AA7BF;
	Sat, 21 Jun 2025 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="C4NDFT8A"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F219AD89;
	Sat, 21 Jun 2025 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750491563; cv=none; b=JIuzjGOTsEceH16NaSIebKG+i3B1tVl8yVUpmd4JVT0Yll1PwXMR8Lgt9w2iAoIddml8nYRLpWMu6xHpDjQSLpfFsPIpRsYoWCu4KVeBk6iQ8q+afdft/qOwWMcr6zWO8ePGNzmCdsjBaED/LuKv0DRsibNapChcLQdBCzCG7Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750491563; c=relaxed/simple;
	bh=cbFI5Cc1bZrgM4rTXtX9rJdnwMgSlSITn8w3Od67/Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYugqdCY0nRxCORdoEeEvbf9Nbcb1nJKuRxqX0QU8FgtKhWvdFHC4o5ZK+EKaWcbW/JTM9/aA6pb3N9RfEZywkngLc6ZYK5dhKlBVDBOu/klf0xELxqmYUvPASsZtnHkBXh+ZJt4d3TzRok8c3ERODPKwADkJ/KeP4MC/ygZha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=C4NDFT8A; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ZitZ8bWumcyW1MR/MaKS/o+JAIlQ+zy7xef+odnx7uM=; b=C4NDFT8ANCUVmX3P5VsdZa6rIK
	/P3uu4Zg9awdZuPmOmGaCBUFrChk/ie0XymVM4KlvFRBxN3MHvPl36nrvChRlXiaeQro08YdVsIpi
	friKF9S3HzhCpJzy+007YBHJMZzP9K68EKsSCER1eQWAXmZDyunU5C0IUelZVjvWv3Ctf6UnjhNZF
	YB6b6VtqSfe6W/tkaiVwIbiBQpwD6dz7rsT1Ix4gAl92HEolqEZ9kXwG1Dtal6XTJJYSCNqtKCnnF
	JglR3KkfRhdGmVzl2iOGB4OGcNVidSBtzSc628JPCpGWvyJb3R65zV3wJvuILAsQQvhZOx7yaDaU0
	vzEvGF6Q==;
Received: from 85-207-219-154.static.bluetone.cz ([85.207.219.154] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uSsof-0004Xc-TU; Sat, 21 Jun 2025 09:39:09 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
 Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Rick wertenbroek <rick.wertenbroek@gmail.com>, linux-phy@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/4] PCI: rockchip: Improve driver quality
Date: Sat, 21 Jun 2025 09:39:08 +0200
Message-ID: <4760493.mogB4TqSGs@phil>
In-Reply-To: <cover.1750470187.git.geraldogabriel@gmail.com>
References: <cover.1750470187.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Geraldo,

Am Samstag, 21. Juni 2025, 03:47:51 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Geraldo Nascimento:
> During a 30-day debugging-run fighting quirky PCIe devices on RK3399
> some quality improvements began to take form and this is my attempt
> at upstreaming it. It will ensure maximum chance of retraining to Gen2
> 5.0GT/s, on all four lanes and fix async strobe TEST_WRITE disablement.

just a driver by comment, you might want to drop the RFC element from
the patch subjects.

It does look like things take form nicely and how people read those
RFC marks varies wildly. Some may even read it as "this is unfinished"
or something and spent review time on other things.

So if you're mostly happy with your changes, just drop the RFC part :-)


> ---
> V5 -> V6: reflow to 75 cols, use 5.0GTs instead of Gen2 nomenclature,
> clarify strobe write adjustment and remove PHY_CFG_RD_MASK
> V4 -> V5: fix build failure, reflow commit messages and also convert
> registers for EP operation, all suggested by Ilpo
> V3 -> V4: fix setting-up of TLS in Link Control and Status Register 2,
> also adjust commit titles
> V2 -> V3: correctly clean-up with standard PCIe defines as per Bjorn's
> suggestion
> V1 -> V2: use standard PCIe defines as suggested by Bjorn
>=20
> Geraldo Nascimento (4):
>   PCI: rockchip: Use standard PCIe defines
>   PCI: rockchip: Set Target Link Speed before retraining
>   phy: rockchip-pcie: Enable all four lanes if required
>   phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal
>=20
>  drivers/pci/controller/pcie-rockchip-ep.c   |  4 +-
>  drivers/pci/controller/pcie-rockchip-host.c | 48 +++++++++++----------
>  drivers/pci/controller/pcie-rockchip.h      | 12 +-----
>  drivers/phy/rockchip/phy-rockchip-pcie.c    | 15 +++----
>  4 files changed, 36 insertions(+), 43 deletions(-)
>=20
>=20





