Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073321C88E3
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgEGLum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 07:50:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:59334 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgEGLuj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 07:50:39 -0400
IronPort-SDR: K8gq3h49VHpmZS0MqG+na4IjNG4n8aYqR44k2kPT7ga/PdFvCxmtm3VS4/lVxK7fQe9PcX4MJu
 I5+IApngKnPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 04:50:39 -0700
IronPort-SDR: 8bD02u6o+OKmozbXo9UsSMMfj9zmgxWFMnYTnkoWDvJi3GAkjFa/S1BKe4rDWplcn9g2Bgpyfn
 2caRx6V10iYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="370094733"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 May 2020 04:50:35 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 07 May 2020 14:50:34 +0300
Date:   Thu, 7 May 2020 14:50:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI/ASPM: Enable ASPM for bridge-to-bridge link
Message-ID: <20200507115034.GI487496@lahna.fi.intel.com>
References: <20200506061438.GR487496@lahna.fi.intel.com>
 <20200506212947.GA455758@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506212947.GA455758@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 04:29:47PM -0500, Bjorn Helgaas wrote:
> On Wed, May 06, 2020 at 09:14:38AM +0300, Mika Westerberg wrote:
> > On Wed, May 06, 2020 at 01:34:21AM +0800, Kai-Heng Feng wrote:
> > > The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
> > > state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
> > > power. On Windows ASPM L1 is enabled on the device and its upstream
> > > bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
> > > power.
> > > 
> > > In short, ASPM always gets disabled on bridge-to-bridge link.
> > 
> > Excelent finding :) I've heard several reports complaining that we can't
> > enter PC10 when TBT is enabled and I guess this explains it.
> 
> I'm curious about this.  I first read this patch as affecting
> garden-variety Links between a Root Port or Downstream Port and the
> Upstream Port of a switch.  But the case we're talking about is
> specifically when the downstream device is PCI_EXP_TYPE_PCI_BRIDGE,
> i.e., a PCIe to PCI/PCI-X bridge, not a switch.
> 
> AFAICT, a Link to a PCI bridge is still a normal Link and ASPM should
> still work.  I'm sort of surprised that you'd find such a PCIe to
> PCI/PCI-X bridge in a Thunderbolt topology, but maybe that's a common
> thing?

It actually is not common and now that you mention I'm wondering how
this can help at all. I also thought this applies to all ports which
would explain the issue we have but if it only applies to PCIe to
PCI/PCI-X bridge it should not make any difference in TBT systems.

> I guess "PC8" and "PC10" are some sort of Intel-specific power states?

Package C-state 8 and Package C-state 10. These are power states the
whole (Intel) CPU package can enter when individual CPU cores are in
correct low power states.
