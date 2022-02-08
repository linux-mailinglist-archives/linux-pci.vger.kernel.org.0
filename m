Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8674ADE73
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 17:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbiBHQjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 11:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiBHQjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 11:39:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4668DC061576;
        Tue,  8 Feb 2022 08:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644338342; x=1675874342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CaBZdofp3ykhk8RNvPuDfsy0ml+vizGXPsdsETYU1ho=;
  b=aZQB4DCAe9st6fb5vThwdWNzAXuc50hRBPWdSk0RFSyAqvNrhy0pNLhO
   AGQsgst7V1G/AeJSVw8kY6orlstfptdGs8auWzZMA9BVOVEFOGhqc+HEV
   WuiyOtjviTKKHDFbizbd4dz4l0dO/BWKSeyVKVLuggCCMZZ5ZH1LlZJaB
   IcBY2YLJi3rSmuqqGz3Rx9sMiW8LHdY5MEzk69/66rWlbG1WckuEw1w4z
   RGMTd4mNCjgGbUPjl/MxZ1PIHvJ74sQ10TEyXce8jJs7MSZboS3B/Dxn9
   6NWgeT55lgYA9iF6QXG6/gCe9KKCQQPOeGERbOfUREJMs7133O0IPE6DU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="273520855"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="273520855"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 08:38:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="771037216"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 08:38:49 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Feb 2022 18:38:47 +0200
Date:   Tue, 8 Feb 2022 18:38:47 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [5.17 regression] "x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems" breaks suspend/resume
Message-ID: <YgKcl9YX4HfjqZxS@lahna>
References: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
 <697aaf96-ec60-4e11-b011-0e4151e714d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697aaf96-ec60-4e11-b011-0e4151e714d7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hans,

On Tue, Feb 08, 2022 at 04:59:13PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/8/22 16:25, Hans de Goede wrote:
> > Hi All,
> > 
> > Unfortunately I've just learned that commit 7f7b4236f204 ("x86/PCI:
> > Ignore E820 reservations for bridge windows on newer systems"):
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f7b4236f2040d19df1ddaf30047128b41e78de7
> > 
> > breaks suspend/resume on at least one laptop model, the Lenovo ThinkPad
> > X1 gen 2, see:
> > https://bugzilla.redhat.com/show_bug.cgi?id=2029207

:-(

> > This regression was actually caught be Fedora already carrying this
> > patch for a while now and as such it has been reproduced with 5.15
> > with an older version of the patch which still allowed turning the
> > new behavior of by adding "pci=use_e820". Dmesg output with and
> > without the option has just been attached to the bug, I've not
> > analyzed this any further yet.
> > 
> > I guess that for now this means that we need to revert commit
> > 7f7b4236f204. Rafael, I'll send you a revert with a commit msg
> > explaining why this needs to be reverted tomorrow.
> > 
> > More interesting IMHO is finding out another solution. Both the touchpad
> > problem which got me looking into this:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> > 
> > As well as the thunderbolt hotplug issue Mika was looking at:
> > https://bugzilla.kernel.org/show_bug.cgi?id=206459
> > 
> > both are cases where we fail to find a memory-window for a
> > BAR which has not been setup yet.
> > 
> > So I see a couple of options here:
> > 
> > 1. Detect that the e820 reservations fully cover (one of)
> > the PCI bridge main 32 bit memory windows and if that happens
> > ignore them. This actually was my first plan when I started
> > working on this. In the end I choose the other option
> > because Bjorn indicated that in hindsight honoring the e820
> > reservations might have been a mistake and maybe we should
> > get rid of honoring them all together.
> > 
> > 2. Have a flag which, when we fail to alloc a 32 bit
> > (or 64 bit) memory PCI BAR, is set if not already set
> > and then retry the alloc. And make the e820 reservation
> > carve-out get skipped in this case.
> > 
> > 3. When booting with pci=nocrs as a workaround for
> > the touchpad case a 64 but memory window ends up getting
> > used. There already is some special handling for some
> > AMD bridges where if there are no 64 bit memory Windows
> > in the _CRS for the bridge, one gets added. Maybe we need
> > to do the same for Intel bridges ?
> 
> 4. It seems that all devices which have issues with allocating
> a PCI bar are Ice Lake based; and the model where the ignoring
> of e820 reservations has been reported to cause issues is somewhat
> old. It is a Haswell, but still getting BIOS updates causing
> the BIOS date check to enable the new behavior. So another
> solution might be to only ignore e820 reservations on machines
> with Intel Ice Lake (and presumably also Tiger Lake) CPUs.
> 
> 
> 5. It also seems that the troublesome e820 entry on all devices
> ends at 0xcfffffff and starts well below 0x8000000 :
> 
> Yoga C940:
> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> 
> IdeaPad 3 15IIL05:
> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> 
> Lenovo IdeaPad 5 14IIL05:
> [    0.000000] BIOS-e820: [mem 0x000000005bc50000-0x00000000cfffffff] reserved

I don't remember the details anymore but looking at the commit log of my
"fix" attempt here:

https://bugzilla.kernel.org/attachment.cgi?id=287661

The EFI memory map actually seems to consists of several entries that somehow
are merged by something (I think this is the EFI stub but not sure). Booting
with "efi=debug" may help us to understand this further (or not).

On that Yoga system, this:

  [Reserved           |   |  |  |  |  |  |  | |   |WB|WT|WC|UC] range=[0x000000002bc50000-0x000000003fffffff] (323MB)
  [Reserved           |   |  |  |  |  |  |  | |   |WB|  |  |UC] range=[0x0000000040000000-0x0000000040ffffff] (16MB)
  [Reserved           |   |  |  |  |  |  |  | |   |  |  |  |  ] range=[0x0000000041000000-0x00000000453fffff] (68MB)
  [Memory Mapped I/O  |RUN|  |  |  |  |  |  | |   |  |  |  |UC] range=[0x0000000045400000-0x00000000cfffffff] (2220MB)

became this:

  BIOS-e820: [mem 0x000000002bc50000-0x00000000cfffffff] reserved

Since the area (0x45400000-0xcfffffff) is marked as MMIO I think maybe we can
simply skip those areas in arch_remove_reservations() or so?

I may be missing a lots of details, though. ;-)
