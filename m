Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684DC542456
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbiFHBCt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838016AbiFHAAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 20:00:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED41F21B3;
        Tue,  7 Jun 2022 16:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D68EBB8247A;
        Tue,  7 Jun 2022 23:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E65BC34114;
        Tue,  7 Jun 2022 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654645780;
        bh=NS/V46V47Sf9XBKle2Qi4MX9X2KwRhjCPnKdxUCJENs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MtaQCLxTXJb2arBWP/ih+TVPapyfo6WhuBRaYOcMnYtmOTaVK0PtQD+wjbXQd8mIG
         4y1mYzJroYbk09J6XAtHpZphidDa1YWISLrPm287rbc8512LcKWBMpjl8Ml7wKlaKO
         m3bgYQfUh22JCEGrkN0fEj4OxdS0Lw+9AoMWfODbistdrClrCSbWOXlz0BTv/ureFZ
         vwH8bXRETh1/Tn/wH+Mt8aEcvKE+4961M4Hbdmn5FlrJ7evcl4p/O46ubR1gb0juAu
         lDX8s8aZBkcFI6CRNLm2l2YuO+UtXv8ufOl3mknsSZlRCNBS5Qodg5nxu+6WJpLp22
         XPN31KVPHKw4Q==
Date:   Tue, 7 Jun 2022 18:49:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [Bug 216094] New: pci-mvebu: SATA HDDs via 88SE6121 AHCI fail
 with Marvell 88F6281 PCIe
Message-ID: <20220607234937.GA356793@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bug-216094-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 07, 2022 at 07:29:03AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216094
> 
>            Summary: pci-mvebu: SATA HDDs via 88SE6121 AHCI fail with
>                     Marvell 88F6281 PCIe
>     Kernel Version: 3.16 ... 5.10
>           Reporter: hajo-linux-bugzilla@noerenberg.de
>                 CC: pali@kernel.org
>         Regression: No
> 
> I would like to continue the SATA-related topic started with Pali
> Rohár at the U-Boot mailing list [1]. I have analysed the issue
> further and come the following conclusion that it is related to the
> PCIe subsystem:
> 
> SATA-2 and SATA-3 hard disks connected to a 88SE6121 (AHCI)
> controller, wired via PCIe to the 88F6281 SoC fail to operate
> ("failed to IDENTIFY" ... "qc timeout") when the pci-mvebu driver
> (Kernel 3.16 .. 5.10 Debian) is in use.

Please attach the complete dmesg logs showing this issue.

From your lspci output with v3.2, the SATA controller is at 00:01.0:

  00:01.0 IDE [0101]: Marvell 88SE6121 SATA II

The v3.16 (with DTB) lspci output is essentially the same except the
controller is at 01:00.0:

  01:00.0 IDE [0101]: Marvell 88SE6121 SATA II

The ahci driver is bound in both cases.  The PCI address and I/O port
assignment differences are of no consequence unless some mvebu driver
defect keeps them from working.

I think what we need is a complete dmesg log and DTB from the newest
possible kernel that fails, plus the same logs from the newest kernel
that works.

> More details:
> 
> - The problem does not exist in 2.6 and 3.16 kernels. With the old
> mach-kirkwood/pcie.c driver all SATA-2/3 hard disks work correctly.
> Especially with a 3.16 kernel it is possible to have identical
> ATA/AHCI drivers but try both PCIe drivers: without DTB ->
> mach-kirkwood -> SATA-2/3 HDDs work; with DTB -> mach-mvebu -> HDDs
> fail.
> 
> - The problem is specific to SATA-2/3 HDDs. Very old SATA-1-only
> HDDs work without problems. This might be related to the available
> data lanes, DMA or other bandwidth-related things -- I can only
> guess. Interestingly it does not help to limit SATA speed
> (libata.force=1.5G ...) with SATA-2/3 HDDs, only 'pure' SATA-1 HDDs
> work with pci-mvebu.
> 
> - The problem was identified with the Seagate Blackarmor NAS440
> hardware. Forum posts show that other users experience similar
> problems with the (very similar) Iomega ix4-200d NAS [2].
> 
> - Within patched U-Boot [3] all (Sata-1/2/3) HDDs always work. Same
> for the 88F6281 SoC onboard SATA ports (sata_mv - not connected via
> PCIe).
> 
> - The mach-kirkwood driver operates the 6281 as class "Host bridge
> [0600]" with Cap "Express (v1) Root Port", the mach-mvebu driver as
> class "PCI bridge [0604]" with "Express (v2) Root Port"
> [4][5][6][7]. Notably the v1/v2, cache line size 32/64 or the
> missing interrupt route might be a key difference.
> 
> From the sources I see that all PCI drivers (mach-kirkwood,
> mach-mvebu and U-Boot) do various unconventional 'magic' things
> (rewriting PCI class of the root complex, changing capabilitys, host
> emulation and so on). This is the point where I currently get lost
> and ask for your help.

> [1] https://lists.denx.de/pipermail/u-boot/2022-March/479197.html
> [2] https://forum.doozan.com/read.php?2,94079,95519#msg-95519
> [3] https://lists.denx.de/pipermail/u-boot/2022-March/479227.html
> [4] lspci Linux version 3.2.0-4-kirkwood mach-kirkwood/pci.c: HDDs ok
> [5] lspci Linux version 3.16.0-0.bpo.4-kirkwood - with DTB -> mvebu-pci: HDDs
> fail
> [6] lspci Linux version 3.16.0-0.bpo.4-kirkwood - without DTB ->
> mach-kirkwood/pci.c: HDDs ok
> [7] lspci Linux version 5.10.0-11-marvell (Debian bullseye) mvebu-pci: HDDs
> fail
