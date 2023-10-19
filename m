Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1517D0291
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbjJSTcv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346117AbjJSTcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 15:32:50 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18D112A
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 12:32:48 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CC462100E5F4B;
        Thu, 19 Oct 2023 21:32:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9C9FC5A98A; Thu, 19 Oct 2023 21:32:46 +0200 (CEST)
Date:   Thu, 19 Oct 2023 21:32:46 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v9 2/3] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20231019193246.GA16112@wunner.de>
References: <20231013034158.2745127-2-alistair.francis@wdc.com>
 <20231019165829.GA1381099@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019165829.GA1381099@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 11:58:29AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 13, 2023 at 01:41:57PM +1000, Alistair Francis wrote:
> > +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +		xa_for_each(&doe_mb->feats, j, entry)
> > +			return a->mode;
> > +	}
> > +
> > +	return 0;
> 
> The nested loops that don't test anything look a little weird and
> maybe I'm missing something, but this looks like it returns a->mode if
> any mailbox with a feature exists, and 0 otherwise.
> 
> Is that the same as this:
> 
>   if (pdev->doe_mbs)
>     return a->mode;
> 
>   return 0;
> 
> since it sounds like a mailbox must support at least one feature?

In theory it's the same, in practice there *might* be non-compliant
devices which lack support for the discovery feature.


> > +		attrs[i].attr.name = kasprintf(GFP_KERNEL,
> > +					       "0x%04lX:%02lX", vid, type);
> 
> What's the rationale for using "0x" on the vendor ID but not on the
> type?  "0x1234:10" hints that the "10" might be decimal since it lacks
> "0x".
> 
> Suggest lower-case "%04lx:%02lx" either way.
> 
> FWIW, there's no "0x" prefix on the hex vendor IDs in "lspci -n"
> output and dmesg messages like this:
> 
>   pci 0000:01:00.0: [10de:13b6] type 00

The existing attributes "vendor", "device" etc do emit the "0x".

From drivers/pci/pci-sysfs.c:

pci_config_attr(vendor, "0x%04x\n");
pci_config_attr(device, "0x%04x\n");
pci_config_attr(subsystem_vendor, "0x%04x\n");
pci_config_attr(subsystem_device, "0x%04x\n");
pci_config_attr(revision, "0x%02x\n");
pci_config_attr(class, "0x%06x\n");


> I try hard to avoid calling *anything* from the
> pci_create_sysfs_dev_files() path because it has the nasty
> "sysfs_initialized" check and the associated pci_sysfs_init()
> initcall.

What's the purpose of sysfs_initialized anyway?

It was introduced by this historic commit:
https://git.kernel.org/tglx/history/c/f6d553444da2

Can PCI_ROM_RESOURCEs appear after device enumeration but before
the late_initcall stage?

If sysfs_initialized is only needed for PCI_ROM_RESOURCEs, can we
constrain pci_sysfs_init() to those and avoid creating all the
other runtime sysfs attributes in the initcall?

Thanks,

Lukas
