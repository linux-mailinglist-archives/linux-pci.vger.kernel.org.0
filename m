Return-Path: <linux-pci+bounces-42631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350CCA3DAD
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 14:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD93C3128276
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E092A342538;
	Thu,  4 Dec 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cu0O5kHh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAA33B6FC;
	Thu,  4 Dec 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855167; cv=none; b=lg5GztK5d6EwfNg5f+YBs3gaMawrklps7QTQkn1Bfj7+oGL8HNleNigxzhlSQmLhdit6yAALauSlVGOS9YS6tt/1dsitzgxvHXBAjGyPTVqv6E+k/wg1o0Ji02Dt96UaD0oDAU33/HDHzP3CYxsl2kDpIeaG9iqJyA1z0GWq+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855167; c=relaxed/simple;
	bh=3v3VlgRwdbEm5Jz7/1tD4NafUahZLStcG6k+IKOd/2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rFfqKJaFMhrVVRgFjU4qi9PM7nACS5+A6M3V9r8AsF7qLDyHyjjbyZQ0Ogre41kykqEeaWPZZzUsyKmkQqeijSLp94U4GELMJiCnKN/YhaWWQa7UJwXZ3uDivHnRhVK+yg13f3V5i85uWKXgmmrOGObsvBnk2UVjLtS6CitTpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cu0O5kHh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4C4mkh009614;
	Thu, 4 Dec 2025 13:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3v3Vlg
	RwdbEm5Jz7/1tD4NafUahZLStcG6k+IKOd/2Y=; b=cu0O5kHhW0Hz4jY8Xprorg
	Gltg/lFvyMNgmOME0vz6+KPn2J1hGbePUxQ5Nsm5LCZLhbhyxFy6idL3eHrR01pr
	LIhJFZyDVtlJ60AcoiuLnGdNBiOUalEfjjlu1zCd/Zrqieb7FJJgina/3AAyCf0M
	1GZboRF8LTbfl+c2gSkv5TQ0kaNdV9Jas3SOmhGarhNZopvllA2vkYhVGkXqw9wK
	K7lkw49XFpJ065hWEqv0vxLU4+XUkaj+eA4Mxq7cAW56Zl4N8z/2SJGrg7PaCjWp
	eHQzKxYDpU7Mq4lZZCdFSHDAeCCZ+earnxAd/sJXVb0gQvEkYFkdCdQfKjjnP8KA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrja0ft1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 13:32:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B4DSaMP025401;
	Thu, 4 Dec 2025 13:32:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrja0fsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 13:32:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4D1Z7Q003891;
	Thu, 4 Dec 2025 13:32:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjyr4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 13:32:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4DWdCE58130786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 13:32:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 978D52004B;
	Thu,  4 Dec 2025 13:32:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 328DE20040;
	Thu,  4 Dec 2025 13:32:39 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 13:32:39 +0000 (GMT)
Message-ID: <147846fa858805ae8cc2e7ba3cf9801dbb3264b2.camel@linux.ibm.com>
Subject: Re: [PATCH v3] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas
	 <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
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
Date: Thu, 04 Dec 2025 14:32:39 +0100
In-Reply-To: <f49c568303ec861a721969251da9b686cc051303.camel@linux.ibm.com>
References: <20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com>
		 <c66fe13cf2dbe9def72cbd5ae703538dcb770d7b.camel@linux.ibm.com>
	 <f49c568303ec861a721969251da9b686cc051303.camel@linux.ibm.com>
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
X-Proofpoint-GUID: 2c5f1R5rY2fTn46mnIZSuAgG63ddoy61
X-Proofpoint-ORIG-GUID: gyBdYrPJbMAG0OYqmNWzvgjJMCRdfPtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX5j35LcScXHMD
 vNvllffWEdl3jBgTXWfRi97Zirlc1G8OjPfF0h0ePDcJ+RtRY6OOP5V5Cj10kigAcTPcTbUhJDX
 FKinCOGkvI51XoonBJSwBSH4DDKwiHlDc9DNiuu564xgihVm2mkEvFd7wH/kuFFiCQP3MgGVo1J
 38H3XcaZKpuWKNsLvpxcIlrR7GUsYO3vCPb5JkskisGL9AXW1GxsbzFQP2oQfEO8KNr2cA4yFah
 JIcbSCyX/zrQiaEIP45Xt6lomWGquK9ccSMv4GU96uJECJ7MNz+wi+e0f5RYJn+7z9DcQS4lVDW
 W8wchkKA3b2GsiR13qbYX+FGOZnuch9dcjs461GdftdmYPDNQCeKQMLAgIpq4SBcV3KSMWb1/pD
 d4l11Gqs2LXv9Dof9fUu6otyJrrJew==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=69318d7c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=hDeK41mN1ZnsdbcWdGkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

