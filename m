Return-Path: <linux-pci+bounces-43611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7DBCDA1E3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45113301C8BA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31224347FD2;
	Tue, 23 Dec 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUZ3po7Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF133370F7;
	Tue, 23 Dec 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511204; cv=none; b=QuAfQa7200B+oM41zgh98SxFFLXLIutRut6qvWvAcgDoKEt4FE4gb2isymgEg91u7EruSJNe8iec+35sovlJXYGVPLChEy3a9xkN3qqwAnUWK8CJHVkMVAt0+rTQFfDviW/7vRNQ9JmMieHk68DHKy//obbSNkxYwAS+qeiF5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511204; c=relaxed/simple;
	bh=deTOv7XWoeuDUPt33bGc//lPbnOioqRsasUYpJIf5pE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hi/Rj73P6RN9ZfCulPS6ok8z5m2ba4I+cYSpSSIDLq+Kh/o9AXjOv80DKneneZcsPlRyVBzY7sbwjlm9mI9PbnhTCgoVfmeTggLBPKDQ6BZtvxraTogqkQTtHfiBoubdQKaJIk7M5DfXUmyF/J2H4sqwxc8fdl6ixZ/rfmAEO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUZ3po7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AE5C113D0;
	Tue, 23 Dec 2025 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511204;
	bh=deTOv7XWoeuDUPt33bGc//lPbnOioqRsasUYpJIf5pE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BUZ3po7QvFj1iRZJ6vcG78nShtB30uzeWmluFduwouRNP9Zp+15iJH1pgj1GeDEXe
	 hKrl8itN2PvIW++a+zaLsUG2JnWfxjdH03iJwiMCSrMM4B2DtG407YXFvB5wdrDb97
	 mMaBTk5GjeMZWKwHxDBPlJaR8BfOSRpECOdd6lfhu8PWZR9wZ+YRYIHFubcRnoR8Ef
	 GxzWWCq8D/V1fTSv/XR5XJySaz5tkxImvT31+mVWKHiPSC8cYUjQo1kYR4g5zsVk7b
	 Ev+dzIC6FjB+wFaSglIpTmsr7Uzr0/4YjJe4YvD+V761BVs0mOhOBNfNREvnXYeqWq
	 p9hlMBUWcWlNw==
From: Vinod Koul <vkoul@kernel.org>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
 mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org, 
 neil.armstrong@linaro.org, abel.vesa@linaro.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com>
References: <20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v8 0/5] pci: qcom: Add QCS8300 PCIe support
Message-Id: <176651119812.749296.11219098556381324671.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:03:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 14 Jul 2025 16:15:24 +0800, Ziyue Zhang wrote:
> This series depend on the sa8775p gcc_aux_clock and link_down reset change
> https://lore.kernel.org/all/20250529035416.4159963-1-quic_ziyuzhan@quicinc.com/
> 
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

[1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for qcs8300
      commit: 393e132efcc5e3fc4ef2bd9bbed2a096096c9359

Best regards,
-- 
~Vinod



