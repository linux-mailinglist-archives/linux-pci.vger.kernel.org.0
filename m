Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF594AF5F5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 17:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiBIQDn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 11:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiBIQDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 11:03:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA62C0612BE;
        Wed,  9 Feb 2022 08:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644422625; x=1675958625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aafKnGCoEaqvsnU9LCDeEaZ8jYeHAC9CSnldTj89q44=;
  b=TTwcDJl80fT72VCLGnDEo8wnr2JH3WUpwCtWc0c0hLyxN1GndEZrDkIR
   6D7IvWELbhJrVR2BC5+15yzisOeTyxw4De4XCe9osfOgbNQ0/mXnRrIeI
   +RO9IyvAkym489zfhC+kkW2IF/F3ZHBUth72zg/h4PbniyTKATjmR+ODI
   1X39HaK1MXUdF40XX8yTRnPe/wNMeXAJa4Dri07vaFKIfLD4SYDuNXF61
   YIIdbrwaT2GU4FMNLU9WMsf1/os8UFpW0qbFFWJ6Ma+zfI79X3HSTO+FR
   xEh+/8Robkh+ry/YOt3+pX/88ykN4VSOb1xaq/jM2wftajztKCg1b1hQd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229205198"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="229205198"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:03:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="622317188"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:03:21 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 09 Feb 2022 18:01:07 +0200
Date:   Wed, 9 Feb 2022 18:01:07 +0200
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
Message-ID: <YgPlQ6UK3+4/yzLk@lahna>
References: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
 <697aaf96-ec60-4e11-b011-0e4151e714d7@redhat.com>
 <YgKcl9YX4HfjqZxS@lahna>
 <02994528-aaad-5259-1774-19aeacdd18fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02994528-aaad-5259-1774-19aeacdd18fc@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hans,

Thanks for looking into this!

On Wed, Feb 09, 2022 at 04:12:32PM +0100, Hans de Goede wrote:
> An alternative, much more elaborate fix would be to:
> 
> 1. Add E820_TYPE_MMIO and E820_TYPE_MMIO_PCI_BRIDGE_WINDOW types to
>    enum e820_type and modify the 2 places which check for type == reserved
>    to treat these both as reserved too, so as to not have any functional
>    changes there
> 
> 2. Modify the code building e820 tables from the EFI memmap to use
>    E820_TYPE_MMIO for MMIO EFI memmap entries and make e820_nomerge()
>    treat E820_TYPE_MMIO as non mergable to retain these as is
> 
> 3. Modify pci_acpi_root_prepare_resources() to compare ACPI provided
>    bridge mmio windows against E820_TYPE_MMIO e820_Table entries and
>    if there is an exact match (as is the case on the Yoga C940)
>    then change the e820 type to E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
> 
>    This means that we are now very narrowly treating EFI MMIO marked
>    regions special, in the special case where they are a 1:1 map
>    to an ACPI PCI bridge window resource.
> 
>    Note since we treat both E820_TYPE_MMIO and E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
>    identical to the old RESERVED everywhere there is no functional change
>    here.
> 
> 4. Modify arch/x86/kernel/resource.c: remove_e820_regions() to skip
>    e820 table entries with a type of E820_TYPE_MMIO_PCI_BRIDGE_WINDOW,
>    this would actually be a functional change and should fix the
>    issues we are trying to fix.
> 
> Note an alternative would be to skip having the extra E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
> type and to skip step 3. above. That would boil down to doing the same
> as your original patch in a somewhat cleaner manner.

I agree and my vote goes for this last alternative (e.g skipping step 3).
That would also make it slightly easier to follow the logic if someone
in the future needs to investigate possible issues around this, I think.
