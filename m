Return-Path: <linux-pci+bounces-41471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B170C66B3B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 01:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CC83129715
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 00:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F2944F;
	Tue, 18 Nov 2025 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OlKqWkhC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0E1C2334
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427020; cv=none; b=DRWxi5HiFzZwYrLXWklzyUZvGdEKYdYly6aTIVVbAFIiVxoA8/J5ZMBCJjnLBdaHuXFLH1spIe73x/hBskUE/8EDq9DKJGcGHKIsKsFtJP2R5xZM7Xk40UibaDixbYX6Cxuh5G5SHIXoenIzD6NiKRsg7Esx9HGUftFjz0PmJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427020; c=relaxed/simple;
	bh=gHS/Eg1xPCcRUqB7YMbxuhHmVgSNi2IWCXXJ0dykZng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mp5ABHKhVrHxsgiPZ4k3A0R15V/sVIq3OgWEFz2vHjI16PW0t531nkSG8pA0b96I+/jklbXDajTh/P79AWl8dbiLmJVH4HBG6FpXX9fE5VG2ljhMroturxIt0ElfBl/dPSRa+96pKCoQOGjuM+Shd2bAmEECOGsVQZFaSwYFYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OlKqWkhC; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHLm0Wd3852206
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 16:50:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=K984MT1BI8AsKR90UtDQZfW+zUX5Q/Uf71qK2FmsDdo=; b=OlKqWkhC7au8
	rsRERnOWkZ1JBrcgPX6tXoR1ZjiZhpDjUL/GGlCRoo1CEn+penMwj6x96Pvi5TXE
	rONHC3ISgwbXtX2D/twGG/bS9Eu4S97cZCte4Mfcdls2+HW4tRvz7nLIRaWau0sv
	PUrJKWk0JHKbuHJm0yokoD+S/hyC7GmRkKGQhMynm2xQw+zzMLBfB120/2gZ7Wh4
	sJEBvbmNtYXbKjazhh66EUJIOVDkHALsoAnmem10EGeTZV/nw3ulaFVAbKwiFMBk
	1G4Qc41ZWlOmRbiaebPhsRwjwuJB6U9ZegtwM8R/gOC/OmU9ffFr7ZdJnFSf7kNx
	NeGZcwlV8g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ag7w3ut8h-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 16:50:17 -0800 (PST)
Received: from twshared12874.03.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 18 Nov 2025 00:50:15 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id E597DC3DF760; Mon, 17 Nov 2025 16:50:05 -0800 (PST)
From: <zhipingz@meta.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kbusch@kernel.org>, <yochai@nvidia.com>,
        <yishaih@nvidia.com>
Subject: Re: [RFC 1/2] Set steering-tag directly for PCIe P2P memory access
Date: Mon, 17 Nov 2025 16:50:01 -0800
Message-ID: <20251118005005.1473648-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114131232.00006e9e@huawei.com>
References: <20251114131232.00006e9e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDAwNCBTYWx0ZWRfXyKsR4s9bYjwP
 9MEPd6VfY31iYuJ1UdwaMFOclR5U1YlRdR1z3Y4c5AYOyIt6oaz63476RiFDbrtHzDzK4wz3ZY5
 u9o0f5HNHa3p5TomvZbD0aghvMhcT5I+sHGQFYzewh/zyH83CT68+SoE0j1ABMJU/WX3Mw5lpdF
 S6D66qbOmJ3dA21GrtiGgvLNsNRBkprSVGJy1ib2DkJ/urkDjkKNrvxaxsZ7vbtsiKf78QHm6Qt
 TQGWWYrl87Vr6+siWgYeYj4w3lAo1sHHPKCqTiYq5oU+XbfS24zLqXd0EIsMDkbym3xWZlbou3x
 12WuEX9piPkgbH5MXQfxRq6U38i1e2Hoc3Fhtjgv2/wE46r8GUJL0mxSx6HAat7mvtHkklE/snT
 mvuUx4fgfiWMHZwUz5DRtyhn/gWUKQ==
X-Proofpoint-ORIG-GUID: 3k4UNhTtn5z8O7EmkUdMD3PZ3aYcyUVj
X-Authority-Analysis: v=2.4 cv=Zsfg6t7G c=1 sm=1 tr=0 ts=691bc2c9 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=S7gPgYD2AAAA:8 a=VabnemYjAAAA:8 a=tBecTD8rVLH8ZP6GYt4A:9 a=QEXdDO2ut3YA:10
 a=1f8SinR9Uz0LDa1zYla5:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 3k4UNhTtn5z8O7EmkUdMD3PZ3aYcyUVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01

> From: Jonathan Cameron @ 2025-11-14 13:12 UTC (permalink / raw)
>  To: Zhiping Zhang
>  Cc: Jason Gunthorpe, Leon Romanovsky, Bjorn Helgaas, linux-rdma,
>	linux-pci, netdev, Keith Busch, Yochai Cohen, Yishai Hadas
>
> On Thu, 13 Nov 2025 13:37:11 -0800
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > PCIe: Add a memory type for P2P memory access
> >=20
> > The current tph memory type definition applies for CPU use cases. For=
 device
> > memory accessed in the peer-to-peer (P2P) manner, we need another mem=
ory
> > type.
> >=20
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/pci/tph.c       | 4 ++++
> >  include/linux/pci-tph.h | 4 +++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index cc64f93709a4..d983c9778c72 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -67,6 +67,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_ty=
pe, u8 req_type,
> > 			if (info->pm_st_valid)
> > 				return info->pm_st;
> > 			break;
> > +		default:
> > +			return 0;
> > 		}
> > 		break;
> > 	case PCI_TPH_REQ_EXT_TPH: /* 16-bit tag */
> > @@ -79,6 +81,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_ty=
pe, u8 req_type,
> > 			if (info->pm_xst_valid)
> > 				return info->pm_xst;
> > 			break;
> > +		default:
> > +			return 0;
> > 		}
> > 		break;
> > 	default:
> > diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> > index 9e4e331b1603..b989302b6755 100644
> > --- a/include/linux/pci-tph.h
> > +++ b/include/linux/pci-tph.h
> > @@ -14,10 +14,12 @@
> >   * depending on the memory type: Volatile Memory or Persistent Memor=
y. When a
> >   * caller query about a target's Steering Tag, it must provide the t=
arget's
> >   * tph_mem_type. ECN link: https://members.pcisig.com/wg/PCI-SIG/doc=
ument/15470.
> > + * Add a new tph type for PCI peer-to-peer access use case.
> >   */
> >  enum tph_mem_type {
> >  	TPH_MEM_TYPE_VM,	/* volatile memory */
> > -	TPH_MEM_TYPE_PM		/* persistent memory */
> > +	TPH_MEM_TYPE_PM,	/* persistent memory */
> > +	TPH_MEM_TYPE_P2P	/* peer-to-peer accessable memory */
>
> Trivial but this time definitely add the trailing comma!  Maybe there w=
ill never
> be any more in here but maybe there will and we can avoid a line of
> churn next time.
>

Thanks for catching that! I=E2=80=99ll add the trailing comma to the enum=
 in the patch.

> >  };
> > =20
> >  #ifdef CONFIG_PCIE_TPH


