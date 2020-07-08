Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF833218B24
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 17:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgGHPYl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 11:24:41 -0400
Received: from foss.arm.com ([217.140.110.172]:46630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgGHPYk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jul 2020 11:24:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 257D01FB;
        Wed,  8 Jul 2020 08:24:40 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9361C3F237;
        Wed,  8 Jul 2020 08:24:38 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:24:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     wu000273@umn.edu
Cc:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org, helgaas@google.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, kjlu@umn.edu
Subject: Re: [PATCH V2] PCI: qcom: Improve exception handling in
 qcom_pcie_probe().
Message-ID: <20200708152436.GB4238@e121166-lin.cambridge.arm.com>
References: <20200527025531.32357-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527025531.32357-1-wu000273@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 09:55:31PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> This function contained improvable implementation details according to
> exception handling.
> 1. pm_runtime_put() should be called after pm_runtime_get_sync() failed,
> because the reference count will be increased despite of the failure.
> Thus add the missed function call.
> 2. pm_runtime_disable() are called twice, after the call of phy_init() and
> dw_pcie_host_init() failed. Thus remove redundant function calls.

Can you send a patch fixing (2) based on my pci/runtime-pm branch:

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git

pci/runtime-pm

Note that (1) is fixed by

https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/runtime-pm&id=cb52a40202420d3886b84ea13dba699c9da13eb0

> 
> Fixes: 6e5da6f7d824 ("PCI: qcom: Fix error handling in runtime PM support")
> Co-developed-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  V2: words adjustments and fix some typos 
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 138e1a2d21cc..10393ab607bf 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1340,8 +1340,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
> -		pm_runtime_disable(dev);
> -		return ret;
> +		goto err_pm_runtime_put;
>  	}
>  
>  	pci->dev = dev;
> @@ -1401,7 +1400,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	ret = phy_init(pcie->phy);
>  	if (ret) {
> -		pm_runtime_disable(&pdev->dev);
>  		goto err_pm_runtime_put;
>  	}
>  
> @@ -1410,7 +1408,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "cannot initialize host\n");
> -		pm_runtime_disable(&pdev->dev);
>  		goto err_pm_runtime_put;
>  	}
>  
> -- 
> 2.17.1
> 
