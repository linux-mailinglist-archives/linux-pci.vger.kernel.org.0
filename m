Return-Path: <linux-pci+bounces-10288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EA8931985
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368021F23416
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E691386D1;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+RknX5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8B78C6C;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=lVeO3Ybl2K2ulbMAWbQvQTYj33aqsHzmp6CrDMBi/bXSxnKu4gvscVlMAbZgMjvPrdgt9RsDXjgALMIFKpYU985TXWgTCH3WVeKYnJZJyAC5hCDk6+A/Y4pRm7dE2GgMnjkVBT7s9fZi06/eVmy+OyM0dDUvt4R5LxwcLCTHtZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=RQxgelkyLN8Ts/HTeZBS0QZuoUf1hPKhZohT5VJ5sqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHK1/z9YvaJ1qnq/vxKpaCSTBUhuVWA346REul5KdC2aaXTpAWVmHjWojW2BuZgJYJGj32HeSDRipP4NRD4PQD/BjSj4Xw58Wu0oLbWWpE56/hD02YeF1zUxqwKWixFophY+tl7FatZip1qYN5Hi4yTrE5Jk6sM9kj775OcS/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+RknX5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF8D3C4AF0D;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064830;
	bh=RQxgelkyLN8Ts/HTeZBS0QZuoUf1hPKhZohT5VJ5sqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B+RknX5MeQRmZ/kd4fnU8RSCgroHa5yOjbwuvrY2cGaBWA/OP2FNJfxMYi5ja0RBM
	 qQDS9FSLzfwMH1p9y8PwK/jE51VRxvxW22RkDRot5gxLLJq2HZewK0SGJStNJAeeyS
	 B+vZNzU2ba3Z5Sbw+cggFsGxjpjf3idAlgswRl79e5Klku87E8Ir5exBQG1m9S/jgy
	 5wY2B896UYNw7erCblX9hqzrQWPLZKBirShHc8CBZkAOQmfUS9NrMu7r369a1kvtsY
	 vpSh6ARjR6MIgKhJAjK3leDN2ofZxOzeOb5RsGdgFzZgXDhWotiKan3mERRlXvlz6J
	 /0v0etCAQTLyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A5DC3DA60;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:52 +0530
Subject: [PATCH 10/14] arm64: dts: qcom: sa8775p: Add 'linux,pci-domain' to
 PCIe EP controller nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-10-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=yEgvSXmb27DZa3gudFLW4zQMizODQlbDCoGJB1twpkY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV16mrEo9NAV0hiS5F8uIuEUCRNSQ3KaNpcjJ
 xlqNZmego+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdegAKCRBVnxHm/pHO
 9a0UB/9rL1u5DYb4E5GiDOZUSXZC+9jk0Sxesl5D3WH2U2toRZncQIw6kUqORTEnnyoTGA/gYsr
 DpZJ3HVigPzTH4uJIwNDKBX+9/9CaaPfkfXbxMBhix1cI0dbX1NJ4QXSAkQhAsbk+qt+pZNBSMa
 7oTrmIgYW0Ptw/LQ0pdXv5dYsg2JX20BMyYhl500pLJj8CPzihAb+7qgFgR5IgjuYdSW4H3OYkV
 yUt4wSE9GhhGCT3D9Clor1IvW0sPTeaVv8udq5s0QeX6zsREGU57pF1ozrWsXqVBgD9MpNsY0WZ
 OF2AcDFy4RofVwZ6G2h3zxK4W90JPVcMpqBOEC6vqbB5H2k4
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



