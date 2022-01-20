Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB164955BF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 22:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347402AbiATVCQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 16:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbiATVCP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 16:02:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02EDC061574
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 13:02:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5271B61859
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 21:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7114AC340E0;
        Thu, 20 Jan 2022 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642712533;
        bh=zz2uyNWT1JAjXGrdAaF9iS4Z27EMFJec4F6lhjeDsZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MbXK87EqKommxe5TITOJxYxBkF3Adkft6xqnl+WnF3CVU6ZbjdL3zOsS4C6X/Ocvf
         emgtU2uyH62BqSAd5usroJltO1YIrftaUi2G5h/l2yekmATVF2MY/t1jvvHX5NF1bI
         K0X7qZfVTrvXRpX1/dfohPPF+X+zMoSU90LbSEXqeYzBq9biqfRils+xYMR4oUhDcN
         vrFqHuhuTm3K1pz1e44D49LASOyaxfF6sg7a0Jo/+GIR+q5j+p7rVsJdtj4DIslL2U
         mZazYSCfpOZ1oZQEEcKPeNfnoMpPH6jpeKe5+cdHjazrwAreCzCJPDtXBGWz1uihxl
         1Ao2ahJEJ8jSQ==
Date:   Thu, 20 Jan 2022 15:02:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 3/4] libpci: Add support for filling bridge
 resources
Message-ID: <20220120210212.GA1066435@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220120204505.pwsgfutwh563y3ug@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 09:45:05PM +0100, Pali Rohár wrote:
> On Thursday 20 January 2022 14:33:52 Bjorn Helgaas wrote:
> > On Fri, Dec 31, 2021 at 11:27:48PM +0100, Pali Rohár wrote:
> > > On Sunday 26 December 2021 23:20:27 Pali Rohár wrote:
> > > > On Sunday 26 December 2021 23:13:11 Martin Mareš wrote:
> > > > > Hi!
> > > > > 
> > > > > > +      else if (i < 7+6+4)
> > > > > > +        {
> > > > > > +          /*
> > > > > > +           * If kernel was compiled without CONFIG_PCI_IOV option then after
> > > > > > +           * the ROM line for configured bridge device (that which had set
> > > > > > +           * subordinary bus number to non-zero value) are four additional lines
> > > > > > +           * which describe resources behind bridge. For PCI-to-PCI bridges they
> > > > > > +           * are: IO, MEM, PREFMEM and empty. For CardBus bridges they are: IO0,
> > > > > > +           * IO1, MEM0 and MEM1. For unconfigured bridges and other devices
> > > > > > +           * there is no additional line after the ROM line. If kernel was
> > > > > > +           * compiled with CONFIG_PCI_IOV option then after the ROM line and
> > > > > > +           * before the first bridge resource line are six additional lines
> > > > > > +           * which describe IOV resources. Read all remaining lines in resource
> > > > > > +           * file and based on the number of remaining lines (0, 4, 6, 10) parse
> > > > > > +           * resources behind bridge.
> > > > > > +           */
> > > > > > +          lines[i-7].flags = flags;
> > > > > > +          lines[i-7].base_addr = start;
> > > > > > +          lines[i-7].size = size;
> > > > > > +        }
> > > > > > +    }
> > > > > > +  if (i == 7+4 || i == 7+6+4)
> > > > > 
> > > > > This looks crazy: is there any other way how to tell what the
> > > > > bridge entries mean?  Checking the number of entries looks very
> > > > > brittle.
> > > > 
> > > > I do not know any other way. Just for reference, here is a link to
> > > > the function resource_show() and DEVICE_COUNT_RESOURCE enum:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-sysfs.c?h=v5.15#n136
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/pci.h?h=v5.15#n94
> > > 
> > > I have also checked flags and there is no indication if resource is
> > > assigned on bridge as BAR or is forwarded behind the bridge.
> > > 
> > > Bjorn, Krzysztof: any idea if something better than checking number
> > > of entries in "resource" node can be used to determinate type of
> > > entry at specified line in "resource" node?
> > 
> > That *is* crazy.  I'm sorry that resource_show() works that way, and
> > that it gives no clue to identify BAR vs ROM vs IOV BAR vs CB window
> > vs regular bridge window.
> > 
> > It's conceivable that we could add "io_window" and "mem_window" files
> > or something similar.
> 
> Meanwhile I found out that in linux/ioport.h file is IORESOURCE_WINDOW
> constant with comment /* forwarded by bridge */
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ioport.h?h=v5.15#n56
> 
> But apparently it is not set for resources behind PCI bridges and
> therefore it is not available in column of "resources" sysfs file.
> 
> So maybe instead of adding new sysfs files, it would be better way to
> implement this flag and export it in flags column of "resources" file
> for every row which belongs to resources behind bridges?

I looked at that, too.  Today we only set IORESOURCE_WINDOW for host
bridge windows.  Maybe it could be set for PCI-to-PCI bridge windows,
too.  Would have to audit users to make sure it wouldn't break
anything.

> But in any case changes in kernel does not help lspci/libpci which is
> running on existing (unmodified) kernel.

Of course.

> > Does this patch fix a problem?  I'm not clear on what the benefit is.
> 
> My patch for libpci fixes it, but via counting number of rows in
> "resources" sysfs file... which is crazy. But I do not see any other
> option how to do it via currently available kernel APIs.

The current subject and commit log are:

  libpci: Add support for filling bridge resources

  Extend libpci API and ABI to fill bridge resources from sysfs.

That doesn't give a reason why Martin should include this patch.  Does
it fix a problem?  Does it help lspci show more information?  If so,
what is the difference in output?

Bjorn
