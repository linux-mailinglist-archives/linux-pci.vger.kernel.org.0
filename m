Return-Path: <linux-pci+bounces-34489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D9B30331
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 21:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81851CC1ACE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9600D2DFA2A;
	Thu, 21 Aug 2025 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEsgulqW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EF2C21EC;
	Thu, 21 Aug 2025 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805724; cv=none; b=b2klY7RHNB4FbLp/yFlteiE7+7qDumdv4hVgWToH5exxPLB7/a4lZk7GeOZpNC1bDkGzqXdoHExU6KW734ayU82mqNtahvbJeGisqRgoUXB71Rb/zLKnEAvCgZnKarhSWKBAESpjgWjJj1LbQYg6gdEj2J+GYE1I3mbaQdSnTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805724; c=relaxed/simple;
	bh=WEIIKeLrop4poqHTNKV2qrFN5V55F44pNdz+Gf7fIfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME4NT9O3ZiIxA1TSCm6Y2dpaN3Br13tCT3ddx6d1X1MwGAgau/gM6HhJ5/BShU6NcNmHPs34z1CMhL3oBFzgwQb/GVEs69qle09/w4q4HVBZ36g2tt+5kEn4v8X0zjCEdy5akjroB02vV9KQ7GKyTLWST3kMPzO2MtxBAD2ar6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEsgulqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAD8C4CEEB;
	Thu, 21 Aug 2025 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755805723;
	bh=WEIIKeLrop4poqHTNKV2qrFN5V55F44pNdz+Gf7fIfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEsgulqWjTPKiElNvYm/ryWR1n55vykIkBV3hLHpuxBVOngtQxXjss1YX/9CQZTuR
	 +NVgjS5P4U5z54A1h8AkASFKymPTRoj2CjUtTsZmCrhhn2vc62qMpoIfKMoWNlIb6a
	 iaaXgfRtEFV5QY+Cov9+IrBB8Ytovl0sMjLXfHRJuX9hnG56c0QENCQ+o5diIvFqyQ
	 AsPU9swFD6+Z9o1TNIMEoVH9wo+mdLGg3S06B7yXscu/CJa/ak1dvT4oPePcqEk6MN
	 EjFZoyHnWrHFEGqGReqPn1ynU5B5g2uBqwY0vnnouffpn/z3wtysM7C8B+VfRYjd/q
	 pVWtM/QF0OHgQ==
Date: Thu, 21 Aug 2025 14:48:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org, qiang.yu@oss.qualcomm.com
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Message-ID: <175580571576.471370.10486560769596957109.robh@kernel.org>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
 <20250821-glymur_pcie5-v2-2-cd516784ef20@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-glymur_pcie5-v2-2-cd516784ef20@oss.qualcomm.com>


On Thu, 21 Aug 2025 02:44:29 -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
> controller present on the X1E80100 platform. So document the PCIe
> controllers found on Glymur and use the X1E80100 compatible string as a
> fallback in the schema.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring (Arm) <robh@kernel.org>




