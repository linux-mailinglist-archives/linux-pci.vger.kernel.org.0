Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC80921B668
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGJNaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 09:30:01 -0400
Received: from foss.arm.com ([217.140.110.172]:46612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgGJNaB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 09:30:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD5431FB;
        Fri, 10 Jul 2020 06:30:00 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AED53F8C6;
        Fri, 10 Jul 2020 06:29:58 -0700 (PDT)
Date:   Fri, 10 Jul 2020 14:29:50 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v5 6/6] PCI: uniphier: Use
 devm_platform_ioremap_resource_byname()
Message-ID: <20200710132950.GA5540@e121166-lin.cambridge.arm.com>
References: <1592469493-1549-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1592469493-1549-7-git-send-email-hayashi.kunihiko@socionext.com>
 <f7138d4c-be56-5519-fbb2-3c655945f5ff@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7138d4c-be56-5519-fbb2-3c655945f5ff@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 09:54:12AM +0900, Kunihiko Hayashi wrote:
> Hi Lorenzo,
> 
> This 6/6 patch has just been covered with the following patch:
> https://patchwork.ozlabs.org/project/linux-pci/patch/20200708164013.5076-1-zhengdejin5@gmail.com/
> 
> As a result, my other patches conflict with this patch.
> I'd like your comments in the patch 2/6, though,
> should I rebase to pci/dwc and resend this series without 6/6?

No, don't worry about patch (6). I will review patch (2) shortly.

Thanks,
Lorenzo

> Thank you,
> 
> On 2020/06/18 17:38, Kunihiko Hayashi wrote:
> > Use devm_platform_ioremap_resource_byname() to simplify the code a bit.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>f
> > ---
> >   drivers/pci/controller/dwc/pcie-uniphier.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> > index 8356dd3..233d624 100644
> > --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > @@ -456,8 +456,7 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
> >   	if (IS_ERR(priv->pci.atu_base))
> >   		priv->pci.atu_base = NULL;
> > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
> > -	priv->base = devm_ioremap_resource(dev, res);
> > +	priv->base = devm_platform_ioremap_resource_byname(pdev, "link");
> >   	if (IS_ERR(priv->base))
> >   		return PTR_ERR(priv->base);
> > 
> 
> ---
> Best Regards
> Kunihiko Hayashi
