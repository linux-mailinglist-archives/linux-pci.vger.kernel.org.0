Return-Path: <linux-pci+bounces-4496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F448717D6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5811F22324
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50C80BE0;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/IjcnCa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04480621;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=jCzPYTkKThh51pxa6/1VM6cJlnIzhHJxxXMYNUy8VvzDlPEkUYzdwVPKC5LBxzWpWYU+WkLC6P3fzMBuih+nyvs1wn69CDUAQchfDzG8EsrSixHhMw53APD0ZhwrwzveYOA+QY+HOUkp4deebv4N/ynB1qol98pHp+AO7EuoQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=SeN5s38iyxyuP3h2YLzK9sPl4gFza+BIG/u7YnOtYgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caDbMCPdZaTaVwD3y/nnfvuSX8oTKNAt63Auc+aix2Zh5JSF/px5pAUaoRZH4WLmvqoQm6+i3dihelwjE1km1qgrQ0FuyEsno/sFrYi5ENZBcCJ3X1cdAtIMJ4RrAedALbNnm8i0wxk7JJ0D5092d529HF5MzeZWD2M/+E6aWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/IjcnCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D138C43390;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=SeN5s38iyxyuP3h2YLzK9sPl4gFza+BIG/u7YnOtYgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/IjcnCatz2PFJcczjWwH7v5EC3Z2QudrSXRO03CUSwFflCEaoWqBDhJJVf5la8iN
	 SPLdb0NIe2FoYSEBVd8+4jsJdf696L+J8jF/cAgZI6DVWnvbFBGtROL6HaxU0abZOj
	 jzqAk65U7QrPrXSYV36rmRrUy4JW3oPkkT9M0YF6xEfBHu+saLLq+OOgIAXQHu1wAl
	 kMOtbr0KPu1QAF6m823lWxcGcE6Ofk40RkqfSfpWKxG2UZaNsCWs19nAX7FDUte+WS
	 PLz1LjscB6KGmlN/AdmU3xdL1i86lg306CCqhOnl+mDK9pt1uHXWJWsU5hSDFKqzXL
	 98hJCNXEVl4eg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwq-0000000037z-159h;
	Tue, 05 Mar 2024 09:14:52 +0100
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
Subject: [PATCH v3 06/10] arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for NVMe
Date: Tue,  5 Mar 2024 09:11:01 +0100
Message-ID: <20240305081105.11912-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305081105.11912-1-johan+linaro@kernel.org>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


