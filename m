Return-Path: <linux-pci+bounces-3937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA638615A1
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA201C23FA8
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96FC82D70;
	Fri, 23 Feb 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8zvAImA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E383A0F;
	Fri, 23 Feb 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701789; cv=none; b=FOa4kPp5vAFuv/P6ne9fQg4FOtO8rzx6+ZTK/ie7RFy00HdGFq4G71GXG3T4TJpD4HngbTyo0/rkJCpZa2ESqapDWNKImWLQhexFz0ETCP42boMnU4mhbmGXc0trjlrwVDA5HFTn2Wwcvg4TbzjApiLQzg8BwtGEpBLF1oshDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701789; c=relaxed/simple;
	bh=N1lJfJsT0X5pb0MCpBJjAnSC5f6053KInsrfpjOCKaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP4ozAEEf+kPksVc3r4H9SiGC/q5ydI3U9Z7nwfog8WMk6VpCuR3oZyeSfaPOFwjlbA5DG0UxwMcit5MlAyRx/1V3ABaVMU5kCbJusmUGmuG+mm00qK7KLiBH760O1fGfN+AmUQo3VOx96tRb0YFMq8QXd4Z0P8fl8ECx71Aymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8zvAImA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A130BC43601;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=N1lJfJsT0X5pb0MCpBJjAnSC5f6053KInsrfpjOCKaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8zvAImAr1MqUBYI5vxImRdSOuHk2sxTSfrG62ZHC16ADhX8y+4DNiagcklJbqwre
	 O2IoWidiH5rqUjXaoTZ+BbSRhl03S8xJLDBu0fvUTAGmsNGZC7UU/5Zh9UmpBezh+c
	 ZeKH5L8y3HsWb0sYv3MghGApcXdMRxhmpvUtepst2VTr9WddM9BFj4DUSUkFXIlpfm
	 fjQMlxLaZeidHtvXCaLrjyF3zf3lIX23Q12qMAKPa0KAs7JxpdVuoqkmGE8Zm9xUCW
	 CACDdJhazbYCG6sCFbI4v7VIYf5c+bSEWs1TYldrtmKJjTXeshPAaxUSjA2UgkUojw
	 ypuqfG1Vc7uZg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOJ-000000005Fj-1s8o;
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
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 08/12] arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for NVMe
Date: Fri, 23 Feb 2024 16:21:20 +0100
Message-ID: <20240223152124.20042-9-johan+linaro@kernel.org>
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

Enabling ASPM L0s on the CRD results in a large amount of Correctable
Errors (Timeout) when accessing the NVMe controller so disable it for
now.

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Cc: stable@vger.kernel.org      # 6.7
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 41215567b3ae..7e94a68d5d9f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -525,6 +525,8 @@ keyboard@68 {
 };
 
 &pcie2a {
+	aspm-no-l0s;
+
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
 
-- 
2.43.0


