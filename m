Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811CA4B9B68
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiBQIsL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 03:48:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbiBQIsK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 03:48:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC40A2A0D7C;
        Thu, 17 Feb 2022 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645087673; x=1676623673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PDYw5rQvsj5va8j31Q9ml+BYtwBg3y8USkcS+rlhy/s=;
  b=GVMw/odFrmF2FLqRqpaG8SfrK5NCs6M0LV4S77Y/z+ptKetohILkjnKT
   inEZ8ky0YowVgLSyDRFpZaCT9QXZBMPGDNA8MNYTeqLXP/eLpbA9FyGBg
   3UVA2nA7Fq+s+9DS9JYXPxkZPQhCiZfJpZH3ZzAFjCRsfW2Fj9QpgYYIw
   HleKzWnZV/v0GLAQOg52Y04+hXpAIXvjFzQsfXvHVo9B8MtkdaigDxUe2
   Pw+7iNpVnOdMHxIUTPecrOMetUbLMvMXZXc8XkDZ0A9KSbeem8JYr+vyD
   8QI2uPeZz3+DXx+ymHVwR7ksKWvCUmSZCF/tXjgk/KjP4PI3XWKPpi7v8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="248424765"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="248424765"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:47:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="634446125"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:47:48 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 17 Feb 2022 10:47:46 +0200
Date:   Thu, 17 Feb 2022 10:47:46 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/PCI: Disable exclusion of E820 reserved
 addresses in some cases
Message-ID: <Yg4LsrPRkLfRz7eB@lahna>
References: <20220216150121.9400-1-hdegoede@redhat.com>
 <20220216150121.9400-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216150121.9400-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 16, 2022 at 04:01:21PM +0100, Hans de Goede wrote:
> Some fw has a bug where the PCI bridge window returned by the ACPI
> resources partly overlaps with some other address range, causing issues.
> To workaround this Linux excludes E820 reserved addresses when allocating
> addresses from the PCI bridge window. 2 known examples of such fw bugs are:
> 
> 1. The returned window contains addresses which map to system RAM,
> see commit 4dc2287c1805 ("x86: avoid E820 regions when allocating
> address space").
> 
> 2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
> reserved range and the ACPI provided PCI bridge window:
>  efi: mem46: [MMIO] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>  BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
>  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
> If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
> then the system fails to resume after a suspend.
> 
> Recently (2019) some systems have shown-up with EFI memmap MMIO entries
> covering the entire ACPI provided PCI bridge window. These memmap entries
> get converted into e820_table entries, causing all attempts to assign
> memory to PCI BARs which have not been setup by the BIOS to fail.
> For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
>  efi: mem63: [MMIO] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
>  BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>  pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>  pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
> 
> To fix this, check if the ACPI provided PCI bridge window is fully
> contained within in EFI memmap MMIO region and in that case disable
> the "exclude E820 reserved addresses" workaround, fixing the problem
> of not being able to find free space for unassigned BARs.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> BugLink: https://bugs.launchpad.net/bugs/1878279
> BugLink: https://bugs.launchpad.net/bugs/1931715
> BugLink: https://bugs.launchpad.net/bugs/1932069
> BugLink: https://bugs.launchpad.net/bugs/1921649
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
