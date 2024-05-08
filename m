Return-Path: <linux-pci+bounces-7228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF79C8BFE39
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865C91F2350E
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209697A15A;
	Wed,  8 May 2024 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi4E4VIC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD8779DDB;
	Wed,  8 May 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174029; cv=none; b=OzZrqHswlRTBIIYW2bjioQKqRtFbM/Ls9ejfKy91XiZ8yfXdtov5S6uocNF7H2qqADzyFo/cinAqtZCgknyztTFulsKvOlBl5TFo+R0M6B6qFGWQQISLAUx5vBT5sUA8k4k6WwwHHqEMicbLZDk57Zn3h10UaAZCLDK1WMEDnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174029; c=relaxed/simple;
	bh=dazCN/iT/MHdY+ckymlAcfBjUpa3OmMTl+4+NDKJR2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FzkjWZA3anDX9rImBsx8xHOFPyweRiZjJSRdOGnGmtIsPyxsyFMrv3UrY2+63jKIvXXG9g4CjYiyMwRET1ghElDZLLL/tbyCL6A3suK1gtc7nrydD+6PkROODW7GxsJh0buMw/CzfRFgEXX01fV5PRDPi7srJTGD8Av3gK0nw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi4E4VIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD70BC4AF67;
	Wed,  8 May 2024 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174028;
	bh=dazCN/iT/MHdY+ckymlAcfBjUpa3OmMTl+4+NDKJR2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pi4E4VIC6PlUKiRfH02y9WHAKtBRzIOB1Z33gdIKcmkXVBfeVoaoRHuyxHrGcSA7V
	 k+cEWHlV7ewtslwfMtDB/n7uajEAwcdpJp64e67nh/QJUyvMncSd+RMOrs9JfefYcm
	 WvoByh6cYGJilhWkPqkYLiLc+GjWGaBIiG9Yh7ibdrP2G68YsWI9yH90pAfqH7w8a+
	 nRW+0shdXXyo4+qf7IlqKyhJyqdeC5Z9V8uMxfmfBPoNGHjxB3WPwATDNc5YVc8nYj
	 IYpeCHi7NTu/4iHcIeCGM53sOTg35BVgM3e2GHYB4SfsOHNxNO0bHtYYlyRbidcPrM
	 3+QFCTc1+BPdA==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:33 +0200
Subject: [PATCH v3 02/13] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific interrupt-names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-2-1748e202b084@kernel.org>
References: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
In-Reply-To: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=cassel@kernel.org;
 h=from:subject:message-id; bh=dazCN/iT/MHdY+ckymlAcfBjUpa3OmMTl+4+NDKJR2A=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKsq+pXvTt3YIdE5EqO0pe37rbctkmxdruwZq+k01HHE
 1tj7Ev0OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjAROW5Ghj0ttxwYolOlU1Zc
 ZXv4xe67enyLR3/bg/lnJWd6bO7+Vs7IcKtAa8esN0HaHG9mKV4wTsnZ8WjSVCXx/Qc1NpyL9O9
 UZAMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Considering that some drivers (e.g. pcie-dw-rockchip.c) already use the
interrupt-names "sys", "pmc", "msg", "err" for the device tree binding in
Root Complex mode (snps,dw-pcie.yaml), it doesn't make sense that those
drivers should use different interrupt-names when running in Endpoint mode
(snps,dw-pcie-ep.yaml).

Therefore, since "sys", "pmc", "msg", "err" are already defined in
snps,dw-pcie.yaml, add them also for snps,dw-pcie-ep.yaml.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index 00dec01f1f73..f5f12cbc2cb3 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -156,7 +156,7 @@ properties:
             for new bindings.
           oneOf:
             - description: See native "app" IRQ for details
-              enum: [ intr ]
+              enum: [ intr, sys, pmc, msg, err ]
 
   max-functions:
     maximum: 32

-- 
2.44.0


