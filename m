Return-Path: <linux-pci+bounces-43613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34DCDA1F2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7084F3017E3F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E895D347FD0;
	Tue, 23 Dec 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n786vXVL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EA0199237;
	Tue, 23 Dec 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511217; cv=none; b=Ao6VzE7CbbLP17o3vGt44MkS9durIjALYyMqhrd74Fn3/SnB6y0KNk9Ug7jmXvl5+YE5i/nMf0vXvnHf8GBYP0QWZZrEq7w+4zVS/ceWVKVaNNrJTqj50ut4Z5m3vAQ5qiywOLlBIqE+eYOD8PYYREVFN0SzKNLPvvm02DtKDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511217; c=relaxed/simple;
	bh=ieK5MZIYeyBFJTCcyavFLmcVUp3IkB50W7p/l4Ss9SA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IFDOMHk0Upxawe68TDUlqXFjNirm5sW/Q7tNJ1MxyBaGp4Sn5lICVROtayvEGRkxjC0VC46K5mGObdusf9W+oM8ecb+Idlf3VQZFx8hnPXamLs5mZd3XGzpWzVgOYIIRjBF4qN/rYf1R5dy1a8i5Evg83WkBNTHOLRL4Q2BRXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n786vXVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C058C113D0;
	Tue, 23 Dec 2025 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511217;
	bh=ieK5MZIYeyBFJTCcyavFLmcVUp3IkB50W7p/l4Ss9SA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n786vXVLo4nQS0cugl5a3rh1q3ZJkV1eSofkv4/iod8CfGY7zpOYygy2Kjqmt77Fp
	 10gAUzhHRkZI+eEBVWxYBk6wf+hHGm8izm10o+NOTj/xFSKKVcE9SHk4zICzpiVru+
	 Fyj12q0gOU/uXhIkUSvAKZQ4ANyBvT3D2OyBKdxyJt8bmzLRnB/Hyut2CCzcC1DXY8
	 mf4Ej6X3iCWcriszVm23sC1/U+83J4cM2x/Ta/z3whZd5cc8beqHjwJSJCYQzg1bp+
	 BWoXP/GJ98B55Djj63RYFRCGG3hD2bdkkrWSS4fljxSR5pjXnYTfFZsyF1zIbLJcYt
	 L9bxa5bQ2dY7w==
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
In-Reply-To: <20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com>
References: <20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v11 0/5] pci: qcom: Add QCS8300 PCIe support
Message-Id: <176651121108.749296.10189735833836078202.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:03:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 26 Aug 2025 17:12:00 +0800, Ziyue Zhang wrote:
> This series depend on this patch
> https://lore.kernel.org/all/20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com/
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



