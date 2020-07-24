Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9060B22CC32
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGXR3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 13:29:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:53039 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgGXR3h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 13:29:37 -0400
IronPort-SDR: Hu/tW/aoZ3CxDv8vNY4gkN5+dHaPOqjMQIAIPlOyRWaeCn9xJD2909cTxYiVMORLDwvBvXEBoP
 Rt0moM7cIOUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="212293900"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="212293900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:29:36 -0700
IronPort-SDR: deXYC6ycbU5NEDDJCdldKH/n6fNc7ijDCsGKYQ3EwXdv+YgwekW+taAHwFibPxG+6V+X1HAi5D
 PlHAz0aOR2AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="289054381"
Received: from seokjaeb-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley) ([10.254.24.239])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2020 10:29:36 -0700
Message-ID: <f75fd57d8c1611ab5b07bcdc0a5e758b25123ffb.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI/AER: Add support for reset of RCiEPs for
 APEI/Firmware first reporting only
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
Reply-To: sean.v.kelley@linux.intel.com
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, linux-acpi@vger.kernel.org,
        James Morse <james.morse@arm.com>
Date:   Fri, 24 Jul 2020 10:29:31 -0700
In-Reply-To: <20200708173213.00001852@Huawei.com>
References: <20200622114402.892798-1-Jonathan.Cameron@huawei.com>
         <02999929-39F5-4A11-AACA-84490F12E12B@linux.intel.com>
         <20200626194126.00007190@Huawei.com>
         <6CAFE871-36CC-44DD-B4E0-D0BB5ABF3947@linux.intel.com>
         <20200703092351.00004981@Huawei.com>
         <431b4d136e5e2ba158640c0ef6eb7dc09351a992.camel@linux.intel.com>
         <20200708163924.00007006@Huawei.com>
         <EC08D16A-5434-4021-A28B-D7121DDF98B7@linux.intel.com>
         <20200708173213.00001852@Huawei.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-07-08 at 17:32 +0100, Jonathan Cameron wrote:
