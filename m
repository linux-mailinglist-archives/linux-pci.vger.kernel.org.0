Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABFC49F14D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 03:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345548AbiA1CwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 21:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241793AbiA1CwR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 21:52:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1DC061714
        for <linux-pci@vger.kernel.org>; Thu, 27 Jan 2022 18:52:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B88F9B82402
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 02:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A215C340E4;
        Fri, 28 Jan 2022 02:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643338334;
        bh=aqkeWsQtWjqqKWyZMaIOG3+r8UrVOPu2Ui7eWxUPCIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XnAj4VXCjzFbfT+Cm7+w0H64qcRMa+OfLwLdVWDRlPEBggn6CrIJWpVFMtBLo2SP6
         DWKdCswnGZ3O9dW9+8rgfqWAMnBWeBZ3ICcUZLuc7YW1XmN2kwBs7I6vZtDb9H6CxU
         uxMWtxEDhqLIijZN0hb9OORdLTnnL0ETQQd7d7Krhf0EV2eMsfUxHjVH3x7/0vqlQH
         m8aBGcVhwVOWQSd9fL1kSIfwbWbBAJ3LTbbkSajJ2Zil23z2p5sRZlszKC/whCU51v
         2J0fXSsZGmrixqre2gmqxU2pGQkDQjIxkhdoGbIMVuGuaYq9y5IEoeg8RvK5Ho9Nha
         jPo0QvSMsu2jg==
Date:   Thu, 27 Jan 2022 20:52:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220128025212.GA152555@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127154615.00003df8@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 03:46:15PM +0100, Mariusz Tkaczyk wrote:
> ...
> Thanks for your suggestions. Blazej did some tests and results were
> inconclusive. He tested it on two same platforms. On the first one it
> didn't work, even if he reverted all suggested patches. On the second
> one hotplugs always worked.
> 
> He noticed that on first platform where issue has been found initally,
> there was boot parameter "pci=nommconf". After adding this parameter
> on the second platform, hotplugs stopped working too.
> 
> Tested on tag pci-v5.17-changes. He have CONFIG_HOTPLUG_PCI_PCIE
> and CONFIG_DYNAMIC_DEBUG enabled in config. He also attached two dmesg
> logs to bugzilla with boot parameter 'dyndbg="file pciehp* +p" as
> requested. One with "pci=nommconf" and one without.
> 
> Issue seems to related to "pci=nommconf" and it is probably caused
> by change outside pciehp.

Maybe I'm missing something.  If I understand correctly, the problem
has nothing to do with the kernel version (correct me if I'm wrong!)

PCIe native hotplug doesn't work when booted with "pci=nommconf".
When using "pci=nommconf", obviously we can't access the extended PCI
config space (offset 0x100-0xfff), so none of the extended
capabilities are available.

In that case, we don't even ask the platform for control of PCIe
hotplug via _OSC.  From the dmesg diff from normal (working) to
"pci=nommconf" (not working):

  -Command line: BOOT_IMAGE=/boot/vmlinuz-smp ...
  +Command line: BOOT_IMAGE=/boot/vmlinuz-smp pci=nommconf ...
  ...
  -acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
  -acpi PNP0A08:00: _OSC: platform does not support [AER LTR]
  -acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
  +acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
  +acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
  +acpi PNP0A08:00: MMCONFIG is disabled, can't access extended PCI configuration space under this bridge.

Why are you using "pci=nommconf"?  As far as I know, there's no reason
to use that except to work around some kind of defect.

Bjorn
