Return-Path: <linux-pci+bounces-28052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 540FAABCCF3
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 04:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97F21B629A1
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E744C7C;
	Tue, 20 May 2025 02:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5P60Sof"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09D2580FF;
	Tue, 20 May 2025 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747707309; cv=none; b=K0q/nNIGtW4tRIFZJ1iDRM5uVEDZEZKcc+0e5ZrS6GHypffVekDs0DDPpbnMpLoL9k1NEDwBEWYQlaSBqYouf0fm7Y0U17iaCU9nH7tBjfoKB8cVLU4uNfvdPUsFi4Ieku3I1t7nxaLJpwpSHw634BJ+xvNvNajBSkGBwLWGguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747707309; c=relaxed/simple;
	bh=iZ2fwRrkKzLXPreiWheSfX+pZFO7+QVw8FqJucxprr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fq/WjvMjB2MfO06hfhzXdgVGWkqLpGDMQmyOV41yhEHwQ8A/rPvgWaZBVE2qFekL8UHAAbottmGGoZQ3HmkNI/p/FkFbf2WFTdiTu5ou3yTBx5FJySzOTbOwO0py/RuL4RFrjNBC0w3a7FcaMaXIhDHOauOZtlDH0HpX5iG7AGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5P60Sof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EB5C4CEE4;
	Tue, 20 May 2025 02:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747707308;
	bh=iZ2fwRrkKzLXPreiWheSfX+pZFO7+QVw8FqJucxprr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5P60Sof3VWvJ5VPmjMR0dOfvYg47miCn3UBGHF15TZ07FB982qmpz3O9yFTaQQhp
	 UKYRIYVu2gl/+FUjnxyfHPJ70kq3euqJALNxvfoOPWnx4BsNwUNy0SzS/+6FnGc0xj
	 A4fCkZ2LoLL2mKhRGCcebA+BreZs+OxA0k7NVsy384kdike0Du/idrfdsSH08h7bME
	 GQnzsbLXwcaOYcVRO9qqb07k9JREZjdk/PnlptjReEI80L8hym970eco/+qg9GcJo2
	 tfdcNCO49krC3pufJ0BiijlY+FahKsZEkH/1IbjXSNpAxXJXijtzCbUpb8XuC+I2D7
	 X3V9cwYiwqhnw==
From: Bjorn Andersson <andersson@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nitheesh Sekar <quic_nsekar@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Praveenkumar I <quic_ipkumar@quicinc.com>,
	George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	20250317100029.881286-1-quic_varada@quicinc.com,
	20250317100029.881286-2-quic_varada@quicinc.com,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v7 0/6] Enable IPQ5018 PCI support
Date: Mon, 19 May 2025 21:14:39 -0500
Message-ID: <174770727716.36693.13906353941989643518.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
References: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 26 Mar 2025 12:10:54 +0400, George Moussalem wrote:
> This patch series adds the relevant phy and controller
> DT configurations for enabling PCI gen2 support
> on IPQ5018. IPQ5018 has two phys and two controllers,
> one dual-lane and one single-lane.
> 
> Last patch series (v3) submitted dates back to August 30, 2024.
> As I've worked to add IPQ5018 platform support in OpenWrt, I'm
> continuing the efforts to add Linux kernel support.
> 
> [...]

Applied, thanks!

[5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
      commit: 18a5bf00a02ca54d51266b861518f2844c4f08d7
[6/6] arm64: dts: qcom: ipq5018: Enable PCIe
      commit: 22667f0b306f9cfa0c5be20166222f0e66272533

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

