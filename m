Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADFB277844
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgIXSJI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 14:09:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:47009 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgIXSJH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 14:09:07 -0400
IronPort-SDR: GEpELOF18HVsme9RnRgRLLRi4KKz6Ym6vVTDNH6/IK8+wf2UBVogtOJYqxtuMyDnrFgIyQ1gl+
 fZ0GyhWSFi+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="162202366"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="162202366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 11:09:07 -0700
IronPort-SDR: fTN88eBS4ZGG0H6UJwXoUequL6Ju3JPJg39ZHVmhom6pOBekTTlWPf9fPUWHkwAuWhbvL0v4Lo
 o1rPhHwRFtBg==
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="487025646"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 11:09:06 -0700
Date:   Thu, 24 Sep 2020 11:09:05 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Rajat Jain <rajatja@google.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        "Jechlitschek, Christoph" <christoph.jechlitschek@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200924180905.GB85236@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kai

+ Alex, since he had some of the early quirks authored.

On Thu, Sep 24, 2020 at 12:31:53AM +0800, Kai-Heng Feng wrote:
> [+Cc Christoph]
> 
> > On Sep 24, 2020, at 00:03, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > [+cc IOMMU and NVMe folks]
> > 
> > Sorry, I forgot to forward this to linux-pci when it was first
> > reported.
> > 
> > Apparently this happens with v5.9-rc3, and may be related to
> > 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> > which appeared in v5.8-rc3.
> > 
> > There are several dmesg logs and proposed patches in the bugzilla, but
> > no analysis yet of what the problem is.  From the first dmesg
> > attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):
> 
> AFAIK Intel is working on it internally.
> Comet Lake probably needs ACS quirk like older generation chips.

I have confirmed with Internal documentation that the problem exists on
Comet Lake. But its fixed ICL and TGL generations.

Unfortunately I do not see if the public specupdate documents are for these
generation chipsets to makes sure all root port id's can be captured.

There is also another entry in bugzilla that was forwarded that referred to
Request Redirect Capability to be always disabled as well. This same
workaround also seems to be turning off RR for the root port. I believe it
should fix it as well. But i saw another patch attached.

Can you tell how you reproduce this? just doing a

#echo mem > /sys/power/state

is sufficient with an attached NVMe drive? 

> 
> > 
> >  [   50.434945] PM: suspend entry (deep)
> >  [   50.802086] nvme 0000:01:00.0: saving config space at offset 0x0 (reading 0x11e0f)
> >  [   50.842775] ACPI: Preparing to enter system sleep state S3
> >  [   50.858922] ACPI: Waking up from system sleep state S3
> >  [   50.883622] nvme 0000:01:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> >  [   50.947352] nvme 0000:01:00.0: restoring config space at offset 0x0 (was 0xffffffff, writing 0x11e0f)
> >  [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> >  [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> >  [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> >  [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> >  [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> >  [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> >  [   50.947843] nvme nvme0: frozen state error detected, reset controller
> > 
> > I suspect the nvme "can't change power state" and restore config space
> > errors are a consequence of the DPC event.  If DPC disables the link,
> > the device is inaccessible.
> > 
> > I don't know what caused the ACS Violation.  The AER TLP Header Log
> > might have a clue, but unfortunately we didn't print it.
> > 

Apparently it also requires to disable RR, and I'm not able to confirm if
CML requires that as well. 

pci_quirk_disable_intel_spt_pch_acs_redir() also seems to consult the same
table, so i'm not sure why we need the other patch in bugzilla is required.


Cheers,
Ashok
