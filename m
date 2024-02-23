Return-Path: <linux-pci+bounces-3955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97864861F61
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 23:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CD3285E31
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 22:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D9B14CAC3;
	Fri, 23 Feb 2024 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpLO6XnX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49214CAAB;
	Fri, 23 Feb 2024 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726203; cv=none; b=WU+1S+MaXACWlXCvnJcaE29u0kZC7dImyhy6Xh++a9D7MlwFnnVyg+rcrymiYhvYY8VPQ/35p7AxPhX6xIb+QkQ3rjnzsFfvFz/aktXcg0yrP7hFwCo0XQM73hpyqExnm2t6ALPZObeZdlBC9Cl9REOiRj7hdBZO/S7VfyrAJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726203; c=relaxed/simple;
	bh=ddVApPNuf6tVk4Tbz93m9z7lMVLzrLppfynOoPkXXNM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G9SYZfa5RIKWuWHKWEJLUeZ3e6nSeIn/cJhUzc1khzMBLY7jMx3NWuDQBxYzHg6txhpfKOumy4RQIymRLOS9I1tHqQyiP7WghD+icH4hxJxo5bLRL70ud0aNzU9bCteAAVjKpaU1+GPL6MUt/xsqL8MpWwIcT7gAUwOMVqIrnnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpLO6XnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC52FC433F1;
	Fri, 23 Feb 2024 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708726202;
	bh=ddVApPNuf6tVk4Tbz93m9z7lMVLzrLppfynOoPkXXNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZpLO6XnX/konsdIIp8e+tRfeWzOtu1/s2BVvcXtk8MmrAw/V47QQD7APMk6oe8F6s
	 2S5+EXTzP3qucJYpskwL3rvw8khnQoURsGphXbEOWwGFfi9J6ktiBJ/r3ebyNm1YJ7
	 PPZbolW144cK7L7xtgvEXl3ibrEcAXOWtqxccI2fSIOgLZhODAdGzKFsi1uJPKi/4o
	 XZADSyNx0OIdw/mlI+DSv/Yz/wgHF5JOv+/fEq7jtLluOmgbX7rlcFsPB2ozmA/5nQ
	 +7xUfBuoUrh7yJWFwnLS92ZqOpxsjclNAgRnCB0alW1DzDpZH36+POAG+n051sZg/m
	 I+uV4hjCDB1SA==
Date: Fri, 23 Feb 2024 16:10:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 04/12] PCI: qcom: Add support for disabling ASPM L0s
 in devicetree
Message-ID: <20240223221000.GA118088@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223152124.20042-5-johan+linaro@kernel.org>

On Fri, Feb 23, 2024 at 04:21:16PM +0100, Johan Hovold wrote:
> Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting
> 1.9.0 ops") started enabling ASPM unconditionally when the hardware
> claims to support it. This triggers Correctable Errors for some PCIe
> devices on machines like the Lenovo ThinkPad X13s, which could indicate
> an incomplete driver ASPM implementation or that the hardware does in
> fact not support L0s.

Are there any more details about this?  Do the errors occur around
suspend/resume, a power state transition, or some other event?  Might
other DWC-based devices be susceptible?  Is there a specific driver
you suspect might be incomplete?

Do you want the DT approach because the problem is believed to be
platform-specific?  Otherwise, maybe we should consider reverting
9f4f3dfad8cf until the problem is understood?

Could this be done via a quirk like quirk_disable_aspm_l0s()?  That
currently uses pci_disable_link_state(), which I don't think is
completely safe because it leaves the possibility that drivers or
users could re-enable L0s, e.g., via sysfs.

This patch is nice because IIUC it directly changes PCI_EXP_LNKCAP,
which avoids that issue, but quirk_disable_aspm_l0s() could
conceivably be reimplemented to cache PCI_EXP_LNKCAP in struct pci_dev
so quirks could override it, as we do with struct pci_dev.devcap.

> Add support for disabling ASPM L0s in the devicetree when it is not
> supported on a particular machine and controller.
> 
> Note that only the 1.9.0 ops enable ASPM currently.
> 
> Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> Cc: stable@vger.kernel.org      # 6.7
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 09d485df34b9..0fb5dc06d2ef 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -273,6 +273,25 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
> +{
> +	u16 offset;
> +	u32 val;
> +
> +	if (!of_property_read_bool(pci->dev->of_node, "aspm-no-l0s"))
> +		return;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_ASPM_L0S;
> +	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>  static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>  {
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -962,6 +981,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
> +	qcom_pcie_clear_aspm_l0s(pcie->pci);
>  	qcom_pcie_clear_hpc(pcie->pci);
>  
>  	return 0;
> -- 
> 2.43.0
> 

