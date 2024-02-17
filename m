Return-Path: <linux-pci+bounces-3659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31E9858FB4
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 14:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2697F1C21117
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 13:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AEE7AE58;
	Sat, 17 Feb 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="EX95BqER"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A94E1D2
	for <linux-pci@vger.kernel.org>; Sat, 17 Feb 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177105; cv=none; b=FaJvSr0CjevcYYLULEUWUurl0Ksa9b7nyeCGZ7ANaiHvgwScNstxvwGtF16caW3F3f5WY3MlxjeOVuk+6lSii1DBxTOXuwUKT3Kq5T5RAUokA7hMi2BXFMEhelE5WZwhiDYK9kSiMk8XiMw2ucz1nNPebmSyTJktBe1qRjE9Xis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177105; c=relaxed/simple;
	bh=w0ROUewTInuPq2j3gG9LCyrZgq9TO2ZUFdX4bS+6Okw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FuANqq8EwqFWtKl3+KC9VLb4EkgwaLGKQDEqAQq73J+9Mxi+tm0YAi9vALs1iRIqxoTrG9ENRKSzyfR/9ASBt0EDyLJAbIOwmT8xt7Kj8tKGL3P2HZtTm04Vq0ld8ds71Vb0G/w6lw1b+qqETJzmMXRk7dzbz8WzmP6MtltdRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=EX95BqER; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1708177080; x=1708781880; i=wahrenst@gmx.net;
	bh=w0ROUewTInuPq2j3gG9LCyrZgq9TO2ZUFdX4bS+6Okw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=EX95BqER6kYpS4iS4P9ZvtTUxzyp8oWAwmQLr1UE2fGFe49xGtJQUIxH3CZGzWUK
	 GqjuJsamwrVFtdFIwNdolU6XQbCche6VuFSmMCGo+4QA9EaLSh1TCWyn34chXHUvI
	 JiHXiNSK7ew+U19dx8VAbE1pMk55IaOsB77+O7Q/VA1B3moy6z6XuRBnMbcOKCPP7
	 Pc2g7PxzlVz/9zZ0D+1A55R3scVNabM8wfv3GC+U/U/1zskESsXtui+zDg7yz18SS
	 V+OTLOUlfG8mK5YHUEo9w4nJYH7Wdxt4WNa2mq+r7LE/lXaCNm6Oe4qkuP7QQgOKc
	 zUIKDfZQsBhLglcQUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1ql1BV3Lpi-00rZvT; Sat, 17
 Feb 2024 14:37:59 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Cyril Brulebois <kibi@debian.org>
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] PCI: brcmstb: fix broken brcm_pcie_mdio_write() polling
Date: Sat, 17 Feb 2024 14:37:22 +0100
Message-Id: <20240217133722.14391-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EHf/q8SnQPVn+fd4Vo8CKB7ejhFUeksvGPbL6tmaNjskgaLD70v
 xoVF1iHwLO4+es3jQ6GZZGmPrSlHsPbeFg/6Xyo/j0jVCweERcJDOF4YkfbfjBandh5DBY8
 R+urFL+w8pIZNjMrjXAp98eRfHYQBlcn1swXhqiSRz3qLAqMURrYhcJbkCuA0qouucWrVW0
 F0K0cPbBAW3BI77Jl+FXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:coubLfRrff8=;PSWUJ83oT5Ld+OKGgZWHcUZ3mFw
 VuEKJGw2KnExuGoWenHmNpOk1UZFactZERT+ythp25wtNeET6AMB34aK8Lq4wFPzfVKoEWVsx
 fNoDbQsG8DZTRYXWiGBXMB69YP5HjJCx7naT5LOzxiLnY0WU5fgWZUrhKr7NL200EkLJulmb9
 /ReFI8LfbBtQw5vzcgELKXAn69AyJqKsTbqCmvtVZ1hOoug3MbgQFagsdcg59kFsHZubGR0h4
 4WpuQoS+ywCdLUPQXi3M0ihcWM1Rim38msBV8qBjVtwb52O2cYnX4xQXz1qqZEdS68B1ROHQK
 EXMjjl9KWD91Kvla6aCsbDLbLMkJrtHnDLt/lvGnEDFNIHbj+xwEDciN0nmcNBfq202iJjmkQ
 DnBA0OIzSSuTK9wLssG9zXtPQOeJbdjnLwbIV7JO1g13mB5KXB2F7n/TLdUowc0UJC7HtNccE
 gVZcZ/uiRUOTohioKnz0fRTebShw4R/sJ8Nmu3cMPk6BHz3eyfT+40jiUgwSEiv7gn00qZkpD
 TADBLQPa2wSq3WiOmcU/aDPR3dPx0ZddwnRY3sVMEYuGsH800obUArgN58CAwl3AuHBBhxVbv
 k74jelzxteEknu+JLucguuzVoeuhm2ERm6Z1l6mvQ45Xhyxt4wcK7Q83enlCP+xJElxtPEvUv
 zjNUCAooijWHhj3cNbmjd4gkhEAjbunbiNflRvVSZWlo9GkOwcJ1I6fmdghnPTd2ust/ncp9W
 Yv1tp/yAdD8087cIPY+fi41uPkHfJ+d0KhH2xWPIvpKMZk6XHXM4wm4/DtYvU+pH3ItQ+0aT6
 y5jfDB8+jtaCDkrZhDrgVIvyFgZ1t3wF2PL0AZNHesBK4=

From: Jonathan Bell <jonathan@raspberrypi.com>

MDIO_WR_DONE() tests bit 31, which is always 0 (=3D=3Ddone) as
readw_poll_timeout_atomic does a 16-bit read. Replace with the readl
variant.

Fixes: ca5dcc76314d ("PCI: brcmstb: Replace status loops with read_poll_ti=
meout_atomic()")
Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controlle=
r/pcie-brcmstb.c
index 618e84402eb50..a7f05e0c4ac51 100644
=2D-- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -420,7 +420,7 @@ static int brcm_pcie_mdio_write(void __iomem *base, u8=
 port,
 	readl(base + PCIE_RC_DL_MDIO_ADDR);
 	writel(MDIO_DATA_DONE_MASK | wrdata, base + PCIE_RC_DL_MDIO_WR_DATA);

-	err =3D readw_poll_timeout_atomic(base + PCIE_RC_DL_MDIO_WR_DATA, data,
+	err =3D readl_poll_timeout_atomic(base + PCIE_RC_DL_MDIO_WR_DATA, data,
 					MDIO_WT_DONE(data), 10, 100);
 	return err;
 }

