Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B811737305
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjFTRgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFTRgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 13:36:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56BCF4
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 10:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66DE2612EE
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 17:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6368C433C8;
        Tue, 20 Jun 2023 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687282594;
        bh=kP26e6+U6+9ctDVxLVnSc7hcrP2+fq036d7O3k2kgTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SK4MBuPChPfMGDozATebPjhaGvjqVbt2uC3xUuslL+ItO43MkaoaIHpb7li4Nj935
         jNmjgu0qMwXCbdtRjs6z844mSaUBbI4W0l/FiLsRJj+DEQH1g9VYrENm+JzMzQuyel
         n1jeq1ZQAV1bqVq2xpEg2SkyxEUYvMibkp7OfdA0Bmxvp2VbpIoDpUEoXVtPqrfMGw
         oGVnJHV+jLXXPzHxHQKcDvUGzwvPv2Xy++mYv+6bSjgrCJVuUo7LBRTid4NmavU9U5
         i9PuVDF0rwdPTUNPlDSp6sWMO7ALWvzgWy8HwZNJJG6hfkpqiw0sL2jqFNDMU1+eg6
         nK2d0So3DGWRA==
Date:   Tue, 20 Jun 2023 19:36:30 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: vmd: Fix domain reset operation
Message-ID: <ZJHjnv4Fzn3EXR40@lpieralisi>
References: <20230530214706.75700-1-nirmal.patel@linux.intel.com>
 <605ab332-dade-3ce4-d73b-617d6fa2cd8b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <605ab332-dade-3ce4-d73b-617d6fa2cd8b@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 10:14:10AM -0700, Patel, Nirmal wrote:
> On 5/30/2023 2:47 PM, Nirmal Patel wrote:
> 
> > During domain reset process we are accidentally enabling
> > the prefetchable memory by writing 0x0 to Prefetchable Memory
> > Base and Prefetchable Memory Limit registers. As a result certain
> > platforms failed to boot up.
> >
> > Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
> >
> >   The Prefetchable Memory Limit register must be programmed to a smaller
> >   value than the Prefetchable Memory Base register if there is no
> >   prefetchable memory on the secondary side of the bridge.
> >
> > When clearing Prefetchable Memory Base, Prefetchable Memory
> > Limit and Prefetchable Base Upper 32 bits, the prefetchable
> > memory range becomes 0x0-0x575000fffff. As a result the

I don't get why the top 32 bits aren't cleared. The patch is
fine to me.

Lorenzo

> > prefetchable memory is enabled accidentally.
> >
> > Implementing correct operation by writing a value to Prefetchable
> > Base Memory larger than the value of Prefetchable Memory Limit.
> >
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> >  drivers/pci/controller/vmd.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 769eedeb8802..f3eb740e3028 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -526,8 +526,18 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
> >  				     PCI_CLASS_BRIDGE_PCI))
> >  					continue;
> >  
> > -				memset_io(base + PCI_IO_BASE, 0,
> > -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> > +				writel(0, base + PCI_IO_BASE);
> > +				writew(0xFFF0, base + PCI_MEMORY_BASE);
> > +				writew(0, base + PCI_MEMORY_LIMIT);
> > +
> > +				writew(0xFFF1, base + PCI_PREF_MEMORY_BASE);
> > +				writew(0, base + PCI_PREF_MEMORY_LIMIT);
> > +
> > +				writel(0xFFFFFFFF, base + PCI_PREF_BASE_UPPER32);
> > +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
> > +
> > +				writel(0, base + PCI_IO_BASE_UPPER16);
> > +				writeb(0, base + PCI_CAPABILITY_LIST);
> >  			}
> >  		}
> >  	}
> 
> Gentle reminder!
> Thanks.
> 
