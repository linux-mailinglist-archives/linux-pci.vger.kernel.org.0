Return-Path: <linux-pci+bounces-10285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C65CE931996
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797091F235EC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9140D132464;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou0Pq0AR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D37172F;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=WPePuyjv5sP0GNlTq8Ti0U8TjwZd4RAaaQVdKQI0tnmHovp/5xaPekZ5uDhMVQxfMw/L19NeLILGs+EJJGkXdYNf1wagDi4Ax3znX5qN9sjTYzyHU8H6UKh7sdn3LDtEy9SKE9bxD7yCXL3Kr39Pi4qXJSMTfS2Ba7geWZtQG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=VDKSHzhinHhMd2hc1HddY9yOlQzYGMP04iRbR68jXgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcJaQZgBwt1ifxG4rX8rOSiVP5eSB/lIKbo7Q/sPWkuRgEYHf9Wz/RaVb15Hq45YMvp5vjpo1HAmDJu6wW/gfpUwKbH7PBYCybVk7Hk8Do9dEPOElJgdJNQL7/ftSXdV5h4Wl6nG8wD5vhL1WKCAIIIJdlmoYf9zhLtNC6yCNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou0Pq0AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A239AC4AF1C;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=VDKSHzhinHhMd2hc1HddY9yOlQzYGMP04iRbR68jXgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ou0Pq0ARmDSwfRaqSdp+ax+sOe9Hj3aBWPPm4jJV2JgYSe17rsM1wu6xafLa/eNMT
	 m4qQTHgbN//nMRq7kJvc0cwAO2S32lGNRehX+rzl8E7eoEXAcQR8EGEFYsWKVdRuZr
	 tzxREtUFZPevDr16kmaoL3WExOyKahLKKRcPdWxPCd9Fsz3bqdy9VhtldMf3JbcG1j
	 HCY6Ua/kx+UjYOOMb1pStOxR3uUj5+XA2gb/iZsux4EgEWTxHWmFFGkePYuvbqXHSg
	 xYfrOECZKXOaGb+JfxaTTnFGZTg2rT/GwVyYl2duzSb9Sb+ZIO9jtZWGHhuhwwLK9y
	 U+VK4Fv7iJ6kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97756C3DA59;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:47 +0530
Subject: [PATCH 05/14] dt-bindings: PCI: qcom-ep: Document
 "linux,pci-domain" property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-5-5f3765cc873a@linaro.org>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
In-Reply-To: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=4/Y3NDpzD8Z8CE/W/YJnbzDjm+Dvqo0pEX0LWeYt20k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV14OxNu2Wouvfh0sC2iqACXk4KaF46EPflGP
 K5SvUq1GKOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdeAAKCRBVnxHm/pHO
 9ZRqB/9aiqXGr2qOBpgTi78f/kJz/f1LUHV2LmgvzXET9Xqx2UNmEVcAilBQQBSZK52d6X4PBxv
 aWJ1oX8Zue/z2xEAHNwZIjg/wR/hFMku4gJNvheAE3UrigmeKAgd2aiIHEI7FVZ8SbJwCe/5QHT
 ADzYloawz3PUkbN6zWNY0S1mag5KAW1nWGsjbYfKCx5sNqfTMMFOT1ZdJBpdDXgmLnNuAbEGCnl
 l0yTmZ0jDL1tYtYO+5AgKlVF7I/3q5GlfL6Ps3EqFVbCT/epaLH0FK2OO1VseRjmrpocaZf89YA
 YWyMEcgnFosgHbVde+NZnLhEzA36wQHjoVhcHEgvw1CHn9Ci
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'linux,pci-domain' property provides the PCI domain number for the PCI
endpoint controllers in a SoC. If this property is not present, then an
unstable (across boots) unique number will be assigned.

Use this property to specify the domain number based on the actual hardware
instance of the PCI endpoint controllers in a SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 46802f7d9482..1226ee5d08d1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -280,4 +280,5 @@ examples:
         phy-names = "pciephy";
         max-link-speed = <3>;
         num-lanes = <2>;
+        linux,pci-domain = <0>;
     };

-- 
2.25.1



