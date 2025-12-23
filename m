Return-Path: <linux-pci+bounces-43612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE0CDA210
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 18:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7B2F3030D81
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF4A301477;
	Tue, 23 Dec 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVYOQT0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39796199920;
	Tue, 23 Dec 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511211; cv=none; b=Mdz4klVTQx5u0Ponwr+9gdQjVG6vRlMp52YOvWUKIatRr1H0ccwADY54G7cjok1CMN2+wLZXgOms6dGeB0ixaT1xtz90gQFgQzkMjLkjEr/6IM6vtSceRbQ0zSio3b8vRD0eMON2YREB5tVpChycLwFyYbPyfhZodb6A9tOG3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511211; c=relaxed/simple;
	bh=+vbWQLsDktrRDTVqLO3sO5wLflVRrRgUbqvl2EXZW9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gRAZ+BRXdYCrPW8XFSCXQ6iDLHzeuA0//Sucm9lNNRqp3m4NW6ZxaKkFDOcHwqMAJS5tl0+zFc/O6E0djVsU+7m8aqZGQb6KHpIZiUb4TH+voXMux8TWSvRxKzExVV6PcrccdLUS/7IuGo4CFhwGIoJO8BBNEyXCV3GeF4XsTL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVYOQT0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBBFC116B1;
	Tue, 23 Dec 2025 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511210;
	bh=+vbWQLsDktrRDTVqLO3sO5wLflVRrRgUbqvl2EXZW9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZVYOQT0/QzrtL6tc5EE+Qo5Y8Tb4h4+XpaKtCSpx0q8VdecHGvK2QJ3k0zwUDfUt6
	 fWW11xVq/93oAdBlxTmirSFCKR9Hk3iJcAbEydYg3tmugLiKpcVeINHifo+v44yPwd
	 Iv5pfIyRUUe3g1PWKnRL+fq1HRqPoLKCl3VT6e9UJ/udQYSUfyLsBMuLIKzkwr9D/6
	 lfkcpUmloprXCxQl0CzynKAZQpShm+hp/EpmM/jwseuyoiQcZaGLB0ZX1pooNrmoxX
	 ZdrCGgNK04LOoCKswgRF+J+qsC20RH5G+SxJHRRUS6LNLvD+N0DIgdiyIuyryB799q
	 cer0dkymE4fEg==
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
In-Reply-To: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
References: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v10 0/5] pci: qcom: Add QCS8300 PCIe support
Message-Id: <176651120460.749296.6051122462631271364.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:03:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 11 Aug 2025 15:11:26 +0800, Ziyue Zhang wrote:
> This series depend on the sa8775p gcc_aux_clock and link_down reset change
> https://lore.kernel.org/all/20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com/
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



