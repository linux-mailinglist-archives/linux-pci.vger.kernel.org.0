Return-Path: <linux-pci+bounces-29201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7516AD1A08
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 10:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902FF16B473
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A51210F5D;
	Mon,  9 Jun 2025 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1R6ba9wk"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B1202F8F;
	Mon,  9 Jun 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749459070; cv=none; b=P5W1vP8xB8TVEEjiK7McuI5TJ+TuDZme9/6N6HQzDy5xZXWIb/1IMecR2D0wdeYUre9YlfQ+0nzmjOYjFdRqAfxJml0Hg3TBY/H90ALxb7VlDbROjj/f3TcjZ+E0+nkdx0/JSJ0kIcyS4YCVHp7puhyUvKwnXSs+96doZHmIykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749459070; c=relaxed/simple;
	bh=vARZ2HXvra+7FQMDYg1A9+OYwBUND+ICkiWTD4qm3rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7gNGQbsDpChL83IIdskOGgXmTj75mx8r2AuFcHuAR7W328bvay+VRqIPhf7mks3gL+DKV2uiYLglJQXSaoHbwgepazcHMaHoEJLHrgFotey9Rdd6ixwbwBTe4Kj8P4BvLSAJIjYsltnAK/5oX4vPIvV/lzQeIFtTFezBrXi9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1R6ba9wk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FOHakUk5xT1fcNi+NPqv3HQ+xAZj2Oji/+RFN8IiveA=; b=1R6ba9wkp1ZO9GSRWkwczG90ui
	Uifd7T3spP4VYBkQjasbFUAKxrlDFyusDdhK2NPoVCW0proWCH2OYPyuUu4gv4UTbwY0iVbtDdzuu
	tMS15zAP236F4PI8tZoP56ZLHKX6S2dcsLrHtVTNgs4fwmVg9TAvq/Ves07/fwp2Dd8mG6QNfhy3q
	KIVKTs+fh4/qAdV3DZsn6cPHwyq6v2F5lNpj7jdJqxDuuTlIJs4EzVH7U8Vsx+vZklAwigAffvq1o
	t8HAaZ+BT76JWnkFFEQJIKDhGsOhtAIVhzyeWlc2rhEB9Y0RJRpOlIjOz5CMhBC4EZwQ02NIor6bD
	GDd/kYnw==;
Received: from i53875b1c.versanet.de ([83.135.91.28] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uOYDP-0005cP-0b; Mon, 09 Jun 2025 10:50:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
 Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Quality Improvements for Rockchip-IP PCIe
Date: Mon, 09 Jun 2025 10:50:45 +0200
Message-ID: <2266650.atdPhlSkOF@phil>
In-Reply-To: <aEQbx0Qu-2UKhV1y@geday>
References: <aEQbx0Qu-2UKhV1y@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Geraldo,

Am Samstag, 7. Juni 2025, 13:00:23 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Geraldo Nascimento:
> During a 30-day debugging-run fighting quirky PCIe devices on RK3399
> some quality improvements began to take form and this is my attempt
> at upstreaming it. It will ensure maximum chance of retraining to Gen2
> 5.0GT/s, on all four lanes and plus if anybody is debugging the PHY
> they'll now get real values from TEST_I[3:0] for every TEST_ADDR[4:0]
> without risk of locking up kernel like with present broken async
> strobe TEST_WRITE.

could you check your settings for sending patches please?

The individual patches of this series did not get "in-reply-to" headers
that would point to this cover-letter. Instead each mail of this
series stands on its own, preventing mail clients from creating a
threaded display of the series.

git-send-email normally does create these needed headers on its own,
so could you check if you have some option enabled that prevents this?

Thanks a lot
Heiko


>=20
> Geraldo Nascimento (4):
>   PCI: pcie-rockchip: add bits for Target Link Speed in LCS_2
>   PCI: rockchip-host: Set Target Link Speed before retraining
>   phy: rockchip-pcie: enable all four lanes
>   phy: rockchip-pcie: adjust read mask and write strobe disable
>=20
>  drivers/pci/controller/pcie-rockchip-host.c |  4 ++++
>  drivers/pci/controller/pcie-rockchip.h      |  3 +++
>  drivers/phy/rockchip/phy-rockchip-pcie.c    | 16 +++++++++-------
>  3 files changed, 16 insertions(+), 7 deletions(-)
>=20
>=20





