Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF9422CFE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhJEPy3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 11:54:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:9577 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhJEPy2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 11:54:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="225675202"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="225675202"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 08:52:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="523818699"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 08:52:13 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mXmji-008vFZ-Ie;
        Tue, 05 Oct 2021 18:52:10 +0300
Date:   Tue, 5 Oct 2021 18:52:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] watchdog: wdt_pci: Correct the PCI ID vendor name
Message-ID: <YVx0qrshK4wEqT4S@smile.fi.intel.com>
References: <20211005151445.89620-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VdR7Dn+621YewmePRXxb6wbxTGZK8GHcUVDiDbQxho+Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdR7Dn+621YewmePRXxb6wbxTGZK8GHcUVDiDbQxho+Rw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 05, 2021 at 06:17:03PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 5, 2021 at 6:15 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The proper name of Acces I/O is with a single 's'. Correct it respectively.
> >
> > While at it, convert to use PCI_DEVICE() macro, drop unneeded initializer
> > and comma.
> 
> Scratch it. 8250_exar is using the wrong vendor ID as well.

After all I think we may go with wrong one for the lesser churn.

-- 
With Best Regards,
Andy Shevchenko


