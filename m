Return-Path: <linux-pci+bounces-37121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956DBA4E31
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0581C561B63
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA6322D7B0;
	Fri, 26 Sep 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pejRJYFZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0A1494A8;
	Fri, 26 Sep 2025 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911118; cv=none; b=WlC87d6Y5B6LTMDmXwUobaISgrOY93zdzVuhm05UuNRqyvhgO0TjhSOqS39H58V+y4H3SjdtGoWAc799wmdQ5K/s3flkJS3smzr55h4idNKCqsUWgwTLE4wEY7ONPJlV50VVPh9FIhHvjeiB64j3HhY3ITBRP8fK0ZDSAJTAV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911118; c=relaxed/simple;
	bh=h7vPkxzCW0YeB7YobHNfAjgqqSPdXNu/hriUYM8fjts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUzYsuRoj7n6xL9kja9Oaz9/G7Z/FQc2ggRKMOHuu8uMlfN2dD5bXOfYrmxNZGhmWg9LnqKV/raTpuSLEsm5B1D8xubPPgR2kc4vCQYJuqV0B/0+y29g+1HiUwwNA1a5kc3At59oRFhNXNe9xyU23kEqEu+KuJxX6qTnjUtZJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pejRJYFZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QFsY0p028794;
	Fri, 26 Sep 2025 18:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=roVwvt
	kajXkdCgky14cayzULYJeIWUj0A4pxK0Hsx2o=; b=pejRJYFZe2HA1wEoEsJb35
	yKNQwaCmk8v5RHn0wQWsJHytXQ3WUN2dKosuA88j5nEWeuw5n4s+sm6WpWhzsHki
	heH8g1z+dvLYoCbcyiFB1AFw0vkcniVcXhWI1NwGgBGojIWSFZYZFYg37ywyWB2z
	5P/tHjtY2AyCJYrtkhMYcZSzx/SVT5+qz1WHWYyg/47Ua2NH9yuQBXhUd0hbKl9Q
	wncvFqVoMRbHsUY+ke5GHi+y2Tk38PJVi06DWqTPmmMsgP0mzcnpFIuBjU/INU1m
	8EMud7sgz/gemndDOkePIAFB7QnRz5fRpSnc2pNHg0LOPuBX38WQMEiq2L9fVzew
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbbpj57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 18:25:13 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58QIP7Qf012751;
	Fri, 26 Sep 2025 18:25:13 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbbpj53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 18:25:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QHFGmh030117;
	Fri, 26 Sep 2025 18:25:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawmdkst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 18:25:12 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QIOxGT8782376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 18:25:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A26058059;
	Fri, 26 Sep 2025 18:25:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D233458055;
	Fri, 26 Sep 2025 18:25:07 +0000 (GMT)
Received: from [9.111.32.203] (unknown [9.111.32.203])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Sep 2025 18:25:07 +0000 (GMT)
Message-ID: <b8c610fa2ac725364c8e485e948c7bd6efd605fa.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Gerd Bayer	 <gbayer@linux.ibm.com>,
        Matthew
 Rosato <mjrosato@linux.ibm.com>,
        Heiko Carstens	 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev	
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Ruess
	 <julianr@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 26 Sep 2025 20:25:07 +0200
