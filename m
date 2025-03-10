Return-Path: <linux-pci+bounces-23296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5730CA58FB6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 10:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA7C188FDAD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B85C22333B;
	Mon, 10 Mar 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpR+Y2Lt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B640EAC7;
	Mon, 10 Mar 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599114; cv=none; b=hK9bTIeGCUuqdHoBuSelnnTNshrn97QK1oaHerG3skEQOBRLz00ayRpg0QUrAzitJ0GyopLzEwqgbtET3G7116j1y+4ubL1GcM96RdEJc4jz0QNdeqcClYVTgI/dUIhGP+iZg+MOWdVEnFPPmjQbEi/SEBy9Op1ojJxNzejQf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599114; c=relaxed/simple;
	bh=Iz8IZsYghrJMpQWOE7HLH833OewDZeMFRdw2jLto4lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQtjoMslEQXNShKtK8B0nc6gcTHjrE3tN9lioFwZJZlP7jlf7kz1xjTzLmxTSVoAd/fIYseMOi7IQTpUDWSq7n+/x7Pm9kKhYGdH7c8ycUbd/6gSLVa52y9MveRWi4oO5PnZCxKGQR2sKLejBlMqu4N2K3pgqBMPW7qYoBs1e/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpR+Y2Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22A3C4CEE5;
	Mon, 10 Mar 2025 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741599113;
	bh=Iz8IZsYghrJMpQWOE7HLH833OewDZeMFRdw2jLto4lY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpR+Y2LtdYEw57ZtfSRH7/eXAUwpNUKT7IIQzhC2CCz7+9CCZRVVSztv/WLPJMo8B
	 8aEjM+9OVnnTY6exKNMyVPJcEQ6vUwmdSJVhniOEg5oXwzBGb9hObVLJXrztFttIOw
	 IiIKSuLnxRVSV11wCWDRnwT1/DkzixqF4bPL1KJWuCFrXd69iLVO0k7qbXx6v4RC9y
	 H14E7FjjKCdmVgbpW5q7H5kQEni09amJLpCzvpl/CFcEsvMKux/3TB30/tfUS5mpQ8
	 ZvTaw3Lj68U7shAz1GZlTKh88foRs59CKURuG0+JSNKulqZsz1+jK/Hz1QUfT7Z7hX
	 H4Ab1Lfo1fQTA==
Date: Mon, 10 Mar 2025 10:31:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, quic_vpernami@quicinc.com, 
	mmareddy@quicinc.com
Subject: Re: [PATCH v5 2/7] dt-bindings: PCI: qcom,pcie-sc7280: Make elbi
 register as an optional
Message-ID: <20250310-rainbow-ebony-panda-cd0ad3@krzk-bin>
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
 <20250309-ecam_v4-v5-2-8eff4b59790d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309-ecam_v4-v5-2-8eff4b59790d@oss.qualcomm.com>

On Sun, Mar 09, 2025 at 11:15:24AM +0530, Krishna Chaitanya Chundru wrote:
> ELBI regitsers are optional registers and not been using in this

What does it mean "optional"? Hardware can miss them or they can be
restricted by firmware? Which board has such issue?

Your commit must explain this.

> platform. Having this register as required is not allowing to enable
> ECAM feature of the PCIe cleanly. ECAM feature needs to do single
> remap of entire 256MB which includes DBI and ELBI. Having optional
> ELBI registers in the devicetree and binding is causing resorce
> conflicts when enabling ECAM feature.

I don't think it is possible that register in binding causes anything.
Linux does not parse the binding doc. You are changing bindings based on
some issues in your drivers.

Fix your drivers.


> 
> So, make ELBI registers as optional one.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> index 76cb9fbfd476..326059a59b61 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> @@ -19,17 +19,17 @@ properties:
>      const: qcom,pcie-sc7280
>  
>    reg:
> -    minItems: 5
> +    minItems: 4
>      maxItems: 6
>  
>    reg-names:
> -    minItems: 5
> +    minItems: 4
>      items:
>        - const: parf # Qualcomm specific registers
>        - const: dbi # DesignWare PCIe registers
> -      - const: elbi # External local bus interface registers
>        - const: atu # ATU address space
>        - const: config # PCIe configuration space
> +      - const: elbi # External local bus interface registers

NAK, ABI break based on issues on drivers. Fix your drivers.

Best regards,
Krzysztof


