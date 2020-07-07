Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3724F21761A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGGSNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 14:13:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:16648 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgGGSNk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 14:13:40 -0400
IronPort-SDR: 5KXnoWWbJ1OyetQAYSEMidtc01sX7lr850PpzfS0Btg79MyJezgDwoJMJdb2NH0EB3QR1j4z50
 UJoDggl9zDWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="232537266"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="232537266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 11:08:37 -0700
IronPort-SDR: YMF2E2rA5NfghqnpPzUMY+gm8z60gEkEvF4SZunb5s4VU2S27gxiz7N9In/Z3twLOeaPPDhyWy
 IOmmlZUvB9ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="427560512"
Received: from unknown (HELO arch-ashland-svkelley) ([10.254.20.145])
  by orsmga004.jf.intel.com with ESMTP; 07 Jul 2020 11:08:36 -0700
Message-ID: <32846e01ccc7e8222dbedeae0e73fd4f484ca39a.camel@linux.intel.com>
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
Date:   Tue, 07 Jul 2020 11:08:36 -0700
In-Reply-To: <431b4d136e5e2ba158640c0ef6eb7dc09351a992.camel@linux.intel.com>
References: <20200622114402.892798-1-Jonathan.Cameron@huawei.com>
         <02999929-39F5-4A11-AACA-84490F12E12B@linux.intel.com>
         <20200626194126.00007190@Huawei.com>
         <6CAFE871-36CC-44DD-B4E0-D0BB5ABF3947@linux.intel.com>
         <20200703092351.00004981@Huawei.com>
         <431b4d136e5e2ba158640c0ef6eb7dc09351a992.camel@linux.intel.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Minor correction:

