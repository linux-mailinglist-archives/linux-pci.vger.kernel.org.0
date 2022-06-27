Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB2455CD5B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiF0HbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 03:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiF0HbS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 03:31:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145BF389A;
        Mon, 27 Jun 2022 00:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4F98B80F92;
        Mon, 27 Jun 2022 07:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B09C341C8;
        Mon, 27 Jun 2022 07:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656315067;
        bh=LvUqnHVulczahgyXpi9jFp5F1xbG8GaIH3qq2YaHXQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6JcbhWMkiQZukzZlOa1CPbJHHuLBPxa8qSHy7YIk8V3kRDmGVbBRhmRMpIe4ICGi
         RlWoRu3qXIUqEKpkzXJI4gk5mnLeacu9j3sZf9NzHmYnWThcZayRuwqQdMUlgs5woq
         UVus+IWW0dCW0xGr5b3N1ps4b7PjFdO7CCyFiEEjediRO3gurPmqlJYqRyxdoLJpwB
         TC9zyyV9cim7XqWQuwHY784z4563wh6RUCe/k4wc+aQfTAV/28A/nmj2BzOx7x04jB
         J904wT2rvx1/IOmzh8iwORn5VKx1qoaCfyOITogdCVNEndUdPXxDRWp331GVe4gyNl
         huQtOBdR6U85A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o5jD6-0004yY-D6; Mon, 27 Jun 2022 09:31:04 +0200
Date:   Mon, 27 Jun 2022 09:31:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Message-ID: <YrlcuExtGFp/ASF+@hovoldconsulting.com>
References: <20220519094646.23009-1-johan+linaro@kernel.org>
 <20220623155213.GA1450949@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623155213.GA1450949@bhelgaas>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 10:52:13AM -0500, Bjorn Helgaas wrote:
> On Thu, May 19, 2022 at 11:46:46AM +0200, Johan Hovold wrote:
> > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > is useful for multi-platform kernels as well as during development.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---

> > +static void qcom_pcie_host_deinit(struct qcom_pcie *pcie)
> > +{
> > +	qcom_ep_reset_assert(pcie);
> > +	if (pcie->cfg->ops->post_deinit)
> > +		pcie->cfg->ops->post_deinit(pcie);
> > +	phy_power_off(pcie->phy);
> > +	pcie->cfg->ops->deinit(pcie);
> 
> These post_deinit/deinit names look backwards.  Why would we call a
> "post_deinit()" method *before* the "deinit()" method?  It would make
> sense if we called "pre_deinit()" followed by "deinit()".

Yeah, that annoys me as well, but those are the names the driver
currently use.

I considered renaming the deinit callback but instead sent a follow up
patch to remove both of these callbacks now that the pipe clock rework
that depends on them has been merged, but seems like the post_init one
will be needed for the DBI accesses.

I can respin the above mentioned patch to drop or or rename the badly
named one when things settle down a bit.

> >  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> >  	.host_init = qcom_pcie_host_init,
> >  };
> > @@ -1651,6 +1660,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >  	return ret;
> >  }
> >  
> > +static int qcom_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> > +	struct device *dev = &pdev->dev;
> > +
> > +	dw_pcie_host_deinit(&pcie->pci->pp);
> > +	qcom_pcie_host_deinit(pcie);
> > +
> > +	phy_exit(pcie->phy);
> > +
> > +	pm_runtime_put_sync(dev);
> > +	pm_runtime_disable(dev);
> 
> Why is this not more symmetric with qcom_pcie_probe()?  Maybe struct
> dw_pcie_host_ops needs a new .host_deinit() pointer that would be
> called from dw_pcie_host_deinit()?

Yeah, I considered that too but decided it's not needed to implement
modular builds for this driver. Instead I did the ground work by adding
a deinit helper function so that it's easier to track any additions to
the host_init() callback and which can later be called by core if
someone decides to clean up core and add a deinit callback.

Looks like someone just posted something along these lines, but this
would conflict with the split MSI series which is otherwise ready to be
merged:

	https://lore.kernel.org/r/20220624143947.8991-9-Sergey.Semin@baikalelectronics.ru

Also note that there are other drivers that implement remove() without
this callback already today.

> In the probe path, we have this:
> 
>   qcom_pcie_probe
>     pm_runtime_enable
>     pm_runtime_get_sync
>     phy_init(pcie->phy)
>     dw_pcie_host_init
>       pp->ops->host_init
>         qcom_pcie_host_init             # .host_init()
>           pcie->cfg->ops->init(pcie)
>           phy_power_on(pcie->phy)
>           pcie->cfg->ops->post_init(pcie)
>           qcom_ep_reset_deassert(pcie)
> 
> The remove path does do things in the opposite order, which makes
> sense, but the call to qcom_pcie_host_deinit() breaks the symmetry:
> 
>   qcom_pcie_remove
>     dw_pcie_host_deinit
>     qcom_pcie_host_deinit
>       qcom_ep_reset_assert
>       pcie->cfg->ops->post_deinit
>       phy_power_off(pcie->phy)
>       pcie->cfg->ops->deinit
>     phy_exit(pcie->phy)
>     pm_runtime_put_sync
>     pm_runtime_disable

Yeah, I didn't want to go rewrite core just for this basic driver
functionality. Especially with so many things already in flux.

As mentioned above, everything is instead prepared to move over to such
a callback if and when it materialises.

Johan
