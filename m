Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED821E29A1
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgEZSGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 14:06:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:13544 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgEZSGx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 14:06:53 -0400
IronPort-SDR: D247/DyVAw3Jld+4PYfjzqpA3IBef9yHI0COnLtBIHli/4ObJz255crzRj0jLe95Jwjkq1Y2/0
 fQkVhTGw+YIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 11:06:52 -0700
IronPort-SDR: q+pQDcn4f+N/hEXm8Qvt7pl3Xr3aIrKoloNX8RPGaEGmVHMomEVW9q5KhawnCFSUiDi4jKMJH/
 JNdh8L62gBFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="468395909"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga005.fm.intel.com with ESMTP; 26 May 2020 11:06:48 -0700
Date:   Tue, 26 May 2020 11:06:48 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>,
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200526180648.GC35892@otc-nc-03>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
 <20200504231936.2bc07fe3@x1.home>
 <20200505061107.GA22974@araj-mobl1.jf.intel.com>
 <20200505080514.01153835@x1.home>
 <20200505145605.GA13690@otc-nc-03>
 <20200505093414.6bae52e0@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505093414.6bae52e0@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

I was able to find better language in the IOMMU spec that gaurantees 
the behavior we need. See below.


On Tue, May 05, 2020 at 09:34:14AM -0600, Alex Williamson wrote:
> On Tue, 5 May 2020 07:56:06 -0700
> "Raj, Ashok" <ashok.raj@intel.com> wrote:
> 
> > On Tue, May 05, 2020 at 08:05:14AM -0600, Alex Williamson wrote:
> > > On Mon, 4 May 2020 23:11:07 -0700
> > > "Raj, Ashok" <ashok.raj@intel.com> wrote:
> > >   
> > > > Hi Alex
> > > > 
> > > > + Joerg, accidently missed in the Cc.
> > > > 
> > > > On Mon, May 04, 2020 at 11:19:36PM -0600, Alex Williamson wrote:  
> > > > > On Mon,  4 May 2020 21:42:16 -0700
> > > > > Ashok Raj <ashok.raj@intel.com> wrote:
> > > > >     
> > > > > > PCIe Spec recommends we can relax ACS requirement for RCIEP devices.
> > > > > > 
> > > > > > PCIe 5.0 Specification.
> > > > > > 6.12 Access Control Services (ACS)
> > > > > > Implementation of ACS in RCiEPs is permitted but not required. It is
> > > > > > explicitly permitted that, within a single Root Complex, some RCiEPs
> > > > > > implement ACS and some do not. It is strongly recommended that Root Complex
> > > > > > implementations ensure that all accesses originating from RCiEPs
> > > > > > (PFs and VFs) without ACS capability are first subjected to processing by
> > > > > > the Translation Agent (TA) in the Root Complex before further decoding and
> > > > > > processing. The details of such Root Complex handling are outside the scope
> > > > > > of this specification.
> > > > > >   
> > > > > 
> > > > > Is the language here really strong enough to make this change?  ACS is
> > > > > an optional feature, so being permitted but not required is rather
> > > > > meaningless.  The spec is also specifically avoiding the words "must"
> > > > > or "shall" and even when emphasized with "strongly", we still only have
> > > > > a recommendation that may or may not be honored.  This seems like a
> > > > > weak basis for assuming that RCiEPs universally honor this
> > > > > recommendation.  Thanks,
> > > > >     
> > > > 
> > > > We are speaking about PCIe spec, where people write it about 5 years ahead
> > > > and every vendor tries to massage their product behavior with vague
> > > > words like this..  :)
> > > > 
> > > > But honestly for any any RCiEP, or even integrated endpoints, there 
> > > > is no way to send them except up north. These aren't behind a RP.  
> > > 
> > > But they are multi-function devices and the spec doesn't define routing
> > > within multifunction packages.  A single function RCiEP will already be
> > > assumed isolated within its own group.  
> > 
> > That's right. The other two devices only have legacy PCI headers. So 
> > they can't claim to be RCiEP's but just integrated endpoints. The legacy
> > devices don't even have a PCIe header.
> > 
> > I honestly don't know why these are groped as MFD's in the first place.
> > 
> > >    
> > > > I did check with couple folks who are part of the SIG, and seem to agree
> > > > that ACS treatment for RCiEP's doesn't mean much. 
> > > > 
> > > > I understand the language isn't strong, but it doesn't seem like ACS should
> > > > be a strong requirement for RCiEP's and reasonable to relax.
> > > > 
> > > > What are your thoughts?   
> > > 
> > > I think hardware vendors have ACS at their disposal to clarify when
> > > isolation is provided, otherwise vendors can submit quirks, but I don't
> > > see that the "strongly recommended" phrasing is sufficient to assume
> > > isolation between multifunction RCiEPs.  Thanks,  
> > 
> > You point is that integrated MFD endpoints, without ACS, there is no 
> > gaurantee to SW that they are isolated.
> > 
> > As far as a quirk, do you think:
> > 	- a cmdline optput for integrated endpoints, and RCiEP's suffice?
> > 	  along with a compile time default that is strict enforcement
> > 	- typical vid/did type exception list?
> > 
> > A more generic way to ask for exception would be scalable until we can stop
> > those type of integrated devices. Or we need to maintain these device lists
> > for eternity. 
> 
> I don't think the language in the spec is anything sufficient to handle
> RCiEP uniquely.  We've previously rejected kernel command line opt-outs
> for ACS, and the extent to which those patches still float around the
> user community and are blindly used to separate IOMMU groups are a
> testament to the failure of this approach.  Users do not have a basis
> for enabling this sort of opt-out.  The benefit is obvious in the IOMMU
> grouping, but the risk is entirely unknown.  A kconfig option is even
> worse as that means if you consume a downstream kernel, the downstream
> maintainers might have decided universally that isolation is less
> important than functionality.

