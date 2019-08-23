Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602FA9A847
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 09:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbfHWHKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 03:10:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:6425 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbfHWHKn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Aug 2019 03:10:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 00:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="196419917"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Aug 2019 00:10:38 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 23 Aug 2019 10:10:37 +0300
Date:   Fri, 23 Aug 2019 10:10:37 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Matthias Andree <matthias.andree@gmx.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add missing link delays required by the PCIe spec
Message-ID: <20190823071037.GP19908@lahna.fi.intel.com>
References: <20190821124519.71594-1-mika.westerberg@linux.intel.com>
 <9f741e3a-0878-b914-39d8-a64a02484cb5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f741e3a-0878-b914-39d8-a64a02484cb5@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 08:29:09PM +0200, Matthias Andree wrote:
> Am 21.08.19 um 14:45 schrieb Mika Westerberg:
> > Hi all,
> >
> > As the changelog says this is reworked version that tries to avoid reported
> > issues while at the same time fix the missing delays so we can get ICL
> > systems and at least the one system with Titan Ridge controller working
> > properly.
> >
> > @Matthias, @Paul and @Nicholas: it would be great if you could try the
> > patch on top of v5.4-rc5+ and verify that it does not cause any issues on
> > your systems.
> >
> >  drivers/pci/pci-driver.c |  19 ++++++
> >  drivers/pci/pci.c        | 127 ++++++++++++++++++++++++++++++++++++---
> >  drivers/pci/pci.h        |   1 +
> >  3 files changed, 137 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index a8124e47bf6e..9aec78ed8907 100644
> 
> ...
> 
> Mika, Bjorn, Rafael,
> 
> quick smoke test, this test applied with git-am on top
> v5.3-rc5-149-gbb7ba8069de9, reboot, suspend, wake, suspend, wake,
> hibernate, wake, looks good to me. The top of git log --pretty-short is
> shown below.

Thanks for testing!

> Couldn't test on v5.4-rc5 though as I've handed off my time machine for
> repairs,
> I seem to recall they said something about the flux compensator.

:)
