Return-Path: <linux-pci+bounces-38073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525BCBDAB52
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 18:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DCB3BD581
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC174303CBD;
	Tue, 14 Oct 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NfcVmVLt"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF5303CB0;
	Tue, 14 Oct 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460654; cv=none; b=U9seC0yv9NJX1jWTFzHZVwXmUgfCZ0fLpLQlXxuKkuicr148m95M5ndwM/Lrjs+soKjjl5HLrAzdBuZRNFcC0saujKS1UWE9L3DCXZbdTRjBvTZIcMvVeB+Nm6Pzr0KS+O0TxSnmlwMYOqxmNlbq7yckM8gRFfdzxlTYn3CsYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460654; c=relaxed/simple;
	bh=i3nX73Tgl7T+D6NnOb0YSU+/PS3VeVGXgGa2v7ixNu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6cm9w8Tep3umNkG624mi9H2QsYVcttNpQty8Ys5+uzyP5eq7e665TameKdJeMGTcT/YPYdAZdXZfrKFKQEmPu/f3KkClRPMOAQntj8oe7MRfEzcavtBEdYmZYr1v1yOVRdW7pr7cs8ktNv9ppLBq9XrlWO3s1gxlwOp4SsR9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NfcVmVLt; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C0855261E9;
	Tue, 14 Oct 2025 18:50:51 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9z_uVIIJSLaD; Tue, 14 Oct 2025 18:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760460651; bh=i3nX73Tgl7T+D6NnOb0YSU+/PS3VeVGXgGa2v7ixNu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfcVmVLtmLImuia58iMmr8PU0YvCKNT7GKW3gm11Jh8ntbSuHtg5X2Coqq8cX8V79
	 7q9ACYx4IwAf64yHdvm1RkybTiAvtW/IMpELfOGpP9F/ltEYKOuzgH+LgsWqsRnRvl
	 5jCo3i9mCYQxepUQYdRnmueVcDjEtE6ZXKYAgGeq3f409qRKu6mEYIQg+pyWo0Z0yy
	 DGKpGenNNyJakZtAUFCm8/KDSITkfsF4n0MKzTsr684wG1p34k7Jrc9pJ01HnX+yta
	 c/bqhei8HxksCzR4GnSZ0kpQGc2vvtorJzZv0JoZg7Wuq1g3nJdffBszDUW+hkssG4
	 GR+tM3BOcSEhA==
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
Subject: [PATCH net-next 4/4] MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue driver
Date: Tue, 14 Oct 2025 16:47:47 +0000
Message-ID: <20251014164746.50696-6-ziyao@disroot.org>
In-Reply-To: <20251014164746.50696-2-ziyao@disroot.org>
References: <20251014164746.50696-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I volunteer to maintain the DWMAC glue driver for Motorcomm ethernet
controllers.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04193ceb9365..6f44a3f57ab5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17445,6 +17445,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
 F:	drivers/net/phy/motorcomm.c
 
+MOTORCOMM DWMAC GLUE DRIVER
+M:	Yao Zi <ziyao@disroot.org>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
+
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
 M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
-- 
2.50.1


