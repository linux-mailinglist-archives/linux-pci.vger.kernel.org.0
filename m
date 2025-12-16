Return-Path: <linux-pci+bounces-43134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD46CC40D1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 16:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FA1E301928F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1768128C862;
	Tue, 16 Dec 2025 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umzTpPGI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4934403D;
	Tue, 16 Dec 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898950; cv=none; b=aVpC+9Yv2andrpsSOFAHL+dPWS+1Kjkb3Ut0OSYIFe6Uc6lDWc2ncbSJTjv/LqNzmh57UWw6j952a7Pl5HN9vjAGpL7rQYeEJM982APzna2QY9Cy6Ig9HOkPIpwpKG//39pKj2WxRKgu0V/9jsXbOIjTYOVZB/u2e9MDKX9x2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898950; c=relaxed/simple;
	bh=ZqgGDZJPzfmSIrJ7Y3pKsg8ii8OKhw1fZ3Qm4xmv9Pk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pS4d7t46G7zY3oPaV2ia5bXJJazIkohSajSaFU4pYVWqUt6r5+iyAng9GtFjbbjtb2242WwCOmdhzr4qig6waYsgL0E8Q0WZmE/vayM/+wfsPR3eo8mBlGaFmS3tIuxKiK1KJ+efLR+5IK10E9z7UQ7tzlmxoGvhdMdY2ticl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umzTpPGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AC9C4CEF1;
	Tue, 16 Dec 2025 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765898949;
	bh=ZqgGDZJPzfmSIrJ7Y3pKsg8ii8OKhw1fZ3Qm4xmv9Pk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=umzTpPGIUT9tUTdOow3rH7yL6TqEzh9jL3coxEi60tDTEZXQB8BR3BoA45lhOC9vy
	 ChdhMlpYuW0txxWq/5C5AfwbTvaB/WtN/9qJ6Hq4RTZSFrsPptZaBW+Q31TuwPwe4J
	 jzRGJjo9Ce1KD8PlR9zheTmtIiKgcel3TyKN0f/8atgypVcc9ItUZ4zHcqb7n/V2XO
	 IRP9EkmfZVaa4UopJeLQ3trHBAQRiBE3nS2uo8Z7y9EuPlVKzJje27tIMYfusi3P+d
	 NB9X+24+egEpRIz6sIipW5wMotLHPx/3+zfRLf2a5Z6If9+Qjltd7ts6SjLNJ496w6
	 v5Drg7l6spKwg==
Date: Tue, 16 Dec 2025 09:29:06 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
 quic_shazhuss@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rama Krishna <quic_ramkri@quicinc.com>, quic_vbadigan@quicinc.com, 
 Nitesh Gupta <quic_nitegupt@quicinc.com>, 
 Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
In-Reply-To: <20251216-firmware_managed_ep-v2-1-7a731327307f@oss.qualcomm.com>
References: <20251216-firmware_managed_ep-v2-0-7a731327307f@oss.qualcomm.com>
 <20251216-firmware_managed_ep-v2-1-7a731327307f@oss.qualcomm.com>
Message-Id: <176589894648.2511603.9461849499751093485.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom,pcie-ep-sa8255p:
 Document firmware managed PCIe endpoint


On Tue, 16 Dec 2025 19:19:17 +0530, Mrinmay Sarkar wrote:
> Document the required configuration to enable the PCIe Endpoint controller
> on SA8255p which is managed by firmware using power-domain based handling.
> 
> Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> ---
>  .../bindings/pci/qcom,pcie-ep-sa8255p.yaml         | 110 +++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.example.dtb: /example-0/soc/pcie-ep@1c10000: failed to match any schema with compatible: ['qcom,sa8255p-pcie-ep']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251216-firmware_managed_ep-v2-1-7a731327307f@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


