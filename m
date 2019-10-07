Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504AECDE3E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 11:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfJGJcm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 05:32:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:32438 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGJcm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Oct 2019 05:32:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 02:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,267,1566889200"; 
   d="scan'208";a="206374733"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 07 Oct 2019 02:32:37 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 07 Oct 2019 12:32:36 +0300
Date:   Mon, 7 Oct 2019 12:32:36 +0300
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
Message-ID: <20191007093236.GP2819@lahna.fi.intel.com>
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
 <811277ae-bec1-1724-23ce-c13407bd79c5@gmx.de>
 <20191004130619.GI2819@lahna.fi.intel.com>
 <ed169065-1a2a-4729-b052-6ec8b1bf4835@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed169065-1a2a-4729-b052-6ec8b1bf4835@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 05, 2019 at 09:34:41AM +0200, Matthias Andree wrote:
> Am 04.10.19 um 15:06 schrieb Mika Westerberg:
> > On Fri, Oct 04, 2019 at 02:57:21PM +0200, Matthias Andree wrote:
> >> Am 04.10.19 um 14:39 schrieb Mika Westerberg:
> >>> @Matthias, @Paul and @Nicholas, I appreciate if you could check that this
> >>> does not cause any issues for your systems.
> >> Just to be sure: is this intended to be applied against the 5.4-rc*
> >> master branch?
> > Yes, it applies on top of v5.4-rc1.
> 
> I am sorry to say that I cannot currently test - my computer has a
> GeForce 1060-6GB an no onboard/on-chip graphics.
> The nvidia module 435.21 does not compile against 5.4-rc* for me (5.3.1
> was fine).

I think the two patches should apply cleanly on 5.3.x as well.

> For some reasons I don't understand, it first complains about missing or
> empty  Module.symvers, (which I do have and which has 12967 lines)
> and if I bypass that check, it complains about undeclared DRIVER_PRIME
> "here (outside a function)" - sorry for the German locale:

Possibly v5.4-rcX moved/renamed some symbol(s) which than makes the
out-of-tree driver fail to build.
