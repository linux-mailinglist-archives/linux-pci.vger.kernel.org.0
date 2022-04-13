Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C7D4FF33B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiDMJUZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiDMJUY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 05:20:24 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Apr 2022 02:18:01 PDT
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5B52B29;
        Wed, 13 Apr 2022 02:17:53 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 84BEC20A6058
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 3/6] PCI: rcar-gen2: Add R9A06G032 support
To:     Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20220412094029.287562-1-herve.codina@bootlin.com>
 <20220412094029.287562-4-herve.codina@bootlin.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <75be60ce-d9b2-b9a0-c897-3cc904889db6@omp.ru>
Date:   Wed, 13 Apr 2022 12:08:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220412094029.287562-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 4/12/22 12:40 PM, Herve Codina wrote:

> Add Renesas R9A06G032 SoC support to the Renesas R-Car gen2 PCI
> bridge driver.
> The Renesas RZ/N1D (R9A06G032) internal PCI bridge is compatible
> with the one available in the R-Car Gen2 family.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/pci/controller/pci-rcar-gen2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
> index 528bc3780e01..586e4785a57f 100644
> --- a/drivers/pci/controller/pci-rcar-gen2.c
> +++ b/drivers/pci/controller/pci-rcar-gen2.c
> @@ -352,6 +352,8 @@ static const struct of_device_id rcar_pci_of_match[] = {
>  	{ .compatible = "renesas,pci-r8a7791", },
>  	{ .compatible = "renesas,pci-r8a7794", },
>  	{ .compatible = "renesas,pci-rcar-gen2", },
> +	{ .compatible = "renesas,pci-r9a06g032", },

   Do we really need this one here? Isn't it covered by the next item?

> +	{ .compatible = "renesas,pci-rzn1", },
>  	{ },
>  };
>  

MBR, Sergey
