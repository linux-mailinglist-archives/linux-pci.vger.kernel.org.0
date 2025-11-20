Return-Path: <linux-pci+bounces-41800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E70ACC752C1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 25111315D8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23D368280;
	Thu, 20 Nov 2025 15:38:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533A333743;
	Thu, 20 Nov 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653125; cv=none; b=HtEyWn9dAQetzQKM0ahHr32vZZvmJL2gHXdis/mNkfYYMedWoKPi49APO8Fvw0+fPn9XRAGyQK6sfAB75HXUMdlhWiOSAlX+RUmxZ9ChdY2RNqduwXbAinQ7r3HIB0Yu9LAsh/ox345GouFT9hC5whSAPWLlwjFkRCQsRXdU5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653125; c=relaxed/simple;
	bh=ibq11tXWtjiobKtCsw/vA9F7w0kISsPA6gKgAPxyJTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd2XBip6zXR4PXxRHE156a6XH8LgJXZXULeaoIWFNdc5h3VeE6ToGywr4wgNESo1nHdPFFOpPmBZ2T0jJp7xkdUAKN0DUQb46KDqBySicLSE5HLYeVCKcs03/iPVPf7gdd/wYy65zwzf5QkL4fnKmwaLarq4oIY4Il/uK01MYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vM6jw-0000000086m-1ie9;
	Thu, 20 Nov 2025 15:38:32 +0000
Date: Thu, 20 Nov 2025 15:38:20 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lee Jones <lee@kernel.org>, patchwork-bot+netdevbpf@kernel.org,
	Sjoerd Simons <sjoerd@collabora.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, lorenzo@kernel.org, nbd@nbd.name,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org,
	bryan@bryanhinton.com, conor.dooley@microchip.com
Subject: Re: [PATCH v4 00/11] arm64: dts: mediatek: Add Openwrt One AP
 functionality
Message-ID: <aR817IjAOgJ808FO@makrotopia.org>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
 <176360700676.1051457.11874224265724256534.git-patchwork-notify@kernel.org>
 <20251120152829.GH661940@google.com>
 <20251120073639.3fd7cc7c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120073639.3fd7cc7c@kernel.org>

On Thu, Nov 20, 2025 at 07:36:39AM -0800, Jakub Kicinski wrote:
> On Thu, 20 Nov 2025 15:28:29 +0000 Lee Jones wrote:
> > > Here is the summary with links:
> > >   - [v4,01/11] dt-bindings: mfd: syscon: Add mt7981-topmisc
> > >     (no matching commit)  
> > 
> > I thought this days of Net randomly picking up MFD patches were behind us!
> 
> Take another look at the message. We picked out just one of the changes
> here.

... and that's an MFD change (dt-bindings, but still)

