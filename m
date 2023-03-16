Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE46BD2DA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 16:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCPPAs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCPPAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 11:00:47 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2011246AA;
        Thu, 16 Mar 2023 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678978845; x=1710514845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKOT8mwLMCfwJaJTixWaN8UYI2lDfCPX0HtfI2KLD2k=;
  b=io49smxMVmgqLStc1+zjA5CfgItvlh8NzagZ2JTd9teHDwA28YCf9xJk
   Ik+yDz2QW2fcrLHbTcaaP5fEyR+eky9jy7Us79nXHaxHDbBMWaAeA2f6o
   +4mnJvAipaytc2a9tiMG5LwRWIZ5nLHyFj3gE/ypD81boW0lrf4C1KLtN
   H/BjDPOn3Cd7l0BtMbkXUUw2NIju55f4tCaq+q/cLiZs0AVupiwSzjarn
   r3MV/m8EFhLyrWMv0cobIjuJwneAX2jjrB6dW2Gs1CtVN8a6kYodqX6kp
   PPLcLK9j52k8lCBynraw447/dDM+vMu+QWL/JxNNRuRfHsXjlXBSbopM1
   A==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29743092"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Mar 2023 16:00:43 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Mar 2023 16:00:43 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Mar 2023 16:00:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678978843; x=1710514843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKOT8mwLMCfwJaJTixWaN8UYI2lDfCPX0HtfI2KLD2k=;
  b=dw22qRIcXdup0sK9+st+Utbqq9YEIRZK3gKwb2n+6SDfHZT4mH4ALWB2
   LBgZJd2Q+t9nXQfRINNZn7x90q1kJgcPiHnEY96gTqd6yidD0IZpP3EOJ
   NfyJD7Gwh7tEDtO1Kz02AKqOnCkBYw+KC9Jh7Rv2nOz+6t9oNKVOJGo6H
   MvaK0X9H0Ye4mVTqKvDeyTN2pT7YbCs2O1S0LwzK975UZcyjuutQ1wJJk
   1eTM0eQ5C4K1DvgHlNUBGBT2ILEBB7ccyloxrKrJXHOpcOjZeMvB94sH9
   NQjNp2WSu/RBl93pSM3ZgOQ+ga9b0Wg3jAFViyf46/i20uyWC/ybMeuKv
   w==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="29743090"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Mar 2023 16:00:42 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id CCEAE280056;
        Thu, 16 Mar 2023 16:00:42 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Oliver Neukum <oneukum@suse.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Date:   Thu, 16 Mar 2023 16:00:42 +0100
Message-ID: <3554992.taCxCBeP46@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ced8713f-69de-e48a-37eb-4f844e651b6b@suse.com>
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com> <3607385.usQuhbGJ8B@steina-w> <ced8713f-69de-e48a-37eb-4f844e651b6b@suse.com>
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

Am Donnerstag, 16. M=E4rz 2023, 15:01:25 CET schrieb Oliver Neukum:
> On 16.03.23 14:16, Alexander Stein wrote:
> > But isn't the root bridge discovered by the driver (pci-imx6 in this ca=
se)
> > for that? And the driver probe path eventually calls into the sysfs file
> > creation. I compared the file creation to usb, as this is a discoverable
> > bus as well. There is no special initialization regarding sysfs.
>=20
> If you discover a bus system you always have the option of creating of
> virtual hotplug event for the root hub or host controller.
> But for PCI that is a bad design choice. USB is different.

I'm not sure if I can follow you here. Can you elaborate?

> > If, for some reason, the device enumeration for PCI bus during
> > imx6_pcie_probe is delayed after pci_sysfs_init initcall, this initcall
> > essentially does nothing, no devices or busses to iterate. Which means
> > the complete pcie sysfs
> On your specific system. You cannot use that as a model for all systems.

I am aware that my platform is not a role model for the others. But I've ye=
t=20
to get information what is actually different on other platforms.

> > creation is done from bridge probe path. There is no reason to iterate
> > over
> > discovered PCIe devices/busses separately.
>=20
> If there is no other PCI device, the loop is a nop. But otherwise it is
> necessary.

How is it necessary? How do these PCI devices get attaches to the pci_bus_t=
ype=20
bus without calling pci_bus_add_device?

> >>> So technically the device is not probed from within a initcall but a
> >>> kthread. It is set to be probed asynchronous in imx6_pcie_driver.
> >>=20
> >> That may be the problem, respectively that system is incomplete
> >> You are registering a PCI bridge. The PCI subsystem should be
> >> done setting up when you run. That is just a simple dependency.
> >=20
> > Is there such an dependency in the first place? I can't see anything, e=
ven
> > the late_initcall to pci_resource_alignment_sysfs_init is a different
> > matter.
> On your hardware, yes. In the kernel, no.
> That is the very point. The kernel is missing a way to represent a
> dependency.

Okay, so which dependency is provided by pci_sysfs_init, which are required=
 by=20
drivers then?

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


