Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D48C4DCD7F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 19:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiCQSY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiCQSY7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 14:24:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBF9DCAB0
        for <linux-pci@vger.kernel.org>; Thu, 17 Mar 2022 11:23:41 -0700 (PDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DFAE03F221
        for <linux-pci@vger.kernel.org>; Thu, 17 Mar 2022 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647541418;
        bh=mAdVcJhToSrCB/a7t8Sh+35WYqrUG3pwc0slS8rIHHU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=nYNzwzs0EG1a39Yp6tbpDyEeG/DgC06ulQEGkx5zGuFUG6OLmLPsClTClxQ8HAgpE
         PVtcdU/yYLEsQljfE5xfnXdzSyd5ILkyGi2SctNHaqRanXoTYIhTqFXNQnq1WZiQSS
         fqbYREk6ZwP1uruwGlLjGHVMDLEN5auYy5JBB3lBHKtuBsPB+5N+3xw/UPxS3aFW+W
         FcOF1y1IQaJxYmlKgyzIITfYC/jP6MVN2hlwulGOMdfKMGWoDRst1a3U2RGZRzq84G
         qBoQUfF6GBtUCntzQHtNv1fQf5DHC5fSynecxlz8lkV+lzaN8tU0v6TrSL/XQj+14C
         PQBfIXFUYl11A==
Received: by mail-il1-f198.google.com with SMTP id 3-20020a056e020ca300b002c2cf74037cso3539310ilg.6
        for <linux-pci@vger.kernel.org>; Thu, 17 Mar 2022 11:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mAdVcJhToSrCB/a7t8Sh+35WYqrUG3pwc0slS8rIHHU=;
        b=BduWXKjD6Np2dQDHfJHuuDJlTBuCenDcwJrhn8YPXVnpq4Q4c+UuyvJPCBYBhirwGv
         ogXXepw/fdk34AuglL7sVmYguTXcf7yBfYRV8UHApZ+jxmnYIPtiUEMG9+2UeiPqWkrK
         YSCV/Eqo9sPd9eyk3+XLAUpGW8Ze2AWfdsfaOrVb/A1HxEGlxS7Orn+1TSI5Xati6/Ak
         vvNeY1HlA7Qfn6V5UFTj4mIR5zco+3kFR8/nA62vOG99e3irVd4fkQuef0w8fP7lCPSO
         TDUqDV4WdLr5oOgWnBB8F1x993x2bo6UWGdsa19wINcmYe9EpxfQu4Ntce7Z/928brIo
         uARA==
X-Gm-Message-State: AOAM530hgOUSX47112X2wena9i9dJL2ESSHnuaeQXgk9i8vx7XApkOlL
        HGNtACzYAtmODaNZdlxBQ9R/voy2hHgpsj18gtyw2DvZzCa3VZBcP0EAvX6a1MvcnP/G5+Rv+37
        bqdkmW+4Hb2yER4xUHoYtcXk4MOswfOpzjE6xBQ==
X-Received: by 2002:a05:6638:14c1:b0:319:dd1c:e179 with SMTP id l1-20020a05663814c100b00319dd1ce179mr2953220jak.64.1647541417552;
        Thu, 17 Mar 2022 11:23:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydmsovQdnsv6/vsumr0R6jzDnWMQIUt88oHLcsHXh5GhykfJlRwpHtRjlwxttQFLYXvPCreQ==
X-Received: by 2002:a05:6638:14c1:b0:319:dd1c:e179 with SMTP id l1-20020a05663814c100b00319dd1ce179mr2953204jak.64.1647541417263;
        Thu, 17 Mar 2022 11:23:37 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
        by smtp.gmail.com with ESMTPSA id n5-20020a056e02148500b002c7aa9c389csm3840370ilk.32.2022.03.17.11.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:23:35 -0700 (PDT)
Date:   Thu, 17 Mar 2022 12:23:33 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Toan Le <toan@os.amperecomputing.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] PCI: xgene: Revert "PCI: xgene: Use inbound resources
 for setup"
Message-ID: <YjN8pT5e6/8cRohQ@xps13.dannf>
References: <20220314144429.1947610-1-maz@kernel.org>
 <YjL8P0zkle2foxbk@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YjL8P0zkle2foxbk@lpieralisi>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 17, 2022 at 09:15:43AM +0000, Lorenzo Pieralisi wrote:
