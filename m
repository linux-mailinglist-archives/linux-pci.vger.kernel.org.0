Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039BB6B8DDA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 09:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCNIx5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCNIx4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 04:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8103A1717;
        Tue, 14 Mar 2023 01:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E01A61684;
        Tue, 14 Mar 2023 08:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FC5C433EF;
        Tue, 14 Mar 2023 08:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678784033;
        bh=hhk1J4ONP6mjhXxAG2T33eYmJ6gxsSx9EIKa3jOh4ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBtuPkQvhc/JLQsOo3dnwP1rDv6yoxVe9G9EOsEaJuO2SFB8+mYvBsIyKztH2nD7K
         VZAjvTL14PSHwky/jS+zSwNjuTbOdwPvWg6kRI5klzyPJduLk5KSFY6dclvmQ7ivUN
         cIBlOf9I6FSZCkE99HITh4/I1nDrBfPi8jqXj6Aj+sp8wpYD50uTym3q/nLK63kbQx
         kPhTqkkc0w8ChyN4ZnipR30uZfpJQGs7MFJAjP93d/MyLXGgNvyNmE7pX7WflxW8Fm
         FsYAL6CLlTGhU3811d9sS14WhnSq7QiK/gURdv9wT76T2geHh3wJu69g3uUj0zwoJ+
         S2sTzyrStR2lQ==
Date:   Tue, 14 Mar 2023 09:53:46 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Add quirk for platforms running Windows
Message-ID: <ZBA2Gl5xCjk7mMoW@lpieralisi>
References: <ZAswHyaYjeqjW/+A@lpieralisi>
 <20230310230539.GA1289856@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310230539.GA1289856@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 05:05:39PM -0600, Bjorn Helgaas wrote:
> On Fri, Mar 10, 2023 at 02:26:55PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Mar 08, 2023 at 12:53:10PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Feb 27, 2023 at 10:12:21AM +0800, Shawn Guo wrote:
> > > > Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> > > > host bridge windows") introduced a check to remove host bridge register
> > > > resources for all arm64 platforms, with the assumption that the PNP0A03
> > > > _CRS resources would always be host bridge registers and never as windows
> > > > on arm64.
> > > > 
> > > > The assumption stands true until Qualcomm Snapdragon Windows laptops
> > > > emerge.  These laptops describe host bridge windows in PNP0A03 _CRS
> > > > resources instead.  For example, the Microsoft Surface Pro X has host
> > > > bridges defined as
> > > > 
> > > >     Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
> > > >     Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> > > > 
> > > >     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > > >     {
> > > >         Name (RBUF, ResourceTemplate ()
> > > >         {
> > > >             Memory32Fixed (ReadWrite,
> > > >                 0x60200000,         // Address Base
> > > >                 0x01DF0000,         // Address Length
> > > >                 )
> > > >             WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> > > >                 0x0000,             // Granularity
> > > >                 0x0000,             // Range Minimum
> > > >                 0x0001,             // Range Maximum
> > > >                 0x0000,             // Translation Offset
> > > >                 0x0002,             // Length
> > > >                 ,, )
> > > >         })
> > > >         Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
> > > >     }
> > > > 
> > > > The Memory32Fixed holds a host bridge window, but it's not properly
> > > > defined as a "producer" resource.  Consequently the resource gets
> > > > removed by kernel, and the BAR allocation fails later on:
> > > > 
> > > >     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
> > > >     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> > > >     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> > > >     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> > > > 
> > > > This eventually prevents the PCIe NVME drive from being accessible.
> > > > 
> > > > Add a quirk for these platforms to avoid the resource being removed.
> > > > 
> > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > ---
> > > > We are running into the issue on more devices than just Surface Pro X
> > > > now, so trying to sort it out with a quirk as suggested by Lorenzo [1].
> > > 
> > > One thing I don't like about this application of quirks is that the
> > > list of affected platforms is likely to grow, which is an ongoing
> > > burden for users and developers.
> > > 
> > > Can we have a conversation with Qualcomm about how they *intend* this
> > > to work?  Linux is probably doing something wrong (interpreting
> > > something differently than Windows does), and if we could fix that, we
> > > have a better chance of future platforms working without quirks.
> > 
> > Catch-22. What if some firmware would add host bridge MMIO register
> > space (marked as consumer) in the _CRS ? We would end up allocating
> > BAR regions in there, which is not right, so your commit:
> > 
> > 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from host bridge windows")
> > 
> > is correct and if we revert it we would trigger regressions on some
> > arm64 platforms for the reason I mention above.
> > 
> > We can look for clarification at ACPI specs level but for firmware
> > that is out there I am not sure what options we have.
> 
> I don't remember why 8fd4391ee717 exists; I assume there was some
> platform that needed it.  I should have included that in the commit
> log; mea culpa.

I believe it is because there were arm64 platforms (early) that added a
consumer descriptor in the host bridge CRS with MMIO registers space in
it (I am not sure I can find the bug report - it has been a while,
remember the issue with non-ECAM config space and where to add the MMIO
resource required to "extend" MCFG config space ? I will never forget
that :)).

> In any event, I assume Windows works on both that platform and the
> ones mentioned in this quirk, and I assume Windows doesn't require
> platform-specific quirks for something like this.

I don't think it can work *without* quirks.

If, for reasons that I don't understand, anyone would add consumer
resources in the host bridge CRS that include at the same time PCI
memory windows and bridge MMIO registers, how can Windows detect which
one is what ? There is no way - at least none I can see.

Most likely, on platforms on which Windows boots, nobody ever added
in FW MMIO register space as a consumer resource in the host bridge
CRS (or Windows has a quirk mechanism for those).

> I admit that's a lot of assuming, but if Windows can do it, Linux
> should be able to do it, too.

I don't think it can do it, would be happy to be wrong.

I can ask, that will not solve anything but at least we know.

Lorenzo

> > > > +static struct acpi_platform_list qcom_platlist[] = {
> > > > +	/* Thinkpad X13s */
> > > > +	{ "LENOVO", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> > > > +	/* Microsoft Surface Pro 9 (5G) and Windows Dev Kit 2023 */
> > > > +	{ "QCOMM ", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> > > > +	/* Microsoft Surface Pro X */
> > > > +	{ "QCOMM ", "SDM8180 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
