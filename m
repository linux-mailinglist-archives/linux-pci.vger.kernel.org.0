Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73C5841E7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 16:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiG1Okx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiG1Okg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 10:40:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E669F32;
        Thu, 28 Jul 2022 07:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 018F8B82484;
        Thu, 28 Jul 2022 14:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73272C433C1;
        Thu, 28 Jul 2022 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659019107;
        bh=PzTyW5XDvX426b+qr4yqw7MdaUS0RZKB/42aqH1QEyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cQIWqK7G5qHhJinwmsf8nCjYKjC40bgwRARdhVnaNZrIMu/Z52VdSYNhvOZ24x2jH
         1BD29MHdZ3a2cPa0NvFJeKxObQJKeVhOR997twrCGLbaTzACREZ7iT4Hc8S6izx+Nb
         l4ebRU06R7YQec4czw7rmXYLaCGoHr4lZV9uVJGsg0yZMdPtUCxMgn3GY50mLVBCLp
         3P3kVGwcGKtXrdDmWTYD1IyrAIQGz2B1w+p3RU5g2LykfkcN3VknVlV3fVpEc7tCvj
         tDH62ZgV3ZN8E115s9kc8ke9y3DFdoqhJMb8WH3cMk6v//fQv9eXfpzqT5qv2NGweZ
         O6jerW2ecHY/Q==
Date:   Thu, 28 Jul 2022 09:38:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 02/15] PCI: dwc: Detect iATU settings after
 getting "addr_space" resource
Message-ID: <20220728143825.GA298132@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624143947.8991-3-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:34PM +0300, Serge Semin wrote:
> The iATU detection procedure was introduced in the commit 281f1f99cf3a
> ("PCI: dwc: Detect number of iATU windows"). A bit later the procedure
> execution was moved to Host/EP-specific methods in the framework of commit
> 8bcca2658558 ("PCI: dwc: Move iATU detection earlier"). The later
> modification wasn't done in the most optimal way since the "addr_space"
> CSR region resource doesn't depend on anything detected in the
> dw_pcie_iatu_detect() method. Thus the detection can be postponed to be
> executed after the resource request which can fail and make the detection
> pointless. It will be also helpful for the dw_pcie_ep_init() method
> readability since we are about to add the IP-core version and eDMA module
> (a bit later) detection procedures.

The patch is fine, but IMO the commit log is overkill.  It's enough to
say that we do some work (dw_pcie_iatu_detect()) earlier than
necessary, so we can move it later.  All the history makes it seem
like this is more complicated than it really is.

Something like this is enough:

    Previously, dw_pcie_ep_init() did:

      dw_pcie_iatu_detect(pci);
      res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
      if (!res)
        return -EINVAL;

    The platform_get_resource_byname() can fail, and dw_pcie_iatu_detect()
    doesn't depend on the "addr_space" resource, so delay it until afterwards,
    i.e.,

      platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
      dw_pcie_iatu_detect(pci);

No need to repost for this.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v2:
> - This is a new patch added on v2 iteration of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 15b8059544e3..1e35542d6f72 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -704,8 +704,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		}
>  	}
>  
> -	dw_pcie_iatu_detect(pci);
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>  	if (!res)
>  		return -EINVAL;
> @@ -713,6 +711,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> +	dw_pcie_iatu_detect(pci);
> +
>  	ep->ib_window_map = devm_kcalloc(dev,
>  					 BITS_TO_LONGS(pci->num_ib_windows),
>  					 sizeof(long),
> -- 
> 2.35.1
> 
