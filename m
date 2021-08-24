Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C363F6983
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhHXTGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 15:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232710AbhHXTGN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 15:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10F9361368;
        Tue, 24 Aug 2021 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629831929;
        bh=AHzw5+xWkEeEGVoZjVwMsegCxjuI7l0q+qizzHwAlCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OVCtytrUB5f9U7Fk/yxzNCEfnI5uB9FthFA5rl3vU5cONNgKalS9Ys4uticNroERw
         iBKhXZBrUFL3l/PfI27kW+NhpeDSmSEQCyqolnREpHCFjaM5AQ8qgQ1HMmnOWpabmR
         LW36DyUApChnbDh4zzu6SGC6EQ9iXza378rupuCEDl07M1XQcCG/UPU5A0I7A0RzTZ
         bOZLzky39N2ELHWMSwlCSZnthun5KyM/WKZEZtyCgi8E+nL4xxFHmwtGYj/LW4kY/Z
         OSMgZOU7mHT4mX9yUqCcqQSS79/1hnUWFJawmDw+DedUeWtE2zFGuxl46C/leKg4Pi
         n0Sx2GljxiyHw==
Date:   Tue, 24 Aug 2021 14:05:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Perform host_init() before registering
 msi
Message-ID: <20210824190527.GA3486548@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823154958.305677-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 23, 2021 at 08:49:57AM -0700, Bjorn Andersson wrote:
> On the Qualcomm sc8180x platform the bootloader does something related
> to PCI that leaves a pending "msi" interrupt, which with the current
> ordering often fires before init has a chance to enable the clocks that
> are necessary for the interrupt handler to access the hardware.
> 
> Move the host_init() call before the registration of the "msi" interrupt
> handler to ensure the host driver has a chance to enable the clocks.

Did you audit other drivers for similar issues?  If they do, we should
fix them all at once.

> The assignment of the bridge's ops and child_ops is moved along, because
> at least the TI Keystone driver overwrites these in its host_init
> callback.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - New patch, instead of enabling resources in the qcom driver before jumping to
>   dw_pcie_host_init(), per Rob Herring's suggestion.
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d1d9b8344ec9..f4755f3a03be 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -335,6 +335,16 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (pci->link_gen < 1)
>  		pci->link_gen = of_pci_get_max_link_speed(np);
>  
> +	/* Set default bus ops */
> +	bridge->ops = &dw_pcie_ops;
> +	bridge->child_ops = &dw_child_pcie_ops;
> +
> +	if (pp->ops->host_init) {
> +		ret = pp->ops->host_init(pp);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (pci_msi_enabled()) {
>  		pp->has_msi_ctrl = !(pp->ops->msi_host_init ||
>  				     of_property_read_bool(np, "msi-parent") ||
> @@ -388,15 +398,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> -	/* Set default bus ops */
> -	bridge->ops = &dw_pcie_ops;
> -	bridge->child_ops = &dw_child_pcie_ops;
> -
> -	if (pp->ops->host_init) {
> -		ret = pp->ops->host_init(pp);
> -		if (ret)
> -			goto err_free_msi;
> -	}
>  	dw_pcie_iatu_detect(pci);
>  
>  	dw_pcie_setup_rc(pp);
> -- 
> 2.29.2
> 
