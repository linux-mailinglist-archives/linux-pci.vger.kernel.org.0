Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23350546968
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245075AbiFJPad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 11:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiFJPa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 11:30:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2563A1A0;
        Fri, 10 Jun 2022 08:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E27D1CE36F6;
        Fri, 10 Jun 2022 15:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB5AC34114;
        Fri, 10 Jun 2022 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654875022;
        bh=ta96T6c2nNcPWAsBNRTtLMz9n9426tesAoUAX1Q+IMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QTha3y968nP9ETEGDQmF6NzJDQ2F4BQH3LJGoscUtpOb2lrMjg/UMPaLmZy04j5iK
         gu34asgm5pjSkdIl7Ps9AdUNL4no45ztjiHjUU0njH75skMJONKlY6nd0PiBk186He
         /4nCrqYWqWfh4s68LGCdn6YPMRt3QTU5S0oecdm6ozFzx0YIpWJc2xwGy15ITfs4aP
         qPUJQ5BaA3G3o1XWW50E8++U2X5Owivd6AUdImZGQONyIv3XeyaCzVkC6dbgdlsVfH
         KDwPtrt9lp3VSvJaMk9TyV5JJxwkJspPr3bxlOhm2haQI/PBdy+AukmtVQfKcFJ1Sq
         P0h/pRD7CRv0w==
Date:   Fri, 10 Jun 2022 10:30:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
Subject: Re: [PATCH v2 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Message-ID: <20220610153020.GA597980@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610000303epcms2p537e12cb268999b4d4bdeb4c76e2eb3dd@epcms2p5>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 09:03:03AM +0900, Wangseok Lee wrote:
> On 06/04/2022 01:03, Bjorn Helgaas wrote:
> > In the subject, why do you tag this "axis"?  There's an existing
> > pcie-artpec6.c that uses the driver name ""artpec6-pcie" and the
> > subject line tag "artpec6".
> > 
> > This adds pcie-artpec8.c with driver name "artpec8-pcie", so the
> > obvious choice would be "artpec8".
> > 
> > I assume you evaluated the possibility of extending artpec6 to support
> > artpec8 in addition to the artpec6 and artpec7 it already supports?
>  
> "pcie-artpec6. c" supports artpec6 and artpec7 H/W.
> artpec8 can not be expanded because H/W configuration is
> completely different from artpec6/7.
> phy and sub controller are different.

Thanks for this detail.  Can you include this in the commit log next
time around in case anybody else has a similar question?

> >> +/* FSYS SYSREG Offsets */
> > 
> > The list below seems to inclue more than just register offsets.
> > 
>  
> Is it clear to change to "FSYS blue logic system registers" 
> like Jasper Nilsson`s comment?
> https://lore.kernel.org/all/20220607070332.GY18902@axis.com/
> My opinion is the same.

Yep, that's fine.  But spell it "glue logic", not "blue logic" :)

> >> +static int artpec8_pcie_get_clk_resources(struct platform_device *pdev,
> >> +                                       struct artpec8_pcie *artpec8_ctrl)
> >> +{
> >> +        struct device *dev = &pdev->dev;
> >> +
> >> +        artpec8_ctrl->pipe_clk = devm_clk_get(dev, "pipe_clk");
> >> +        if (IS_ERR(artpec8_ctrl->pipe_clk)) {
> >> +                dev_err(dev, "couldn't get pipe clock\n");
> >> +                return -EINVAL;
> >> +        }
> >> +
> >> +        artpec8_ctrl->dbi_clk = devm_clk_get(dev, "dbi_clk");
> >> +        if (IS_ERR(artpec8_ctrl->dbi_clk)) {
> >> +                dev_info(dev, "couldn't get dbi clk\n");
> >> +                return -EINVAL;
> >> +        }
> >> +
> >> +        artpec8_ctrl->slv_clk = devm_clk_get(dev, "slv_clk");
> >> +        if (IS_ERR(artpec8_ctrl->slv_clk)) {
> >> +                dev_err(dev, "couldn't get slave clock\n");
> >> +                return -EINVAL;
> >> +        }
> >> +
> >> +        artpec8_ctrl->mstr_clk = devm_clk_get(dev, "mstr_clk");
> >> +        if (IS_ERR(artpec8_ctrl->mstr_clk)) {
> >> +                dev_info(dev, "couldn't get master clk\n");
> > 
> > It'd be nice if the err/info messages matched the exact DT name:
> > "pipe_clk", "dbi_clk", slv_clk", etc.
> > 
>  
> I will fix it.
>  
> > Why are some of the above dev_err() and others dev_info() when you
> > return -EINVAL in all cases?
>  
> When property is not found, it just to return error.
> I will modify to return PTR_ERR.

Using PTR_ERR() looks like a good idea, since then you return the
actual error from devm_clk_get() instead of always returning -EINVAL.

But that wasn't my comment.  My comment was that it looks like these
should be all dev_err() (or all dev_info()).

> >> +        switch (mode) {
> >> +        case DW_PCIE_RC_TYPE:
> >> +                artpec8_pcie_writel(artpec8_ctrl->elbi_base, DEVICE_TYPE_RC,
> >> +                                PCIE_ARTPEC8_DEVICE_TYPE);
> >> +                ret = artpec8_add_pcie_port(artpec8_ctrl, pdev);
> >> +                if (ret < 0)
> > 
> > Are there positive return values that indicate success?  Most places
> > above you assume "ret != 0" means failure, so just curious why you
> > test "ret < 0" instead of just "ret".
>  
> There is no special reason, but it seems that the format used 
> in the existing dw driver is applied.

Fair enough.  "git grep -A2 add_pcie_port drivers/pci/controller/"
says all *_add_pcie_port() calls use the same pattern, so thanks for
following that.

Bjorn
