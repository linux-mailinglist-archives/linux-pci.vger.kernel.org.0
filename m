Return-Path: <linux-pci+bounces-34738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA978B358E3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 11:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64F8170132
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16A12FB97D;
	Tue, 26 Aug 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqDrtAyO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217229ACDB;
	Tue, 26 Aug 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200527; cv=none; b=nvHR6NyUgfuadkO1p8GEvtqlJUGCXKVEILpps0yKAhnBC4y053Pc8Pjt7T2DWVAjeopTOB2GQ/5x/pq1y+WvebEuUpM50ZJxpxJ4Y0S/r3+W69Dk6Vlc6SAYgZ7trwv1EeSZ2BLBoHBvCuIDur5S2n0Mqmv2b/oDyL+qM6DBeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200527; c=relaxed/simple;
	bh=FRhK9KHMFCQsZHQ2MZAeoYpx+OUA1J13ZSCRsY94yLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=km9kwUi8Fv8vn9bvGWONrksIRSH/prJTqRonQXxkaLirA0tP5wGf66j86Okky9u9VUjMJEvcqf6oiBdtYd7gWqUGAmlt/3oraMbTBFeUUv8ha4gG8uDTF6U9yXFZDErlKRJaTE20BqEZFLuznR1hqe9zIZyHjVKP7Xs/Skrll1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqDrtAyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F58BC4CEF1;
	Tue, 26 Aug 2025 09:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200527;
	bh=FRhK9KHMFCQsZHQ2MZAeoYpx+OUA1J13ZSCRsY94yLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqDrtAyOHb75rEdv5GCVbEcMswoAkY9VQEWETHD+EjNqsmh5AgdSon4mMMJmYd3iM
	 trpMaxc9MCelOlEoK9gjHdcpC+QTbfuHpfbko1ZgVxoJ237neUqcQpxQWikost49Hw
	 +ar6K+JnCPe4YVF5BjTnstmEa1ZDB8RodczgXbfXlW1IzeFXLiMg2/uzsFQLykHvtc
	 RATgoDC2dElCARBEYOdX68lzyFx104NYt6PF5VQcolgpM+1CQ67VHbywL3frgAp6a5
	 jeRsDn4hKL4P9CInyWELCNYimtvPBLHgJig4tX76VrUH03lH4gMGZtGo0pgmBXSC9m
	 n7+Afr5+W8rpA==
Date: Tue, 26 Aug 2025 14:58:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v2 3/3] PCI: qcom: Restrict port parsing only to pci
 child nodes
Message-ID: <3ah45g7o3vaswanur7id3ypii3773scg3x46wrkxet3jywnyhi@l2za3z3su624>
References: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
 <20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com>
 <4583bf66-737d-4029-8f14-ce6d6a75def6@kernel.org>
 <0c732ac6-2d1a-4341-94d4-dc6734bfb959@kernel.org>
 <e2d23d22-de22-47ee-b715-e7b6c36976b1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2d23d22-de22-47ee-b715-e7b6c36976b1@oss.qualcomm.com>

On Tue, Aug 26, 2025 at 02:33:44PM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 8/26/2025 2:02 PM, Krzysztof Kozlowski wrote:
> > On 26/08/2025 10:27, Krzysztof Kozlowski wrote:
> > > On 26/08/2025 07:18, Krishna Chaitanya Chundru wrote:
> > > > The qcom_pcie_parse_ports() function currently iterates over all available
> > > > child nodes of the PCIe controller's device tree node. This can lead to
> > > > attempts to parse unrelated nodes like OPP nodes, resulting in unnecessary
> > > > errors or misconfiguration.
> > > > 
> > > > Restrict the parsing logic to only consider child nodes named "pcie" or
> > > > "pci", which are the expected node names for PCIe ports.
> > > > 
> > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..5dbdb69fbdd1b9b78a3ebba3cd50d78168f2d595 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -1740,6 +1740,8 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
> > > >   	int ret = -ENOENT;
> > > >   	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > > > +		if (!(of_node_name_eq(of_port, "pcie") || of_node_name_eq(of_port, "pci")))
> > > 
> > > 
> > > Huh? Where is this ABI documented?
> > 
> > I see it actually might be documented, but you did not mention it at
> > all. I doubt you even checked.
> > 
> > Please reference exactly where is the ABI, so reviewing will be easier.
> > 
> > I still think though that it is wrong - we don't want device node names
> > to be the ABI if we already have compatibles and the children here
> > should have them, right?
> I intended to check for device_type to be pci, my mistake I went with
> the node name, I will update the patch with this logic
> 
> if (!of_node_is_type(np, "pci"))
> 	continue
> 

Yes, we can rely on it as it is a required property for PCI bridge nodes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

