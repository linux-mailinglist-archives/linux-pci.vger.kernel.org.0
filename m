Return-Path: <linux-pci+bounces-36944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C405BB9F72E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5313B2714
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061FA217716;
	Thu, 25 Sep 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K76m1nAO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659E1C8611
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805917; cv=none; b=TA4rYtdGq+E1CGEngG2mcHd3vUfPhPjlv1NXYGKwfoTrbp3FILG7Hf5IKmEpqL3lHpTlx9P2gd7+5FB20exSWlieY9cXDbvgvKl91W0jWZzOuU+cGVwolJpD8juOJm2O5HVgSO381o7niKSQ7rmxSH+OVtNWUIa+ZNKQhaCM1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805917; c=relaxed/simple;
	bh=y7cqJIPsUWM5zsNy85LeufXZZ/OSw5x6xSz2Ml5X5p4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZbJlbawYErtMOgzNyd2mlHuZRzCZj/dJG3DK2pOZYJn5Qk17mLkpwUAPIxgtan+D78cxrLxzIJ7lEaJHyrHKm0b9n1WXx+QmvsXBOwGVC6dvVBy9tG6I75/Rgld+PtIgMdg7GRgJDS1BTtNZZ8YOjqG7YijcYVi5y2Y5tQDnYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K76m1nAO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758805916; x=1790341916;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=y7cqJIPsUWM5zsNy85LeufXZZ/OSw5x6xSz2Ml5X5p4=;
  b=K76m1nAOPJ7VjDRK3Spf6FMSvvEFZ33uhBfmI8i6NdqTunTXItrBwXCZ
   9IztY8hAdux9oXXcUDdD9arlADB2dwH5cVeCGImUgdFmdgdhgTSUOz49S
   PoR9we+Zjec3Ef5IGSZOhonW1MIS73gmv3qjaueKS0udDhZgLwFywUFr5
   RH8+pF4wSo2wVHCPfb1llwLZVdxAf5oCT6/a3sXysM2E4fJ1be+Il8DvM
   +t+g+5RQDPueMaBWFKGnO3D1DqhneDhpE1Dzz+vmBELpGAjo9rgXr/wb4
   ltoQ3zr/yF3aE7x2D+rQLSgUJ9vqTPRiGgi/OFRt5v0vnG/4XtuK0YKuz
   w==;
X-CSE-ConnectionGUID: wgqjQuLoRpS89kmLC4yULw==
X-CSE-MsgGUID: QBvMVQ7nQKqahOKtBUjYBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61010838"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61010838"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 06:11:55 -0700
X-CSE-ConnectionGUID: 8v36/uDlR/2DNpCPEo0kug==
X-CSE-MsgGUID: cKSxaADzSaa6gV0Pl3tWtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181335788"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.244.100]) ([10.245.244.100])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 06:11:52 -0700
Message-ID: <f646f5e281e0f53656847ad4eddc3cc215c684f5.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, Jason Gunthorpe
 <jgg@nvidia.com>
Cc: "Brost, Matthew" <matthew.brost@intel.com>, Simona Vetter	
 <simona.vetter@ffwll.ch>, "dri-devel@lists.freedesktop.org"	
 <dri-devel@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"	
 <intel-xe@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Date: Thu, 25 Sep 2025 15:11:50 +0200
In-Reply-To: <50c946f3-08c5-421e-80bf-61834a58eddf@amd.com>
References: <045c6892-9b15-4f31-aa6a-1f45528500f1@amd.com>
	 <20250922122018.GU1391379@nvidia.com>
	 <IA0PR11MB718580B723FA2BEDCFAB71E9F81DA@IA0PR11MB7185.namprd11.prod.outlook.com>
	 <aNI9a6o0RtQmDYPp@lstrano-desk.jf.intel.com>
	 <aNJB1r51eC2v2rXh@lstrano-desk.jf.intel.com>
	 <80d2d0d1-db44-4f0a-8481-c81058d47196@amd.com>
	 <20250923121528.GH1391379@nvidia.com>
	 <522d3d83-78b5-4682-bb02-d2ae2468d30a@amd.com>
	 <20250923131247.GK1391379@nvidia.com>
	 <8da25244-be1e-4d88-86bc-5a6f377bdbc1@amd.com>
	 <20250923133839.GL1391379@nvidia.com>
	 <5f9f8cb6-2279-4692-b83d-570cf81886ab@amd.com>
	 <IA0PR11MB71855457D1061D0A2344A5CFF81CA@IA0PR11MB7185.namprd11.prod.outlook.com>
	 <1d9065f3-8784-4497-b92c-001ae0e78b63@amd.com>
	 <IA0PR11MB7185239DB2331A899561AA7DF81FA@IA0PR11MB7185.namprd11.prod.outlook.com>
	 <ab09c09638c4482f99047672680c247b98c961c9.camel@linux.intel.com>
	 <50c946f3-08c5-421e-80bf-61834a58eddf@amd.com>
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

On Thu, 2025-09-25 at 13:28 +0200, Christian K=C3=B6nig wrote:
> On 25.09.25 12:51, Thomas Hellstr=C3=B6m wrote:
> > > > In that case I strongly suggest to add a private DMA-buf
> > > > interface
> > > > for the DMA-
> > > > bufs exported by vfio-pci which returns which BAR and offset
> > > > the
> > > > DMA-buf
> > > > represents.
> >=20
> > @Christian, Is what you're referring to here the "dma_buf private
> > interconnect" we've been discussing previously, now only between
> > vfio-
> > pci and any interested importers instead of private to a known
> > exporter
> > and importer?
> >=20
> > If so I have a POC I can post as an RFC on a way to negotiate such
> > an
> > interconnect.
>=20
> I was just about to write something up as well, but feel free to go
> ahead if you already have something.

Just posted a POC. It might be that you have better ideas, though.


/Thomas


