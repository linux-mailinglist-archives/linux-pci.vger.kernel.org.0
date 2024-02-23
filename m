Return-Path: <linux-pci+bounces-3927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A9861571
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033601C23F5C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9583A13;
	Fri, 23 Feb 2024 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydyu1SR8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C376839E8;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701787; cv=none; b=Ub73KDJ21QZLFBwYOaRGjQvHk/jz+GvlqaTtGucMJH6LlHn3+lTOIFeIgUYaloDak8CcWmZerIAlxcSAUk3YVoo01S/bye9Lz7NPSLj1duEqe3EhrxH1i9mlIXCKUqabmvhKgOb2f9n8X9fW861Njf+RkH/ZMbDHq8L11iuk27g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701787; c=relaxed/simple;
	bh=nc4MqV6YaWXP4nv2pZ90dCQqT4i4GYj2D270C7X4X5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4CzU0GsxcXmxm/2NZ+4R4KHJFnSL2cwVdcYPvC/DdkjsTTCwpgovrOz6QLq8/kcxUESCtwpbQjyMw+2bwsyrCVpm3nijhg3dws6baxuHS3pU13V1lasHBQsXr52UErcYzZzWhxPHn4RdizpDlI3s/QteuoOOAVLdsGfZ0GPQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydyu1SR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908B0C433A6;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=nc4MqV6YaWXP4nv2pZ90dCQqT4i4GYj2D270C7X4X5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ydyu1SR8lpLQzpzB3X2h06K49YWtAISIGICtzLov1pVdvuuemjHzdi9XuRSexfKQX
	 pkbziFhPoPSLqSSNiwrauPsgZEdLgfCdE2e6YilkGMttkMFmVl2Q9ODhe9whw1TGoj
	 Nn9JmQP3RuhduIjAYJ5qs9F9kRZ+SCc3hdRPRHUa1Pxl5kJWSAqi7KyG9+ZMjYRpCu
	 Y+4DVIeAAdX0kIE2m9dejvSbZnzMjRd/Z4lXUF8Ce9Bd8+BLeOUyxEkhuMvDUNealQ
	 0K2Ijlnp02ifK9PXNXURp+Epo3KWY/AI4lkS1Gv5XklYEToE258SMsdtWnM20Cc1ov
	 iwRAu1VX9xIvQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOJ-000000005FZ-0BSl;
	Fri, 23 Feb 2024 16:23:11 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
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
Subject: [PATCH v2 03/12] dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
Date: Fri, 23 Feb 2024 16:21:15 +0100
Message-ID: <20240223152124.20042-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223152124.20042-1-johan+linaro@kernel.org>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'aspm-no-l0s', which can be used to indicate that ASPM L0s is not
supported, to the binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index b28517047db2..4d1060b52592 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -130,6 +130,8 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  aspm-no-l0s: true
+
 required:
   - compatible
   - reg
-- 
2.43.0


