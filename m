Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB51C580E
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgEEOFX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 10:05:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54561 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728749AbgEEOFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 10:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588687521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=luoy1TLOzPtNCKIsAfLeQmh34ahepyUul/Qz8MaTrLs=;
        b=B3hkYBmK44NBz0ffhvBOOfh0OC8gdke8n+HSQlOkRYoLsIvfIfB75n6SXtjfRanz3+qHzd
        HG5Z+n2Nj+JXJfyqzZf6fZsYBDaM6mbILjNGyphInGzspD/DNhSMUdWdso37eJSZPV32QB
        4Kn/vUP9hDwQuYoe1Rv3z8bFvgiYvW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-ymkQCNgyNxC4TvjMGnwTBg-1; Tue, 05 May 2020 10:05:17 -0400
X-MC-Unique: ymkQCNgyNxC4TvjMGnwTBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26879461;
        Tue,  5 May 2020 14:05:16 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1904C6061C;
        Tue,  5 May 2020 14:05:15 +0000 (UTC)
Date:   Tue, 5 May 2020 08:05:14 -0600
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
Message-ID: <20200505080514.01153835@x1.home>
In-Reply-To: <20200505061107.GA22974@araj-mobl1.jf.intel.com>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
        <20200504231936.2bc07fe3@x1.home>
        <20200505061107.GA22974@araj-mobl1.jf.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 May 2020 23:11:07 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> Hi Alex
> 
> + Joerg, accidently missed in the Cc.
> 
> On Mon, May 04, 2020 at 11:19:36PM -0600, Alex Williamson wrote:
> > On Mon,  4 May 2020 21:42:16 -0700
> > Ashok Raj <ashok.raj@intel.com> wrote:
> >   
> > > PCIe Spec recommends we can relax ACS requirement for RCIEP devices.
> > > 
> > > PCIe 5.0 Specification.
> > > 6.12 Access Control Services (ACS)
> > > Implementation of ACS in RCiEPs is permitted but not required. It is
> > > explicitly permitted that, within a single Root Complex, some RCiEPs
> > > implement ACS and some do not. It is strongly recommended that Root Complex
> > > implementations ensure that all accesses originating from RCiEPs
> > > (PFs and VFs) without ACS capability are first subjected to processing by
> > > the Translation Agent (TA) in the Root Complex before further decoding and
> > > processing. The details of such Root Complex handling are outside the scope
> > > of this specification.
> > > 
> > > Since Linux didn't give special treatment to allow this exception, certain
> > > RCiEP MFD devices are getting grouped in a single iommu group. This
> > > doesn't permit a single device to be assigned to a guest for instance.
> > > 
> > > In one vendor system: Device 14.x were grouped in a single IOMMU group.
> > > 
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.3
> > > 
> > > After the patch:
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> > > /sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group
> > > 
> > > 14.0 and 14.2 are integrated devices, but legacy end points.
> > > Whereas 14.3 was a PCIe compliant RCiEP.
> > > 
> > > 00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
> > > Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
> > > 
> > > This permits assigning this device to a guest VM.
> > > 
> > > Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
> > > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > > To: Joerg Roedel <joro@8bytes.org>
> > > To: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: iommu@lists.linux-foundation.org
> > > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
> > > Cc: Mark Scott <mscott@forcepoint.com>,
> > > Cc: Romil Sharma <rsharma@forcepoint.com>
> > > Cc: Ashok Raj <ashok.raj@intel.com>
> > > ---
> > >  drivers/iommu/iommu.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 2b471419e26c..5744bd65f3e2 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -1187,7 +1187,20 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
> > >  	struct pci_dev *tmp = NULL;
> > >  	struct iommu_group *group;
> > >  
> > > -	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> > > +	/*
> > > +	 * PCI Spec 5.0, Section 6.12 Access Control Service
> > > +	 * Implementation of ACS in RCiEPs is permitted but not required.
> > > +	 * It is explicitly permitted that, within a single Root
> > > +	 * Complex, some RCiEPs implement ACS and some do not. It is
> > > +	 * strongly recommended that Root Complex implementations ensure
> > > +	 * that all accesses originating from RCiEPs (PFs and VFs) without
> > > +	 * ACS capability are first subjected to processing by the Translation
> > > +	 * Agent (TA) in the Root Complex before further decoding and
> > > +	 * processing.
> > > +	 */  
> > 
> > Is the language here really strong enough to make this change?  ACS is
> > an optional feature, so being permitted but not required is rather
> > meaningless.  The spec is also specifically avoiding the words "must"
> > or "shall" and even when emphasized with "strongly", we still only have
> > a recommendation that may or may not be honored.  This seems like a
> > weak basis for assuming that RCiEPs universally honor this
> > recommendation.  Thanks,
> >   
> 
> We are speaking about PCIe spec, where people write it about 5 years ahead
> and every vendor tries to massage their product behavior with vague
> words like this..  :)
> 
> But honestly for any any RCiEP, or even integrated endpoints, there 
> is no way to send them except up north. These aren't behind a RP.

But they are multi-function devices and the spec doesn't define routing
within multifunction packages.  A single function RCiEP will already be
assumed isolated within its own group.
 
> I did check with couple folks who are part of the SIG, and seem to agree
> that ACS treatment for RCiEP's doesn't mean much. 
> 
> I understand the language isn't strong, but it doesn't seem like ACS should
> be a strong requirement for RCiEP's and reasonable to relax.
> 
> What are your thoughts? 

I think hardware vendors have ACS at their disposal to clarify when
isolation is provided, otherwise vendors can submit quirks, but I don't
see that the "strongly recommended" phrasing is sufficient to assume
isolation between multifunction RCiEPs.  Thanks,

Alex

