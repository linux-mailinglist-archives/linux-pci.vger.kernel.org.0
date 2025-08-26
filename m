Return-Path: <linux-pci+bounces-34737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5EEB358CF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 11:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5291683D5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DD30748A;
	Tue, 26 Aug 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyoB2UhG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED603074AA;
	Tue, 26 Aug 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200381; cv=none; b=FPFMSR55J7gQMy1hL5CebwbszV4hlQKvkiP2vPN8s74a3IfxQR5CgsS6o5Qy+dxXLhP2o/rJE2/QEYjNU/0z62JXnppeJOJPqC2ggcXGkSETj9KhK360uren+luYaNrnE6RlhbeT58v7ABGgUQJAjDcXnfVpx6GYyzeyDgAyNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200381; c=relaxed/simple;
	bh=ZDQPouyh0tXwE4FaqtVS1nMSLMBuymRC8yoZpy2COSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP/56rzwjwdOZ1zEvvL5rguxChkFSX9DNVxmoECPum+D4KjEc24wgCHQD0ovnN/B1RU0Ibh9bxBs4OTxNnOw+eazJBOfFdJWbefx46OCY8OtrSJyVeig6z58D5YSlhZREdRsRtAUdEvWhZ+cT/T+a7hQS0iR3EhS0V3UFFmN9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyoB2UhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1978C4CEF1;
	Tue, 26 Aug 2025 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200379;
	bh=ZDQPouyh0tXwE4FaqtVS1nMSLMBuymRC8yoZpy2COSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyoB2UhGzy+dXwciBnB51SUQYNWvcreEx7fJTGIDC4YYg6hUa7VBnSBqw+8bPkgL2
	 8jgtfUJ2pB9dDBGDVgY3nsoqtHvWGTkvGMO+LWTGkTNZ0rh8nTD8KGxccr+m3cqMYD
	 vsLD4jl5j7S4UDN4UY9o04Z1YjXXapJizgnDXWc/Vq1VeNh+1o+s2aV+7hy9dwc0T+
	 RwHf6MuLwRLhwUmswAGeCkX3Yeb3aG8WTPqVhTMA1btcs97tZ7VJbwoEWgx1JpHkxB
	 EsL34mPq/WAvdEnGA2kktNICHam7zmNy5cqqP4tjynOXFNADFVPCAX0lBlrtUqTDEQ
	 9+gzhcMb5tERQ==
Date: Tue, 26 Aug 2025 14:56:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com
Subject: Re: [PATCH v2 3/3] PCI: qcom: Restrict port parsing only to pci
 child nodes
Message-ID: <p6yacm6hkhp4rgtl2xn677kek24ksczvtuersxnou4kmxmp7go@tmoy7gn4hrhx>
References: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
 <20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com>
 <rurdrz3buvb7paqgjjr7ethzvaeyvylezexcwshpj73xf7yeec@i52bla6r5tx7>
 <b7529529-9677-4713-920f-bf36863459ca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7529529-9677-4713-920f-bf36863459ca@kernel.org>

On Tue, Aug 26, 2025 at 10:28:51AM GMT, Krzysztof Kozlowski wrote:
> On 26/08/2025 08:17, Manivannan Sadhasivam wrote:
> > On Tue, Aug 26, 2025 at 10:48:19AM GMT, Krishna Chaitanya Chundru wrote:
> >> The qcom_pcie_parse_ports() function currently iterates over all available
> >> child nodes of the PCIe controller's device tree node. This can lead to
> >> attempts to parse unrelated nodes like OPP nodes, resulting in unnecessary
> >> errors or misconfiguration.
> >>
> > 
> > What errors? Errors you are seeing on your setup or you envision?
> > 
> >> Restrict the parsing logic to only consider child nodes named "pcie" or
> >> "pci", which are the expected node names for PCIe ports.
> >>
> >> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > 
> > Since this is a fix, 'Fixes' tag is needed.
> > 
> >> ---
> >>  drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..5dbdb69fbdd1b9b78a3ebba3cd50d78168f2d595 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -1740,6 +1740,8 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
> >>  	int ret = -ENOENT;
> >>  
> >>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> >> +		if (!(of_node_name_eq(of_port, "pcie") || of_node_name_eq(of_port, "pci")))
> > 
> > May I know which platform has 'pci' as the node name for the bridge node? AFAIK,
> > all platforms defining bridge nodes have 'pcie' as the node name.
> 
> It does not matter. If I name my node name as "pc" it stops working?
> 
> No, Qualcomm cannot introduce such hidden ABI.

There is no hidden ABI that Qcom is introducing. We are just trying to reuse the
standard node names documented in the devicetree spec. So you are saying that
we should not rely on it even though it is documented? Maybe because, the dt
tooling is not yet screaming if people put non-standard names in DT?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

