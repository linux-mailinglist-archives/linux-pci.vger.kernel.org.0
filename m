Return-Path: <linux-pci+bounces-44053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A13C5CF55BE
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 20:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ABDC30D2C2B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DE5346AE8;
	Mon,  5 Jan 2026 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGRFtQj7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885C340DB1;
	Mon,  5 Jan 2026 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640611; cv=none; b=RIgxg7Y7pjD4xeoYl+zsRtT56OI0U+Qf5Wf+wG4PXmA8tWmSbqitWZI6/jJefroUiPLmApPIi4urd8u0u+MfpzQQbLP1lBVT70xv021ZfbE1zbrRUWYDJbdZLjGmb0sbTly8/9lJWxfsXSEoNXgT+6FNBVV+rzXiZ0vER5pXOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640611; c=relaxed/simple;
	bh=lJsAlyKWGPK9NeKozns1vIwE/xw06yTTTCaW1jO7B+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCoBAOz3FWmMZiUDiD7FCO5LNTxC0VW5V372zJrvKSNoNNTUeLd9oZpYBLBpchXOg+qSRk0dw/MvxrKL6IyTS8QRocKN0Lv6JbtzN9uv7GwKqlrfAskvhvJ/THjeIFPjYezDCN5dEexx29wchGcSCTBPdGtpEJZvjGf+1lmlVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGRFtQj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B088C116D0;
	Mon,  5 Jan 2026 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767640611;
	bh=lJsAlyKWGPK9NeKozns1vIwE/xw06yTTTCaW1jO7B+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGRFtQj70gQmDnVa+VY6r6e4KSgjOBNGNp0yF4W5v0Btif8RXOkXu368UK7II6aaM
	 lMNjihxYqji82EEDrE9PioYlLoCL/33TIe9X2POs2gCt+FwqW31+/0MMjZya2d3IGT
	 v9C9ZupLKWi+KClRN47Rb3V/Vm2sWjl8qLpbShvrQwKSlNL6ZexGnCqRdIvP9we6ez
	 a/E2hb+OgVBOeP8ufDPg45xhu8SRey8ZP611t3AGkgNbJ8tWrOSRL5ekbRnbsbUFmd
	 O5UirIyaRL3G7/T6653BpnzLl+wxLp7J3gkkaxj7gMs23CCSLIaiS8iCBtu6/QhE/r
	 9AjZPoT6B0prw==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	johan+linaro@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	neil.armstrong@linaro.org,
	Abel Vesa <abelvesa@kernel.org>,
	Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com,
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: Re: (subset) [PATCH v15 0/6] pci: qcom: Add QCS8300 PCIe support
Date: Mon,  5 Jan 2026 13:16:29 -0600
Message-ID: <176764058427.2961867.4488819001760832428.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>
References: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Nov 2025 18:49:22 +0800, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS8300.
> It also adds 'link_down' reset for sa8775p.
> 
> Have follwing changes:
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
> 
> [...]

Applied, thanks!

[2/6] arm64: dts: qcom: qcs8300: enable pcie0
      commit: 46a7c01e7e9d296ba09bad579ae0277cfb558b24
[3/6] arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
      commit: 33967eadb2153d92ea1de6e9c9ac8ade21c74d86
[4/6] arm64: dts: qcom: qcs8300: enable pcie1
      commit: 7565ec0170201aca07c9e1c3b5b6f213c5024599
[5/6] arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
      commit: cdb613a84527197f88f8bff3c5ee015e611a8373
[6/6] arm64: dts: qcom: monaco-evk: Enable PCIe0 and PCIe1.
      commit: 41e2424651f7c679382bb9e32225d3b541d4aa8d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

