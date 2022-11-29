Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4463BD6A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiK2J6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 04:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiK2J5z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 04:57:55 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A781D6437;
        Tue, 29 Nov 2022 01:57:52 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0632E92009E; Tue, 29 Nov 2022 10:57:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F32FD92009B;
        Tue, 29 Nov 2022 09:57:51 +0000 (GMT)
Date:   Tue, 29 Nov 2022 09:57:51 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Alex Williamson <alex.williamson@redhat.com>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: Work around PCIe link training failures
In-Reply-To: <20221109131632.6a059bd9.alex.williamson@redhat.com>
Message-ID: <alpine.DEB.2.21.2211290004150.58543@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2211090014500.15287@angie.orcam.me.uk> <20221109050418.GA529724@bhelgaas> <20221109131632.6a059bd9.alex.williamson@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 9 Nov 2022, Alex Williamson wrote:

> > 05:00.0 supports the "bus" method, i.e., pci_reset_bus_function(),
> > which tries pci_dev_reset_slot_function() followed by
> > pci_parent_bus_reset().  Both of them return -ENOTTY if the device
> > (05:00.0) has a secondary bus ("dev->subordinate"), so I think nothing
> > happens here.
> 
> Right, the pci-sysfs reset attribute is only meant for a reset scope
> limited to the device, we'd need something to call pci_reset_bus() to
> commit to the whole hierarchy, which is not something we typically do.
> vfio-pci will only bind to endpoint devices, so it shouldn't provide an
> interface to inject a bus reset here either.
> 
> Based on the fact that there's a pericom switch in play here, I'll just
> note that I think this is the same device with other link speed issues
> as well:
> 
> https://lore.kernel.org/all/20161026180140.23495.27388.stgit@gimli.home/

 Thanks for the pointer.  This has been superseded by commit acd61ffb2f16 
("PCI: Add ACS quirk for Pericom PI7C9X2G switches"), right?  In which 
case it is a match ([12d8:2304]), though the quirk does not trigger here, 
i.e. no message is printed about store-forward mode activation:

pcieport 0000:05:00.0: calling  pci_fixup_pericom_acs_store_forward+0x0/0xba @ 1
pcieport 0000:05:00.0: pci_fixup_pericom_acs_store_forward+0x0/0xba took 0 usecs
[...]
pci 0000:05:00.0: calling  pci_fixup_pericom_acs_store_forward+0x0/0xba @ 1
pci 0000:05:00.0: pci_fixup_pericom_acs_store_forward+0x0/0xba took 0 usecs
[...]
pcieport 0000:06:01.0: calling  pci_fixup_pericom_acs_store_forward+0x0/0xba @ 1
pcieport 0000:06:01.0: pci_fixup_pericom_acs_store_forward+0x0/0xba took 3 usecs
[...]
pcieport 0000:06:02.0: calling  pci_fixup_pericom_acs_store_forward+0x0/0xba @ 1
pcieport 0000:06:02.0: pci_fixup_pericom_acs_store_forward+0x0/0xba took 2 usecs

NB I don't know why the quirk for the upstream port (05:00.0) is called 
twice, both via pcieport and via pci.

> This fell off my plate some time ago, but as noted there, enabling ACS
> when the upstream and downstream ports run at different link rates
> exposes errata where packets are queued and not delivered within the
> switch.
> 
> Could enabling ACS on this device be contributing to the issue here,
> for example triggering the Asmedia downstream port to get into this
> link reseting issue?  A test with
> pci=disable_acs_redir=0000:06:01.0;0000:06:02.0 could be interesting
> assuming this occurs on an platform that has an IOMMU, ie. calls
> pci_request_acs().  Thanks,

 We have no IOMMU support for any RISC-V machine at the moment:

config ARCH_RV64I
	[...]
	select SWIOTLB if MMU

and:

software IO TLB: area num 4.
software IO TLB: mapped [mem 0x00000000fb732000-0x00000000ff732000] (64MB)

so IIUC this issue does not apply.  Thank you for your input.

  Maciej