We discussed this internally, and Intel vt-d spec does spell out clearly 
in Section 3.16 Root-Complex Peer to Peer Considerations. The spec clearly
calls out that all p2p must be done on translated addresses and therefore
must go through the IOMMU.

I suppose they should also have some similar platform gauranteed behavior
for RCiEP's or MFD's *Must* behave as follows. The language is strict and
when IOMMU is enabled in the platform, everything is sent up north to the
IOMMU agent.

3.16 Root-Complex Peer to Peer Considerations
When DMA remapping is enabled, peer-to-peer requests through the
Root-Complex must be handled
as follows:
• The input address in the request is translated (through first-level,
  second-level or nested translation) to a host physical address (HPA).
  The address decoding for peer addresses must be done only on the 
  translated HPA. Hardware implementations are free to further limit 
  peer-to-peer accesses to specific host physical address regions 
  (or to completely disallow peer-forwarding of translated requests).
• Since address translation changes the contents (address field) of the PCI
  Express Transaction Layer Packet (TLP), for PCI Express peer-to-peer 
  requests with ECRC, the Root-Complex hardware must use the new ECRC 
  (re-computed with the translated address) if it decides to forward 
  the TLP as a peer request.
• Root-ports, and multi-function root-complex integrated endpoints, may
  support additional peerto-peer control features by supporting PCI Express
  Access Control Services (ACS) capability. Refer to ACS capability in 
  PCI Express specifications for details.

> to indicate where devices are isolated.  The hardware can do this
> itself by implementing ACS, otherwise we need quirks.  I think we've
> also generally been reluctant to accept quirks that provide a blanket
> opt-out for a vendor because doing so is akin to trying to predict the
> future (determining the behavior of all current and previous hardware
> is generally a sufficiently impossible task already).  Perhaps if a
> vendor has a published internal policy regarding RCiEP isolation and is
> willing to stand by a quirk, there might be room to negotiate.  Thanks,
> 
> Alex
> 
