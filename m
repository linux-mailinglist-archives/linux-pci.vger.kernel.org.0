Return-Path: <linux-pci+bounces-36428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23487B85EA6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25173A4D40
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC1314B64;
	Thu, 18 Sep 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VoslzeLw"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD0831195D;
	Thu, 18 Sep 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211619; cv=none; b=hUrF+RymU14W3Z6ah8yq7nrj0dWaMBdukM1mQHUuTR7mn3lRqf4hfwXBlc/x79f9sP20RrSjxtgsJIS8tZi6EU6h4QLDnIsJradn2iXuJTz9TdGjH0eGugFXm7cAgP7ElfX+nTpqbUvwVq76PZGWNzBrfRF24ZS4dDCWPWrGAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211619; c=relaxed/simple;
	bh=+F4TaAJ1+I3lApf7Zbx5vaj8m+LuxzrlFuwgun2z2qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLFBz62l4nYvsQDegIYZibuUSI48nxmQeJry4X3aEbQEAhkzsDtZWV7mwZ8XijEEhp6+0vhyWrbkwMg2BLt/t2qrHaWY+qpbaRlB+n8HOIDlT0+q97JhEdE6DFToQatjJpaxZ5JCy/S90bVvJXnEQBc/K/tDnbhdwINNmkXo47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VoslzeLw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=+F4TaAJ1+I3lApf7Zbx5vaj8m+LuxzrlFuwgun2z2qg=; b=VoslzeLwepJmNzjMIsPuSVmsXt
	V++kPbTcSCQW75otpc1HAvdiq4J1Rniab/l5JMYEG72uAk147fN/5Fs7Rb5PX1v6jASWgOMrVNXCu
	tWl2TLPi4OuJlXdtmN95amPcIDonK64CvmXTX3KKasnbO2Ttt7WYAneSc9pTTaI1PvAUUzJfTvx0V
	wyVrrQfpv4T25Mq/TTedTcN34tBQsXndl0u81m/lrpE6Z6PbTJsk1ZcIH9Hs1XzeHRO8PPgA3pp22
	PyAjQZF8g1LIWPt6zhfgpWY4FWVovVItYSU4uB3vF7rxy+xT/mYuDv9LEdsvvDXkVNh6NvanSL72i
	52jE1RoQ==;
Received: from i53875b0a.versanet.de ([83.135.91.10] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzH9T-0001tG-MC; Thu, 18 Sep 2025 18:06:31 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
 Yao Zi <ziyao@disroot.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
 Chukun Pan <amadeus@jmu.edu.cn>, Yao Zi <ziyao@disroot.org>
Subject:
 Re: [PATCH v2 1/3] dt-bindings: PCI: dwc: rockchip: Add RK3528 variant
Date: Thu, 18 Sep 2025 18:06:30 +0200
Message-ID: <2042643.CrzyxZ31qj@diego>
In-Reply-To: <20250918153057.56023-2-ziyao@disroot.org>
References:
 <20250918153057.56023-1-ziyao@disroot.org>
 <20250918153057.56023-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 18. September 2025, 17:30:55 Mitteleurop=C3=A4ische Sommerze=
it schrieb Yao Zi:
> RK3528 ships a PCIe Gen2x1 controller that operates in RC mode only.
> Since the SoC has no separate MSI controller, the one integrated in the
> DWC PCIe IP must be used, and thus its interrupt scheme is similar to
> variants found in RK3562 and RK3576.
>=20
> Older BSP code claimed its integrated MSI controller supports only 8
> MSIs[1], but this has been changed in newer BSP[2] and testing proves
> the controller works correctly with more than 8 MSIs allocated,
> suggesting the controller should be compatible with the RK3568 variant.
> Let's document its compatible string.
>=20
> Link: https://github.com/rockchip-linux/kernel/blob/792a7d4273a5/drivers/=
pci/controller/dwc/pcie-dw-rockchip.c#L1610-L1613 # [1]
> Link: https://github.com/rockchip-linux/kernel/blob/1ba51b059f25/drivers/=
pci/controller/dwc/pcie-dw-rockchip.c#L904-L906 # [2]
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Heiko Stuebner <heiko@sntech.de>

This likely should to go through the PCI tree.
(or needs an Ack from PCI maintainers, for me to pick it up)

Heiko




