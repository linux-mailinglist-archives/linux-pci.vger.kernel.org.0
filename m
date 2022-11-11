Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCA626358
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 22:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKKVGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 16:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKVGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 16:06:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA8E833AC
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 13:06:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5D00B82775
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 21:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EE0C433C1;
        Fri, 11 Nov 2022 21:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668200757;
        bh=Md7r15xpIcXrzmOMtgS/bLTu59Ct3vctpSOgUabspNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mUpYujhvYF5+otrQiqVe2cmjKhLy3N8DPb8cKULRyt00bVuGwCxQ0gKzCss8CCPSX
         UMAk8tTCgF6H6dZUYuCo3TM0Lkj7BkwAurdyxOmsBW9Olg4HQv5IBBjxzqDkSiz4ik
         B3kA7fzQVDRPHpxZJeGl8oS0QYeDn7zx5DsUzUtDDkTRTN+eypBILXZuQiRCbL2SwS
         c5f8cC7Edr81uWxXv/qHFWMdl52+yfzWaySLpkmv2q/KiYBBs2SIJi73bKu63JJbVM
         dDijAIzc2yl6ulAwneFPy6CrE9K7/I2qIAoaAfw3CfEnOxOjw1shirhHyc1f5Hte1+
         Qay84Fneaz8fw==
Date:   Fri, 11 Nov 2022 15:05:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: IORESOURCE_WINDOW for PCI-to-PCI bridges
Message-ID: <20221111210555.GA744899@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111200945.qlholxaoa2ecrfm4@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 09:09:45PM +0100, Pali Rohár wrote:
> On Thursday 20 January 2022 15:02:12 Bjorn Helgaas wrote:
> > On Thu, Jan 20, 2022 at 09:45:05PM +0100, Pali Rohár wrote:

[trimmed material; beginning of thread is at
https://lore.kernel.org/r/20211220155448.1233-3-pali@kernel.org]

> > > Meanwhile I found out that in linux/ioport.h file is IORESOURCE_WINDOW
> > > constant with comment /* forwarded by bridge */
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ioport.h?h=v5.15#n56
> > > 
> > > But apparently it is not set for resources behind PCI bridges and
> > > therefore it is not available in column of "resources" sysfs file.
> > > 
> > > So maybe instead of adding new sysfs files, it would be better way to
> > > implement this flag and export it in flags column of "resources" file
> > > for every row which belongs to resources behind bridges?
> > 
> > I looked at that, too.  Today we only set IORESOURCE_WINDOW for host
> > bridge windows.  Maybe it could be set for PCI-to-PCI bridge windows,
> > too.  Would have to audit users to make sure it wouldn't break
> > anything.
> 
> Hello Bjorn, I would like to remind this older issue. Did you have a time
> to audit usage of IORESOURCE_WINDOW? Some flag for resource forwarding
> windows in PCI-to-PCI bridges would really help userspace application to
> distinguish between IO/MEM BARs an IO/MEM forwarding windows.

I had forgotten all about this issue.  IIUC, the ultimate goal here
is to help lspci distinguish between an I/O window that's disabled and
one that's enabled at [io 0x0000-0x0fff].

I have not done the research to see whether it would be safe to set
IORESOURCE_WINDOW for PCI-to-PCI bridge windows.  I'm sorry if I left
the impression that I intended to do that.  I would welcome your help
to do that.

Bjorn
