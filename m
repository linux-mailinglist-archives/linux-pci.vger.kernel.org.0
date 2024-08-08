Return-Path: <linux-pci+bounces-11478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E9A94B970
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 11:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2091DB20F39
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5D145FE0;
	Thu,  8 Aug 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKyXfAJp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C318D63E;
	Thu,  8 Aug 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107784; cv=none; b=nhOP9QFu7cJ4ohi6IPhOwVwmqEE+NMHLj95cmnIG02Z6tsLpfzsTsF4zOwo/HiBcgIfv00luh1Tg84PGkvUXC+8fRRygqtJdh4gf7rMOc8V1Ttzpzj6sp6QgE3bDRenZ5H+/5W+tGKM6xBmVCnhBe52085nj5HJJbECuYvIsp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107784; c=relaxed/simple;
	bh=/AWqpolpgqyfgf35iEEQKqgmGWgN/S+xvUFXlCHA35w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DvXrtUmISBimbnGcBJIV/JzWC7154UVyJs124TjvZvCeIGN7Q4jGL2meHnpr7gmQCgGjzU1ktgtP0i4Hq5UCFQs/dzIWxnE/YR0/YQrIeVPW9Pfi4lAM/FuN84umY/U6zDeZZXjERdvjroKeytprCqkheM/cAPu+9oXkRgDz9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKyXfAJp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723107783; x=1754643783;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/AWqpolpgqyfgf35iEEQKqgmGWgN/S+xvUFXlCHA35w=;
  b=MKyXfAJp2CVoXrYJJdhooj3kF5l/bLyAXy6sZtV9U3Wa+yB+AuCDoex9
   vMV2DGo8w6n78vq2+ThHkYM1mn7PSpTfHFOFmY6imdy7EF6MTYJHI909u
   7ugElqQdJRP+IQJKmMZuVKkNN/96I0v3x+3lLPoYx1Y9vbppapWo+RF1U
   9uO7EGhk6M7ksJKP+IwwwCOBGRo7L0BNDPyBCaNHBhBoufhCUskhbKq59
   z5hbySSKH8v2aF8rVIqSA4hIW0ebx6nUf7RLaYvNzb3N+NdbYNKvBUpXd
   dFrkBpyfnbKh0S3H4QGaHgQ+QhVLpiv3ubPm59QqxzgR3z6y5aFUBxTW8
   w==;
X-CSE-ConnectionGUID: AvDZmiUkQRiKQA8Jp1nLAg==
X-CSE-MsgGUID: IfaciyGzSKWWG5fRBLRIig==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21388436"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21388436"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:03:02 -0700
X-CSE-ConnectionGUID: yCnD/tp4SGaQMdUPh2+4uw==
X-CSE-MsgGUID: xNQqgQJbS8y8BW1e7Nst5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="94701705"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.125.108.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:02:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Aug 2024 12:02:54 +0300 (EEST)
To: Alistair Francis <alistair23@gmail.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    Jonathan.Cameron@huawei.com, Lukas Wunner <lukas@wunner.de>, 
    alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, logang@deltatee.com, 
    LKML <linux-kernel@vger.kernel.org>, chaitanyak@nvidia.com, 
    rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v15 2/4] PCI/DOE: Rename Discovery Response Data Object
 Contents to type
In-Reply-To: <CAKmqyKNiT=yDw0ScwAxODpaQ-0fJRM5eEBxGTpbTe22N-UAfNQ@mail.gmail.com>
Message-ID: <ef1cc514-bf44-13b6-da86-2e442fdb6df7@linux.intel.com>
References: <20240806230118.1332763-1-alistair.francis@wdc.com> <20240806230118.1332763-2-alistair.francis@wdc.com> <cbc54dfb-6699-ae15-f40e-d3b5969fc806@linux.intel.com> <CAKmqyKNiT=yDw0ScwAxODpaQ-0fJRM5eEBxGTpbTe22N-UAfNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-72770772-1723107774=:1044"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-72770772-1723107774=:1044
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 8 Aug 2024, Alistair Francis wrote:

> On Wed, Aug 7, 2024 at 6:03=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Wed, 7 Aug 2024, Alistair Francis wrote:
> >
> > > PCIe r6.1 (which was published July 24) describes a "Vendor ID", a
> > > "Data Object Type" and "Next Index" as the fields in the DOE
> > > Discovery Response Data Object. The DOE driver currently uses
> > > both the terms type and prot for the second element.
> > >
> > > This patch renames all uses of the DOE Discovery Response Data Object
> > > to use type as the second element of the object header, instead of
> > > type/prot as it currently is.
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> >
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_r=
egs.h
> > > index 94c00996e633..795e49304ae4 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -1146,9 +1146,12 @@
> > >  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX         0x000000ff
> > >  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER           0x0000ff00
> > >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID           0x0000ffff
> > > -#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL              0x00ff0=
000
> > > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE          0x00ff0000
> >
> > This change (removal of the old define) is inside UAPI header, so it do=
es
> > seem something that is not allowed.
> >
> > >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX    0xff000000
> > >
> > > +/* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3=
_TYPE */
> > > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL              PCI_DOE=
_DATA_OBJECT_DISC_RSP_3_TYPE
>=20
> The old define is kept here though

Ah sorry, I didn't realize it despite the comment...

--=20
 i.

--8323328-72770772-1723107774=:1044--

