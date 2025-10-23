Return-Path: <linux-pci+bounces-39160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1FC02218
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC8D3AFCD9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702B3385A0;
	Thu, 23 Oct 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kmjaykWF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7923385BA;
	Thu, 23 Oct 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233144; cv=none; b=X4Jb3d2xKrwonljmJxKMpYaMbvCEbCFSfRm4pMuBvBMv31d+toyCKV08ihI9kzuKeY3+i1OOQQAGKG76QHBEst+irS+DgIOuejOl+0u/kRl6V1fU0ndY2j2xDWk0Kg10nV9L1nMac8BSCWlNgHP8DfVMlcePJBl2UIoRXc22aig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233144; c=relaxed/simple;
	bh=yq0HGuo0hn8Kf8othbq07wPy0KtiTeh1Qs6HduBo3Lg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RA8BqHT/nJAamecmc4+s7XKRlGWJwQFIyE21kNX9ooxtDKIVWdNPnFS9qkm52TwtaWQJ/SuVhy+peJVfvSiV83ruA/qoTJW8OiWCzP+bHR5RdenZttcCbeqHIUau5TxrjFUstvEPoZQWC5Kx80Yd37v+A+7cIjkse2Z5Bs9jbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kmjaykWF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEa9tf007314;
	Thu, 23 Oct 2025 15:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yq0HGu
	o0hn8Kf8othbq07wPy0KtiTeh1Qs6HduBo3Lg=; b=kmjaykWF+pFW1UQoay46mc
	KoTZJg/KDkujYZ5Z7772fvRxLmKbIzDIt5zxno8YpI4j8uv99Z87k4b9yggSPb22
	C44MmS4Z7kzes82NuVBDYwGFWBBVqHGy7dhH7x3btmVzVdFRs2t29oxvweu1L2FE
	2LM47H+Y7LAFLJN0nW/chUBq/4SAUK3wkJWxw/ERXsYZ4Slog4/ah4OdfGdKCijM
	MT4EP1CwxCfwRqoC2TfpF+pR3rkgmbozQchBK+Ay+RpZmiJkk4TMSX5xjLQ9DlTQ
	rug9s+5vOB8dgXu90CrL4wf2g7q7nSN2ikmogGR9/W2ENCF//6Ivb/BmIwAfGX0w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fk2ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:25:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEKe46024940;
	Thu, 23 Oct 2025 15:25:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk6dja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:25:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NFPTgN18678322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:25:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77D4F58068;
	Thu, 23 Oct 2025 15:25:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A30858052;
	Thu, 23 Oct 2025 15:25:27 +0000 (GMT)
Received: from [9.111.75.188] (unknown [9.111.75.188])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 15:25:27 +0000 (GMT)
Message-ID: <163456ca8cf900e24fe3b9ce71fdad7b68398058.camel@linux.ibm.com>
Subject: Re: Potential issue with hypervisor_isolated_pci_functions()
 handling
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, jailhouse-dev@googlegroups.com,
        linux-s390	 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev,
        Farhan
 Ali	 <alifm@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tianrui Zhao	 <zhaotianrui@loongson.cn>,
        Gerd Bayer <gbayer@linux.ibm.com>
Date: Thu, 23 Oct 2025 17:25:26 +0200
In-Reply-To: <CAAhV-H4Q932R0fAbL6JyygZcgALdO_HJZ1Cqo88EhNMm04yjtQ@mail.gmail.com>
References: <d3f11e8562f589ddb2c1c83e74161bd8948084c3.camel@linux.ibm.com>
	 <CAAhV-H4Q932R0fAbL6JyygZcgALdO_HJZ1Cqo88EhNMm04yjtQ@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa48ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=uhtPpr09aKWp3gP-ho0A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ZBgHrv1JQDBXENfk-qIC_lEA0Wtq6V72
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzMjW0m/1vB95
 2MaFFBa4iLTkdbp912zRW7gFiblNMEJD0oLuVqwHlST+XlBE0WyAuy0XPYrmBCuyr5JI8RbYwHQ
 ZPU4MMT4U3YS6gd6dy+T4KjYW6rMigztVzkiobKsmbKK1gX7IvVn3N2XNxsMVyYAQn2Zp9cXGYB
 w0UljYwuvC2QTjPTY476pQuoY7uhNfkj3mRASxX2lBlysgROUHY3DrefgJv3eUjclEjwPaH7mPw
 JbbMYbkSHywvbxRSmpf1nrB3aTv+3T09rCBt00tycm/ToS02S7bfRdV7ueXc1EwlcKONeW/KlPd
 4PN3MVrIxeoiYSUTirmL/a+jTbTrJ0GqQKv9gIo+CK2oCg1wlXKWk3g402SEDvmjUJ0vpSqt1mH
 +ekX41uszhHUGZOzzCnsXDUmCogeGg==
