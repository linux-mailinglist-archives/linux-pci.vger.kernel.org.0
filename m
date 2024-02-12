Return-Path: <linux-pci+bounces-3355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07690851A2B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363131C223E0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D523F8D3;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YitcKmDa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7283D560;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=p221Uh9qeoY3HWNI4R6o+q7BsOKcGpmXPu44v1rKGi0AGr4XuUluu3QmDWICpJ+277kC5FMZyuS/j+rd+e40EBPBqxIuEUcmBXQvMYlbSI5Nkl0Ds/M9CcJb+vemB8dvWISiWOpM5X0Ov9wshAmBAJzfwXc3qN5L3k6MG7QbQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=BEJ/GlZcEcIeY41YB328X8vzZf6tkBr888FPIZPHjzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMU7u8L/wSd2joYBP1TvOqXH+fmh8KIUmxhKjpvptjqR8xu2h8rVTZCNjFojnZt2ZxPNFuO4VoGaeS1N54biuYL0mwM27zcMIFm0pAU65sdiSnKvf1Z/txvLOgmmsvcleku5UanzfdB3CbN+yA6V6isjUxUe6uqspmAEbkxZcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YitcKmDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2C3C41630;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=BEJ/GlZcEcIeY41YB328X8vzZf6tkBr888FPIZPHjzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YitcKmDaWTdTmxZSSRNlNxyqvhf9hP/VT58cE8Km+Vp1YXZurJTs2p+iEhJGUa5CH
	 R237iE22Xgo+4OIFWNBI4AifareOBc9my3nmTQr7k/AKzNZFvvSyZ7sM0ZngjN69RR
	 1XTbDmYx5BNoftwz1S/2Y3OEYIwCTqN5SSUnWx2hizGlpmDyVBAKrwokQpEztin70P
	 4H1HMqBkXgM38f8szZaDPLhD0PfL1lFBfw3bHphT220ix3Sx2LOeDJsVnLaTbebZ9g
	 dkai6btbr9tz1cByfR07ib6i0sy9U40sh7pGbHhayES3qrxjJBc5zSTsgpUkfgaUSi
	 tqQCJBnKWjCXg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ3-000000007NH-0J18;
	Mon, 12 Feb 2024 17:53:53 +0100
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
Subject: [PATCH 10/10] arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for Wi-Fi
Date: Mon, 12 Feb 2024 17:50:43 +0100
Message-ID: <20240212165043.26961-11-johan+linaro@kernel.org>
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

Enabling ASPM L0s on the Lenovo Thinkpad X13s results in Correctable
Errors (BadTLP, Timeout) when accessing the Wi-Fi controller so disable
it for now.

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index ff4b896b1bbf..aed857feface 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -864,6 +864,7 @@ &pcie3a_phy {
 
 &pcie4 {
 	max-link-speed = <2>;
+	aspm-no-l0s;
 
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
-- 
2.43.0