On Tue, 2020-07-07 at 09:56 -0700, Sean V Kelley wrote:
> On 3 Jul 2020, at 1:23, Jonathan Cameron wrote:
> 
> > On Thu, 2 Jul 2020 11:06:26 -0700
> > Sean V Kelley <sean.v.kelley@linux.intel.com> wrote:
> > 
> > However, if the RCEC doesn't support multiple error records, you
> > may 
> > need
> > to walk the bus to identify multiple simultaneous issues, very 
> > carefully
> > avoiding (or least minimizing) race conditions.
> > 
> > > The alternative is to have a separate walk for RCECs that loops 
> > > through
> > > the bitmap / ranges (if supported) triggering the callback for
> > > each
> > > device found.
> 
> I’ve been testing the Associated Endpoint Bitmap and Bus Range 
> handling and using my pciutils patches to help to confirm some of
> the 
> association. This overlaps with my CXL work and CXL 1.1 based RCiEPs
> are good test cards:
> 
> (Decode via:  
> https://lore.kernel.org/linux-pci/20200624223940.240463-1-sean.v.kelley@linux.intel.com/
>  )
> 
> Test card at 6b:00.0
> 
> Capabilities: [e00 v1] Designated Vendor-Specific: Vendor=1e98
> ID=0000
> Rev=0 Len=56: CXL
> CXLCap: Cache- IO+ Mem+ Mem HW Init+ HDMCount 1 Viral-
> CXLCtl: Cache- IO+ Mem- Cache SF Cov 0 Cache SF Gran 0 Cache Clean-
> Viral-
> CXLSta: Viral-
> Capabilities: [e38 v1] Device Serial Number 30-91-11-78-10-00-00-00
> 
> RCEC assocated to RCiEP at 6b while residing at 6a:
> 
> Capabilities: [160 v2] Root Complex Event Collector Endpoint
> Association
> RCiEPBitmap: 00000000 [none]
> AssociatedBusNumbers: 6b-6b
> Kernel driver in use: pcieport
> 
> with dmesg:
> 
> [ 10.502543] pcieport 0000:6a:00.4: AER: enabled with IRQ 34
> 
> The trick is the walk, which is not compact.  Currently working on
> error injection to test:
> 
> void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *,
> void *),
> +                   void *userdata)
> +{
> +       u32 pos, bitmap, hdr, busn;
> +       u8 ver, nextbusn, lastbusn;
> +       unsigned int dev, fn, bnr;
> +       struct pci_bus *pbus=NULL;
> +       struct pci_dev *pdev;
> +       int retval;
> +
> +       pos = pci_find_ext_capability(rcec, PCI_EXT_CAP_ID_RCEC);
> +       if (!pos)
> +               return;
> +
> +       pci_read_config_dword(rcec, pos + PCI_RCEC_RCIEP_BITMAP,
> &bitmap);
> +
> +       for (dev = 0; dev < 32; dev++) {
> +               if (!(bitmap & (1 << dev)))
> +                       continue;
> +
> +               for (fn = 0; fn < 8; fn++) {
> +                       pdev =
> pci_get_domain_bus_and_slot(pci_domain_nr(rcec->bus),
> +                                                          rcec->bus-
> > number,
> +                                                          PCI_DEVFN(
> de
> v, fn));
> +                       if (!pdev)
> +                               continue;
> +
> +                       retval = cb(pdev, userdata);
> +                       if (retval)
> +                               return;
> +               }
> +       }
> 
> Then continuing in the same function above, I need to also consider
> the
> case for the Bus ranges (still wip, not tested):
> 
> +       pci_read_config_dword(rcec, pos, &hdr);
> +       ver = PCI_RCEC_EP_CAP_VER(hdr);
> +       if (ver < PCI_RCEC_BUSN_REG_VER)
> +               return;
> +
> +       pci_read_config_dword(rcec, pos + PCI_RCEC_BUSN, &busn);
> +       nextbusn = PCI_RCEC_BUSN_NEXT(busn);
> +       lastbusn = PCI_RCEC_BUSN_LAST(busn);
> +
> +       if ((nextbusn == 0xff) && (lastbusn == 0x00))
> +               return;
> +
> +       for (bnr = nextbusn; bnr < (lastbusn + 1); bnr++) {
> +               pbus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
> +               if (pbus) {
> +                       /* find RCiEP devices on the given bus */
> +                       for (dev = 0; dev < 32; dev++) {
> + etc...
> +                       }
> +               }
> +       }
> +}
> 
> Currently this lives in aer.c and it's large enough that I wonder if
> due to the specifity of the assoicated spec requirments if that
> should
> be fine?


This currently resides in portdrv_core.c due to the fact that a walk is
needed also for pme.c. 

Sean

