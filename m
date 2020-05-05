Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548061C5A2A
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgEEO4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 10:56:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:9028 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbgEEO4H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 10:56:07 -0400
IronPort-SDR: aGndGSR8Xo6swItycAIjm5ani4eTHGNIR3UmOgB+j1v9lz/vK1r5hhKMJvbdg5+vd81n0NyIlb
 mB/l7XODtCLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 07:56:06 -0700
IronPort-SDR: 3Dvi1ejqJAT0ii4H3bhyjVLjuLdN2tBgeX+c/L56IS1TSdvC0/Ceit4FGYGFx4NJGifMt8HDih
 CO6rC90DOOqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="250919303"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2020 07:56:06 -0700
Date:   Tue, 5 May 2020 07:56:06 -0700
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
Message-ID: <20200505145605.GA13690@otc-nc-03>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
 <20200504231936.2bc07fe3@x1.home>
 <20200505061107.GA22974@araj-mobl1.jf.intel.com>
 <20200505080514.01153835@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505080514.01153835@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 08:05:14AM -0600, Alex Williamson wrote:
> On Mon, 4 May 2020 23:11:07 -0700
> "Raj, Ashok" <ashok.raj@intel.com> wrote:
> 
> > Hi Alex
> > 
> > + Joerg, accidently missed in the Cc.
> > 
> > On Mon, May 04, 2020 at 11:19:36PM -0600, Alex Williamson wrote:
> > > On Mon,  4 May 2020 21:42:16 -0700
> > > Ashok Raj <ashok.raj@intel.com> wrote:
> > >   
> > > > PCIe Spec recommends we can relax ACS requirement for RCIEP devices.
> > > > 
> > > > PCIe 5.0 Specification.
> > > > 6.12 Access Control Services (ACS)
> > > > Implementation of ACS in RCiEPs is permitted but not required. It is
> > > > explicitly permitted that, within a single Root Complex, some RCiEPs
> > > > implement ACS and some do not. It is strongly recommended that Root Complex
> > > > implementations ensure that all accesses originating from RCiEPs
> > > > (PFs and VFs) without ACS capability are first subjected to processing by
> > > > the Translation Agent (TA) in the Root Complex before further decoding and
> > > > processing. The details of such Root Complex handling are outside the scope
> > > > of this specification.
> > > > 
> > > 
> > > Is the language here really strong enough to make this change?  ACS is
> > > an optional feature, so being permitted but not required is rather
> > > meaningless.  The spec is also specifically avoiding the words "must"
> > > or "shall" and even when emphasized with "strongly", we still only have
> > > a recommendation that may or may not be honored.  This seems like a
> > > weak basis for assuming that RCiEPs universally honor this
> > > recommendation.  Thanks,
> > >   
> > 
> > We are speaking about PCIe spec, where people write it about 5 years ahead
> > and every vendor tries to massage their product behavior with vague
> > words like this..  :)
> > 
> > But honestly for any any RCiEP, or even integrated endpoints, there 
> > is no way to send them except up north. These aren't behind a RP.
> 
> But they are multi-function devices and the spec doesn't define routing
> within multifunction packages.  A single function RCiEP will already be
> assumed isolated within its own group.

That's right. The other two devices only have legacy PCI headers. So 
they can't claim to be RCiEP's but just integrated endpoints. The legacy
devices don't even have a PCIe header.

I honestly don't know why these are groped as MFD's in the first place.

>  
> > I did check with couple folks who are part of the SIG, and seem to agree
> > that ACS treatment for RCiEP's doesn't mean much. 
> > 
> > I understand the language isn't strong, but it doesn't seem like ACS should
> > be a strong requirement for RCiEP's and reasonable to relax.
> > 
> > What are your thoughts? 
> 
> I think hardware vendors have ACS at their disposal to clarify when
> isolation is provided, otherwise vendors can submit quirks, but I don't
> see that the "strongly recommended" phrasing is sufficient to assume
> isolation between multifunction RCiEPs.  Thanks,

You point is that integrated MFD endpoints, without ACS, there is no 
gaurantee to SW that they are isolated.

As far as a quirk, do you think:
	- a cmdline optput for integrated endpoints, and RCiEP's suffice?
	  along with a compile time default that is strict enforcement
	- typical vid/did type exception list?

A more generic way to ask for exception would be scalable until we can stop
those type of integrated devices. Or we need to maintain these device lists
for eternity. 

Cheers,
Ashok
