Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A167D4516FC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 22:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347612AbhKOV4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 16:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345577AbhKOVzk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 16:55:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 504E361B31;
        Mon, 15 Nov 2021 21:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637013164;
        bh=Jqa1sy/xgpkd137yPrSXA8AX2pufnDtjpBH69HO/KBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A70jrUe2HlHiQL/CQPGSbJpNx4Y6Qoak5OBE8JYctluaS4V/qwNLN6rsmqK5l+GGO
         LKlUoIvXZVWyZI0HR+K1V+FIMXIPAktCKw9Fn9/8naV2DSuHlwJMs6ykKoCCBx8WqV
         qzLr6YBEp+PfplBhzJ7Fd2Es43bhQxHcLnhtghjoZ/DsCmXz2LAFyu2BbrNc8tMUgz
         Lq89UYuYLja/FGP34anMFdJ1ngRP5nMyNWKjKeXcjosElkIwnmHITJZn9t2aqbZNcy
         XtGpuldgg0QLLzXd8DjQ1uvYkugPuYD2oBoBN0g3dH8RdCOKh0/Erw2F5Y/+RcifKh
         WzkeBFyJxy3rg==
Date:   Mon, 15 Nov 2021 13:52:41 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, bjorn@helgaas.com,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215027] New: "PCIe Bus Error: severity=Corrected,
 type=Physical Layer" flood on Intel VMD + Samsung NVMe combination
Message-ID: <20211115215241.GA2893043@dhcp-10-100-145-180.wdc.com>
References: <bug-215027-41252@https.bugzilla.kernel.org/>
 <20211115212050.GA1588607@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115212050.GA1588607@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 03:20:50PM -0600, Bjorn Helgaas wrote:
> [+cc Naveen, NVMe, VMD folks]
> 
> On Mon, Nov 15, 2021 at 07:17:01AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=215027
> > 
> >             Bug ID: 215027
> >            Summary: "PCIe Bus Error: severity=Corrected, type=Physical
> >                     Layer" flood on Intel VMD + Samsung NVMe combination
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: mainline, linux-next
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: kai.heng.feng@canonical.com
> >         Regression: No
> > 
> > The following tests (and any combination of them) don't help:
> > - Change NVMe LTR value to 0 or any other number
> > - Disable NVMe APST
> > - Disable PCIe ASPM
> > - Any version of kernel, including linux-next
> > - "Fix long standing AER Error Handling Issues" patch series [1]
> > 
> > [1]
> > https://lore.kernel.org/linux-pci/cover.1635179600.git.naveennaidu479@gmail.com/
> 
> Thanks a lot for the report, Kai-Heng.  It's on v5.15, which is good,
> and not marked as a regression.  Samples from dmesg:
> 
>   [    0.408995] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
>   [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
>   [    0.412207] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
>   [    1.367220] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
>   [    1.490742] vmd 0000:00:0e.0: Bound to PCI domain 10000
>   [    1.569083] nvme nvme0: pci function 10000:e1:00.0
>   [    1.571421] pcieport 10000:e0:06.0: can't derive routing for PCI INT A
>   [    1.573997] nvme 10000:e1:00.0: PCI INT A: not connected
>   [    1.579028] pcieport 10000:e0:06.0: AER: Corrected error received: 10000:e1:00.0
>   [    1.584839] nvme 10000:e1:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver)
>   [    1.587454] nvme 10000:e1:00.0:   device [144d:a80a] error status/mask=00000001/0000e000
>   [    1.589502] nvme 10000:e1:00.0:    [ 0] RxErr
>   [    1.589813] nvme nvme0: Shutdown timeout set to 10 seconds
>   [    1.591509] pcieport 10000:e0:06.0: AER: Corrected error received: 10000:e1:00.0
>   [    1.595252] pcieport 10000:e0:06.0: AER: can't find device of IDe100
>   [    1.597213] pcieport 10000:e0:06.0: AER: Corrected error received: 10000:e1:00.0
>   ...

Just for testing purposes, does it still produce the repeated error
messages if you disable VMD?
