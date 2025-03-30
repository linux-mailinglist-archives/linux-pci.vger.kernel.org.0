Return-Path: <linux-pci+bounces-24993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B6CA75C16
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 21:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C047A395D
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8E1DF755;
	Sun, 30 Mar 2025 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XEZG9aie";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PrY04B2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488B4207F;
	Sun, 30 Mar 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743364727; cv=none; b=Xdyn5XgiQdaVy8MTXIrRmU2CHfje5xTeyWMtuxN/GiX8BSMAtm9HFUezSsUql3qY1WdvyZy8TlQjhwozfCuDTsH2TYmtSJQAjTvZBezqk7Fc7bv3olVuifNyclPts/KHsWGwVTQlvd0l682N0xT2M0uane+C13oTK3MKC03Y4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743364727; c=relaxed/simple;
	bh=uAoUeZLeVXJiil6IY0KeyV6g6HaQbDLBxfzdVHiPyHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOMCefewZJxnbH7UAY8W/g2jmVdgePrpihWggSK7yXkl0B5mtOla350dawi2O0BX3fmz1ummzgc9ToR+mGUJKzevpg6OqMcBIT1hTcUkZKQklcwOBeekk/ySm5ZvdWd8uvaQCuwp413DaNqKIJIFgenV6HiiIViGqQC/DFhuim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XEZG9aie; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PrY04B2H; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZQlSZ38N4z9tMw;
	Sun, 30 Mar 2025 21:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dB0HkyaDcO/o8Yz5vpAZ0YdaxioxQKZgF7Z+3OSsvfE=;
	b=XEZG9aieYDMulM1d0eECzh92jKfunl9M/nCq9t54QKTBbYpkTl/wbKSs3DKpFTBoL7pCJt
	EoMjGc8xvRcxsqCePDADgeRdMwA5TOKF47jME5kQoZbJfm172PYDi7spu1SSdGQE5j5/9G
	8xXPtzNLx4+AxV2yXLhRRrqk5AX5HSlVNDIhWSi9sTJzscK8VH8iXxrQMuADAkft3d4XXg
	7OUuvoTN/gG7X5XtnTcEWk2SejfQuX1+ZMG6hwBKfrfiKhFZfG7sNTEOv3Zk5NlKwr/Oou
	gRNaJ7JGJhCzQ51KJgiYM/6W39MivvmnaRyae2ItJxqxyFISAowfaPaL1jGRmw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dB0HkyaDcO/o8Yz5vpAZ0YdaxioxQKZgF7Z+3OSsvfE=;
	b=PrY04B2HFXUWEKy1FSAAttSIUz1AM2uayAOuP1lis7w1GHrzgXcPOUGeD9unJVdsV1n9/3
	8oPZ1LVy8aenSpy1J7bbr+/VaQQTQXsAexxaTo5riTRtGzU3mPM/KfPg5kUkcBsVETpx7I
	tuFRZoKGvv/QtH+wswiiEKADYhHYSTVsVcQndxfAUs9AaGCGzM0GMUFYZoqE4ZMBVSAaxK
	lsxUwazmUv9EEWFHst6U2cC02Wrmv5iSH2rET6UWdDHgpZJ0vhokPYwMSsYpITMWXZfgFe
	Rymrj68O2O19qq47ZXdjWZPbVBfvjdHh6X1lrEtGMM7Cpw6fVUoHkShp/u5NBQ==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Junhao Xie <bigfoot@classfun.cn>,
	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: soc: renesas: Document Renesas R-Car V4H Sparrow Hawk board support
Date: Sun, 30 Mar 2025 21:56:11 +0200
Message-ID: <20250330195715.332106-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8zc833myjtjdzmroe7k71r6sxheyckay
X-MBO-RS-ID: 0256a3e279c46fb2a0a

Document Renesas R-Car V4H Sparrow Hawk board based on R-Car V4H ES3.0
(R8A779G3) SoC. This is a single-board computer with single gigabit ethernet,
DSI-to-eDP bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports,
micro SD card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD,
debug UART and JTAG.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: "Rafał Miłecki" <rafal@milecki.pl>
Cc: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Junhao Xie <bigfoot@classfun.cn>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 51a4c48eea6d7..201088277514d 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -375,6 +375,13 @@ properties:
               - renesas,r8a779g3 # ES3.x
           - const: renesas,r8a779g0
 
+      - description: R-Car V4H (R8A779G3)
+        items:
+          - enum:
+              - retronix,sparrow-hawk # Sparrow Hawk board
+          - const: renesas,r8a779g3 # ES3.x
+          - const: renesas,r8a779g0
+
       - description: R-Car V4M (R8A779H0)
         items:
           - enum:
-- 
2.47.2


