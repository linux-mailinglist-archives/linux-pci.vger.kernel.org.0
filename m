Return-Path: <linux-pci+bounces-5534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3888951A8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 13:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BD028402E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AB627FC;
	Tue,  2 Apr 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtTzReyo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5162147;
	Tue,  2 Apr 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056741; cv=none; b=CzE6KXg7J0tc86SfuTn8zsNtUR6H82F3SuOqQbPhixTwDs1++WY8kDwwA9nCsUc5RDrQU+57PiyYZaq8kpSlI3m5IP0j1AdGosZs4WhftnH5yO35xtL/gkkGlZFmlaIY+NJQZM6EER/BL9g1aZV6w360Y1ecFvYkORmRh6lrE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056741; c=relaxed/simple;
	bh=EngvwcHPKVW3rJfsOG5BaNu6Bo2aD8qL+HdMGSHkZLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaV24Q0m34yBkbsou62BP/FhEcnu3zQqn7OLMj0a54wlSMEXgPabFc0enni/YUP9XhGffSfl72ClRV2JHcycVE1pdkA2CNrE1I5uwBw7B/uAfwPi8bzxDUph1Jx25r6Jll9wPzJ9OUZ7rEtAIWz5cSt3+B+Dmx/ISFaNhnaNDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtTzReyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76550C43390;
	Tue,  2 Apr 2024 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712056740;
	bh=EngvwcHPKVW3rJfsOG5BaNu6Bo2aD8qL+HdMGSHkZLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtTzReyodK1xQWsf7wOzHlNkClL3G0Dy9PtLO8GP8vyiKOeyny3m2hf2nJRxkWUPq
	 tyr81a4IDQTWBhTvdKURIP9YdSruFnDn0HfcnNDuATtnvEwzrfV2hj7xwcX7Uem2we
	 Jgx0MQD3iSS2WLJtoH9D5buPrymwAqjT5XfYWIGUkBms9I1w0UoUbcpAmk+FFAA1Eo
	 2FqeUBWz4QW5nNEoae0lxWJhSleFR5XSSjnmHBF8qAxrNv1EA7rrpCaJ6XZng3Tm7i
	 Wl4csOeBarC4k/bUvBejEXTMf+UJ0zbhy90nAsfwqTIrjOlq/KmtcMGXtz/hRE1ux5
	 J2mda87IoJ9zw==
Date: Tue, 2 Apr 2024 13:18:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI: qcom: Implement shutdown() callback to
 properly reset the endpoint devices
Message-ID: <ZgvpnqdjQ39JMRiV@ryzen>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-10-970dbe90b99d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-pci-epf-rework-v2-10-970dbe90b99d@linaro.org>

On Mon, Apr 01, 2024 at 09:20:36PM +0530, Manivannan Sadhasivam wrote:
> PCIe host controller drivers are supposed to properly reset the endpoint
> devices during host shutdown/reboot. Currently, Qcom driver doesn't do
> anything during host shutdown/reboot, resulting in both PERST# and refclk
> getting disabled at the same time. This prevents the endpoint device
> firmware to properly reset the state machine. Because, if the refclk is
> cutoff immediately along with PERST#, access to device specific registers
> within the endpoint will result in a firmware crash.
> 
> To address this issue, let's call qcom_pcie_host_deinit() inside the
> shutdown callback, that asserts PERST# and then cuts off the refclk with a
> delay of 1ms, thus allowing the endpoint device firmware to properly
> cleanup the state machine.

Hm... a QCOM EP device could be attached to any of the PCIe RC drivers that
we have in the kernel, so it seems a bit weird to fix this problem by
patching the QCOM RC driver only.

Which DBI call is it that causes this problem during perst assert on EP side?

I assume that it is pci-epf-test:deinit() callback that calls
pci_epc_clear_bar(), which calls dw_pcie_ep_clear_bar(), which will both:
-clear local data structures, e.g.
ep->epf_bar[bar] = NULL;
ep->bar_to_atu[bar] = 0;

but also call:
__dw_pcie_ep_reset_bar()
dw_pcie_disable_atu()


Do we perhaps need to redesign the .deinit EPF callback?

Considering that we know that .deinit() will only be called on platforms
where there will be a fundamental core reset, I guess we could do something
like introduce a __dw_pcie_ep_clear_bar() which will only clear the local
data structures. (It might not need to do any DBI writes, since the
fundamental core reset should have reset all values.)

Or perhaps instead of letting pci_epf_test_epc_deinit() call
pci_epf_test_clear_bar()/__pci_epf_test_clear_bar() directly, perhaps let
pci_epf_test_epc_deinit() call add a .deinit()/.cleanup() defined in the
EPC driver.

This EPC .deinit()/.cleanup() callback would then only clear the
local data structures (no DBI writes...).

Something like that?


> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 14772edcf0d3..b2803978c0ad 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1655,6 +1655,13 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  	return 0;
>  }
>  
> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	qcom_pcie_host_deinit(&pcie->pci->pp);
> +}
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> @@ -1708,5 +1715,6 @@ static struct platform_driver qcom_pcie_driver = {
>  		.pm = &qcom_pcie_pm_ops,
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
> +	.shutdown = qcom_pcie_shutdown,
>  };
>  builtin_platform_driver(qcom_pcie_driver);
> 
> -- 
> 2.25.1
> 

