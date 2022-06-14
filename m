Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501DF54B0DC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356831AbiFNMbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 08:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiFNM2p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 08:28:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AEB22B02;
        Tue, 14 Jun 2022 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655209725; x=1686745725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G/BX8Uxdz+yrMTFWd+nOOlTWRC0rRAkVHt5072WNsL8=;
  b=WytpUNbvjE1IvZE7C8TDPCkkamy+L5n0cTedZ4BxzHgXUpFxbeEr7y+X
   80Y4EK0gbV1pOJq8o7H4Bpq7EOGTNCwe4x3jBx8qp6KUgAUusg+VJGzKV
   SvQ/rISa9oq1vWsOlhaokZ6xJ22ou2x7qdFtT2JW4x4aMDS7BnMb5J1XT
   q2uDt2Yio4wwacE+vuu6qAortVlXgIa2lqkm4gE5JZ3Nxelx46y3qNo9g
   Z5E0mLejcRhIZDEx+RA6VvIMqYy1WMP3x962aipCNWr7T4Dh9TvxF5OnK
   yF+gt6MP1m+MN+5SVMF4D4N4wPUyVeShMwM3p+fYVrzsARk3GbgY23zxH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279639124"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279639124"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:28:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="582677693"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:28:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1o15eu-000cKr-Bp;
        Tue, 14 Jun 2022 15:28:36 +0300
Date:   Tue, 14 Jun 2022 15:28:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
        linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820
 regions"
Message-ID: <Yqh+9Ei5BLhKB/da@smile.fi.intel.com>
References: <20220612144325.85366-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612144325.85366-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 12, 2022 at 04:43:25PM +0200, Hans de Goede wrote:
> Clipping the bridge windows directly from pci_acpi_root_prepare_resources()
> instead of clipping from arch_remove_reservations(), has a number of
> unforseen consequences.
> 
> If there is an e820 reservation in the middle of a bridge window, then
> the smallest of the 2 remaining parts of the window will be also clipped
> off. Where as the previous code would clip regions requested by devices,
> rather then the entire window, leaving regions which were either entirely
> above or below a reservation in the middle of the window alone.
> 
> E.g. on the Steam Deck this leads to this log message:
> 
> acpi PNP0A08:00: clipped [mem 0x80000000-0xf7ffffff window] to [mem 0xa0100000-0xf7ffffff window]
> 
> which then gets followed by these log messages:
> 
> pci 0000:00:01.2: can't claim BAR 14 [mem 0x80600000-0x806fffff]: no compatible bridge window
> pci 0000:00:01.3: can't claim BAR 14 [mem 0x80500000-0x805fffff]: no compatible bridge window
> 
> and many more of these. Ultimately this leads to the Steam Deck
> no longer booting properly, so revert the change.
> 
> Note this is not a clean revert, this revert keeps the later change
> to make the clipping dependent on a new pci_use_e820 bool, moving
> the checking of this bool to arch_remove_reservations().

It does _not_ fix the Intel MID case. It requires to have my patch applied as well.
So the difference as I see is the flags checking. I believe that you still need to
have it in case pci_use_e820 == true. But it might be that I missed an importan
detail.

-- 
With Best Regards,
Andy Shevchenko


