Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6D149DAA0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiA0G3X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 01:29:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:58431 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbiA0G3W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 01:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643264962; x=1674800962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JkOo36tz8YaoDuZXPsp9O8nW6ib1sRzLUQMQhkkfdUQ=;
  b=BTN03RbvFhT+b7H0V0o1ZxLRME0MvTjWJp0P7lgHx3ynzei1VDxw6r4I
   TKEz7Fttah+ee/HGoJoTdZ8gCwtl0r0EwMaK+txeqd1RpYivhI4HVodiL
   feZ0Iefw2k1I+16DvUngRSrzPjcUM2ovZJkqphaMc9++LTlI1fOIrxgs6
   BjqYJVDvEoUC1fMSm57LTzPM/DSUeO94PXZKYZyBjJhNMFYjvExKMizJC
   FyVU69Pnyp5UT5GTulNBFspWygFY65vu88TsxLbqNf1PhsvWVuPRYsq6B
   h+CUH1DDz/96Q1EHzOw2CxFKJ91Zu/MO2m0rdtjAhqIS2W0YaLpUHInxH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310076972"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="310076972"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:29:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="618225100"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:29:18 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 27 Jan 2022 08:29:15 +0200
Date:   Thu, 27 Jan 2022 08:29:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/AER: Disable AER when link is in L2/L3 ready, L2
 and L3 state
Message-ID: <YfI7u5XSlNlx2w4I@lahna>
References: <20220126071853.1940111-1-kai.heng.feng@canonical.com>
 <YfEqZMUS9jyiErmF@lahna>
 <CAAd53p7H3RApEHOzJYorD9VBnaPqYRkzE2g+8hAUXRToc=jbGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7H3RApEHOzJYorD9VBnaPqYRkzE2g+8hAUXRToc=jbGg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jan 27, 2022 at 10:21:35AM +0800, Kai-Heng Feng wrote:
> On Wed, Jan 26, 2022 at 7:03 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Wed, Jan 26, 2022 at 03:18:51PM +0800, Kai-Heng Feng wrote:
> > > Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
> > > hint") enables ACS, and some platforms lose its NVMe after resume from
> > > S3:
> > > [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> > > [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> > > [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> > > [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> > > [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> > > [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> > > [   50.947843] nvme nvme0: frozen state error detected, reset controller
> > >
> > > It happens right after ACS gets enabled during resume.
> >
> > Is this really because of the above commit of due the fact that AER
> > "service" never implemented the PM hooks in the first place ;-)
> 
> >From what I can understand, all services other than PME should be
> disabled during suspend.
> 
> For example, should we convert commit a697f072f5da8 ("PCI: Disable PTM
> during suspend to save power") to PM hooks in PTM service?

Yes, I think that's the right thing to do. I wonder how it was not using
the PM hooks in the first place.
