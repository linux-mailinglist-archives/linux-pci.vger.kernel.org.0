Return-Path: <linux-pci+bounces-4504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C678717F6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6909D2824BC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F981AB5;
	Tue,  5 Mar 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi1I/LRv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726DC80BFF;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=Z4QBPp8nMsB/tEEjUgOyGZsnTfpHYYoS5ixqzUYefOPUZT7c3CNUOYvtGY0WjJEDkMq81Gz6KBU02KgqU4tFId+HuUe6iUPXaTqBR6CgNDbseh4fLLiAQ7AN67APHOl3EaZ1pRQI0LtMFqh4J7jMVvLd2wsg6ad4+NUZAJTKkAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=d/l7BsFbkWwQfmOrlB4DTD4deaGWaxJirdYb7/cpxMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTkjl5bcMK/KKw5lAhYLlH5QsudBxlD+31zDZnS8vXznGXTLRhg8BRvsrSf0EAzIJaP/uztCLwUoZzqtPyyRhyWxgo0DJ8/2FQ04n8/+BGutmV0nfgEKPtdxnsfVzaCBmPZyVcIaRe0/nSjo13HEqNSaJbh1GkCIOdmK7gj1IVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi1I/LRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B84C433F1;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=d/l7BsFbkWwQfmOrlB4DTD4deaGWaxJirdYb7/cpxMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yi1I/LRvp5bFmf7e1UTMhwmzJMXxd3IM1SlSBwW+3aLqfnsuiaFE6CT/9gLZ4Pvtp
	 8bKflpKjd6CTD561KegURdSArnxIzRn/e5M21+IiDe8UzlZRVwgotoE/hj07ezAGTM
	 dopTgMYk/f3niQhLK1VTIGXsXUXuDAT+ziBmVVFUhPvMipOIREaYpmfKL9iM7HRoc7
	 zSZ9qnj/J5fECL26uxi15P+QPxLcczQ/BifVeyq7/schkL5hh6W4yy9OSGDjrwd2Lb
	 Br632HhvSvvQ0/CmDacDAXkJY1OIm30MRQ2dWirF8zGX7OmHDhIaAVSfuDqq58ILL8
	 falYxqgJnD28Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwq-00000000383-1kPa;
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
Subject: [PATCH v3 08/10] arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for Wi-Fi
Date: Tue,  5 Mar 2024 09:11:03 +0100
Message-ID: <20240305081105.11912-9-johan+linaro@kernel.org>
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

Enabling ASPM L0s on the Lenovo Thinkpad X13s results in Correctable
Errors (BadTLP, Timeout) when accessing the Wi-Fi controller so disable
it for now.

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Cc: stable@vger.kernel.org      # 6.7
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index eb8a16aa233e..9567b82db9a5 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -734,6 +734,7 @@ &pcie3a_phy {
 
 &pcie4 {
 	max-link-speed = <2>;
+	aspm-no-l0s;
 
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
-- 
2.43.0


