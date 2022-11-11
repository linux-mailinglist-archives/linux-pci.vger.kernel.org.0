Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC26265BE
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 00:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiKKXyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 18:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiKKXyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 18:54:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FCFE087;
        Fri, 11 Nov 2022 15:54:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22A3CB82865;
        Fri, 11 Nov 2022 23:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F06C433C1;
        Fri, 11 Nov 2022 23:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668210866;
        bh=n9rlg2Dp22rShleywetYNqZbZzrEq6i3fmhDrN5LHUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G1BsGh35H/FvER66OzB4YdXN7WKPIP6Lpg4XsFACM46lQV1aSq1gEzkzbDrCpJDf4
         rfxOgJQRldk6Zg5I7EXjel+xkbkV6kXdQfvQQeSgNJKOyOL1jbpdva64s5mIgiLPMp
         qxyExEg+0nedDAHDm0l21sAjiLCB101OaKdYU4hTSktUzfquX96ppNgZDUnT2d6Jos
         zHgrSjeq7MNM9h+0Y5sCT5Mxu2nmh27ky+w8KcNUpL+Tk9+pUUYrME/8x33EnmQ6Da
         iioIP/jmop1iSxFRpX960OD/4bDFp67lRPCHnxN8HneFmsSVtBNJru40t5TOO5RDx8
         F7Z5RT2kQdPqQ==
Date:   Fri, 11 Nov 2022 17:54:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiaochun Lee <lixiaochun.2888@163.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaochun Lee <lixc17@lenovo.com>
Subject: Re: [PATCH v1] PCI: Set no io resource for bridges that behind VMD
 controller
Message-ID: <20221111235425.GA764316@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663075485-20591-1-git-send-email-lixiaochun.2888@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 09:24:45PM +0800, Xiaochun Lee wrote:
> From: Xiaochun Lee <lixc17@lenovo.com>
> 
> When enable VMDs on Intel CPUs, VMD controllers(8086:28c0) be
> recognized by VMD driver and there are many failed messages of
> BAR 13 when scan the bridges and assign IO resource behind it
> as listed below, the bridge wants to get 0x6000 as its IO
> resource, but there is no IO resources on the host bridge.
> 
> VMD host bridge resources:
> vmd 0000:64:00.5: PCI host bridge to bus 10000:80
> pci_bus 10000:80: root bus resource [bus 80-9f]
> pci_bus 10000:80: root bus resource [mem 0xe0000000-0xe1ffffff]
> pci_bus 10000:80: root bus resource [mem 0x24ffff02010-0x24fffffffff 64bit]
> 
> Failed messages of BAR#13:
> pci 10000:80:02.0: BAR 13: no space for [io  size 0x1000]
> pci 10000:80:02.0: BAR 13: failed to assign [io  size 0x1000]
> pci 10000:80:03.0: BAR 13: no space for [io  size 0x1000]
> pci 10000:80:03.0: BAR 13: failed to assign [io  size 0x1000]
> 
> VMD-enabled root ports use
> Enhanced Configuration Access Mechanism (ECAM) access
> PCI Express configuration space, and offer VMD_CFGBAR as
> base of PCI Express configuration space for the bridges
> behind it. The configuration space includes IO resources,
> but these IO resources are not actually used on X86,
> especially the NVMes as device connected on this hot plug
> bridges, and it can result in BAR#13 assign IO resource
> failed. So we clear IO resources by setting an IO base value
> greater than limit to these bridges. Hence, we can leverage
> kernel parameter "pci=hpiosize=0KB" to avoid this failed
> messages show out.
> 
> Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>

Some of the discussion here got lost because of email issues.  Lore
has some:
https://lore.kernel.org/all/1663075485-20591-1-git-send-email-lixiaochun.2888@163.com/T/#u,
and patchwork has a v2 with a little more discussion:
https://patchwork.kernel.org/project/linux-pci/patch/1664288166-7432-1-git-send-email-lixiaochun.2888@163.com/

But the v2 patch doesn't seem to have made it to the mailing lists or
to lore (https://lore.kernel.org/all/?q=f%3Alixc17) and I don't apply
things until they appear on the mailing list.

I *would* like to get rid of those "no space" and "failed to assign"
messages.  This is an issue for platforms other than VMD, too.  Just
an FYI that you need to follow up on this if we want make progress.

Bjorn
