Return-Path: <linux-pci+bounces-11230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B1946771
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 06:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EF728252B
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8892321A04;
	Sat,  3 Aug 2024 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/MCcpvv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C91130A54;
	Sat,  3 Aug 2024 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659599; cv=none; b=FDImrvmQcSH2QAYmpd+LedJj2A09IZ2wor+YyicmBj5s4HtsgGy8xFF4w85EafvxS8YqDgKc0s8Y4od6FvSYniPA7zg/7B2/5sRBNazvDCJOln7VFL7ntiQ+YBuEXN3owSQjpW5N3HS32hMbeyWDmnGtcW6lB3cvp9O52LQZhAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659599; c=relaxed/simple;
	bh=pKpCcF4Ikahp6VdzkjPmida2UGTxrv8uaII3qSDhGkQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=hTQJhFpRNppZVMX/+iSiSR76fzzUykYI4H/Kl04y6kumDgOjl/jBaY8I+MghyVq4LMJZ/OLDhRyO0JO4SxKXFsR4joFJuizwTlHsJC1xTpAWugf6Pv4bnVzis7y2j52Nxl+YF7iN9eXr/eP1qawW9DTuLRdWJkrz1Xfux7rf6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/MCcpvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3DEC116B1;
	Sat,  3 Aug 2024 04:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659598;
	bh=pKpCcF4Ikahp6VdzkjPmida2UGTxrv8uaII3qSDhGkQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=c/MCcpvvpitEdeZCrrWC2G9BT0nZj5dh+2DWEdBQF+ZTtfboxhOk7rsDhf1yqkBXw
	 FQymZ6GrsJHyLVE2DsYwXFeiA6ANYdBbZBXFN9H1WVCghwalARO/JYcj1y1mWA7NLl
	 CZB9R4d4Kk2kDGQY6xHonCFRJbifvJ+dWdZ6qCRjD3TndtARNClFNDuaVwCpPthgSV
	 uaqzhMOksXkvBzGNpaVw40rojGiw73TCBb+59GGswRmNFqnjCgdBls7+ovO7Y43Yvi
	 1Ad19tF3XyiU7CfozKWZBsdRbq1uIYEKqH0PAB1ArCYt0y85uyD36ukrfTx+EXBYMG
	 X9hc3TIfvUzYg==
Date: Fri, 02 Aug 2024 22:33:17 -0600
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
Cc: cros-qcom-dts-watchers@chromium.org, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, quic_vbadigan@quicinc.com, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, andersson@kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, devicetree@vger.kernel.org
In-Reply-To: <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
Message-Id: <172265959745.856785.3854064719699930724.robh@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615


On Sat, 03 Aug 2024 08:52:47 +0530, Krishna chaitanya chundru wrote:
> Add binding describing the Qualcomm PCIe switch, QPS615,
> which provides Ethernet MAC integrated to the 3rd downstream port
> and two downstream PCIe ports.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 +++++++++++++++++++++
>  1 file changed, 191 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pci/qcom,qps615.example.dts:33.26-101.19: Warning (pci_device_bus_num): /example-0/pcie/pcie@0/pcie@0,0: PCI bus number 1 out of range, expected (0 - 0)
Documentation/devicetree/bindings/pci/qcom,qps615.example.dts:52.30-60.23: Warning (pci_device_bus_num): /example-0/pcie/pcie@0/pcie@0,0/pcie@1,0: PCI bus number 2 out of range, expected (0 - 0)
Documentation/devicetree/bindings/pci/qcom,qps615.example.dts:62.30-70.23: Warning (pci_device_bus_num): /example-0/pcie/pcie@0/pcie@0,0/pcie@2,0: PCI bus number 2 out of range, expected (0 - 0)
Documentation/devicetree/bindings/pci/qcom,qps615.example.dts:72.30-100.23: Warning (pci_device_bus_num): /example-0/pcie/pcie@0/pcie@0,0/pcie@3,0: PCI bus number 2 out of range, expected (0 - 0)
Documentation/devicetree/bindings/pci/qcom,qps615.example.dts:81.39-89.32: Warning (pci_device_bus_num): /example-0/pcie/pcie@0/pcie@0,0/pcie@3,0/pcie@0,0: PCI bus number 4 out of range, expected (0 - 0)
Documentation/devicetree/bindings/pci/qcom,qps615.example.dts:91.39-99.32: Warning (pci_device_bus_num): /example-0/pcie/pcie@0/pcie@0,0/pcie@3,0/pcie@0,1: PCI bus number 4 out of range, expected (0 - 0)

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240803-qps615-v2-1-9560b7c71369@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


