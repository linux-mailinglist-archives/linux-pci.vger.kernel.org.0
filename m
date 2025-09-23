Return-Path: <linux-pci+bounces-36723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EDCB93EF8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 04:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9218A595E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 02:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366E273D9A;
	Tue, 23 Sep 2025 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GugeaNOA"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E999D272E71
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758593224; cv=none; b=hqkxLosdt5z5ibVcdz/uPOJDA0dFr+S4Q820HSoQTJAvCmqUbGr/NNlscuI5oOrU77UMfflxP/R1nODL4Z32tmc1dtSQADdB+co+s3ad9X3pFxzlHZwXX5f9X/qls7h9f9ffF1FHdMz17bmvegGKYIVkj07LkEyUhGpecB9NlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758593224; c=relaxed/simple;
	bh=hxlelpbKv6FmkP6tifB9ObAVB289dOhERvKZKK8nkEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzbkZEDaW8RG0ZRKdy0D0zbvL91eiofapBBWINZvOQbFhBXgOkLSTNiu0GnweCwhDIHAMNkEDfKUOLQnYIyVVZPBxS8UGN5vmCtvzCQoiFPHY9bKJ9F3VkvCHwEkh0aFlP0XjOtIYkONlzJGL3hg0orz5uyU4Fjgkhnq0yXe+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GugeaNOA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758593220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQSXu/tBIkGtqnapGa5REn0jb8CDZVdrcUf9mrDSfGs=;
	b=GugeaNOA+tdS9Y898bgxWMMsw6iHqe4O0Zw3TImkAf37W4d+IgayFbZkFIqP4sO3FSgOe/
	oc6gqGZlj/KEOG04mwG1UYbCvObDp3wwGlWZt+3G1msd49/+rLzGRg8Q7TgJ0QOI8bcHPI
	5In5ZrCquYeXAt6Tmd4gpnbDiFPt85U=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-VYkKp4vrNAOY1oreFmUHiQ-1; Mon, 22 Sep 2025 22:06:58 -0400
X-MC-Unique: VYkKp4vrNAOY1oreFmUHiQ-1
X-Mimecast-MFC-AGG-ID: VYkKp4vrNAOY1oreFmUHiQ_1758593218
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-34657fa878bso433328fac.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 19:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758593218; x=1759198018;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQSXu/tBIkGtqnapGa5REn0jb8CDZVdrcUf9mrDSfGs=;
        b=ln5OSD02qsa1d29kOjbwTLdSbFEYeQVSJjhAcWq8EXELx+xhxygYrkerMVN7dKDKet
         2OFBCv4WgFUNee3AT/oGpVKZWl2fxTrbs0AwnNrWRPxKWsZQyUVqzDkF1kRYB9aQTYDJ
         rZPFdty1jRb7VlearRBAZWEUBcQaRPo8vMn/tPpDe/P+ULP5IAbNuLmnliGAHO1kmN2D
         eBQiHCO4vBbs1WkLJ/hZVGI4cqVC2uNX7E+qW+rRm3uwztwFTYZFm/xepofmo0pglHae
         51baKB3T0KNAio7F39fVr2VYHb+iaCzWAn3ktSTNvc0GFQY5yyZ2MeYhAfATfeyCOnNZ
         a4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxCHEtFxAparD32Qws7HTxUIInVXiFSgb1PaVss99Yx0jJrmq6Z1sWJ6GLAjGn8s8G99kNhoW9enU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfC4IT/NDhlpXxMgDs0oXYtj/BgCITNRMdo3NDm4ZddwM3FBLK
	lzSaywH4mmFxGgknEOZcZKNXkjuO+neEnIaEAotRCeOLSYzpz4XE4ZGIjvHyiSS6fiQJEdUJFV6
	k0XIMD70ZIoG+IPUW5TLNrGjNvdkieivIe+IaVz+1Puke6ywAZJYP/nDLbjimTQ==
