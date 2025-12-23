Return-Path: <linux-pci+bounces-43609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95931CDA1CE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 18:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 033FC3002EAA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5D3347BD2;
	Tue, 23 Dec 2025 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPGjmqoo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65C275AE3;
	Tue, 23 Dec 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511194; cv=none; b=Z3HuhKAaYJucjKsAokWF/PMEvijkAqW8fX+IG7ShekTkKazc9jkOCTy3ykrS+OWKLpG3Z0rk0awKD0ARywARO051UZPApOz93Mi1d7Bt5M2JbhTTeOQYSQBYoZEYIbV8H6a4OItx+vh2/wT1I438+W14pj2ztp3IxvOag8cNTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511194; c=relaxed/simple;
	bh=omGwGLKu+amFxrkn8sr0EraNhTwGj2HokUaFJLyoq6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XpRBEzEyt5CgLqji3e3mJ0dNr1J6T7nOPPluVSZINZA1RmdVKQCo/BhzyPxZep9nFogZA5AqWMeXl/RcI5G+dEmLwqLyr01I2XH4HX9xMgLvDawbTfNOXF6F0gVyjs4+K3dNivRQuukYXKSETPE4CyrCsC33QdDfOi0gFHoh9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPGjmqoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B14C116B1;
	Tue, 23 Dec 2025 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511191;
	bh=omGwGLKu+amFxrkn8sr0EraNhTwGj2HokUaFJLyoq6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BPGjmqooLPzq3mMFX9ehYZElO+y3l4zzEJcPdrG5c4wDwkCCfLIXcZXtp4ecJD+VJ
	 fwAkUTQdoN2cyf2yAudv+UsQ/0Pk7M7AaXM5Dz+AiZZ7l0kz0RlBPxkJpv2ykqQNes
	 DpKsRc6aVaV8HWkIZz3VN6u57TnGfqixb2Sei8GWvj0vbYWkFjTA+8LrJy8LFEwSUW
	 pEpY5NRlZCTOgWcKUfuEOo+od1+q2dYmew2iry2SWLSvMbDbLDDEMZqIuuHYxDdpma
	 +SpBgslVp7bXs041buXuoV7ObGY3Uuj1Kg/NeR+Jjbnk0R8X8335VzFUeoxLe566/D
	 wMJyNBgzaJbMQ==
From: Vinod Koul <vkoul@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, krzk+dt@kernel.org, neil.armstrong@linaro.org, 
 abel.vesa@linaro.org, conor+dt@kernel.org, kishon@kernel.org, 
 andersson@kernel.org, konradybcio@kernel.org, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com, 
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
In-Reply-To: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
References: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
Subject: Re: (subset) [PATCH v6 0/6] pci: qcom: Add QCS8300 PCIe support
Message-Id: <176651118606.749296.7445159215784702009.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:03:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 29 May 2025 11:56:29 +0800, Ziyue Zhang wrote:
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

[1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for qcs8300
      commit: 393e132efcc5e3fc4ef2bd9bbed2a096096c9359

Best regards,
-- 
~Vinod



