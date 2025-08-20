Return-Path: <linux-pci+bounces-34371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB1B2D827
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BC2721CBA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791102DFA38;
	Wed, 20 Aug 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ohtYdNEQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1922579E;
	Wed, 20 Aug 2025 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681560; cv=none; b=bgGP4xI+UZkzVsQvn4wJrYUTWEj2rbKzw6zGdHblxYOaEKTyWYwvk7Q1BCARmLcxi7fF3mdlAbnNL4vVsWauOFwjZDggeme4qiwE8npqHvECHltKrjh7IBrOVoW+BUxO1gdtvaDl38r2+3rTVY6bQWxltVXzsfNfz33bZPbS7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681560; c=relaxed/simple;
	bh=yxaIXoKVYeelx227mioum5SrmxAfhHL8SyrI78nxSEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jVrjf4yVk1CfeiazbJ2R6cY9TY7ZEClGalcoG1vs9ANpRZLFmlkTNm7uKNJEBABWNYvsogUcQ9y/4E2mDcNl4i/LQDwfKWYVpZflXpJXnegQbZhglaPMz9CZRRGV6lg8ofor3C4RD+PojpW/iKAFvas/DoCVMv2mhmnV4fPfzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ohtYdNEQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNm6je011904;
	Wed, 20 Aug 2025 09:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B6uijq
	u3UzW9BI2Ce+LrWvtBEqM5lN9mu+9SVFUyuuQ=; b=ohtYdNEQUj4pYJoR4Cs5nM
	jQTzsrru0lUGGgiHf6x87ws9nlVQDaBglZX1ccrjCJWUS9ixcfkhSSYGh0xT+x55
	hdjZQ9zcCqs+W8vDkngKSupAmQBNiWnFG+B4K08VcZAQNzAFVILfZZpZ2/eFaFxq
	lVNcDST5JcCuu1xCkwYuC5j58sk3+wTstLVTDT0y27+XMlHLTStomSd4SUypXbxR
	P/irSBeD2gcloj5ARUS4lzLkFCX9pbNox5/+b1aXPnw0A4VLdH0c07eM1Ix4aaCO
	zHmxnv5C+aW/1exQM+ERineMN0ubqIdYibNGSiK2SRdNHFt46FyZeK+XAclyuNuA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38va2js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:19:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57K9JA8C014557;
	Wed, 20 Aug 2025 09:19:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38va2jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:19:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57K505TG016018;
	Wed, 20 Aug 2025 09:19:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my422m3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:19:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57K9J7dO48693666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 09:19:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDF9120049;
	Wed, 20 Aug 2025 09:19:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF04520040;
	Wed, 20 Aug 2025 09:19:07 +0000 (GMT)
Received: from [9.152.224.87] (unknown [9.152.224.87])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Aug 2025 09:19:07 +0000 (GMT)
Message-ID: <353d1dc7e3c4e9b5f127ac9177a863d8a8cde39f.camel@linux.ibm.com>
Subject: Re: [PATCH v15 1/6] PCI: Clean up __pci_find_next_cap_ttl()
 readability
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
        jingoohan1@gmail.com, mani@kernel.org
Cc: robh@kernel.org, ilpo.jarvinen@linux.intel.com, schnelle@linux.ibm.com,
        lukas@wunner.de, arnd@kernel.org, geert@linux-m68k.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 20 Aug 2025 11:19:07 +0200
In-Reply-To: <20250813144529.303548-2-18255117159@163.com>
References: <20250813144529.303548-1-18255117159@163.com>
	 <20250813144529.303548-2-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jNvYtlxzmnSVTPRMRPIh6Oau072Cl6SZ
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a5930f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=BGCEjKcQT-SkztS5gqMA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX40yHxzNV/pv2
 4HcAvQ3jHti8C0rDaf71tPBrB5WxfmHQAmigkzLeK3jFzseO3P2OZfzzkqtVrcpzYlMEPO+NRBc
 c2v14I089Opn18wlBoF9ecYqGxvBo8dZCmiaPHAgbuJILBQJS8wad99RWCTYqVNhp/V4cf5ZdLk
 yDLQ+S+6+KIubMr1SUddB2gUQjICAN0AlhrLkPV6j20UZ30i/tV29XjAl/Pwk6bivskT7zFXFa6
 N5tNBjWkaNMDkZ8yPbUq9xaZnYLTGJT3IxupoaOqEwDgJXIrUXBAvJEfj2Q3RGJWf+ixhC4WZ3O
 uB7nBwEu75lZtBMVWym0pl/v47fEuZBE6kBC4tHu8zzxtpJJTfiUDM4q1I/uCuqqqd/k+DHBQ3N
 XJcACgmMnbZVvuKcM4TSkNbTZQGzkA==
X-Proofpoint-ORIG-GUID: f2tGAf0Lm2ajHpvep3oaoeiMdfCXOSDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

On Wed, 2025-08-13 at 22:45 +0800, Hans Zhang wrote:
> Refactor the __pci_find_next_cap_ttl() to improve code clarity:
> - Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
> - Use ALIGN_DOWN() for position alignment instead of manual bitmask.
> - Extract PCI capability fields via FIELD_GET() with standardized masks.
> - Add necessary headers (linux/align.h).
>=20
> No functional changes intended.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/pci.c             | 9 +++++----
>  include/uapi/linux/pci_regs.h | 3 +++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..40a5c87d9a6b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -9,6 +9,7 @@
>   */
> =20
>  #include <linux/acpi.h>
> +#include <linux/align.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -432,17 +433,17 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus *b=
us, unsigned int devfn,
>  	pci_bus_read_config_byte(bus, devfn, pos, &pos);
> =20
>  	while ((*ttl)--) {
> -		if (pos < 0x40)
> +		if (pos < PCI_STD_HEADER_SIZEOF)
>  			break;
> -		pos &=3D ~3;
> +		pos =3D ALIGN_DOWN(pos, 4);
>  		pci_bus_read_config_word(bus, devfn, pos, &ent);
> =20
> -		id =3D ent & 0xff;
> +		id =3D FIELD_GET(PCI_CAP_ID_MASK, ent);
>  		if (id =3D=3D 0xff)
>  			break;
>  		if (id =3D=3D cap)
>  			return pos;
> -		pos =3D (ent >> 8);
> +		pos =3D FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
>  	}
>  	return 0;
>  }
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index f5b17745de60..1bba99b46227 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -207,6 +207,9 @@
> =20
>  /* Capability lists */
> =20
> +#define PCI_CAP_ID_MASK		0x00ff	/* Capability ID mask */
> +#define PCI_CAP_LIST_NEXT_MASK	0xff00	/* Next Capability Pointer mask */
> +
>  #define PCI_CAP_LIST_ID		0	/* Capability ID */
>  #define  PCI_CAP_ID_PM		0x01	/* Power Management */
>  #define  PCI_CAP_ID_AGP		0x02	/* Accelerated Graphics Port */

Hi Hans,

I like your approach to replace the magic numbers here. If you went
further to replace the single pci_bus_read_config_word() with two
single-byte reads at the appropriate places - for CAP_ID and
CAP_LIST_NEXT - you could even go with the already existing offset
defines PCI_CAP_LIST_ID and PCI_CAP_LIST_NEXT from pci_regs.h.

But that might be a more intricate change and involves more HW accesses
than what it's worth.

So feel free to add my
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>

Thanks,
Gerd

