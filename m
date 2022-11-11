Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E062628F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 21:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiKKUKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 15:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiKKUKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 15:10:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8818B6711D
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 12:09:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4367BB8260C
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 20:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887ADC433C1;
        Fri, 11 Nov 2022 20:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668197395;
        bh=XVrCYxZDbIIhctj7F9GuJbA4PCs1u4bCEJl7mPMYLSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEt492GegNVRMrVicgwa2/sbHGiwOi1tTeVY6Z1bcYV1mUQxR0fVmrvKbWSchp2B6
         gKZRgrm7gcoUPDIHtakATrDHXtI85dDbfeDwt3NVPJKhjYOfSzwWr7uM9BFgGEDnrX
         yUM0tY7SomWdQpB5uo7Hibh/uNlpxelebdRY2clbYsQ1sEhZKjuK3e/WG+L2/cR7x9
         JWmHpTztEPiur6bIHett7Qnlvr45ZoSP7UaXS3RG0uIh5hzAv7cGOASG00lMoMHit5
         WpiOt1yQJJ1ceyKxziTPOMbCYuj6ZfQUCz/AiYqL2xszppwwuv2m1J+BpgsfTtpsnw
         rrLtJ/0Q3g0XA==
Received: by pali.im (Postfix)
        id BD3AE818; Fri, 11 Nov 2022 21:09:52 +0100 (CET)
Date:   Fri, 11 Nov 2022 21:09:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: IORESOURCE_WINDOW for PCI-to-PCI bridges
Message-ID: <20221111200945.qlholxaoa2ecrfm4@pali>
References: <20220120204505.pwsgfutwh563y3ug@pali>
 <20220120210212.GA1066435@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220120210212.GA1066435@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 20 January 2022 15:02:12 Bjorn Helgaas wrote:
> On Thu, Jan 20, 2022 at 09:45:05PM +0100, Pali Rohár wrote:
> > On Thursday 20 January 2022 14:33:52 Bjorn Helgaas wrote:
> > > On Fri, Dec 31, 2021 at 11:27:48PM +0100, Pali Rohár wrote:
> > > > On Sunday 26 December 2021 23:20:27 Pali Rohár wrote:
> > > > > On Sunday 26 December 2021 23:13:11 Martin Mareš wrote:
> > > > > > Hi!
> > > > > > 
> > > > > > > +      else if (i < 7+6+4)
> > > > > > > +        {
> > > > > > > +          /*
> > > > > > > +           * If kernel was compiled without CONFIG_PCI_IOV option then after
> > > > > > > +           * the ROM line for configured bridge device (that which had set
> > > > > > > +           * subordinary bus number to non-zero value) are four additional lines
> > > > > > > +           * which describe resources behind bridge. For PCI-to-PCI bridges they
> > > > > > > +           * are: IO, MEM, PREFMEM and empty. For CardBus bridges they are: IO0,
> > > > > > > +           * IO1, MEM0 and MEM1. For unconfigured bridges and other devices
> > > > > > > +           * there is no additional line after the ROM line. If kernel was
> > > > > > > +           * compiled with CONFIG_PCI_IOV option then after the ROM line and
> > > > > > > +           * before the first bridge resource line are six additional lines
> > > > > > > +           * which describe IOV resources. Read all remaining lines in resource
> > > > > > > +           * file and based on the number of remaining lines (0, 4, 6, 10) parse
> > > > > > > +           * resources behind bridge.
> > > > > > > +           */
> > > > > > > +          lines[i-7].flags = flags;
> > > > > > > +          lines[i-7].base_addr = start;
> > > > > > > +          lines[i-7].size = size;
> > > > > > > +        }
> > > > > > > +    }
> > > > > > > +  if (i == 7+4 || i == 7+6+4)
> > > > > > 
> > > > > > This looks crazy: is there any other way how to tell what the
> > > > > > bridge entries mean?  Checking the number of entries looks very
> > > > > > brittle.
> > > > > 
> > > > > I do not know any other way. Just for reference, here is a link to
> > > > > the function resource_show() and DEVICE_COUNT_RESOURCE enum:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-sysfs.c?h=v5.15#n136
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/pci.h?h=v5.15#n94
> > > > 
> > > > I have also checked flags and there is no indication if resource is
> > > > assigned on bridge as BAR or is forwarded behind the bridge.
> > > > 
> > > > Bjorn, Krzysztof: any idea if something better than checking number
> > > > of entries in "resource" node can be used to determinate type of
> > > > entry at specified line in "resource" node?
> > > 
> > > That *is* crazy.  I'm sorry that resource_show() works that way, and
> > > that it gives no clue to identify BAR vs ROM vs IOV BAR vs CB window
> > > vs regular bridge window.
> > > 
> > > It's conceivable that we could add "io_window" and "mem_window" files
> > > or something similar.
> > 
> > Meanwhile I found out that in linux/ioport.h file is IORESOURCE_WINDOW
> > constant with comment /* forwarded by bridge */
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ioport.h?h=v5.15#n56
> > 
> > But apparently it is not set for resources behind PCI bridges and
> > therefore it is not available in column of "resources" sysfs file.
> > 
> > So maybe instead of adding new sysfs files, it would be better way to
> > implement this flag and export it in flags column of "resources" file
> > for every row which belongs to resources behind bridges?
> 
> I looked at that, too.  Today we only set IORESOURCE_WINDOW for host
> bridge windows.  Maybe it could be set for PCI-to-PCI bridge windows,
> too.  Would have to audit users to make sure it wouldn't break
> anything.

Hello Bjorn, I would like to remind this older issue. Did you have a time
to audit usage of IORESOURCE_WINDOW? Some flag for resource forwarding
windows in PCI-to-PCI bridges would really help userspace application to
distinguish between IO/MEM BARs an IO/MEM forwarding windows.
