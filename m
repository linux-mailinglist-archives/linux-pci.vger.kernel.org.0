Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98F1542976
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiFHIaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiFHI3K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 04:29:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B828CFB4;
        Wed,  8 Jun 2022 00:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00167B81B34;
        Wed,  8 Jun 2022 07:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC9BC3411D;
        Wed,  8 Jun 2022 07:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654674728;
        bh=gS10ZB6Wtd0r48aPzfM0OfzrzAHMoUWP8IgQwbfbPzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMQYCPm4Uwx919OpTJB7WMivRIA3qIkcRuAFdU2j6jS8kb+AmP4qcFPr7Hvcb8Czh
         XhGP7A1r19Q15qcXd8Dfy/c4c+f4UVgYYOoD1pmqc4gQkYBvTlk8lSfpX34cNZDxub
         utN7l6+LDJ10ctfc2QApR5JUQNCQtviMeXHb2Z2pt5FbI0nTI4GEcgXWI9EapwmoEe
         R44cPVkLKuFm7bYdi/SuBDjuOG2ey32mVd2bWJapR2/NBOCC7Ju30jHG4MMvYYYdlT
         E0ZiZ22aC5ubANBYqNWz55BAzclmycI4W3bUTuXdAL2ZiHtiiSmENSSy+nwpXSdeFn
         2LBy0Qt3pvYpw==
Received: by pali.im (Postfix)
        id 5BDA27D5; Wed,  8 Jun 2022 09:52:05 +0200 (CEST)
Date:   Wed, 8 Jun 2022 09:52:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>,
        linux-ide@vger.kernel.org
Subject: Re: [Bug 216094] New: pci-mvebu: SATA HDDs via 88SE6121 AHCI fail
 with Marvell 88F6281 PCIe
Message-ID: <20220608075205.wc55e33sxndpfrim@pali>
References: <bug-216094-41252@https.bugzilla.kernel.org/>
 <20220607234937.GA356793@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607234937.GA356793@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 07 June 2022 18:49:37 Bjorn Helgaas wrote:
> On Tue, Jun 07, 2022 at 07:29:03AM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216094
> > 
> >            Summary: pci-mvebu: SATA HDDs via 88SE6121 AHCI fail with
> >                     Marvell 88F6281 PCIe
> >     Kernel Version: 3.16 ... 5.10
> >           Reporter: hajo-linux-bugzilla@noerenberg.de
> >                 CC: pali@kernel.org
> >         Regression: No
> > 
> > I would like to continue the SATA-related topic started with Pali
> > Rohár at the U-Boot mailing list [1]. I have analysed the issue
> > further and come the following conclusion that it is related to the
> > PCIe subsystem:
> > 
> > SATA-2 and SATA-3 hard disks connected to a 88SE6121 (AHCI)
> > controller, wired via PCIe to the 88F6281 SoC fail to operate
> > ("failed to IDENTIFY" ... "qc timeout") when the pci-mvebu driver
> > (Kernel 3.16 .. 5.10 Debian) is in use.
> 
> Please attach the complete dmesg logs showing this issue.
> 
> From your lspci output with v3.2, the SATA controller is at 00:01.0:
> 
>   00:01.0 IDE [0101]: Marvell 88SE6121 SATA II
> 
> The v3.16 (with DTB) lspci output is essentially the same except the
> controller is at 01:00.0:

Old kernel (incorrectly) reports Root Port and Endpoint device from the
other end of the link to the same bus zero. Hence the difference in bus
number between old kernel and new kernel.

>   01:00.0 IDE [0101]: Marvell 88SE6121 SATA II
> 
> The ahci driver is bound in both cases.  The PCI address and I/O port
> assignment differences are of no consequence unless some mvebu driver
> defect keeps them from working.
> 
> I think what we need is a complete dmesg log and DTB from the newest
> possible kernel that fails, plus the same logs from the newest kernel
> that works.

+1

> > More details:
> > 
> > - The problem does not exist in 2.6 and 3.16 kernels. With the old
> > mach-kirkwood/pcie.c driver all SATA-2/3 hard disks work correctly.
> > Especially with a 3.16 kernel it is possible to have identical
> > ATA/AHCI drivers but try both PCIe drivers: without DTB ->
> > mach-kirkwood -> SATA-2/3 HDDs work; with DTB -> mach-mvebu -> HDDs
> > fail.

So it looks like that issue is with DT based setup.

Just by a chance, could you try to boot kernel with pcie_aspm=off or
pci=nomsi cmdline options? There are some issues in driver/controller
related to link retraining and MSI interrupts which ASPM kernel code can
trigger.

> > - The problem is specific to SATA-2/3 HDDs. Very old SATA-1-only
> > HDDs work without problems. This might be related to the available
> > data lanes, DMA or other bandwidth-related things -- I can only
> > guess. Interestingly it does not help to limit SATA speed
> > (libata.force=1.5G ...) with SATA-2/3 HDDs, only 'pure' SATA-1 HDDs
> > work with pci-mvebu.
> > 
> > - The problem was identified with the Seagate Blackarmor NAS440
> > hardware. Forum posts show that other users experience similar
> > problems with the (very similar) Iomega ix4-200d NAS [2].
> > 
> > - Within patched U-Boot [3] all (Sata-1/2/3) HDDs always work. Same
> > for the 88F6281 SoC onboard SATA ports (sata_mv - not connected via
> > PCIe).
> > 
> > - The mach-kirkwood driver operates the 6281 as class "Host bridge
> > [0600]" with Cap "Express (v1) Root Port", the mach-mvebu driver as
> > class "PCI bridge [0604]" with "Express (v2) Root Port"
> > [4][5][6][7]. Notably the v1/v2, cache line size 32/64 or the
> > missing interrupt route might be a key difference.
> > 
> > From the sources I see that all PCI drivers (mach-kirkwood,
> > mach-mvebu and U-Boot) do various unconventional 'magic' things
> > (rewriting PCI class of the root complex, changing capabilitys, host
> > emulation and so on). This is the point where I currently get lost
> > and ask for your help.

This 'magic' is there because of broken PCIe controller and its PCIe
Root Port in all 32-bit Marvell SoCs.

> > [1] https://lists.denx.de/pipermail/u-boot/2022-March/479197.html
> > [2] https://forum.doozan.com/read.php?2,94079,95519#msg-95519
> > [3] https://lists.denx.de/pipermail/u-boot/2022-March/479227.html
> > [4] lspci Linux version 3.2.0-4-kirkwood mach-kirkwood/pci.c: HDDs ok
> > [5] lspci Linux version 3.16.0-0.bpo.4-kirkwood - with DTB -> mvebu-pci: HDDs
> > fail
> > [6] lspci Linux version 3.16.0-0.bpo.4-kirkwood - without DTB ->
> > mach-kirkwood/pci.c: HDDs ok
> > [7] lspci Linux version 5.10.0-11-marvell (Debian bullseye) mvebu-pci: HDDs
> > fail
