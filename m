Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23926CB1DB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 00:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC0Wh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 18:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjC0Wh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 18:37:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4055124;
        Mon, 27 Mar 2023 15:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69588B818C7;
        Mon, 27 Mar 2023 22:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB77C433EF;
        Mon, 27 Mar 2023 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679956673;
        bh=1if43ofgC9kxf3iYz7Cwwx2xe1GO6f2A+/K/yppDoB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V5stfdgS5SB9T2aCNjNxc787XGu0UHW2Yjcxry6AiYOk2AjfNgKZRSmvJ2XNzdnQJ
         9wUPZcA+vnIMA1uRFTXkA0YxA6n6VlMHHzyKxDSoQ7rc4eC2COVi+Av1XkiwmJEV8c
         +9L/vwdZ/2mufCy0WbHu2VIdbROdZhMWd88cJMemF6WKRgv+6MciuyFkYZ3cMwGxNX
         L+yBPC0/EX8nJFuFjfW5/FkhH+KnlrSAHK2hlmq8FJHIN7x+dZBqG80Vl4Pp2kgyJz
         169aPEmhjItSjwH789Jibd4RdoGhYvZA68vAo8t83ow2rj20G/n/o4+7CI2fd+6e6+
         G1Mqi9W1qvE9w==
Date:   Mon, 27 Mar 2023 17:37:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org,
        "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        Aleksander Trofimowicz <alex@n90.eu>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
Message-ID: <20230327223750.GA2860671@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975cc790-7dd9-4902-45c1-c69b4be9ba3a@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Aleksander, original report at
https://lore.kernel.org/r/975cc790-7dd9-4902-45c1-c69b4be9ba3a@linux.intel.com]

On Thu, Mar 09, 2023 at 07:34:18PM +0530, Rajat Khandelwal wrote:
> On 3/9/2023 7:31 PM, Rajat Khandelwal wrote:
> > Hi,
> > I am seeking some help regarding an issue I encounter sporadically
> > with Samsung Portable TBT SSD X5.
> > 
> > Right from the thunderbolt discovery to the PCIe enumeration, everything
> > is fine, until 'NVME_REG_CSTS' is tried to be read in 'nvme_reset_work'.
> > Precisely, 'readl(dev->bar + NVME_REG_CSTS)' fails.

> > I handle type-C, thunderbolt and USB4 on Chrome platforms, and currently
> > we are working on Intel Raptorlake systems.
> > This issue has been witnessed from ADL time-frame and now is seen
> > on RPL as well. I would really like to get to the bottom of the problem
> > and close the issue.
> > 
> > I have tried 5.10 and 6.1.15 kernels.

It's intermittent, but happens on both v5.10 and v6.1.15.  So we have
no reason to think this is a regression, right?

And you see it on ADL and RPL?  Do you see it on any other platforms?
Have you tried any others?

> > During the issue:
> > Contents of BAR-0: <garbage> 00000004 (dumped using setpci)
> > Contents of kernel PCI resource-0: 0x83000000 (matches with the mem allocation)
> > Issue: nvme nvme1: Removing after probe failure status: -19

How exactly did you use setpci and what was "<garbage>"?  Can you
include the entire transcript, e.g.,

  $ setpci -G -s 01:00.0 BASE_ADDRESS_0.L
  Trying method linux-sysfs......using /sys/bus/pci...OK
  Decided to use linux-sysfs
  ec000000

What does "lspci -vvxxx" show in this case?

I guess "kernel PCI resource-0: 0x83000000" means the following from
your dmesg log, right?

  pci 0000:03:00.0: BAR 0: assigned [mem 0x83000000-0x83003fff 64bit]

I think the first access to the device should be here (same as what
Keith said):

  nvme_probe
    nvme_pci_enable
      pci_enable_device_mem
      pci_set_master
      readl(dev->bar + NVME_REG_CSTS)

But you mention nvme_reset_work() above.  How did you figure that out?

Maybe there's a race where we reset the device (which clears the BARs)
and do MMIO accesses before the BARs are restored.

Or maybe some PCI error happens and nvme_reset_work() is invoked as
part of recovery?  I see some *corrected* AER errors in your log, but
none look related to your NVMe device at 03:00.0.

I assume reading the BAR with setpci happens in "slow user time" so we
have to assume that's the steady state of the BAR after nvme_probe()
fails with -19.

> > During a working case:
> > Contents of BAR-0: 83000004 (dumped using setpci)
> > 
> > Seems like, the kernel PCIe resource contents don't change (which results in a
> > successful ioremap), but somehow the BAR-0 dumps garbage.
> > 
> > The logs for the scenario: (apologies if this is not the way to attach a log in
> > the mailing list as I have never done that :)).

> > ... (see original report at
> > https://lore.kernel.org/r/975cc790-7dd9-4902-45c1-c69b4be9ba3a@linux.intel.com)

Bjorn
