Return-Path: <linux-pci+bounces-41817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B52C758F6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 4465028A76
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F232471F;
	Thu, 20 Nov 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihxve8Dz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A533A031;
	Thu, 20 Nov 2025 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658664; cv=none; b=UPjaaYayOGAdyEaVsMvFWTPPxv2rV0JsB8iKk88/1nx8FBzp0GQxEQ+NHkjyASjCPLMIzmucN/V7EU7AWQdORPZ02Bdjcw6Co2zTqgkEgc692x7jvH0qdCBmkNvgJex8EWsHDup+0km8cTKy+x0J85o4AYXc7rL376+BUrD/EX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658664; c=relaxed/simple;
	bh=srEXc3YV3Z9k+S6EjyCYz4pndYvvbKnp0h6Ftjs+8L8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AdEMEHiPm7W8C2fNlejvDtaKyQxtMvbH+nwNz9xkiM1z0RyCvfX6C2OxXVtTs1YZUkk2loinroi3RJB7b/juWTUb8+UzWQU9fdbo0L88aWlBBvR9uckFD5ttwUxXT0HQAVALpj47kArTHuyIvcimWKys3Nn5ex7Z3w5d265XRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihxve8Dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D931C4CEF1;
	Thu, 20 Nov 2025 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763658663;
	bh=srEXc3YV3Z9k+S6EjyCYz4pndYvvbKnp0h6Ftjs+8L8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ihxve8DzixV2TWEoB5pzQv6zF5lJiNc9O+zNIBHJ+p1O3P+EAxeIFgpualrrnUUcK
	 GM9o+qbJ2jonDThsdrpXOHcvSBF3NPB2DEXZTlI9SnMcA0ZJkteKHb9BZmnzHZVlcR
	 aXBB1/lBhMUQHnSdmT9iw1OgJwUmWltt947pg2VwCMFOYj06hRaJcacgw/FNo3OxnQ
	 fQoUtYZD0LyDmP43hC9um8bp28PrYl8JdiERR6dpb1QdN5L8lTx4YIx8rsNqY49+WH
	 NVWvifn/N6DKmykahiO1ikXpWCZf8syhAlNUkBNCQAtt6DcxlX39/3MigYeKioRQdv
	 XemZHmeMa1v4Q==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com, 
 qiang.yu@oss.qualcomm.com, Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
References: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/4] PCI: qcom: Add support for Glymur PCIe
 Gen5x4
Message-Id: <176365865805.207696.3284794076492688749.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 22:40:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 25 Aug 2025 23:01:46 -0700, Wenbin Yao wrote:
> Glymur is the next generation compute SoC of Qualcomm. This patch series
> aims to add support for the fifth PCIe instance on it. The fifth PCIe
> instance on Glymur has a Gen5 4-lane PHY. Patch [1/4] documents PHY as a
> separate compatible and Patch [2/4] documents controller as a separate
> compatible. Patch [3/4] describles the new PCS offsets in a dedicated
> header file. Patch [4/4] adds configuration and compatible for PHY.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the Glymur QMP PCIe PHY
      commit: d877f881cec508a46f76dbed7c46ab78bc1c0d87
[3/4] phy: qcom-qmp: pcs: Add v8.50 register offsets
      commit: bc2ba6e3fb8a35cd83813be1bd4c5f066a401d8b
[4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe Gen5x4 PHY
      commit: 1797c6677ad6298ca463b6ee42245e19e9cc1206

Best regards,
-- 
~Vinod



