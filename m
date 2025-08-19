Return-Path: <linux-pci+bounces-34326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83869B2CD1A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 21:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 796A44E4B19
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E233CEB9;
	Tue, 19 Aug 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="podfsgBj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A432FC869;
	Tue, 19 Aug 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632534; cv=none; b=f6HAtf+CD4Y+2H2noOtx1cuPWdbqUuFTENdfCs9qG6389zacegl0QZ+Yvi0AdvUPzO7J/x2tMSYSf2tsSLjggVuEJmEgUWRE/+uHtBh0H8tUC1s6d/kakW0O7bl2CxUPQB5i1y7+Crg5bfrrVxdgwekDOxCcxE8tcYDYTeRiPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632534; c=relaxed/simple;
	bh=G9mv2RQpR3w2FU/L5T3lV1QBkI1hXSk14gFndmYnh+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UENpjdKfO0aCUnm/0DrCYlzzbc3dfakwyV0+ne5oQBmONxfNoelxOCo3+2SdI4lhkQSjuXf6Tzb4txocq+NHxDYQluD84h/dhuPTjGoNbfv1fwClUHYshvx/4711L3veHJCHtd7btoppl6ib6XeZ9/g5bli+kkvGFFPWlhXAiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=podfsgBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0DBC4CEF1;
	Tue, 19 Aug 2025 19:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755632534;
	bh=G9mv2RQpR3w2FU/L5T3lV1QBkI1hXSk14gFndmYnh+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=podfsgBjTTBfDfPBRlNExhLOv83frAjtsb5SIIcmqb2DThGhsjzTs8iWGpP9yyC6X
	 BD8UVJH5G8Cwvbn9p1F06Hy1SJDZR6uD/igitH+agMzzz9JpUABILL90U8ivh45XLD
	 OtojOKXh539zAKfgnq//uW6xF7Pv8y3OQI7m2MM4ZeTr2LcQeOI6lUqJNoaVIPG4tX
	 mpp7YO6XHZfmX5thJCSuITeLDoqN6BJtfGgTvzADRyus1PxZ488+zOcpZzDaHLHrnp
	 y04QoQZueS7HAMWMSVsclNPBSF3UCSJTu6w5dXep5PdU3lHsXFzCMykl+uyEelQqqe
	 E2cBrH0YVN5Uw==
Date: Tue, 19 Aug 2025 14:42:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Message-ID: <175563253013.1213233.1800125828083070871.robh@kernel.org>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
 <20250819-glymur_pcie5-v1-1-2ea09f83cbb0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-glymur_pcie5-v1-1-2ea09f83cbb0@oss.qualcomm.com>


On Tue, 19 Aug 2025 02:52:05 -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
> separate compatible.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


