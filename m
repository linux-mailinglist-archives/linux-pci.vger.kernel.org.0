Return-Path: <linux-pci+bounces-43526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D97CD62F1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 14:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AAAE304B028
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96C31A813;
	Mon, 22 Dec 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aKJ20RLN"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB33191BC;
	Mon, 22 Dec 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410729; cv=none; b=E8ZS5A4E1q8yb+FOVEW0nqQ+nDZLZXnbopY4eG728HaYQMQQ299vByweQMlYTNuidGXFBCrhhQmhY43izAf72DDfXKkXzkCVZVTPJEGGfqwM998YCaT1axqxXZnRUYO5Ukcj0oHLU8LwG9aWlexLEvAkMVOSirWhbwE91godRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410729; c=relaxed/simple;
	bh=bU0/fQy8qI9VjlJU9zbmyJYsk727NjYattEG43zuJvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVHq23of8SNbLvmkyK+LZlF5rjuK7tFM//1o+PhHxhiIkJA+uGBok+Eqw0Xo5KJUyldZO2474pbLHBiavnexzk3Wq/BQunb0mZKOwfSDdMCCPm9WNQO7xiiPQYniUCDikl+um36+2NQ3BEnMTMjLZxmMuQ87EmW9wX2IirLQ49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aKJ20RLN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=zyNlIYVGdqBwPbC3NbHSO9fACJaQ81uwPvV6sz6WN6w=; b=aKJ20RLNXHNkpP2m2BcJ6miVeB
	6GhEYyqmtsenDadUpjQQMitJZg3sWrSnZXcvMG5GIEdMvND5H9GZrhGs1X9EQkP2OBbbO4ofLUNO1
	72cLOsJlZPrvNXiiyZxOytHX+jEA5bvXSycFudNyvQgUmmePQ/otQxFXV891s6IclLBhidX7L1sFx
	Xk8A3uz5WWCwkBIeIuvSo8UQXfoAYT/nEtXFvRjKYZZtqdt1+oukQVGqFP7ZFchkIzKKcud/n6MYF
	eZASupZg71vr114cvoI91jlMqOsrlxa5OvabmhCon4iw2osNSONtddl0X07oY0WIyb+duvpQRCSJ1
	0npPj5Ww==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vXg7L-0005s2-6w; Mon, 22 Dec 2025 14:38:31 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/4] PCI: rockchip: 5.0 GT/s speed may be dangerous
Date: Mon, 22 Dec 2025 14:38:24 +0100
Message-ID: <176641067349.1648325.7613113925741792154.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763415705.git.geraldogabriel@gmail.com>
References: <cover.1763415705.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 17 Nov 2025 18:46:43 -0300, Geraldo Nascimento wrote:
> Dragan Simic already had warned me of potential issues with 5.0 GT/s
> speed operation in Rockchip PCIe. However, in recent interactions
> with Shawn Lin from Rockchip it came to my attention there's grave
> danger in the unknown errata regarding 5.0 GT/s operational speed
> of their PCIe core. Even if the odds are low, to contain any damage,
> let's cover the remaining corner-cases where the default would lead
> to 5.0 GT/s operation as well as add a comment to Root Complex driver
> core, documenting this danger. Furthermore, remove redundant
> declaration of max-link-speed from rk3399-nanopi-r4s.dtsi
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: rockchip: remove dangerous max-link-speed from helios64
      commit: 0368e4afcf20f377c81fa77b1c7d0dee4a625a44
[4/4] arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r4s
      commit: ce652c98a7bfa0b7c675ef5cd85c44c186db96af

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

