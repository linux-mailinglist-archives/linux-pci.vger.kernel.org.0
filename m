Return-Path: <linux-pci+bounces-18579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A989F4515
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 08:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AA0188857F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A718D63A;
	Tue, 17 Dec 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8ZQlRnZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BD189F42;
	Tue, 17 Dec 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420457; cv=none; b=S1d8KMfgCJecieRXXmpZs4iQ+dROs/W+dxliZ/zS8Xdpz8bM3K9h8f+tmWe2piQchCyieuRsfdlfsGljIIutGInqU0UrksBwOl3I0GVh4mppjYq0lZE5E0IPRDuiA9hvVY6iFpp3i3WlIh8tZbNm2bB6clrl0gR7q/tPpi7/8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420457; c=relaxed/simple;
	bh=E/Ox3kudr//gds5CCkXEvKZN4F2VPAOGkX7l6mnxOOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTdN79Z2ayjVk+f+9535YyRhu2ewlFtyVITjhMnLLk4YkmS3iEGogGDg7rffzU5xxO3+sv7vwxsrCfLHpVL2RmVatr6mzonBu///ShaTpgaHy+ThIpOFV0YF00y0snGvH8vj28tO5vZ8ORCKvmnhNo+pQNzY6o9DRzPWjuUVoUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8ZQlRnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76026C4CED3;
	Tue, 17 Dec 2024 07:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734420457;
	bh=E/Ox3kudr//gds5CCkXEvKZN4F2VPAOGkX7l6mnxOOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8ZQlRnZJITWtv7Nv//BDvpDhrjU/74eSXmUNJOZffUsOIYx51Ib2GRbjN82QaSXj
	 WW8U1PR7gLpqS88fX03C0+F7KegOUljHRgIIIMn+Ax7DIihhBcb6pthzGLQYwzgvdR
	 rbVgYwQPdvSWfD6GNM5JyRU/8iPYvqpgkqf9m69ZSfEQdwkOacM6lTtnWU88cA5xY0
	 wBuKOtwyG6brhdZ2JvUs9JSNINRumimHmV903Cz1FnwrYRgFz9rgBZfs9CXwcmze00
	 ptFRPLf8zIYGomQPMqyC2RM2IFzIKZnCDFR2Kio8g3eOvLcWxNxiS3xYJThJK61pWV
	 4cenV94mXsnIg==
Date: Tue, 17 Dec 2024 08:27:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH 2/4] dt-bindings: phy: qcom,ipq8074-qmp-pcie: Document
 the IPQ5424 QMP PCIe PHYs
Message-ID: <lbzoom3xyareorikzgdcroiysgewh5z6r3pnkkjdoxcyogeyc5@pjyeldrte4jb>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-3-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213134950.234946-3-quic_mmanikan@quicinc.com>

On Fri, Dec 13, 2024 at 07:19:48PM +0530, Manikanta Mylavarapu wrote:
> Document the PCIe phy on the IPQ5424 platform using the
> IPQ9574 bindings as a fallback, since the PCIe phy on the
> IPQ5424 is similar to IPQ9574.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


