Return-Path: <linux-pci+bounces-34296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1874B2C3C2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2190188AA10
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47AE202C3A;
	Tue, 19 Aug 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUE5LiKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A90305078;
	Tue, 19 Aug 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606747; cv=none; b=NVOjHFDf17Vmql9CnDkfK0MBtJOLsBvBcxlkSL5sIzfYLDvRM327E7eZZdan37uVTdnC/zyiwMiSAIHTDT65RELqkdX+mrRisW9YuEbXowuuCk4uEhjQbG9FcGyDkl28c2QfBLYYyRe/SA+SSpAepLleMiPKIKsoNaJF+XNWxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606747; c=relaxed/simple;
	bh=oRf1mvv6p2bt2J9+yBXoa4O3Bz8NmOE1R+ShJsBwd/s=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UdM2CnQyorTKHfIf8BmpAtApfGlqr6muO0mFWRrC4hm3gHnEd1hkro3R7vANmT7RBGSdm2KZRRf8mqZCkkHCmh8SrB758yUOmu5J8PXYWAb9RAYbQlx/1LPJnVugVznEkUfFeQi55ZPNyTgLOxshwN1cA97zrcPNinIb1kHVBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUE5LiKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84DBC113D0;
	Tue, 19 Aug 2025 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755606747;
	bh=oRf1mvv6p2bt2J9+yBXoa4O3Bz8NmOE1R+ShJsBwd/s=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rUE5LiKs3wj2ajNOjxxegJfOJU8PKCbDqCkia0L24pJDJUnoEBpH7zpSgei2uCkS6
	 MlQ5EpxK5lGGVUaL6gcQKCguaQWb0jb8fx/TKgH8DPN92sHL2cHHLXEzmbgvhxQWg0
	 nPM7lLP/6ptWbi7kxdigC2mTsk1A+AmOTAKE2Nf5kURMusvQ/gaUMHMZObmEvWQJQ6
	 J4S5IMEwX6w3PQiaaExlQZMXmkufrUFzQgjJ6YjpCfrrVmJu4gqtcjSYbzZU0awYJU
	 uNsbf8fh7R90vtCInXNcRjwTt438nmStKF3n45xlLEqFsN0bnT6vHmuLGzbEx7a8nD
	 MzuQTX0pccz3w==
Date: Tue, 19 Aug 2025 07:32:25 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, konrad.dybcio@oss.qualcomm.com, 
 linux-kernel@vger.kernel.org, 
 Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
 devicetree@vger.kernel.org, qiang.yu@oss.qualcomm.com
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
In-Reply-To: <20250819-glymur_pcie5-v1-1-2ea09f83cbb0@oss.qualcomm.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
 <20250819-glymur_pcie5-v1-1-2ea09f83cbb0@oss.qualcomm.com>
Message-Id: <175560674306.26088.17838769805587892599.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY


On Tue, 19 Aug 2025 02:52:05 -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
> separate compatible.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-glymur_pcie5-v1-1-2ea09f83cbb0@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