In-Reply-To: <20250926142714.GB17059@p1gen4-pw042f0m.boeblingen.de.ibm.com>
References: <20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com>
	 <20250926142714.GB17059@p1gen4-pw042f0m.boeblingen.de.ibm.com>
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
X-Proofpoint-ORIG-GUID: 94gVbpDbyhhQTE99YkwuNxMiNrRIS9bP
X-Authority-Analysis: v=2.4 cv=LakxKzfi c=1 sm=1 tr=0 ts=68d6da89 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=P9skmfd1rRbCZ86thLoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FvGhVWoEg1Dn-i36jPjaqOQ6S6wcfp-C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX+6MM4EmbjBSj
 0DqnTpE5wCVAq4ITMCLUshwSFVcuxM/AiaNrTTVo5poOw705HZT0O7k9ejHL9/TDArO50MQO4dB
 2gFjUQTZcQZFwwyALMnl/Y4Z2lSoMpAkXLEYQtqSjJ1WkfGBj3NjPfAWsCs/m3L9nekHgKKl8WR
 yMxlBsZCcUFs1olwjoKrHjTVZ/Rmvytr1Or1FVTPRVTWb83zgCTz2dCJ1OnZIei3RkDFtGpTKWc
 NO6LeV7mqzDmYAQwG1QSUvtm4ZWa5mW2ITvfhKs0d8BXSJ7kW3yLdGrNOM5Z0aYzGyLPYUdvF6d
 6BI4lSxAvSOlXFJtuUTLTC0psuTOkXuW+Fk3QGh4/+skuH7Mku//Pq8OFvC7zfFOFxDK0CSp0io
 BWPNVteTjSBl5I9ECPURPpm6OGeVwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

On Fri, 2025-09-26 at 16:27 +0200, Benjamin Block wrote:
> > diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> > index 41f900f693d92522ff729829e446b581977ef3ff..23eed78d9dce72ef466679f=
31c78aca52ba00f99 100644
> > --- a/arch/s390/include/asm/pci.h
> > +++ b/arch/s390/include/asm/pci.h
> > @@ -207,6 +207,10 @@ extern const struct attribute_group zpci_ident_att=
r_group;
> > =C2=A0			    &pfip_attr_group,		 \
> > =C2=A0			    &zpci_ident_attr_group,
> >=20
--- snip --
> > +extern const struct attribute_group zpci_slot_attr_group;
> > +
> > +#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
>=20
> I don't know the history exactly, but this can't be easily extended like =
the
> other group above `ARCH_PCI_DEV_GROUPS`.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0(&zpci_slot_attr_group,  \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&zpci_slot_attr_group_b)
>=20
> Won't compile. The way `ARCH_PCI_DEV_GROUPS` does it, attaching a differe=
nt
> group is just adding a new line.

Without the parenthesis it should. I only added them because otherwise
checkpatch complains and it's still valid for a single item to have
parenthesis.

>=20
> > diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> > index 0ee0924cfab7e5d22468fb197ee78cac679d8c13..997dff3796094680d9a3f0b=
6eb27a89fa1ed30b2 100644
> > --- a/arch/s390/pci/pci_sysfs.c
> > +++ b/arch/s390/pci/pci_sysfs.c
> > @@ -178,6 +178,17 @@ static ssize_t index_show(struct device *dev,
> > =C2=A0}
> > =C2=A0static DEVICE_ATTR_RO(index);
> > =C2=A0
> > --- snip ---
> > +{
> > +	struct zpci_dev *zdev =3D container_of(slot->hotplug, struct zpci_dev=
,
> > +					     hotplug_slot);
> > +
> > +	return sysfs_emit(buf, "0x%x\n", zdev->uid);
>=20
> Do we need a special case for when `uid` is 0? That would imply the uid i=
s
> invalid, right? Would we want to return an error in that case (-EINVAL, o=
r
> smth)?=20
>=20
> Also, do we want to use the same format as in `zpci_setup_bus_resources()=
`
> with the 4 leading 0's (`0x%04x`)?

I chose to match the "uid" device attribute here ("zpci_attr(uid,
"0x%x\n", uid)" in the beginning of the same file). This doesn't
special case UID 0. You are right that this is an invalid UID though.
It also still exposes the UID even if it is not guaranteed to be
unique. But we'll make that setting known to user-space separately.
I feel like knowing the UIDs can still be helpful even when they are
not unique, for example to check that they've been set correctly from
within Linux before enabling UID Checking.

>=20
> > +}
> > +
> > +static struct pci_slot_attribute zpci_slot_attr_uid =3D
> > +	__ATTR(uid, 0444, zpci_uid_slot_show, NULL);
>=20
> __ATTR_RO()?

