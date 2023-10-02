Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D4F7B5D05
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 00:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjJBWMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 18:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJBWMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 18:12:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0ABF
        for <linux-pci@vger.kernel.org>; Mon,  2 Oct 2023 15:12:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C247BC433C8;
        Mon,  2 Oct 2023 22:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696284740;
        bh=LnCw649oSo06kYU1LBLPXAcfIE3COHy/mx1F9ClYaho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DLdaZym38hP+QjaQ+ccgXEg1HCxSPpVQ57ouccjP675mlbG5kDgVte4kCN4Y8KX5s
         io8F10UJ5vrKwSd2o0weNCbBugfi7t0pHoqSPIA1lDFWe4H3shk1Jh1LRQhKWdFgaw
         /va0vgPbLHNUpO8G1vqG/WeGmoaLkcY/4D78fcyB0PTT3IQu31v1w0P52fTwDHyiEs
         MXXOSUUcoxQmfilrArpZoEGWeA3rx9OvEgnBWfURfqESbCNBqHw61ZUKqTeiQ0ru5a
         CQLdmsRgdZ+fntW4quW+1wGCoAH26BKThb7n7eCibuRdwkw+p7f7AabOTipeI7/RwS
         nmwBkUo275YKA==
Date:   Mon, 2 Oct 2023 17:12:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/4] PCI: kirin: Don't put .remove callback in .exit.text
 section
Message-ID: <20231002221218.GA651790@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231001170254.2506508-3-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 01, 2023 at 07:02:52PM +0200, Uwe Kleine-König wrote:
> With CONFIG_PCIE_KIRIN=y and kirin_pcie_remove() marked with __exit, the
> function is discarded from the driver. In this case a bound device can
> still get unbound, e.g via sysfs. Then no cleanup code is run resulting
> in resource leaks or worse.

kirin_pcie_driver sets .suppress_bind_attrs = true.

Doesn't that mean that we can't unbind a device via sysfs in this
case?

I don't expect modpost to know about .suppress_bind_attrs, so maybe we
should remove the __exit annotation even if it would be safe to keep
it in this case.  It's a tiny function anyway.

> The right thing to do is do always have the remove callback available.
> This fixes the following warning by modpost:
> 
> 	drivers/pci/controller/dwc/pcie-kirin: section mismatch in reference: kirin_pcie_driver+0x8 (section: .data) -> kirin_pcie_remove (section: .exit.text)
> 
> (with ARCH=x86_64 W=1 allmodconfig).
> 
> Fixes: 000f60db784b ("PCI: kirin: Add support for a PHY layer")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d93bc2906950..2ee146767971 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -741,7 +741,7 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
>  	return ret;
>  }
>  
> -static int __exit kirin_pcie_remove(struct platform_device *pdev)
> +static int kirin_pcie_remove(struct platform_device *pdev)
>  {
>  	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
>  
> @@ -818,7 +818,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
>  
>  static struct platform_driver kirin_pcie_driver = {
>  	.probe			= kirin_pcie_probe,
> -	.remove	        	= __exit_p(kirin_pcie_remove),
> +	.remove	        	= kirin_pcie_remove,
>  	.driver			= {
>  		.name			= "kirin-pcie",
>  		.of_match_table		= kirin_pcie_match,
> -- 
> 2.40.1
> 
