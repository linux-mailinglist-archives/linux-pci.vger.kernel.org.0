Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D512779E27
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 10:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHLIFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Aug 2023 04:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHLIFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2023 04:05:10 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D91DCE;
        Sat, 12 Aug 2023 01:05:12 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 07F9D100DCEFD;
        Sat, 12 Aug 2023 10:05:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B9CD730E77; Sat, 12 Aug 2023 10:05:09 +0200 (CEST)
Date:   Sat, 12 Aug 2023 10:05:09 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230812080509.GA9469@wunner.de>
References: <20230810163342.1059509-1-alistair.francis@wdc.com>
 <b3d437f5-fe33-4677-e336-a67ac9b8d477@kernel.org>
 <CAKmqyKOpgTUOzPMhe3Dr1H6BiFZYHrBHFpiESyXitRHbdH0+LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKOpgTUOzPMhe3Dr1H6BiFZYHrBHFpiESyXitRHbdH0+LA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 11, 2023 at 02:40:45PM -0400, Alistair Francis wrote:
> On Thu, Aug 10, 2023 at 9:04???PM Damien Le Moal <dlemoal@kernel.org> wrote:
> > > This uses pci_sysfs_init() instead of the ->is_visible() function as
> > > is_visible only applies to the attributes under the group. Which
> > > means that every PCIe device will see a `doe_protos` directory, no
> > > matter if DOE is supported at all on the device.
> > >
> > > On top of that ->is_visible() is only called
> > > (fs/sysfs/group.c:create_files()) if there are sub attrs, which we
> > > don't necessary have. There are no static attrs, instead they are
> > > all generated dynamically.
> >
> > You said that the kernel caches the protocols supported. So it should
> > not be hard to allocate one attribute for each of the supported protocols
> > when these are discovered, no ?
> 
> I couldn't figure out a way to get this to work. You end up with a
> race between the sysfs group being created and the attributes being
> created. The DOE features are probed before the sysfs init creates the
> group.

If you look at device_add_attrs() in drivers/base/core.c, you'll notice
it calls device_add_groups() for the class, type and dev->groups.

pci_dev_attr_groups[] is assigned through the type.

What you want to do is amend pci_alloc_dev() to allocate enough space
for a struct attribute_group, in addition to struct pci_dev, then
assign it to dev->groups in that same function.  Define a macro
for the size.  Initially you'll need two struct attribute_group
elements, one for your DOE element plus one for the terminating
zero element.

If there are DOE mailboxes, let ->is_visible of the DOE group
return true and use "doe" as its ->name to make attributes appear
in a "doe" subdirectory.  Finally allocate and fill a struct
struct attribute[] array with all the protocols found in all the
mailboxes.

Thanks,

Lukas
