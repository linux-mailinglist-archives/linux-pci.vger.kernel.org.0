Return-Path: <linux-pci+bounces-5392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7829689157A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3392F285DE3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217336AE7;
	Fri, 29 Mar 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQabuVT2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8E37714
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703415; cv=none; b=aafOoBbKt551mcVrOwMnfhEGeoBCpxcvNYyvsYF4l4+Xu4+SDcpZh6X79+ZtywymO5Eef3fFRqbfqwpNKqLjIHeRF8caBwDkdkFwbqoLl2y2osdUJO9wibCC+JDcUcn4fCkVYRAMWXbCnqsctdUuCTGLzOBnbUKlM2xP65+QXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703415; c=relaxed/simple;
	bh=7oDGTy7Lw9gvGIO8M6FvPbAlyOWQQdvFe/jiW9a1h3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQZNIc0RBmjZQ1fAgtoiOFRQgAI1q54kWAgrQPhTmRLkTZ9FlAdBIsewpRZoMuOriSPj33/W7v3fIuNzDX9aXLsa4uNucSHKiRll9XKvAN8RMdUZHa7CrEmirjqpf+5HXeTGYF4rfbMf8o7kzdHP874fVauV1380OyrVyEfEi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQabuVT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FEBC433C7;
	Fri, 29 Mar 2024 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703415;
	bh=7oDGTy7Lw9gvGIO8M6FvPbAlyOWQQdvFe/jiW9a1h3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQabuVT2/wm2HpNgWsT5QsW9+2tTGubZLksdh0wQiVdwMANADoXD8g7JH2x9c01H3
	 QtSv1UBycphovECJf6nCEygV/GJKrBHzWM4KtGjoAeIANHihSD95UVB2bWxIKMD2QL
	 sE8fCyAsM5DsAgjMsZSBorpaEaz4QhObKb9zGD2hM+lQVzxySXqA2gxxTUDLNsalxd
	 a2nG8pUQwU9KEQFcpEdG3IN83mxYL37gSvyVIzXkWPHbF2JHCTlUhHIqMPSzWYFr1l
	 4pG21Kwvd2X4cooLl7GC8gDGR65e4qVG3v5yFmR8vd9wMwwEiT+mJYw+GeyQs6nI2F
	 aWzERCjqanxOA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 18/19] dt-bindings: pci: rockchip,rk3399-pcie-ep: Add ep-gpios property
Date: Fri, 29 Mar 2024 18:09:44 +0900
Message-ID: <20240329090945.1097609-19-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Describe the `ep-gpios` property which is used to map the PERST input
signal for endpoint mode.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
index 6b62f6f58efe..b8a5b567a9af 100644
--- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
@@ -30,6 +30,9 @@ properties:
     maximum: 32
     default: 32
 
+  ep-gpios:
+    description: Input GPIO configured for the PERST signal.
+
 required:
   - rockchip,max-outbound-regions
 
-- 
2.44.0


