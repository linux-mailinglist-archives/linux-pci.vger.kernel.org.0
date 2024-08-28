Return-Path: <linux-pci+bounces-12365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B804C962CE4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4159BB26446
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3F1A7068;
	Wed, 28 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNZpItaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356701A4F25;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859985; cv=none; b=phZrqBbQog3CPogQmpcX5lP+mjLH1kL1zeUaWRxNdjyqQloTLdoZeYRQrnMooP/aicSuHJmoWa9G2BZo8uVvHI7Cn9Xv1ddd3yRNOMO73G3ptgOOKu7/72WlFyWmrOvH9+ClwDGHi9rnlgmlmLKxgs8ovS3HkBePSYtTwvoe6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859985; c=relaxed/simple;
	bh=9SpPkeVArnB3rJ4nPZ0WPdvcC8ctAG/YXTHNpaqeYTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8ogyt3uuArazzn6n0c4gjRnrAVzX/ejLHBOXOclUXh+3Zl+gMe76k3HppeIY22F6oJyucP+iK+KcuEZMDtO23+6S42TvaNn9/EdcV9LozLkKAfZuR51/wV+x7MbrbfsE6H58UtMu7ANAEKHSAlu0uDGv7mlBqhselkQthSkxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNZpItaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9ADDC4CEF2;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=9SpPkeVArnB3rJ4nPZ0WPdvcC8ctAG/YXTHNpaqeYTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iNZpItaSw5EVogZD9jBh5ya2aq1nbydFMEuY2E3LKtyjjAyFQBCXa8H/w32bwq8w6
	 vtXF3KC8IgfK3hVA7kBnzKIPaH2H+9Bwu5WR2C/UmN5SvVZnt4XHOp3Jh2l9NheqEt
	 F6Zw67JqWQdkFS3XOZLnrg0X2OFWABM4/psN2W1VLkR1WfofvNCUUNbpZZcBoyKkpZ
	 E8U65LkyCTZeszLb0miy/pspPc0XFeyEYw7ztDmCvoexKGn09DMZgvK48ZipnpuZ3W
	 Rf5S7DeZHQmDvxtBFtRf6MIBMWuhTDx5mWfNYCGeJcZOE3m/UzzEeod2TmzHJMgYM5
	 KPsAjSNcCYX9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C088CC63685;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:19 +0530
Subject: [PATCH v4 09/12] arm64: dts: qcom: sa8775p: Add 'linux,pci-domain'
 to PCIe EP controller nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-9-263a385fbbcb@linaro.org>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=YKSy5vPklQvLJA99UbdPy4mFyoiPQChYvArhByAGkpA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZMziJrsXic02yVCJv/8NFMTgDi+58XUKWXX
 KH3CGTMQB6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GTAAKCRBVnxHm/pHO
 9VDsB/4sVDxMnvqbnlA73pjYq88mhGwkv1J3VCb9j/EKZHqMl10jBYx5MOYbJSW3y25GYwIxIMU
 qmjz9rqsQWRqRAkhyAkAqNhEEU8xyOdzIGO3gXHngFEVPCi2IgGpZUMDP3bMzDlUOML97HRuQHg
 kv5M/olxW+ZTsVkVca08HU8zmt7ggk7WUYgpnYRMCpfj0EVg0fspx9BD1yys1RfB+n+JqVqfuM8
 M5vzw0E7NHX82HgvT2k4RSBMTfrW4s6hJ2zFWbGm1diGiNdwqYvCUAqoI4LAw+52+zWlxKcSfL+
 Ko1Kqu+MadWR11YDjc04z8HXhrzlUEKHgsfwmeVFpEiOjZFz
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
instance of the PCI endpoint controllers in SA8775P SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 23f1b2e5e624..198b39abde97 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -4618,6 +4618,7 @@ pcie0_ep: pcie-ep@1c00000 {
 		phy-names = "pciephy";
 		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
 		num-lanes = <2>;
+		linux,pci-domain = <0>;
 
 		status = "disabled";
 	};
@@ -4775,6 +4776,7 @@ pcie1_ep: pcie-ep@1c10000 {
 		phy-names = "pciephy";
 		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
 		num-lanes = <4>;
+		linux,pci-domain = <1>;
 
 		status = "disabled";
 	};

-- 
2.25.1



