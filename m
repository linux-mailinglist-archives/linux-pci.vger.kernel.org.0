Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492E684061
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 01:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBAAO1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 19:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjBAAOX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 19:14:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F50945206;
        Tue, 31 Jan 2023 16:14:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B7616174E;
        Wed,  1 Feb 2023 00:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41378C4339B;
        Wed,  1 Feb 2023 00:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675210461;
        bh=VrkTkh6sMfICNOUk5NZrD7fgvs8RF21aHhoYAwfB2Uo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sqnLiyMXkgfW9mlamfTWgJ1sZbtC2gIfY0hjWHQCvx0fGp0qWgh5PZtDL6FoXeaYZ
         xWZREiaBUtHNCiXuQu4UQWNF9oSsi5YfXuaN9uyWaHwvLsbeyKesqU/uB4owTDN7MI
         LTCx7a1FSeUUfQBhwJ0WX2zQGr0kqt1Ps5jz+7KIe5WEYioligobIzT1QJZBm8Um5X
         NNSr5C7Cb0hrZOcFfiRcN2+KLM+QYl4XtTIDCCQT2Hh3zzxRuhrlDJmSmxkAOnNmAm
         Ui4L+GOcFgEQf++rdWS3phUMVuzNfzHC9rXfWb+BVtVDFsBKPrNk5sZAmFCwvW4WhW
         X7RLsy45uhHsw==
Date:   Tue, 31 Jan 2023 18:14:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <20230201001419.GA1776086@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030e66e0-fb54-b77d-5094-4786684ba97d@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 31, 2023 at 08:56:13PM +0800, Baolu Lu wrote:
> On 2023/1/31 2:38, Bjorn Helgaas wrote:
> > > PCI: Add translated request only flag for pci_enable_pasid()
> > > 
> > > The PCIe fabric routes Memory Requests based on the TLP address, ignoring
> > > the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
> > > Enable PASID only when ACS RR & UF enabled on upstream path") requires
> > > some ACS features being supported on device's upstream path when enabling
> > > PCI/PASID.

Looking up 201007ef707a to see what ensuring system integrity means,
it prevents Memory Requests with PASID, which should always be routed
to the RC, from being mistakenly routed as peer-to-peer requests.

> > > However, above change causes the Linux kernel boots to black screen on a
> > > system with below graphic device:
> >
> > We need a PCIe concept-level description of the issue first, i.e., in
> > terms of DMA, PASID, ACS, etc.  Then we can mention the AMD GPU issue
> > as an instance.
> 
> How about below description?

Thanks, this is exactly the sort of thing I'm looking for.  But my
understanding of ATS/PRI/PASID is weak, so I'm still working through
this.  Tell me when I say something wrong below...

> PCIe endpoints can use ATS to request DMA remapping hardware to
> translate an IOVA to its mapped physical address. If the translation is
> missing or the permissions are insufficient, the PRI is used to trigger
> an I/O page fault. The IOMMU driver will fill the mapping with desired
> permissions and return the translated address to the device.

In PCIe spec language, I think you're saying that a PCIe Function may
contain an ATC.  If the ATC Capability Enable bit is set, the Function
can issue Translation Requests.

The TA (aka IOMMU) will respond with a Translation Completion.  If the
Completion is a CplD, it contains the translated address and the
Function can store the entry in its ATC.  I assume the I/O page fault
case corresponds to a Cpl (with no data) meaning that the TA could not
translate the address.

If the TA doesn't have a mapping with the desired permissions, and the
Function's Page Request Capability Enable bit is set, it may issue a
Page Request Message.  It's up to the TA/IOMMU to make this message
visible to the OS, which can make the page resident, create an IOMMU
mapping, and enable a PRG Response Message.  After the Function
receives the PRG Response Message, it would issue another Translation
Request.

> The translated address is specified by the IOMMU driver. The IOMMU
> driver ensures that the address is a DMA buffer address instead of any
> P2P address in the PCI fabric. Therefore, any translated memory request
> will eventually be routed to IOMMU regardless of whether there is ACS
> control in the up-streaming path.

A Memory Request with an address that is not a P2P address, i.e., it
is not contained in any bridge aperture, will *always* be routed
toward the RC, won't it?  Isn't that the case regardless of whether
the address is translated or untranslated, and even regardless of ACS?

IIUC, ACS basically causes peer-to-peer requests to be routed upstream
instead of directly to the peer.

OK, reading this again, I realize that I just restated exactly what
you had already written, sorry about that.

> AMD GPU is one of those devices.

I guess you mean the AMD GPU has ATS, PRI, and PASID Capabilities?
And furthermore, that the GPU *always* uses Translated addresses with
PASID?

So I guess what's going on here is that if:

  - A device only uses PASID with Translated addresses, and 
  - those Translated addresses are never P2P addresses, then
  - those transactions will always be routed to the RC.  

And this applies even if there is no ACS or ACS doesn't support
PCI_ACS_RR and PCI_ACS_UF.

The black screen happens because ... ?

What can we include in the commit log to help people find this fix?  I
see these in the bugzilla:

  WARNING: CPU: 0 PID: 477 at drivers/pci/ats.c:251 pci_disable_pri+0x75/0x80
  WARNING: CPU: 0 PID: 477 at drivers/pci/ats.c:419 pci_disable_pasid+0x45/0x50

(These look like defects in pdev_pri_ats_enable(), so really just
distractions)

  kfd kfd: amdgpu: Failed to resume IOMMU for device 1002:9874
  kfd kfd: amdgpu: device 1002:9874 NOT added due to errors
  BUG: kernel NULL pointer dereference, address: 0000000000000058
  RIP: 0010:report_iommu_fault+0x11/0x90

I couldn't figure out the NULL pointer dereference.  I expected it to
be from a BUG() or similar in report_iommu_fault(), but I don't see
that.

> Furthermore, it always uses translated memory requests for PASID.
>
> > > 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > >          [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
> > >          (prog-if 00 [VGA controller])
> > >          DeviceName: ATI EG BROADWAY
> > >          Subsystem: Hewlett-Packard Company Device 8332

> > > The AMD iommu driver allocates a new domain (called v2 domain) for the
> > "v2 domain" needs to be something greppable -- an identifier,
> > filename, etc.
> 
> The code reads,
> 
> 2052         if (iommu_feature(iommu, FEATURE_GT) &&
> 2053             iommu_feature(iommu, FEATURE_PPR)) {
> 2054                 iommu->is_iommu_v2   = true;
> 
> So, how about
> 
> ..The AMD GPU has a private interface to its own AMD IOMMU, which could
> be detected by the FEATURE_GT && FEATURE_PPR features. The AMD iommu
> driver allocates a special domain for the GPU device ..

Where is this special domain allocated?  I think the above tests for
*IOMMU* features (I assume "GTSup: Guest translations supported" and
"PPRSup: Peripheral page request support" based on the AMD IOMMU
spec).  It doesn't test that this is a GPU.

This change doesn't feel safe for all possible devices that have a
PASID Capability because we don't know whether they *always* use
Translated addresses with PASID TLPs.

Bjorn
