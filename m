Return-Path: <linux-pci+bounces-13921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22F992378
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02B11C21B9A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F33C502BE;
	Mon,  7 Oct 2024 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZH8bE+Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373702AF1B;
	Mon,  7 Oct 2024 04:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274366; cv=none; b=qcQDon37Ec1rzPsQ7MUxE4W1xPVdpcb01KvMpsa9PI19L7ZOjoA1xrm6USNIEueDzvsS0eH3EKHS9LYwefS8Su/Or9rWibvtMmSQ+eY2UNk723SYOFokexf9b7PFHQcD0qk+1+WCbakyYDGVuV1Foa17rCU/oCq0KXyWpw0SoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274366; c=relaxed/simple;
	bh=C6RIdeyvQKZh9z5RSGrLA4DfWGjaKLJl7wwv+6mWXJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNYB6nZeVurAIg1SSLB0K1ST+S0uZ8nxtzw9lySheUY8KsD7IqjTpjj2O1rrRzKPDjk7/LE52l2PF9jqYujsKDHtIKOSOypkzWf1VeeTBLf5RFUmdXrBK6dyGzEvvklXKbz0ZvslWVwMvHG0QycIRjDIcUH1U9L9FA3SJkN3fbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZH8bE+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E40AC4CECF;
	Mon,  7 Oct 2024 04:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728274365;
	bh=C6RIdeyvQKZh9z5RSGrLA4DfWGjaKLJl7wwv+6mWXJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZH8bE+ZrFByQnTZwsyTfS69hBJ21ffufkZj48W6tOMtlmuDyiH0kwdDN+zP3cxuK
	 tWNybfwzrvEyZ4lxbqA3inDK8g/fOs4fxjjdk7yS5bJkfDIdvhEJfXTCnnYD/27VVU
	 TAF7fUiNguf7OtCbbJEhoSwkcT1pDzVTptXIk8x3rHqOUsgNP5m/CG3v3DXA9ACqxe
	 VFX0TUc92kG8+Qe4Uwx8rduEK5VNT5WAsMyMiBdbhze/8mm7BK2Q7VKoT3XeD1lybU
	 nfuU1ySSa7S0nf4Gj0py1F028HRYZ8Z26Tz/wptw2c4KrTf5c3Yzo+N+ReXxt3FQBh
	 vStKz7Xa/ufKQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 11/12] dt-bindings: pci: rockchip,rk3399-pcie-ep: Add ep-gpios property
Date: Mon,  7 Oct 2024 13:12:17 +0900
Message-ID: <20241007041218.157516-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007041218.157516-1-dlemoal@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Describe the `ep-gpios` property which is used to map the PERST# input
signal for endpoint mode.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
index 6b62f6f58efe..a8970bda7174 100644
--- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
@@ -30,6 +30,10 @@ properties:
     maximum: 32
     default: 32
 
+  ep-gpios:
+    description: Input GPIO configured for the PERST# signal
+    maxItems: 1
+
 required:
   - rockchip,max-outbound-regions
 
-- 
2.46.2


