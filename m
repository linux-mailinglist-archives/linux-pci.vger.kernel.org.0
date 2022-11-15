Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B42D62AE06
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 23:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKOWPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 17:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKOWPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 17:15:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77FE25F
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 14:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5502E61A41
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 22:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E645C433C1;
        Tue, 15 Nov 2022 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668550503;
        bh=99O8kLOfvn0T8dOSb/i+2MDEYfk2b9UPYRzzXoaELJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VJjP196WciP3w/Ya6rRuPgs/5Y91yd/WCvyGpdmEIUAZgjW7KOm3vdWmV1cmkP+XX
         pNUji1l/MDANvbVX+v1AN8MdDdMLsvs4Eb/XASPFgMjNB89YKBzU7/2fFiA/0g5dkG
         HmJFDwbCmBooSEBt+NjpJAVdretgXucrQcPIuFFdXjOjWCmVl/heYfsvajzzcDr3uT
         P5XTmVowkiuT6+ehkXGYLjLIRQYeiydVExwVJm/cmmr7PNLfyzBGyV/Isw78zyrCUo
         3cGY9gs+LG7wy6siHb6C6ZTg7SIjVhIjKmEp/3irWoThsjJKkyxedD8Pqe6t20Q6aR
         AaiG2yr11xASA==
Date:   Tue, 15 Nov 2022 16:15:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: IORESOURCE_WINDOW for PCI-to-PCI bridges
Message-ID: <20221115221502.GA755872@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111214816.65fi63ffgvr6nbj2@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 10:48:16PM +0100, Pali Rohár wrote:
> On Friday 11 November 2022 15:05:55 Bjorn Helgaas wrote:
> > On Fri, Nov 11, 2022 at 09:09:45PM +0100, Pali Rohár wrote:
> > > On Thursday 20 January 2022 15:02:12 Bjorn Helgaas wrote:
> > > > On Thu, Jan 20, 2022 at 09:45:05PM +0100, Pali Rohár wrote:
> > 
> > [trimmed material; beginning of thread is at
> > https://lore.kernel.org/r/20211220155448.1233-3-pali@kernel.org]
> > 
> > > > > Meanwhile I found out that in linux/ioport.h file is IORESOURCE_WINDOW
> > > > > constant with comment /* forwarded by bridge */
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ioport.h?h=v5.15#n56
> > > > > 
> > > > > But apparently it is not set for resources behind PCI bridges and
> > > > > therefore it is not available in column of "resources" sysfs file.
> > > > > 
> > > > > So maybe instead of adding new sysfs files, it would be better way to
> > > > > implement this flag and export it in flags column of "resources" file
> > > > > for every row which belongs to resources behind bridges?
> > > > 
> > > > I looked at that, too.  Today we only set IORESOURCE_WINDOW for host
> > > > bridge windows.  Maybe it could be set for PCI-to-PCI bridge windows,
> > > > too.  Would have to audit users to make sure it wouldn't break
> > > > anything.
> > > 
> > > Hello Bjorn, I would like to remind this older issue. Did you have a time
> > > to audit usage of IORESOURCE_WINDOW? Some flag for resource forwarding
> > > windows in PCI-to-PCI bridges would really help userspace application to
> > > distinguish between IO/MEM BARs an IO/MEM forwarding windows.
> > 
> > I had forgotten all about this issue.  IIUC, the ultimate goal here
> > is to help lspci distinguish between an I/O window that's disabled and
> > one that's enabled at [io 0x0000-0x0fff].
> > 
> > I have not done the research to see whether it would be safe to set
> > IORESOURCE_WINDOW for PCI-to-PCI bridge windows.  I'm sorry if I left
> > the impression that I intended to do that.  I would welcome your help
> > to do that.
> 
> Ok, do you have some resources or other information at which I should
> look? I just do not know where to start or what to check for that
> research.
> 
> I looked into kernel sources and the only places where is code checking
> for IORESOURCE_WINDOW is ACPI related: arch/arm64/kernel/pci.c and
> drivers/pnp/resource.c. And I do not fully understand how is ACPI
> connected with PCI resources at this level. Other places which check
> (lib/vsprintf.c and drivers/pnp/interface.c) just use it for
> printf-formats.

Yeah, that's the kind of thing I have in mind.  I can't remember if I
had any specific concern.

Bjorn
