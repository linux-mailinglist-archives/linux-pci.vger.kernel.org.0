Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80A1495599
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 21:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbiATUpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 15:45:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43826 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347236AbiATUpJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 15:45:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 424CD61865
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 20:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51711C340E0;
        Thu, 20 Jan 2022 20:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642711508;
        bh=a88irtrpHyTXFEJChpvrjofK80Arq6Dau38IGAmiUwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=absrxxQEGYn50Lfr2hIV1Nn9ld+W7lnPMOtbK+UfI8jJBTNPgCdXjsOdrFsKr57K/
         Sp43xd1ZAo0FqaJVKxIC5NS0sOWL5C7SBEvv3+GknaxZJdeeuz2GAnJ5hHx31efsHL
         21jRWY2YqpL0NWdz+hkD9yg+C3i9cQGiUuyOCtRLph2TqafuukhGjfWZPqL4u9HIaj
         LxZA6cI7H3nOmn7K0YUP0SiymBquGYMenldoIwhfWm5SVFSDRnmHwEzGMw/Wg1j67z
         CG9xth/5dc44GnHZuaR0QMBiJMbtUYjFMxzNzGgYSw/V84KRvdRYLd0wuCS2fy20rg
         3BSVryZj1OX5w==
Received: by pali.im (Postfix)
        id 8F980791; Thu, 20 Jan 2022 21:45:05 +0100 (CET)
Date:   Thu, 20 Jan 2022 21:45:05 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 3/4] libpci: Add support for filling bridge
 resources
Message-ID: <20220120204505.pwsgfutwh563y3ug@pali>
References: <20211231222748.xriixk5etfya2xbn@pali>
 <20220120203352.GA1061051@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220120203352.GA1061051@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 20 January 2022 14:33:52 Bjorn Helgaas wrote:
> On Fri, Dec 31, 2021 at 11:27:48PM +0100, Pali Rohár wrote:
> > On Sunday 26 December 2021 23:20:27 Pali Rohár wrote:
> > > On Sunday 26 December 2021 23:13:11 Martin Mareš wrote:
> > > > Hi!
> > > > 
> > > > > +      else if (i < 7+6+4)
> > > > > +        {
> > > > > +          /*
> > > > > +           * If kernel was compiled without CONFIG_PCI_IOV option then after
> > > > > +           * the ROM line for configured bridge device (that which had set
> > > > > +           * subordinary bus number to non-zero value) are four additional lines
> > > > > +           * which describe resources behind bridge. For PCI-to-PCI bridges they
> > > > > +           * are: IO, MEM, PREFMEM and empty. For CardBus bridges they are: IO0,
> > > > > +           * IO1, MEM0 and MEM1. For unconfigured bridges and other devices
> > > > > +           * there is no additional line after the ROM line. If kernel was
> > > > > +           * compiled with CONFIG_PCI_IOV option then after the ROM line and
> > > > > +           * before the first bridge resource line are six additional lines
> > > > > +           * which describe IOV resources. Read all remaining lines in resource
> > > > > +           * file and based on the number of remaining lines (0, 4, 6, 10) parse
> > > > > +           * resources behind bridge.
> > > > > +           */
> > > > > +          lines[i-7].flags = flags;
> > > > > +          lines[i-7].base_addr = start;
> > > > > +          lines[i-7].size = size;
> > > > > +        }
> > > > > +    }
> > > > > +  if (i == 7+4 || i == 7+6+4)
> > > > 
> > > > This looks crazy: is there any other way how to tell what the
> > > > bridge entries mean?  Checking the number of entries looks very
> > > > brittle.
> > > 
> > > I do not know any other way. Just for reference, here is a link to
> > > the function resource_show() and DEVICE_COUNT_RESOURCE enum:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-sysfs.c?h=v5.15#n136
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/pci.h?h=v5.15#n94
> > 
> > I have also checked flags and there is no indication if resource is
> > assigned on bridge as BAR or is forwarded behind the bridge.
> > 
> > Bjorn, Krzysztof: any idea if something better than checking number
> > of entries in "resource" node can be used to determinate type of
> > entry at specified line in "resource" node?
> 
> That *is* crazy.  I'm sorry that resource_show() works that way, and
> that it gives no clue to identify BAR vs ROM vs IOV BAR vs CB window
> vs regular bridge window.
> 
> It's conceivable that we could add "io_window" and "mem_window" files
> or something similar.

Meanwhile I found out that in linux/ioport.h file is IORESOURCE_WINDOW
constant with comment /* forwarded by bridge */
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ioport.h?h=v5.15#n56

But apparently it is not set for resources behind PCI bridges and
therefore it is not available in column of "resources" sysfs file.

So maybe instead of adding new sysfs files, it would be better way to
implement this flag and export it in flags column of "resources" file
for every row which belongs to resources behind bridges?

But in any case changes in kernel does not help lspci/libpci which is
running on existing (unmodified) kernel.

> Does this patch fix a problem?  I'm not clear on what the benefit is.
> 
> Bjorn

My patch for libpci fixes it, but via counting number of rows in
"resources" sysfs file... which is crazy. But I do not see any other
option how to do it via currently available kernel APIs.
