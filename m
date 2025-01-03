Return-Path: <linux-pci+bounces-19209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FE3A00549
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802493A3940
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA821CBA18;
	Fri,  3 Jan 2025 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el1WDEGF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970551C9DCB;
	Fri,  3 Jan 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890319; cv=none; b=JP2w93k9Dm4QcRC/Kd7SDCrpJfME14y6Nm59bXVdFmuygIKcskQ0XzYx6LrGVBjaGSWq3tEkAAry2sEEDOVBIrKXhtiNxelPEMvuOXGkAkjg3LZeIrDNM72go0ReO9YpwUuYWmTcWClpQ1lE4UpbnXIOppiYQbWIsaaDXtlR1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890319; c=relaxed/simple;
	bh=aMmPzVen99cj6Sv2ngxr71M0gY35RED8D5Y2iY5FFaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReCVGQwJVlOHI3QE5fVOWMYmyhU6/j0QZON4qbQKESCX7DuXdkLGRkz6Qz87soe0EQJtKMQ+MPGxLJ4iyNC5Ouykh+UOoLaX4isz4ku50JqZdah/pGxsExS5P4CUkq/ocyvm0vbjSIYhxUr9ZnhHci9SWfVomjfIwq+LwjyK/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el1WDEGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D881C4CECE;
	Fri,  3 Jan 2025 07:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735890318;
	bh=aMmPzVen99cj6Sv2ngxr71M0gY35RED8D5Y2iY5FFaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=el1WDEGFF6V8HbGVbRFtOWv6xz7bue4TdfvCuEmgxJwO9ZlyVOMHQ0nNyMC+ETmHo
	 vgl+LhYbltmGtC/4AoRyPcIMVte0dEmsAmBB4hvKFDFRoQnFdeSzzRdnYaPBLOJgNJ
	 PBmog2d+bwiYR8HL3TqvJtTDpTcCr1PVgKXUeg4r1qdnkTkIzohIVuLNaxX61C3mSf
	 jYCYJOPTKuQepq+B576JLvzjXjzacNbOXRLj9y7ZF7QDBG10jkR0U9yPv6wQglMzyp
	 bByJNmA4eQMPQEmsmUGvs8viMREURruV1SMFNrqlQdUPiTQKWGRWwz1TBF8Z4h8tTh
	 b0cZnnbGftWnQ==
Date: Fri, 3 Jan 2025 08:45:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 3/5] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
Message-ID: <4hwclzotaowog6rzfejiixqvvg7iumg4udbvq3h72mmh42dbki@piphsf37vhpv>
References: <20250102113019.1347068-1-quic_varada@quicinc.com>
 <20250102113019.1347068-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250102113019.1347068-4-quic_varada@quicinc.com>

On Thu, Jan 02, 2025 at 05:00:17PM +0530, Varadarajan Narayanan wrote:
> Document the PCIe controller on IPQ5332 platform.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts

What? How this is related to commit msg?

> 
> v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
>     * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
>       to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
>       and dt_binding_check flag errors.
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index bd87f6b49d68..9f37eca1ce0d 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -26,7 +26,6 @@ properties:
>            - qcom,pcie-ipq8064-v2
>            - qcom,pcie-ipq8074
>            - qcom,pcie-ipq8074-gen3
> -          - qcom,pcie-ipq9574

I don't understand this change at all and your commit msg explains
here nothing.

Best regards,
Krzysztof


