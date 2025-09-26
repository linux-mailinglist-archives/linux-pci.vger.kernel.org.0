Return-Path: <linux-pci+bounces-37122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F4097BA4E73
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D130A7A3A5C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C8C274FE3;
	Fri, 26 Sep 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bVPkHPpd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC735957;
	Fri, 26 Sep 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911828; cv=none; b=HWkt+GguFretEhquu0Y03ew0Q3sOSjK3b99xi3t8pF5lSspJAgcEWaBC7Eyh5OkDNSqaB4YpTHiEyv5sX0TpfKUSGiE0SsgCBzXLpIcbmlOpMgaFW+WVPp1KXXhstQ/lrmS9l5o0Su7WY5coLbWgGhns1npqxL9fVhZcx761GrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911828; c=relaxed/simple;
	bh=bI1dj/ANFOr3zfsK43Pa1drUBTFTzsgFe3mxvon8gHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WHPfA1OSozalZjP6eljewrPLkt/EgIl/goWDuQmPP2KXJIHPtG25hlLSEkjsfbsCHz/POpm/spadGScGDFVp00YCl8EBX9xEt+2FXYr8pqTS79dRxvN6fLvhN6A+8shL+LbB4wqptYwFEQbPP2VVIkBALHhb94SFa4ELX0oVM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bVPkHPpd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QDRPxN006100;
	Fri, 26 Sep 2025 18:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q5nv2P
	wmfVa2e1c/51t82Hpimrg0ex2BKIC2wVTa6IU=; b=bVPkHPpdieH2MjEknsgyZH
	GXdd+UmpPGtvtoxaGkppn8TnnNiouQ7BPnCDqRpdu2ZT5/YNipcMorDdS0gyqQ77
	57dN3MwFbysoWIdpP9vsdalS30qs/Dit+EZXYNAf/IaB8YYfX7hOs7+JaMlccABX
	X4ijuvoaPNU8ZjKvgEJ6UoZheC1KqpsN3Qa30jTQoCYQp7ucDKE98xFB8JDnCh7P
	oBDA2gXe7Zad9zgxGaDyUtZOIaq+VItos13Zg2Zcxf9sbm7r0HXsFjWAom6XvL/l
	/nK6lip6AzEU24ADzNGxvdKEbnJuTLp/Hb9toT+xkQ/We4G/dxYs6bePOLEkmoiw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb6pjcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 18:37:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58QIKn3H002739;
	Fri, 26 Sep 2025 18:37:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb6pjck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 18:37:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QHO6b9030082;
	Fri, 26 Sep 2025 18:37:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawmdny1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 18:37:03 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QIb2pp31457810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 18:37:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1273758062;
	Fri, 26 Sep 2025 18:37:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0225B5805C;
	Fri, 26 Sep 2025 18:36:59 +0000 (GMT)
Received: from [9.111.32.203] (unknown [9.111.32.203])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Sep 2025 18:36:58 +0000 (GMT)
Message-ID: <67de8faa7eca891c7c39ae83540f74369de5b783.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: ramesh@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner
	 <lukas@wunner.de>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew
 Rosato	 <mjrosato@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle	 <svens@linux.ibm.com>,
        Julian
 Ruess <julianr@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date: Fri, 26 Sep 2025 20:36:58 +0200
In-Reply-To: <4dd8a92a-0843-4009-a9c6-3a1336dbf217@linux.ibm.com>
References: <20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com>
	 <4dd8a92a-0843-4009-a9c6-3a1336dbf217@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MfBhep/f c=1 sm=1 tr=0 ts=68d6dd50 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=bH0TyEJ6RQiHK2C8XwAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2Idp1cNKwFR4vhOhxNhF_vMOLAHegYea
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX/iBLddznQDnA
 Rl/kRbtw+eQfzhu70/vg8M/2Hx1aOFESKN/FGUuoKXtqwmq9scictrZZYAbS8fbQuvoQTpUq6rf
 Llar/cDZiJCXrI6JRt1EF01nxQpQZwkEwvWrnLt4tmyVxXSe3IfNyxhPQjxrtfpSRDiHaqzGWCA
 kZKo6voIe7SFBv3FKcW6k9iIk+9E7q0AGPLQzC7+cksiNs/zsSqm47r/Sw6a2HR70MXjc3RHbB0
 m09o5s7bm538yRBI/gQ4gM4aRYMjPdFe9FSSx+PCAXt7jsqOuvkssuBr3o4B1lbm1Rew5odzgpx
 okbm94tcmla0nydtk4rmwGa0LiPCmsszihwd/+PzUHuBT8TX9qBFT707hPjhpdY3AgFfEO6DD9S
 mE7AbgJlM3zXWtO584UzFY6y9HgrOg==
