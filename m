Return-Path: <linux-pci+bounces-3360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C07851A30
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C15B20D0C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74C3F9C3;
	Mon, 12 Feb 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfDDJcXj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962923D995;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=ETnWtbnvXWydbMfBcePVQpIfXxjYE3RNj/lW7k2y5EwjfdvcLrVILiEawGMOTEhw/pvlEhYoiO5FFhR3sFK3snzqe84k8+MYNL84m5i/Bqk6m5v9i+4Cffw0aJeJeYcz2eVZgCb07e7Pcl0Eoa9Jn0c5vWoHQKNQpNFY80Aw68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=b9sQBFDZU3VO1UBig2yVSwe4gu61tiUJKbyEVJ58Ty4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iat/uY6ci7hO9LXPxhWZ4JY/sVYjnUnogYtEUWWjZ+GtfK8tcpgq1PvHaKry/vea8WKusy3W0vAAFFAjKvwPcyzX8Cst2v/SpmbgIyfxR8ncZ1JHrcHiACBCkvCDhNXxtV/kB0y0TiGppW3HzqVhlOLrfkwLffA5nCYKNLEeCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfDDJcXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72C2C43601;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=b9sQBFDZU3VO1UBig2yVSwe4gu61tiUJKbyEVJ58Ty4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kfDDJcXjc5rf9yM9juPLHJ15hJN5VnNveC0WNajBfuKrI7feA2TRUaNz5XDEwiaEi
	 tXwZ87lDx9N4tHJWeEsy6HVRs9cJRkVz51BTFPS7IFeOt+rS0LZADGwHUSMgnkqHzx
	 AIMc3MuvLGG2/fM6da9rri9R2G3y9yfoho2pxwlrwtJLJpeGs6KtaQs8P0r0KAnCVY
	 3vq/bT6r36QKxz10qDkHqcPQZEefqDbmY9nERSu0d6F+ZanBOQsBzpl8tbW4qWsVu3
	 lvlZH3dCBLwHVt5P0Bkz+p+v+1UAM1etCW9v7a/Du8hAQF7G6JAZDTLlO/Wc0WBnmE
	 cUPH5vTax9gjA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007N1-1kg7;
	Mon, 12 Feb 2024 17:53:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 02/10] dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
Date: Mon, 12 Feb 2024 17:50:35 +0100
Message-ID: <20240212165043.26961-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212165043.26961-1-johan+linaro@kernel.org>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whether the 'msi-map-mask' property is needed or not depends on how the
MSI interrupts are mapped and it should therefore not be described as
required.

Note that the current schema fails to detect omissions of the mask
property if the internal MSI controller properties are also present.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 5eda4e72f681..b28517047db2 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -146,7 +146,6 @@ anyOf:
       - "#interrupt-cells"
   - required:
       - msi-map
-      - msi-map-mask
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
-- 
2.43.0


