Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D88150BD7A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 18:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449827AbiDVQum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386269AbiDVQul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 12:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B685F265;
        Fri, 22 Apr 2022 09:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81FCB62117;
        Fri, 22 Apr 2022 16:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7928BC385A0;
        Fri, 22 Apr 2022 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650646066;
        bh=w1qcxjgX+1d8NUij8QnC2gvBWuSGhmDYEIfSULLHp4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Gezo8m3gEr5nx5XLkdGXI42ucp3Bepkhw4Oxz5QNc1duj2Uz86gVqCOF2l0Z1ICSA
         k5/AXoBRPP2BT3IpoqC88gbJDQAE68D+rGlnyWWVjL2bMSUQmfMAiCeANXm54M6JMa
         ctxWozcf59fUm1193SB4kKBF7mi3RK0wS8WD71wSxXIy7coP9BRTJKTJTeMao5IqLY
         VTadPGYReNmekFi5o6RcNGM7IdM4vsyFFRM7I0J/gskPkRLmCTOyJ9KbfsOmOYMQ9f
         nJpuI+bMIns67RdQhib9TTWWuuFHyuIlNXXdnjga+w2c2knL+JvRVH/kB2eFEtWVlQ
         x1r2KzfrI4kaA==
Date:   Fri, 22 Apr 2022 11:47:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 3/8] PCI: rcar-gen2: Add RZ/N1 SOCs support
Message-ID: <20220422164744.GA1460864@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422120850.769480-4-herve.codina@bootlin.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 02:08:45PM +0200, Herve Codina wrote:
> Add Renesas RZ/N1 SOCs family support to the Renesas R-Car
> gen2 PCI bridge driver.
> The Renesas RZ/N1 SOCs internal PCI bridge is comptible with
> the one available in the R-Car Gen2 family.
> Tested with the RZ/N1D (R9A06G032) SOC.

Nits (only address if you have some other reason to repost this
series):

  - Subject claims this adds "support," which suggests that this adds
    some piece of new functionality.  But it adds no new
    functionality, it merely adds a new compatible string.  I would
    say "Add RZ/N1 SOC compatible string"

  - Add blank lines between paragraphs

  - Rewrap paragraphs to fill 75 characters

  - s/comptible/compatible/

  - s/R-Car gen2/R-Car Gen2/ to write this consistently instead of
    capitalizing "Gen2" sometimes but not others

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/pci/controller/pci-rcar-gen2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
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
