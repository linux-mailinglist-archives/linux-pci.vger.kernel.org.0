Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA3E24814B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 11:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHRJDZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 18 Aug 2020 05:03:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgHRJDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 05:03:24 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id D4ECC6C33E78F3F0A705;
        Tue, 18 Aug 2020 10:03:22 +0100 (IST)
Received: from localhost (10.52.121.15) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 18 Aug
 2020 10:03:22 +0100
Date:   Tue, 18 Aug 2020 10:01:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Sean V Kelley <sean.v.kelley@intel.com>, <rjw@rjwysocki.net>,
        <bhelgaas@google.com>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 4/9] PCI/AER: Extend AER error handling to RCECs
Message-ID: <20200818100150.00007f29@Huawei.com>
In-Reply-To: <20200817222433.GA1453800@bjorn-Precision-5520>
References: <20200810103252.00000318@Huawei.com>
        <20200817222433.GA1453800@bjorn-Precision-5520>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.15]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 17 Aug 2020 17:24:33 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Aug 10, 2020 at 10:32:52AM +0100, Jonathan Cameron wrote:
> > On Fri, 7 Aug 2020 17:55:17 -0700
> > Sean V Kelley <sean.v.kelley@intel.com> wrote:  
> > > On 7 Aug 2020, at 15:53, Bjorn Helgaas wrote:  
> > > > On Tue, Aug 04, 2020 at 12:40:47PM -0700, Sean V Kelley wrote:    
> 
> > > >>  	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > > >> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> > > >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> > > >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END ||
> > > >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC))
> > > >>  		dev = dev->bus->self;  
> 
> I'm not sure I understand this "if" statement.  Previously (with no
> RCEC support), the possible ways I see to call pcie_do_recovery() are
> with:
> 
>   AER native:   Root Port
>   AER via APEI: Root Port or other PCIe device (ACPI v6.3, 18.3.2.5)
>   DPC:          Root Port or Switch Downstream Port
>   EDR:          Root Port or Switch Downstream Port
> 
> I *guess* the reason we have this "if" statement is for the AER/APEI
> case?  And the effect is that even if AER/APEI gives us an Endpoint,
> we back up and handle it as though we got it from the Downstream Port
> above it, i.e., we reset the Endpoint along with any other children of
> that Downstream Port?
> 
> Then, IIUC, your patches add this case:
> 
>   AER native:   Root Port or RCEC
>   AER via APEI: Root Port, RCEC, or other PCIe device
> 
> Just noodling here, but I wonder if this would be more understandable
> as something like:
> 
>   type = pci_pcie_type(dev);
>   if (type == PCI_EXP_TYPE_ROOT_PORT ||
>       type == PCI_EXP_TYPE_DOWNSTREAM ||
>       type == PCI_EXP_TYPE_RC_EC)
>     bridge = dev;
>   else if (type == PCI_EXP_TYPE_RC_END)
>     bridge = dev->rcec;
>   else
>     bridge = pci_upstream_bridge(dev);
> 
> and then we could do:
> 
>   if (type == PCI_EXP_TYPE_RC_END)
>     flr_on_rciep(dev);
>   else
>     reset_link(bridge);
> 
> It's still awkward to have to deal with being supplied either
> endpoints or bridges.  But I guess in the AER/APEI case, we aren't
> allowed to touch the error registers so maybe we can't avoid the
> awkwardness.

Agreed with your analysis with one exception. It isn't just that we
aren't allowed to touch the error registers, but also that they may
not even exist (i.e. there is no RCEC).

There are quite a lot of places where we have to then handle the
cases separately.  For an RC_END in the APEI case we don't
have to have an RCEC as we should never be touching it or
any of its registers.  We have platforms that do it this way
(obviously there is a hardware entity doing RCEC like stuff, but it is
not visible to the OS).

In these cases (bridge == NULL) and we can't call the bus_walk on it
to call the various desired resets on the RCiEP.  We could
do something like

pci_walk_affected(bridge, dev, report_frozen, &status);

and if bridge is NULL, perform the reset just on dev.

Would that be clearer?

Thanks,

Jonathan

> 
> > > >>  		status = reset_link(dev);    
> > > >
> > > > reset_link() might be misnamed.  IIUC "dev" is a bridge, and the point
> > > > is really to reset any devices below "dev."  Whether we do that by
> > > > resetting link, DPC trigger, secondary bus reset, FLR, etc, is sort of
> > > > immaterial.  Some of those methods might be applicable for RCiEPs.
> > > >
> > > > But you didn't add that name; I'm just trying to understand this
> > > > better.    
> > > 
> > > Yes, that’s a confusing term with the _link attached. It’s difficult 
> > > to relate to the different resets that might be applicable. I was 
> > > thinking about that when looking at the callback path via the 
> > > “reset_link” of the RCiEP to the RCEC for the sole purpose of 
> > > clearing the Root Port Error Status. It would be worth time to spend 
> > > looking at better descriptive naming/methods.  
> > 
> > Agreed, this caused me some some confusion as well so more descriptive
> > naming would be good.  
> 
> Maybe something like reset_subordinate_devices()?  Then it's clear
> that we pass a bridge and reset the devices *below* it.  It's not
> quite as obvious for RCECs, since they aren't bridges and the RCiEPs
> aren't actually *subordinates*, but maybe it's still suggestive of the
> logical relationship?
> 
> Bjorn


