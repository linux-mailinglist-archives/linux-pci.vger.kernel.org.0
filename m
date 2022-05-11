Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC4B522FA9
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiEKJnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 05:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiEKJnG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 05:43:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9579F13F1CE;
        Wed, 11 May 2022 02:43:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 650B81FB;
        Wed, 11 May 2022 02:43:05 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E5163F73D;
        Wed, 11 May 2022 02:43:01 -0700 (PDT)
Date:   Wed, 11 May 2022 10:42:57 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 3/6] PCI: rcar-gen2: Add RZ/N1 SOCs family compatible
 string
Message-ID: <YnuFIfcq1Wg9Nh1L@lpieralisi>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
 <20220429134143.628428-5-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429134143.628428-5-herve.codina@bootlin.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 29, 2022 at 03:41:40PM +0200, Herve Codina wrote:
> Add the Renesas RZ/N1 SOCs family support to the Renesas R-Car Gen2
> PCI bridge driver.
> 
> The Renesas RZ/N1 SOCs internal PCI bridge is compatible with the one
> available in the R-Car Gen2 family.
> 
> Tested with the RZ/N1D (R9A06G032) SOC.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pci/controller/pci-rcar-gen2.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

I assume this series will be picked up by platforms maintainers.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
> index 35804ea394fd..839695791757 100644
> --- a/drivers/pci/controller/pci-rcar-gen2.c
> +++ b/drivers/pci/controller/pci-rcar-gen2.c
> @@ -328,6 +328,7 @@ static const struct of_device_id rcar_pci_of_match[] = {
>  	{ .compatible = "renesas,pci-r8a7791", },
>  	{ .compatible = "renesas,pci-r8a7794", },
>  	{ .compatible = "renesas,pci-rcar-gen2", },
> +	{ .compatible = "renesas,pci-rzn1", },
>  	{ },
>  };
>  
> -- 
> 2.35.1
> 
