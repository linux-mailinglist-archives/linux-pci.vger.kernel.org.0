Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7DA1C5B78
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgEEPeZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 11:34:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49774 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729672AbgEEPeY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 11:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588692862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnbFEV0yzg7DHxDmKfIXizOuP0I8+/dIqAQu+mCixHM=;
        b=FZp2OOJnm0ssQ7DqTTwYNLEaXiYPtaqx1NrkGSdLi/NxRLeQ9xpwen3lTpBuAFuPUEEgeC
        k+QU5W2bDB5fbvBRBHGWqHbvSVjfrBA9czNFJ9Ieb7saC78PWn2rue9PNd+lTQEDlaYkUq
        mDMyMrLPtpx+hGH4QzbLWPDxtZmaSjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-q6FCn2JzMkCHeL88OvURcA-1; Tue, 05 May 2020 11:34:18 -0400
X-MC-Unique: q6FCn2JzMkCHeL88OvURcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE9D107ACCA;
        Tue,  5 May 2020 15:34:16 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA006061C;
        Tue,  5 May 2020 15:34:15 +0000 (UTC)
Date:   Tue, 5 May 2020 09:34:14 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200505093414.6bae52e0@x1.home>
In-Reply-To: <20200505145605.GA13690@otc-nc-03>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
        <20200504231936.2bc07fe3@x1.home>
        <20200505061107.GA22974@araj-mobl1.jf.intel.com>
        <20200505080514.01153835@x1.home>
        <20200505145605.GA13690@otc-nc-03>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 5 May 2020 07:56:06 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> On Tue, May 05, 2020 at 08:05:14AM -0600, Alex Williamson wrote:
> > On Mon, 4 May 2020 23:11:07 -0700
> > "Raj, Ashok" <ashok.raj@intel.com> wrote:
> >   
> > > Hi Alex
> > > 
> > > + Joerg, accidently missed in the Cc.
> > > 
> > > On Mon, May 04, 2020 at 11:19:36PM -0600, Alex Williamson wrote:  
> > > > On Mon,  4 May 2020 21:42:16 -0700
> > > > Ashok Raj <ashok.raj@intel.com> wrote:
> > > >     
> > > > > PCIe Spec recommends we can relax ACS requirement for RCIEP devices.
> > > > > 
> > > > > PCIe 5.0 Specification.
> > > > > 6.12 Access Control Services (ACS)
> > > > > Implementation of ACS in RCiEPs is permitted but not required. It is
> > > > > explicitly permitted that, within a single Root Complex, some RCiEPs
> > > > > implement ACS and some do not. It is strongly recommended that Root Complex
> > > > > implementations ensure that all accesses originating from RCiEPs
> > > > > (PFs and VFs) without ACS capability are first subjected to processing by
> > > > > the Translation Agent (TA) in the Root Complex before further decoding and
> > > > > processing. The details of such Root Complex handling are outside the scope
> > > > > of this specification.
> > > > >   
> > > > 
> > > > Is the language here really strong enough to make this change?  ACS is
> > > > an optional feature, so being permitted but not required is rather
> > > > meaningless.  The spec is also specifically avoiding the words "must"
> > > > or "shall" and even when emphasized with "strongly", we still only have
> > > > a recommendation that may or may not be honored.  This seems like a
> > > > weak basis for assuming that RCiEPs universally honor this
> > > > recommendation.  Thanks,
> > > >     
> > > 
> > > We are speaking about PCIe spec, where people write it about 5 years ahead
> > > and every vendor tries to massage their product behavior with vague
> > > words like this..  :)
> > > 
> > > But honestly for any any RCiEP, or even integrated endpoints, there 
> > > is no way to send them except up north. These aren't behind a RP.  
> > 
> > But they are multi-function devices and the spec doesn't define routing
> > within multifunction packages.  A single function RCiEP will already be
> > assumed isolated within its own group.  
> 
> That's right. The other two devices only have legacy PCI headers. So 
> they can't claim to be RCiEP's but just integrated endpoints. The legacy
> devices don't even have a PCIe header.
> 
> I honestly don't know why these are groped as MFD's in the first place.
> 
> >    
> > > I did check with couple folks who are part of the SIG, and seem to agree
> > > that ACS treatment for RCiEP's doesn't mean much. 
> > > 
> > > I understand the language isn't strong, but it doesn't seem like ACS should
> > > be a strong requirement for RCiEP's and reasonable to relax.
> > > 
> > > What are your thoughts?   
> > 
> > I think hardware vendors have ACS at their disposal to clarify when
> > isolation is provided, otherwise vendors can submit quirks, but I don't
> > see that the "strongly recommended" phrasing is sufficient to assume
> > isolation between multifunction RCiEPs.  Thanks,  
> 
> You point is that integrated MFD endpoints, without ACS, there is no 
> gaurantee to SW that they are isolated.
> 
> As far as a quirk, do you think:
> 	- a cmdline optput for integrated endpoints, and RCiEP's suffice?
> 	  along with a compile time default that is strict enforcement
> 	- typical vid/did type exception list?
> 
> A more generic way to ask for exception would be scalable until we can stop
> those type of integrated devices. Or we need to maintain these device lists
> for eternity. 

I don't think the language in the spec is anything sufficient to handle
RCiEP uniquely.  We've previously rejected kernel command line opt-outs
for ACS, and the extent to which those patches still float around the
user community and are blindly used to separate IOMMU groups are a
testament to the failure of this approach.  Users do not have a basis
for enabling this sort of opt-out.  The benefit is obvious in the IOMMU
grouping, but the risk is entirely unknown.  A kconfig option is even
worse as that means if you consume a downstream kernel, the downstream
maintainers might have decided universally that isolation is less
important than functionality.

I think the only solution is that the hardware vendors need to step up
to indicate where devices are isolated.  The hardware can do this
itself by implementing ACS, otherwise we need quirks.  I think we've
also generally been reluctant to accept quirks that provide a blanket
opt-out for a vendor because doing so is akin to trying to predict the
future (determining the behavior of all current and previous hardware
is generally a sufficiently impossible task already).  Perhaps if a
vendor has a published internal policy regarding RCiEP isolation and is
willing to stand by a quirk, there might be room to negotiate.  Thanks,

Alex

