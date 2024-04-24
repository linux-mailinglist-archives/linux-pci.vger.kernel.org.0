Return-Path: <linux-pci+bounces-6634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD168B0DC5
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65606B29188
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FB15F400;
	Wed, 24 Apr 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxXeL0MY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62215EFC7;
	Wed, 24 Apr 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971807; cv=none; b=kVMIPzffGNjq/CRy4IJH0E7uwikgL/+RRz++585y/0kwXWZbVy5OV8zN3qdVFJCLwzWrtjihrKvQds6RZm7mjt+z1RBKl2mYTf20WIFJil5VXd+nXH6GWeoHFFXOKEIVKBp5f1AbcLosYKgZeK6Eil9O+CKP+820zH8Yv4GTDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971807; c=relaxed/simple;
	bh=RS5e+C8n99mUSp3drovm0VWPXXUTCxKx8PPtgdI2hJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWRUElWtc5v9Np0uxO5S5ud36dcNVi/lh2Z9P/U7YOJWfwzkp9b6KuQJXRZq7kKFYfqPfwyvoS7oVQV1uCb0OczU1YBWcqAhLXokbS1iVxqeHZwlpHmVW44W7LRa8pJVa3ZH6efn0A838Pa/+a/0TyFiO4elNuoAbZHEiANerAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxXeL0MY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE17C32783;
	Wed, 24 Apr 2024 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971807;
	bh=RS5e+C8n99mUSp3drovm0VWPXXUTCxKx8PPtgdI2hJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GxXeL0MYUsc+BA+H9o4ID0yqOlTwHXserXcofLg02Zpe2DY0/cwiBhgQWLcnnjD63
	 QdYGqk4jUbezqGkpdXFRM20bqiLo2QWSi5BKDaNkkoGlfGPyjaFCG9Q8V9ZnOITjv8
	 VVQ0+eqaIQp/o9u2PSzJrVNv8W01FHvxEuRtRxIFgDl0Z5Cq7PEEIjcOC0/KeAK0fz
	 ExfKIbhA0fqrnO/3uc/V7xARu83dpZu1efSgfEaSpy8b0Ks0BZviy7F8/p7y1rRvm1
	 MaRpPT/RZOWjAc6aos5tNdwRMdZTIJh1ki5QuDjCOrdxJEOv5jWWF5pR/3Xgjrum1b
	 cYLZcxfHZcI8g==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:20 +0200
Subject: [PATCH 02/12] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific interrupt-names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-2-b1a02ddad650@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=cassel@kernel.org;
 h=from:subject:message-id; bh=RS5e+C8n99mUSp3drovm0VWPXXUTCxKx8PPtgdI2hJI=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYJ857GzxhdJpmeJvTWOqijc7PRXKSJb5MLcMt3j/
 sxzHn/sKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwES0xBj+p0mVrTDr2GAwpaLs
 0twac/UDiWIbMiJExJYdNewV1Ob5xciweEalc3PFl/LuDaw+t302y84XOLPcvERRxOboFK4vH+7
 xAgA=
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


