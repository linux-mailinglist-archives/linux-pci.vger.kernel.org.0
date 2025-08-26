Return-Path: <linux-pci+bounces-34714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0250B35404
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BCC202B20
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 06:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE8247283;
	Tue, 26 Aug 2025 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQzX4xdI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB219309C;
	Tue, 26 Aug 2025 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189093; cv=none; b=rpnLmZKdiBS3b49V84L5bJX2tayTH3kSf6Ul8gxL/2BTJJ3jrFAP2MUz8AFqJPDhhBVBjG4tfvib8MnDOJ3VclySmtVD8it+giyGpRxES7/GyQRwZP0I3IPG4j0yQbDmFQYTZ8+FdzsDhqxidxMgsKKXdl5blr2O38H7tl23LzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189093; c=relaxed/simple;
	bh=TufPpZh+5km23M/SOb+uejlv3zSfmFKXfTQaS89ZyJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqkf/qrpMBUB5mNtJkh8mdyokrWJMtFREpxxljLlBjVALIe4eKmLXFxN2sl0ermWSGpsH7LxefntT4Uin7Hqx+6ZTymxo0xdlxASWQcmbqMhzY7Z8JTl4oJAWz/5Y9BZZwkDlUxzNUmSTdOIVL1kePjsKw4JJ8AfMCANVMQs/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQzX4xdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C714EC4CEF1;
	Tue, 26 Aug 2025 06:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756189093;
	bh=TufPpZh+5km23M/SOb+uejlv3zSfmFKXfTQaS89ZyJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQzX4xdIcvcaavyDzRTUsYZ2OZUrJufij98mjWbxGcZeGCqD+CBo2QCXLr6Usp83U
	 AKMwXLjiCcoyrK7uhTShCLMkMjVA0a7eFAOV+gg8JsNSqV/emBvBg8gzX0w6Q8hRxd
	 YbSdrOAbvYwt47IaVMYKOXtxTZrv9g4XiAzZmrG1mgu2Wfwtu1phe7R5l6jDuC5XY4
	 //preh2SFWda0re1aktjTK22g9R7Lem4dilWBdIqrTFW4x7riB5bEpXGpA6bhsxLXw
	 L+/gcEs4yK1CrSO9eevpU4KbfvpZOPFNbUVawY+krKmOG6e2W07uLg+Qw9oSU9vxSA
	 wHREnYoKtBlXw==
Date: Tue, 26 Aug 2025 11:47:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v2 3/3] PCI: qcom: Restrict port parsing only to pci
 child nodes
Message-ID: <rurdrz3buvb7paqgjjr7ethzvaeyvylezexcwshpj73xf7yeec@i52bla6r5tx7>
References: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
 <20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com>

On Tue, Aug 26, 2025 at 10:48:19AM GMT, Krishna Chaitanya Chundru wrote:
> The qcom_pcie_parse_ports() function currently iterates over all available
> child nodes of the PCIe controller's device tree node. This can lead to
> attempts to parse unrelated nodes like OPP nodes, resulting in unnecessary
> errors or misconfiguration.
> 

What errors? Errors you are seeing on your setup or you envision?

> Restrict the parsing logic to only consider child nodes named "pcie" or
> "pci", which are the expected node names for PCIe ports.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Since this is a fix, 'Fixes' tag is needed.

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..5dbdb69fbdd1b9b78a3ebba3cd50d78168f2d595 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1740,6 +1740,8 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>  	int ret = -ENOENT;
>  
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		if (!(of_node_name_eq(of_port, "pcie") || of_node_name_eq(of_port, "pci")))

May I know which platform has 'pci' as the node name for the bridge node? AFAIK,
all platforms defining bridge nodes have 'pcie' as the node name.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

