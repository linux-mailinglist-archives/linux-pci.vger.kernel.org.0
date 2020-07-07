Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6D216A6F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgGGKgb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 06:36:31 -0400
Received: from foss.arm.com ([217.140.110.172]:38584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgGGKga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 06:36:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 575EEC0A;
        Tue,  7 Jul 2020 03:36:30 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 089BC3F71E;
        Tue,  7 Jul 2020 03:36:28 -0700 (PDT)
Date:   Tue, 7 Jul 2020 11:36:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] PCI: qcom: Fix runtime PM imbalance on error
Message-ID: <20200707103617.GA14581@e121166-lin.cambridge.arm.com>
References: <20200707055000.9453-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707055000.9453-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 07, 2020 at 01:50:00PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: - Remove redundant brackets.
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied to pci/runtime-pm, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 138e1a2d21cc..12abdfbff5ca 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1339,10 +1339,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_disable(dev);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto err_pm_runtime_put;
>  
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
> -- 
> 2.17.1
> 
