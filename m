Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7504B520E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 14:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiBNNp3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 08:45:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiBNNp2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 08:45:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5EECF9;
        Mon, 14 Feb 2022 05:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644846321; x=1676382321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8o30VyhgldzE+eBXBY55NtguExG1hksgZZAny2N2dg=;
  b=l43OCFzBYnTncBEhdWFgZKjcpAcjQbbob53JBpyDxbDAJsXf7verQPCq
   OSCYV/ui8vCs4CaCrlCi9YH/JQadMerNIA77haUm6kUGc/qf1UIZumaJg
   ilRW+xU6m+qoA9kEycjTTuUhXA3Zc3B1Qu1uu/Z2F+sEYxWZSebOHyT8T
   HqRxod8iEXQAbfKcOCGgU+CcMe6r0fg/qiCvti2nhvm9AmyxpafXUvMbe
   kbmareiZvOE41dKCpAyjcrETKlUk+BEGxFvb1xDTQJK9Di+acSlxACQs/
   02nm8ayySS/zrAeEm7AgNtX171vLDXp65Nnlmd/laLN1L90fZCK9TS1P7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230054450"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="230054450"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:45:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="632150186"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:45:16 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 14 Feb 2022 15:42:56 +0200
Date:   Mon, 14 Feb 2022 15:42:56 +0200
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
Message-ID: <YgpcYHZ1fxnBiUjV@lahna>
References: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
 <697aaf96-ec60-4e11-b011-0e4151e714d7@redhat.com>
 <YgKcl9YX4HfjqZxS@lahna>
 <02994528-aaad-5259-1774-19aeacdd18fc@redhat.com>
 <YgPlQ6UK3+4/yzLk@lahna>
 <2f01e99d-e830-d03c-3a9d-30b95726cc2c@redhat.com>
 <YgSzNAlfgcrm8ykH@lahna>
 <039f9e8d-6e29-0288-606a-1d298e026c97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039f9e8d-6e29-0288-606a-1d298e026c97@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hans,

On Mon, Feb 14, 2022 at 01:42:29PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/10/22 07:39, Mika Westerberg wrote:
> > Hi Hans,
> > 
> > On Wed, Feb 09, 2022 at 05:08:13PM +0100, Hans de Goede wrote:
> >> As mentioned in my email from 10 seconds ago I think a better simpler
> >> fix would be to just do:
> >>
> >> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> >> index 9b9fb7882c20..18656f823764 100644
> >> --- a/arch/x86/kernel/resource.c
> >> +++ b/arch/x86/kernel/resource.c
> >> @@ -28,6 +28,10 @@ static void remove_e820_regions(struct resource *avail)
> >>  	int i;
> >>  	struct e820_entry *entry;
> >>  
> >> +	/* Only remove E820 reservations on classic BIOS boot */
> >> +	if (efi_enabled(EFI_MEMMAP))
> >> +		return;
> >> +
> >>  	for (i = 0; i < e820_table->nr_entries; i++) {
> >>  		entry = &e820_table->entries[i];
> >>  
> >>
> >> I'm curious what you think of that?
> > 
> > I'm not an expert in this e820 stuff but this one looks really simple
> > and makes sense to me. So definitely should go with it assuming there
> > are no objections from the x86 maintainers.
> 
> Unfortunately with this suspend/resume is still broken on the ThinkPad
> X1 carbon gen 2 of the reporter reporting the regression. The reporter
> has been kind enough to also test in EFI mode (at my request) and then
> the problem is back again with this patch. So just differentiating
> between EFI / non EFI mode is not an option.

Thanks for the update! Too bad that it did not solve the regression, though :(

> FYI, here is what I believe is the root-cause of the issue on the ThinkPad X1 carbon gen 2:
> 
> The E820 reservations table has the following in both BIOS and EFI boot modes:
> 
> [    0.000000] BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
> 
> Which has a small overlap with:
> 
> [    0.884684] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
> 
> This leads to the following difference in assignments of PCI resources when honoring E820 reservations
> 
> [    0.966573] pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff]
> [    0.966698] pci_bus 0000:02: resource 1 [mem 0xdfb00000-0xdfcfffff]
> 
> vs the following when ignoring E820 reservations:
> 
> [    0.966850] pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff]
> [    0.966973] pci_bus 0000:02: resource 1 [mem 0xdfa00000-0xdfbfffff]
> 
> And the overlap of 0xdfa00000-0xdfa0ffff from the e820 reservations seems to be what is causing the suspend/resume issue.

Any idea what is using that range?

> ###
> 
> As already somewhat discussed, I'll go and prepare this solution instead:
> 
> 1. Add E820_TYPE_MMIO to enum e820_type and modify the 2 places which check for
>    type == reserved to treat this as reserved too, so as to not have any
>    functional changes there
> 
> 2. Modify the code building e820 tables from the EFI memmap to use
>    E820_TYPE_MMIO for MMIO EFI memmap entries.
> 
> 3. Modify arch/x86/kernel/resource.c: remove_e820_regions() to skip
>    e820 table entries with a type of E820_TYPE_MMIO,
>    this would actually be a functional change and should fix the
>    issues we are trying to fix.

Given the above regression, I can't think of a better way to solve this.
