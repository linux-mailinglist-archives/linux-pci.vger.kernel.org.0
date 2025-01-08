Return-Path: <linux-pci+bounces-19532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58591A058E2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 11:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4E93A5141
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DECD1F8922;
	Wed,  8 Jan 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eIMaio5z"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1F1F8690;
	Wed,  8 Jan 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333892; cv=none; b=qoMGZl4+HnJAlOnJ30WIixrSq1wTzu0ay62kQsAYtOLhRfZ6oppkR50GhVPkUn7wcj966zNo7BE2JLKb0hXggv/4LmWMsqEfjEmMVASPpZrzlXvfcb7/GR6w0h108TjfBb5523aZb4GZGrPuEBwixyx4crl02VfDUKvYNYKp/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333892; c=relaxed/simple;
	bh=dnIIFKCbbltWrQTN9BU3UdILHLuLW1UDG4EBPXZQpNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pm3yD2nH2Oa89E5W20okGQLhyeCySUKur7+fpl6tCaVWd04j3QEVNWQvqZTLXg5qliNVWrBk6xR0NXSD5zyINHY8uTY+Y5SmsiOyGO7KWHafxnvhPY6jZ7Nuh+WexJuU0NsyH54ZPebT0Fa+hDjlPwyx+BH4HtfB1RXQSs4iy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eIMaio5z; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NoqnFYUo08zl9sWUFbQWTKaMIDKJok6y4m0E+eEGjW0=; b=eIMaio5zc/+B4GTx3PuSdSuLPd
	nDICgbOAAgkMxx8haKwyg7JDocSjvGKLzvzW68TJkq0h/kO4ekwS9IJfder0V2RMwCa0R49+VTPIF
	lcLoTebP3YurjlCjif8qQzAw+oojrEE1gJzkpBznJhzlcAWZQOjXZrCPVNSI2dYTE6pEZJY+3Z+7l
	eig/GIGgCrEV8wUak0Ego/S479d+gz/6Qz56BBp1JdxCHnbotZ7fKmdb0sBf9ntF2/0AyVRYT0wnc
	vlFcqZik8YJq1g6Ln6iQXLNRIbf+6zyOgkYsI2FcUdS7VFeah7e7xyD5U01qAKZfIVPBTxypwqGiC
	JhBfd5Yw==;
Received: from i53875aad.versanet.de ([83.135.90.173] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tVTkw-0004wu-3A; Wed, 08 Jan 2025 11:57:46 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	Simon Xue <xxm@rock-chips.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-pci@vger.kernel.org,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Yan <andyshrk@163.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Tim Lunn <tim@feathertop.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: (subset) [PATCH v4 0/7] Rockchip: add Rockchip rk3576 EVB1 board
Date: Wed,  8 Jan 2025 11:57:35 +0100
Message-ID: <173633124858.2752317.13499985925633362517.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250107074911.550057-1-kever.yang@rock-chips.com>
References: <20250107074911.550057-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 07 Jan 2025 15:49:04 +0800, Kever Yang wrote:
> This patch set is for rockchip rk3576 evb1.
> Based on the naneng combphy patch from Frank Wang.
> 
> This version including the patch adding usb nodes from Frank Wang.
> 
> Changes in v4:
> - Fix wrong indentation in dt_binding_check report by Rob
> - Update the commit msg with sort rule per required by Krzysztof.
> 
> [...]

Applied, thanks!

[1/7] arm64: dts: rockchip: Add rk3576 naneng combphy nodes
      commit: ddbf63b25866a4a58222d763f9f2d29c309e00e8
[4/7] arm64: dts: rockchip: add usb related nodes for rk3576
      commit: 23ec57a32da448cb3415d6abad3457b14c69af25
[5/7] dt-bindings: arm: rockchip: Sort for boards not in correct order
      commit: ffd07673f08a03ff5532212ebbd98fbfd0dac00e
[6/7] dt-bindings: arm: rockchip: Add rk3576 evb1 board
      commit: 88dc3756ece1d19ab0aa85ceb6ffb4e5f9318ae1
[7/7] arm64: dts: rockchip: Add rk3576 evb1 board
      commit: f135a1a07352b848d3d39557413dd1cd3716d930

I've dropped the PCIe patches (and pcie nodes from the board)
to be handled separately and also sorted some things
(regulator nodes, button nodes) and fixed some empty-lines things

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

