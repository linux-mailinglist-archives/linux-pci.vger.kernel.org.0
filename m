Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFEC54B2A8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 15:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiFNN6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 09:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343676AbiFNN6o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 09:58:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AFD2E696;
        Tue, 14 Jun 2022 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655215124; x=1686751124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=we4ojTybIP4ZBv9pT35w2MXKtjIBA6VKpIHuWVylsjA=;
  b=n3cwPn0RJpKGb3fXJn3vdr1jyNBwsNJbXbjVFwTwTDI+Pd6701aP75o+
   dFNFvwqdw+Xmut8CS/H6dQfDqI+EFDBUjBfHXHETWHjq8R7vNgcEBjSP+
   mT8I92O/nKT+OaB72OrdiHJuxqHLjDMbyrz2SnzEWeK8LQNkRrwIy9IS5
   SegpxldRxwNNY+UFtwtRXPyzy244J8OInOscjfEAIuBTWeOvKNmUzDbgQ
   5K8OutPcSrzEkUdgneAk2JcSUrCnxkkAQ4PG2KYHipXlh1ohx7IS+LfQZ
   B2WKh1Ch8eXnsCkMvr7St9KpKx40zJheZ+4KN35IIsxS2ETBon+xK2e73
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277407957"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="277407957"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 06:58:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="673907783"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 06:58:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o173z-000cQq-VG;
        Tue, 14 Jun 2022 16:58:35 +0300
Date:   Tue, 14 Jun 2022 16:58:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <YqiUC+zvSxxvb0jw@smile.fi.intel.com>
References: <20220612144325.85366-1-hdegoede@redhat.com>
 <Yqh+9Ei5BLhKB/da@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqh+9Ei5BLhKB/da@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 03:28:36PM +0300, Andy Shevchenko wrote:
> On Sun, Jun 12, 2022 at 04:43:25PM +0200, Hans de Goede wrote:
> > Clipping the bridge windows directly from pci_acpi_root_prepare_resources()
> > instead of clipping from arch_remove_reservations(), has a number of
> > unforseen consequences.
> > 
> > If there is an e820 reservation in the middle of a bridge window, then
> > the smallest of the 2 remaining parts of the window will be also clipped
> > off. Where as the previous code would clip regions requested by devices,
> > rather then the entire window, leaving regions which were either entirely
> > above or below a reservation in the middle of the window alone.
> > 
> > E.g. on the Steam Deck this leads to this log message:
> > 
> > acpi PNP0A08:00: clipped [mem 0x80000000-0xf7ffffff window] to [mem 0xa0100000-0xf7ffffff window]
> > 
> > which then gets followed by these log messages:
> > 
> > pci 0000:00:01.2: can't claim BAR 14 [mem 0x80600000-0x806fffff]: no compatible bridge window
> > pci 0000:00:01.3: can't claim BAR 14 [mem 0x80500000-0x805fffff]: no compatible bridge window
> > 
> > and many more of these. Ultimately this leads to the Steam Deck
> > no longer booting properly, so revert the change.
> > 
> > Note this is not a clean revert, this revert keeps the later change
> > to make the clipping dependent on a new pci_use_e820 bool, moving
> > the checking of this bool to arch_remove_reservations().
> 
> It does _not_ fix the Intel MID case. It requires to have my patch applied as well.
> So the difference as I see is the flags checking. I believe that you still need to
> have it in case pci_use_e820 == true. But it might be that I missed an importan
> detail.

Yeah, I missed that I have compiled a tested something else, and not what I was
focused on.

That said, I double checked with your patch and nothing else and v5.19-rc2
based tree works nicely.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


