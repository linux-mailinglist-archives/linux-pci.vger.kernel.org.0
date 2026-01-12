Return-Path: <linux-pci+bounces-44519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E997D140BD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A917330BE122
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27D368292;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMe+8sdX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87094365A1E;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235313; cv=none; b=aUnBVEFlSuhB2xPZV378DUZh+XJNWCrtH65ixEgYqVhPOo94g5EfPnxLkEAQpuQfecm5EYUnhQXGv5eJWN953pTjdZKnLG8B4V7aFzoSnCPd+XDVK9RoFLCE9oa3uPiW44Z1v/gwoREIaFoz9eL96mvr6yY7uA1KdnFQrlyDD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235313; c=relaxed/simple;
	bh=/73Is6LSiZFdQQ1Wgzmm55BHcfPO7Tzrd+XL5DP+qdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVwBndBcfk5LdJASpCRSpp/FH39WbZQ2YyenplUiQtzkKOgvKraeOuU9SApRODcUpo2nEYY6KAaAYjY7dLGMY4bg1p+XUD64c6TgHt3ucBzyXz9WZr5/nt473ErZ2GOKmaFUjbM2bEESRUqF5onOMJCcwjBgBazvXv0O/KfRN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMe+8sdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DA57C2BCB8;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235313;
	bh=/73Is6LSiZFdQQ1Wgzmm55BHcfPO7Tzrd+XL5DP+qdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oMe+8sdXJ4ErkQTsKSkCatE8iBDpSCkVKY+QhsKXX1AH3wcSbBNVotQ5WRgMcbz4u
	 xNAgCvzAwPwcBftpRn91YE3gIUVJiiVzpV+CfH67yKUSD9eXL5rFcmHHnNSookf8B0
	 AJSydeRqREZbpVeWrvvxovPgJQdxdayQ61pblCeRVDV0Q4tOovPpe04LGHWIAP1d3S
	 IhZHCyvxeY7z2Ymr+WHJo1vcjZlX56LwSrD6X/ap2U+uXvI6Oai9LMqqgiJtDTPj4r
	 nUWock9soL8mGz6VQyGam3IcxnPCZaPEPQe7oUTYm5eV0ZwYoyE9V0OyD+Ul6RipAC
	 d9/3iz8uGKKVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F31FD25041;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 12 Jan 2026 21:56:03 +0530
Subject: [PATCH v4 4/9] dt-bindings: serial: Document the graph port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pci-m2-e-v4-4-eff84d2c6d26@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=924;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=T/idG4KQSOfNt30dCJ08aa+KY4iI2ktYxKaU/4zNwXM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpZSEtv8Q38gSKx/zNAHHW7JSU4HH2xJDb10pel
 u2A0qNlaNCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWUhLQAKCRBVnxHm/pHO
 9bT/B/9fDJ+ncITWLZ7gbtwtnZXl1zMoVoh8Hz7vv0ap4NmdB+Y62hMvzahw9/Cp/gArGNqsVUm
 aB8HbCqZ0SpN5GwHK1wPtrxX0UultBtJVOZ4zn4aumBU/pPw7y23t+hfdeQWXLHCYLF/tA1XvKi
 ynC2ZQtlQvQO1ke1AhFKx3SLstFbm3Ny881k4UW40h7VOpxWJ9gFL8J9cH/xNHKy30kx4ptj7Yc
 oBPprPfyQIckHJJumSUYnOWjO3h2iqHA8JRhJQNOgOQ2J5oWZxm2v0NmBNzv9V6GWBVM4i6YEPs
 FyvdMhstqMEyGkn3jy7QI3tT2Q/ucwPhdvQJ1Dkm/fDhxAiK
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



