Return-Path: <linux-pci+bounces-42054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5BC858BF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84DC04ED6FD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EC0328B4E;
	Tue, 25 Nov 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux4NijW3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81C97B3E1;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081912; cv=none; b=UXkOda5JSex+74cZFC4hYIdFZXpvOiFK4Wn9/6B+z/SIY4Ob2fj108AtHoFOjhHnZwrO0ZIW/qHCOyeRVEHlkCe7i75BDgVky6nruUJWUj2VkPbNMaeoVtPxAnpLMpNRycVN9g/SJWZiuKMI7SmL4DJaoC6qJAAHdHIHfmqRxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081912; c=relaxed/simple;
	bh=/73Is6LSiZFdQQ1Wgzmm55BHcfPO7Tzrd+XL5DP+qdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kfol+tpCjlvwy/MhzVVXkDB/DEqmudLs4GhA8n/FglxQDXGypwoL+3NvV81rOxXlm5m6lqmrdsvgsTvOthfq1E7scGyy90QsMyL/nHVf9YjfrMs3aF3Nv4mqh4b2hNgnJ/lL3FnO+IpHj5MUhqDYlOJ+V2hGfobkr8s7qhMEXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux4NijW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D06EC2BC86;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=/73Is6LSiZFdQQ1Wgzmm55BHcfPO7Tzrd+XL5DP+qdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ux4NijW3UFRboXv9u6LPlRCENKkwrVSZGw09iu6h3TUiFWO6PDC7Y0PEPJCeP5ycw
	 9JuEM4/ABlvwZNaRZqnf6y4bZ7u0rPuQstCkvCDeh9KNtEemWropv8QWg3jiqfcO5y
	 Zpi9TVppuVbBPxdF6WUOrnI3Em1wFzHdnAqOWWWGdG8evqEBeCiGt41slTywxAN57a
	 ijt9DKlxofrYxI8L4gfmxqY4qQ24lYBtdaQkFTElZdiBuQUpuC62SsWBVjEr1LeTW3
	 xAc88QY9beU3EcU9bOdOykVvweho+pKTdK0xS8+Lx4m455Bpx/kSQ+iXqOWwqU9ym4
	 Ai2svALBh7V4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F8D0E6F1;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:10 +0530
Subject: [PATCH v2 06/10] dt-bindings: serial: Document the graph port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-pci-m2-e-v2-6-32826de07cc5@oss.qualcomm.com>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
In-Reply-To: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=924;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=T/idG4KQSOfNt30dCJ08aa+KY4iI2ktYxKaU/4zNwXM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDyNiXGRYrPVp6/mZbLWkAyQuBwsrwnBd+/3
 3QTUwQiV0uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8gAKCRBVnxHm/pHO
 9VSfCACLeP9J91KGjkzLmAnSRJjUrVh9amjj5XEExSgeQkxJaA0bSIKjOT1ZqYrQI7azbYt6qqX
 zkjl/a3qz3YSEmkLZNG9Cy5HPwe1+VliFK0laziN/ChAfWukehX8S3cbzDKDp1eizMb3Uyes5wX
 yqNID4XZc9uwH1NrkqeTq3I6OMzDnxh72XPwg7O/v4UqkFHRcSHAIg9YnVdc4EPECTkiTWY9YI2
 Gi+6cQFpcOMHviCHuD1vhVU5l26gAJBwNpsNOl4yrzQe74EIZ5lTFgzMGhG/FTuVIx9VWwVv6Wu
 jPWJrbbjVb07i9Mee4GlZ4dSOVXP986oChp2dkFg3o2z/y/j
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



