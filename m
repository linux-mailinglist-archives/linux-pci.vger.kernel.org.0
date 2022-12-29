Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C721A658F42
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 17:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiL2QwL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 11:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiL2QwC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 11:52:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9102623;
        Thu, 29 Dec 2022 08:52:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13D9761337;
        Thu, 29 Dec 2022 16:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D69C433EF;
        Thu, 29 Dec 2022 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672332720;
        bh=pWJ1fVqPn1KZwUbrxRmW638nDmclmsop8peDGjpTTN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a88gwGaKAw6Xb/2AO44XcfYfdMiKRO+8F2gF6RevXSxYsdaeK5KcCVJGGrtHLfCMb
         VqIj3ePz/Np+1DCBcC9m4OCJePo8YuWm8sJIlgGJSkkLA+Pk8xJ3HnMtl81LjFl7Ea
         89FX5A3jhYLmsHhrgTedzBOAZ6W8SuJL1JtHYH4HKQxSCl5Xjd9af8kdg4812Qh4Wj
         6L/HVPvXDv1QPcyJvBW9VJAJ2cGgMO6CDZVqvq3iO1DX/g0WjNYJDAJBcq6+e/VAW9
         siG1mTr65a8IBvSg0KaK88/GHXzVXYcN1XXQZql/IxukLVq4Jc8alCd5DvVOx1hZ6j
         TbAUzpvvMl1/w==
Date:   Thu, 29 Dec 2022 10:51:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Avoid enabling AER on Thunderbolt devices
Message-ID: <20221229165158.GA608748@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p4CU+K5sOumJYxENRE-Ci7zPKxk0ROszvBUPWV=1xYZyw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 29, 2022 at 11:45:51AM +0800, Kai-Heng Feng wrote:
> On Mon, Dec 26, 2022 at 11:46 PM Pali Rohár <pali@kernel.org> wrote:
> > On Monday 26 December 2022 23:30:31 Kai-Heng Feng wrote:
> > > We are seeing igc ethernet device on Thunderbolt dock stops working
> > > after S3 resume because of AER error, or even make S3 resume freeze:

> > > pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:00:1d.0
> > > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> > > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00008000/00002000
> > > pcieport 0000:00:1d.0:    [15] HeaderOF
> > > pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > > pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > > pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 00000000
> > > pcieport 0000:00:1d.0: AER:   Error of this Agent is reported first
> > > pcieport 0000:04:01.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > > pcieport 0000:04:01.0:   device [8086:1136] error status/mask=00300000/00000000
> > > pcieport 0000:04:01.0:    [20] UnsupReq               (First)
> > > pcieport 0000:04:01.0:    [21] ACSViol
> > > pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04000052 00000000 00000000
> > > thunderbolt 0000:05:00.0: AER: can't recover (no error_detected callback)
> > >
> > > This supposedly should be fixed by commit c01163dbd1b8 ("PCI/PM: Always disable
> > > PTM for all devices during suspend"), but somehow it doesn't work for
> > > this case.
> > >
> > > By dumping the PCI_PTM_CTRL register on resume, it turns out PTM is
> > > already flipped on by either the Thunderbolt dock firmware or the host
> > > BIOS. Writing 0 to PCI_PTM_CTRL yields the same result.
> > >
> > > Windows is however not affected by this issue, by using WinDbg's !pci
> > > command, it shows that AER is not enabled for devices connected via
> > > Thunderbolt port, and that's the reason why Windows doesn't exhibit the
> > > issue.
> >
> > Could you try to manually enable AER on Windows (via touching PCIe
> > config registers) if Windows can trigger this issue too, or not?
> 
> Actually I misread the output of WinDbg !pci command, the AER is also
> enabled under Windows.
> !pci command also shows the same PTM error in Header Log. I can also
> find the AER warnings in Windows' Event Viewer.

I suspected a Linux problem (e.g., we messed up disabling/restoring
PTM).  That's why I was asking about your debug patch, to see if we
could find something wrong with Linux.

But if you also see the Unsupported Request errors on Windows, that
makes it more likely that it's a firmware issue.

> I am asking hardware vendor to see if it's possible to fix it at
> firmware side.

I assume PTM was not enabled by firmware at boot-time (you might be
able to confirm this by tweaking early_dump_pci_device() to dump more
space and using "pci=earlydump").  If that's the case, it seems
strange that firmware would enable PTM at resume-time.

Linux *should* be disabling PTM at suspend-time, so firmware should
never see the fact that it had been enabled, so I don't know how it
could conclude that it's safe to enable PTM at resume-time.

Bjorn
