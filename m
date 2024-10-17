Return-Path: <linux-pci+bounces-14711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3D9A183D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9C01C20A24
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C233A23741;
	Thu, 17 Oct 2024 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENbypHjk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88622087;
	Thu, 17 Oct 2024 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130346; cv=none; b=Hts+Obw+TitAgKsxgQWDm74wbZJ6r1L/JmepPWuoMCPlpb5Yp35UAv2CH//VSdY7ad7VGlUbQRJQHS0KZ6zmIGF8PCc5R3Q1zsLi1TpuqMnM+NSK9mzbcvhY46fXJ6b3iT6BnKy9nEqi1GtljpjkZ2+a6lJDxvKuKtjJKnZ8GzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130346; c=relaxed/simple;
	bh=cGogfKDAaP5QdN9tIREGdoJWnNKUGTNQsxIwLw1Hkwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2+3Udoyv6J8aPgDqdf6TyeWwNYUjVz3HkTbhRDX4eiCe8O6UqzS7u4fB/u87IlZbIDDpu02A0b+3J/aWIBAEAOvAwOCXc0BwTpxv9CW3bEyHsDecnQzizjB45STwF2M2ZzWZQz1I5yxDUf8mUkOMXjl52TiNgBPX0QUPcL/k1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENbypHjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DB4C4CED0;
	Thu, 17 Oct 2024 01:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130346;
	bh=cGogfKDAaP5QdN9tIREGdoJWnNKUGTNQsxIwLw1Hkwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENbypHjkiFN71XKpXMX/O2XF5TmHRJ8GkuUQEz10j6ffehYmn9Gdvt2r0+pxmGyh2
	 uWJdJcry0O8u4NF+8YJ28UId1T2l97blSKp5iKcOvYCA+xijbpRjkxKxipWo6t0f4i
	 5xKACM1kKwi/T8ki/hYW+MdaAqsDAfySOyvhUnaHqHlW8Xjy/YTZkERSwrkdb4ARdV
	 tFxr3ETOSP21WIMCH3vuJv+XlurkWpB6QGV54WXMw6ZsYDokowh87etCm5SZflUCp0
	 3k5dx4x9Q9kd/jiRKuRj+2mNsZwhVxWMavcS2i2hb/czP984UeD1z+oJbIuWpzG3oO
	 e03Q4Ua05n3/g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 07/14] PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
Date: Thu, 17 Oct 2024 10:58:42 +0900
Message-ID: <20241017015849.190271-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To be consistent with the usual "get_resources" naming of driver
functions that acquire controller resources like clocks, PHY etc, rename
the function rockchip_pcie_parse_ep_dt() to
rockchip_pcie_ep_get_resources().

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index dcd1b5415602..705f6741fa53 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -494,8 +494,8 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.get_features	= rockchip_pcie_ep_get_features,
 };
 
-static int rockchip_pcie_parse_ep_dt(struct rockchip_pcie *rockchip,
-				     struct rockchip_pcie_ep *ep)
+static int rockchip_pcie_ep_get_resources(struct rockchip_pcie *rockchip,
+					  struct rockchip_pcie_ep *ep)
 {
 	struct device *dev = rockchip->dev;
 	int err;
@@ -557,7 +557,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	ep->epc = epc;
 	epc_set_drvdata(epc, ep);
 
-	err = rockchip_pcie_parse_ep_dt(rockchip, ep);
+	err = rockchip_pcie_ep_get_resources(rockchip, ep);
 	if (err)
 		return err;
 
-- 
2.47.0


