Return-Path: <linux-pci+bounces-20312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E09A1B057
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 07:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 642EF7A1222
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B81D7E50;
	Fri, 24 Jan 2025 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oplL3bsE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F901D9A42;
	Fri, 24 Jan 2025 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737699522; cv=none; b=DW/0UL6yMq2ODUcYd1JnvDKuOn21mLYvAX1KKnlihvHeWaHR0INET8h7Y6UoDOsZ4Tkb/v80B/cBDO6mTvFdPf5WwfvZvlHoMILuSN10lKjv2JeJTi6Zp5LCkAES3tKWMDfnfFcA1iyMDj3gH2jf2FoEjQqzDAzZ9xeLiBb/rQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737699522; c=relaxed/simple;
	bh=cItniUqC4QT0YNtakY684hqDWnvjk9LjdVh3uC6piDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLqW0QwX3QDcG37QtJmTK71cNu4+fpuqOYGeQhx1ysFu5h2DR3ly7hwGAMROtgtKehWeUSFoTY3YvUfwDbe9QaZ2IWoXW9rcYgfzaInew+F5fb7//Y4m6FyO6vPWeERxq8xqwLSr4iTqQIE02F4OkgD5qAKYohslDjcVd6+8b04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oplL3bsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47492C4CED2;
	Fri, 24 Jan 2025 06:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737699522;
	bh=cItniUqC4QT0YNtakY684hqDWnvjk9LjdVh3uC6piDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oplL3bsEoT2qIWCapWtyTkT4VvhxRhJ9mSSR/GJ6MBIbvElkDpQN0Ka5oP6KzvROc
	 hNuWXyCfj2+sB+831FaXXPpgrm6Shis+CFEm5ZcuLpalb1ixXeapGfRqIYx6eldxqr
	 LHUkikNyb/LUpuObytdgCgvb5sZ+JsxDLQP+EcEeOyNKSh3ApZh6DTEnit7bqsApow
	 miXZElfhKdaicvom5KGDqIlnP6ZELdUfBk2YEM3WfH/xwctt0wQgOUWJw+tvYV/58s
	 Nr1lOL7E8rJneL7xyRFZ48s4PMLEHjFkKr5nNQe3ywtT5Sh73swEmNqnBs/7ROyFsR
	 QfiIWKJpu+8pg==
Date: Fri, 24 Jan 2025 11:48:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	mmareddy@quicinc.com,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v3 3/4] PCI: dwc: Reduce DT reads by allocating host
 bridge via DWC glue driver
Message-ID: <20250124061828.ncycdpxqd6fqpjib@thinkpad>
References: <20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com>
 <20250121-enable_ecam-v3-3-cd84d3b2a7ba@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121-enable_ecam-v3-3-cd84d3b2a7ba@oss.qualcomm.com>

On Tue, Jan 21, 2025 at 02:32:21PM +0530, Krishna Chaitanya Chundru wrote:
> Allow DWC glue drivers to allocate the host bridge, avoiding redundant
> device tree reads primarily in dw_pcie_ecam_supported().
> 

I don't understand what you mean by 'redundant device tree reads'. Please
explain.

- Mani

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3888f9fe5af1..0acf9db44f2c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -484,8 +484,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct pci_host_bridge *bridge = pp->bridge;
>  	struct resource_entry *win;
> -	struct pci_host_bridge *bridge;
>  	struct resource *res;
>  	int ret;
>  
> @@ -497,11 +497,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		return -ENODEV;
>  	}
>  
> -	bridge = devm_pci_alloc_host_bridge(dev, 0);
> -	if (!bridge)
> -		return -ENOMEM;
> -
> -	pp->bridge = bridge;
> +	if (!pp->bridge) {
> +		bridge = devm_pci_alloc_host_bridge(dev, 0);
> +		if (!bridge)
> +			return -ENOMEM;
> +		pp->bridge = bridge;
> +	}
>  
>  	pp->cfg0_size = resource_size(res);
>  	pp->cfg0_base = res->start;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

