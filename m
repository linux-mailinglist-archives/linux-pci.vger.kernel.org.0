Return-Path: <linux-pci+bounces-3931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C6861577
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB311C23ECF
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7380E8405D;
	Fri, 23 Feb 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl5esR1J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FA82866;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701787; cv=none; b=EAUklM5PjLcor+YQbrByo9lzk3C7/Qy9xr3TNpLzUENTiBAQgfAPaXJXGZQ0lihny3ui8bt453rDPdh6PdHzEUZeT9NQIQXH3ZRaSgb3aUtJ1jzXF5vRbLYkN+oGM6YGLLijg/s3RUgMpSuhOXAB9rDRUICK1mbc5hNbG7R1L/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701787; c=relaxed/simple;
	bh=jSrJkfIN1qAWzxJsRTl7DfvhSeqHU9HH07knGCfmKHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCX1pagZ6LRVUooGatlg23JfgiyukTz2TpBS7PF1aVAR41Fdsf4TAnB49Nth/x5ha84Q0NHdPYb2/0wWhRJpj/dcPVmPVkXpI126TwysJTnjbDmeyDFtfRgA/LalnOz0kuJlNdzQWqrrY1riJGilstzUdSX/yFtS31kxycV+3BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl5esR1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFA2C433C7;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=jSrJkfIN1qAWzxJsRTl7DfvhSeqHU9HH07knGCfmKHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fl5esR1JlBLC32MubsqkqReluCkKzF9p1XmsrALW6QYtrbSfz5f9Hj1QH9VeFNG1F
	 twC8+mwwaJvx7f/2+7aP0HKsPgQcxOxFLYeDOscVDvWY5PvhrcI+LQd+iPY0xph2xm
	 mNCB638j/w9XfNGwFSWQH+CWcU4hqPWXuYIORv7upi29Oux8islrzdgPr8ABy6lunC
	 qbb7+p8S6EGanN14Y4dBrz/V0OfkQr0b4eo1uKV58ngOXjmkw2+SXSyZ1yxCL6DL5V
	 ZzItuyb6YQMpLJpvFZRbde4q/Lydkxptilv7M7xmpR+S7jbmEb0Uhu1AlRln0mnGWs
	 f0pIsILf0MEfQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOI-000000005FV-3iz9;
	Fri, 23 Feb 2024 16:23:10 +0100
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
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/12] dt-bindings: PCI: qcom: Allow 'required-opps'
Date: Fri, 23 Feb 2024 16:21:13 +0100
Message-ID: <20240223152124.20042-2-johan+linaro@kernel.org>
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

Some Qualcomm SoCs require a minimum performance level for the power
domain so add 'required-opps' to the binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


