Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C298E21212C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 12:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgGBK1Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 06:27:16 -0400
Received: from foss.arm.com ([217.140.110.172]:35888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbgGBK1Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 06:27:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E3D51FB;
        Thu,  2 Jul 2020 03:27:15 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C80BE3F71E;
        Thu,  2 Jul 2020 03:27:12 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:27:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu
Subject: Re: [PATCH] PCI: qcom: handle pm_runtime_get_sync failure case
Message-ID: <20200702102706.GA21978@e121166-lin.cambridge.arm.com>
References: <20200605031643.18171-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605031643.18171-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 04, 2020 at 10:16:43PM -0500, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Navid, I will review and merge Dinghao's version of these patches[1]
since he posted them first, I will drop yours from the PCI patch
queue, thanks anyway for posting them.

Lorenzo

[1] https://patchwork.kernel.org/patch/11559819/

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 138e1a2d21cc..48c434e6e915 100644
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
