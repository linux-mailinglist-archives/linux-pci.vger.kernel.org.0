Return-Path: <linux-pci+bounces-29351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC09AD4126
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 19:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC88F17A306
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4E248F50;
	Tue, 10 Jun 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRnKIiLK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6393F24A054;
	Tue, 10 Jun 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577447; cv=none; b=SjXICs5mWuqA0zdAMG+C8e4bdOcGY9tbuda2pQfsOVp/JJwesJcpxNg8bg6nJJmPQaAvuVB+boAPov+/yCMxy2LufMx4KhFlBJEHrdWKX3Pv62AbeEAlcZQU9KQibLUt/4OrAT1ABPjkRcxG9LH/0qtBc2Z2RjTSog+Ld6ZHaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577447; c=relaxed/simple;
	bh=BvDgxhAaCeCWsOTtqUYCrQtjEum+gyaP+KRfTEo0gL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLK69YXqqXZZz801ek47h55K3x9daUK+ai3dGE1SxfrFe5YeUDxr7GxJbesgFAiuaUjopwZ6xOtLzvSB58f49vuIn0HUjW25BnWHZJkqh34qCkxe+1S+WAqsMHI9n6zw/OHHzQD4NeI4KGQ9MnxWYvWssuCIsUHyhrcN3X+pldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRnKIiLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108B5C4CEED;
	Tue, 10 Jun 2025 17:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749577446;
	bh=BvDgxhAaCeCWsOTtqUYCrQtjEum+gyaP+KRfTEo0gL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRnKIiLKuEi/tmAfsXOxgk4p2qF5DC5AJUp6LNSU4ijrDCAv9c00Z4rfOsN8NbO6o
	 1ZY3kQ9oHRil/lEA+hzIdeQ4EfBAF3EwVkpRchxUX5g8Vfw/kdKGfUlQnKs85qCg+N
	 YLfgTTqU5z5iBzN6Redyemq67sXirJFB5Bf3BMzl0tkTnZmqYaym2G98eGJ8U278L8
	 3JDLWX3B6JoDzLL8Ozc3YGxQSmB+UoqmALFrGFhDcpApLdSEIxB4Y/RAqJ7Xj1BxK3
	 e2S5vETRO/ld4pG09iXZd9erJiEVavDGG+P61QIraPEC0OV5H6XkEH7hreIaRoI+/1
	 efKdTUL9+/6Tg==
From: Bjorn Andersson <andersson@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 00/23] arm64: dts: qcom: Add 'global' IRQ to supported SoCs
Date: Tue, 10 Jun 2025 12:43:59 -0500
Message-ID: <174957743676.435769.4199701352148338559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 27 Feb 2025 19:10:42 +0530, Manivannan Sadhasivam wrote:
> This series adds the Qualcomm specific 'global' IRQ to the supported SoCs.
> This IRQ is used to receive the PCIe controller and link specific events
> such as Link Up/Down, MSI, PTM etc... in the driver. Support for this IRQ
> was already added to the pcie-qcom driver. So enabling this IRQ would allow
> the driver to enumerate the endpoint device and also retrain the link when
> the device is removed [1] without user intervention.
> 
> [...]

Applied, thanks!

[02/23] arm64: dts: qcom: sm8150: Add 'global' PCIe interrupt
        commit: b151de3b3543b2f6cef9cfd5e54775a846c6b48b
[04/23] arm64: dts: qcom: sm8250: Add 'global' PCIe interrupt
        commit: 0ea9df0b968832674c3728459ae4f5699ef3cea5
[06/23] arm64: dts: qcom: sm8350: Add 'global' PCIe interrupt
        commit: 28b49abaaa003a5dee499cb60cc2021e967ca0fd
[08/23] arm64: dts: qcom: sa8775p: Add 'global' PCIe interrupt
        commit: b83843df74f22f5b3c1ea315bf58bccca768c0ce
[10/23] arm64: dts: qcom: sc7280: Add 'global' PCIe interrupt
        commit: 423704cc7fdfcc4b013c9f46596cf54b9b7acff2
[12/23] arm64: dts: qcom: sdm845: Add missing MSI and 'global' IRQs
        commit: 469cda30e4c29a1dc2fd855200baa0f1bec31eb9
[13/23] arm64: dts: qcom: msm8996: Add missing MSI SPI interrupts
        commit: 7256eee44e63adc8875e12dea64d0f7ca595d257
[15/23] arm64: dts: qcom: msm8998: Add missing MSI and 'global' IRQs
        commit: c2c4c10a00b7eafde1198dcdba9a97aa06af5177
[17/23] arm64: dts: qcom: ipq8074: Add missing MSI and 'global' IRQs
        commit: b6b20109ccb5dba2331b12ca7748dda4041191e7
[19/23] arm64: dts: qcom: ipq6018: Add missing MSI and 'global' IRQs
        commit: b1830bdc0fe67754e0f9103b8dfc16d847632498
[21/23] arm64: dts: qcom: sc8180x: Add 'global' PCIe interrupt
        commit: 9c786d24f1da819186b420dcd8a7ca096832ea9c
[22/23] arm64: dts: qcom: sar2130p: Add 'global' PCIe interrupt
        commit: 34d10f33472347dec0c4a078e9cd77aa92be2776
[23/23] arm64: dts: qcom: x1e80100: Add missing 'global' PCIe interrupt
        commit: 4ba960e75bab4a4e5f328d22a7a9b253abd3c214

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

