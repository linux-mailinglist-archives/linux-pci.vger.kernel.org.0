Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26E0659137
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 20:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiL2Tni (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 14:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiL2Tng (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 14:43:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893212ACC;
        Thu, 29 Dec 2022 11:43:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E8DB618EB;
        Thu, 29 Dec 2022 19:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C02C433EF;
        Thu, 29 Dec 2022 19:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672343014;
        bh=OF2QBuIivwLI2yVtSZKFRSp8bN1Ke056/VS/n7wByCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Otu5AevErYtodelmxt2WZnb1eqn6EdT//+dP2yuR13RAhiN1MJrCTglbBeMmPSNwB
         MDE5/NQGT46ucxCTLPQZxgunwaw0AruuMmpPBrsOLJl4H/xRgHLbcwE86e5XmTrGvL
         OnBeyUn4DOJKFf6LEciXysOfbtVpxTbdrGl1ZEZNdEU94p3OrITBgKIbbOwIMw4ABp
         i0RRmmw5yqeczQLPIQLgFFeua22UBxW+ybmhnD77bBnkmyweMI9Fv4inGJ28d6fe/7
         fPQsv2lVfXT/UfAfML2KMroB4luuWyMsqH4GFEH+uG4MLiS4beGzXoP7JBmQcaEX/h
         Z2DXfow9d7hnw==
Date:   Thu, 29 Dec 2022 13:43:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aleksandr Burakov <a.burakov@rosalinux.ru>
Cc:     Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI: amlogic: The check for devm_add_action_or_reset's
 return value added
Message-ID: <20221229194333.GA625014@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220092137.6527-1-a.burakov@rosalinux.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Aleksandr,

Thanks for the patch!

On Tue, Dec 20, 2022 at 12:21:37PM +0300, Aleksandr Burakov wrote:
> The return value of the function devm_add_action_or_reset() was not
> checked hence an error code would not be returned.

You can save Lorenzo and Krzysztof some work by:

  - Rewording the subject line in the typical "<verb> <object>"
    imperative form, e.g., "Check for devm_add_action_or_reset()
    failure"

  - Rewording the commit log similarly.  Note that the existing commit
    only describes the current situation and doesn't actually say what
    the patch does.

Here's a good guide to commit logs: https://cbea.ms/git-commit/

> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index c1527693bed9..3d82f0b65480 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -187,9 +187,13 @@ static inline struct clk *meson_pcie_probe_clock(struct device *dev,
>  		return ERR_PTR(ret);
>  	}
>  
> -	devm_add_action_or_reset(dev,
> +	ret = devm_add_action_or_reset(dev,
>  				 (void (*) (void *))clk_disable_unprepare,
>  				 clk);
> +	if (ret) {
> +		dev_err(dev, "couldn't reset clk\n");
> +		return ERR_PTR(ret);
> +	}
>  
>  	return clk;
>  }
> -- 
> 2.25.1
> 
