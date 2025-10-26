Return-Path: <linux-pci+bounces-39340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF37C0AD06
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 16:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE51189DBB3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9D200BAE;
	Sun, 26 Oct 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUPb8KxQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB71F4169;
	Sun, 26 Oct 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761494240; cv=none; b=PHCvMbn+dUmC4+THW7Rqgbm+Cyi8NI6JN/+uT5ZmXKhOPuyWqFg9KAY5PuYFVN3JRLCQEH1i8Uf85OkokIG3LvcrZgsL/jI1YtuXm2AsCMryQ/DHFsm954979iJ6VefKJASeACPP078Esyfq9gVTmMZirpLoCG5E5DpzqfGAxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761494240; c=relaxed/simple;
	bh=7Ou0fEZ/jwKerVmUa4t96b/hLUjjbHEGSc/S4mOnZyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h8TBxAyhxNtZxEGB2/IyO31dXMoSM1viz7vjsWeZtZgDfFTvbsQtCf4g8cbP2b0PJwRHWFMPh+g7zC4nSJahFuPnpCnfYDJewEEsPdxj2PB9Ybr4HSjNAwonOPHa8WTLbdyKWwi7WFKU5YfMYXJsB30bZNgD3EVbV6Da2JC0xwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUPb8KxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F6FC4CEE7;
	Sun, 26 Oct 2025 15:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761494240;
	bh=7Ou0fEZ/jwKerVmUa4t96b/hLUjjbHEGSc/S4mOnZyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jUPb8KxQm2jI/qhICb70KWnhukiMfL3HCZ9JVXUq/H2f6i1aWGv3awPaDfmZ0/FLZ
	 e8R1wXwYd+i8bvq+JA1X0GIUaaCtwsghv9qElkORQrhy0dZ4ijVWDSzIxTPRcMYs8m
	 2qyOIYpQ4/ypz0KNAb+NFFAl+h3O2ZSqw/77QFN0ZDJIcGcpPfX0X0x26W5xwjkb3W
	 ++MxEwLww8sV0ZS+hxamrRYJS1u5aF5j23yR/N7WO7KChbCRwgcPcuUQCDuDFmW1Z3
	 5f49Qecq5v6fxefs0FGmKHus61hCAj2usE6bUSId1GNGc2uFBegfEIEOtYJCQofCH2
	 8wKtbXRMecWvw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/3] PCI: qcom: Binding fix
Message-Id: <176149423539.9818.11398999036385649843.b4-ty@kernel.org>
Date: Sun, 26 Oct 2025 21:27:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 10 Oct 2025 11:25:46 -0700, Manivannan Sadhasivam wrote:
> This series fixes the binding issue around the PERST# and PHY properties.
> The binding issue was reported in [1], while discussing a DTS fix [2].
> 
> The binding fix provided in this series is not sufficient enough to spot all the
> shenanigans, especially keeping one property in Controller node and another in
> Root Port node. But this series does catch the DTS issue fixed by [2]:
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: PCI: Update the email address for Manivannan Sadhasivam
      commit: e3d7fda088c3c75d210b849c3823008f32cd00ce

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


