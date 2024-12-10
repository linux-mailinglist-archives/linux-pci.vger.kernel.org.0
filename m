Return-Path: <linux-pci+bounces-18020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A909EAD5F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 11:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C566188B328
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545BA2153FA;
	Tue, 10 Dec 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKpbBCuK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C71DC9BD;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824556; cv=none; b=rjJcCOVLznVgXmQ5RPX0RVCSyl0S2BHvCI6fkoc0oJO3GLLccwDbWAA4IEME9qZb9+V+zBJ8C4BeDlSpQxbB2V0ifo1SFCbG9ylX1nijr1UhqXGpl7iwIEl92+J/9CE/cgRMbxUcpU+x6sPdjXOfRR3W9sA2C/R3CnI1AtRG9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824556; c=relaxed/simple;
	bh=T2sh2Q/Y9fgSGBrXOiifiNvzAqHpFKWViU1vs72cjb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duKeRnwQtPhNC9navoZ7tTwPjBf6PvuEtTlXEZLBPh+IHG/f8Z/BnZ6YAis1yriX+aWhvqV6deCi88HI6tO6u85R+ZM4ERGSkwiIHOgkaMkfZbrDH/J2bYXW46UzEJeVYw9zn7YacrpzACwdg8Lbh373tfo1sDW/8P4jIZj8M9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKpbBCuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3BF0C4CEE6;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733824555;
	bh=T2sh2Q/Y9fgSGBrXOiifiNvzAqHpFKWViU1vs72cjb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UKpbBCuKyDZyahGDEAXitj9E+gb6tppYsmw57OyRVQGVcP1Iwk3sgJA3rREMFuxZN
	 dXz/otSfMNEwiidH91Gp1VJn/QMbFrHQuIEdRoSkT2eSmZzh9N9iRGhiBdF9n/pANw
	 IP0w/ZsahhJ+oe2qCjhH+QmKy2TQP/kv6bQ4s8PcVWd02rRtZY0O+0fQTuGTcnZGkD
	 0eoX2b52ok1VKMfthz28fsztdHLqt5kn9BzsrCaP2T8dYz3nZIH/kTNtq/3FLi+3XL
	 5kyUedwSggQ7i/R5V9unUm0/JYf6Je7RhIcpqeo76RJHvDtM0EYsoJjXkODya6WZ0a
	 KgR715vXxNUbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C811E77180;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 10 Dec 2024 15:25:26 +0530
Subject: [PATCH 3/4] dt-bindings: vendor-prefixes: Document the 'pciclass'
 prefix
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pci-pwrctrl-slot-v1-3-eae45e488040@linaro.org>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=HKM4JQvLtVZEuK+wBVjVsihcFTWIsR7scQIFFFt6+xA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnWBAobw0O8/2q4G9PbPmaPc/g7UW2Uo2k1SzXS
 3PtGNLZQbuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ1gQKAAKCRBVnxHm/pHO
 9Vo7B/4+lSUrKEPOl/7bJDUkt6FuAdR1edfTmZN3KB1SZp5qApaRRFwAtIMIvvgA/GOKeju0YUU
 Rv/cUXm9VOt+zCJBge69DdtjK1Z4IXtNk/HbtKUVP5aGeH75LdswjMp3Z32rf/55r/c94VtbLu6
 r7k9k+FpeZetGTkuQPtYvPOgLMeV6BOVyda4Iz8LLklkMO1b/46Gt0EuiUHk74DhHrpRSQslKkJ
 hnNcreJ3XDYwCWi1Hl+dNru/3FeBitdHjsW3Hmn8JGvqkJlRo9WGLepFYbEAq9IXb5PE++VMIuH
 yqkD/CWnqYtmjH3HuUHdS1mgn+90zP8odjonKA7zZTVq69FD
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'pciclass' is an existing prefix used to identify the PCI bridge devices,
but it is not a vendor prefix. So document it in the non-vendor prefix
list.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index da01616802c7..0539aea6af5a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -18,7 +18,7 @@ patternProperties:
   # DO NOT ADD NEW PROPERTIES TO THIS LIST
   "^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdmi|i2c-gpio),.*": true
   "^(keypad|m25p|max8952|max8997|max8998|mpmc),.*": true
-  "^(pinctrl-single|#pinctrl-single|PowerPC),.*": true
+  "^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*": true
   "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
   "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
 

-- 
2.25.1