> On Wed, 8 Jul 2020 09:01:13 -0700
> Sean V Kelley <sean.v.kelley@linux.intel.com> wrote:
> 
> > On 8 Jul 2020, at 8:39, Jonathan Cameron wrote:
> > 
> > > On Tue, 7 Jul 2020 09:56:26 -0700
> > > Sean V Kelley <sean.v.kelley@linux.intel.com> wrote:
> > >  
> > > > On 3 Jul 2020, at 1:23, Jonathan Cameron wrote:
> > > >  
> > > > > On Thu, 2 Jul 2020 11:06:26 -0700
> > > > > Sean V Kelley <sean.v.kelley@linux.intel.com> wrote:
> > > > >  
> > > > > > On 26 Jun 2020, at 11:41, Jonathan Cameron wrote:
> > > > > >  
> > > > > > > On Fri, 26 Jun 2020 09:29:34 -0700
> > > > > > > Sean V Kelley <sean.v.kelley@linux.intel.com> wrote:
> > > > > > >  
> > > > > > > > Hi,  
> > > > > > > Hi,
> > > > > > > 
> > > > > > > Thanks for taking a look.
> > > > > > >  
> > > > > > > > On 22 Jun 2020, at 4:44, Jonathan Cameron wrote:
> > > > > > > >  
> > > > > > > > > Was previously: PCI/AER: Add partial initial supprot
> > > > > > > > > for
> > > > > > > > > RCiEPs
> > > > > > > > > using
> > > > > > > > > RCEC or
> > > > > > > > > firmware first.
> > > > > > > > > 
> > > > > > > > > Currently the kernel does not handle AER errors for
> > > > > > > > > Root
> > > > > > > > > Complex
> > > > > > > > > integrated
> > > > > > > > > End Points (RCiEPs)[0].  These devices sit on a root
> > > > > > > > > bus
> > > > > > > > > within
> > > > > > > > > the
> > > > > > > > > Root Complex
> > > > > > > > > (RC).  AER handling is performed by a Root Complex
> > > > > > > > > Event
> > > > > > > > > Collector
> > > > > > > > > (RCEC) [1]
> > > > > > > > > which is a effectively a type of RCiEP on the same
> > > > > > > > > root bus.
> > > > > > > > > 
> > > > > > > > > This code will only perform the correct reset flow
> > > > > > > > > for the
> > > > > > > > > case
> > > > > > > > > where
> > > > > > > > > there
> > > > > > > > > is no need to take any actions on the RCEC because
> > > > > > > > > the
> > > > > > > > > firmware is
> > > > > > > > > responsible for them.   This is true where APEI [2]
> > > > > > > > > is used
> > > > > > > > > to
> > > > > > > > > report
> > > > > > > > > the AER
> > > > > > > > > errors via a GHES[v2] HEST entry [3] and relevant AER
> > > > > > > > > CPER
> > > > > > > > > record
> > > > > > > > > [4]
> > > > > > > > > and Firmware
> > > > > > > > > First handling is in use.  
> > > > > > > > 
> > > > > > > > Right, in the case of the RCEC one identifies the
> > > > > > > > RCiEPs by
> > > > > > > > the
> > > > > > > > RCiEP
> > > > > > > > bitmap as a part of the RCEC Associated Endpoint
> > > > > > > > Extended
> > > > > > > > Capabilities.
> > > > > > > > This ‘search’ so to speak would make use also of the
> > > > > > > > RCEC
> > > > > > > > Associated
> > > > > > > > Bus Numbers Register to associate the devices with an
> > > > > > > > RCEC when
> > > > > > > > not
> > > > > > > > on
> > > > > > > > the same bus.  
> > > > > > > 
> > > > > > > Ah. I'm afraid my access to recent specs is a bit limited
> > > > > > > at the
> > > > > > > moment.
> > > > > > > I do have a draft 5.0 spec which has that in though so I
> > > > > > > now see
> > > > > > > what
> > > > > > > you mean.
> > > > > > > 
> > > > > > > Was introduced in Root Complex Event Collector Endpoint
> > > > > > > Association
> > > > > > > Extended
> > > > > > > Capability version 2 in PCIe 5.0 I think.
> > > > > > >  
> > > > > > 
> > > > > > Correct.
> > > > > >  
> > > > > > > > > As there is no current RCEC driver support, it should
> > > > > > > > > not be
> > > > > > > > > possible
> > > > > > > > > to get
> > > > > > > > > to this code via any routes other than the one above.
> > > > > > > > > Hence
> > > > > > > > > appropriate RCEC
> > > > > > > > > handling can be added when the RCEC driver support is
> > > > > > > > > ready.
> > > > > > > > > The error handling is different from a normal PCIe
> > > > > > > > > End Point
> > > > > > > > > On Wed, 8 Jul 2020 09:01:13 -0700
> > > > > > > > > > Sean V Kelley <sean.v.kelley@linux.intel.com>
> > > > > > > > > wrote:
> > > > > > > > > > 
> > > > > > > > > > > On 8 Jul 2020, at 8:39, Jonathan Cameron wrote:
> > > > > > > > > > > 
> > > > > > > > > > > > On Tue, 7 Jul 2020 09:56:26 -0700
> > > > > > > > > > > > Sean V Kelley <sean.v.kelley@linux.intel.com>
> > > > > > > > > wrote:
> > > > > > > > > > > >  
> > > > > > > > > > > > > On 3 Jul 2020, at 1:23, Jonathan Cameron
> > > > > > > > > wrote:
> > > > > > > > > > > > >  
> > > > > > > > > > > > > > On Thu, 2 Jul 2020 11:06:26 -0700
> > > > > > > > > > > > > > Sean V Kelley <
> > > > > > > > > sean.v.kelley@linux.intel.com> wrote:
> > > > > > > > > > > > > >  
> > > > > > > > > > > > > > > On 26 Jun 2020, at 11:41, Jonathan
> > > > > > > > > Cameron wrote:
> > > > > > > > > > > > > > >  
> > > > > > > > > > > > > > > > On Fri, 26 Jun 2020 09:29:34 -0700
> > > > > > > > > > > > > > > > Sean V Kelley <
> > > > > > > > > sean.v.kelley@linux.intel.com> wrote:
> > > > > > > > > > > > > > > >  
> > > > > > > > > > > > > > > > > Hi,  
> > > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > Thanks for taking a look.
> > > > > > > > > > > > > > > >  
> > > > > > > > > > > > > > > > > On 22 Jun 2020, at 4:44, Jonathan
> > > > > > > > > Cameron wrote:
> > > > > > > > > > > > > > > > >  
> > > > > > > > > > > > > > > > > > Was previously: PCI/AER: Add
> > > > > > > > > partial initial supprot
> > > > > > > > > > > > > > > > > > for
> > > > > > > > > > > > > > > > > > RCiEPs
> > > > > > > > > > > > > > > > > > using
> > > > > > > > > > > > > > > > > > RCEC or
> > > > > > > > > > > > > > > > > > firmware first.
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > Currently the kernel does not
> > > > > > > > > handle AER errors for
> > > > > > > > > > > > > > > > > > Root
> > > > > > > > > > > > > > > > > > Complex
> > > > > > > > > > > > > > > > > > integrated
> > > > > > > > > > > > > > > > > > End Points (RCiEPs)[0].  These
> > > > > > > > > devices sit on a root
> > > > > > > > > > > > > > > > > > bus
> > > > > > > > > > > > > > > > > > within
> > > > > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > > > > Root Complex
> > > > > > > > > > > > > > > > > > (RC).  AER handling is performed by
> > > > > > > > > a Root Complex
> > > > > > > > > > > > > > > > > > Event
> > > > > > > > > > > > > > > > > > Collector
> > > > > > > > > > > > > > > > > > (RCEC) [1]
> > > > > > > > > > > > > > > > > > which is a effectively a type of
> > > > > > > > > RCiEP on the same
> > > > > > > > > > > > > > > > > > root bus.
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > This code will only perform the
> > > > > > > > > correct reset flow
> > > > > > > > > > > > > > > > > > for the
> > > > > > > > > > > > > > > > > > case
> > > > > > > > > > > > > > > > > > where
> > > > > > > > > > > > > > > > > > there
> > > > > > > > > > > > > > > > > > is no need to take any actions on
> > > > > > > > > the RCEC because
> > > > > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > > > > firmware is
> > > > > > > > > > > > > > > > > > responsible for them.   This is
> > > > > > > > > true where APEI [2]
> > > > > > > > > > > > > > > > > > is used
> > > > > > > > > > > > > > > > > > to
> > > > > > > > > > > > > > > > > > report
> > > > > > > > > > > > > > > > > > the AER
> > > > > > > > > > > > > > > > > > errors via a GHES[v2] HEST entry
> > > > > > > > > [3] and relevant AER
> > > > > > > > > > > > > > > > > > CPER
> > > > > > > > > > > > > > > > > > record
> > > > > > > > > > > > > > > > > > [4]
> > > > > > > > > > > > > > > > > > and Firmware
> > > > > > > > > > > > > > > > > > First handling is in use.  
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > Right, in the case of the RCEC one
> > > > > > > > > identifies the
> > > > > > > > > > > > > > > > > RCiEPs by
> > > > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > > > RCiEP
> > > > > > > > > > > > > > > > > bitmap as a part of the RCEC
> > > > > > > > > Associated Endpoint
> > > > > > > > > > > > > > > > > Extended
> > > > > > > > > > > > > > > > > because:
> > > > > > > > > 
> > > > > > > > > 1) There is no downstream port above an RCiEP as
> > > > > > > > > these
> > > > > > > > > devices sit
> > > > > > > > > on
> > > > > > > > > a root
> > > > > > > > >    bus.
> > > > > > > > > 
> > > > > > > > > 2) In general, it makes little sense to reset other
> > > > > > > > > devices
> > > > > > > > > on on
> > > > > > > > > the
> > > > > > > > > same
> > > > > > > > >    root bus.  For error handling outside the of the
> > > > > > > > > root
> > > > > > > > > complex
> > > > > > > > > (RC)
> > > > > > > > > an AER
> > > > > > > > >    error will indicate that all the topology below
> > > > > > > > > the
> > > > > > > > > physical
> > > > > > > > > link,
> > > > > > > > > which
> > > > > > > > >    the error is related to, will need to be reset as
> > > > > > > > > they
> > > > > > > > > share a
> > > > > > > > > common
> > > > > > > > >    path to the host.  For an RCiEP there is no such
> > > > > > > > > defined
> > > > > > > > > shared
> > > > > > > > > path
> > > > > > > > >    relationship with other elements on the root bus.
> > > > > > > > > 
> > > > > > > > > A new walk function, similar to pci_bus_walk is
> > > > > > > > > provided
> > > > > > > > > that
> > > > > > > > > takes
> > > > > > > > > a
> > > > > > > > > pci_dev
> > > > > > > > > instead of a bus.  If that dev corresponds to a
> > > > > > > > > downstream
> > > > > > > > > port it
> > > > > > > > > will walk
> > > > > > > > > the subordinate bus of that downstream port.  If the
> > > > > > > > > dev does
> > > > > > > > > not
> > > > > > > > > then
> > > > > > > > > it
> > > > > > > > > will call the function on that device alone.   This
> > > > > > > > > function
> > > > > > > > > allows
> > > > > > > > > us
> > > > > > > > > to
> > > > > > > > > avoid adding special cases to the majority of the
> > > > > > > > > error
> > > > > > > > > handling.  
> > > > > > > > 
> > > > > > > > Then in that case the callback could add the additional
> > > > > > > > checks
> > > > > > > > specific
> > > > > > > > to identifying the associated RCiEPs.  
> > > > > > > 
> > > > > > > I am afraid I don't follow what you mean here.  Could you
> > > > > > > give
> > > > > > > more
> > > > > > > info?  
> > > > > > 
> > > > > > Sure, a given RCEC can be associated with multiple
> > > > > > RCiEPs.  As a
> > > > > > part
> > > > > > of
> > > > > > the Extended Association Cap it is possible to obtain a
> > > > > > bitmap of
> > > > > > the
> > > > > > RCiEP device ids on the same bus number as the RCEC device
> > > > > > itself.
> > > > > > (5.0-1.0 sec 7.9.10.2).  With a Cap version of 2h or
> > > > > > higher, it is
> > > > > > also
> > > > > > possible to get an additional range of bus numbers
> > > > > > containing
> > > > > > RCiEPs
> > > > > > also associated with this RCEC.
> > > > > > 
> > > > > > So I’m wondering if this function could be used in which
> > > > > > passing 
> > > > > > a
> > > > > > dev, in this case the RCEC, triggers the call back which
> > > > > > makes use
> > > > > > of
> > > > > > the RCiEP bitmap and associated bus ranges to return all
> > > > > > identified
> > > > > > devices in use cases such as in AER for finding sources,
> > > > > > etc.  
> > > > > 
> > > > > Ah understood.
> > > > > 
> > > > > If we do this we effectively end up with 3 different types of
> > > > > walk
> > > > > and
> > > > > the meaning of the walk function gets more complex again.
> > > > > 
> > > > > 1) Normal bus walk - we pass the downstream port above a bus
> > > > > to 
> > > > > which
> > > > > the device is attached and it walks everthing below that
> > > > > point.
> > > > > 
> > > > > 2) Case I care about RCiEP with no visible association with
> > > > > an RCEC
> > > > > as
> > > > > I don't need to walk devices.  In that case just calls the
> > > > > callbacks
> > > > > for
> > > > > the actual device.
> > > > > 
> > > > > 3) Pass in RCiEP with RCEC asociated with it (or do a dance
> > > > > at the
> > > > > caller
> > > > > to pass in the RCEC itself). Need to walk the devices that
> > > > > the RCEC
> > > > > is
> > > > > handling errors for.  For handling, I'm not all the calls
> > > > > will be
> > > > > generally
> > > > > applicable to other devices associated with the RCEC as some
> > > > > only
> > > > > make
> > > > > sense if there is an actual PCIe bus involved and hence we
> > > > > need to
> > > > > reset
> > > > > other devices on that bus.  For RCEC I don't think there is
> > > > > an
> > > > > particular
> > > > > reason to assume an AER error reported at one RCiEP will have
> > > > > any
> > > > > impact
> > > > > on other devices associated with the particular RCEC.
> > > > > I've not found anything in the spec addressing this question
> > > > > but
> > > > > perhaps
> > > > > I've missed something?  
> > > > 
> > > > Correct.  There should be no impact to the RCEC or its
> > > > associated
> > > > RCiEPs which may not happen to reside on the same bus as the 
> > > > collector at all.
> > > >  
> > > > > However, if the RCEC doesn't support multiple error records,
> > > > > you may
> > > > > need
> > > > > to walk the bus to identify multiple simultaneous issues,
> > > > > very
> > > > > carefully
> > > > > avoiding (or least minimizing) race conditions.
> > > > >  
> > > > > > The alternative is to have a separate walk for RCECs that
> > > > > > loops
> > > > > > through
> > > > > > the bitmap / ranges (if supported) triggering the callback
> > > > > > for each
> > > > > > device found.  
> > > > 
> > > > I’ve been testing the Associated Endpoint Bitmap and Bus Range
> > > > handling and using my pciutils patches to help to confirm some
> > > > of the
> > > > association. This overlaps with my CXL work and CXL 1.1 based
> > > > RCiEPs
> > > > are good test cards:
> > > > 
> > > > (Decode via:
> > > > https://lore.kernel.org/linux-pci/20200624223940.240463-1-sean.v.kelley@linux.intel.com/
> > > >  )
> > > > 
> > > > Test card at 6b:00.0
> > > > 
> > > > Capabilities: [e00 v1] Designated Vendor-Specific: Vendor=1e98 
> > > > ID=0000
> > > > Rev=0 Len=56: CXL
> > > > CXLCap: Cache- IO+ Mem+ Mem HW Init+ HDMCount 1 Viral-
> > > > CXLCtl: Cache- IO+ Mem- Cache SF Cov 0 Cache SF Gran 0 Cache
> > > > Clean-
> > > > Viral-
> > > > CXLSta: Viral-
> > > > Capabilities: [e38 v1] Device Serial Number 30-91-11-78-10-00-
> > > > 00-00
> > > > 
> > > > RCEC assocated to RCiEP at 6b while residing at 6a:
> > > > 
> > > > Capabilities: [160 v2] Root Complex Event Collector Endpoint
> > > > Association
> > > > RCiEPBitmap: 00000000 [none]
> > > > AssociatedBusNumbers: 6b-6b
> > > > Kernel driver in use: pcieport
> > > > 
> > > > with dmesg:
> > > > 
> > > > [ 10.502543] pcieport 0000:6a:00.4: AER: enabled with IRQ 34
> > > > 
> > > > The trick is the walk, which is not compact.  Currently working
> > > > on
> > > > error injection to test:
> > > > 
> > > > void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct
> > > > pci_dev *,
> > > > void *),
> > > > +                   void *userdata)
> > > > +{
> > > > +       u32 pos, bitmap, hdr, busn;
> > > > +       u8 ver, nextbusn, lastbusn;
> > > > +       unsigned int dev, fn, bnr;
> > > > +       struct pci_bus *pbus=NULL;
> > > > +       struct pci_dev *pdev;
> > > > +       int retval;
> > > > +
> > > > +       pos = pci_find_ext_capability(rcec,
> > > > PCI_EXT_CAP_ID_RCEC);
> > > > +       if (!pos)
> > > > +               return;
> > > > +
> > > > +       pci_read_config_dword(rcec, pos +
> > > > PCI_RCEC_RCIEP_BITMAP,
> > > > &bitmap);
> > > > +
> > > > +       for (dev = 0; dev < 32; dev++) {  
> > > 
> > > for_each_bit_set perhaps?
> > >  
> > > > +               if (!(bitmap & (1 << dev)))
> > > > +                       continue;
> > > > +
> > > > +               for (fn = 0; fn < 8; fn++) {
> > > > +                       pdev =
> > > > pci_get_domain_bus_and_slot(pci_domain_nr(rcec->bus),
> > > > +                                                          rcec
> > > > ->bus-  
> > > > > number,  
> > > > +                                                          
> > > > PCI_DEVFN(de
> > > > v, fn));
> > > > +                       if (!pdev)
> > > > +                               continue;
> > > > +
> > > > +                       retval = cb(pdev, userdata);
> > > > +                       if (retval)
> > > > +                               return;
> > > > +               }
> > > > +       }
> > > > 
> > > > Then continuing in the same function above, I need to also
> > > > consider 
> > > > the
> > > > case for the Bus ranges (still wip, not tested):
> > > > 
> > > > +       pci_read_config_dword(rcec, pos, &hdr);
> > > > +       ver = PCI_RCEC_EP_CAP_VER(hdr);
> > > > +       if (ver < PCI_RCEC_BUSN_REG_VER)
> > > > +               return;
> > > > +
> > > > +       pci_read_config_dword(rcec, pos + PCI_RCEC_BUSN,
> > > > &busn);
> > > > +       nextbusn = PCI_RCEC_BUSN_NEXT(busn);
> > > > +       lastbusn = PCI_RCEC_BUSN_LAST(busn);
> > > > +
> > > > +       if ((nextbusn == 0xff) && (lastbusn == 0x00))
> > > > +               return;
> > > > +
> > > > +       for (bnr = nextbusn; bnr < (lastbusn + 1); bnr++) {
> > > > +               pbus = pci_find_bus(pci_domain_nr(rcec->bus),
> > > > bnr);
> > > > +               if (pbus) {
> > > > +                       /* find RCiEP devices on the given bus
> > > > */
> > > > +                       for (dev = 0; dev < 32; dev++) {
> > > > + etc...
> > > > +                       }
> > > > +               }
> > > > +       }
> > > > +}  
> > > 
> > > Makes sense.
> > >  
> > > > Currently this lives in aer.c and it's large enough that I
> > > > wonder if
> > > > due to the specifity of the assoicated spec requirments if
> > > > that 
> > > > should
> > > > be fine?  
> > > 
> > > Seems fine to me.
> > >  
> > > >  
> > > > > Agreed. We would end up with the same splitting of handling
> > > > > paths
> > > > > that
> > > > > wasn't liked in my v1 patch.   Perhaps we need  single
> > > > > pci_walk_aer_affected
> > > > > function with a pile of documentation for what it is actually
> > > > > doing?  
> > > > 
> > > > Perhaps this would be a good start?  I tend to agree.  I can
> > > > also
> > > > submit more of the patches as RFC for further comment.  
> > > 
> > > When you are ready that would be great.  
> > 
> > Sounds good.
> > 
> > >  
> > > >  
> > > > > Even then we may need to have a parameter to indicate a
> > > > > particular
> > > > > callback
> > > > > should be restricted to devices that share a 'real bus' or
> > > > > not.  
> > > > 
> > > > In my case 'walk' through the spec options of either just
> > > > bitmap or 
> > > > if
> > > > of sufficient version (2h), I walk through the bus ranges,
> > > > calling 
> > > > the
> > > > callback at each encounter.  
> > > 
> > > That wasn't what I meant.  When doing some of the actual handling
> > > once
> > > we have a walk function it will get a bit fiddly.
> > > I 'think' we need to first identify which devices associated with
> > > the 
> > > RCEC
> > > have reported an AER error and then we need to only call the
> > > callback 
> > > for
> > > those.  
> > 
> > Right, I was going to do that decision making in the call back
> > rather 
> > than include those details in the walk. That way the call back
> > simply 
> > reports what associated devices it finds and makes no assumptions
> > on 
> > which device needs to be acted upon.  I’ll experiment with 
> > alternatives to placement of identification code.
> 
> That may work.  Will need the existing callbacks to be a bit more
> clever
> perhaps. Will be interesting to see what you get to work!
> 

Patches are out today, please take a look:

https://lore.kernel.org/linux-pci/20200724172223.145608-1-sean.v.kelley@intel.com/

Thanks,
Sean