X-Gm-Gg: ASbGnctNvEd6LRPfwXH6mfI1FDU5k0dj/iJ5BgjY+2IrXkfUqcwO3griBgEX/0dQYWu
	exrqFA/DkzVXdusIRsJOtYLRfI7IBxMnnxoa5mw7PtCq+tnmZQDpY0RZcyzOvPZGYZL4eCHOAA/
	VUUrMkAeFNA2JBIZP/ZsY44c3eVJpbEdHTOV0wh7SDUuMEJm6O+kezGw+a+1FhSoY1MRhJ/hHSP
	fEUadCMO5ZXHKSxReexXWwDng7+YUJn5g8po3m3VmfEFZCOllQm+EPVLh10i2iMs3nhhKUGyJRB
	BCJBGKWIFsEUqqQKzY+ZBImpb/BQACSmzNJkhJBYPKc=
X-Received: by 2002:a05:6808:1997:b0:437:b03d:9028 with SMTP id 5614622812f47-43f2d4c80a0mr154649b6e.8.1758593217693;
        Mon, 22 Sep 2025 19:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMR1w06FroJTAROa+WnoXiVE0EXZyT2GRTa3R5RQsoT8/Jep2KvSTC8ACq2vGMVb7Fd8zBWQ==
X-Received: by 2002:a05:6808:1997:b0:437:b03d:9028 with SMTP id 5614622812f47-43f2d4c80a0mr154631b6e.8.1758593217219;
        Mon, 22 Sep 2025 19:06:57 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c85d269sm5474466b6e.23.2025.09.22.19.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:06:56 -0700 (PDT)
Date: Mon, 22 Sep 2025 20:06:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Donald Dutile <ddutile@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 galshalom@nvidia.com, Joerg Roedel <jroedel@suse.de>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, maorg@nvidia.com,
 patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH v3 00/11] Fix incorrect iommu_groups with PCIe ACS
Message-ID: <20250922200654.1d4ff8b8.alex.williamson@redhat.com>
In-Reply-To: <e9d4f76a-5355-4068-a322-a6d5c081e406@redhat.com>
References: <0-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
	<20250922163947.5a8304d4.alex.williamson@redhat.com>
	<e9d4f76a-5355-4068-a322-a6d5c081e406@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 21:44:27 -0400
Donald Dutile <ddutile@redhat.com> wrote:

> On 9/22/25 6:39 PM, Alex Williamson wrote:
> > On Fri,  5 Sep 2025 15:06:15 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> >> The series patches have extensive descriptions as to the problem and
> >> solution, but in short the ACS flags are not analyzed according to the
> >> spec to form the iommu_groups that VFIO is expecting for security.
> >>
> >> ACS is an egress control only. For a path the ACS flags on each hop only
> >> effect what other devices the TLP is allowed to reach. It does not prevent
> >> other devices from reaching into this path.
> >>
> >> For VFIO if device A is permitted to access device B's MMIO then A and B
> >> must be grouped together. This says that even if a path has isolating ACS
> >> flags on each hop, off-path devices with non-isolating ACS can still reach
> >> into that path and must be grouped gother.
> >>
> >> For switches, a PCIe topology like:
> >>
> >>                                 -- DSP 02:00.0 -> End Point A
> >>   Root 00:00.0 -> USP 01:00.0 --|
> >>                                 -- DSP 02:03.0 -> End Point B
> >>
> >> Will generate unique single device groups for every device even if ACS is
> >> not enabled on the two DSP ports. It should at least group A/B together
> >> because no ACS means A can reach the MMIO of B. This is a serious failure
> >> for the VFIO security model.
> >>
> >> For multi-function-devices, a PCIe topology like:
> >>
> >>                    -- MFD 00:1f.0 ACS not supported
> >>    Root 00:00.00 --|- MFD 00:1f.2 ACS not supported
> >>                    |- MFD 00:1f.6 ACS = REQ_ACS_FLAGS
> >>
> >> Will group [1f.0, 1f.2] and 1f.6 gets a single device group. However from
> >> a spec perspective each device should get its own group, because ACS not
> >> supported can assume no loopback is possible by spec.  
> > 
> > I just dug through the thread with Don that I think tries to justify
> > this, but I have a lot of concerns about this.  I think the "must be
> > implemented by Functions that support peer-to-peer traffic with other
> > Functions" language is specifying that IF the device implements an ACS
> > capability AND does not implement the specific ACS P2P flag being
> > described, then and only then can we assume that form of P2P is not
> > supported.  OTOH, we cannot assume anything regarding internal P2P of an
> > MFD that does not implement an ACS capability at all.
> >   
> The first, non-IF'd, non-AND'd req in PCIe spec 7.0, section 6.12.1.2 is:
> "ACS P2P Request Redirect: must be implemented by Functions that
> support peer-to-peer traffic with other Functions. This includes
> SR-IOV Virtual Functions (VFs)." There is not further statement about
> control of peer-to-peer traffic, just the ability to do so, or not.
> 
> Note: ACS P2P Request Redirect.
> 
> Later in that section it says:
> ACS P2P Completion Redirect: must be implemented by Functions that
> implement ACS P2P Request Redirect.
> 
> That can be read as an 'IF Request-Redirect is implemented, than ACS
> Completion Request must be implemented. IOW, the Completion Direct
> control is required if Request Redirect is implemented, and not
> necessary if Request Redirect is omitted.
> 
> If ACS P2P Require Redirect isn't implemented, than per the first
> requirement for MFDs, the PCIe device does not support peer-to-peer
> traffic amongst its function or virtual functions.
> 
> It goes on...
> ACS Direct Translated P2P: must be implemented if the Function
> supports Address Translation Services (ATS) and also peer-to-peer
> traffic with other Functions.
> 
> If an MFD does not do peer-to-peer, and P2P Request Redirect would be
> implemented if it did, than this ACS control does not have to be
> implemented either.
> 
> Egress control structures are either optional or dependent on Request
> Redirect &/or Direct Translated P2P control, which have been
> addressed above as not needed if on peer-to-peer btwn functions in an
> MFD (and their VFs).
> 
> 
> Now, if previous PCIe spec versions (which I didn't read & re-read &
> re-read like the 6.12 section of PCIe spec 7.0) had more IF and ANDs,
> than that could be cause for less than clear specmanship enabling
> vendors of MFDs to yield a non-PCIe-7.0 conformant MFD wrt ACS
> structures. I searched section 6.12.1.2 for if/IF and AND/and, and
> did not yield any conditions not stated above.