On Thu, 2025-12-04 at 14:09 +0100, Niklas Schnelle wrote:
> On Thu, 2025-12-04 at 13:45 +0100, Gerd Bayer wrote:
> > On Wed, 2025-10-15 at 15:42 +0200, Niklas Schnelle wrote:
> > > On s390, an individual PCI function can generally be identified by tw=
o
> > > identifiers, the FID and the UID. Which identifier is used depends on
> > > the scope and the platform configuration.
> > >=20
> > > The first identifier, the FID, is always available and identifies a P=
CI
> > > device uniquely within a machine. The FID may be virtualized by
> > > hypervisors, but on the LPAR level, the machine scope makes it
> > > impossible to create the same configuration based on FIDs on two
> > > different LPARs of the same machine, and difficult to reuse across
> > > machines.
> > >=20
> > > Such matching LPAR configurations are useful, though, allowing
> > > standardized setups and booting a Linux installation on different LPA=
Rs.
> > > To this end the UID, or user-defined identifier, was introduced. Whil=
e
> > > it is only guaranteed to be unique within an LPAR and only if indicat=
ed
> > > by firmware, it allows users to replicate PCI device setups.
> > >=20
> > > On s390, which uses a machine hypervisor, a per PCI function hotplug
> > > model is used. The shortcoming with the UID then is, that it is not
> > > visible to the user without first attaching the PCI function and
> > > accessing the "uid" device attribute. The FID, on the other hand, is
> > > used as the slot name and is thus known even with the PCI function in
> > > standby.
> > >=20
> > > Remedy this shortcoming by providing the UID as an attribute on the s=
lot
> > > allowing the user to identify a PCI function based on the UID without
> > > having to first attach it. Do this via a macro mechanism analogous to
> > > what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
> > > pdev->dev.groups") for the PCI device attributes.
> >=20
> > Hi Niklas,
> >=20
> > I like this addition a lot. Also, Lukas' method to add arch-specific
> > attributes to sysfs. Is there a reason why you didn't apply that
> > mechanism 1-to-1?
>=20
> I considered that and actually had basically the same as your diff in
> an intermediate version. To me it looked cleaner with the #ifdef in the
> attribute_group array initialization as I feel that it is more obvious
> if the macroed elements are used. This may be because my editor grays
> out the code between unused #ifdef or just because "it's in one place"
> either way just a matter of taste. Also the comma gave me checkpatch
> complaints.

I agree, for me it's more a question of taste than anything else. If
there's a preference towards commonality, Lukas or Bjorn may want to
chime in.


> >=20
> > >=20
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > > Note: I considered adding the UID as a generic "index" via the hotplu=
g
> > > slot driver but felt like there is probably too little commonality on
> > > format and usage patterns
> >=20
> > Sorry for my ignorance but how is the hotplug slot driver defining an
> > "index" or how is used?
> >=20
>=20
> It's not. I meant that I considered that the UID could be turned into a
> generic "index" attribute in the same way that the UID is used as
> /sys/bus/pci/devices/<dev>/index on s390 while the same attribute is an
> SMBIOS index thing on x86 and others.

I see and agree, "index" by itself lacks the definition of a
"dimension" on which you mark individual slots.

Having no further comments, feel free to add my
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>

Thanks,
Gerd

