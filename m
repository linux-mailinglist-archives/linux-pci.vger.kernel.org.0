Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A645EEFDFA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 14:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfKENLM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 08:11:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:15899 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388902AbfKENLM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 08:11:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 05:11:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="212538591"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 Nov 2019 05:11:08 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Nov 2019 15:11:07 +0200
Date:   Tue, 5 Nov 2019 15:11:07 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: INFO: task irq/129-pciehp:116 blocked for more than 120 seconds.
Message-ID: <20191105131107.GY2552@lahna.fi.intel.com>
References: <899c9bad-1e3b-8458-7b1f-7fa39556c52e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <899c9bad-1e3b-8458-7b1f-7fa39556c52e@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Nov 05, 2019 at 02:03:37PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9380 with Debian Sid/unstable with Linux 5.3.7
> the user reported today, that the USB input devices and the
> Ethernet device of the Dell TB16 docking station did not work
> at all after connecting the laptop to the docking station. The
> monitor connected over DisplayPort continued working.
> 
> Cutting the power from the docking station and reconnecting it
> did not help.
> 
> Linux reported messages like below.
> 
> ```
> [ 9511.727328] usb usb3: root hub lost power or was reset
> [ 9511.727329] usb usb4: root hub lost power or was reset
> [ 9511.729046] pcieport 0000:04:04.0: pciehp: Slot(4): Card not present
> [ 9511.729048] pcieport 0000:3a:00.0: Refused to change power state, currently in D3
> [ 9511.729059] pcieport 0000:3b:01.0: Refused to change power state, currently in D3
> [ 9511.729060] pcieport 0000:3b:04.0: Refused to change power state, currently in D3
> [ 9511.729078] pcieport 0000:3d:00.0: Refused to change power state, currently in D3
> [ 9511.729079] pcieport 0000:3b:04.0: pciehp: Slot(4-1): Card not present
> [ 9512.254595] thunderbolt 0-303: device disconnected
> [ 9512.254736] thunderbolt 0-3: device disconnected
> [ 9519.575474] thunderbolt 0000:05:00.0: 3: drom data crc32 mismatch (expected: 0xaf438340, got: 0xaf4383c0), continuing
> [ 9519.579227] thunderbolt 0-3: new device found, vendor=0xd4 device=0xb051
> [ 9519.579231] thunderbolt 0-3: Dell Dell Thunderbolt Cable
> [ 9520.048166] thunderbolt 0-303: new device found, vendor=0xd4 device=0xb054
> [ 9520.048168] thunderbolt 0-303: Dell Dell Thunderbolt Dock
> [ 9667.560748] INFO: task irq/129-pciehp:116 blocked for more than 120 seconds.
> [ 9667.560761]       Not tainted 5.3.0-1-amd64 #1 Debian 5.3.7-1
> [ 9667.560765] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 9667.560771] irq/129-pciehp  D    0   116      2 0x80004000
> [ 9667.560779] Call Trace:
> [ 9667.560803]  ? __schedule+0x2b9/0x6c0
> [ 9667.560816]  ? __wake_up_common+0x80/0x180
> [ 9667.560824]  schedule+0x39/0xa0
> [ 9667.560833]  schedule_timeout+0x20f/0x300
> [ 9667.560843]  ? ida_free+0xa8/0x130
> [ 9667.560851]  wait_for_completion+0x119/0x160
> [ 9667.560860]  ? wake_up_q+0x60/0x60
> [ 9667.560871]  kthread_stop+0x4d/0x110
> [ 9667.560881]  __free_irq+0x11f/0x300
> [ 9667.560889]  ? irq_finalize_oneshot.part.0+0x100/0x100
> [ 9667.560894]  free_irq+0x3a/0x70
> [ 9667.560905]  pcie_shutdown_notification+0x2b/0x40
> [ 9667.560911]  pciehp_remove+0x23/0x50
> [ 9667.560921]  pcie_port_remove_service+0x2f/0x40
> [ 9667.560933]  device_release_driver_internal+0xd8/0x1b0
> [ 9667.560942]  bus_remove_device+0xdb/0x140
> [ 9667.560949]  device_del+0x163/0x360
> [ 9667.560957]  ? irq_finalize_oneshot.part.0+0x100/0x100
> [ 9667.560963]  device_unregister+0x16/0x60
> [ 9667.560971]  ? pcie_port_find_device+0x60/0x60
> [ 9667.560977]  remove_iter+0x17/0x20
> [ 9667.560983]  device_for_each_child+0x58/0x90
> [ 9667.560992]  pcie_port_device_remove+0x1e/0x30
> [ 9667.561002]  pci_device_remove+0x3b/0xa0
> [ 9667.561012]  device_release_driver_internal+0xd8/0x1b0
> [ 9667.561021]  pci_stop_bus_device+0x68/0x90
> [ 9667.561028]  pci_stop_bus_device+0x2c/0x90
> [ 9667.561036]  pci_stop_and_remove_bus_device+0xe/0x20
> [ 9667.561044]  pciehp_unconfigure_device+0x7c/0x12f
> [ 9667.561052]  pciehp_disable_slot+0x6b/0xf0
> [ 9667.561060]  pciehp_handle_presence_or_link_change+0xdc/0x140
> [ 9667.561067]  pciehp_ist+0x10f/0x120
> [ 9667.561074]  irq_thread_fn+0x20/0x60
> [ 9667.561081]  irq_thread+0xdc/0x170
> [ 9667.561087]  ? irq_forced_thread_fn+0x80/0x80
> [ 9667.561097]  kthread+0xf9/0x130
> [ 9667.561104]  ? irq_thread_check_affinity+0xd0/0xd0
> [ 9667.561111]  ? kthread_park+0x80/0x80
> [ 9667.561121]  ret_from_fork+0x1f/0x40
> ```

The below patch should solve this one

https://lkml.org/lkml/2019/10/29/816

> Please find the Linux messages attached.
> 
> Shutting down the system, it did not power off but just hung at the
> last message, and had to be powered off by pressing the power button
> for 12 seconds.
> 
> This is the first time this happened, and I was *not* able to
> reproduce it after shutting down the laptop and rebooting the docking
> station by disconnecting the power.

I think it can be reproduced if you do plug/unplug several times. If you
have a longer chain the probability of the deadlock increases.
