Return-Path: <linux-pci+bounces-43167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90212CC7662
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 12:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4883F30C68F5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B633CEA4;
	Wed, 17 Dec 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsLd3koP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25432ABF6;
	Wed, 17 Dec 2025 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971122; cv=none; b=JouwqBPaQERzpbYfcqtY+QbV/0Cw4tsH5ePfyJyo0mHv3OfK+uz0a0+LCfolRrERfNLNR41mO83HDY6nU0j4gqafMyhGRHAqXsDExsy0LSsh2fG9WWrvrAcAnypeScXdR4wnRiajUpJFdhqWL9x1gdwVrnrWskZ+HT2zz4BiTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971122; c=relaxed/simple;
	bh=3dqfqIyIPLev54CZ6uE58tgsfI2/7I7WNdCX5laUzmQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tuhZwKw5xQcmjrAAw+nxlbx4DEFoPdjGfSc1gFV4XoaeIG3m56F+o/ZVdfNOL5FmGOTw/hSYiloLbQ3RtXkG2U1RxFf9aTXjFo7Wm2EnWBO/EugR6POaCs/9eN8qRRtMfOJTi1JlvpFBloywW02+wLecfLk+PEklpyFavmT1L+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsLd3koP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CDFC113D0;
	Wed, 17 Dec 2025 11:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765971121;
	bh=3dqfqIyIPLev54CZ6uE58tgsfI2/7I7WNdCX5laUzmQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QsLd3koPmVP+cLQxVZfeWNiT94p7LMqhdDJunz0ylkw7vLoznd7bXzcJV/d6QdVzY
	 oiXLzW1gY04d0uztqIRIef3/v/iSBuADsT/d3F9zvUXRzQ3SJBufeUNG8ABpsedbHC
	 rqfS7XK2qQx9Wz+FjtDRtEheYj98KRXjvxfgtrPha3D2JtI8k3p9oEYz1XBeUtqTa7
	 5Yg7AzBfhZiSG1P2E9FloxClEUdORqjumcD7Xah0qPmxJJ70ytm0slzoSTpInPlmzi
	 tFdGP6i/6aPW2NnZVVjdRgAOP2jl51cTDs+8/zDvirYP7bCtTSKM9BgvTpu/ixXru6
	 pLrIdNrqXSAZQ==
Date: Wed, 17 Dec 2025 05:31:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Rama Krishna <quic_ramkri@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 quic_shazhuss@quicinc.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Nitesh Gupta <quic_nitegupt@quicinc.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 quic_vbadigan@quicinc.com
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
In-Reply-To: <20251217-firmware_managed_ep-v3-1-ff871ba688fb@oss.qualcomm.com>
References: <20251217-firmware_managed_ep-v3-0-ff871ba688fb@oss.qualcomm.com>
 <20251217-firmware_managed_ep-v3-1-ff871ba688fb@oss.qualcomm.com>
Message-Id: <176597111816.570337.1780092644304118894.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: qcom,pcie-ep-sa8255p:
 Document firmware managed PCIe endpoint


On Wed, 17 Dec 2025 15:42:45 +0530, Mrinmay Sarkar wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.example.dtb: pcie-ep@1c10000 (qcom,pcie-ep-sa8255p): compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,pcie-ep-sa8255p' does not match '^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$'
	'qcom,pcie-ep-sa8255p' does not match '^qcom,sar[0-9]+[a-z]?-.*$'
	'qcom,pcie-ep-sa8255p' does not match '^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$'
	'qcom,pcie-ep-sa8255p' does not match '^qcom,(glymur|milos)-.*$'
	'qcom,pcie-ep-sa8255p' does not match '^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
	'qcom,pcie-ep-sa8255p' does not match '^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
	'qcom,pcie-ep-sa8255p' does not match '^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
	'qcom,pcie-ep-sa8255p' does not match '^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+.*$'
	'qcom,pcie-ep-sa8255p' does not match '^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
	'qcom,pcie-ep-sa8255p' does not match '^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+.*$'
	'qcom,pcie-ep-sa8255p' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,gpucc-sdm630', 'qcom,gpucc-sdm660', 'qcom,lcc-apq8064', 'qcom,lcc-ipq8064', 'qcom,lcc-mdm9615', 'qcom,lcc-msm8960', 'qcom,lpass-cpu-apq8016', 'qcom,usb-ss-ipq4019-phy', 'qcom,usb-hs-ipq4019-phy', 'qcom,vqmmc-ipq4019-regulator']
	'qcom,pcie-ep-sa8255p' is not one of ['qcom,ipq806x-gmac', 'qcom,ipq806x-nand', 'qcom,ipq806x-sata-phy', 'qcom,ipq806x-usb-phy-ss', 'qcom,ipq806x-usb-phy-hs']
	from schema $id: http://devicetree.org/schemas/arm/qcom-soc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251217-firmware_managed_ep-v3-1-ff871ba688fb@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


