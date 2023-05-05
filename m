Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860E6F865E
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjEEQII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjEEQIH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 12:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1555160BE;
        Fri,  5 May 2023 09:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 382B963F0B;
        Fri,  5 May 2023 16:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBBFC433EF;
        Fri,  5 May 2023 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683302881;
        bh=8gHxaGg91TPv9kc6vpEsICRg7ABwQvC7Ch9caGsg5qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k/y/8fhLFoib5n2EyfDqOl9faQaNCORUMbW+4uotpIEHinZ8Lz3Nnka/WrKoIqf2T
         gjHha9Khbk24VjTSVjCIPSBVUNdJd5gdsa00JhN570YF2P0mr2EhK46JqQISUNiPtQ
         XGEzHDCOuhOsrQtl1qo0Oj46vivxGopGQWA2wZWjub9JDeNTetdMpKYJ9txlslJIXI
         C3zGetOOEk3d81taSS/r9RKwQj8AzllW9J0yNLkTGkcpoF6ZXG2/MJ3Robsblwg1Ln
         /LEifPCu5OK25wD0Vt5ES5caNXlmBDdId2WW6VaPRtc1cQKVwHBhzgo+CjT1FnddwP
         vIfNTSpkXnOIQ==
Date:   Fri, 5 May 2023 11:07:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xinghui Li <korantwork@gmail.com>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH v5] PCI: vmd: Add the module param to adjust MSI mode
Message-ID: <20230505160759.GA955334@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEm4hYUdkoZkdVg9tQ=fZoCk-1DYrNrDxmPc=+ZyRJaSnGOxwA@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 05, 2023 at 05:31:44PM +0800, Xinghui Li wrote:
> On Sat, Apr 29, 2023 at 3:58 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 28, 2023 at 01:40:36PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Apr 20, 2023 at 03:09:14PM +0800, korantwork@gmail.com wrote:
> > > > From: Xinghui Li <korantli@tencent.com>
> >
> > > What if you made boolean parameters like these:
> > >
> > >   no_msi_remap
> > >
> > >     If the VMD supports it, disable VMD MSI-X remapping.  This
> > >     improves interrupt performance because child device interrupts
> > >     avoid the VMD MSI-X domain interrupt handler.
> > >
> > >   msi_remap
> > >
> > >     Remap child MSI-X interrupts into VMD MSI-X interrupts.  This
> > >     limits the number of MSI-X vectors available to the whole child
> > >     device domain to the number of VMD MSI-X interrupts.
> >
> > I guess having two parameters that affect the same feature is also
> > confusing.  Maybe just "msi_remap=0" or "msi_remap=1" or something?
> >
> > I think what makes "disable_msi_bypass=0" hard is that "MSI bypass" by
> > itself is a negative feature (the positive activity is MSI remapping),
> > and disabling bypass gets us back to the positive "MSI remapping"
> > situation, and "disable_msi_bypass=0" negates that again, so we're
> > back to ... uh ... let's see ... we are not disabling the bypass of
> > MSI remapping, so I guess MSI remapping would be *enabled*?  Is that
> > right?
>
> I am fine with these two ways naming of the param. Adjusting from
> enable_msi_remaping to disable_msi_bypass was aimed to trying address
> your comment about dealing with the device not supporting bypass.
> And in vmd drivers, the vmd bypass feature is enabled by adding the flag
> "VMD_FEAT_CAN_BYPASS_MSI_REMAP".  Therefore, I think disabling
> bypass seems more appropriate. This patch aims to provide a convenient
> way to remove that flag in a specific case.

Users don't care about the name of VMD_FEAT_CAN_BYPASS_MSI_REMAP.  I
don't think that's a very good name either (in my opinion
"VMD_FEAT_MSI_REMAP_DISABLE" would be more descriptive, and
VMCONFIG_MSI_REMAP is even worse since setting it *disables* MSI
remapping), but in any case these are internal to the driver.

> On Sat, Apr 29, 2023 at 2:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > The "disable_msi_bypass" parameter name also leads to some complicated
> > logic.  IIUC, "disable_msi_bypass=0" means "do not disable MSI remap
> > bypassing" or, in other words, "do not remap MSIs."  This is only
> > supported by some VMDs.  Using "disable_msi_bypass=0" to *enable* the
> > bypass feature is confusing.
>
> However, as you said, it does lead to some complicated logic.  So, I
> also believe that these two approaches have their own pros and cons.
> 
> > I still don't understand what causes the performance problem here.  I
> > guess you see higher performance when the VMD remaps child MSIs?  So
> > adding the VMD MSI-X domain interrupt handler and squashing all the
> > child MSI vectors into the VMD MSI vector space makes things better?
> > That seems backwards.  Is this because of cache effects or something?
> 
> > What does "excessive pressure on the PCIe node" mean?  I assume the
> > PCIe node means the VMD?  It receives the same number of child
> > interrupts in either case.
>
> What I mean is that there will be performance issues when a PCIe domain
> is fully loaded with 4 Gen4 NVMe devices.  like this:
>  +-[10002:00]-+-01.0-[01]----00.0  device0
>  |                     +-03.0-[02]----00.0  device1
>  |                     +-05.0-[03]----00.0  device2
>  |                      \-07.0-[04]----00.0  device3
> 
> According to the perf/irqtop tool, we found the os does get the same
> counts of interrupts in different modes. However, when the above
> situation occurs, we observed a significant increase in CPU idle
> time. Besides, the data and performance when using the bypass VMD
> feature were identical to when VMD was disabled. And after the
> devices mounted on a domain are reduced, the IOPS of individual
> devices will rebound somewhat. Therefore, we speculate that VMD can
> play a role in balancing and buffering interrupt loads. Therefore,
> in this situation, we believe that VMD ought to not be bypassed to
> handle MSI.

The proposed text was:

  Use this when multiple NVMe devices are mounted on the same PCIe
  node with a high volume of 4K random I/O. It mitigates excessive
  pressure on the PCIe node caused by numerous interrupts from NVMe
  drives, resulting in improved I/O performance. Such as:

The NVMe configuration and workload you mentioned works better with
MSI-X remapping.  But I don't know *why*, and I don't know that NVMe
is the only device affected.  So it's hard to write useful guidance
for users, other than "sometimes it helps."

Straw man proposal:

  msi_remap=0

    Disable VMD MSI-X remapping, which improves interrupt performance
    because child device interrupts avoid the VMD MSI-X domain
    interrupt handler.  Not all VMD devices support this, but for
    those that do, this is the default.

  msi_remap=1

    Remap child MSI-X interrupts into VMD MSI-X interrupts.  This
    limits the number of MSI-X vectors available to the whole child
    device domain to the number of VMD MSI-X interrupts.

    This may be required in some virtualization scenarios.

    This may improve performance in some I/O topologies, e.g., several
    NVMe devices doing lots of random I/O, but we don't know why.

I hate the idea of "we don't know why."  If you *do* know why, it
would be much better to outline the mechanism because that would help
users know when to use this.  But if we don't know why, admitting that
straight out is better than hand-waving about excessive pressure, etc.

The same applies to the virtualization caveat.  The text above is not
actionable -- how do users know whether their particular
virtualization scenario requires this option?

Bjorn
