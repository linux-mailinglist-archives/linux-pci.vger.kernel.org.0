Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A83624D0B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiKJVct (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiKJVcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:32:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC013554F1;
        Thu, 10 Nov 2022 13:32:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0A193CE250B;
        Thu, 10 Nov 2022 21:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3442C433D6;
        Thu, 10 Nov 2022 21:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668115961;
        bh=X+IjlfiqIXTsy2UpCIUeFlBhZS6jWwbpzGFfAP5Hxfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OpEdw6rMlptPdAg/70b0VExq+MmfIX0dgpOr7i8lt7DULlosQTzZZ9NdFEfqJTt9G
         igjizIWFHPuz4NFFZnU3KdhIonjoFRmADOUVs8kXKxSYqT6g2wzEYfVqpGbu1KmA+Q
         0F8uc2RsuN4RG3TOLnnoykO5qESxLp0TCdYC9nlLYtz0lkmkKYm6iet6EXl1vfBNet
         ta83ArAmsrk4tuWdvJYb53dROi19T/GikkrbyaCmkfu54S57HI5ldAzyw/NYHgf0xu
         4kY2323Vzsm+jEMJOM6NqO5Mx2J9THoRdLonVgf9dUwBaliEoJ3N9qUaZoZ9peZvBG
         9bZl9K08peLIQ==
Date:   Thu, 10 Nov 2022 15:32:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     JunDong Song <jundongsong1@gmail.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc-host: Add a warning to prevent invalid
 values
Message-ID: <20221110213239.GA672651@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107153108.5770-1-jundongsong1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The subject lines are not quite accurate.  The warning does nothing to
*prevent* invalid values; it only warns about them.

And it should say what *kind* of values we're talking about.

Maybe:

  PCI: dwc: Warn about invalid 'max-link-speed' from DT

On Mon, Nov 07, 2022 at 11:31:07PM +0800, JunDong Song wrote:
> of_pci_get_max_link_speed() may return a negative value,
> causing the controller to not set the speed correctly.
> Add a warning in case the driver engineer misses it.

Rewrap this to fill 75 columns.

I would probably squash these into a single patch since they're
doing exactly the same thing to the host and endpoint cases.

> Signed-off-by: JunDong Song <jundongsong1@gmail.com>
> ---
> 
> When I use the pcie dwc driver, the controller speed is abnormal,
> but it has not been detected because of the @max-link-speed error,
> so I think I need to return an error or warning here.
> 
> Thanks.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 83ddb1902..573342601 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -739,8 +739,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -ENOMEM;
>  	ep->outbound_addr = addr;
>  
> -	if (pci->link_gen < 1)
> +	if (pci->link_gen < 1) {
>  		pci->link_gen = of_pci_get_max_link_speed(np);
> +		if (unlikely(pci->link_gen < 0))

Using "unlikely" here is unnecessary since this is not a performance
path, and it's a distraction.

> +			dev_warn(dev, "Failed to get max link speed\n");
> +	}
>  
>  	epc = devm_pci_epc_create(dev, &epc_ops);
>  	if (IS_ERR(epc)) {
> -- 
> 2.25.1
> 
