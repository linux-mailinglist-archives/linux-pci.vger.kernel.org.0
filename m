Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B515207F2A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 00:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390213AbgFXWJf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 18:09:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:16343 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389122AbgFXWJf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 18:09:35 -0400
IronPort-SDR: 4T8PccjApL1cNbva2EUMF28Y4n1ovlQ507NipKF0AqQcStfwmZDvTHB5bjvvZPTjKOb0OWi8IP
 icwbj9dAjtzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="162743991"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="162743991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 15:09:33 -0700
IronPort-SDR: 2SVh1mImTky8qw5v7uYe5jrIaRPakYHkCi8Im1bR39HTfEeR3VgDSbz4g1c+CN5zo5qWIASHQL
 HnQ1YZlUUXvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="275836573"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 24 Jun 2020 15:09:33 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 8C58C5804D6;
        Wed, 24 Jun 2020 15:09:33 -0700 (PDT)
Message-ID: <e980bc2959b5a959bddfa63adb35aeae8261ab06.camel@linux.intel.com>
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, dan.j.williams@intel.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-acpi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Wed, 24 Jun 2020 15:09:33 -0700
In-Reply-To: <20200624213757.GA2591059@bjorn-Precision-5520>
References: <20200624213757.GA2591059@bjorn-Precision-5520>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-06-24 at 16:37 -0500, Bjorn Helgaas wrote:
> On Fri, Jun 12, 2020 at 01:48:19PM -0700, David E. Box wrote:
> > StorageD3Enable is a boolean property that indicates that the
> > platform
> > wants to use D3 for PCIe storage drives during suspend-to-idle. 
> 
> Is this something that should apply to plug-in drives, or does this
> only apply to soldered-in things?
> 
> > It is a
> > BIOS work around that is currently in use on shipping systems like
> > some
> > Intel Comet Lake platforms. 
> 
> What is this BIOS work around?  Is there a defect here that's being
> worked around?  What's the defect?

> 
> > It is meant to change default driver policy for
> > suspend that may cause higher power consumption.
> 
> I guess this means that by changing the driver policy from the
> default, we can save some power?

Yes. Maybe 'work around' was a poor choice of words. 'Getting around
default driver policy' is the issue. There is no hardware defect. One
of the uses of the suspend-to-idle flow is to support compliance with
increasingly tighter energy regulations. One of the ways to do this on
desktop systems is to power off the ATX power supply during s2idle and
use the 5V standby rail for self refresh and other low power needs. But
the platforms that support this can't shutdown the PS unless PCI ports
are placed in D3. On Linux this won't happen with NVMe drives because
the default driver policy is to use ASPM (NVMe APST) during s2idle.
Windows has a related concern. So to 'get around' the driver choosing a
policy that will result in higher power consumption, they implemented
this _DSD to inform the OS of its preference for D3 on the PCI port.

David

