Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D186263C7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 22:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKKVsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 16:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKKVsV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 16:48:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866571147F
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 13:48:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC39620FF
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 21:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44758C433D6;
        Fri, 11 Nov 2022 21:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203299;
        bh=PZglyOhtUcn6TLGHSUgx5ruKsD3szT5I1T60pNTZY3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3HeT2N0mG2yLnIWF+iY+SJ54rRDu76Omg7IQ3b4guTnZo/PGL3KHlF8TMR4ricCs
         m/+V+BFU8VNPw6orBlTPUV99SXwJ2M97tJ+A1H1Q0F8C8gdzbVw0o0eUaUI5IwjTSS
         QAUGM+eVkiBZA9TLJYXCL/CVNkLlBKXVmkenn4nlsy5/0P9Hem4yWV/bnLks/iGLG9
         K64t7pkwQoXKAUyXrWuHTu6NP4gDRLPv+fzqv0pkGzVmZQFvOGft5ehrq0brnxiyEi
         ikhzO8cURzD4cMpHgj68YkImTWyWvtad3x322v5hQ1rdbKDQeV0ttsIvsWrPP6jli0
         yb6zlE+oNyIgQ==
Received: by pali.im (Postfix)
        id 34D9C818; Fri, 11 Nov 2022 22:48:16 +0100 (CET)
Date:   Fri, 11 Nov 2022 22:48:16 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: IORESOURCE_WINDOW for PCI-to-PCI bridges
Message-ID: <20221111214816.65fi63ffgvr6nbj2@pali>
References: <20221111200945.qlholxaoa2ecrfm4@pali>
 <20221111210555.GA744899@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111210555.GA744899@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 11 November 2022 15:05:55 Bjorn Helgaas wrote:
> On Fri, Nov 11, 2022 at 09:09:45PM +0100, Pali Rohár wrote:
> > On Thursday 20 January 2022 15:02:12 Bjorn Helgaas wrote:
> > > On Thu, Jan 20, 2022 at 09:45:05PM +0100, Pali Rohár wrote:
> 
> [trimmed material; beginning of thread is at
> https://lore.kernel.org/r/20211220155448.1233-3-pali@kernel.org]
> 
> > > > Meanwhile I found out that in linux/ioport.h file is IORESOURCE_WINDOW
> > > > constant with comment /* forwarded by bridge */
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ioport.h?h=v5.15#n56
> > > > 
> > > > But apparently it is not set for resources behind PCI bridges and
> > > > therefore it is not available in column of "resources" sysfs file.
> > > > 
> > > > So maybe instead of adding new sysfs files, it would be better way to
> > > > implement this flag and export it in flags column of "resources" file
> > > > for every row which belongs to resources behind bridges?
> > > 
> > > I looked at that, too.  Today we only set IORESOURCE_WINDOW for host
> > > bridge windows.  Maybe it could be set for PCI-to-PCI bridge windows,
> > > too.  Would have to audit users to make sure it wouldn't break
> > > anything.
> > 
> > Hello Bjorn, I would like to remind this older issue. Did you have a time
> > to audit usage of IORESOURCE_WINDOW? Some flag for resource forwarding
> > windows in PCI-to-PCI bridges would really help userspace application to
> > distinguish between IO/MEM BARs an IO/MEM forwarding windows.
> 
> I had forgotten all about this issue.  IIUC, the ultimate goal here
> is to help lspci distinguish between an I/O window that's disabled and
> one that's enabled at [io 0x0000-0x0fff].
> 
> I have not done the research to see whether it would be safe to set
> IORESOURCE_WINDOW for PCI-to-PCI bridge windows.  I'm sorry if I left
> the impression that I intended to do that.  I would welcome your help
> to do that.
> 
> Bjorn

Ok, do you have some resources or other information at which I should
look? I just do not know where to start or what to check for that
research.

I looked into kernel sources and the only places where is code checking
for IORESOURCE_WINDOW is ACPI related: arch/arm64/kernel/pci.c and
drivers/pnp/resource.c. And I do not fully understand how is ACPI
connected with PCI resources at this level. Other places which check
(lib/vsprintf.c and drivers/pnp/interface.c) just use it for
printf-formats.
