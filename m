Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363A34B066E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 07:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiBJGkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 01:40:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiBJGkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 01:40:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19FA10A6;
        Wed,  9 Feb 2022 22:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644475203; x=1676011203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfJE1FFBu6sgemhtirYEevD0xuq7pkhl4dDQwqgLxNY=;
  b=VQ7cHeQwrjW1aSUrAzEG6IKiV5b1RIdsbZgi8j6KqYSxwUJGct51Pz8g
   md/mdEUhKNsOowkAHCxRJgXPE4EL1TgTApRNIOP63GORGCsF00TxrnqxX
   UvYPdrGqH0YvbG2zSAD/SwumTnrNZTFKbKWYr2NFU6PtH33O5PEl+jAPU
   Zg6ryScn3TwmXvKmsmTQ2WDyAW25+w4kX7UI7dPQpDQRKilW8OWHdJa8m
   5ziD+bVJ7a1HGXgLj0kEu/abH4E21aSwJm1EBf6j0SEF037GxURVKtKVV
   v5Z9TUiWlKylA69L695g7wqBdbhq5cDPq1msDwf8qThKaK/v7LNl9j50e
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="247006511"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="247006511"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 22:40:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="526354353"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 22:39:55 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 10 Feb 2022 08:39:48 +0200
Date:   Thu, 10 Feb 2022 08:39:48 +0200
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
Message-ID: <YgSzNAlfgcrm8ykH@lahna>
References: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
 <697aaf96-ec60-4e11-b011-0e4151e714d7@redhat.com>
 <YgKcl9YX4HfjqZxS@lahna>
 <02994528-aaad-5259-1774-19aeacdd18fc@redhat.com>
 <YgPlQ6UK3+4/yzLk@lahna>
 <2f01e99d-e830-d03c-3a9d-30b95726cc2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f01e99d-e830-d03c-3a9d-30b95726cc2c@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hans,

On Wed, Feb 09, 2022 at 05:08:13PM +0100, Hans de Goede wrote:
> As mentioned in my email from 10 seconds ago I think a better simpler
> fix would be to just do:
> 
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 9b9fb7882c20..18656f823764 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c
> @@ -28,6 +28,10 @@ static void remove_e820_regions(struct resource *avail)
>  	int i;
>  	struct e820_entry *entry;
>  
> +	/* Only remove E820 reservations on classic BIOS boot */
> +	if (efi_enabled(EFI_MEMMAP))
> +		return;
> +
>  	for (i = 0; i < e820_table->nr_entries; i++) {
>  		entry = &e820_table->entries[i];
>  
> 
> I'm curious what you think of that?

I'm not an expert in this e820 stuff but this one looks really simple
and makes sense to me. So definitely should go with it assuming there
are no objections from the x86 maintainers.