Back up to 6.12.1:

  ACS functionality is reported and managed via ACS Extended Capability
  structures. PCI Express components are permitted to implement ACS
  Extended Capability structures in some, none, or all of their
  applicable Functions. The extent of what is implemented is
  communicated through capability bits in each ACS Extended Capability
  structure. A given Function with an ACS Extended Capability structure
  may be required or forbidden to implement certain capabilities,
  depending upon the specific type of the Function and whether it is
  part of a Multi-Function Device.

What you're quoting are the requirements for the individual p2p
capabilities IF the ACS extended capability is implemented.

Section 6.12.1.1 describing ACS for downstream ports begins:

  This section applies to Root Ports and Switch Downstream Ports that
  implement an ACS Extended Capability structure.

Section 6.12.1.2 for SR-IOV, SIOV and MFDs begins:

  This section applies to Multi-Function Device ACS Functions, with the
  exception of Downstream Port Functions, which are covered in the
  preceding section.

While not as explicit, what is a Multi-Function Device ACS Function if
not a function of a MFD that implements ACS?

> > I believe we even reached agreement with some NIC vendors in the
> > early days of IOMMU groups that they needed to implement an "empty"
> > ACS capability on their multifunction NICs such that they could
> > describe in this way that internal P2P is not supported by the
> > device.  Thanks, 
> In the early days -- gen1->gen3 (2009->2015) I could see that
> happening. I think time (a decade) has closed those defaults to
> less-common quirks. If 'empty ACS' is how they liked to do it back
> than, sure. [A definition of empty ACS may be needed to fully
> appreciate that statement, though.] If this patch series needs to
> support an 'empty ACS' for this older case, let's add it now, or
> follow-up with another fix.

An "empty" ACS capability is an ACS extended capability where the ACS
capability register reads as zero, precisely to match the spec in
indicating that the device does not support p2p.  Again, I don't see
how time passing plays a role here.  A MFD must implement ACS to infer
anything about internal p2p behavior.
 
> In summary, I still haven't found the IF and AND you refer to in
> section 6.12.1.2 for MFDs, so if you want to quote those sections I
> mis-read, or mis-interpreted their (subtle?) existence, than I'm not
> immovable on the spec interpretation.

As above, I think it's covered by 6.12.1 and the introductory sentence
of 6.12.1.2 defining the requirements for ACS functions.  Thanks,

Alex


