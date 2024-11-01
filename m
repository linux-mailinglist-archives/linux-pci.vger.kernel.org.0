Return-Path: <linux-pci+bounces-15803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2690F9B9467
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 16:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5787F1C2132C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6EB1B4F2E;
	Fri,  1 Nov 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFKJkWnr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E51411DE;
	Fri,  1 Nov 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475018; cv=none; b=fXB3wdLF2S2Ea/F6hFF7x2L4vWYTdos6zOmhiNQoH5pueAyYBbDwEORfGYoWZNkdqpSl7UOswdgfHgV87hEiNxXBgck/oyPRV3MI8pdAoWiTbvVxteI29qfoPPyA0Ljb8+5M8kJJVR0cuxdJww59mvyz0DiwP3CmE2+oJdSk8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475018; c=relaxed/simple;
	bh=VgE+7jChh5IyD9wnRdhxDfZmf/SVR68cXAP4kxhPyHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubyG95C5wlNdMSSc9Ngb4ksoN4YtERuEGkYkiaRCUk8fu307y7i/QQJEjA0H6D++0Ot9W64zLrXZ+WYpeuBwZ93anJyD+NRXvfzoK8J+nSy5HHxwaLNq8Dt546PQi6rqnqdKbqWm5f8PyS8gzGjBnQZxdLZruulUCKoWK1EIkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFKJkWnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0AEC4CECD;
	Fri,  1 Nov 2024 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475017;
	bh=VgE+7jChh5IyD9wnRdhxDfZmf/SVR68cXAP4kxhPyHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFKJkWnrPT1+WaLUEIvO59ES0WhOct5qplLA4WFliQcOcmpWP8CH1tyN77Lhd5E9S
	 vq+egFJj7VddWDn37E6CwLUlTavaRkLqoN+KSbVyZvswjk2+GYsRWTYOt7HgyzRTs6
	 TRPay/mjNBJtcif+DoddKnNXgyUZFfV5cDnIPCeo/bfu0QjgIO3B4GyRgD2kAGCc2O
	 bJoNL1mfT0H2GKizJQkd656QTO7t7fE6NgfqE6hHmslSZCK2gLVnix2JxABF0iNjNs
	 Va1XYBCOgJCttQPIuD+o2yAppk788LhgrTaFzAE1oF0Gbh5Uxd4jTy6w12cjeWoM4V
	 XE3gKFV3Qai/g==
Date: Fri, 1 Nov 2024 10:30:15 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 2/3] PCI: qcom: Set linkup_irq if global IRQ handler
 is present
Message-ID: <rbykc6qnqechpru4sehjvdo6iedeo4cankp3mwesdfnxyxsgs7@vj2p7wwfdqm7>
References: <20241101-remove_wait-v3-0-7accf27f7202@quicinc.com>
 <20241101-remove_wait-v3-2-7accf27f7202@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-remove_wait-v3-2-7accf27f7202@quicinc.com>

On Fri, Nov 01, 2024 at 05:04:13PM GMT, Krishna chaitanya chundru wrote:
> In cases where a global IRQ handler is present to manage link up
> interrupts, it may not be necessary to wait for the link to be up
> during PCI initialization which optimizes the bootup time.
> 
> So, set linkup_irq flag if global IRQ is present and In order to set the
> linkup_irq flag before calling dw_pcie_host_init() API, which waits for
> link to be up, move platform_get_irq_byname_optional() API
> above dw_pcie_host_init().
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ef44a82be058..474b7525442d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1692,6 +1692,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	irq = platform_get_irq_byname_optional(pdev, "global");
> +	if (irq > 0)
> +		pp->linkup_irq = true;

This seems to only ever being used in dw_pcie_host_init(), would it make
sense to use a argument to the function to pass the parameter instead of
stashing it in the persistent data structure?

Regards,
Bjorn

> +
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "cannot initialize host\n");
> @@ -1705,7 +1709,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_host_deinit;
>  	}
>  
> -	irq = platform_get_irq_byname_optional(pdev, "global");
>  	if (irq > 0) {
>  		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  						qcom_pcie_global_irq_thread,
> 
> -- 
> 2.34.1
> 
> 

