Return-Path: <linux-pci+bounces-34488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4DB3032F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 21:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B145A2930
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C862C21EC;
	Thu, 21 Aug 2025 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPeL8Rov"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA01EA65;
	Thu, 21 Aug 2025 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805709; cv=none; b=FDPcRH0+CMIhFjFScdzdbhc7XbXukRUoLeJ7tDu6FOBJD112cLM4ebTtTUI7wnuNqZBkcUcmfvc+7MBAcWMt02lthtIEDN1ZV5YmA/IwJ5HX0JM5WC9k/9a57mQG7ks/enYozQk2HNWUxOeXTPoHaDHQkVkbb9rjugP6svQYmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805709; c=relaxed/simple;
	bh=Xhpi152UPPYepOeU8j1aeDsj3ylJjhTecg57Bmk368c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS/9ZOqufJtDN4wQOEilLJrQLCORqvquSBCckgsM6tNDEJxy2m4AjfqUQm8vRoCJv9oTDTR6dxFnRhUmH1KXTNuMZmJWvEP1szzWI8HVkTU27SM4ayKuJfbv4LC3w2U6OxP7fE/tNSgkJIQsAQLJy8DpoawS26LUmFjMjfP/UxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPeL8Rov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86587C4CEEB;
	Thu, 21 Aug 2025 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755805708;
	bh=Xhpi152UPPYepOeU8j1aeDsj3ylJjhTecg57Bmk368c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPeL8Rov3Iktdy05myWKuavwcXunCI9pAtp0qtEq6RW9516Eir+o7hfkREOVqthk3
	 Qdy0kkDzDBro+I4FedReKYbyfi11N/znOSAdq9CK4Eg6Z2ncAnuRoZaW5HD26VdWmF
	 4x8f9b6RHGDa70I002KCW+vT4eEBsRep1ozZjv8QhYYeTkwglTsHd7aPstJCrz82LV
	 a6YyrfqgclCbnNcYgmU9jbfpRtFu1mwTrm+G5KjUCQ488RwQCDVXqJV5G28TE+LLaR
	 1lcWpOowQqJSuBysUQXNjy5sq9ETmczj/hWlh7klb64Kp1oNCdRHWnDxhfS2hc5mIH
	 2ggd3Tic9q/sw==
Date: Thu, 21 Aug 2025 14:48:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>, qiang.yu@oss.qualcomm.com,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Message-ID: <175580569944.470925.12622150205137529754.robh@kernel.org>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
 <20250821-glymur_pcie5-v2-1-cd516784ef20@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-glymur_pcie5-v2-1-cd516784ef20@oss.qualcomm.com>


On Thu, 21 Aug 2025 02:44:28 -0700, Wenbin Yao wrote:
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


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring (Arm) <robh@kernel.org>




