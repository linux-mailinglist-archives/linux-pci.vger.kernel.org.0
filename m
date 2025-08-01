Return-Path: <linux-pci+bounces-33286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71603B18122
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7B03A769C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 11:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D2A23536A;
	Fri,  1 Aug 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TKivpDyD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059D153598;
	Fri,  1 Aug 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047850; cv=none; b=u74o3NstP4dsRZdK+dTCFqc1Qfa3dpP5Fd/njSzwrYWNV/+JdlzXDhynyr63JPjCGNum8wFqLCZVTW84Iar1YGJc0+9J4TZ+nhg9vO4KafvvpVx15pOFpwescyWzSMapMl23rw4U61n3CeVSnkiOGuic7L/HbGMWANGTYDTqS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047850; c=relaxed/simple;
	bh=RKD7hTjJn7DKyLS2zmc983hzW0AyHzMV/FBpKo16Qs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mk3Qp5gTZ73l5cajF45UBJ0pVzAoLha5DiacRQc58pC0BGvZS+WkSRIGW19oz7XBnCnkHy5Ed6XQYuekktsRLraZ+JdUywwvM/qa5lladA+3u6qPNA/IJWTkTZ7rDZuIAIoHHccoWkKMOhcrtS348TmN9b3yBb5AEDKxKTsx/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TKivpDyD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719gkD8009163;
	Fri, 1 Aug 2025 11:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m0OaO0
	jOVQuvmH7Ckr/opp4IRUlcCS7PuSW4JR+2Igw=; b=TKivpDyDgQ+wVB1W5p04jS
	tIvLirRfQxWwV6jagq+/rlvpAbX9TVn8hUP8R830TDCsPduaJjvGEs6iATIbJpOo
	4CPEDIAldr9WYDrrB+OeGogcv1vuiM6vlvXYp/ZJUEuK+6UTtne57r5JITsL7gE/
	ahvmbM4/ZhWxky0jOJiWXxOmgYUn8zBXmiv98G4UGYM7ft8thBOJIuXolg+kyURo
	jWgsOGalipl6CmN+FO8M9ZdvLt6gf0f39JJtb4BIZ8pe6ddKO237QZ8hl1mx9cbm
	9ZAEw0DgZ8B1NJOjvfvoMYQYXYafbckf8w/ho/UCEj7raPqNtnSd2eUEKhyIXNww
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcggd02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 11:30:32 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 571BPGGY009183;
	Fri, 1 Aug 2025 11:30:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcggcyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 11:30:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5718cAXk017467;
	Fri, 1 Aug 2025 11:30:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r0h9pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 11:30:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571BUR2o34931102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 11:30:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F31920040;
	Fri,  1 Aug 2025 11:30:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FA6F2004D;
	Fri,  1 Aug 2025 11:30:27 +0000 (GMT)
Received: from [9.152.224.87] (unknown [9.152.224.87])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 11:30:27 +0000 (GMT)
Message-ID: <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Hans Zhang
 <hans.zhang@cixtech.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        jingoohan1@gmail.com,
        Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-next
 <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>, geert@linux-m68k.org
Date: Fri, 01 Aug 2025 13:30:27 +0200
In-Reply-To: <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
References: <20250731183944.GA3424583@bhelgaas>
	 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
	 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
	 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
	 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
	 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
	 <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4NCBTYWx0ZWRfX70m2fojqcxai
 EICC7mib8QH9VDJkUZ4SKDtE+Y9f1Be75XYgtOXR9GG2j/ShFkGz/QvtZ2+qxN+i0fJCN4UJ6LH
 fXrkN23Gy2YDlzuy3VRLkXpyd8dBXQDfXMUzTrN0vyZHUwy2Id+loT96EzRs/71KBJIZC1Io6yR
 JSohIL3rdlOfMRGbztFshPp9VLlE0NzrrZCaXeje01dJ3z6w/PmePmURwQctkd2lGKkzg2CP1Xu
 FFc8iExD6/n/YHGlxtplPDw6qQSJ8MNU8oz9E8l7uam1YnY1C+YSfpWgD73D0g3Ij5WsK999O5b
 PB/QDGti1lLH1mcw1dIu9IYHFeuZveKXSqe4sGPrBCVuxMKLHOJHaKa1BlVxTPV2GVg2WmzGew1
 qNUrnZfjbz5sOzT8LXLjHxHbppThbWizvhX7uc+xbfGF5YoEc8DfbHLxYudNDe11gBivBsN1
