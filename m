Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA344B50C8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 13:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353677AbiBNMzQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 07:55:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353724AbiBNMzH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 07:55:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6584BFF1
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 04:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D330DB80B77
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 12:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60073C340F0;
        Mon, 14 Feb 2022 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644843296;
        bh=/lMoYB6uwOzDdoBhSkPJand5DJEhcqe1AnVjy1/uE0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrRNTJOxjgFu1I53D6myrf8P+NZCtLRpZxm7eJqCCe+vP0xN+3gdeBB8kBKRnh5t9
         8zbZN2+7e1YcP6YxzfGxzn7Jb58b4N06THj3LJDFG79vz5/BX+R0F9LqEIv5sdi565
         jnx3p82s9NsA0gcNE9wj8/yy0J2OG/clV5EFJmPuC9h5rRZW8NEUVL8pFySlTA2NMB
         OiEVVcW8khAT89CN7BXPTgGzrwyPPSfBnGAyPVES7zGvLknNZCiB7WLU5XmnGgrAKS
         XVIbrIXK3NtVEGl4at3sf/j2yhUVknbpDh6jMFp5UD0B2jbCfzi+yMpqYV053rjU6s
         IaAER+HE59FOg==
Received: by pali.im (Postfix)
        id EE266CAA; Mon, 14 Feb 2022 13:54:53 +0100 (CET)
Date:   Mon, 14 Feb 2022 13:54:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Jan Palus <jpalus@fastmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [Bug 215540] New: mvebu: no pcie devices detected on turris
 omnia (5.16.3 regression)
Message-ID: <20220214125453.6gpkgydarfbyicic@pali>
References: <20220211194330.siiwntko6b3lldw4@pali>
 <20220211195744.GA728212@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211195744.GA728212@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 11 February 2022 13:57:44 Bjorn Helgaas wrote:
> On Fri, Feb 11, 2022 at 08:43:30PM +0100, Pali Rohár wrote:
> > On Thursday 03 February 2022 09:47:28 Bjorn Helgaas wrote:
> > > [+cc Lorenzo, beginning of thread:
> > > https://lore.kernel.org/r/20220127234917.GA150851@bhelgaas]
> > > On Thu, Feb 03, 2022 at 01:55:28PM +0100, Pali Rohár wrote:
> 
> > > > Bjorn & Greg: How do you want to handle this situation? Should I prepare
> > > > special patch for stable which fix it? Or something else?
> > > > 
> > > > Anyway, do you know how it could happen that patch was incorrectly
> > > > auto-backported into stable? Differences between original and
> > > > wrongly-modified patch looks very similar (both "bus" and "dev" keywords
> > > > have same number of characters) and it was hard for me to see that there
> > > > are differences. So probably overlooking could happen or maybe git or
> > > > patch tools could do such small changes when doing backports?
> > > 
> > > Your patch on the mailing list [1] contains:
> > > 
> > >         mvebu_pcie_setup_hw(port);
> > >         mvebu_pcie_set_local_dev_nr(port, 1);
> > >   +     mvebu_pcie_set_local_bus_nr(port, 0);
> > > 
> > > 91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus of PCIe Root
> > > Port via emulated bridge") [2] appeared in v5.17-rc1 and contains:
> > > 
> > >         mvebu_pcie_setup_hw(port);
> > >   -     mvebu_pcie_set_local_dev_nr(port, 1);
> > >   +     mvebu_pcie_set_local_dev_nr(port, 0);
> > > 
> > > And this is the current state of mainline [3].
> > > 
> > > 91a8d79fc797 was backported to v5.16.3 as 7cde9bf07316 [4], which also
> > > contains:
> > > 
> > >         mvebu_pcie_setup_hw(port);
> > >   -     mvebu_pcie_set_local_dev_nr(port, 1);
> > >   +     mvebu_pcie_set_local_dev_nr(port, 0);
> > > 
> > > So I think the problem was a merge error when we first applied this
> > > for mainline, and we just need to make a patch for mainline, apply it
> > > for v5.17, and mark it for stable.
> > 
> > Should I prepare and send fixup patch?
> 
> Yes, please.  Sorry for the inconvenience!

Done!
https://lore.kernel.org/linux-pci/20220214110228.25825-1-pali@kernel.org/

> > > [1] https://lore.kernel.org/r/20211125124605.25915-12-pali@kernel.org
> > > [2] https://git.kernel.org/linus/91a8d79fc797
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-mvebu.c?id=v5.17-rc2#n1323
> > > [4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.16.y&id=7cde9bf07316
