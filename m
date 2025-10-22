Return-Path: <linux-pci+bounces-39047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 541ACBFD993
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0A094F0638
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB32C234B;
	Wed, 22 Oct 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kOqs+hxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D292C21D3;
	Wed, 22 Oct 2025 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154420; cv=none; b=ZBcY2YSm22Wq9lS2GfJdNgwZkelgvQdeZ1qWGM7FzKcW+BKLztEg6LfGY3EIQiC+T5ynNxwePnh5BcMNk0YHcp9TUTaKKhJ5beX2amvGwqTvkfxzCFrr+OvUVx+ZIHRBWPpO1jX0P4RLl4WF8I7ec0qNfDa7r2+6z9Hy71Ix5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154420; c=relaxed/simple;
	bh=/Yk9WiXQBjIwG6nS0SNWlq/vPVccKp+iCtnR+gPxq0U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bqJIqWLnKDGva+AeRzWAGXJygmdOn2UEd3v9Qe+p6VzSpqn6e4oXTvw/VJFXplW+m2adHI6Psr/ywyHnM1IwObxQRWbRg1xxrE78pJnt2cPhDpSjQb6671+SGxiS6nfswLGbIO5Ar59dJfHg8A3wYiAgWfy+bFmT6q7ORUhSSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kOqs+hxH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAOXBn003946;
	Wed, 22 Oct 2025 17:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Yk9Wi
	XQBjIwG6nS0SNWlq/vPVccKp+iCtnR+gPxq0U=; b=kOqs+hxH1CqLHrj8YxBgu/
	2vj5zA4+6c0sArBC7uMpIBqeSKb+4qkoRZddCyLvS/UKiWDWfKi94E98X/PEMT8h
	7Axa1vAUGH6lylie0sZa/Q1ms8ghFgTnaD0nWM6Dh2CM9+23GL3qsD73yeNjaoGC
	f1XjOOgLR5x91/5x8/u8M3i8kW2MBl99SaAn91Z7qWK2LlxfDrdbJLfA3noJp5q9
	IngNEzz9GmghW3dgwjdhfVB+pzPRvOa+P+S/THyRk8Odz/mivbb9S3EWEsxIFTSv
	l6GKQabLgj8QWiM9PCkS9Px0fO02lXycjjZH7xCRSD0sGuHKcPKvre0gGM0gZrhA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hmn4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 17:33:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MH1oWU017052;
	Wed, 22 Oct 2025 17:33:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky1r8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 17:33:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MHXNMr24707762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 17:33:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E851A58058;
	Wed, 22 Oct 2025 17:33:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2044158059;
	Wed, 22 Oct 2025 17:33:21 +0000 (GMT)
Received: from [9.111.88.198] (unknown [9.111.88.198])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 17:33:20 +0000 (GMT)
Message-ID: <7e15ec9e157521489fb5e98a0c52f90aa3ccf09a.camel@linux.ibm.com>
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
Date: Wed, 22 Oct 2025 19:33:20 +0200
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9zhnbiIttv74
 3JnksB+ByvKr2ZSUzqpj/+IKkTkfCSRemz+6fXK2/bMUlmqROPkX9kmYIBKrOY9cl4RBuH15pSF
 3X7eLzxO7hDEFZ+CTWXNayMsBLfutMZMZ9N71Ru6s7aZsxRctnQ8AuVC0pYMpEuoEOfzkR7/7PV
 Tfe776M/JMqTjDOo/9PB6gyOcVXzaxKkHJA48eojJ+8Sdam7/OaOFIAEgfr3biggfcwnpn/OU60
 MFkaghPEUiQ42//c5lFD0XLn/0yf5exC+bdYrHpmCfiNHzFZbCmY5BPOMEeL/OplfbIKbs+32p3
 FJ0pmtJijcYGT6eO0cOFP5OSufSzPeBD4SQjE5ZKeBLkjLuJE3dqvEi7jB5/u24B2VxZkH+Y/jL
 ALvrMmS6pMQMyhEh7Oz/o/0SoTyTXw==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f91565 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=9vf2bs2iEuHWSEF46McA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: E16fo7ub-l2JXCn_GDTbDSOdQnAVEKJS
X-Proofpoint-ORIG-GUID: E16fo7ub-l2JXCn_GDTbDSOdQnAVEKJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
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

Interesting. I'm working on a patch that simplifies and hopefully fixes
the isolated function probing by basically going back to basics and
just trying every devfn 0-255. It would be interesting if that fixes
your issue too. In the linked patch you said that the hole left by
function 0 is not supposed to be probed, but with disabled isolated
function probing you'd still try to scan function 0 so I can't see how
that would explain your issues. On the other hand it doesn't sound like
an exact match of what I saw. I'm still working on the cover letter and
more testing including testing on x86, but if you're curious the
current state is on my git.kernel.org account[0] in the
b4/ari_no_bus_dev branch.

Thanks,
Niklas

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=3Db4/=
ari_no_bus_dev