> 
> > Agreed. We would end up with the same splitting of handling paths
> > that
> > wasn't liked in my v1 patch.   Perhaps we need  single 
> > pci_walk_aer_affected
> > function with a pile of documentation for what it is actually
> > doing?
> 
> Perhaps this would be a good start?  I tend to agree.  I can also
> submit more of the patches as RFC for further comment.
> 
> > Even then we may need to have a parameter to indicate a particular 
> > callback
> > should be restricted to devices that share a 'real bus' or not.
> 
> In my case 'walk' through the spec options of either just bitmap or
> if
> of sufficient version (2h), I walk through the bus ranges, calling
> the
> callback at each encounter.
> 
> > I guess the proof will as ever be in what the code looks like.
> 
> Agreed.
> 
> > Hmm. It increasingly feels like we may need to have a go at
> > drawing 
> > together
> > some coherent documentation for the different ways of handling
> > AER errors and specifications / assumptions for each.  Would be 
> > 'interesting'
> > to do given I'm fairly sure very few people actually understands
> > all 
> > the options and
> > nasty corner cases!
> > 
> > +CC Lorenzo and James who may also be interested in this topic in 
> > general.
> 
> Let's do.
> 
> Best regards,
> 
> Sean
> 
> > Thanks,
> > 
> > Jonathan
> > 
> > 
> > > Thanks,
> > > 
> > > Sean
> > > 
> > > > > > Open questions:
> > > > > > 
> > > > > > 1. Are we better protecting against link reset for an RCiEP
> > > > > > in 
> > > > > > here
> > > > > > or
> > > > > >    should we put the check in the link reset functions?
> > > > > > 
> > > > > > 2. If we were to get a stupid firmware record with the
> > > > > > relevant
> > > > > > reset
> > > > > > flag
> > > > > >    set to trigger a link reset, what is the correct
> > > > > > response?  For
> > > > > > now
> > > > > > I
> > > > > >    try to report that we haven't done anything and print a 
> > > > > > warning.
> > > > > > 
> > > > > > 3. Naming of pci_walk_below_dev is rather unsatisfying. Any
> > > > > > better
> > > > > > ideas?
> > > > > > 
> > > > > > 4. pci_walk_below_dev is perhaps not of general utility.
> > > > > > Shall I
> > > > > > make
> > > > > > it local
> > > > > >    in err.c?  If not would a precursor patch for that be
> > > > > > preferred?’
> > > > > 
> > > > > It depends.  Is it intended as a drop in replacement where
> > > > > needed 
> > > > > for
> > > > > pci_walk_bus()? So in that case you are now passing the dev 
> > > > > structure
> > > > > and do the check for subordinate or is it intended as being 
> > > > > specific
> > > > > to
> > > > > say RCEC? With AER, one could either first check for RC_EC
> > > > > type
> > > > > before
> > > > > using this one.  Or one could just drop in replace (passing
> > > > > the
> > > > > dev
> > > > > structure instead) and the call back performs the RCEC
> > > > > specific
> > > > > checks
> > > > > when a device is encountered.
> > > > 
> > > > If it is useful in aer.c that's great.   Just seemed such a
> > > > weird
> > > > beast
> > > > I wasn't sure it would be of use anywhere else.
> > > > 
> > > > > > Testing has been performed via error injection on a QEMU
> > > > > > platform 
> > > > > > as
> > > > > > that lets
> > > > > > me create a wide range of topologies and report errors at
> > > > > > any 
> > > > > > chosen
> > > > > > location.
> > > > > > Currently I have no plans to upstream this injection
> > > > > > support,
> > > > > > but 
> > > > > > am
> > > > > > happy to
> > > > > > share if useful to others.
> > > > > 
> > > > > I’m experimenting with it in my RCEC code in AER and will
> > > > > give 
> > > > > you
> > > > > additional feedback.
> > > > 
> > > > Great, thanks
> > > > 
> > > > Jonathan
> > > > 
> > > > > Thanks,
> > > > > 
> > > > > Sean
> > > > > 
> > > > > 
> > > > > > [0] ACPI PCI Express Base Specification 4.0 1.3.2.3 Root
> > > > > > Complex
> > > > > > Integrated
> > > > > >     Endpoint Rules.
> > > > > > [1] ACPI PCI Express Base Specification 4.0 6.2 Error
> > > > > > Signalling 
> > > > > > and
> > > > > > Logging
> > > > > > [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error 
> > > > > > Interface
> > > > > > (APEI)
> > > > > > [3] ACPI Sepcification 6.3 18.2.3.7 Generic Hardware Error
> > > > > > Source
> > > > > > [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
> > > > > > 
> > > > > > Signed-off-by: Jonathan Cameron <
> > > > > > Jonathan.Cameron@huawei.com>
> > > > > > ---
> > > > > > Changes since v1:
> > > > > > * Separated from the largely unrelated fix so the two can
> > > > > > move
> > > > > > forwards separately.
> > > > > > * Instead of separate path for RCiEP handling use the
> > > > > > method
> > > > > > suggested
> > > > > > by Bjorn
> > > > > >   and Sathyanarayanan with an adjusted pci_bus_walk.
> > > > > > 
> > > > > > Thanks all for reviews of V1.
> > > > > > 
> > > > > >  drivers/pci/bus.c      | 28 ++++++++++++++++++++++++++++
> > > > > >  drivers/pci/pcie/err.c | 29 +++++++++++++++++++----------
> > > > > >  include/linux/pci.h    |  2 ++
> > > > > >  3 files changed, 49 insertions(+), 10 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > > > index 8e40b3e6da77..7cbe1ed2db3d 100644
> > > > > > --- a/drivers/pci/bus.c
> > > > > > +++ b/drivers/pci/bus.c
> > > > > > @@ -411,6 +411,34 @@ void pci_walk_bus(struct pci_bus *top,
> > > > > > int
> > > > > > (*cb)(struct pci_dev *, void *),
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(pci_walk_bus);
> > > > > > 
> > > > > > +/** pci_walk_below_dev - walk devices below (or on)
> > > > > > another 
> > > > > > device
> > > > > > + *  @dev      device for which we should walk below,
> > > > > > include 
> > > > > > device
> > > > > > when not a port.
> > > > > > + *  @cb       callback to be called for each device found
> > > > > > + *  @userdata arbitrary pointer to be passed to callback.
> > > > > > + *
> > > > > > + *  If the device provided is a port,
> > > > > > + *  walk the subordinate bus, including any bridged
> > > > > > devices
> > > > > > + *  on buses under this bus.  Call the provided callback
> > > > > > + *  on each device found.
> > > > > > + *
> > > > > > + *  If the device provided hs no subordinate bus, call
> > > > > > the 
> > > > > > provided
> > > > > > + *  callback on the device itself.
> > > > > > + *
> > > > > > + */
> > > > > > +void pci_walk_below_dev(struct pci_dev *dev, int
> > > > > > (*cb)(struct
> > > > > > pci_dev
> > > > > > *, void *),
> > > > > > +			void *userdata)
> > > > > > +{
> > > > > > +	struct pci_bus *bus;
> > > > > > +
> > > > > > +	if (dev->subordinate) {
> > > > > > +		bus = dev->subordinate;
> > > > > > +		pci_walk_bus(bus, cb, userdata);
> > > > > > +	} else {
> > > > > > +		cb(dev, userdata);
> > > > > > +	}
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(pci_walk_below_dev);
> > > > > > +
> > > > > >  struct pci_bus *pci_bus_get(struct pci_bus *bus)
> > > > > >  {
> > > > > >  	if (bus)
> > > > > > diff --git a/drivers/pci/pcie/err.c
> > > > > > b/drivers/pci/pcie/err.c
> > > > > > index 14bb8f54723e..fa08b1cc3d96 100644
> > > > > > --- a/drivers/pci/pcie/err.c
> > > > > > +++ b/drivers/pci/pcie/err.c
> > > > > > @@ -151,33 +151,39 @@ pci_ers_result_t
> > > > > > pcie_do_recovery(struct
> > > > > > pci_dev
> > > > > > *dev,
> > > > > >  			pci_ers_result_t (*reset_link)(struct
> > > > > > pci_dev *pdev))
> > > > > >  {
> > > > > >  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> > > > > > -	struct pci_bus *bus;
> > > > > > 
> > > > > >  	/*
> > > > > >  	 * Error recovery runs on all subordinates of the
> > > > > > first 
> > > > > > downstream
> > > > > > port.
> > > > > >  	 * If the downstream port detected the error, it is
> > > > > > cleared at 
> > > > > > the
> > > > > > end.
> > > > > > +	 * For RCiEPs we should reset just the RCiEP itself.
> > > > > >  	 */
> > > > > >  	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > > > > > -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> > > > > > +	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> > > > > > +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END))
> > > > > >  		dev = dev->bus->self;
> > > > > > -	bus = dev->subordinate;
> > > > > > 
> > > > > >  	pci_dbg(dev, "broadcast error_detected message\n");
> > > > > >  	if (state == pci_channel_io_frozen) {
> > > > > > -		pci_walk_bus(bus, report_frozen_detected,
> > > > > > &status);
> > > > > > +		pci_walk_below_dev(dev, report_frozen_detected,
> > > > > > &status);
> > > > > > +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
> > > > > > {
> > > > > > +			pci_warn(dev, "link reset not possible
> > > > > > for RCiEP\n");
> > > > > > +			status = PCI_ERS_RESULT_NONE;
> > > > > > +			goto failed;
> > > > > > +		}
> > > > > > +
> > > > > >  		status = reset_link(dev);
> > > > > >  		if (status != PCI_ERS_RESULT_RECOVERED) {
> > > > > >  			pci_warn(dev, "link reset failed\n");
> > > > > >  			goto failed;
> > > > > >  		}
> > > > > >  	} else {
> > > > > > -		pci_walk_bus(bus, report_normal_detected,
> > > > > > &status);
> > > > > > +		pci_walk_below_dev(dev, report_normal_detected,
> > > > > > &status);
> > > > > >  	}
> > > > > > 
> > > > > >  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> > > > > >  		status = PCI_ERS_RESULT_RECOVERED;
> > > > > >  		pci_dbg(dev, "broadcast mmio_enabled
> > > > > > message\n");
> > > > > > -		pci_walk_bus(bus, report_mmio_enabled,
> > > > > > &status);
> > > > > > +		pci_walk_below_dev(dev, report_mmio_enabled,
> > > > > > &status);
> > > > > >  	}
> > > > > > 
> > > > > >  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> > > > > > @@ -188,17 +194,20 @@ pci_ers_result_t
> > > > > > pcie_do_recovery(struct
> > > > > > pci_dev
> > > > > > *dev,
> > > > > >  		 */
> > > > > >  		status = PCI_ERS_RESULT_RECOVERED;
> > > > > >  		pci_dbg(dev, "broadcast slot_reset message\n");
> > > > > > -		pci_walk_bus(bus, report_slot_reset, &status);
> > > > > > +		pci_walk_below_dev(dev, report_slot_reset,
> > > > > > &status);
> > > > > >  	}
> > > > > > 
> > > > > >  	if (status != PCI_ERS_RESULT_RECOVERED)
> > > > > >  		goto failed;
> > > > > > 
> > > > > >  	pci_dbg(dev, "broadcast resume message\n");
> > > > > > -	pci_walk_bus(bus, report_resume, &status);
> > > > > > +	pci_walk_below_dev(dev, report_resume, &status);
> > > > > > 
> > > > > > -	pci_aer_clear_device_status(dev);
> > > > > > -	pci_aer_clear_nonfatal_status(dev);
> > > > > > +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > > > > > +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> > > > > > +		pci_aer_clear_device_status(dev);
> > > > > > +		pci_aer_clear_nonfatal_status(dev);
> > > > > > +	}
> > > > > >  	pci_info(dev, "device recovery successful\n");
> > > > > >  	return status;
> > > > > > 
> > > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > > index c79d83304e52..538bf0a76d33 100644
> > > > > > --- a/include/linux/pci.h
> > > > > > +++ b/include/linux/pci.h
> > > > > > @@ -1411,6 +1411,8 @@ int pci_scan_bridge(struct pci_bus
> > > > > > *bus,
> > > > > > struct
> > > > > > pci_dev *dev, int max,
> > > > > > 
> > > > > >  void pci_walk_bus(struct pci_bus *top, int (*cb)(struct
> > > > > > pci_dev 
> > > > > > *,
> > > > > > void *),
> > > > > >  		  void *userdata);
> > > > > > +void pci_walk_below_dev(struct pci_dev *dev, int
> > > > > > (*cb)(struct
> > > > > > pci_dev
> > > > > > *, void *),
> > > > > > +			void *userdata);
> > > > > >  int pci_cfg_space_size(struct pci_dev *dev);
> > > > > >  unsigned char pci_bus_max_busnr(struct pci_bus *bus);
> > > > > >  void pci_setup_bridge(struct pci_bus *bus);
> > > > > > -- 
> > > > > > 2.19.1

