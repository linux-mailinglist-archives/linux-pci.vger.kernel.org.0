Return-Path: <linux-pci+bounces-22419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44FBA45BF0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 11:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5897A9AFA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DB26A095;
	Wed, 26 Feb 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OQKc7ps1"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226824E00E;
	Wed, 26 Feb 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566183; cv=none; b=oZnxne4Wn00ZhEocIse7PG+yOZ66L1MnZMYLSu8WiFWVO6L2KvfN/e4M3YFqVXLFzQRVCl7C714Zmx0mk1NZ5cZMOEWdCrib5G2+5cN00ZYP0C/4TcBLBG8pFvmVZFfJZ6UIYTg4n1CS4I/YwoLzIrD4rVahtZKV/EL8XIp2xLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566183; c=relaxed/simple;
	bh=2WMIyTRKYn+RNupW9ej3GdmnDEAf4ZUDmqoMpA0N/rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3vMBQ+LPVe20lMonBQNym0nccts/yEH0It5aP8pZhas/Ka3RPSD4PpfLwCK3VUlUztRoApSpj7L+CWHzMWRJ8OrHIcF4b0JPaUEU4SiUylZMNovCzGKrzmJ/1KnO5yy3pWznG0zqcEHssbCk2Ssi9fQ6AQQ0N1WznbqVJUiblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OQKc7ps1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5Zbay1ioC0/+bEjvO9SEyQuR/lN3aixi3K7fAqyxee0=; b=OQKc7ps1ZWMV5p+31eWYDGJv8j
	TW+v2NagR7K0IUOrHV4xQOW1iUTViKiNJWn2LSwOeNFOZmwInBrLQAiEnIz6OWo8M4pDPFctLlqrX
	MP5Bg1lR7M3D65eegQ3R4tCwUDEbjAcKdew/CuVGrjm6zMLimAxVvY4LBRjHRFZlByqoeebYlJeQR
	jZo3B67UgreeHoUDXrBUXxzicaUYk0y+4mFyuRKpWs906G1pFKRHTUX+gJcDU8uGq74dV7fB6eBSV
	HzlE7HHiTctdqFUIeG7dPRGMjXr166GMcDaPgthAH2pGs+wFLrtjCBX3tO9HZ/IzazMOAd9y9aD7H
	Y2Pm34Bw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnElu-0006Y7-6p; Wed, 26 Feb 2025 11:36:10 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>, Simon Xue <xxm@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Date: Wed, 26 Feb 2025 11:36:09 +0100
Message-ID: <14510034.lVVuGzaMjS@diego>
In-Reply-To: <20250226095414.2173410-1-kever.yang@rock-chips.com>
References: <20250226095414.2173410-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 26. Februar 2025, 10:54:13 MEZ schrieb Kever Yang:
> rk3576 is using DWC PCIe controller, with msi interrupt directly to GIC
> instead of using GIC ITS, so
> - no ITS support is required and the 'msi-map' is not required,
> - a new 'msi' interrupt is needed.
> 
> Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>





