Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B578A6C5341
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCVSHF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 14:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCVSHE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 14:07:04 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1219F5D45A;
        Wed, 22 Mar 2023 11:07:00 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id BB3EEE0EAE;
        Wed, 22 Mar 2023 21:06:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Ww2kcFcr7CcTTENKIqWDIjWc8wmlgXRUj4b9WQCI0Hc=; b=Dl+r57CRPnDM
        3pYrgDVVod6E9phYjHNl874eBYb1eMts7cM9YChXBnFHaw7SLA+4l6NQrJj+D3uS
        uyMnPyaFB3EQhKXJRfMels2l1iOqk3uTsfUmOmODQOLFLIrWxhzfzEeAco3mRCl7
        s88XWETp2mAKhjsGHhXr4llPyA3Y7oU=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9BF4CE0E6A;
        Wed, 22 Mar 2023 21:06:58 +0300 (MSK)
Received: from mobilestation (10.8.30.14) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 22 Mar 2023 21:06:57 +0300
Date:   Wed, 22 Mar 2023 21:06:57 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <kernel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 06/15] PCI: dwc/*: Convert to platform remove callback
 returning void
Message-ID: <20230322180657.s3ctphnkkmle4l42@mobilestation>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
 <20230321193208.366561-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321193208.366561-7-u.kleine-koenig@pengutronix.de>
X-Originating-IP: [10.8.30.14]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 21, 2023 at 08:31:59PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert the dwc drivers from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pcie-bt1.c      | 6 ++----
>  drivers/pci/controller/dwc/pcie-histb.c    | 6 ++----
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 6 ++----
>  drivers/pci/controller/dwc/pcie-qcom-ep.c  | 8 +++-----
>  drivers/pci/controller/dwc/pcie-tegra194.c | 8 +++-----
>  5 files changed, 12 insertions(+), 22 deletions(-)
> 

> diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> index 95a723a6fd46..17e696797ff5 100644
> --- a/drivers/pci/controller/dwc/pcie-bt1.c
> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> @@ -617,13 +617,11 @@ static int bt1_pcie_probe(struct platform_device *pdev)
>  	return bt1_pcie_add_port(btpci);
>  }
>  
> -static int bt1_pcie_remove(struct platform_device *pdev)
> +static void bt1_pcie_remove(struct platform_device *pdev)
>  {
>  	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
>  
>  	bt1_pcie_del_port(btpci);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id bt1_pcie_of_match[] = {
> @@ -634,7 +632,7 @@ MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
>  
>  static struct platform_driver bt1_pcie_driver = {
>  	.probe = bt1_pcie_probe,
> -	.remove = bt1_pcie_remove,
> +	.remove_new = bt1_pcie_remove,
>  	.driver = {
>  		.name	= "bt1-pcie",
>  		.of_match_table = bt1_pcie_of_match,

Looking good. Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>
* For Baikal-T1 PCIe part

-Serge(y)

[nip]

> -- 
> 2.39.2
> 
> 

