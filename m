Return-Path: <linux-pci+bounces-3357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F68E851A34
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8244A1C224C7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3E3F8EA;
	Mon, 12 Feb 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtHnJJuT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962643D994;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=s0QQyxJZBMdrKe/6oHrcAE44P1PtvQGvrjI9JXLRohjJ8luZcVQHWPLyAd4dz2OH6XEdIvgg62NRSk3/tH6qGqlUzoX1Gp3Dc8Ckr9Ocm0paxnb6A4GpE4KupFV1xC7/2pJ5nl+2xl9R2EFP3kydGuVkydOAH9B7M2G6T3wjs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=4qs5BSHr83bqWVSdSZwruslTHmTwWZz3mLyV0R3YqS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci9Zw5mN4h6B7Cj7CfxJbXqFgQhsnVspYY/dTyF3x4Ojf745PIVv73pa8/R7mPeun48QredL1Ea3xDxA5mQ6lKZ4IzS3taRUb7SM2DjDfvtC/JuJQoHtwf6I/60P1PnD/QqZYLtRv6Fa6szBAjIbYUBfXfarMOuggY94okhEnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtHnJJuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E4AC43330;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=4qs5BSHr83bqWVSdSZwruslTHmTwWZz3mLyV0R3YqS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtHnJJuTAEBUQdcH64Rcdc2knJufwOvhkGG4rT7AC3Ei9LhDfY7uf35++xo5GuKrR
	 aPPdEhziCF/OeeVakVxvmCY2xgg3PKckELu+98kDGlpVbCV2WyzeDpvDBnZ5Gf65Wo
	 AAhqQU/ABmeN2Lk95pRS2JvVks7kvEmIQW9I8XFOAOjeMOTJkGGIFWoF3Mijxcmiei
	 eWMyjHpQiEJOvdf2hzw2gEhbvswEGGYBKRGNpvXaQmJJV7eFtq8WiL3EGHit1hGwt3
	 Wzsh2jDC01dd6u0TpvF/PowRDBD9t0y4J/Fku8nG8kCTmeYyyuRXu6MFdEPmeCEdkQ
	 44f29ol0P1W7Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007Mz-1MLQ;
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
Subject: [PATCH 01/10] dt-bindings: PCI: qcom: Allow 'required-opps'
Date: Mon, 12 Feb 2024 17:50:34 +0100
Message-ID: <20240212165043.26961-2-johan+linaro@kernel.org>
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

Some Qualcomm SoCs require a minimum performance level for the power
domain so add 'required-opps' to the binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a93ab3b54066..5eda4e72f681 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -123,6 +123,9 @@ properties:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
 
+  required-opps:
+    maxItems: 1
+
   wake-gpios:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
-- 
2.43.0


