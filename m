Return-Path: <linux-pci+bounces-44421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6ADD0D207
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 08:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89C6E30B330D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E167034A3C1;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PevRFR0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF9348865;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=C7V9fM/FiEj2WrmzmbYRqTDfHtSF4OsL548N3yA/PClGU6ak8OQ8rS1/GFDOnkAoilIqq/h5xyQZiOOAdqiMIZKYIvJcBm6cXljjeESZShum58HVOPjgICJkmcgQu2fU1cP7XGPaTBlLL1yddJ0i2NVfnj/9NsSbyDQr/wl63kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=/73Is6LSiZFdQQ1Wgzmm55BHcfPO7Tzrd+XL5DP+qdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7AZcYlFa7Fi0+CTgYsSO3RxfQG/s10FiOxK5gnUZOtb7TVEZMsWLQdXcTqyV9+QuPL2FiucTllRM3KyMB4Y7Qxrea1PusiZ8u31Q80hbkkkBj/zM5bglq7SxU5ofBkHb/Kh/tGojdIGCg8PAlf4MIiuWF7M2EwTm5LyZjbSkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PevRFR0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B58FC4AF10;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028226;
	bh=/73Is6LSiZFdQQ1Wgzmm55BHcfPO7Tzrd+XL5DP+qdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PevRFR0huWOxNmIZ2WZdsNenQkI/6u4adPi1dbDkCeDRJRZkUIQ6o1eGNUhFrp5fk
	 ecaYxjxXrMwXJASUlmwcRltPhU4rAa1VF2DEyo8ihF+5FyJ0UL1LaVyEPMmUf8QJJp
	 rDQ0CO0DIRApgfcjjT/Vge3rgtQGJu8Vq3QSrARBQfdKOewSSacZ3y3r6PGU/MRFKh
	 njzX/G3GFTIuyXX2BEKX93NtRP7OnuQGmLGTuIqEc+UzBmDCa6T0Y8peO6qpZ4Q0dU
	 ocf6NRNdqxrCJ/2kgHdgghvWD49NCUm6OqhlHZZW6NjrJA9AHLLzPljMJwQSgCCIEb
	 ujppfrKhf/T+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D89D277D7;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:27 +0530
Subject: [PATCH v3 09/14] dt-bindings: serial: Document the graph port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-9-4faee7d0d5ae@oss.qualcomm.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
In-Reply-To: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
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
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=924;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=T/idG4KQSOfNt30dCJ08aa+KY4iI2ktYxKaU/4zNwXM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg9hVx9oXxHFkCZ6ayTfpv7OrIXAlqSTNYnD
 l8BvU8TehGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4PQAKCRBVnxHm/pHO
 9Zj5B/9FIjw9jA2pUEFQRfVjmhW9kmIDAx8BydxO0AL1yaiDPopbZg6C9WwrJAgtaEx+lk1KRss
 zrY054C1qo2Jo5Sfbhka1l7iXuVZatzbLl/6ahGv6BHdhxCL4SQNRxiYgk3MUaJ5K/pxXq4TOFg
 2RvYtM8kTOfUyrDkMgNJXSdoUIIVfu/UL2XyaBghe+wtpnuidK7CmT0ZYzV2Gj1xVFwYJnFAunn
 98Sh/AhLonSS3D7oxftax0zvR64ZtTWh34BjJ5lvYRc8Xxndn+odWCDrJoQP1OEtGmo+9nN6PTy
 IQqGi5soPZwdnGWzXfT4rhVYuHwmvy0BgULtqpWab9rYTznk
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

A serial controller could be connected to an external connector like PCIe
M.2 for controlling the serial interface of the card. Hence, document the
OF graph port.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 6aa9cfae417b..96eb1de8771e 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -87,6 +87,9 @@ properties:
     description:
       TX FIFO threshold configuration (in bytes).
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
 patternProperties:
   "^(bluetooth|bluetooth-gnss|embedded-controller|gnss|gps|mcu|onewire)$":
     if:

-- 
2.48.1



