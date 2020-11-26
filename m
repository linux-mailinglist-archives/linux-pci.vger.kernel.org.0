Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5772A2C4C92
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 02:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgKZBYc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 20:24:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:47619 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730861AbgKZBYb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 20:24:31 -0500
IronPort-SDR: 9im9K55+2J0t7EbxWDfTNyBGYsP5tQHpYWd6ypyjGaGAgFH8Q25jdI8s3LAFHJqxQQ2bU52rjJ
 KuKDua8FpguA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="169662535"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="169662535"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 17:24:31 -0800
IronPort-SDR: gb93F3GoatNOuqc4+u7f5LeLVs3VebqlGN5fEPZ1DnCh2MyIpVaNmZF2QEz5TaC1w7WdPa3S0i
 ec/I8p4+hxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="537123847"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga005.fm.intel.com with ESMTP; 25 Nov 2020 17:24:21 -0800
Date:   Thu, 26 Nov 2020 09:24:21 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rui.zhang@intel.com, len.brown@intel.com
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
Message-ID: <20201126012421.GA92582@shbuild999.sh.intel.com>
References: <20201119181904.149129-1-helgaas@kernel.org>
 <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Wed, Nov 25, 2020 at 01:46:23PM +0100, Thomas Gleixner wrote:
> On Thu, Nov 19 2020 at 12:19, Bjorn Helgaas wrote:
> > 62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail
> > platform") implemented force_disable_hpet() as a special early quirk.
> > These run before the PCI core is initialized and depend on the
> > x86/pci/early.c accessors that use I/O ports 0xcf8 and 0xcfc.
> >
> > But force_disable_hpet() doesn't need to be one of these special early
> > quirks.  It merely sets "boot_hpet_disable", which is tested by
> > is_hpet_capable(), which is only used by hpet_enable() and hpet_disable().
> > hpet_enable() is an fs_initcall(), so it runs after the PCI core is
> > initialized.
> 
> hpet_enable() is not an fs_initcall(). hpet_late_init() is and that
> invokes hpet_enable() only for the case that ACPI did not advertise it
> and the force_hpet quirk provided a base address.
> 
> But hpet_enable() is also invoked via:
> 
>  start_kernel()
>    late_time_init()
>      x86_late_time_init()
>        hpet_time_init()
> 
> which is way before the PCI core is available and we really don't want
> to set it up there if it's known to be broken :)
> 
> Now the more interesting question is why this needs to be a PCI quirk in
> the first place. Can't we just disable the HPET based on family/model
> quirks?
> 
> e0748539e3d5 ("x86/intel: Disable HPET on Intel Ice Lake platforms")
> f8edbde885bb ("x86/intel: Disable HPET on Intel Coffee Lake H platforms")
> fc5db58539b4 ("x86/quirks: Disable HPET on Intel Coffe Lake platforms")



> 62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail platform")
I added this commit, and I can explain some for Baytrail. There was
some discussion about the way to disable it:
https://lore.kernel.org/lkml/20140328073718.GA12762@feng-snb/t/

It uses PCI ID early quirk in the hope that later Baytrail stepping
doesn't have the problem. And later on, there was official document
(section 18.10.1.3 http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-1.pdf)
stating Baytrail's HPET halts in deep idle. So I think your way of 
using CPUID to disable Baytrail HPET makes more sense.


> I might be missing something here, but in general on anything modern
> HPET is mostly useless.

IIUC, nowdays HPET's main use is as a clocksource watchdog monitor.
And in one debug case, we found it still useful. The debug platform has 
early serial console which prints many messages in early boot phase,
when the HPET is disabled, the software 'jiffies' clocksource will
be used as the monitor. Early printk will disable interrupt will
printing message, and this could be quite long for a slow 115200
device, and cause the periodic HW timer interrupt get missed, and
make the 'jiffies' clocksource not accurate, which will in turn
judge the TSC clocksrouce inaccurate, and disablt it. (Adding Rui,
Len for more details)

Thanks,
Feng


> Thanks,
> 
>         tglx
