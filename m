Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7001CF599
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfJHJFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 05:05:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:13503 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbfJHJFq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 05:05:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 02:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206603137"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 02:05:41 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Oct 2019 12:05:40 +0300
Date:   Tue, 8 Oct 2019 12:05:40 +0300
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: Add missing link delays
Message-ID: <20191008090540.GY2819@lahna.fi.intel.com>
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
 <811277ae-bec1-1724-23ce-c13407bd79c5@gmx.de>
 <20191004130619.GI2819@lahna.fi.intel.com>
 <ed169065-1a2a-4729-b052-6ec8b1bf4835@gmx.de>
 <20191007093236.GP2819@lahna.fi.intel.com>
 <a5cfebd8-a9f8-ce68-21b7-f38514f9be87@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5cfebd8-a9f8-ce68-21b7-f38514f9be87@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 07, 2019 at 05:15:24PM +0200, Matthias Andree wrote:
> Am 07.10.19 um 11:32 schrieb Mika Westerberg:
> > On Sat, Oct 05, 2019 at 09:34:41AM +0200, Matthias Andree wrote:
> >> Am 04.10.19 um 15:06 schrieb Mika Westerberg:
> >>> On Fri, Oct 04, 2019 at 02:57:21PM +0200, Matthias Andree wrote:
> >>>> Am 04.10.19 um 14:39 schrieb Mika Westerberg:
> >>>>> @Matthias, @Paul and @Nicholas, I appreciate if you could check that this
> >>>>> does not cause any issues for your systems.
> >>>> Just to be sure: is this intended to be applied against the 5.4-rc*
> >>>> master branch?
> >>> Yes, it applies on top of v5.4-rc1.
> >> I am sorry to say that I cannot currently test - my computer has a
> >> GeForce 1060-6GB an no onboard/on-chip graphics.
> >> The nvidia module 435.21 does not compile against 5.4-rc* for me (5.3.1
> >> was fine).
> > I think the two patches should apply cleanly on 5.3.x as well.
> 
> Mika, that worked.
> 
> With your two patches on top of Linux 5.3.4, two Suspend-to-RAM cycles
> (ACPI S3), one Suspend-to-disk cycle (ACPI S4),
> no regressions observed => success?

Yes, if it did not hang during resume (because of the PME loop) I think
it should be declared as success :)

Thanks a lot for testing!
