Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25D9699E3B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 21:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBPUtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 15:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBPUtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 15:49:35 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E95474BEA8
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 12:49:32 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0EB83E0EAC;
        Thu, 16 Feb 2023 23:49:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=OZEQUZdQIv6Cu1gdvBFM
        +xDwwxYwA+v1A3rjEqGslAA=; b=ZqYsvUZH0BPZsO9fi+G+BGF2vjOnIIIQVx57
        OoXPqKeQukZgS9enwAboJNfqUB/W1jngOWh8AvCoC6HAIFxMQq3xLtrxRIFYP9Ly
        RkkbUCgK1v0gu9GA7qvybg9faYGWWOL4WEzVYC0Bwl6BrLZpl7HQOkIHsoWgKHUX
        Dw/UiL0=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EA6B7E0E1C;
        Thu, 16 Feb 2023 23:49:31 +0300 (MSK)
Received: from mobilestation (10.8.30.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 16 Feb 2023 23:49:30 +0300
Date:   Thu, 16 Feb 2023 23:49:30 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Message-ID: <20230216204930.jvxt3ajny2eymbtn@mobilestation>
References: <20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com>
 <20230216175822.GA3321300@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230216175822.GA3321300@bhelgaas>
X-Originating-IP: [10.8.30.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 16, 2023 at 11:58:22AM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 16, 2023 at 06:20:12PM +0900, Yoshihiro Shimoda wrote:
> > The "val" of PCIE_PORT_LINK_CONTROL will be reused on the
> > "Set the number of lanes". But, if snps,enable-cdm-check" exists,
> > the "val" will be set to PCIE_PL_CHK_REG_CONTROL_STATUS.
> > Therefore, unexpected register value is possible to be used
> > to PCIE_PORT_LINK_CONTROL register if snps,enable-cdm-check" exists.
> > So, read PCIE_PORT_LINK_CONTROL register again to fix the issue.
> > 
> > Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 6d5d619ab2e9..3bb9ca14fb9c 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -824,6 +824,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  	}
> >  
> >  	/* Set the number of lanes */
> > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> 
> Definitely a bug, thanks for the fix and the Fixes: tag.
> 

> But I would like the whole function better if it could be structured
> so we read PCIE_PORT_LINK_CONTROL once and wrote it once.  And the
> same for PCIE_LINK_WIDTH_SPEED_CONTROL.
>

I don't see a good looking solution for what you suggest. We'd need to
use additional temporary vars and gotos to implement that.

> Maybe there's a reason PCIE_PL_CHK_REG_CONTROL_STATUS must be written
> between the two PCIE_PORT_LINK_CONTROL writes or the two
> PCIE_LINK_WIDTH_SPEED_CONTROL writes, I dunno.  If so, a comment there
> about why that is would be helpful.

There were no sign of dependencies between the CDM-check enabling and
the rest of the setting performed in the dw_pcie_setup() function.
Originally the CDM-check was placed at the tail of the function:
07f123def73e ("PCI: dwc: Add support to enable CDM register check")
with no comments why it was placed there exactly. Moreover I got the
Rb-tag for my fix from Vidya Sagar, the original patch author. So he
was ok with the suggested solution.

-Serge(y)

> 
> >  	val &= ~PORT_LINK_FAST_LINK_MODE;
> >  	val &= ~PORT_LINK_MODE_MASK;
> >  	switch (pci->num_lanes) {
> > -- 
> > 2.25.1
> > 
> 

