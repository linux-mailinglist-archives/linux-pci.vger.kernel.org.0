Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D5676CFC
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jan 2023 13:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjAVMwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Jan 2023 07:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVMwO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Jan 2023 07:52:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C471DBBC;
        Sun, 22 Jan 2023 04:52:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3979B60BF0;
        Sun, 22 Jan 2023 12:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B07EC433EF;
        Sun, 22 Jan 2023 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674391932;
        bh=oLFBGfh6cmm2oxJQ8cei4LDtcDwuCA61Xd24/7G9vgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=op0h+VDhjlqsWLWThMKXvxZrFH9gWEQDFJuEadT0/iAGW//oT/qDwEy00AxfL7MNi
         qW9or04vZ4fPmnPire9gaSHK+d1PMrfz0F00+EGBYy28dgxrssOsAdR/m7hmt0P1mG
         2SNSWaLp13zsi/n4T5mKBK3dc/3VvVlTGCxXMLJ9Mzx9o+xU07x+TRgA9Y11QSlulJ
         klIoN6Qi+t13IcOxf/rWotHfV2amgeGj7GQWhwmfoXJeX1QXwCSIChMbpXdbpTIanc
         X5lig6SYU85X66L8B8H4QEFU5HCNNMx+h3s05zxxDAlgZIFKARnOUmKqpNBmzRDVfv
         l6CeSOgSdB4fg==
Date:   Sun, 22 Jan 2023 14:52:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lizhe <sensor1010@163.com>, bhelgaas@google.com,
        tglx@linutronix.de, darwi@linutronix.de, jgg@ziepe.ca,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drivers/msi.c : use devm_ioremap replace ioremap
Message-ID: <Y80xeG+eEdVLn003@unreal>
References: <20230121170420.8681-1-sensor1010@163.com>
 <86h6win8w6.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86h6win8w6.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 22, 2023 at 10:47:21AM +0000, Marc Zyngier wrote:
> On Sat, 21 Jan 2023 17:04:20 +0000,
> Lizhe <sensor1010@163.com> wrote:
> > 
> > use devm_ioremap replace ioremap
> > 
> > Signed-off-by: Lizhe <sensor1010@163.com>
> > ---
> >  drivers/pci/msi/msi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > index 1f716624ca56..184eca85b88b 100644
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -566,7 +566,7 @@ static void __iomem *msix_map_region(struct pci_dev *dev,
> >  	table_offset &= PCI_MSIX_TABLE_OFFSET;
> >  	phys_addr = pci_resource_start(dev, bir) + table_offset;
> >  
> > -	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
> > +	return devm_ioremap(&dev->dev, phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
> >  }
> 
> And where is the unmap dealt with? From what I can see, this will
> probably explode when the device is removed...

Right, he/she sends many random patches like this.
https://lore.kernel.org/all/Y8Pt+IdfWBVy8nIA@unreal/

Thanks

> 
> 	 M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
