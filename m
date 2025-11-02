Return-Path: <linux-pci+bounces-40071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F722C2923C
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4AB3AC3A4
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469C1C4A20;
	Sun,  2 Nov 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7eRD6TV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD763597B;
	Sun,  2 Nov 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101259; cv=none; b=JZ8YCccQHCYJwgTSwrr85xWPy4bBW2Jmmjqzmfq32AthQG1S3vV22VsaB0frHbgjXO1VkAg3SxDiLMVmcrPuTySAKOR5rlBwPzDPQZ1DZusdEMSD3ZYtz9o1y8Ebw15G0pGqXFVUWDX+rESZF960fg78N0Hvhp7x3Tw7DdTdJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101259; c=relaxed/simple;
	bh=BMHbVQks4miUEqiNB8Bj8JUPKeAlJSJSR1yVrl8aLco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW1lBKWeQqU81v09kAHDiQp1dUwVhUwvaRqxzGQuXJj5izWv5bMMwx9zKBmG4ru7lZ0sZRbhd38Oy9Fv6P2jetdF+xnC2NxdEfZQOFB618LIY2UFsAtz9J9P4mtEejiAkUyTe3r+fMe1ELJ0FT8t4ov/kJX+8HGlNGAkZmks8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7eRD6TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB61C4CEF7;
	Sun,  2 Nov 2025 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762101259;
	bh=BMHbVQks4miUEqiNB8Bj8JUPKeAlJSJSR1yVrl8aLco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7eRD6TVlAfyAK/SnxypxQv2CmKl306jhXgTbNo+yEzxGzgBywD4o3XO+Kra3kmUC
	 BHeM9hHDBMsxnas3zHbLQV+jXGd43myStuXXahsqlnh1MurcU2NGwQZgqfQ1ROV/GQ
	 R1Pn9WDjXqwgLImO8l2p2csPYY5IvVZokYSEJGvJl6QDnPEPH2lDomh0rfaaZUlZeM
	 GXKm1g0JlMbAHcafI/yarK+QpXQbMIsDi8O/iVF9ZvJcEBhNzY649s591I/T7XpW7k
	 vJMX2iVXWlqbfZvVvbDLnKCpTK3ZsX6HPpK8vBbVLb8hhzsxrvKHJS6Gj0qvKfdMhp
	 vvcH1GW9R8jLA==
Date: Sun, 2 Nov 2025 17:34:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, kernel@collabora.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>, 
	Bryan Hinton <bryan@bryanhinton.com>
Subject: Re: [PATCH v2 08/15] dt-bindings: net: mediatek,net: Correct
 bindings for MT7981
Message-ID: <20251102-honest-jade-hedgehog-b85f0d@kuoka>
References: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
 <20251101-openwrt-one-network-v2-8-2a162b9eea91@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251101-openwrt-one-network-v2-8-2a162b9eea91@collabora.com>

On Sat, Nov 01, 2025 at 02:32:53PM +0100, Sjoerd Simons wrote:
> Different SoCs have different numbers of Wireless Ethernet
> Dispatch (WED) units:
> - MT7981: Has 1 WED unit
> - MT7986: Has 2 WED units
> - MT7988: Has 2 WED units
> 
> Update the binding to reflect these hardware differences. The MT7981
> also uses infracfg for PHY switching, so allow that property.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
> V1 -> V2: Only overwrite constraints that are different from the default

I don't get it.

mediatek,mt7622-eth now can have 1 or 2 items, but previously it had
strict 2. This needs explanation in commit msg.

Best regards,
Krzysztof


