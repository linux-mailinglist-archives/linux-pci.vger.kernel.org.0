Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AC0215510
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgGFJ6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 05:58:25 -0400
Received: from foss.arm.com ([217.140.110.172]:53228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgGFJ6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 05:58:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E796030E;
        Mon,  6 Jul 2020 02:58:24 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98DE73F68F;
        Mon,  6 Jul 2020 02:58:23 -0700 (PDT)
Date:   Mon, 6 Jul 2020 10:58:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: fix runtime pm imbalance on error
Message-ID: <20200706095821.GB26377@e121166-lin.cambridge.arm.com>
References: <20200520085837.1399-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520085837.1399-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 04:58:37PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 138e1a2d21cc..35686930df1d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1340,8 +1340,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
> -		pm_runtime_disable(dev);
> -		return ret;
> +		goto err_pm_runtime_put;

I think you need to remove the brackets - this become a single line
if statement.

Lorenzo

>  	}
>  
>  	pci->dev = dev;
> -- 
> 2.17.1
> 
