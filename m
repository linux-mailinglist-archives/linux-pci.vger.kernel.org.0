Return-Path: <linux-pci+bounces-19115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1311C9FEE81
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 10:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DFF3A2D39
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7F19ADB0;
	Tue, 31 Dec 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg3uclUb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C5196D90;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638254; cv=none; b=X1STClOovc0LEiXMuIf/gm5YjQJq9w9U9GrYRZbAd5gKdw5S3DzW/32WWu8BJnSjcUxjcIe8zlonA/hxDMszJ58+YYcZEr7XNF0SAamhu5JOf0JR/qNb7IG75/lbovmkl/7Q3DSGKF8nr4DJvpA5S6uK4oPO1q/yZEgsv01McPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638254; c=relaxed/simple;
	bh=EmN4Jn2rIvX97LgY0ou3YPQGNYpXchenEI59Nhj03LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVhk0eNyPF3sHDWkfeO7uLa47FESR8zigNEEdhGlKgDK2PLOgWZ6RTee+T5Vy2TKA8009R+/lEeIm8e8EkqL35kc8EOsth7fRJZGlCylTjrnwYKEKmXeyIx/m0NYO0+gbl8p6B2FbbeWndQf/WobEBQpITUBhOR7mgy5xZUPBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg3uclUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2182BC4CEE6;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735638254;
	bh=EmN4Jn2rIvX97LgY0ou3YPQGNYpXchenEI59Nhj03LU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tg3uclUbsdQ2rvF1gDq962DdXJWsUR5eWkQoKINsvc45XAtFyj6m33jNXCO5zOrU8
	 f2KuRYEuZ2uQQG5Gf++0KKXHXkfT8lmE8XxTqMvKrjA8LbO74tY8/3UC9+xIzCFSYb
	 gSZIaSnjGZ3XMxptZmKAKcFVQ8cd2PYUf7V+durV+q/eOb3c7V9sbJ0ZNfw72duMAI
	 puuDKzRTEjrrLjbbdOLp95HOec8Qp8apRFkLeW1S+zyMFq9wvub4/66iPMP59e62hV
	 mVb5h/NnjCSM3aRAhKbwjVXGjZvQ7Vl71+MvQIbQFw1QZfU4XuFuPX3nBfTVlwYSCg
	 yVow+gSbrL98w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1570DE77194;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 31 Dec 2024 15:13:46 +0530
Subject: [PATCH v2 5/6] dt-bindings: vendor-prefixes: Document the
 'pciclass' prefix
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241231-pci-pwrctrl-slot-v2-5-6a15088ba541@linaro.org>
References: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org>
In-Reply-To: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=2V7zx2KeHk/VkOVQ7/eUdxe/lfsvltP4xYw5h/bK3Jg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnc7zrdciV1jQWsadhJ4t7js4Cn7Ak714NgV2do
 SpaQY946HaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ3O86wAKCRBVnxHm/pHO
 9Ww/B/wNerD31lCjE4OJmIqxQWZOqcYw66Ta2d/3+wwFEIL6JD4t1JgG2jL4MpUM78L0AcQO1VD
 ga8zNq0guDXRBO9DiyWZnziUcnARZccKeQ0uJD/Jtd937noG2D9fAld8rE9pePmYTCJLG821BO0
 4N0V/jwr2uE6kxDFFU5flAp/65B8TMAstqX8ztjzDclxDWsrd9kTcnaPeJmvHuxYBFT6ChUtswZ
 H+1RImAANVNEIJfCP1UICzTDIoZDRE4qOAb2aUVTYAoDFdSh2oEtNv/FrGgWmMtuz0UYhux0e3C
 CneMG3xbsj2tInJeElO3YgsFrFHMxHdaMAkQTa/4EWQDc3bM
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

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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



