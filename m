Return-Path: <linux-pci+bounces-41736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C624BC72951
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D650B28C91
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 07:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164E3043AE;
	Thu, 20 Nov 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nWjD1BwV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7522E1722
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623514; cv=none; b=tMIQWbuMf6x5XarDyG9vOThcWVw8+eBVlH68yj77cqK+Iwh8+uf0ZydKydVFFC44b1WNQFYaOnYawP1tpd9zCpraqapw6DzIrPglv+lL/C7upvyCbRAHq5YbpQ/uLfXUebtOc4fcrIZPNYMGmoYuraApZeqwSI4TIItZA4Ly3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623514; c=relaxed/simple;
	bh=lUpWZ5UX3+i+7u0Pq8QdniaLTA2oaPmgIy1XELFHAHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMOpogNRl1hi5P0V7JLWB9suxzXpUjHVUGAM/q4nRMqOwN3lfZrJ6LIaN2ONtnZfXBete1ZVwsPr4OlPRooXh3+XcTaefa9LtKsu2mHWFciBJ6ntD7ZnE85ihCuz6en8vO5HC4GvBQuFFnUb6FC9yfHJWrgp5Dn0x2raD6hiePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nWjD1BwV; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJNs6th366133
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 23:25:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zJvQf5k4dRgM04NLpARHaBYHJtmHDdIhvwwQscTDcLI=; b=nWjD1BwVWCcA
	F44UuWGoJRhci1nuRD9KZ/TyZTqrWrPfoHuyVNUd+u9cS7yO5S4xmXKskaxDO7qI
	QvWwTkg8dMlIkOUbhnZ6akRRxMj1eA0POoEcppsAHcASvkWqPOzDshYyHlc9Dg4d
	K48OLacjTwqFOdJw7Z2FUWu4rKRjftBzEX1i5mtXvv2dU/iU3lOQXBYBG3As5x2W
	82uU+W7p7vRuH1+oHEseYPAqLojoDAWKDrst1Lp1hgjIo63aelI3fkRHkV/XMRsN
	9Fu9OkK9wgAjb4fGd1wbBFnchSbdXCe8lEfAvF6EBROOPapUEEDrCaa9NaQmyKW5
	F7UTRyZ8TA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ahqymtkm8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 23:25:11 -0800 (PST)
Received: from twshared1848.32.frc3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 20 Nov 2025 07:24:57 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 42A10C5560F5; Wed, 19 Nov 2025 23:24:43 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Date: Wed, 19 Nov 2025 23:24:40 -0800
Message-ID: <20251120072442.2292818-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117160028.GA17968@ziepe.ca>
References: <20251117160028.GA17968@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=O4o0fR9W c=1 sm=1 tr=0 ts=691ec257 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VabnemYjAAAA:8 a=gBoSNsRbln1ruKUd0gAA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: X3sJP5Lv46ld3Vy3UlPPd-hCzE828k1Q
X-Proofpoint-GUID: X3sJP5Lv46ld3Vy3UlPPd-hCzE828k1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA0MiBTYWx0ZWRfX0QWvihsLR3oH
 ycpeebz4nfafOP7knUaNFnPQValFaGQv9MWZlyNy5HW9GD9Y+1MM413A8i/W977FvLzggzDCiDd
 Yt24yd/CtiMYPrr8BwYlB5yuXjR4K2qWcHGolDPoWjPmYcR+2k1DtXym03aJp/NpJQ0zNVlbdNY
 P5EEgV1GrAuexBFu4oZHZhxV4UQEhwAmBJHgMZ9kVgjFJ5ui+STLoOBDwYELqRDwJQokfU7iSKY
 WWnUrM7M3gKrRkKT8n2IG1MGB/kUXdpXxSWrnJh9WlkwPlDkHtxAou5wGyfq+SdcujOKn2qhdU1
 761IZlRIDtbr/zH8XWBCCpd4v/TzerD/DlFv4vwDafWs6UNBjMkBtxb678cpTWBtdgYkrW7k4fm
 AvW3pkke5CBpUlCr6S77EEhSPcvgTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01

On Monday, November 17, 2025 at 8:00=E2=80=AFAM, Jason Gunthorpe wrote:
> Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
>
> On Thu, Nov 13, 2025 at 01:37:12PM -0800, Zhiping Zhang wrote:
> > RDMA: Set steering-tag value directly in DMAH struct for DMABUF MR
> >
> > This patch enables construction of a dma handler (DMAH) with the P2P =
memory type
> > and a direct steering-tag value. It can be used to register a RDMA me=
mory
> > region with DMABUF for the RDMA NIC to access the other device's memo=
ry via P2P.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> > .../infiniband/core/uverbs_std_types_dmah.c   | 28 ++++++++++++++++++=
+
> > drivers/infiniband/core/uverbs_std_types_mr.c |  3 ++
> > drivers/infiniband/hw/mlx5/dmah.c             |  5 ++--
> > .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 12 +++++---
> > include/linux/mlx5/driver.h                   |  4 +--
> > include/rdma/ib_verbs.h                       |  2 ++
> > include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
> > 7 files changed, 46 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/driver=
s/infiniband/core/uverbs_std_types_dmah.c
> > index 453ce656c6f2..1ef400f96965 100644
> > --- a/drivers/infiniband/core/uverbs_std_types_dmah.c
> > +++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
> > @@ -61,6 +61,27 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC=
)(
> >               dmah->valid_fields |=3D BIT(IB_DMAH_MEM_TYPE_EXISTS);
> >       }
> >
> > +     if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_DIRECT_S=
T_VAL)) {
> > +             ret =3D uverbs_copy_from(&dmah->direct_st_val, attrs,
> > +                                    UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST=
_VAL);
> > +             if (ret)
> > +                     goto err;
>
> This should not come from userspace, the dmabuf exporter should
> provide any TPH hints as part of the attachment process.
>=20
> We are trying not to allow userspace raw access to the TPH values, so
> this is not a desirable UAPI here.
>
> Jason

Thanks for your feedback!

I understand the concern about not exposing raw TPH values to userspace.
To clarify, would it be acceptable to use an index-based mapping table,=20
where userspace provides an index and the kernel translates it to the=20
appropriate TPH value? Given that the PCIe spec allows up to 16-bit TPH v=
alues,
this could require a mapping table of up to 128KB. Do you see this as a r=
easonable
approach, or is there a preferred alternative?

Additionally, in cases where the dmabuf exporter device can handle all po=
ssible 16-bit
TPH values  (i.e., it has its own internal mapping logic or table), shoul=
d this still be
entirely abstracted away from userspace?

Zhiping