X-Proofpoint-ORIG-GUID: nYq4ES_YWcwOS98pyI2g0tFOHFjpKKjx
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=688ca558 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Y6fvskrGHag37onZn_kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1RwGEQaUpfVMdxhJNB9DVmx4MFTmS8XT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010084

On Fri, 2025-08-01 at 16:24 +0530, Manivannan Sadhasivam wrote:

<--- snip --->

> > > > > > The pci_bus_read_config() interface itself may have been a
> > > > > > mistake, can't the callers just use the underlying helpers
> > > > > > directly?
> > > > > >=20
> > > > >=20
> > > > > They can! Since the callers of this API is mostly the macros, we =
can easily
> > > > > implement the logic to call relevant accessors based on the reque=
sted size.
> > > > >=20
> > > > > Hans, could you please respin the series based the feedback since=
 the series is
> > > > > dropped for 6.17.
> > > > >=20
> > > >=20
> > > > Dear all,
> > > >=20
> > > > I am once again deeply sorry for the problems that occurred in this=
 series.
> > > > I only test pulling the ARM platform.
> > > >=20
> > > > Thank you very much, Gerd, for reporting the problem.

no worries!

> > > > Thank you all for your discussions and suggestions for revision.
> > > >=20
> > > > Hi Mani,
> > > >=20
> > > > Geert provided a solution. My patch based on this is as follows. Pl=
ease
> > > > check if there are any problems.
> > > > https://lore.kernel.org/linux-pci/CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpB=
fs9t3uaa=3DwRxNcSOAQ@mail.gmail.com/
> > > >=20
> > > > Also, please ask Gerd to help test whether it works properly. Thank=
 you very
> > > > much.
> > > >=20

I found Geert's proposal intriguing for a quick resolution of the
issue. Yet, I have not tried that proposal, though.

Instead I spent some more cycles on Lukas' and Mani's question about
the value of the pci_bus_read_config() helper. So I changed
PCI_FIND_NEXT_CAP and PCI_FIND_NEXT_EXT_CAP to use size-aware versions
of read_cfg accessor functions like this:

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ac954584d991..9e2f75ede95f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -109,17 +109,17 @@ int pci_bus_read_config(void *priv, unsigned int
devfn, int where, u32 size,
 ({                                                                  =20
\
        int __ttl =3D PCI_FIND_CAP_TTL;                                =20
\
        u8 __id, __found_pos =3D 0;                                    =20
\
-       u32 __pos =3D (start);                                         =20
\
-       u32 __ent;                                                   =20
\
+       u8 __pos =3D (start);                                          =20
\
+       u16 __ent;                                                   =20
\
                                                                     =20
\
-       read_cfg(args, __pos, 1, &__pos);                            =20
\
+       read_cfg##_byte(args, __pos, &__pos);                        =20
\
                                                                     =20
\
        while (__ttl--) {                                            =20
\
                if (__pos < PCI_STD_HEADER_SIZEOF)                   =20
\
                        break;                                       =20
\
                                                                     =20
\
                __pos =3D ALIGN_DOWN(__pos, 4);                        =20
\
-               read_cfg(args, __pos, 2, &__ent);                    =20
\
+               read_cfg##_word(args, __pos, &__ent);                =20
\
                                                                     =20
\
                __id =3D FIELD_GET(PCI_CAP_ID_MASK, __ent);            =20
\
                if (__id =3D=3D 0xff)                                    =
=20
\
@@ -158,7 +158,7 @@ int pci_bus_read_config(void *priv, unsigned int
devfn, int where, u32 size,
                                                                     =20
\
        __ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;   =20
\
        while (__ttl-- > 0 && __pos >=3D PCI_CFG_SPACE_SIZE) {         =20
\
-               __ret =3D read_cfg(args, __pos, 4, &__header);         =20
\
+               __ret =3D read_cfg##_dword(args, __pos, &__header);    =20
\
                if (__ret !=3D PCIBIOS_SUCCESSFUL)                     =20
\
                        break;                                       =20
\
                                                                     =20
\


This fixes the issue for s390's use-cases. With that
pci_bus_read_config() becomes unused - and could be removed in further
refinements.
                                                                     =20
However, this probably breaks your dwc and cdns use-cases. I think,
with the accessor functions for dwc and cadence changed to follow the
{_byte|_word|_dword} naming pattern they could be used straight out of
PCI_FIND_NEXT_{EXT_}CAP, too. Then, dw_pcie_read_cfg() and
cdns_pcie_read_cfg become obsolete as well.

Thoughts?


