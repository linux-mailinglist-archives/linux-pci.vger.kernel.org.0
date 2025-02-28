Return-Path: <linux-pci+bounces-22674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF4CA4A4AE
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4013BB3D7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833771CD213;
	Fri, 28 Feb 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsnA6pBw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B051CAA9E;
	Fri, 28 Feb 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777256; cv=none; b=Qt1aVpcmIzJdoGZmW+dWzkdTbuz5sCzsWVU+WSFa/7Gj6ZXdpGCo5teYOltoVDNKGkyURnMpbY05hzyJp494F5Ym5IG1OboMdYe2mjt0LHvs9/4CJbN6z6lWx2hczdNZ/FU4COmEiy/Ip3l+xsZEX7iWjKIwba9HhXdXKnB8O7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777256; c=relaxed/simple;
	bh=04/AthWwfqna/0RJKFcLfViS1068GCgIgD9S6ZV4wpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHKShtm0TDEfHSKBlBJKBTVKC/p+HdhHOUqlZ7+O5DkL8SbpxvYZwO1HwXVr3rzK1XklaRGniWIes2JjpkHFLDUoyckibP1sSyXdQqcTRibU2EzfNhJk8ecnE+aznxP5Hurp1zvXFWf1OZtRecefu80C1H7O3c2LJRtipZnigV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsnA6pBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D89C4CED6;
	Fri, 28 Feb 2025 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777256;
	bh=04/AthWwfqna/0RJKFcLfViS1068GCgIgD9S6ZV4wpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsnA6pBwWnZ26wyHbiO4L8vKDXfyTUMTKMYiGaZYVHo+c4iSIxyjBhTfSItkvOwYb
	 wIyPfBPa67jXHzdpxr27+rWSo1Kv6RPFDF6ynWNMkioA1qDL1D1E/P00tlaX3NABZQ
	 8/zcBvwwdrNXRv22a3kT7lOO48jvZJZgdx5weC3xbU7y0YsNHKXsRKnWacZVyRCYGv
	 HiOcOMq/RL6nhmEOxk1AW4+BiB7smaDl7sXY6QfRd/ant/tbwnMMN88PklNnadTE6/
	 Qt7SlilIVFZJetyOH8xWIi8VM/YFRZZVmI2Jnh6NH1Ts92olOx9/vNPwkzgd1N4B+t
	 dy0IaEq3A2HNQ==
Date: Fri, 28 Feb 2025 15:14:14 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 18/23] dt-bindings: PCI: qcom: Allow IPQ6018 to use 8 MSI
 and one 'global' interrupt
Message-ID: <174077725397.3729849.15696291364201005825.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-18-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-18-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:11:00 +0530, Manivannan Sadhasivam wrote:
> IPQ6018 has 8 MSI SPI and one 'global' interrupt.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


