Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9497F57652F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 18:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGOQTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 12:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGOQTV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 12:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08AD183BA
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 09:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A404621DF
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 16:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D32C34115;
        Fri, 15 Jul 2022 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657901959;
        bh=+cMCsw85AP2EAn3joW3K0m3o3WexDNoNsuwSCXgz1Hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AwPXllO2SKaIc94Pdh6AeB+QFBVyu0iiazRAyRnqZTG+SwVgQ2YlalYImiN3Uy95c
         tvGxxmopb1FT/pmxqFsnaA9aB9Kz5o45+YugKoZKZp5Inv1xAutHWbRS7hcJ+6u22g
         uEDloBa7AZqX9OBZtClzo1lDq9Tf9SJ+ya8BvoSzFFqzlbZBGM2Hy43Rk9HIIj+g/t
         HMwwuCYL/gVOOeRupQPaQ2wfGhTgde6p9LyRxErkcf6sJHL7Z021WX62LcCqXxUz2Q
         gmK6B/PXqlCKd3tEuEBiFcGVnfxuatfgJxztt0Ftsw7Ep6G+MDFOmOCaLdcFq7yCQO
         GlSh49ltYvLcw==
Date:   Fri, 15 Jul 2022 11:19:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Karri =?iso-8859-1?Q?H=E4m=E4l=E4inen?= 
        <kh.bugreport@outlook.com>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [Bug 216252] New: AMD APU IOMMU: pci 0000:00:00.2: can't derive
 routing for PCI INT A
Message-ID: <20220715161917.GA1136556@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216252-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Joerg, Suravee]

On Fri, Jul 15, 2022 at 02:21:17PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216252
> 
>             Bug ID: 216252
>            Summary: AMD APU IOMMU: pci 0000:00:00.2: can't derive routing
>                     for PCI INT A
>            Product: Platform Specific/Hardware
>            Version: 2.5
>     Kernel Version: 5.18.5
>           Hardware: AMD
>           Priority: P1
>           Assignee: platform_x86_64@kernel-bugs.osdl.org
>           Reporter: kh.bugreport@outlook.com
>                 CC: adm@prnet.info, bjorn@helgaas.com,
>                     bugzilla.kernel.org@e3q.eu,
>                     drivers_pci@kernel-bugs.osdl.org, hxss@ya.ru,
>                     josh.mcd31@gmail.com, kh.bugreport@outlook.com,
>                     marcel@ziswiler.com, snafu109@gmail.com,
>                     whenov@gmail.com
>         Regression: No
> 
> Created attachment 301439
>   --> https://bugzilla.kernel.org/attachment.cgi?id=301439&action=edit
> acpidump from ASRock B450M Pro4-F R2.0
> 
> +++ This bug was initially created as a clone of Bug #212261 +++
> 
> Bug 212261 - pci 0000:00:00.2: can't derive routing for PCI INT A
> https://bugzilla.kernel.org/show_bug.cgi?id=212261
> 
> 
> Crossposting from drivers/pci to Platform Specific/Hardware/x86-64 with AMD
> hardware specificy.
> 
> AMD IOMMU IRQ routing problems.
> 
> [    0.273902] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
> [    0.273932] pci 0000:00:00.2: can't derive routing for PCI INT A
> [    0.273933] pci 0000:00:00.2: PCI INT A: not connected
> 
> Common to AMD reference ACPI / firmware / AGESA for Zen APUs?
> At least Raven Ridge (desktop) and Renoir (both desktop and laptop).
> 
> Personally tested with AMD 2200G and 4650G with Asus and ASRock B450
> motherboards.

My guess is a BIOS bug, maybe missing _PRT entries.

Added a couple AMD IOMMU folks in case they've seen this or have BIOS
contacts who could help.
