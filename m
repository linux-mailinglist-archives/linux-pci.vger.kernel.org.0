Return-Path: <linux-pci+bounces-15804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D479B9494
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7869F1C21755
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79F91B5EBC;
	Fri,  1 Nov 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi8W/ra5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D925634;
	Fri,  1 Nov 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475658; cv=none; b=EhhHc30XTBDBnlhECpC+2LfxRVi7V4xKIsmgotkO5aCEqu4UgdBb6DLLMFq9s1Lge0J5qmvK2BQhdJHrIVsOQR2rOqf6pHwWnBfZNloND0Q11bvwBP97L/JzBWXR48N3bRaMHL9DjjUTufTsZmMQHqIEDXbG9KsI7a+eovfuWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475658; c=relaxed/simple;
	bh=m8SoMgj4KsgMb1emwUZ5BfDfuQXD0LaYOxvM+lAsKmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxNNOBESp+nA1iPocNCUyasKJnTIvfJvGN9q1iA4qza/fjSlqi4uAhM0+qOFeLbeAYuSzNBf0rX1kOX7fG71xHeRUUF0US9xuQKM1lA/X2kfKqHDRSspKmghm3z+JB+UBoBoHI+7Iba/1It4OzC3/kmq6AzsllOafpflpmJypvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi8W/ra5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7F9C4CED3;
	Fri,  1 Nov 2024 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475658;
	bh=m8SoMgj4KsgMb1emwUZ5BfDfuQXD0LaYOxvM+lAsKmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mi8W/ra5yJuo9SxXMvyPVCzdotcOHhLcP10yCuQerj/nnvEE9QcFjjYUO5zpv9Ziy
	 GyzUKD9fDZS9TPeClZUzUUPl/kb9QA4ZcINGdlpKpgzM/+eeD2xMUnEqqX0Z/+kmhE
	 7jNzVZYi/HP6aIGQyfskB1mKqiAu3dOEQl3GR6kvu8rGzc3TbD7D1WKP7w/60dAXqo
	 iQLek9LyPSF4vFH75PgF3Na0rKUxywFewDCMwAumbo+sQbaVADP0SVp5woKTuqlk6I
	 gjwXrJj1Kch8fD+hmjAP9VaEkAgV628vRJ8WpDPgEWY4LnuWYlHIjgzElvH3Tq3qg2
	 HOHIurhPVtuPw==
Date: Fri, 1 Nov 2024 10:40:55 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 3/3] PCI: qcom: Update ICC and OPP values during link
 up event
Message-ID: <bsxaq6zilwaavcwi25dbz2wgrgqrqxfme6a5lfdg6jqfl4kspj@xahygne3tqg4>
References: <20241101-remove_wait-v3-0-7accf27f7202@quicinc.com>
 <20241101-remove_wait-v3-3-7accf27f7202@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-remove_wait-v3-3-7accf27f7202@quicinc.com>

On Fri, Nov 01, 2024 at 05:04:14PM GMT, Krishna chaitanya chundru wrote:
> As part of the PCIe link up event, update ICC and OPP values
> as at this point only driver can know the link speed and
> width of the PCIe link.
> 

It would be nice if you were to write your commit messages in the style
documented at https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
I.e. start with a clear problem description, then move into describing
the solution.

Your commit message is stating that this is the only place the driver
can know the link speed, but wouldn't that imply that there's some
actual problem with the code currently?


I'm guessing (because that's what your commit message is forcing me to
do) that in the case that we don't detect anything connected at probe
time and then we get a "hotplug" interrupt, we will have completely
incorrect bus votes?

If so, it would seem that this patch should have a:
Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")

And of course, a proper description of that problem.

Regards,
Bjorn

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 474b7525442d..5826c0e7ca0b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1558,6 +1558,8 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  		pci_lock_rescan_remove();
>  		pci_rescan_bus(pp->bridge->bus);
>  		pci_unlock_rescan_remove();
> +
> +		qcom_pcie_icc_opp_update(pcie);
>  	} else {
>  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>  			      status);
> 
> -- 
> 2.34.1
> 
> 

