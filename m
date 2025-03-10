Return-Path: <linux-pci+bounces-23286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFFA58E09
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A4188E013
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C8222593;
	Mon, 10 Mar 2025 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8T+aQzp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED40213E93;
	Mon, 10 Mar 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595012; cv=none; b=NWQU7b1neTzUlsmeNqeNbx9z8JUjvJJsGJFi6a6QtzReSay/RrQJOE6z384E19M22ECyQ8aKEoH8NyV0fM79fWfN35dQAqQ3Rr6DnfXEtdpAOSlyJx1T7/n1C0EDe1w3OM8OVO+M9Ntm/Hw5q5BfZ6IP6wWu7JpXw1KEhPs8vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595012; c=relaxed/simple;
	bh=6YS12As8AjAjGZ/NYR1OL7LWdlVVM8Ywxsw7OqaqjCw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LCgu1APZKAhsja1owIHH1mF/XJd3pg9+mkAnLJuukjfUzyG10fKH+3kCe7JsVhmrrrQFf+DKM3o+MM5hrlVWE70570AC8mjdWeCMp+12g767PrSPwdagFaP2nGl6Ui+YsVIvsBFb7SuUtWmTPrUW6+jI1QhbZW76H9Hxnfz4ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8T+aQzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82443C4CEE5;
	Mon, 10 Mar 2025 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741595010;
	bh=6YS12As8AjAjGZ/NYR1OL7LWdlVVM8Ywxsw7OqaqjCw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=M8T+aQzptkie1CRGdVDOBLsQKkwmiHQ7cqdLudZskVnXs6UfjBFtoBV/3o1LOXlRF
	 3deQyAH8FPL+0DH3RnJfWbMiIkfUVyMrQTgx7+wAa4WTHpyoCUeI5cicmUq5UVYRTE
	 HgJfqDe6B66Ar4pdnRt+Ix7Qcyj0YSvbBz2H1D6TbNSGoIZOpqD6TR551rv1YrkV0D
	 nggLc84OktxwOKoB3s7p1xrm16gyu/nEumhk/920jINDpOmeI+ffKfrbQgc8kNVGKs
	 llIqyVT8NzH/o4EgXxhdTqGeKZmkXxv61lmAWRcnNH6biWz2XJ4jL1QPZnanxCPROM
	 v4zXQ7WhhoNgA==
Date: Mon, 10 Mar 2025 03:23:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, abel.vesa@linaro.org, 
 linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, kw@linux.com, 
 johan+linaro@kernel.org, neil.armstrong@linaro.org, lpieralisi@kernel.org, 
 conor+dt@kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, kishon@kernel.org, andersson@kernel.org, 
 dmitry.baryshkov@linaro.org, konradybcio@kernel.org, 
 quic_krichai@quicinc.com, krzk+dt@kernel.org, bhelgaas@google.com, 
 manivannan.sadhasivam@linaro.org, quic_qianyu@quicinc.com
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250310065613.151598-2-quic_ziyuzhan@quicinc.com>
References: <20250310065613.151598-1-quic_ziyuzhan@quicinc.com>
 <20250310065613.151598-2-quic_ziyuzhan@quicinc.com>
Message-Id: <174159500913.3380799.14221924313975247180.robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: qcom: Document the QCS615
 PCIe Controller


On Mon, 10 Mar 2025 14:56:10 +0800, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add dedicated schema for the PCIe controllers found on QCS615.
> Due to qcs615's clock-names do not match any of the existing
> dt-bindings, a new compatible for qcs615 is needed.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../bindings/pci/qcom,qcs615-pcie.yaml        | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,qcs615-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/pci/qcom,qcs615-pcie.example.dts:58.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/pci/qcom,qcs615-pcie.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1511: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250310065613.151598-2-quic_ziyuzhan@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


