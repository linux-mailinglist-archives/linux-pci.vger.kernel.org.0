Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACDF49F51A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 09:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347290AbiA1I3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 03:29:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:11396 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234154AbiA1I3i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 03:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358578; x=1674894578;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8mWBGCWwqokVCoOnFNTrTuq7YTbhJhHV/wj2yIzdG8=;
  b=PcNZIhQ2OpHbAILWyu2t18t1I0feuS7fma16rns00lxbmJP5Og13wYuM
   T3ysN6i+doezUmbYwe2TGOGk7WWiL7Go5ea4aWCCjdk63OSDUz58cBlOm
   x9qWrbG468Yhk3LeJv11ynfJid5IylzN17A88kSSxu+71y5dn2SBBe0Nd
   EUkx25kg7z8tmz0IQgTKCkCojxDjSVzj9ILh3qdiaPUDT0rJ9R1273PUP
   zWYhvg7wBmv0gpS/+Ykk4rOpWQjaLmfeQsKeXqq8MS8hBWTOP8ZmzwpZK
   dWabv5JSfH2OM0GUqGCuEf9aqlyx6u0/19vlxhgcrnG0SHwqd0gUF82fE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="234454695"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="234454695"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:29:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="697019867"
Received: from mtkaczyk-mobl1.ger.corp.intel.com (HELO localhost) ([10.213.14.254])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:29:36 -0800
Date:   Fri, 28 Jan 2022 09:29:31 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220128092931.00004a24@linux.intel.com>
In-Reply-To: <20220128025212.GA152555@bhelgaas>
References: <20220127154615.00003df8@linux.intel.com>
        <20220128025212.GA152555@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 27 Jan 2022 20:52:12 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Jan 27, 2022 at 03:46:15PM +0100, Mariusz Tkaczyk wrote:
> > ...
> > Thanks for your suggestions. Blazej did some tests and results were
> > inconclusive. He tested it on two same platforms. On the first one
> > it didn't work, even if he reverted all suggested patches. On the
> > second one hotplugs always worked.
> > 
> > He noticed that on first platform where issue has been found
> > initally, there was boot parameter "pci=nommconf". After adding
> > this parameter on the second platform, hotplugs stopped working too.
> > 
> > Tested on tag pci-v5.17-changes. He have CONFIG_HOTPLUG_PCI_PCIE
> > and CONFIG_DYNAMIC_DEBUG enabled in config. He also attached two
> > dmesg logs to bugzilla with boot parameter 'dyndbg="file pciehp*
> > +p" as requested. One with "pci=nommconf" and one without.
> > 
> > Issue seems to related to "pci=nommconf" and it is probably caused
> > by change outside pciehp.  
> 
> Maybe I'm missing something.  If I understand correctly, the problem
> has nothing to do with the kernel version (correct me if I'm wrong!)
> 
Hi Bjorn,

The problem occurred after the merge commit. It is some kind of
regression.

> PCIe native hotplug doesn't work when booted with "pci=nommconf".
> When using "pci=nommconf", obviously we can't access the extended PCI
> config space (offset 0x100-0xfff), so none of the extended
> capabilities are available.
> 
> In that case, we don't even ask the platform for control of PCIe
> hotplug via _OSC.  From the dmesg diff from normal (working) to
> "pci=nommconf" (not working):
> 
>   -Command line: BOOT_IMAGE=/boot/vmlinuz-smp ...
>   +Command line: BOOT_IMAGE=/boot/vmlinuz-smp pci=nommconf ...
>   ...
>   -acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
> Segments MSI HPX-Type3] -acpi PNP0A08:00: _OSC: platform does not
> support [AER LTR] -acpi PNP0A08:00: _OSC: OS now controls
> [PCIeHotplug PME PCIeCapability] +acpi PNP0A08:00: _OSC: OS supports
> [ASPM ClockPM Segments MSI HPX-Type3] +acpi PNP0A08:00: _OSC: not
> requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> +acpi PNP0A08:00: MMCONFIG is disabled, can't access extended PCI
> configuration space under this bridge.
> 

So, it shouldn't work from years but it has been broken recently, that
is the only objection I have. Could you tell why it was working?
According to your words- it shouldn't. We are using VMD driver, is that
matter?

I already saw Jonathan's finding, we can check this. But if nommconf
stays against hotplug, is it valuable? Maybe we should accept the
regression as desired.

> Why are you using "pci=nommconf"?  As far as I know, there's no reason
> to use that except to work around some kind of defect.

It was added long time ago when it was useful, and sometimes is
returning. We need to get rid of it definitely.

Thanks,
Mariusz

