Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15736BCECE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 12:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCPL7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 07:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCPL66 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 07:58:58 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A08E2311B;
        Thu, 16 Mar 2023 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678967936; x=1710503936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ju6734ynvDV9eHQw4tpvQwukcfS8TgkcQr6MmSj8sVs=;
  b=kMhj9t2jk4kU82vZeUI/ab15LPMVBP5UxQEhTk27t3U768hvOHQ3kaKd
   j/m8K57lUksV3ttVZF86iP1GYeVMTV9QRFGWUJp2WWYxuWSUnhHOlnZJR
   TvS7qdnyZvE+rv3/nEldRU27NYZSWNdGTFCyPt2GZ+lOvKJ+5vhJ9rhvC
   yujkOU+5qSEM68LRnqWPZB39Llzjz4QzV8OGRfw8a0BdBqY4+bdN6hiWy
   1gU/m0RqNdbY55GoluBks+yFBPyWgRXhtNY6DMi7QRUmjWvSistVbzapv
   ZVcaK3vPooO6pfVl3hwIzDH8fKf6uZgsBhsTRaabxqHGS6vlH981mtkOB
   w==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29736785"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Mar 2023 12:58:54 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Mar 2023 12:58:54 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Mar 2023 12:58:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678967934; x=1710503934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ju6734ynvDV9eHQw4tpvQwukcfS8TgkcQr6MmSj8sVs=;
  b=lGAApJUXpxnKGWvluSsLnNWrtQ0OEh7VlXlaoA+m71UySbbofsKmAbwx
   vgjVtvon5kw94GVVZfvi7gSltuG4eEE5UcJoA913ObXBOhI/lzLaHrvd/
   C6YJRIlrATrx7mn80lDH4Pr6Ikse8kH0b4SAqA1AHrrtr3Vp8h4nvRqBa
   UgVpbK24v7f9SOxp4LtDk/wGioHCObLWUxUX/IKnJ+lCUyx4sgjoD+YVz
   xN5QjOp9TUXhGifdvJ6ijdh2TfLXu8txuIffka2SLJgtU87XXZ1X1AIUV
   a/H1gC/SYIJ7bEXQmmW2pGmnteSecqRDTX+30IHquGtrkZJJ0qpbUDawq
   w==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29736784"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Mar 2023 12:58:54 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B9BBC280056;
        Thu, 16 Mar 2023 12:58:53 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Oliver Neukum <oneukum@suse.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Date:   Thu, 16 Mar 2023 12:58:53 +0100
Message-ID: <4888964.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <612dfdd2-7de1-12a7-c47c-7569c3466224@suse.com>
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com> <6131694.LvFx2qVVIh@steina-w> <612dfdd2-7de1-12a7-c47c-7569c3466224@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Oliver,

Am Donnerstag, 16. M=E4rz 2023, 12:17:32 CET schrieb Oliver Neukum:
> On 16.03.23 10:33, Alexander Stein wrote:
> > Hi Oliver,
>=20
> Hi,
>=20
> > Admittedly
> > I would like to get rid of these two pathes for creating sysfs files in
> > the
> > first place, but I do not know the pci subsystem very well.
> > IMHO for_each_pci_dev(pdev) in pci_sysfs_init is part of the problem as=
 it
> > unconditionally iterates over the bus, without any locks, thus creating
> > sysfs files for each device added to the bus.
> > Any ideas?
>=20
> First of all, this existing code is a mess.
>=20
> If I understand you have the issue that your driver adds a bridge
> in dw_pcie_host_init() and the generic code in pci_create_sysfs_dev_files=
()
> populates the directory before or while your driver does so and
> the devices are effectively discovered twice.

Yep, that's my observation as well.

> It seems to me that you must not add a bridge before
> pci_create_sysfs_dev_files() has finished. Now you could add a wait_queue
> and a flag and wait for it to finish. But that is not very elegant.

Do we need the pci_sysfs_init initcall at all? Or to put it in other words,=
=20
what does this initcall solve?
See my different approach eliminating this race at all.

> From which initcall is your driver probed?

The callstack looks like this:
> imx6_pcie_probe from platform_probe+0x5c/0xb8
> platform_probe from call_driver_probe+0x24/0x118
> call_driver_probe from really_probe+0xc4/0x31c
> really_probe from __driver_probe_device+0x8c/0x120
> __driver_probe_device from driver_probe_device+0x30/0xc0
> driver_probe_device from __driver_attach_async_helper+0x50/0xd8
> __driver_attach_async_helper from async_run_entry_fn+0x30/0x144
> async_run_entry_fn from process_one_work+0x1c4/0x3d0
> process_one_work from worker_thread+0x50/0x41c
> worker_thread from kthread+0xec/0x104
> kthread from ret_from_fork+0x14/0x2c

So technically the device is not probed from within a initcall but a kthrea=
d.=20
It is set to be probed asynchronous in imx6_pcie_driver.

This async call is scheduled in __driver_attach, from this callstack:
> __driver_attach from bus_for_each_dev+0x74/0xc8
> bus_for_each_dev from bus_add_driver+0xf0/0x1f4
> bus_add_driver from driver_register+0x7c/0x118
> driver_register from do_one_initcall+0x4c/0x180
> do_one_initcall from do_initcalls+0xe0/0x114
> do_initcalls from kernel_init_freeable+0xd8/0x100
> kernel_init_freeable from kernel_init+0x18/0x12c
> kernel_init from ret_from_fork+0x14/0x2c

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


