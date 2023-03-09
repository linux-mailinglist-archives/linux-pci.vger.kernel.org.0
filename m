Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619306B2C2B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 18:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCIRiu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 12:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCIRiq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 12:38:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EA9F31FB;
        Thu,  9 Mar 2023 09:38:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88B0361CA5;
        Thu,  9 Mar 2023 17:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A326BC433EF;
        Thu,  9 Mar 2023 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678383518;
        bh=iajjPMk40xiWGEaEZlqlsOqiEOpuHw6FDCZfmoz0Cv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pDuWk9tubZCqcPaxKqF6b8uZ97kOMw/Lj7YS0Mz468atWYwDN+pVQ21mFE7UyRH7q
         0xMwnZjji/6LfjYtrMqLMiIEKt4iuyOkXZMBEChyzSzCU3FTxgKUPOHY4vGXUJML/P
         0zxalYawcdsV9Bn+ekkIVTjJQ7Ih8jZxNPso87vm3sTnCivcQAoL+NUXRAd1hGbOSa
         4k80nczkm8imqt0nP0BK6sLV9wTMx99xcGi/EwsjoAUp+4I0X8AYQ0aeC8mdGfKSU4
         4E4xOpQ/ppbwIw6FY/gUyMzyB3jGOG9vxMJ5t85CDqNARtS5yEs3Q4M3VbEa8Gggtf
         5hiJrJKwdV/HA==
Date:   Thu, 9 Mar 2023 11:38:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Add quirk for platforms running Windows
Message-ID: <20230309173836.GA1148798@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309025212.GB18319@T480>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 09, 2023 at 10:52:13AM +0800, Shawn Guo wrote:
> + linux-arm-msm and MSM maintainer Bjorn
> 
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
> 
> It's a very reasonable concern.  I really hope that Qualcomm will start
> thinking about Linux support on these machines in the future not too far
> away, so that the list will not grow too long.
> 
> > Can we have a conversation with Qualcomm about how they *intend* this
> > to work?  Linux is probably doing something wrong (interpreting
> > something differently than Windows does), and if we could fix that, we
> > have a better chance of future platforms working without quirks.
> 
> Today Qualcomm only ships and cares about Windows on these machines, but
> I believe it will change sooner or later.

I don't maintain arch/arm64/kernel/pci.c, but my opinion is that we
should not pursue quirks like this until we've tried really hard to
figure out a generic approach.

Bjorn
