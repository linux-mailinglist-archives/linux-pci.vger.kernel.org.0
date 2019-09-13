Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF84B26A0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 22:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfIMU1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 16:27:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:57316 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388300AbfIMU1L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 16:27:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 13:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="269533920"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2019 13:27:10 -0700
Date:   Fri, 13 Sep 2019 13:27:10 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Megha Dey <megha.dey@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [RFC V1 0/7] Add support for a new IMS interrupt mechanism
Message-ID: <20190913202710.GA999@otc-nc-03>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
 <VI1PR05MB4141EAE19EE47DA20A75AE21CFB30@VI1PR05MB4141.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR05MB4141EAE19EE47DA20A75AE21CFB30@VI1PR05MB4141.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 13, 2019 at 07:50:50PM +0000, Jason Gunthorpe wrote:
> On Thu, Sep 12, 2019 at 06:32:01PM -0700, Megha Dey wrote:
> 
> > This series is a basic patchset to get the ball rolling and receive some
> > inital comments. As per my discussion with Marc Zyngier and Thomas Gleixner
> > at the Linux Plumbers, I need to do the following:
> > 1. Since a device can support MSI-X and IMS simultaneously, ensure proper
> >    locking mechanism for the 'msi_list' in the device structure.
> > 2. Introduce dynamic allocation of IMS vectors perhaps by using a group ID
> > 3. IMS support of a device needs to be discoverable. A bit in the vendor
> >    specific capability in the PCI config is to be added rather than getting
> >    this information from each device driver.
> 
> Why #3? The point of this scheme is to delegate programming the
> addr/data pairs to the driver so it can be done in some
> device-specific way. There is no PCI standard behind this, and no
> change in PCI semantics. 
> 
> I think it would be a tall ask to get a config space bit from PCI-SIG
> for something that has little to do with PCI.

This isn't a standard config capability. Its Designated Vendor Specific
Capability (DVSEC). The device is responsible for managing the addr-data
pair. This provides a hint to the OS framework that this device has
device specific methods.

Agreed its not required, but some OSV's like a generic way to discover
these capabilities, hence its there so device vendors can have
a common guideline.

Check here for some of those details:

https://software.intel.com/en-us/blogs/2018/06/25/introducing-intel-scalable-io-virtualization 

> 
> After seeing that we already have a platform device based version of
> this same idea (drivers/base/platform-msi.c), I think the task here is
> really just to extend and expand that approach to work generically for
> platform and PCI devices. Along the way tidying the arch interface so
> x86 and ARM's stuff to support that uses the same generic interfaces.
> 
> ie it is re-organizing code and ideas already in Linux, not defining
> some new standard.
> 
> I also think refering to this existing idea by some new IMS name is
> only confusing people what the goal is... Which is perhaps why #3 was
> suggested??
> 
> Stated more clearly, I think all uses would be satisfied if
> platform_msi_domain_alloc_irqs() could be called for struct
> pci_device, could be called multiple times for the same struct
> pci_device, and co-existed with MSI and MSI-X on the same pci_device.
> 
> Jason
