Return-Path: <linux-pci+bounces-14846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F71C9A36E2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 09:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343D21F216E1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 07:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1F185954;
	Fri, 18 Oct 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvOq0BRA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC0178389;
	Fri, 18 Oct 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235847; cv=none; b=SzzrnskZ/q7AxzbXd5L5F1A3zfmJhgg7xff2nwwJGivlLZSxvAbnVtmdF6RJtBDIYTqzJUIaW+aXFjS3bEAv6ji1qZ7mMNfdKJ7yxw2MNORQFSI+RrfFxMWSAUpo/rxqf/STEn5zxSuxQ7uKIxzhZDNLjPZp3q5LkB3sWp0QloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235847; c=relaxed/simple;
	bh=d6Hdr0l+aIz/hqEhprwd2fkSNZrGPpcjsb8Vyast0fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9RMTVidAx1kgU1ifxtaU/HPt3fu2T7WtiQ3YO/SUm7K9j3Mc1Hvm4y/acRwnfabBMeIApi3g/aMErDHEjA8aQAX+t71zBD9RFy9rHbyRUOC9F/NUFE/A9tcvWsHAUdU7XDSgFF4yn1Wcfytl/miXkE8RjBKh2wZLx6j/QpbKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvOq0BRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A482C4CEC3;
	Fri, 18 Oct 2024 07:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729235847;
	bh=d6Hdr0l+aIz/hqEhprwd2fkSNZrGPpcjsb8Vyast0fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvOq0BRAn7IlViVLtqCmmQdhEpelRHPn0a7BOhNk7QhrODbvOhvlr0YSoSmujmBjR
	 BSYCgYkBSfE5zp26XtgBe2TC5ZWk805LMW2vtEWon1dXeS4NHKCNeglm0eAoJVEKM3
	 EyronhG7Bw2hnW9dEsX8uwLtYxvy6x2GjHvsEkk472fmvkNZQTSYxuwz9iprSDOsL0
	 +2gTdCiSCfi5Wa2U72MfIC0jgi12UeAELcGProQDT2MoQLsSBF74p4XA80tGcD6qr0
	 oWtMh0WUQuh9GVsLnjHDtDKv0qSjPGEbuv9HtRMiOZfVuxcbBO6ZWFY3nOTg6FIpQ2
	 0LbyjVcVItiEA==
Date: Fri, 18 Oct 2024 09:17:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-sm8550: add SAR2130P
 compatible
Message-ID: <cslw7ag2ue3axcsiv2swm4sen52hcwaqmflw7eb6hvk44clwov@ngi7rkfv5gdz>
References: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>

On Thu, Oct 17, 2024 at 09:04:47PM +0300, Dmitry Baryshkov wrote:
> On the Qualcomm SAR2130P platform the PCIe host is compatible with the
> DWC controller present on the SM8550 platorm, just using one additional
> clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


