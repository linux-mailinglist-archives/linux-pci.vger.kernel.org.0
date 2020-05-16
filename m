Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A697E1D5F7C
	for <lists+linux-pci@lfdr.de>; Sat, 16 May 2020 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgEPHzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 May 2020 03:55:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:5124 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgEPHzO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 16 May 2020 03:55:14 -0400
IronPort-SDR: W7y8L+6TWDDtJ0JXCxMRIptL68xTNc6iTNRa/klldE8Ntl9ffPCowleCAyDLobLimXsg7hNvuD
 VhtpoChwX47Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 00:55:13 -0700
IronPort-SDR: r8t2k0YQtuum+uqVt30HSEpEPK/dj7nqY9w1RezkN2c25ACfhR212nsQhW96qAdQwTpj/rbIBW
 qrONSJc9DggA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="372908472"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 16 May 2020 00:55:10 -0700
Received: by lahna (sSMTP sendmail emulation); Sat, 16 May 2020 10:55:10 +0300
Date:   Sat, 16 May 2020 10:55:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Do not use pcie_get_speed_cap() to determine
 when to start waiting
Message-ID: <20200516075510.GR2571@lahna.fi.intel.com>
References: <20200515095535.GH2571@lahna.fi.intel.com>
 <20200515205321.GA538705@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515205321.GA538705@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 03:53:21PM -0500, Bjorn Helgaas wrote:
> On Fri, May 15, 2020 at 12:55:35PM +0300, Mika Westerberg wrote:
> > On Thu, May 14, 2020 at 05:41:32PM -0500, Bjorn Helgaas wrote:
> > > On Thu, May 14, 2020 at 04:30:43PM +0300, Mika Westerberg wrote:
> > > > Kai-Heng Feng reported that it takes long time (>1s) to resume
> > > > Thunderbolt connected PCIe devices from both runtime suspend and system
> > > > sleep (s2idle).
> > > > 
> > > > These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> > > > announces support for speeds > 5 GT/s but it is then capped by the
> > > > second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> > > > possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> > > > it ended up waiting for 1100 ms as these ports do not support active
> > > > link layer reporting either.
> > > 
> > > I don't think PCI_EXP_LNKCTL2 is relevant here.  I think the lack of
> > > Data Link Layer Link Active is just a chip erratum.  Is that
> > > documented anywhere?
> > 
> > I think it is relevant because if you hard-code (hardware) LNKCTL2 to
> > always target 2.5GT/s then it effectively does not need to implement
> > data link layer active because the link speed never goes higher than
> > that.
> 
> I don't think it's reasonable to expect software to check Link
> Capabilities 2, then try to write Link Control 2 and figure out
> whether the target speed is hard-wired.  I think these devices
> are just broken (at least per spec).

Software does not need to figure that out. It needs to check this field
if it needs to know the "actual" supported link speed.

Spec specifically allows this:

  The default value of this field is the highest Link speed supported by
  the component (as reported in the Max Link Speed field of the Link
  Capabilities Register) unless the corresponding platform/form factor
  requires a different default value.

and it even allows hardwiring this:

  Components that support only the 2.5 GT/s speed are permitted to
  hardwire this field to 0000b.
