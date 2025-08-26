Return-Path: <linux-pci+bounces-34740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AF4B359FF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83601B28111
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4029D292;
	Tue, 26 Aug 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXbW7b99"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5757729D283;
	Tue, 26 Aug 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203623; cv=none; b=BAcEllD7G7ZTL4hCj1Xa5beKRS+vwtHVkDtBy3JeBAiI6+MgKhV2OarH6c+jg7ctNRaEXmxTICIAGBFmnk9wWZe4V+DtGfXBL6OJnezxD0H7xes+JYA5PLff7azDexv0tubgC+0S31PdRVdOg5fnDnR8s+Wr2YvtRWvbbt4RWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203623; c=relaxed/simple;
	bh=SQj19bRsv81q+ZnWFUSYxGQesSOr+XBdXk7u/2A7UuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWbP3v1Fm7S7XBwB5RQ38wlsINIT2zUcETe+nmnP13auQPPYRgPoayY+17hZ5k/lUsnI6UjVG/6ie6iQykhyHewfGLk0Eyk5ziApq63+RtgPy/qZRYjynmuaxeFjbQXyVlGwfKSL32VUkEfF7sE7HrEZftpVQfvaeW9moMAqbWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXbW7b99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DEEC4CEF1;
	Tue, 26 Aug 2025 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756203622;
	bh=SQj19bRsv81q+ZnWFUSYxGQesSOr+XBdXk7u/2A7UuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXbW7b99egZTEWGT1MOnJm6owvmmBX7wjKJ68UPHQ4t+T88ZRP3BYOsTChItPpnv6
	 Xd322TOoLmSp5R3HCzBO0hjvAl9YH3eJzCt4+qzYyIbzAwMRc7VgtjggQPqQ+LbGJ3
	 cW/GWOM40AhYiyVNllhWNaNPIGXm6pbe1LNtLnt8fBo5jEpXNpGk4D9PezQ5IUGIw3
	 BWyUhnubNlPqpVIq7wPpcPas5Wv9dnZKqcXY0D5kxBUERYBfr1D0FtUq4aGQr2oH7c
	 PXMrlac5qeGwmiS+llwIWBzryBN9+sX3oQGHgthnLMEmAnM+Vvrz8ENzV9gObaSFSA
	 DPR/cWj27bSiA==
Date: Tue, 26 Aug 2025 15:50:07 +0530
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
Message-ID: <ei7qtgj7jegwaafrjdccoaz3tg7klnms4dyiqdumwxdvnucp4c@euose4y6vkqg>
References: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
 <20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com>
 <rurdrz3buvb7paqgjjr7ethzvaeyvylezexcwshpj73xf7yeec@i52bla6r5tx7>
 <b7529529-9677-4713-920f-bf36863459ca@kernel.org>
 <p6yacm6hkhp4rgtl2xn677kek24ksczvtuersxnou4kmxmp7go@tmoy7gn4hrhx>
 <dfd9cc8b-8103-4fa9-8b3b-c31ae7c4970a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfd9cc8b-8103-4fa9-8b3b-c31ae7c4970a@kernel.org>

On Tue, Aug 26, 2025 at 11:29:37AM GMT, Krzysztof Kozlowski wrote:
> On 26/08/2025 11:26, Manivannan Sadhasivam wrote:
> > On Tue, Aug 26, 2025 at 10:28:51AM GMT, Krzysztof Kozlowski wrote:
> >> On 26/08/2025 08:17, Manivannan Sadhasivam wrote:
> >>> On Tue, Aug 26, 2025 at 10:48:19AM GMT, Krishna Chaitanya Chundru wrote:
> >>>> The qcom_pcie_parse_ports() function currently iterates over all available
> >>>> child nodes of the PCIe controller's device tree node. This can lead to
> >>>> attempts to parse unrelated nodes like OPP nodes, resulting in unnecessary
> >>>> errors or misconfiguration.
> >>>>
> >>>
> >>> What errors? Errors you are seeing on your setup or you envision?
> >>>
> >>>> Restrict the parsing logic to only consider child nodes named "pcie" or
> >>>> "pci", which are the expected node names for PCIe ports.
> >>>>
> >>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >>>
> >>> Since this is a fix, 'Fixes' tag is needed.
> >>>
> >>>> ---
> >>>>  drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >>>> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..5dbdb69fbdd1b9b78a3ebba3cd50d78168f2d595 100644
> >>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >>>> @@ -1740,6 +1740,8 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
> >>>>  	int ret = -ENOENT;
> >>>>  
> >>>>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> >>>> +		if (!(of_node_name_eq(of_port, "pcie") || of_node_name_eq(of_port, "pci")))
> >>>
> >>> May I know which platform has 'pci' as the node name for the bridge node? AFAIK,
> >>> all platforms defining bridge nodes have 'pcie' as the node name.
> >>
> >> It does not matter. If I name my node name as "pc" it stops working?
> >>
> >> No, Qualcomm cannot introduce such hidden ABI.
> > 
> > There is no hidden ABI that Qcom is introducing. We are just trying to reuse the
> > standard node names documented in the devicetree spec. So you are saying that
> > we should not rely on it even though it is documented? Maybe because, the dt
> > tooling is not yet screaming if people put non-standard names in DT?
> > 
> 
> If it is documented, you can use it, but I doubted first the author even
> checked that. Otherwise commit message would say that.
> 
> As I mentioned in other response, I still find it discouraged pattern if
> you have (and you do have!) compatibles.
> 

Compatibles for the PCI bridges are not mandatory, so we cannot use it. But
'device_type' is and Krishna is going to use that instead.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

