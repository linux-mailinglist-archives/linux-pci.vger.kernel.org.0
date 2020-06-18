Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8447B1FF95E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgFRQjA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 12:39:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2343 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726928AbgFRQjA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 12:39:00 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CFD97E967C456F2CA348;
        Thu, 18 Jun 2020 17:38:58 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 18 Jun
 2020 17:38:58 +0100
Date:   Thu, 18 Jun 2020 17:38:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <sean.v.kelley@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] PCI/AER: Add partial initial support for RCiEPs
 using RCEC or firmware first
Message-ID: <20200618173857.00002ae5@huawei.com>
In-Reply-To: <20200618162004.GA2102664@bjorn-Precision-5520>
References: <20200618094829.00007d46@Huawei.com>
        <20200618162004.GA2102664@bjorn-Precision-5520>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 18 Jun 2020 11:20:04 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Jun 18, 2020 at 09:48:29AM +0100, Jonathan Cameron wrote:
> > On Wed, 17 Jun 2020 11:25:55 -0700
> > "Kuppuswamy, Sathyanarayanan"
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:  
> > > On 6/17/20 10:36 AM, Sean V Kelley wrote:  
> > > > On Tue, 2020-06-16 at 14:24 -0500, Bjorn Helgaas wrote:    
> > > >> On Fri, May 22, 2020 at 01:31:34AM +0800, Jonathan Cameron
> > > >> wrote:    
> 
> > > IIUC, we are trying to solve multiple issues here.
> > > 
> > > 1. Error detection and recovery support for RCiEPs and RCEC.
> > > 2. Firmware first exception for case 1.
> > > 3. AEPI based handling for case 1 (I think this is the case
> > > Jonathan is trying to handle)  
> > 
> > I'm not sure it separates that cleanly but the flow I'm interested
> > in is firmware first with errors reported using APEI / GHESv2 etc.
> > 
> > In particular without an RCEC, as it should (I think) play no part
> > in that path.  One of the main aims of me bringing this forwards at
> > this stage is to establish whether I need to get our hardware teams
> > to put an RCEC in place for future hardware or not.  Right now we
> > have some work arounds in place as we can reroute some of these
> > errors directly to device interrupts.
> > 
> > We haven't been able to come up with a reason why we need an RCEC
> > given our approach to error handling.  
> 
> If you only want to use ACPI APEI and you never need native AER
> support, you may not need an RCEC.  But note that an RCEC *is*
> required if you want PME messages or Function Readiness Status (FRS)
> for RCiEPs.

Understood.

> 
> > > >>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > >>> index 14bb8f54723e..d34be4483f73 100644
> > > >>> --- a/drivers/pci/pcie/err.c
> > > >>> +++ b/drivers/pci/pcie/err.c
> > > >>> @@ -153,6 +153,67 @@ pci_ers_result_t pcie_do_recovery(struct
> > > >>> pci_dev *dev,
> > > >>>   	pci_ers_result_t status =
> > > >>> PCI_ERS_RESULT_CAN_RECOVER; struct pci_bus *bus;    
> > > I am curious what bus (dev->subordinate) does RCEC and RCiEP
> > > belongs to ?  
> > 
> > I'm not quite sure what you are asking so...
> > 
> > They are effectively the same as root ports, and so sit on a bus
> > specified via ACPI. In our case IORT. The root complex includes a
> > bunch of bus numbers on which these devices can be discovered.
> > 0, 74, 78, 7a, 7b, 7c, 80, b4, ba, bb, b8, bc on the 2 socket
> > machine I have to hand.  Those buses have a mix of root ports, and
> > RCiEPs on them.  
> 
> I don't know much about IORT, but it's not the way we discover these
> devices.
> 
> RCiEPs and RCECs should be discovered the same way as Root Ports: a
> PNP0A03 device in the ACPI namespace describes a PCI host bridge, and
> the _CRS method of that PNP0A03 device contains a bus number range.
> The base of that range is the root "bus" on which Root Ports, RCiEPs,
> RCECs, and possibly some Conventional PCI devices exist.
> 
> The machine Jonathan mentioned above should have 12 PNP0A03 devices,
> one for each of the root buses he listed.

You are of course correct. That particular bit of info is available in
both places, but enumeration comes the DSDT entries you mention.

> 
> > As to subordinate (i.e. where they bridge to) I don't think it
> > would have any meaning.   For reference I checked one of our RCiEPs
> > and it's set to 0 on the config space.  
> 
> RCiEPs and RCECs are type 0 devices, so they're not bridges.  They
> have no secondary bus.

Thanks