X-Proofpoint-ORIG-GUID: tAeDPIoQTm9ZvwveodBrzKSRJRtAVUFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

On Fri, 2025-09-26 at 11:34 -0500, Ramesh Errabolu wrote:
> On 9/24/2025 8:14 AM, Niklas Schnelle wrote:
>=20
> > On s390, an individual PCI function can generally be identified by two
> > IDs, depending on the scope and the platform configuration.
> It would help to name the two IDs - FID and ???

How about:
"On s390, an individual PCI function can generally be identified by two
identifiers, the FID and the UID. Which identifier is used depends on
the scope and the platform configuration."

And then reword the below without "so-called".

> > The first ID is the so-called FID, which is always available and
> > identifies a PCI device uniquely within a machine. The FID may be
> > virtualized by hypervisors, but on the LPAR level, the machine scope
> > makes it impossible to reuse the same configuration based on FIDs on tw=
o
> > different LPARs.
> >=20
> > Such matching LPAR configurations are useful, though, allowing
> > standardized setups and booting a Linux installation on different
> > machines. To allow this, a second user-defined identifier called UID wa=
s
> > introduced. It is only guaranteed to be unique within an LPAR and only
> > if the platform indicates so via the UID Checking flag.
> The paragraph as I read is not clear. Your intention is to highlight the=
=20
> need for UID to allow standardized setups.

Yes, that was my intention. Also here is where the second ID is
introduced so I'll reword this a bit if the name is already mentioned
in the first paragraph.

> >=20
> > On s390, which uses a machine hypervisor, a per PCI function hotplug
> > model is used. The shortcoming with the UID then is, that it is not
> > visible to the user without first attaching the PCI function and
> > accessing the "uid" device attribute. The FID, on the other hand, is
> > used as slot number and is thus known even with the PCI function in
> > standby.
> >=20
> > Remedy this shortcoming by providing the UID as an attribute on the slo=
t
> > allowing the user to identify a PCI function based on the UID without
> > having to first attach it. Do this via a macro mechanism analogous to
> > what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
> > pdev->dev.groups") for the PCI device attributes.
> >=20
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Note: I considered adding the UID as a generic "index" via the hotplug
> > slot driver but opted for a minimal solution to open the discussion. In
> > particular my concern with a generic attribute is that it would be hard
> > to find a format that fits everyone. For example on PCI devices we also
> > use the "index" attribute for UIDs analogous to SMBIOS but having it in
> > decimal is odd on s390 where these are usual in hexadecimal.
> > ---
> >   arch/s390/include/asm/pci.h |  4 ++++
> >   arch/s390/pci/pci_sysfs.c   | 20 ++++++++++++++++++++
> >   drivers/pci/slot.c          | 13 ++++++++++++-
> >   3 files changed, 36 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> > index 41f900f693d92522ff729829e446b581977ef3ff..23eed78d9dce72ef466679f=
31c78aca52ba00f99 100644
> > --- a/arch/s390/include/asm/pci.h
> > +++ b/arch/s390/include/asm/pci.h
> > @@ -207,6 +207,10 @@ extern const struct attribute_group zpci_ident_att=
r_group;
> >   			    &pfip_attr_group,		 \
> >   			    &zpci_ident_attr_group,
> >  =20
> > +extern const struct attribute_group zpci_slot_attr_group;
> > +
> > +#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
> > +
> >   extern unsigned int s390_pci_force_floating __initdata;
> >   extern unsigned int s390_pci_no_rid;
> >  =20
>=20
> Will this not lead to linking error when the patch is built on non-s390=
=20
> architecture. You could refer to zpci_slot_attr_group using a=20
> CONFIG_..... and discard the #define ARCH_PCI_SLOT_GROUPS. I didn't find=
=20
> a relevant CONFIG_... that could be used.

This code is in arch/s390/ it will not be build on non-s390. For the
non s390 case ARCH_PCI_SLOT_GROUPS will be undefined and the #ifdef in
slot.c makes sure we're not trying to insert ARCH_PCI_SLOT_GROUPs in
the array as it is not defined.

Thanks,

Niklas

