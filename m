Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565B6697F9E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 16:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBOPjT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 10:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjBOPjQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 10:39:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC593754B;
        Wed, 15 Feb 2023 07:39:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64EFF61CA1;
        Wed, 15 Feb 2023 15:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E44C4339B;
        Wed, 15 Feb 2023 15:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676475554;
        bh=KAqVQM9UCH1nsN4dVqO6EI2zHup8vWAXhFqadtkfxJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RaKm6Vd89p1r/UPhvnoxGM8/yaSzsjglgOBhaKDjkb66pV8QyxW8L6p+iTAWHw5fr
         ow8VrkUQ47yCIqPBTU12Y1e5i6FQqvtasc3nI4nTwipHy5QQbmYPKq03feQ7lj4lxB
         4QvQP7lmtYdMV0LqxnrmYKW366R92hVLF2jIVfEPtf9kxNDIL2kuPkGfGAeNKJhSNf
         4mXkTP0lpilWn114gDuj2C6vCcgr+i1x6jYnf/mpp5g7Cpy2lNTa75PV15gDik493s
         EuhBBIu98FjsuRQjkJIexThiNjQJYAiaNHezaExE++u+q49OIi+57CU1rQ5jj4Q5ii
         nBJHKKqXH+3UA==
Date:   Wed, 15 Feb 2023 09:39:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [regression, =?iso-8859-1?Q?bisected?=
 =?iso-8859-1?Q?=2C_pci=2Fiommu=5D_Bug=A0216865_-_Black_screen_when_amdgp?=
 =?iso-8859-1?Q?u?= started during 6.2-rc1 boot with AMD IOMMU enabled
Message-ID: <20230215153913.GA3189407@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bbc0f65-e1c6-f388-29a8-390b8c9c92c8@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christian, Xinhui, amd-gfx]

On Fri, Jan 06, 2023 at 01:48:11PM +0800, Baolu Lu wrote:
> On 1/5/23 11:27 PM, Felix Kuehling wrote:
> > Am 2023-01-05 um 09:46 schrieb Deucher, Alexander:
> > > > -----Original Message-----
> > > > From: Hegde, Vasant <Vasant.Hegde@amd.com>
> > > > On 1/5/2023 4:07 PM, Baolu Lu wrote:
> > > > > On 2023/1/5 18:27, Vasant Hegde wrote:
> > > > > > On 1/5/2023 6:39 AM, Matt Fagnani wrote:
> > > > > > > I built 6.2-rc2 with the patch applied. The same black
> > > > > > > screen problem happened with 6.2-rc2 with the patch. I
> > > > > > > tried to use early kdump with 6.2-rc2 with the patch
> > > > > > > twice by panicking the kernel with sysrq+alt+c after the
> > > > > > > black screen happened. The system rebooted after about
> > > > > > > 10-20 seconds both times, but no kdump and dmesg files
> > > > > > > were saved in /var/crash. I'm attaching the lspci -vvv
> > > > > > > output as requested. ...

> > > > > > Looking into lspci output, it doesn't list ACS feature
> > > > > > for Graphics card. So with your fix it didn't enable PASID
> > > > > > and hence it failed to boot. ...

> > > > > So do you mind telling why does the PASID need to be enabled
> > > > > for the graphic device? Or in another word, what does the
> > > > > graphic driver use the PASID for? ...

> > > The GPU driver uses the pasid for shared virtual memory between
> > > the CPU and GPU.  I.e., so that the user apps can use the same
> > > virtual address space on the GPU and the CPU.  It also uses
> > > pasid to take advantage of recoverable device page faults using
> > > PRS. ...

> > Agreed. This applies to GPU computing on some older AMD APUs that
> > take advantage of memory coherence and IOMMUv2 address translation
> > to create a shared virtual address space between the CPU and GPU.
> > In this case it seems to be a Carrizo APU. It is also true for
> > Raven APUs. ...

> Thanks for the explanation.
> 
> This is actually the problem that commit 201007ef707a was trying to
> fix.  The PCIe fabric routes Memory Requests based on the TLP
> address, ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with
> PASID that should go upstream to the IOMMU may instead be routed as
> a P2P Request if its address falls in a bridge window.
> 
> In SVA case, the IOMMU shares the address space of a user
> application.  The user application side has no knowledge about the
> PCI bridge window.  It is entirely possible that the device is
> programed with a P2P address and results in a disaster.

Is this stalled?  We explored the idea of changing the PCI core so
that for devices that use ATS/PRI, we could enable PASID without
checking for ACS [1], but IIUC we ultimately concluded that it was
based on a misunderstanding of how ATS Translation Requests are routed
and that an AMD driver change would be required [2].

So it seems like we still have this regression, and we're running out
of time before v6.2.

[1] https://lore.kernel.org/all/20230114073420.759989-1-baolu.lu@linux.intel.com/
[2] https://lore.kernel.org/all/Y91X9MeCOsa67CC6@nvidia.com/
