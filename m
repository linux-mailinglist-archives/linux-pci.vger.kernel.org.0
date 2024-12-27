Return-Path: <linux-pci+bounces-19072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10479FD1C5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 09:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70288160F3D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69FD14D28C;
	Fri, 27 Dec 2024 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+SShp0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16BD2BAF7;
	Fri, 27 Dec 2024 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286654; cv=none; b=h8cZ4TmER/1Gl66hJUrq5mhuxbWCh/P6BRgcMQyB00gfKsuJ4xM+bfv5SMtzjzs+rubJIP9XpIYLEZy/N4j4xX6gTazNQJ3ncBbHKKw6H/m3gKOu/JuhRaYuYmH7kyN0Qj3RnVCqDPtcJTrCxKY6a+9YflnTcbxNOJhfePEeASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286654; c=relaxed/simple;
	bh=biCHUJ5+/8TVAXXt/3zdeR+eVLD02s5dFj+qLRU/u4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+YeRYhTMV6pXUvSy3S991+lokGgfDh3lDrmQbccVsLpDIKn4H5ck85Ye9c43jp9nw6VxCB2j2Tj98zV1Qmuq1qw1sQ5eTfxiGXfLpxpw5IOieRn+k2oRDrjpXXjPulLWzm60awIY69A6w4ySotweRMWmqqyheiHiVx6BqIbOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+SShp0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DD4C4CED0;
	Fri, 27 Dec 2024 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735286654;
	bh=biCHUJ5+/8TVAXXt/3zdeR+eVLD02s5dFj+qLRU/u4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+SShp0c8wwOpMs9hwz4VL+Rx6bWq5SN7auamJKsEb/6M3CmLkyVq9DWglwgTeApb
	 DG5e1B26DiUXIebY61Zn0KaZiMz10JbSSHRoM9vrhTkaR7pR2USQT8FRV29zNzDI6q
	 3WQRqNbOCpw35FH7y4mgQyVr+xKOsD3wcenaHKDR8veBX8RQUMhGlYlyMN6A6he+uD
	 5Mt2zy9fzWiVm4UUqVkcMn6bgNKLyks6+b4rVgvERcmvbEmyfVFAgYeHt66eMebDm1
	 lKiAdAmYbUm0y/9VznQu3a1I4OqDLGr8ojZCoSYswxa2o+DodbwvJKrSn0kuB67v/V
	 rAXt/Lz9Lmq7Q==
Date: Fri, 27 Dec 2024 09:04:10 +0100
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
Message-ID: <u6jrvxkp3hmodbly7kud4uykkxjza7qehkqifrfjjztzkw37et@qnp7uueafvwu>
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
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2

You need to list and describe the items instead.

> +
> +  resets:
> +    maxItems: 3

You need to list and describe the items instead.

Best regards,
Krzysztof


