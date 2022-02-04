Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1464AA38F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 23:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbiBDWxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 17:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiBDWxO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 17:53:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89ECC06134A;
        Fri,  4 Feb 2022 14:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B67ADB83954;
        Fri,  4 Feb 2022 22:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B7EC004E1;
        Fri,  4 Feb 2022 22:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644015190;
        bh=/GzwVvJMLbvFuL7505iRlddvcEtqGqqgxMSACzO5WaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SCVpnqN0O2Oeo+jsHYY7UyYnv8LrQu8v/cO91izw0Zs9hvvq2hXLdmscEji4rFGvO
         4RVO1ELuhL6b6ui5qdKFNgQ12FWmn2nziYmt7qR/M91iMcgxs77FjfsURueL/THNew
         bkxAIjyODRfFB63pWunMh1AN6cjSiVWSxf0jOh3MGFS0fQvsc22UCBJBJIShflV0ux
         SxeQ2X4ACfvBtpgXvzY6IZGxcnLmwIl9ZrR5QJCQt/e1CyyzAXF7Lb2a46NU5S99Ba
         /0LYuDB8NnUZBQt4sScS2ZoK9AVN3t77ImLm+NkChXapZ+I3ZkLZVw01Zz7wm6YCL+
         NJqaHHqyz4e3w==
Date:   Fri, 4 Feb 2022 16:53:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] PCI: fu740: fix finding gpios
Message-ID: <20220204225308.GA225749@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204173821.281784-1-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_20,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Follow subject line convention (s/fix/Fix/, s/gpios/GPIOs/).

On Fri, Feb 04, 2022 at 05:38:21PM +0000, Ben Dooks wrote:
> The calls to devm_gpiod_get_optional() have the -gpios on
> the name. This means the pcie driver is not finding the
> necessary reset or power gpios to allow the pcie devices
> on the SiFive Unmatched boards.
> 
> Note, this was workng around 5.16 and may not have been
> broken? There is still an issue if uboot has not probed
> the pcie bus then there are no pcie devices shown when
> Linux is started.

Wrap to fill 75 columns
s/gpios/GPIOs/
s/pcie/PCIe/
s/workng/working/
s/to allow the pcie devices/to allow the PCIe devices <to something>?/

I can't tell what this is saying.  It used to work and something broke
it?  If so, we should have a "Fixes:" tag to identify the commit that
broke it.

Or it used to work and "may *not* have been broken"?  I'm confused.

Unclear how uboot is involved.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/pci/controller/dwc/pcie-fu740.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> index 00cde9a248b5..842b7202b96e 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -259,11 +259,11 @@ static int fu740_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(afp->mgmt_base);
>  
>  	/* Fetch GPIOs */
> -	afp->reset = devm_gpiod_get_optional(dev, "reset-gpios", GPIOD_OUT_LOW);
> +	afp->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(afp->reset))
>  		return dev_err_probe(dev, PTR_ERR(afp->reset), "unable to get reset-gpios\n");
>  
> -	afp->pwren = devm_gpiod_get_optional(dev, "pwren-gpios", GPIOD_OUT_LOW);
> +	afp->pwren = devm_gpiod_get_optional(dev, "pwren", GPIOD_OUT_LOW);
>  	if (IS_ERR(afp->pwren))
>  		return dev_err_probe(dev, PTR_ERR(afp->pwren), "unable to get pwren-gpios\n");
>  
> -- 
> 2.34.1
> 