X-Proofpoint-ORIG-GUID: ZBgHrv1JQDBXENfk-qIC_lEA0Wtq6V72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Wed, 2025-10-22 at 22:49 +0800, Huacai Chen wrote:
> Hi, Niklas,
>=20
> On Wed, Oct 22, 2025 at 7:40=E2=80=AFPM Niklas Schnelle <schnelle@linux.i=
bm.com> wrote:
> >=20
> > Hi Huacai, Hi Jan, Hi Bjorn,
> >=20
> > I noticed that with commit a02fd05661d7 ("PCI: Extend isolated function
> > probing to LoongArch") LoongArch now also makes use of the isolated
> > function probing. First, nice to see this sees more users and that the
> > interface is useful to you.
> >=20
> > Seeing this, I was reminded of an issue I ran into when using this
> > mechanism with SR-IOV capable devices. In that case VFs with devfn > 7
> > and PCI_SLOT(devfn) !=3D 0 wouldn't get probed.
> > This is because if a device is found next_fn() will check whether dev-
> > > multifunction is set. So if for example devfn =3D=3D 8 is found (fn =
=3D=3D 0)
> > dev->multifunction won't be set in pci_scan_slot() and for VFs it's
> > also not set via PCI_HEADER_TYPE_MFD. So we won't check for devfn =3D=
=3D 9
> > even though that could very well be there.
> >=20
> > Now for s390 this currently doesn't cause issues because for all
> > multifunction devices we have, we either get a VF alone and then since
> > commit 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs") use devfn
> > =3D=3D 0, or we have the parent PF passed-through and then VFs always g=
et
> > hot plugged after SR-IOV enable, which then uses
> > pci_scan_single_device(). And for non VFs we always have devfn =3D=3D 0
> > and/or devfn =3D=3D 1 and multifunction via the header. So in a sense t=
he
> > above commit works around the issue, though that wasn't its primary
> > intention.
> >=20
> > Did either of you also run into this issue or can reproduce it?
> >=20
> > Somewhat related, if ARI is enabled this would also break the isolated
> > function case including on s390 where ARI is used by the platform
> > firmware, but detected as off by Linux because there is no struct
> > pci_dev associated with the PCI bus. If I patch Linux to correctly
> > detect ARI, it no longer finds an isolated PF with devfn =3D=3D 1.
> LoongArch do have some problems after commit a02fd05661d7 ("PCI:
> Extend isolated function probing to LoongArch"). Please see:
> https://lore.kernel.org/linux-pci/20251014074100.2149737-1-chenhuacai@loo=
ngson.cn/
>=20
> Now we don't know what happens exactly, so I haven't answered Bjorn's
> question...
>=20
> Huacai
>=20

Hi Huacai,

I have now send[0] a fix proposal together with correctly exposing ARI
enablement in s390. I also reproduced both the issue I saw with SR-IOV
and with ARI and confirmed that the first patch in the series fixes
them. You're on Cc and I'd highly appreciate if you could test whether
this fixes your issues as well.

Thanks,
Niklas

[0]
https://lore.kernel.org/linux-pci/20251023-ari_no_bus_dev-v4-0-8482e2ed10bd=
@linux.ibm.com/

