Return-Path: <linux-pci+bounces-9323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF69185E3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A061C20B77
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39F18C337;
	Wed, 26 Jun 2024 15:33:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141618C32F;
	Wed, 26 Jun 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415994; cv=none; b=X3CPTonGv4Rw494x3YFw+QAT5XY2rkj/b3yrKvWlkQRqxw4cahgMV+aiXlRvj08xZs+9SkSsRv+lNsY34IHx6zr7Q9DwiC1xduZmOwwknIMYsa2skc/Uy17qnvoogtMQcBTADDRv0XFZ+/34iYmwPOh+dvS4iIrE3EfeVRVH9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415994; c=relaxed/simple;
	bh=beBVFO6Bha+en0Z2AqjFAVxZ6mZk/YXpfnPM+j4gB74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Evq26JfCFSOqhxW7Ry9ZtsOaPrrbpQx0Bb4qcPoayLvcao0EdTCoD0OzQXM8CNDAw+T8uDYFho1bG0Iw9GXP1k4yHkFZRMrPalz3Y8Cmg+brq6HbpMRAJKuvO1/onoshybkyjcPTPuVVDyjqUiAaPlqWnfRo6iMm0adZ/Qtx5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sMUdf-00058K-69; Wed, 26 Jun 2024 17:32:51 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Simon Xue <xxm@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v5 00/13] PCI: dw-rockchip: Add endpoint mode support
Date: Wed, 26 Jun 2024 17:32:49 +0200
Message-Id: <171941553475.921128.9467465539299233735.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Jun 2024 13:14:20 +0200, Niklas Cassel wrote:
> This series adds PCIe endpoint mode support for the rockchip rk3588 and
> rk3568 SoCs.
> 
> This series is based on: pci/next
> (git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git)
> 
> This series can also be found in git:
> https://github.com/floatious/linux/commits/rockchip-pcie-ep-v5
> 
> [...]

Applied, thanks!

[12/13] arm64: dts: rockchip: Add PCIe endpoint mode support
        commit: 2fe9fe4e54f5763b8b681478dda9ac61fd42ecaf
[13/13] arm64: dts: rockchip: Add rock5b overlays for PCIe endpoint mode
        commit: 41367db58cbf51ecb89ca017b7473688345caa7b

I've dropped the overlay-symbol-enablement for now.
As this creates massive size increases there have actually
been concerns of things like TF-A getting overwhelmed by
the size if I remember correctly.

In any case, right now we don't have an established way on
how to handle overlay symbold for Rockchip boards.

For example broadcom enables symbols for all DTs, Nvidia and TI do
it for select boards only, while for example Mediatek and Freescale
do not handle symbols at all right now.

So I'll just postpone that decision for a bit.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

