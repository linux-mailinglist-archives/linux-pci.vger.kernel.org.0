Return-Path: <linux-pci+bounces-9308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0E918290
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E3D1F25FD5
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68D1836FB;
	Wed, 26 Jun 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWzHept0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244E181326;
	Wed, 26 Jun 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408896; cv=none; b=DT7HchrUAJ9rCWctGnht43OEUARHva1s0xSA5nrwKpQF+pyNDj0LAeSJ6m57VMaf2+prg6wFrZVSJTMMrd1oTQzJO9EWmIc+oIpt716UE24ttnIlCdkTG1+XIVm9Igl1KYyAJorn8g2S4xhb0f3IVisCJznbJOEC0xkJE9qJU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408896; c=relaxed/simple;
	bh=Gn4Pli2kvWj3GVbjuWpohIcu4iNuEX1X1zc4/G39S+Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=fIPcGxSuOxTctBiUN21Gd3Sph/waeVxCbkJ+Lx7ZCInvciC+cMLVPJHOd7pHhoU2lV8wQw/q2Mo2seSj4WJ5b/tH9MakCFlIYwb/91D/YTifY6zH/H0LSedHEvz4GzkHKmCf9d7bmh3FfXLydoVnNxJO28VwTBAhK57Cz6JwKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWzHept0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4B2C2BD10;
	Wed, 26 Jun 2024 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408895;
	bh=Gn4Pli2kvWj3GVbjuWpohIcu4iNuEX1X1zc4/G39S+Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZWzHept09Wt38QVjeaNvs16nDFLFZ9zPjbteSM3NNSK7rwC9vqpgyhCDXusg+RY6X
	 TAhAv1Uy2Yq8wp436x1fkcxTlzIra6/gZuqxMG9qawKmRizY2N9Hgvt5+ObQpXAVg3
	 wzGpr1EpbKKyua4N9fHYebbuGtI0RQaVIBSLjoRIQVM6X1oEcrNLmxr9jxfjV6pyq2
	 2TogYvzvKh7sQAlhqceppGnC4f2GPN/FnPQ1Oy2WIdJj2eTmYZnwLybTJK5JOc4yAv
	 8S32Xjxiwq09ryWVY2NipV4K2rsfvPOvDlwyJya2HcOXTmf+B+XB5IhTvOwqoyMowO
	 8V1Pyh/uf71ig==
Date: Wed, 26 Jun 2024 07:34:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
 quic_vbadigan@quicinc.com, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, quic_nitegupt@quicinc.com, 
 quic_skananth@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20240626-qps615-v1-1-2ade7bd91e02@quicinc.com>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
 <20240626-qps615-v1-1-2ade7bd91e02@quicinc.com>
Message-Id: <171940889433.2971707.8511570213525065770.robh@kernel.org>
Subject: Re: [PATCH RFC 1/7] dt: bindings: add qcom,qps615.yaml


On Wed, 26 Jun 2024 18:07:49 +0530, Krishna chaitanya chundru wrote:
> qps615 is a driver for Qualcomm PCIe switch driver which controls
> power & configuration of the hardware.
> Add a bindings document for the driver.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,qps615.yaml       | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/qcom,qps615.yaml:70:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/pci/qcom,qps615.example.dts'
Documentation/devicetree/bindings/pci/qcom,qps615.yaml:70:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pci/qcom,qps615.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/pci/qcom,qps615.yaml:70:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,qps615.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240626-qps615-v1-1-2ade7bd91e02@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


