Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FAF25F58B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 10:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgIGIny (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 04:43:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:24709 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbgIGInx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 04:43:53 -0400
IronPort-SDR: lTEYkIKZBjKEoVeFtMFelD9XK3/EWGJUgNrLxH903l+hi+h8aYg+Gk2TuqDIMJVtAbidqVLaid
 RuvFB9D8Dn9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="242789756"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="242789756"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 01:43:52 -0700
IronPort-SDR: OZ4NI3funrdLD5Nm8UUcbwwVuX37opK1MYw6pXMy5H0l4SoKOu++904l4qnNZ65aFbiQAEB0VQ
 z8EFOVdIaBEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406774494"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 Sep 2020 01:43:49 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 07 Sep 2020 11:43:49 +0300
Date:   Mon, 7 Sep 2020 11:43:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add a quirk to skip 1000 ms default link activation
 delay on some devices
Message-ID: <20200907084349.GZ2495@lahna.fi.intel.com>
References: <20200831093147.36775-1-mika.westerberg@linux.intel.com>
 <20200903181122.GA313490@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903181122.GA313490@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Sep 03, 2020 at 01:11:22PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 31, 2020 at 12:31:47PM +0300, Mika Westerberg wrote:
> > Kai-Heng Feng reported that it takes a long time (> 1 s) to resume
> > Thunderbolt-connected devices from both runtime suspend and system sleep
> > (s2idle).
> > 
> > This was because some Downstream Ports that support > 5 GT/s do not also
> > support Data Link Layer Link Active reporting.  Per PCIe r5.0 sec 6.6.1:
> > 
> >   With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
> >   software must wait a minimum of 100 ms after Link training completes
> >   before sending a Configuration Request to the device immediately below
> >   that Port. Software can determine when Link training completes by
> >   polling the Data Link Layer Link Active bit or by setting up an
> >   associated interrupt (see Section 6.7.3.3).
> > 
> > Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting,
> > but at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and
> > Intel JHL7540 Thunderbolt 3 Bridge [8086:15e7, 8086:15ea, 8086:15ef] do
> > not.
> 
> Is there any erratum about this?  I'm just hoping to avoid the
> maintenance hassle of adding new devices to the quirk.  If Intel
> acknowledges this as a defect and has a plan to fix it, that would
> help a lot.  If they *don't* think it's a defect, then maybe they have
> a hint about how we should handle this generically.

I don't think there is any public documentation about these chips so
probably no errata either. I did ask our TBT HW folks about this but so
far did not get any answer.
