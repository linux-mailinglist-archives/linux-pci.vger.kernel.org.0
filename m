Return-Path: <linux-pci+bounces-39899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE329C23C81
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFBFC4F50D6
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE42C029A;
	Fri, 31 Oct 2025 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjAfxm6t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95222AE45;
	Fri, 31 Oct 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898849; cv=none; b=ABOWwj9+sCxlvnNicYcv9CB9MHpIn3WcG8aW2Dj1qUG5il+02Ksu78oo7IWxYM+3pDfBITO8SIxWAmCJhQlyGFJXOTEyWaXhdJHsmRAkig8NBL52GiL7OPioLwpKoIAfDstDXz4ZWIqtTpBAli3z1NI7CyetWdrTkXDUw5pKDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898849; c=relaxed/simple;
	bh=JxffaojoaNLBd6ekBMI0wGMUU29k4ICcZxn3vQPCuKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hLjmFDm2qFEXlwdFA+ut2aitY99VbwFB+x1knQlpikZz8XLapHtOjwC+pJ75RwaVqkBsqMLc0esn59u03CZVtf1JXbmCFfemlCcM+AcNhnfkI+pLF9D24/ESzd5x12REv0p/gBUwH8C8L5tK2Cl44r2r7MG1j0d3viVrf8ofl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjAfxm6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A21C4CEE7;
	Fri, 31 Oct 2025 08:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761898848;
	bh=JxffaojoaNLBd6ekBMI0wGMUU29k4ICcZxn3vQPCuKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PjAfxm6teG9V4VjvlmxAHvsIsuw2dbgm9scYX0IerS8+rEKmlmAi1Qwt3b1LeI/DQ
	 ol+GkuvfmSLLZVbKwqONXxDy2b39rDww0dCiCA6lGFzhJXKPepSdCrxy0bpnPCvU7r
	 QVMwG9jT6jPdx+AGx9UlMaFEARI2gMEifjObDpi4Gcj5Blc4XD7aADbLU0aYXH8H6c
	 8RzgfRKJ9mPWwLYOvQY/u696zjA6Rhv3croHEP/BN6J9/zp6TNOxjN4Motye6UVAzq
	 IhLWlQ6Hc+UOv+N7P7OCm3FZZNuj6XejG9ELZ6QkS78eTc86Ar+iXAvKIIhhZYYt7U
	 Jqu7aQKVAjrjA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, 
 Wenbin Yao <wenbin.yao@oss.qualcomm.com>, 
 Qiang Yu <quic_qianyu@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/6] PCI: qcom: Add support for Glymur PCIe
 Gen5 x4 and Gen4 x2
Message-Id: <176189884156.5303.14323602106505981794.b4-ty@kernel.org>
Date: Fri, 31 Oct 2025 13:50:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 17 Oct 2025 18:33:37 -0700, Qiang Yu wrote:
> Glymur is the next generation compute SoC of Qualcomm. This patch series
> aims to add support for the fourth, fifth and sixth PCIe instance on it.
> The fifth PCIe instance on Glymur has a Gen5 4-lane PHY and fourth, fifth
> and sixth PCIe instance have a Gen5 2-lane PHY.
> 
> The device tree changes and whatever driver patches that are not part of
> this patch series will be posted separately after official announcement of
> the SOC.
> 
> [...]

Applied, thanks!

[3/6] dt-bindings: PCI: qcom: Document the Glymur PCIe Controller
      commit: f0b5af98e1b5761095d5186d3a7af5a0991a5cd9

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


