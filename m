Return-Path: <linux-pci+bounces-19073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75FB9FD1CB
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 09:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48340160C70
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6C14D6E1;
	Fri, 27 Dec 2024 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL0qSBjL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5162BAF7;
	Fri, 27 Dec 2024 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286736; cv=none; b=YxMRzosbaedPn+0Qe9IQ6obcMfxz9nmbXLoFjdPP9v70lhGwlNjiyPShYDFRb+P1otpE8/WTlZEZwo/rF/9VrWgd1qcU/9smmkwvJt6K360iONU1MMlOLKZwlugGpsU2GZvj+yS1pLn7HtIhU60ho8L4DRCH3mEkHlqgsCJa3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286736; c=relaxed/simple;
	bh=zpeDIwumBH9adCAX9/ugP0JbjTLYj3GZUQ9OpTyGp5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZvCSyyTef1me5+O4U06VeHbqZ7eFDh/cu5ppHHCF0GZYuWR9PRDay+80qmac3ttrLeQj40TGu4ct6hE6fnMRBy+7lHLeU/MgOQYS5gcdo5RgxVEnNo52M4t+6TmCLZ7fF5lbtG95yEGUSUbZq/76oXXZakEAmOMGHG5+Hhmq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL0qSBjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4B7C4CED2;
	Fri, 27 Dec 2024 08:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735286736;
	bh=zpeDIwumBH9adCAX9/ugP0JbjTLYj3GZUQ9OpTyGp5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LL0qSBjL4xJNZ0ECZqV7DyXdbvQ2pRrhuTvltL1RudTqzEOOssvsXzkEDgZyUt0CZ
	 DW9DUSaE4RmYqpgz3CrSneCUjTxXy49fLTxL389Sa0eSpKg2QHj9yVtAcU7bfOzJyS
	 lScFGfITnndDJgWpkhHiLw66GZ+hHIyRleVnloNFwUEXW4wPqTiAK3+Y2MNueA5SZt
	 CqlZxaoCnVAbPR5+JwAkx8B1L8yvc9AE7vig2jQFbGcKcBk6YN8CwKtHKCUgnsTZcQ
	 MAxbGsg5vVJEvDSvnkT3QFcrXMy99LOQeV7XSg6Xwx2jL5jgXG/IMC36nPmXxaTkii
	 tBCydMJbX7yAQ==
Date: Fri, 27 Dec 2024 09:05:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 1/5] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Message-ID: <s2tdxcpmgvxhcne6go23p5qdwra37adl3igz6w37n6espbe77s@bc25jxnwxgt6>
References: <20241226102432.3193366-1-quic_varada@quicinc.com>
 <20241226102432.3193366-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241226102432.3193366-2-quic_varada@quicinc.com>

On Thu, Dec 26, 2024 at 03:54:28PM +0530, Varadarajan Narayanan wrote:
> +title: Qualcomm UNIPHY PCIe 28LP PHY
> +
> +maintainers:
> +  - Nitheesh Sekar <quic_nsekar@quicinc.com>
> +  - Varadarajan Narayanan <quic_varada@quicinc.com>
> +
> +description:
> +  PCIe and USB combo PHY found in Qualcomm IPQ5332 SoC
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5332-uniphy-gen3x1-pcie-phy
> +      - qcom,ipq5332-uniphy-gen3x2-pcie-phy


These do not look like separate devices. Why num-lanes property cannot
be used?

Best regards,
Krzysztof


