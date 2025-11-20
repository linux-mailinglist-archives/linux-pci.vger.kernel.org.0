Return-Path: <linux-pci+bounces-41802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8CFC75309
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0124EAF15
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230F364027;
	Thu, 20 Nov 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl4LSnzm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8134AB18;
	Thu, 20 Nov 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653281; cv=none; b=lfROxkv8V+US/eqsx5SOWaD5ZiqjTf5EHbkMBSqLJVsiH9YH4Oi1+PaAMmmfo/iQrf2xL3ZNrqYiSEEEfDO1p7JpMqfAWVB5tJckkReM9w62X2GIjsnjcpktrsGD8DuYQ+GWi9FJrcNTKdpPmFpAeEhkqmJRFCMtSzWugRkj/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653281; c=relaxed/simple;
	bh=GyUij2MHubbkYt0KHWY6Tsa6lwXops1vSRgPKRjjAYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cb3M5FKdTeGjnXOphAQ88xhSMi6+QJ4jMuBxuKOkgXiVs5lACfBk0x1611kr7tglHgGTFOo1Men9kja0pbKMMckanP63I159wP/7Rs6N99kdafhKF1vC8Jrf4g9eXiy3eBbfnkIuBasybLGVmiSkW24vFlO7QvW7Ji8bUPiZu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl4LSnzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33742C4CEF1;
	Thu, 20 Nov 2025 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763653280;
	bh=GyUij2MHubbkYt0KHWY6Tsa6lwXops1vSRgPKRjjAYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Bl4LSnzmwQaEcExw/APJKAemxDFRXSAalBsMfvhLoBS9pA3Exsrbr94IgZljjpAUP
	 SJOnnxt+uF9tKPpADmGa5vPP9dbPQSnM7qYlTM14S6vzEhNloYBmJZzDQb8ZnnIlSF
	 FhojDyCCgOf8HNwfM0JZmk0v5VqpB2ZDCKzOQwYX1xb6B17po/KnNaFBsOpJibmYJI
	 R/MwWPXu9pIYxmzY7ioVvTD09aWH4MW5UWEA2s9XZcmRfVO0Jr4pZ8beCLkYb7jKcG
	 mbTzIc2jmHKQVQoOPIUl3G5eu9ULzxp1jHi7SWmSwuiEX2YgxzL/c9covxglDBTySG
	 oWyXuKPYY6P0g==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 Sjoerd Simons <sjoerd@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20251115-openwrt-one-network-v4-1-48cbda2969ac@collabora.com>
References: <20251115-openwrt-one-network-v4-1-48cbda2969ac@collabora.com>
Subject: Re: (subset) [PATCH v4 01/11] dt-bindings: mfd: syscon: Add
 mt7981-topmisc
Message-Id: <176365327394.767266.14919759793033444113.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 15:41:13 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Sat, 15 Nov 2025 21:58:04 +0100, Sjoerd Simons wrote:
> This hardware block amongst other things includes a multiplexer for a
> high-speed Combo-Phy. This binding allows exposing the multiplexer
> 
> 

Applied, thanks!

[01/11] dt-bindings: mfd: syscon: Add mt7981-topmisc
        commit: a95419ff9f21d246835a8c6ba6f89c8916f7f0d6

--
Lee Jones [李琼斯]


