Return-Path: <linux-pci+bounces-36987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D1EBA065E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD552A5BFC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8001DE4E0;
	Thu, 25 Sep 2025 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwFT5Gqq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73CD2F83B2
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814832; cv=none; b=W+DcY7OInNx7kxRN12vQvdB+G8FOYCjYhNYOtih5bsF0p1EofvCEXc7el+J0+DvknPm8rfWnUPmilP+07bdrH0uG7MonamN+/ZDb1mAPztG20XSJgizkqbqQRP48PqBfVcvI8rYJdKTsSVgJewwLLOZDims+nZ/Fz/NsVtm21cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814832; c=relaxed/simple;
	bh=7YEhsqL9ZLZQxeM49v3cxD1CeAceGyKQczMB4/6Sgw4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hG+TcAXfca+ernX3dWUktLQB+VcCAI+43bJDDl9a4hN7C5XNok+L6VK3YLTFxLVwEDVjXAPZqqDGmviCsuUL8ddjhMV7aXx9Xg5CwZhIfDpEfNMKZ+umu0PnHzw5eXCMiYN7vTAEVdy0Rvpsw9+Rmap6A4pJ1jHq8+aQ7g3HbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwFT5Gqq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758814831; x=1790350831;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7YEhsqL9ZLZQxeM49v3cxD1CeAceGyKQczMB4/6Sgw4=;
  b=fwFT5GqqfzZV3i3i51yth5LZu+w7X1Vlg2WPUfE5CpqKkoBG63DEB+4B
   fzqc73548f+19glEOy40GpFsFbtbZ6xG9dPo3gE1hZoJPb+1FfUCa4+iq
   hihSJ83ly+G2iHqhey4Nrs8BvXlcM8WvL7BtsFU9tSszSuEy3tTkI/hj1
   cghjYtg6byd+1cdO0JMIdK1X7SMkorZRrOqXsq6z1Ayewab3POFv5/ZI9
   Gtsc6V+Q/mvRUv/2nouweCubS+dlOwiqaOQOIiQlzKGqxyBrCkm7fHwXi
   cI9HQnWv9cMOiazL/GMLBX7wK9eDTibis0E7d2VrQbR4bK+GYu++xV97W
   Q==;
X-CSE-ConnectionGUID: 1LosVtE9RHu3qSQ+E10dwg==
X-CSE-MsgGUID: kV1b2DHAQKy9zPgBWoWI8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71822626"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="71822626"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:40:30 -0700
X-CSE-ConnectionGUID: 3xmOTkNmRlCC0J35HwgroA==
X-CSE-MsgGUID: FrXyVz0qRt2xnvOYqNXkng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="178116058"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.244.100]) ([10.245.244.100])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:40:28 -0700
Message-ID: <62d722e45981fbf2e86f59aa3978be5b230b0a4a.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, Simona Vetter	 <simona.vetter@ffwll.ch>,
 "dri-devel@lists.freedesktop.org"	 <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org"	 <intel-xe@lists.freedesktop.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 25 Sep 2025 17:40:25 +0200
In-Reply-To: <20250925133323.GZ2617119@nvidia.com>
References: <20250923131247.GK1391379@nvidia.com>
	 <8da25244-be1e-4d88-86bc-5a6f377bdbc1@amd.com>
	 <20250923133839.GL1391379@nvidia.com>
	 <5f9f8cb6-2279-4692-b83d-570cf81886ab@amd.com>
	 <IA0PR11MB71855457D1061D0A2344A5CFF81CA@IA0PR11MB7185.namprd11.prod.outlook.com>
	 <1d9065f3-8784-4497-b92c-001ae0e78b63@amd.com>
	 <IA0PR11MB7185239DB2331A899561AA7DF81FA@IA0PR11MB7185.namprd11.prod.outlook.com>
	 <ab09c09638c4482f99047672680c247b98c961c9.camel@linux.intel.com>
	 <50c946f3-08c5-421e-80bf-61834a58eddf@amd.com>
	 <f646f5e281e0f53656847ad4eddc3cc215c684f5.camel@linux.intel.com>
	 <20250925133323.GZ2617119@nvidia.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-25 at 10:33 -0300, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 03:11:50PM +0200, Thomas Hellstr=C3=B6m wrote:
> > On Thu, 2025-09-25 at 13:28 +0200, Christian K=C3=B6nig wrote:
> > > On 25.09.25 12:51, Thomas Hellstr=C3=B6m wrote:
> > > > > > In that case I strongly suggest to add a private DMA-buf
> > > > > > interface
> > > > > > for the DMA-
> > > > > > bufs exported by vfio-pci which returns which BAR and
> > > > > > offset
> > > > > > the
> > > > > > DMA-buf
> > > > > > represents.
> > > >=20
> > > > @Christian, Is what you're referring to here the "dma_buf
> > > > private
> > > > interconnect" we've been discussing previously, now only
> > > > between
> > > > vfio-
> > > > pci and any interested importers instead of private to a known
> > > > exporter
> > > > and importer?
> > > >=20
> > > > If so I have a POC I can post as an RFC on a way to negotiate
> > > > such
> > > > an
> > > > interconnect.
> > >=20
> > > I was just about to write something up as well, but feel free to
> > > go
> > > ahead if you already have something.
> >=20
> > Just posted a POC. It might be that you have better ideas, though.
>=20
> I think is also needs an API that is not based on scatterlist. Please
> lets not push a private interconnect address through the scatterlist
> dma_addr_t!

I think that needs to be defined per interconnect, choosing a data
structure that suits best. Although I find it reasonable to mandate
dma_addr_t or scatterlists to *not* be used.

This merely focuses on the interconnect negotiation itself.

>=20
> Assuming that you imagine we'd define some global well known
> interconnect
>=20
> 'struct blah pci_bar_interconnect {..}'
>=20
> And if that is negotiated then the non-scatterlist communication
> would
> give the (struct pci_dev *, bar index, bar offset) list?

Yes something like that. Although I think perhaps the dev + bar index
might be part of the negotiation, so that it is rejected if the
importer feels that there is no implied PF + VF interconnect. Then the
list would be reduced to only the offset.

Still I think Vivek would be better to figure the exact negotiation and
data structure out.
=20
/Thomas

>=20
> I think this could solve the kvm/iommufd problems at least!
>=20
> Jason


