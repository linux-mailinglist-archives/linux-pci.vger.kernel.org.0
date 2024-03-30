Return-Path: <linux-pci+bounces-5449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE289295C
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 05:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDB228373C
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9D847E;
	Sat, 30 Mar 2024 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWsIvubV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD941849C;
	Sat, 30 Mar 2024 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772425; cv=none; b=Iva3Uac4jvjxXUDROysHfbQZda+dBfInMG0DIi7rGHp20BRuX/Wn3XzZPkFIMxYQVLsr/SEEKhYiUpV95zxXCQ+nj6yqKBPKq1to7W/wibvUGJ+0BqUmCJzqtyxhSdwqH5rVjiI5LRx+uOo8WwBPag8R/OQmWZT3925huxqUFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772425; c=relaxed/simple;
	bh=9stkOLflAG6/3kVK40zaxko5NFLtGR7KPzA/Rp38W/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjqhKTj7y2xgnyaD++0yBzwlIECuz5PxPECTAzRDcUNskAYyM/7ymCfvXP71q/4mgMdrkJCkvNM/R/pc2xTtrI9A8jclsU4qvBVKYoP9rAam50B3aEp+oRdmXvQq9ClKLcVOFYLf2MWb7TLKYMS8kLL4jzCq859Qnq6ddHxr2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWsIvubV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2055C43394;
	Sat, 30 Mar 2024 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711772424;
	bh=9stkOLflAG6/3kVK40zaxko5NFLtGR7KPzA/Rp38W/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWsIvubV/iQ4i4niDzLQfexxBezMLA6Zs/aP7fLcgCX2tglP5gdV3brj4Bz9Gn86R
	 j9wWSzeDvQSxsAFc6AE6sOb0Ee118R/fnDv9W3UVOIHXjg72qCpyH9osLLvh7ueG1R
	 LU1HOQTIy1rXCmDjmWks7pviMywZPZeDrZn6P8aYHpwly7byfqy/oIn8c2KtGx/eyb
	 IwXVY0BDYNlkkaFC8u9qZrJ7jzz9y49V9n3rDG5CdOZuvah0qQCvc/b7atllxeIlZS
	 UJOiGrSEccfHsZvLDI/zDMFzOf9aW+yHkAXsrIn4weWtD8uCMNN9ML//R0dUkH+tKc
	 eHpVJglbc/osw==
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
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 17/18] dt-bindings: pci: rockchip,rk3399-pcie-ep: Add ep-gpios property
Date: Sat, 30 Mar 2024 13:19:27 +0900
Message-ID: <20240330041928.1555578-18-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330041928.1555578-1-dlemoal@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
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
 .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
index 6b62f6f58efe..9331d44d6963 100644
--- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
@@ -30,6 +30,9 @@ properties:
     maximum: 32
     default: 32
 
+  ep-gpios:
+    description: Input GPIO configured for the PERST# signal.
+
 required:
   - rockchip,max-outbound-regions
 
-- 
2.44.0


