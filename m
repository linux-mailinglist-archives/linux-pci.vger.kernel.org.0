Return-Path: <linux-pci+bounces-2626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0480783F2EA
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 03:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72B3B22C4E
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F7DDAE;
	Sun, 28 Jan 2024 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdL81Wqe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087EDDA0;
	Sun, 28 Jan 2024 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408255; cv=none; b=EUROpJHGCmBPUKlFhL6N0vBrSvEUMuBm0MQz5SrV0iKiqSifevhHtBORF8BpOpE9nWS3nYPwDnjtWQoz17QKrY2NXMUfPsKnGdjN9m51RTyx4j8FsH0FUFyYPEHZE4ZFNhMn9pUWPaRw80AYvwBfVaXNTaNjZzpEET07K+h+Bog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408255; c=relaxed/simple;
	bh=w9emQtFveAATvbrNnOXhicJgUsJeURD6CHGO51vDXTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkCXRGifUjL1hWjZGlGJaokUPg6T6ZmeDAIH11liEL5HIxSu7BzK3u4GQ6b/Edfdi6FR4UoKk5AyvIETocxe90A6ZZVUaoBHRQNjlOG9X9pr0ODTGqzc9XKvbvTuVijhFVL/f1bzOXikpk519qTnuVxGjjRyeBmjVOY5D+R4GcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdL81Wqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39CAC43141;
	Sun, 28 Jan 2024 02:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706408255;
	bh=w9emQtFveAATvbrNnOXhicJgUsJeURD6CHGO51vDXTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdL81WqercFmt94THu7fSg2YU7i7g7VKAtW6D6GhyFNcuHZqYFi/1wIT2LYQrtRuj
	 9kWA2NyYEwGAcbO3LFjzufktLlWLikxc079WsUnqlWn61VggPzVqdQ29l7cW5fOM80
	 UaAiT3hFAtASwWuzvaCD8svu6c5mkjbsM3IsKpMADMiOb1OZDY+U4fC9ZSCWEq6oG5
	 jw4Xj8rjL9ahsh2LHRQn4+MaAkY/MAuYnpDrIT9OsY0v9rLsY5s+fLgIpCQ2c7BNl6
	 o52P71s8suJBmL4ujHmDBfRI3ZZGM+9Tu2EbCmFB2vIne+1CZhDen9dTsaaMxYuWGK
	 h8w7smerIrj5A==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: (subset) [PATCH v3 1/4] dt-bindings: PCI: qcom: adjust iommu-map for different SoC
Date: Sat, 27 Jan 2024 20:17:21 -0600
Message-ID: <170640822842.30820.14658971326152390562.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 08 Dec 2023 11:51:52 +0100, Krzysztof Kozlowski wrote:
> The PCIe controller on SDX55 has five entries in its iommu-map, MSM8998
> has one and SDM845 has sixteen, so allow wider number of items to fix
> dtbs_check warnings like:
> 
>   qcom-sdx55-mtp.dtb: pcie@1c00000: iommu-map: [[0, 21, 512, 1], [256, 21, 513, 1],
>     [512, 21, 514, 1], [768, 21, 515, 1], [1024, 21, 516, 1]] is too long
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: sm8150: add necessary ref clock to PCIe
      commit: 6de995bc46344d5a6f0c80fee526bfb5d11c3d88

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

