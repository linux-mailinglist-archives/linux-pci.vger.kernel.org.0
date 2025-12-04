Return-Path: <linux-pci+bounces-42627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E18B9CA3BCE
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 14:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 752F630DE355
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE5335089;
	Thu,  4 Dec 2025 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cGeMRVWi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA2342534;
	Thu,  4 Dec 2025 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853749; cv=none; b=VS/p8QxFB4cPwab4oNvKdzRkMCUIBAkT89YvdRQYeLpNlj9DyFeQFeRQtbsF6rZyGGuKAjaqLQdx0eKmC9sMkl7HI4cpkSuGhp5qdfFcvhJDjSP+NT7441XMzxH2mwBrFnIZ39nCA+wPm0N8+TwmxQIgY6MiJLDSN3uW0FcQhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853749; c=relaxed/simple;
	bh=/vhJp4Era/lCT7cwvDoW8hENCXitZDB/pJNpWJ/xu5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfDyW1GUJkkEcwmfVMEWSqUEOEDTK3Rdbbuf22ftTOJgeZD+Zje9IlBL2oDwHcPcY84et4nn7RVf0rXcMd+1RH+6selbbTzQf/LRMjnEiouRsiy/PvPQm+eQf7FZAvGk0aQGpb+kq7KHoPSl99XCdfipm0gl4OrPBxNj51M+rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cGeMRVWi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B40qlD4021132;
	Thu, 4 Dec 2025 13:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/vhJp4
	Era/lCT7cwvDoW8hENCXitZDB/pJNpWJ/xu5Y=; b=cGeMRVWiFSgAVYnEhb23py
	ijN3mFS5mvG93fcyz11xk/0tzRTkv2ZUw1hvcRwQQZLc2DlfkPgVefaiZPkK2Wz0
	r/afe35gigu10BkOlOrcurFIc1UIGGcM33RegdRPDyH+7iPbvaBxPdkduPKTzTtk
	viCL2LXJZUGeKa9NCBPHXvdjICxAKszlLJoXYpPB1t79hRZ8wWzFTwMthNtiG2P2
	c9FZap5Lg3Z/+ORqmORHD5WvQQrmSKZpbZLK3jXLbJtP34teo+NIpwgDZTx6kpsc
	DZk4MEUyC8apzlvOFIvuQQOpQkbXqN/rvsTPzdQ/ZEqGPWEnA/eWpJxCDCgYWVDg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8uyv10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 13:09:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B4D96FM014368;
	Thu, 4 Dec 2025 13:09:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8uyv0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 13:09:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4Bs5j5010292;
	Thu, 4 Dec 2025 13:09:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnkfsfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 13:09:05 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4D94oF28705390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 13:09:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7173F5805D;
	Thu,  4 Dec 2025 13:09:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF01258055;
	Thu,  4 Dec 2025 13:09:01 +0000 (GMT)
Received: from [9.111.38.114] (unknown [9.111.38.114])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 13:09:01 +0000 (GMT)
Message-ID: <f49c568303ec861a721969251da9b686cc051303.camel@linux.ibm.com>
Subject: Re: [PATCH v3] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev	 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Ruess	 <julianr@linux.ibm.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Thu, 04 Dec 2025 14:09:01 +0100
In-Reply-To: <c66fe13cf2dbe9def72cbd5ae703538dcb770d7b.camel@linux.ibm.com>
References: <20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com>
	 <c66fe13cf2dbe9def72cbd5ae703538dcb770d7b.camel@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dLYNHFuJPZXyohLucuu6DGpz4VqXPQss
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX+lwHBp/btG+m
 FeAbPsngqQx/K5HC52q1sO0r1osqeLnIgeEXv8qUlTo5mF05MoZ1IrAdYSsYdwqGY2ArvRJofwU
 Wl2qe/GbCu4CTJz7QOox48PTKZSbj3RZLyAf72VXx9386CcgfrOcWqaRZ9V097FeOuGcY/NXwPp
 NrUc/nJBA2/OpZSL7QZmTbAl7LSnn7iLYJSc/RQuJ5aCMSs+ULaiXNnfPeSmHhDUx29Lhz1CPNo
 P9hHPZrYEJPY+EsEqZAnyS0AZ5iSqSuckFFHeXsVkYFNdXDP2sphmeGQv/BKw160Amla/yZZlzP
 lETBBW4oICL/dRCqfMlf0n+HJaD3UrqLP95noz8hZt/IzMK5c/e9+w+Nf0Qr0RDrfWIQ1ZQOp3T
 OaO9t+AqKJyCcX8OAjb5HDBw3uu3EA==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=693187f2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=loEuMJwbk0X0rLMOwskA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BnPuDKurt7NUTjmKWVxx4Lwvi3YXCcFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008

On Thu, 2025-12-04 at 13:45 +0100, Gerd Bayer wrote:
> On Wed, 2025-10-15 at 15:42 +0200, Niklas Schnelle wrote:
> > On s390, an individual PCI function can generally be identified by two
> > identifiers, the FID and the UID. Which identifier is used depends on
> > the scope and the platform configuration.
> >=20
> > The first identifier, the FID, is always available and identifies a PCI
> > device uniquely within a machine. The FID may be virtualized by
> > hypervisors, but on the LPAR level, the machine scope makes it
> > impossible to create the same configuration based on FIDs on two
> > different LPARs of the same machine, and difficult to reuse across
> > machines.
> >=20
> > Such matching LPAR configurations are useful, though, allowing
> > standardized setups and booting a Linux installation on different LPARs=
.
> > To this end the UID, or user-defined identifier, was introduced. While
> > it is only guaranteed to be unique within an LPAR and only if indicated
> > by firmware, it allows users to replicate PCI device setups.
> >=20
> > On s390, which uses a machine hypervisor, a per PCI function hotplug
> > model is used. The shortcoming with the UID then is, that it is not
> > visible to the user without first attaching the PCI function and
> > accessing the "uid" device attribute. The FID, on the other hand, is
> > used as the slot name and is thus known even with the PCI function in
> > standby.
> >=20
> > Remedy this shortcoming by providing the UID as an attribute on the slo=
t
> > allowing the user to identify a PCI function based on the UID without
> > having to first attach it. Do this via a macro mechanism analogous to
> > what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
> > pdev->dev.groups") for the PCI device attributes.
>=20
> Hi Niklas,
>=20
> I like this addition a lot. Also, Lukas' method to add arch-specific
> attributes to sysfs. Is there a reason why you didn't apply that
> mechanism 1-to-1?

I considered that and actually had basically the same as your diff in
an intermediate version. To me it looked cleaner with the #ifdef in the
attribute_group array initialization as I feel that it is more obvious
if the macroed elements are used. This may be because my editor grays
out the code between unused #ifdef or just because "it's in one place"
either way just a matter of taste. Also the comma gave me checkpatch
complaints.

>=20
> >=20
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Note: I considered adding the UID as a generic "index" via the hotplug
> > slot driver but felt like there is probably too little commonality on
> > format and usage patterns
>=20
> Sorry for my ignorance but how is the hotplug slot driver defining an
> "index" or how is used?
>=20

It's not. I meant that I considered that the UID could be turned into a
generic "index" attribute in the same way that the UID is used as
/sys/bus/pci/devices/<dev>/index on s390 while the same attribute is an
SMBIOS index thing on x86 and others.

