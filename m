Return-Path: <linux-pci+bounces-38071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4820BDAB31
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 18:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5540519A56B7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDAE3043C4;
	Tue, 14 Oct 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="UBtnrIkS"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C73301027;
	Tue, 14 Oct 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460590; cv=none; b=ML6CE8AqFd2CY3nPQprzvz3CduwqzcyhNwbpM3M1NwILqYmiG34fSWCH6uwWdIPEpqcPbh5YIsVlO4hnZTLC2QAMp2XpsWipsEDZUbDKCf90yyB6sBOx0F1tAi85bhpE7QIG+VsK5+yqgiqaD8tIHa56vN0xVI8ILIB2nP5PUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460590; c=relaxed/simple;
	bh=hdQ+lgMLu/JaI6S6oyCUDuEqX6s4fUPXX5eCMdkEmRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqkuD/bL1/MHP8W3WwQv+8/7yAnlxAO8ElBvxC8O02UuFyOFpPPMXJJSAC7vgf9LgjMZYHHM1hvBzh4jpdJR5W7GRH52Upi69uZiT+kFWcAIKKjhNmQxq8qV5jiAOvK1RuX82HSPFtq2ZqOpcUXYN6WzghfUVWvkjCy4ZXFbu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=UBtnrIkS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 965B325F11;
	Tue, 14 Oct 2025 18:49:47 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V54v87uxZCH7; Tue, 14 Oct 2025 18:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760460586; bh=hdQ+lgMLu/JaI6S6oyCUDuEqX6s4fUPXX5eCMdkEmRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UBtnrIkSnQcyOOxdqUmzLhbBqQ94HewCcLvds0OlC7yaFT+LE8xw8laaXibWXsFi/
	 l5D2pnHV+Vz7apsWOs3sJFpX0nZ22M9vD7UhCsMaU3foKOtXLnOOr08gzVidaa8XC2
	 HCdcbMzOND2zW92XC/hLVUjSPy1LagcSqJuoRdRD8rSKmhnFqQOPXgfbsLFkRCNiXs
	 WSKrgNkVkXIHnpjklleQ8NrCMjIqcCV8zIxrAaxWKsdbLWF4hZehITFx53dlNEiTUP
	 NZtKKEUDQ2LifEUOlxPuf3bOCP/xDTcCC1ueSl2o2pyBNRjKtwhYdfuppECHT5h4l4
	 QQG451ZHDyfJA==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 2/4] net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
Date: Tue, 14 Oct 2025 16:47:45 +0000
Message-ID: <20251014164746.50696-4-ziyao@disroot.org>
In-Reply-To: <20251014164746.50696-2-ziyao@disroot.org>
References: <20251014164746.50696-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
by a previous series[1] and reading PHY ID. Add support for
PHY_INTERFACE_MODE_INTERNAL for YT8531S to allow the Ethernet driver to
reuse the PHY code for its internal PHY.

Link: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/ # [1]
Co-developed-by: Frank Sae <Frank.Sae@motor-comm.com>
Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/net/phy/motorcomm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index a3593e663059..e478e4f51755 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -910,6 +910,10 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
 		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
 		break;
+	case PHY_INTERFACE_MODE_INTERNAL:
+		if (phydev->drv->phy_id != PHY_ID_YT8531S)
+			return -EOPNOTSUPP;
+		break;
 	default: /* do not support other modes */
 		return -EOPNOTSUPP;
 	}
-- 
2.50.1


