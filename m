Return-Path: <linux-pci+bounces-42262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07965C91F75
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 13:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD9674E2701
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 12:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC3328B79;
	Fri, 28 Nov 2025 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoU05y5y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2D328633;
	Fri, 28 Nov 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332333; cv=none; b=dAxPHc86zEIaRKmutJAG2xdCNOGSsjVwF5jyz7T3uAl4wXD6QcH4QyTQ66eII2KwKNgmJGPUlJO81epC0RLr7J9ww+AYSA+lYnK5J5ll0L9W62a1uCAD1kirHyielxnXWy3pis4PrJFqnV1Xz3JPjUXorK2Sy8O6a6w+jngwdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332333; c=relaxed/simple;
	bh=gwDTvuVEHdwL5CUTLbeq4biMUroLNJCpGrbaPQOlfCw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Gtc9lcPW87CkzXYxSd/bqgAIH5lz200Tcqiy7afPiWFkEOQuX8xcRF1HUvYyM27cztKCtTd98LILAemCCjmbgHyV49FTpsVacxcKOkPMduUVcC8G9hxSM63rYVBT7PjAvMNJJd+7GF8aSAB0PDBCkNkYMR+HTQ6igIIRimMqy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoU05y5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5BEC4CEF1;
	Fri, 28 Nov 2025 12:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764332331;
	bh=gwDTvuVEHdwL5CUTLbeq4biMUroLNJCpGrbaPQOlfCw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=PoU05y5ysXu2aV9aWhr1Z4El4WoOUqFX1MQqkEQWpgWfHFWJOqq/slmGgmMeUnH6j
	 nLOwi8Q9sRIvjV9BuIIQY/74a4ck2fWuhC5G/cgHrnTYUTJoWA84N1T1HdiTFH4481
	 MMUZSWc1h1l1hqzjsyW6KoBZhPVa3versw2HZIYdXV9q+q3kOILLH0xp4sqnAI91J4
	 KTdwcjQj1yWfeR3v43Unr5iw64TJCy3JIRsCFw5LpP/Pxn2HZ4KjB6SB5X+jtHfyRr
	 1ullpmvw84BUX9JhGzj4KuFEOsyWlMtYER5gJHW5O4+FdXwg5n+p+oJzgUnc1+i+sW
	 I9BoXVDAngGeA==
Date: Fri, 28 Nov 2025 06:18:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, andersson@kernel.org, 
 devicetree@vger.kernel.org, abel.vesa@linaro.org, 
 linux-arm-msm@vger.kernel.org, quic_krichai@quicinc.com, 
 qiang.yu@oss.qualcomm.com, bhelgaas@google.com, kishon@kernel.org, 
 mani@kernel.org, quic_vbadigan@quicinc.com, johan+linaro@kernel.org, 
 kwilczynski@kernel.org, jingoohan1@gmail.com, krzk+dt@kernel.org, 
 neil.armstrong@linaro.org, vkoul@kernel.org, conor+dt@kernel.org, 
 lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, konradybcio@kernel.org, kw@linux.com
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20251128104928.4070050-2-ziyue.zhang@oss.qualcomm.com>
References: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>
 <20251128104928.4070050-2-ziyue.zhang@oss.qualcomm.com>
Message-Id: <176433232993.1873037.5014618389839995125.robh@kernel.org>
Subject: Re: [PATCH v15 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300


On Fri, 28 Nov 2025 18:49:23 +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
> used by any instance.
> 
> Fixes: e46e59b77a9e ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml         | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251128104928.4070050-2-ziyue.zhang@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


