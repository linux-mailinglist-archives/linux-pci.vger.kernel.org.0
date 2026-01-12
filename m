Return-Path: <linux-pci+bounces-44523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF59D13FF7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36CEF3016AE7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1B36AB6D;
	Mon, 12 Jan 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj/dus4E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5599368284;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235314; cv=none; b=s0H90Sk7MJNkux6ez38adERmO8djIzStzGp70DL+zF4iYT4dg2RviawJWHjU2/XaMWlG9MPqT1YIg80SAQMrJixVq6t0LHOhp1w1gNkgyxlD40bMe4FvW1NbLp5foe78VM1ueQkPRw/n5Kut9F8Dxr43joJOq1rEyqiFR/RdqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235314; c=relaxed/simple;
	bh=uwW8257EhmouZpvkVKGgdUbE780fBLOlGG44AztWPJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iX96DTWNERE9/S3eZ0lTaLr7v3d2erQ1PxbbwPJSWH4TIF0w5HiMvepSpwFQnZijTP3Qtj8DeucSLBANaLPKN7+5FrF029eIJTLpHiR9uFzrCuPZklS5GZldFcRLEzhOWcer5JF9yM3twY8AzHELmK5wKDXVNsejIZq3nJJfDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj/dus4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B54D3C19425;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235313;
	bh=uwW8257EhmouZpvkVKGgdUbE780fBLOlGG44AztWPJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gj/dus4Ebu3+bJ8B8ksFvNd7Pq4ujI6e5xavjiVu7Luwteu1x04s8vU1JYGNPBppD
	 PleO1Esntak//tuz8tQ8itvcXUh080oK0/Y5NK5DHW6olM355DfDe+C9X789vD81Rc
	 o9fP5p9ItCGQNpwFT5gjHIiOBYDP+pumGQIn2tXhL6gxluqMv7fwozFAm9teQCvZSD
	 rb06Zk8dslHm8WVxk1L5AqtZPnd6pjf0ZuOH7mGrnxpj3UPna3CzF0cRsK9walxAmL
	 T+YYWoF9aMXEDLDoO0rYm0eUGODjoI+G6Zu2XHFPvOf/PynTuWD3fzB1ajiY0/a1fo
	 qk94m28y7Ms4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F5AC9EC9D;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 12 Jan 2026 21:56:05 +0530
Subject: [PATCH v4 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pci-m2-e-v4-6-eff84d2c6d26@oss.qualcomm.com>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
In-Reply-To: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=RWekJdEKdic9EZu4rQGv0fBKORumjbEDCuN8SBTLMc4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpZSEu9lkU8zXSarTBauv+J55+9dDXCd86TV95R
 Hg4HFzhvpuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWUhLgAKCRBVnxHm/pHO
 9en8B/9QtFwvoPLK8ytd54e3XPvecnAHB4Saxp+aBXFoEq0MQ+d102DNUVZifS3N24eYRSDdC41
 TPbnS0A0513Snh4EoY48GHNfeZPGv+hEXoK15gVK/ZNI5nK9O/MvRwKmj8r5zLxkrQ20RnV4hAn
 SoZbqUwgIVFYomtyQg9XoFNBvu0CK83/dyK9vANbA6eDaS/7rCf5TE3x4v4Brox9U+vj2WKRZ2P
 LudJmT+kr2Ut2Mg2sfdZHDz8lAUHyNcqPVCf7PPAn0U/9834LuvC1pA9TtQpYj+xDRPF1oLuiDV
 En/W/ccMkGvtcQTnTSuLjChp9+eiw3xds8HO+nU/Vt6vLFXt
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
spec, it looks very similar to the M.2 Key M connector. So add the
"pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
to reuse the Key M binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml       | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index b65b39ddfd19..9757fe92907b 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,14 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - items:
+          - enum:
+              - pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.48.1



