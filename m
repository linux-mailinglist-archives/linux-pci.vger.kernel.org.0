Return-Path: <linux-pci+bounces-34297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BCEB2C3CC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378476249CB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE223043CC;
	Tue, 19 Aug 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue6MIP5I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805243043BD;
	Tue, 19 Aug 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606748; cv=none; b=ZFfAmEbbsxPHQOxIM1Ycf5htVyQMrIYeDOxxPwtBO7Djk51o3Rqqqcehkrh6uKLpdLToeFWPIL6Et+85gIcYFYxz5ccm4/dgLggEYxEDr3tHoipwroHjTdvAqwWOe+1Wpaz1zOaRNz0oyUDwaNbhFFQxJdoZ3fxb1Aldh7gWSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606748; c=relaxed/simple;
	bh=AW3nkhwvENrqUTmWgqTETJ2cofqdIM0bMSih3AfLtY4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bN71KSJm0xq8m7Bk3zf+fcNkSR/tvQpI/KJNKyGYkZJCakLOLT2OzJc7sJJT5kO1ZZ3t0wkqq8HVi+dgZsXdnyD4qrrS0KPAp2xmgKpha1/GEMR+uSxWz84y9bWf+n1UMZqKklAfTb+h1EsRoqbYAEChy8oJXMicIThkPdgyWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue6MIP5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB60C4CEF1;
	Tue, 19 Aug 2025 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755606748;
	bh=AW3nkhwvENrqUTmWgqTETJ2cofqdIM0bMSih3AfLtY4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ue6MIP5I7QWsWMRSgbYR7pvkld+A/Jw07jpjDEPHvPpJ8YJ09qEyTKhXa/s4dpcmL
	 awq5yrzFh6efFyKSVQrzYe68L7sxyaN47ybljYdiryvjPs1wrosHczLU2jiGuHOtYu
	 7WjEpQKRgYCbukAA0PfYU4liAH3h3kN7FVnTrtZvNQL6m2J/6enKNolPkM9HTga8lg
	 yewIi2b6oHK5nd8GuA+JaW5vIf7zs8S2QnhNzCoazTfBN5VsqohKBo3QzdboGhrDAa
	 KpKWjOKgSXAPz3d73A3HFpFKz3akDNwPDIibQYpq7VCGGT1L+0s+mq4bcC+49xYwib
	 gKAHPFG5supmw==
Date: Tue, 19 Aug 2025 07:32:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, konrad.dybcio@oss.qualcomm.com, 
 Vinod Koul <vkoul@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 linux-arm-msm@vger.kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, qiang.yu@oss.qualcomm.com, 
 linux-kernel@vger.kernel.org
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
In-Reply-To: <20250819-glymur_pcie5-v1-2-2ea09f83cbb0@oss.qualcomm.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
 <20250819-glymur_pcie5-v1-2-2ea09f83cbb0@oss.qualcomm.com>
Message-Id: <175560674407.26155.2834845935745858066.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller


On Tue, 19 Aug 2025 02:52:06 -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
> controller present on the X1E80100 platform. So document the PCIe
> controllers found on Glymur and use the X1E80100 compatible string as a
> fallback in the schema.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-glymur_pcie5-v1-2-2ea09f83cbb0@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


