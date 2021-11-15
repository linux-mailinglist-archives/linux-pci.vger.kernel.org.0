Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E9D4516A1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 22:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347239AbhKOVgM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 16:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347997AbhKOVXs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 16:23:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D57B161B9F;
        Mon, 15 Nov 2021 21:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637011252;
        bh=skhBsF9w/buW3zrOdd3N7PdD+PdwPY7TKS34+FhWsLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t0+/pkguza5SlQFb61gkx0+RCdHBtQNeIFDsxd1x1oSaOXy4ZdMtn4+1c5t+4CVg2
         u53Opm3HIRjh+/OGB5cIWgETAFB4SZAp2IMbCOSjUm1M6824wKkYOM9DSxBKH0E0T+
         QORwysvCJ3DwgFc4GMuXyfvTOu2csZpnftWGwd5l/sGr5p0A0iLumvvWGNv5f/qeFB
         eQpexiDnm7yRA8Vrslu4/xNOVz1tXshJhv5nbvcwufUZSY3roEjbNC06aVk2IbKErB
         LCRBXXsLpKvvN9ELBNIq08r0NU7dKxwSEe4Oqaf+AxnqqN01e5OHFfROUIIqUhYS/4
         Fif0gecIISDbg==
Date:   Mon, 15 Nov 2021 15:20:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     bjorn@helgaas.com, Naveen Naidu <naveennaidu479@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215027] New: "PCIe Bus Error: severity=Corrected,
 type=Physical Layer" flood on Intel VMD + Samsung NVMe combination
Message-ID: <20211115212050.GA1588607@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-215027-41252@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Naveen, NVMe, VMD folks]

On Mon, Nov 15, 2021 at 07:17:01AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215027
> 
>             Bug ID: 215027
>            Summary: "PCIe Bus Error: severity=Corrected, type=Physical
>                     Layer" flood on Intel VMD + Samsung NVMe combination
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: mainline, linux-next
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: kai.heng.feng@canonical.com
>         Regression: No
> 
> The following tests (and any combination of them) don't help:
> - Change NVMe LTR value to 0 or any other number
> - Disable NVMe APST
> - Disable PCIe ASPM
> - Any version of kernel, including linux-next
> - "Fix long standing AER Error Handling Issues" patch series [1]
> 
> [1]
> https://lore.kernel.org/linux-pci/cover.1635179600.git.naveennaidu479@gmail.com/

Thanks a lot for the report, Kai-Heng.  It's on v5.15, which is good,
and not marked as a regression.  Samples from dmesg:

  [    0.408995] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
  [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
  [    0.412207] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
  [    1.367220] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
  [    1.490742] vmd 0000:00:0e.0: Bound to PCI domain 10000
  [    1.569083] nvme nvme0: pci function 10000:e1:00.0
  [    1.571421] pcieport 10000:e0:06.0: can't derive routing for PCI INT A
  [    1.573997] nvme 10000:e1:00.0: PCI INT A: not connected
  [    1.579028] pcieport 10000:e0:06.0: AER: Corrected error received: 10000:e1:00.0
  [    1.584839] nvme 10000:e1:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver)
  [    1.587454] nvme 10000:e1:00.0:   device [144d:a80a] error status/mask=00000001/0000e000
  [    1.589502] nvme 10000:e1:00.0:    [ 0] RxErr
  [    1.589813] nvme nvme0: Shutdown timeout set to 10 seconds
  [    1.591509] pcieport 10000:e0:06.0: AER: Corrected error received: 10000:e1:00.0
  [    1.595252] pcieport 10000:e0:06.0: AER: can't find device of IDe100
  [    1.597213] pcieport 10000:e0:06.0: AER: Corrected error received: 10000:e1:00.0
  ...
