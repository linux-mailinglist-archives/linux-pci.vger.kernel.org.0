Return-Path: <linux-pci+bounces-4789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E487A994
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 15:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D680E1F23EAE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB2E1E524;
	Wed, 13 Mar 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEzqcJeG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10166290A;
	Wed, 13 Mar 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340577; cv=none; b=lIM8F4iw7d6eomWf8lL9/dz7BW0X1dkHzh3g1zfWo7vTqqcLXCOEMPo/x9Pfx2rQNWTzVVdGhLn1HYjBgJ9Yr+/MBXRS7wvBVbgKT176zNdlYQ8jG4lhf98nOQRoYwrJ6rKbEcHj6Ho2xTYiDF0864eT8ZHpxpgKVde5KWNYdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340577; c=relaxed/simple;
	bh=XFDXYmXdUS9RT2lDf6b0r0Sb31orMCrxt5jtIkbRWKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gtWU/utdAouDEUW/5g1K9SuiZgVbXbHlSlnSIyN6zebr8ufxZs7pxXaGluO0V1AIC9EWTSAiQrnlWBxF99cacrybZ+DQEzK9jE8PactcFXytzPPE1tkl4PpI5AIe8zxNL/Gug4ANuTI62uGBTxoMVX9NMbvMgRggKF0KcGC5Oc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEzqcJeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A6CC433F1;
	Wed, 13 Mar 2024 14:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710340576;
	bh=XFDXYmXdUS9RT2lDf6b0r0Sb31orMCrxt5jtIkbRWKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZEzqcJeGxPPNYFIZRysA/arw8xKmCsgFAtuJNh6CcaGinac4jHPx0j8sRkhwKjbeG
	 2K66SzJFHUpMdstY/bqu5mF7jniMbPjEs6OsS2AO+4KMoqx9Z00vF4N243TSn7RK//
	 LDGvlE//xarvy1U0wLhCPnEWUMDbs+ySoXgXfs6LNUEisMlEYFpeELOwDhChL49fJc
	 66pD5Fz0GtUEGh11BON/V1DjMBIYNy7WUCvoEh7Zw75IJFqYCGfoirAOHQcZdUBZ+w
	 g4eAR37hfXwlKzswREpP7UkjTykH6a7nFsIOnZeEFHUXkyrxX6XZpXzUMExEOFyY50
	 v7uwsn4hsoyvA==
Date: Wed, 13 Mar 2024 09:36:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Implement shutdown() callback to properly
 reset the endpoint devices
Message-ID: <20240313143614.GA916555@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313-pci-qcom-shutdown-v1-1-fb1515334bfa@linaro.org>

On Wed, Mar 13, 2024 at 05:39:22PM +0530, Manivannan Sadhasivam wrote:
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

I guess this 1ms delay is the PERST_DELAY_US hidden inside
qcom_ep_reset_assert()?  I assume the refclk disable is done by
clk_bulk_disable_unprepare()?

  #define PERST_DELAY_US 1000

  qcom_pcie_shutdown
    qcom_pcie_host_deinit
      qcom_ep_reset_assert
        gpiod_set_value_cansleep(pcie->reset, 1);
        usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);  <--
      phy_power_off(pcie->phy)
      pcie->cfg->ops->deinit()
        qcom_pcie_deinit_...
          clk_bulk_disable_unprepare                         <--

Is there a spec citation for this delay requirement?  If not, how do
we know 1ms is enough for whatever the firmware needs to do?

Do other drivers require similar changes?

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 2ce2a3bd932b..41434bc4761a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1618,6 +1618,13 @@ static int qcom_pcie_resume_noirq(struct device *dev)
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
> @@ -1670,5 +1677,6 @@ static struct platform_driver qcom_pcie_driver = {
>  		.pm = &qcom_pcie_pm_ops,
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
> +	.shutdown = qcom_pcie_shutdown,
>  };
>  builtin_platform_driver(qcom_pcie_driver);
> 
> ---
> base-commit: 51459eb30f88651d3688b9e95fed0f97767ececb
> change-id: 20240313-pci-qcom-shutdown-d86298186560
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

