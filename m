Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501C97D02EA
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 22:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbjJSUBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 16:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjJSUBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 16:01:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278AF114;
        Thu, 19 Oct 2023 13:01:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3FCC433C8;
        Thu, 19 Oct 2023 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697745672;
        bh=XskOtb4wMb4vHQ2dkKFABI8QaThcTeUIs3sr/sQXEts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fRhbRS8Pq6bhMFHVAeN8LfFJ1wNqJlqEDWh0zxXDNhxZkhkJfbJJZcTFgGnct2pKx
         v2VJ2U91+pjJO/ZfAMyUCp2FRVzQDFfZ3oHdcAeWMRiZP2mSWe+vHJsW54JrmjmwF6
         COpEJCWqrC9tq7Ed0hdbILHLDlICUgX4dmlvA5m7q0TZLfhV26LEBuqv2kKnh2RLVj
         /fs9XSdZNznOOQwWlKLVpstTlHiAeMVrg5OHuIZSOjTK1+Rnv3r47HsuPb8vN9u6Sd
         dxTS1ExGIHgLyohCzcPFdPYFfzyyzrjNJoZe0dnK15CXe6Z9ppuXMCh6PXt3Z4pWc2
         7fQnzYtuSkbsg==
Date:   Thu, 19 Oct 2023 15:01:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v9 2/3] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20231019200110.GA1410324@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019193246.GA16112@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 09:32:46PM +0200, Lukas Wunner wrote:
> On Thu, Oct 19, 2023 at 11:58:29AM -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 13, 2023 at 01:41:57PM +1000, Alistair Francis wrote:
> > > +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > > +		xa_for_each(&doe_mb->feats, j, entry)
> > > +			return a->mode;
> > > +	}
> > > +
> > > +	return 0;
> > 
> > The nested loops that don't test anything look a little weird and
> > maybe I'm missing something, but this looks like it returns a->mode if
> > any mailbox with a feature exists, and 0 otherwise.
> > 
> > Is that the same as this:
> > 
> >   if (pdev->doe_mbs)
> >     return a->mode;
> > 
> >   return 0;
> > 
> > since it sounds like a mailbox must support at least one feature?
> 
> In theory it's the same, in practice there *might* be non-compliant
> devices which lack support for the discovery feature.

Is there any point in setting ->doe_mbs if there's no feature?

> > > +		attrs[i].attr.name = kasprintf(GFP_KERNEL,
> > > +					       "0x%04lX:%02lX", vid, type);
> > 
> > What's the rationale for using "0x" on the vendor ID but not on the
> > type?  "0x1234:10" hints that the "10" might be decimal since it lacks
> > "0x".

This is my main question.  Seems like it should be both or neither.

> > I try hard to avoid calling *anything* from the
> > pci_create_sysfs_dev_files() path because it has the nasty
> > "sysfs_initialized" check and the associated pci_sysfs_init()
> > initcall.
> 
> What's the purpose of sysfs_initialized anyway?
> 
> It was introduced by this historic commit:
> https://git.kernel.org/tglx/history/c/f6d553444da2
> 
> Can PCI_ROM_RESOURCEs appear after device enumeration but before
> the late_initcall stage?
> 
> If sysfs_initialized is only needed for PCI_ROM_RESOURCEs, can we
> constrain pci_sysfs_init() to those and avoid creating all the
> other runtime sysfs attributes in the initcall?

I think pci_sysfs_init() is already constrained to only the BARs and
ROM.  Constraining it to only the ROM would be an improvement, but I'd
really like to get rid of it altogether.  Krzysztof W. moved a lot of
stuff out of pci_sysfs_init() a while ago, but the BARs are harder
because of some arch/alpha wrinkles, IIRC.

I think the reason for pci_sysfs_init() exists in the first place is
because those resources may be assigned after pci_device_add(), and
(my memory is hazy here) it seems like changing the size of binary
attributes is hard, which might fit with the
pci_remove_resource_files() and pci_create_resource_files() in the
resource##n##_resize_store() macro:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-sysfs.c?id=v6.5#n1440

Bjorn
