Return-Path: <linux-pci+bounces-30366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C9AE3DFD
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D7F1673BA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C023C518;
	Mon, 23 Jun 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX0dOmGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E9226D0D;
	Mon, 23 Jun 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678456; cv=none; b=mzYR8Xz0f2QEmYV4bb5Un9vie5FHUQcKCLcdN8WJ0AAl3zkAwaILEi72sIC6YiBSt2nB6O+mrPLcMgJtm5hAMnQdQVR3BrYv1FUVBSv2YXj4nMX7lkwqMKuSqtNtBxlROjVZ9uaBZvsODK+WtPmgIduzJBTpv/r3xT0eewG0Lk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678456; c=relaxed/simple;
	bh=/RetL4kIHG+LsPfZWhJ8Y9ugot5k+FnaXQxodLw1Dp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uVhZzC5/Pt2kOHtDI/BfOYSTiIKiCfIwJRrNnw9ARJOSKCiApHxqIVOPgeu9kOYn2ZKCzZ+xKjEPtWSVVxQTocCuHee5RaHpol3hUh9e7dCZf4i22w8tt8+iGkFGdyIhb6j9caQ/F8YVuN/xXk23T9PmjziH/jeSWrllyokc1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX0dOmGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D376C4CEEA;
	Mon, 23 Jun 2025 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750678455;
	bh=/RetL4kIHG+LsPfZWhJ8Y9ugot5k+FnaXQxodLw1Dp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EX0dOmGYfFjZHy10cgRxOEMmjpY5O+e/jkfcCVOkNZTkNsW+PoUpLSIpYRFMjM6Hp
	 Q/zpU5NkWvfoZan75eWKLd24OwieVe1cqF9z8Xoke/ih8nkWgDlBtk0wygFXybylU6
	 +P8QhHvTSuG/YgKv5W5HHVqG046wV72wQBDccEwyqGbXtxLKp+Dfd0ffRKOKjFSbMM
	 6StomMxI6sRKAKwbyAIpwjfu9I/SpBxM3waWVUfqGFlehQtr1cEGYuw7tC6gzeIh9T
	 xdLdUj+7mWGEqNHCau+suVBiofZs0tBzfUFPxvY0KQDytUnhYfytP0tZ/gRe6w+S4S
	 4IkSpciGSp15A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, 
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com>
References: <20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/4] Drop unrelated clocks from SM8150/SC8180X
 PCIe RCs
Message-Id: <175067845514.5874.633377340223765245.b4-ty@kernel.org>
Date: Mon, 23 Jun 2025 05:34:15 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 21 May 2025 15:38:09 +0200, Konrad Dybcio wrote:
> Smoke tested on both, but more is always welcome.
> 
> 

Applied, thanks!

[1/4] dt-bindings: PCI: qcom,pcie-sc8180x: Drop unrelated clocks from PCIe hosts
      commit: 26daa18e35ebc4e192ff55d021f1cd7e69d55487
[2/4] dt-bindings: PCI: qcom,pcie-sm8150: Drop unrelated clocks from PCIe hosts
      commit: e1cb67ab82aab44cda410616498d4749399da217

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


