Return-Path: <linux-pci+bounces-2730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63F8409C9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB54B25316
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A06153502;
	Mon, 29 Jan 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRbKfSku"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C71534F9;
	Mon, 29 Jan 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541760; cv=none; b=XE7Cz3Ys6K7f3rgDWI5T3kACC5xv7tg7esdXfgaN2PkCd/uXO8MPB598zZoD1pIW832Ige5y4DgDwqYVa7VNKhMmltLD6MM2t26ysqQlElEYv9rDyEmfHwR49bbpTd4Gr2zGCNzx9bcYTG4FlIjjzzP/x3c69SEYzfaMxKvnmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541760; c=relaxed/simple;
	bh=PwtdHd6TTxvfq+eNHqbTi7xBH6Bo6//TvTCbfsc9QzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7LTyb9AbTBEPz79RDI3EptFLQR9zu4sK+p7St039cCP81h+PI8CNVQSgUI1yWIslo5pV0+Na5tAsLX0VO0udGpchFhsB/cbKFvearu9i0vdkM5WEHGDjKR5wVzetizvsYBHg5ak/YkpAjELEmcjdI0cufwtkg4rB98lgBdrHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRbKfSku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5A6C433F1;
	Mon, 29 Jan 2024 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706541759;
	bh=PwtdHd6TTxvfq+eNHqbTi7xBH6Bo6//TvTCbfsc9QzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRbKfSkuE75/mZnHPZ9Tuk4RJSWbk7hvtLSz2CBoJmGEeiMa1THXQVR80Wn9AvN0X
	 JCowaRk/FXkRg+ipYp2Ou9qKg6aenMego1EtfmRxxevWrQ0pLZj5Ip53OP7ARbCgOC
	 R0mTFCgwNMVLxA44H2Y3g/PI3P+C9QptTIU4ojnhFBeGO4b5RAX9AIxqLFy+t3gjoy
	 CqoMbwIW0+BpxR69lGcIc3/EZvZdHaqbYrsCJwYfhtjnY259M4rZne0AWQBmtJOZbn
	 gTHA0dXL321Ze+lD+fccOBzyxBE0dcTGHJn6qmfB+/p8W4OQIBMNCLqZDWV05JVvWu
	 gKcFsUr6GBL1Q==
Date: Mon, 29 Jan 2024 20:52:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: PCI: qcom: Add interconnects path as
 required property
Message-ID: <20240129152220.GD22617@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-1-77bbf7d0cc37@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112-opp_support-v6-1-77bbf7d0cc37@quicinc.com>

On Fri, Jan 12, 2024 at 07:52:00PM +0530, Krishna chaitanya chundru wrote:
> Add the interconnects path as required property for sm8450 platform.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index eadba38171e1..bc28669f6fa0 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -777,6 +777,8 @@ allOf:
>                - qcom,pcie-sa8540p
>                - qcom,pcie-sa8775p
>                - qcom,pcie-sc8280xp
> +              - qcom,pcie-sm8450-pcie0
> +              - qcom,pcie-sm8450-pcie1
>      then:
>        required:
>          - interconnects
> 
> -- 
> 2.42.0
> 

-- 
மணிவண்ணன் சதாசிவம்

