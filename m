Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED016BD088
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 14:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCPNQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCPNQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 09:16:17 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B70149A5;
        Thu, 16 Mar 2023 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678972576; x=1710508576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKsiC0p5s7wkO/ec8sI+NUgY3uyOfuDKEgeNXNBnm/4=;
  b=k2ngVE9b4GU3Aib3GH7BYZwupD8HVD7dgg32EdmlAvdSRa7OD4OdpoXm
   wODuKe+QBGwKta6QBp35L8EYAtfGWN1Qtahc+eUriLTFBE/J16WYaTuHl
   BKaDbL2gFnyxAPtGTPLqOCniD/DSB9Tw75PE/lDiGy7/TJKMkZdlr0vFR
   +Oi2rJjG+TQRNLQPZvmcYA1xd7Vp+XTF4jNefYWbzjP+vMNrRzREfFbuz
   yBianjngfGi6BaBQa5O0EizPymdWUlEFSHPPaq1lHIdt+st6JBgm6z5NM
   kbHeT+ZNMxtSkbskj0qax6IJwYNPGu6CQWnMRn+BjYx/G7XCtHKpR3Z3j
   A==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29739450"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Mar 2023 14:16:13 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Mar 2023 14:16:13 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Mar 2023 14:16:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678972573; x=1710508573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKsiC0p5s7wkO/ec8sI+NUgY3uyOfuDKEgeNXNBnm/4=;
  b=gjC0ohccWH/yd8HTuq7WH+EBP/XSbJNX2mIO0x5L+4DrOUkxr2Qd9u+n
   VhXRjHBEVzxoYzOLCclQubiJkafoDsJpsyYawj8bGutAmU83yn9ehaMfO
   +lT34+6/gx3rqs0SqIOp5i9IUCY1jmywlg94/zgpSOlO5u+c14biMQuVI
   VILaOfTY4ZiS23mb6C7itEkNxgKgQB1HA5eb3w76iAYtbqhFVuzn4hXA3
   PWX0+K6Y8z7uIjdvNR+pkUZuN6+rlD9BVsD600ZIxuYaD4UZ3QTLfCiym
   +NVAUBODunUx68ZRiejGqeOrtBKkWRk0c3LjFRiaxdyEp8MgMvg67JOLL
   w==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29739449"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Mar 2023 14:16:13 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 82B56280056;
        Thu, 16 Mar 2023 14:16:13 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Oliver Neukum <oneukum@suse.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Date:   Thu, 16 Mar 2023 14:16:13 +0100
Message-ID: <3607385.usQuhbGJ8B@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <90e97b96-2918-294a-0e71-33a42f28d8a8@suse.com>
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com> <4888964.44csPzL39Z@steina-w> <90e97b96-2918-294a-0e71-33a42f28d8a8@suse.com>
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

Am Donnerstag, 16. M=E4rz 2023, 13:23:25 CET schrieb Oliver Neukum:
> On 16.03.23 12:58, Alexander Stein wrote:
> > Hi Oliver,
> >=20
> > Am Donnerstag, 16. M=E4rz 2023, 12:17:32 CET schrieb Oliver Neukum:
> >> It seems to me that you must not add a bridge before
> >> pci_create_sysfs_dev_files() has finished. Now you could add a wait_qu=
eue
> >> and a flag and wait for it to finish. But that is not very elegant.
> >=20
> > Do we need the pci_sysfs_init initcall at all? Or to put it in other
> > words,
> > what does this initcall solve?
>=20
> Fundamentally something has to discover the root bridge.
> Secondly your system has to boot. The device right behind
> the root bridge will already be up and running when the kernel
> takes control. IMHO treating such devices differently from
> other devices makes sense.

But isn't the root bridge discovered by the driver (pci-imx6 in this case) =
for=20
that? And the driver probe path eventually calls into the sysfs file creati=
on.
I compared the file creation to usb, as this is a discoverable bus as well.=
=20
There is no special initialization regarding sysfs.

> > See my different approach eliminating this race at all.
>=20
> Please elaborate

Currently the initcall pci_sysfs_init and the PCIe root bridge driver probe
paths are competing for file creation.
If, for some reason, the device enumeration for PCI bus during imx6_pcie_pr=
obe=20
is delayed after pci_sysfs_init initcall, this initcall essentially does=20
nothing, no devices or busses to iterate. Which means the complete pcie sys=
fs=20
creation is done from bridge probe path. There is no reason to iterate over=
=20
discovered PCIe devices/busses separately.

I assume this issue is not that prominent, if at all, as other platforms va=
ry=20
in speed a lot. I was not able to reproduce on i.MX8MP which uses the same=
=20
PCIe bridge driver. Due to improved speed performance, I guess on this=20
platform pci_sysfs_init finishes, without doing anything, before PCIe bridg=
e=20
is probed.

I might be missing something (ACPI systems, etc.), I do not know the detail=
s=20
within pci subsystem, but from my point of view this initcall is superfluou=
s.

=46or the record the patch is at [1]

[1] https://lore.kernel.org/linux-pci/20230316103036.1837869-1-alexander.st=
ein@ew.tq-group.com/T/#u

> >>  From which initcall is your driver probed?
> >=20
> > The callstack looks like this:
> >> imx6_pcie_probe from platform_probe+0x5c/0xb8
> >> platform_probe from call_driver_probe+0x24/0x118
> >> call_driver_probe from really_probe+0xc4/0x31c
> >> really_probe from __driver_probe_device+0x8c/0x120
> >> __driver_probe_device from driver_probe_device+0x30/0xc0
> >> driver_probe_device from __driver_attach_async_helper+0x50/0xd8
> >> __driver_attach_async_helper from async_run_entry_fn+0x30/0x144
> >> async_run_entry_fn from process_one_work+0x1c4/0x3d0
> >> process_one_work from worker_thread+0x50/0x41c
> >> worker_thread from kthread+0xec/0x104
> >> kthread from ret_from_fork+0x14/0x2c
> >=20
> > So technically the device is not probed from within a initcall but a
> > kthread. It is set to be probed asynchronous in imx6_pcie_driver.
>=20
> That may be the problem, respectively that system is incomplete
> You are registering a PCI bridge. The PCI subsystem should be
> done setting up when you run. That is just a simple dependency.

Is there such an dependency in the first place? I can't see anything, even =
the=20
late_initcall to pci_resource_alignment_sysfs_init is a different matter.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