> [removed CC stable]
> 
> On Mon, Mar 14, 2022 at 02:44:29PM +0000, Marc Zyngier wrote:
> > Commit 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup")
> > killed PCIe on my XGene-1 box (a Mustang board). The machine itself
> > is still alive, but half of its storage (over NVMe) is gone, and the
> > NVMe driver just times out.
> > 
> > Note that this machine boots with a device tree provided by the
> > UEFI firmware (2016 vintage), which could well be non conformant
> > with the spec, hence the breakage.
> > 
> > With the patch reverted, the box boots 5.17-rc8 with flying colors.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Toan Le <toan@os.amperecomputing.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Krzysztof Wilczyński <kw@linux.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Stéphane Graber <stgraber@ubuntu.com>
> > Cc: dann frazier <dann.frazier@canonical.com>
> > Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> > Cc: stable@vger.kernel.org>
> > ---
> >  drivers/pci/controller/pci-xgene.c | 33 ++++++++++++++++++++----------
> >  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> Dann, Rob,
> 
> does this fix the regression debated here:
> 
> https://lore.kernel.org/all/Yf2wTLjmcRj+AbDv@xps13.dannf
> 
> It is unclear in that thread what the conclusion reached was.

Thanks for checking in Lorenzo! Reverting that patch is required but
not sufficient to get our m400s working. In addition, we'd also need
to revert commit c7a75d07827a ("PCI: xgene: Fix IB window setup").

I believe if we revert both then it should return us to a state where
Marc's Mustang, Stéphane's Merlins and our m400s all work again.

  -dann

> Thanks,
> Lorenzo
> 
> > diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> > index 0d5acbfc7143..aa41ceaf031f 100644
> > --- a/drivers/pci/controller/pci-xgene.c
> > +++ b/drivers/pci/controller/pci-xgene.c
> > @@ -479,28 +479,27 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
> >  }
> >  
> >  static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
> > -				    struct resource_entry *entry,
> > -				    u8 *ib_reg_mask)
> > +				    struct of_pci_range *range, u8 *ib_reg_mask)
> >  {
> >  	void __iomem *cfg_base = port->cfg_base;
> >  	struct device *dev = port->dev;
> >  	void __iomem *bar_addr;
> >  	u32 pim_reg;
> > -	u64 cpu_addr = entry->res->start;
> > -	u64 pci_addr = cpu_addr - entry->offset;
> > -	u64 size = resource_size(entry->res);
> > +	u64 cpu_addr = range->cpu_addr;
> > +	u64 pci_addr = range->pci_addr;
> > +	u64 size = range->size;
> >  	u64 mask = ~(size - 1) | EN_REG;
> >  	u32 flags = PCI_BASE_ADDRESS_MEM_TYPE_64;
> >  	u32 bar_low;
> >  	int region;
> >  
> > -	region = xgene_pcie_select_ib_reg(ib_reg_mask, size);
> > +	region = xgene_pcie_select_ib_reg(ib_reg_mask, range->size);
> >  	if (region < 0) {
> >  		dev_warn(dev, "invalid pcie dma-range config\n");
> >  		return;
> >  	}
> >  
> > -	if (entry->res->flags & IORESOURCE_PREFETCH)
> > +	if (range->flags & IORESOURCE_PREFETCH)
> >  		flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
> >  
> >  	bar_low = pcie_bar_low_val((u32)cpu_addr, flags);
> > @@ -531,13 +530,25 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
> >  
> >  static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie *port)
> >  {
> > -	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
> > -	struct resource_entry *entry;
> > +	struct device_node *np = port->node;
> > +	struct of_pci_range range;
> > +	struct of_pci_range_parser parser;
> > +	struct device *dev = port->dev;
> >  	u8 ib_reg_mask = 0;
> >  
> > -	resource_list_for_each_entry(entry, &bridge->dma_ranges)
> > -		xgene_pcie_setup_ib_reg(port, entry, &ib_reg_mask);
> > +	if (of_pci_dma_range_parser_init(&parser, np)) {
> > +		dev_err(dev, "missing dma-ranges property\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Get the dma-ranges from DT */
> > +	for_each_of_pci_range(&parser, &range) {
> > +		u64 end = range.cpu_addr + range.size - 1;
> >  
> > +		dev_dbg(dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
> > +			range.flags, range.cpu_addr, end, range.pci_addr);
> > +		xgene_pcie_setup_ib_reg(port, &range, &ib_reg_mask);
> > +	}
> >  	return 0;
> >  }
> >  
