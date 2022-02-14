Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5A4B5590
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 17:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356121AbiBNQGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 11:06:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356123AbiBNQGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 11:06:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFAE49F97;
        Mon, 14 Feb 2022 08:06:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B37DB811D8;
        Mon, 14 Feb 2022 16:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B92C340E9;
        Mon, 14 Feb 2022 16:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644854758;
        bh=n+vq94HfU6rfmXgl/cSDbf4YdmG3NAKMuYXhVK2OHso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JKD4aMf6G6NMoMHnydRADTZ/HkASxbT0EbypcNf4tE78AaTO9XPZi1Sjc+OQeBKW3
         OgmaVhXXlxc7qBNdjvPNYyfThdIW/jqaEqL9zdNOSfChbQpaEi5p6VdSgmrwx55fCn
         Gr+rpOXXEj0zp23Ho+W7zRiL4rKYMiouqbDoLP+q1/MusNBjbxURdqIRhL/lTyvTJO
         YCLzytW30se3eOkYbVsvFLWXGMFJHN6m0mlw6tvgbdftqpeKxHqrfr87/Zw/gwAz/4
         0TZ0D+XxRElfpKUXTCtWSkoiZxIoJlb8jx2oXsJZ6pozBE/djdJ8TDgzSQSWw95JbG
         03DeTlwo63c2Q==
Date:   Mon, 14 Feb 2022 10:05:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.comv,
        linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, david.abdurachmanov@gmail.com,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] PCI: fu740: fix finding GPIOs
Message-ID: <20220214160556.GA9253@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214082144.1176084-2-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob for possible DT/kernel match issue,
Lorenzo (native host bridge driver maintainer)]

s/fix finding/Fix finding/ (in subject)
Or even better, say something specific about the DT properties in
question, e.g., look for "reset" instead of "reset-gpios".

On Mon, Feb 14, 2022 at 08:21:43AM +0000, Ben Dooks wrote:
> The calls to devm_gpiod_get_optional() have the -gpios at the end of
> the name. This means the pcie driver is not finding the necessary
> reset or power GPOOs to allow the PCIe devices on the SiFive Unmatched
> boards.

s/pcie/PCIe/
s/GPOOs/GPIOs/
"to allow the PCIe devices ...?"  Something is missing from this
sentence.  "To allow the devices <to do what>"?  Or maybe the driver
needs these GPIOs to power up the PCIe devices?

I guess the implication is that the code looks for "reset-gpios" and
"pwren-gpios", but the DT contains "reset" and "pwren"?

But both Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
and arch/riscv/boot/dts/sifive/fu740-c000.dtsi actually do contain
"reset-gpios" and "pwren-gpios".

If we *do* want to change the code, please change the error messages
to match.

> This has not been a noted bug as the PCIe probe from u-boot has been
> required to get the PCIe working due to other issues with the system
> setup. It could have been broken since the driver inclusion, and not
> been noticed as it is not necessary for the driver to funciton.

s/u-boot/U-Boot/
s/funciton/function/

Please add a line about what the connection between U-Boot and this
issue is, e.g., maybe U-Boot powers up the devices, so we wouldn't
notice the kernel's inability to do so?

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
