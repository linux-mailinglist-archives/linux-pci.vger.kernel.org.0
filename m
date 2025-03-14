Return-Path: <linux-pci+bounces-23779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4367A61B60
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 21:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFEE19C6197
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 20:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984502066C0;
	Fri, 14 Mar 2025 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVrVvpAr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A72063FA;
	Fri, 14 Mar 2025 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982491; cv=none; b=MkEER68X6BMZ51927H79ndHINxnNzSpqAnTl4hJXGobtkCjJOs5ASX/bVRCd80es8xQ/lAqI513QkTW5iQF8DvU4O2rIvFJqBCwCvidm2gHfhqppIxcsxqpQtjHkvJaPpC66xM3pZ/HGHcBdiBU+EnwCDl4GN05k+h+27rKbNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982491; c=relaxed/simple;
	bh=yBcbi92N8Un3wkagtNiodogc3Ps9K9BkSvgzoW2LSws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKeAHVr/0WpPHMAN1lWqXkqnarYPUG250AMrNq8o2jl5BYEzbI8IhABpvIxyL5d2hYgiwmcDLPv2eMgov/qDm99h3sAT5GQs7N2sb3VqJb9NmRcTzTMGE/+t+wvBAMzKGrhB8TSTTfYwkgCaCJWqzxzaqmXjTYGVHWJB3g6Q2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVrVvpAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12481C4CEEE;
	Fri, 14 Mar 2025 20:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741982491;
	bh=yBcbi92N8Un3wkagtNiodogc3Ps9K9BkSvgzoW2LSws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVrVvpAr6rgojgh8yqmS8SF1/aCob7wg2/jdTL7LP2aApGl+g/ktZktN6ApD324aW
	 ZlRsOzu+/JuOJY1wiIJa/D3i5f/SP2mPnkFCQQpFMeRWyksQ/n4TQHDfP+hcIJMTS9
	 o8CDDDwW3NN8dGhUsb970oPUJ2R/+/IjbHozUDRfrMwH87ODEvuGM/yCfMvr2+9SU+
	 heJUf7iQrQm5jsLhOJfxqS/C05kZdjgez6Vpnf5YJKsjVFKE8rpvWLha+65czRJx1r
	 uMhJ5CZTV0aFqghGVp+RzF1L3G6ZUh1T0tXzBFIBsK19FpvNrqMapcA7yL4rW/k8DH
	 1qm6IYbm8Ffgg==
From: Bjorn Andersson <andersson@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/8] PCI: qcom-ep: add support for using the EP on SAR2130P and SM8450
Date: Fri, 14 Mar 2025 15:00:47 -0500
Message-ID: <174198247877.1604753.6637295484438228617.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 21 Feb 2025 17:51:58 +0200, Dmitry Baryshkov wrote:
> Update the incomplete SM8450 support and bring in SAR2130P support for
> the PCIe1 controller to be used in EP mode.
> 
> 

Applied, thanks!

[7/8] arm64: dts: qcom: sar2130p: add PCIe EP device nodes
      commit: 84247db00a5c4f9b6fbf23cc46979508ddd8d855
[8/8] arm64: dts: qcom: sm8450: add PCIe EP device nodes
      commit: bffe01a9b4bbccd07a1fe2bd78c3795004b56645

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

