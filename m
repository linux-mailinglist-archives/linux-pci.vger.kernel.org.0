Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D899E62B209
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 05:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKPEF0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 23:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiKPEFZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 23:05:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834AD2CDD5;
        Tue, 15 Nov 2022 20:05:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06DE260A29;
        Wed, 16 Nov 2022 04:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA6BC433D6;
        Wed, 16 Nov 2022 04:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668571522;
        bh=kjVp3+N7XYR/1DyCEtp1GJWjE3u69DI+4L2HULDkv0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rBTkloo7Kak4zSyB8JbEINjfdHa10NHKJN44MrWTA7J/ys3I2GFhrAGEKhJfjEgkH
         FWh5VuOC6p8mfzlapgjAyBWqF1xopGAA6tvYRiw11Y4Vll5siKHJCKWet7PumUFU02
         /23hMoxfoFsoa3WmGC+++b3B+hZUUEJfZ4CemftNmQhgSGsBQKCXQahYeH4oNRLhkC
         FIhavl/pIg69yYBwe37NS7oaMW0sRlfZ/oGxhHaS0qayJhahWT6WTkf2yCWxqpBCYc
         VjKRsjPXbGxUOcyYg5xlAbcQVhnM6oP+BTui3w7H8LhGBxbBzlsZkWAMOv+W00RO7/
         SESt2hAdqHqwQ==
Date:   Tue, 15 Nov 2022 22:05:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiaochun XC17 Li <lixc17@lenovo.com>
Cc:     Xiaochun Lee <lixiaochun.2888@163.com>,
        "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Message-ID: <20221116040520.GA1078511@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR03MB6877FB2A677FBBCF80E6BD3ABC079@SEYPR03MB6877.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 03:34:34AM +0000, Xiaochun XC17 Li wrote:
> On Sat, Nov 11, 2022 at 07:54:25, "Bjorn Helgaas" <helgaas@kernel.org> wrote:
> > On Tue, Sep 13, 2022 at 09:24:45PM +0800, Xiaochun Lee wrote:
> > > From: Xiaochun Lee <lixc17@lenovo.com>
> > >
> > > When enable VMDs on Intel CPUs, VMD controllers(8086:28c0) be
> > > recognized by VMD driver and there are many failed messages of BAR 13
> > > when scan the bridges and assign IO resource behind it as listed
> > > below, the bridge wants to get 0x6000 as its IO resource, but there is
> > > no IO resources on the host bridge.
> > >
> > > VMD host bridge resources:
> > > vmd 0000:64:00.5: PCI host bridge to bus 10000:80 pci_bus 10000:80:
> > > root bus resource [bus 80-9f] pci_bus 10000:80: root bus resource [mem
> > > 0xe0000000-0xe1ffffff] pci_bus 10000:80: root bus resource [mem
> > > 0x24ffff02010-0x24fffffffff 64bit]
> > >
> > > Failed messages of BAR#13:
> > > pci 10000:80:02.0: BAR 13: no space for [io  size 0x1000] pci
> > > 10000:80:02.0: BAR 13: failed to assign [io  size 0x1000] pci
> > > 10000:80:03.0: BAR 13: no space for [io  size 0x1000] pci
> > > 10000:80:03.0: BAR 13: failed to assign [io  size 0x1000]
> > >
> > > VMD-enabled root ports use
> > > Enhanced Configuration Access Mechanism (ECAM) access PCI Express
> > > configuration space, and offer VMD_CFGBAR as base of PCI Express
> > > configuration space for the bridges behind it. The configuration space
> > > includes IO resources, but these IO resources are not actually used on
> > > X86, especially the NVMes as device connected on this hot plug
> > > bridges, and it can result in BAR#13 assign IO resource failed. So we
> > > clear IO resources by setting an IO base value greater than limit to
> > > these bridges. Hence, we can leverage kernel parameter
> > > "pci=hpiosize=0KB" to avoid this failed messages show out.
> > >
> > > Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
> > 
> > Some of the discussion here got lost because of email issues.  Lore has
> > some:
> > https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fall%2F1663075485-20591-1-git-send-email-
> > lixiaochun.2888%40163.com%2FT%2F%23u&amp;data=05%7C01%7Clixc17
> > %40lenovo.com%7C9cd095ffdb584e492dec08dac440139b%7C5c7d0b28bdf
> > 8410caa934df372b16203%7C0%7C0%7C638038076734438158%7CUnknown
> > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=JzWYkIsaEfINofiqo
> > XyjEh43VjXO3HZw2JLSsmhpUiQ%3D&amp;reserved=0,
> > and patchwork has a v2 with a little more discussion:
> > https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > hwork.kernel.org%2Fproject%2Flinux-pci%2Fpatch%2F1664288166-7432-1-
> > git-send-email-
> > lixiaochun.2888%40163.com%2F&amp;data=05%7C01%7Clixc17%40lenovo.
> > com%7C9cd095ffdb584e492dec08dac440139b%7C5c7d0b28bdf8410caa934
> > df372b16203%7C0%7C0%7C638038076734438158%7CUnknown%7CTWFpb
> > GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> > 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=y%2BtIsepTpyLeoHW6CrgkZz2
> > tiMjY0TONfK7zNCKXQ90%3D&amp;reserved=0
> > 
> > But the v2 patch doesn't seem to have made it to the mailing lists or to
> > lore
> > (https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flor
> > e.kernel.org%2Fall%2F%3Fq%3Df%253Alixc17&amp;data=05%7C01%7Clixc1
> > 7%40lenovo.com%7C9cd095ffdb584e492dec08dac440139b%7C5c7d0b28bd
> > f8410caa934df372b16203%7C0%7C0%7C638038076734438158%7CUnknow
> > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=zxGz1hZOD2tvQP
> > EsbxQTzjHwQvXvqeO%2FUd6I9S%2Fj314%3D&amp;reserved=0) and I don't
> > apply things until they appear on the mailing list.
> > 
> > I *would* like to get rid of those "no space" and "failed to assign"
> > messages.  This is an issue for platforms other than VMD, too.  Just an FYI
> > that you need to follow up on this if we want make progress.
> 
> Thanks for your comments, so do you mean we'd better come up with a
> solution to avoid messages like "no space" and "failed to assign" using
> a common way, for both VMD and other platforms?

I tried to say two separate things:

1) It doesn't seem like a VMD-specific thing, so it would be ideal if
the solution were generic instead of being VMD-specific.

2) Some of your previous patches didn't make it to the mailing list,
so we couldn't really do anything with them.

Bjorn
