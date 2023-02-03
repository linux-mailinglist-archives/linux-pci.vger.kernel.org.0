Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ADB68A17F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 19:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjBCSUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 13:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBCSUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 13:20:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510FA8A0D;
        Fri,  3 Feb 2023 10:20:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 112C261FC5;
        Fri,  3 Feb 2023 18:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D0FC433D2;
        Fri,  3 Feb 2023 18:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675448447;
        bh=3D+/sZZJmLI9fYcwlfraDrdIRTAmIP2cDnIjI/PzcSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LKf4mIORaBua0cHD1bhn4kid4fjCZXFof1Ia/hXLrofBPF72QXlGOr9u11xm06uru
         hMyNoPUJcW6WYd7eJuYJZrDZXpkyNlgnp5bsFYAHIhngWlWbaxCgZbSzQZCkaqefYi
         r8874MLJveiWJBkcrpj6bvSzB9SOYC9ZFYHWVw/zRAAGWiKRarbYY5Ekm92pxQZNfR
         gjebtgSN0bz2QvthrYPFJnEFVivVzNWg4q49aFDIsMu6/dev5VA0uAYC6M/e9UcZ7d
         yAXgi3zL9Pa+Bc6VDkwaEbm+zoPQyIH55FeqrOb7ui/3hnAaV92a5VYraCMqti7X1S
         8zbUcvZjilSYA==
Date:   Fri, 3 Feb 2023 12:20:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <20230203182045.GA1972366@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9wg0Znc0tRWj4O9@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex in case you're interested in the ACS angle]

On Thu, Feb 02, 2023 at 04:45:05PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 02, 2023 at 02:12:49PM -0600, Bjorn Helgaas wrote:
> > On Thu, Feb 02, 2023 at 11:08:25AM +0800, Baolu Lu wrote:
> > > ...
> > 
> > > ACS is unnecessary for the devices that only use translated
> > > memory request for PASID. All translated addresses are granted
> > > by the Linux kernel which ensures that such addresses will never
> > > be in a P2P address, i.e., it's not contained in any bridge
> > > aperture, will *always* be routed toward the RC.
> > 
> > Re 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled
> > on upstream path"), does that commit actually *fix* anything?  I
> > wonder whether we could revert it completely.
> > 
> > The intent of 201007ef707a is to use ACS to prevent misrouting,
> > which would happen if a TLP contained an address that *looked*
> > like a PCI bus address, i.e., it was inside a host bridge
> > aperture, but was *intended* to reach an IOMMU or main memory
> > directly.
> 
> Yes.
> 
> > 201007ef707a only affects pci_enable_pasid(), so I think we
> > already avoid this misrouting by restricting DMA address
> > allocation for both non-IOMMU scenarios and non-PASID IOMMU
> > scenarios.
> 
> There is no restriction on DMA address allocation with PASID.
> 
> The typical PASID use case is to point the PASID at the CPU page
> table and then all VA's are fair game by userspace. There is no
> carve out like the DMA API has to protect from bus address
> confusion.

I think you're saying that for (Requester ID, PASID, Untranslated
Address), the Untranslated Address is not restricted at all, and it
may look like a PCI bus address.

> > So what about PASID mappings, e.g., consider a mapping of
> > (Requester ID, PASID, Untranslated Address) -> Translated Address?
> > If either the Untranslated Address or the Translated Address looks
> > like a PCI bus address, a Memory Request or Translation Request
> > could be misrouted.
> 
> The PCI rules are a bit complicated:
>  - A simple MemRd/Wr with a PASID will be routed according to the
>    address. This can be mis-routed
>  - A ATS translation request with a PASID is always routed to the host
>    bridge

From a PCIe point of view, I think these cases are equivalent because
a PASID prefix doesn't affect routing (sec 2.2.10.4).  A Translation
Request includes an Untranslated Address, and if that happens to look
like a PCI bus address, I think it will be mis-routed just like a
MemRd/Wr would be.

>  - A MemRd/Wr with Translated set and no PASID is always routed to the
>    correct destination, even if that is not the host bridge

I don't think Address Type 10b ("Translated") affects routing.  A
MemRd/Wr should be routed to a PCI peer if the Translated Address is
inside a host bridge aperture, or to the host bridge otherwise.

> > Do IOMMUs allocate (PASID, Untranslated Addresses) that look like
> > PCI bus addresses?
> 
> Yes, because it is mapped to a mm_struct userspace can use any mmap
> to access any valid address as an IOVA and thus PASID tagged
> translation must never become confused with bus addresses.

If PCI bus addresses are carved out of the Translated Address arena,
the MemRd/Wr TLPs should be fine, but I think the Translation Requests
that include Untranslated Addresses are still a problem.

> Further, and worse, the common use model for PASID SVA is for
> userspace to directly submit IOVA to the device for operation. If
> userspace can submit a hostile IOVA and cause DMA to reach something
> that is not the host bridge then system security is completely
> wrecked.
> 
> So, as an API in Linux we felt it was best to only enable PASID if
> PASID is secure and truely isolated, otherwise leave PASID off. The
> use cases for insecure PASID seem small.

The patch under discussion is intended to fix a v6.2-rc1 regression
added by 201007ef707a ("PCI: Enable PASID only when ACS RR & UF
enabled on upstream path").

Are we on track to fix this before v6.2?  I don't have a clear
understanding of how we know this change is safe and it only affects
AMD GPU and not other devices below the same IOMMU.

Bjorn
