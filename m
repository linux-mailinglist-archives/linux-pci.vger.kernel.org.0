Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB166B554A
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 00:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjCJXFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 18:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCJXFo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 18:05:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B02135955;
        Fri, 10 Mar 2023 15:05:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28BB561D49;
        Fri, 10 Mar 2023 23:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FBFC433D2;
        Fri, 10 Mar 2023 23:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678489541;
        bh=qYf7XwsN3paZxawhDYAE5mQqUB8cGC47Gx+srOcNCLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WxtsZXJnV6YIb9iZHhO/zmGSkmBWj4CDw+iRqijYdhHcVErkfqUtb0zJ35Lv0EZxU
         i5VJfsuu/mZdzc0FeisJzSsw1XDqHrK338fvVZCdjiiOJ3rch9A1YfebAGs6JohYoH
         qsm+MaSmdexvgI44G/3sKrINfU+1fRSE8ZO3OAB2ZAVTf9yv1KCAbeZ0KKOeshsa9e
         2kjspx8opCNRL6ffRGDjvY1Ft086IYzztnFdqwfnTZMIgpzeA3aW1S9hmaDnOqwlDL
         TwezQaKFX8So4kX5OIdGe5HpPffjGRqgdMrWuuNbF3mRR2DRhcqEbtmLK90jdd4rFJ
         Aa64mApHwIt6g==
Date:   Fri, 10 Mar 2023 17:05:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Add quirk for platforms running Windows
Message-ID: <20230310230539.GA1289856@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAswHyaYjeqjW/+A@lpieralisi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 02:26:55PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Mar 08, 2023 at 12:53:10PM -0600, Bjorn Helgaas wrote:
> > On Mon, Feb 27, 2023 at 10:12:21AM +0800, Shawn Guo wrote:
> > > Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> > > host bridge windows") introduced a check to remove host bridge register
> > > resources for all arm64 platforms, with the assumption that the PNP0A03
> > > _CRS resources would always be host bridge registers and never as windows
> > > on arm64.
> > > 
> > > The assumption stands true until Qualcomm Snapdragon Windows laptops
> > > emerge.  These laptops describe host bridge windows in PNP0A03 _CRS
> > > resources instead.  For example, the Microsoft Surface Pro X has host
> > > bridges defined as
> > > 
> > >     Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
> > >     Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> > > 
> > >     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > >     {
> > >         Name (RBUF, ResourceTemplate ()
> > >         {
> > >             Memory32Fixed (ReadWrite,
> > >                 0x60200000,         // Address Base
> > >                 0x01DF0000,         // Address Length
> > >                 )
> > >             WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> > >                 0x0000,             // Granularity
> > >                 0x0000,             // Range Minimum
> > >                 0x0001,             // Range Maximum
> > >                 0x0000,             // Translation Offset
> > >                 0x0002,             // Length
> > >                 ,, )
> > >         })
> > >         Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
> > >     }
> > > 
> > > The Memory32Fixed holds a host bridge window, but it's not properly
> > > defined as a "producer" resource.  Consequently the resource gets
> > > removed by kernel, and the BAR allocation fails later on:
> > > 
> > >     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
> > >     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> > >     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> > >     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> > > 
> > > This eventually prevents the PCIe NVME drive from being accessible.
> > > 
> > > Add a quirk for these platforms to avoid the resource being removed.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > > We are running into the issue on more devices than just Surface Pro X
> > > now, so trying to sort it out with a quirk as suggested by Lorenzo [1].
> > 
> > One thing I don't like about this application of quirks is that the
> > list of affected platforms is likely to grow, which is an ongoing
> > burden for users and developers.
> > 
> > Can we have a conversation with Qualcomm about how they *intend* this
> > to work?  Linux is probably doing something wrong (interpreting
> > something differently than Windows does), and if we could fix that, we
> > have a better chance of future platforms working without quirks.
> 
> Catch-22. What if some firmware would add host bridge MMIO register
> space (marked as consumer) in the _CRS ? We would end up allocating
> BAR regions in there, which is not right, so your commit:
> 
> 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from host bridge windows")
> 
> is correct and if we revert it we would trigger regressions on some
> arm64 platforms for the reason I mention above.
> 
> We can look for clarification at ACPI specs level but for firmware
> that is out there I am not sure what options we have.

I don't remember why 8fd4391ee717 exists; I assume there was some
platform that needed it.  I should have included that in the commit
log; mea culpa.

In any event, I assume Windows works on both that platform and the
ones mentioned in this quirk, and I assume Windows doesn't require
platform-specific quirks for something like this.  I admit that's a
lot of assuming, but if Windows can do it, Linux should be able to do
it, too.

> > > +static struct acpi_platform_list qcom_platlist[] = {
> > > +	/* Thinkpad X13s */
> > > +	{ "LENOVO", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> > > +	/* Microsoft Surface Pro 9 (5G) and Windows Dev Kit 2023 */
> > > +	{ "QCOMM ", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> > > +	/* Microsoft Surface Pro X */
> > > +	{ "QCOMM ", "SDM8180 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
