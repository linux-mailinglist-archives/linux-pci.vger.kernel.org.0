Return-Path: <linux-pci+bounces-4343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003386E86B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 19:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4321F25ED1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB61E381D9;
	Fri,  1 Mar 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roaSS27x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0571947E;
	Fri,  1 Mar 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317808; cv=none; b=qXT5xG3NAwzb0QC09YRgDc3i/89ZgKbXEaDPZW7GK60eAltjBEJ133yi9ta1Rxq5QkgZ9o00tPHw8eb0IWmcgP+SLdoCmCwv3zBCz2vQ1AUDNvX8MYvUJ6y/VhxXm6/RLX6Jyv/h0BSiXZbspaZZYKjx4h3ajV7jnK9Sp+mnJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317808; c=relaxed/simple;
	bh=zNjk8NgpRf8SPLPlWiULuIIxkOLpaGNZRTDraICPahg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=h3AYlDT7K1hTOCNT1BAfNlFcdWfMo2ZfMkfN9cUgwVUboiQDWNYLYS+FLBUAoMstL6ItdyDtdcDB+KB/OfWdq4X2TTIp/uUePZqHoDg2LUlqL0ZUGgG2D9JRrgQj2ZhXcF4/uTHjY1crAuiTrjXRZ0iI7tLLfWFWZobYD3WC4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roaSS27x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4905C433C7;
	Fri,  1 Mar 2024 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317808;
	bh=zNjk8NgpRf8SPLPlWiULuIIxkOLpaGNZRTDraICPahg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=roaSS27xyOCyQCcgP2A3a0Slim9pXT+s/H3kl8cXh0haT95WOioZ5IvSEiyeYg/68
	 g5q31RWjF5CjSbPwlWcnRrqcO/C4yKUzc/NymXj9bibO2Y0BzUQOo0JSprAA6tDZBp
	 3J5HMQx71OX9BEgsXbNcitUrBvkX88iMux+Eg+QGTvtAeIcBojsAKny7AbDKGeX6tg
	 EUIVcbrYbQwScwofqzShfnRx3rtV6KKHxjpjJrrEo2at5BM5Q1bpJu9wtMy0r/mK/p
	 skdh282kgPlTl4syuakstlsTyTbl6tAfR5ckdABI0p53f6CQzYd4h+vyTdQbkUppWn
	 lj0umnNTJU4UA==
Date: Fri, 01 Mar 2024 12:30:07 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, devicetree@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20240301-x1e80100-pci-v4-1-7ab7e281d647@linaro.org>
References: <20240301-x1e80100-pci-v4-0-7ab7e281d647@linaro.org>
 <20240301-x1e80100-pci-v4-1-7ab7e281d647@linaro.org>
Message-Id: <170931780595.2705354.15356047665214637991.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: qcom: Document the X1E80100
 PCIe Controller


On Fri, 01 Mar 2024 18:59:01 +0200, Abel Vesa wrote:
> Add dedicated schema for the PCIe controllers found on X1E80100.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../bindings/pci/qcom,pcie-x1e80100.yaml           | 165 +++++++++++++++++++++
>  1 file changed, 165 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/pci/qcom,pcie-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.example.dtb: pcie@1c08000: False schema does not allow {'compatible': ['qcom,pcie-x1e80100'], 'reg': [[0, 29392896, 0, 12288], [0, 2080374784, 0, 3869], [0, 2080378688, 0, 168], [0, 2080378880, 0, 4096], [0, 2081423360, 0, 1048576], [0, 29405184, 0, 4096]], 'reg-names': ['parf', 'dbi', 'elbi', 'atu', 'config', 'mhi'], 'ranges': [[16777216, 0, 0, 0, 1612709888, 0, 1048576], [33554432, 0, 1613758464, 0, 1613758464, 0, 63963136]], 'bus-range': [[0, 255]], 'device_type': ['pci'], 'linux,pci-domain': [[0]], 'num-lanes': [[2]], '#address-cells': [[3]], '#size-cells': [[2]], 'clocks': [[4294967295, 96], [4294967295, 98], [4294967295, 99], [4294967295, 105], [4294967295, 106], [4294967295, 21], [4294967295, 33]], 'clock-names': ['aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'noc_aggr', 'cnoc_sf_axi'], 'dma-coherent': True, 'interrupts': [[0, 141, 4], [0, 142, 4], [0, 143, 4], [0, 144, 4], [
 0, 145, 4], [0, 146, 4], [0, 147, 4], [0, 148, 4]], 'interrupt-names': ['msi0', 'msi1', 'msi2', 'msi3', 'msi4', 'msi5', 'msi6', 'msi7'], '#interrupt-cells': [[1]], 'interrupt-map-mask': [[0, 0, 0, 7]], 'interrupt-map': [[0, 0, 0, 1, 4294967295, 0, 0, 0, 149, 4], [0, 0, 0, 2, 4294967295, 0, 0, 0, 150, 4], [0, 0, 0, 3, 4294967295, 0, 0, 0, 151, 4], [0, 0, 0, 4, 4294967295, 0, 0, 0, 152, 4]], 'interconnects': [[4294967295, 1, 0, 4294967295, 1, 0], [4294967295, 3, 0, 4294967295, 12, 0]], 'interconnect-names': ['pcie-mem', 'cpu-pcie'], 'iommu-map': [[0, 4294967295, 5120, 1], [256, 4294967295, 5121, 1]], 'phys': [[4294967295]], 'phy-names': ['pciephy'], 'pinctrl-0': [[4294967295]], 'pinctrl-names': ['default'], 'power-domains': [[4294967295, 5]], 'resets': [[4294967295, 24]], 'reset-names': ['pci'], 'perst-gpios': [[4294967295, 94, 1]], 'wake-gpios': [[4294967295, 96, 0]], '$nodename': ['pcie@1c08000']}
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.example.dtb: pcie@1c08000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'dma-coherent', 'interconnect-names', 'interconnects', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'linux,pci-domain', 'num-lanes', 'perst-gpios', 'phy-names', 'phys', 'power-domains', 'ranges', 'wake-gpios' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240301-x1e80100-pci-v4-1-7ab7e281d647@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


