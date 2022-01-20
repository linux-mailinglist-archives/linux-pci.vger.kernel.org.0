Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3952495570
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 21:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiATUd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 15:33:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40330 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiATUd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 15:33:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0C49B81E2A
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 20:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E988C340E0;
        Thu, 20 Jan 2022 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642710834;
        bh=rpd2x5kieqsemFxNjDSw0qinHmYJwFjC3VwrZ3kcGCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BnMPzjU/5PuMmIczLEOW+UmagS50epIesTtTpWEn4jDH+2ieF44sfh2q+72duoJ+s
         538vY8WuTgenr1y8azuj8ZIZwTuAHiTAaF6bNqo+yrN4A/ZlacEERTa98FJaoMVd2A
         ruOorOOsWo8cwXlpCI851WxjYHLW5+N6WqeBE+dE+WuRZk1DYd/QKvupXXwV+iV1e7
         Rdy4zqv9M+yawfwTG5Hra/a5f83kZyMiPeZ79D7gg0k6GaJmn5lht0Tj9R5D+GGEUj
         XzazU/n5RulUhULrCL9/yvSVPo+Wo9txsGNMDndQkhsXJ1XTBxSuzFrsDgwdExvEfC
         wKVf46H2XuT8A==
Date:   Thu, 20 Jan 2022 14:33:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 3/4] libpci: Add support for filling bridge
 resources
Message-ID: <20220120203352.GA1061051@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211231222748.xriixk5etfya2xbn@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 31, 2021 at 11:27:48PM +0100, Pali Rohár wrote:
> On Sunday 26 December 2021 23:20:27 Pali Rohár wrote:
> > On Sunday 26 December 2021 23:13:11 Martin Mareš wrote:
> > > Hi!
> > > 
> > > > +      else if (i < 7+6+4)
> > > > +        {
> > > > +          /*
> > > > +           * If kernel was compiled without CONFIG_PCI_IOV option then after
> > > > +           * the ROM line for configured bridge device (that which had set
> > > > +           * subordinary bus number to non-zero value) are four additional lines
> > > > +           * which describe resources behind bridge. For PCI-to-PCI bridges they
> > > > +           * are: IO, MEM, PREFMEM and empty. For CardBus bridges they are: IO0,
> > > > +           * IO1, MEM0 and MEM1. For unconfigured bridges and other devices
> > > > +           * there is no additional line after the ROM line. If kernel was
> > > > +           * compiled with CONFIG_PCI_IOV option then after the ROM line and
> > > > +           * before the first bridge resource line are six additional lines
> > > > +           * which describe IOV resources. Read all remaining lines in resource
> > > > +           * file and based on the number of remaining lines (0, 4, 6, 10) parse
> > > > +           * resources behind bridge.
> > > > +           */
> > > > +          lines[i-7].flags = flags;
> > > > +          lines[i-7].base_addr = start;
> > > > +          lines[i-7].size = size;
> > > > +        }
> > > > +    }
> > > > +  if (i == 7+4 || i == 7+6+4)
> > > 
> > > This looks crazy: is there any other way how to tell what the
> > > bridge entries mean?  Checking the number of entries looks very
> > > brittle.
> > 
> > I do not know any other way. Just for reference, here is a link to
> > the function resource_show() and DEVICE_COUNT_RESOURCE enum:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-sysfs.c?h=v5.15#n136
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/pci.h?h=v5.15#n94
> 
> I have also checked flags and there is no indication if resource is
> assigned on bridge as BAR or is forwarded behind the bridge.
> 
> Bjorn, Krzysztof: any idea if something better than checking number
> of entries in "resource" node can be used to determinate type of
> entry at specified line in "resource" node?

That *is* crazy.  I'm sorry that resource_show() works that way, and
that it gives no clue to identify BAR vs ROM vs IOV BAR vs CB window
vs regular bridge window.

It's conceivable that we could add "io_window" and "mem_window" files
or something similar.

Does this patch fix a problem?  I'm not clear on what the benefit is.

Bjorn
