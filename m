Return-Path: <linux-pci+bounces-39621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4FC192E3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E543BBA3C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F213254A7;
	Wed, 29 Oct 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wy5Qn+5q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41145322C60;
	Wed, 29 Oct 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727043; cv=none; b=U0E9yH8dpQi7scko5M8FdIsTnQC/6vkOHuXhME0jsVIU8px/plsKLM5mmAbjnyQaTuhfbqY4h6gLH+SPij4hAu+ZAM7avBnfoPfSPQ87R77MpDRBLTU0DtOMbxxUQXiexih6ZaxHfP8w3ZGctV8WoMFn/dEDAEcZrHrndonHiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727043; c=relaxed/simple;
	bh=oF6LKBB22AafYnCzTEBpOEfHh+noPK2wT2wVlzcUcA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njtid7Ia5yO315h7ddZWMnovRZM4zrLRqpJOnqXCMWv6DU4kRF+smNimhi3oLNoxP8PPw02uMJtoHC4DPmgYgocfnoFGjBMePRe2lVql9Q5wAg1zueHG2I2HBzrOqvkN4gLP4mQBb7XK5YKKOEm1DlO3m25zV2QsUWM4HIqldRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wy5Qn+5q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJmHUD008744;
	Wed, 29 Oct 2025 08:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ecvfUZ
	Bn2euew0euzB3a2mA2MwBou4gYy6KEjz6gV8U=; b=Wy5Qn+5qyzQBxp3FnQ4ohr
	OL0vYOh6V3hGGcVCHieTGFemcdm3Wy4/wBQTwDFBtkpMz/0oftD9l0uVdOMgjom6
	7x3tHVDvaUjicNlSkct209g5e8UBVmEaJg4KO5x+yPM/QfhcD6IPr9jn0iOc4Gig
	p6Y+UNgHcJk1BdUeba+NSUycpH5PjqMF9nwwsu2AWjNqjwfq1yUcQdX422YIRs1B
	L9OuVbkBF4O0wywebL3oP+WD9KJa1xYqeWgD3QrgHozfVTtsuoVr74KehuYt+gAm
	1HvItniwoMR2ozRS1JJII8jsTUDjCJl+8uhIo7JLe2HisRKiAKGCQAEh7vK3yJ9g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34afaa2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 08:37:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T5Gbbk027519;
	Wed, 29 Oct 2025 08:37:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33w2jd5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 08:37:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T8bC0f29360760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:37:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACE2158063;
	Wed, 29 Oct 2025 08:37:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B32558043;
	Wed, 29 Oct 2025 08:37:10 +0000 (GMT)
Received: from [9.111.56.216] (unknown [9.111.56.216])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 08:37:09 +0000 (GMT)
Message-ID: <2d1ea24848d4c389525df63a76fe873723bad900.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] PCI: Allow per function PCI slots
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Bibo Mao <maobibo@loongson.cn>, Farhan Ali <alifm@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: helgaas@kernel.org, mjrosato@linux.ibm.com, bblock@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        stable@vger.kernel.org, Tianrui Zhao <zhaotianrui@loongson.cn>,
        Huacai Chen
	 <chenhuacai@kernel.org>
Date: Wed, 29 Oct 2025 09:37:09 +0100
In-Reply-To: <aa0214e8-31be-2b21-c8af-b7831efd60a7@loongson.cn>
References: <20251022212411.1989-1-alifm@linux.ibm.com>
	 <20251022212411.1989-2-alifm@linux.ibm.com>
	 <e5a5d582a75c030a63c364d553c13baf373663ac.camel@linux.ibm.com>
	 <aa0214e8-31be-2b21-c8af-b7831efd60a7@loongson.cn>
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
X-Proofpoint-GUID: 7A0yER5TuzicOzdnIqMHgbCjTPW8nSiw
X-Authority-Analysis: v=2.4 cv=WPhyn3sR c=1 sm=1 tr=0 ts=6901d23b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=a3Gw60pZ56dmYUsj_9gA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX96rUOvt/9qIL
 Ic5TsUZZIsg2+IHvZLDQHjOcwHlgVmYUBWVpjgeqyFgMamGCHT0wMHhsB+T9mlDzg/wW38XrvTl
 NWrULgTMgKI5iIzSh7lRzyNYm0u+M5FvPenkfmF65XpTsG/5ce0DJ3dtznDT+aHHJKO58ZXWICk
 nhBVxy11hUsCCkp9WmtmRp0HrmGdbSk/Lwdd2q934aObgJVXe+x5ORLtD/ByZ8IJCDyvFnWHaIk
 +BUPL2ULhSia32c1bRG2VXfSj0KvJC00CGyIUOsfCvXnFhctYHNkkMXyrORmK8r7i/lseCYXWrX
 KU3HEehASX/agRnYlmZ8iUPq9iDCZLt2Nte0WBjJQg4aI71EPjR9AGRZUS3qS8KR0pdFA6csw4d
 odjGLO71YrUjekf5d0vdlOW5KLabug==
X-Proofpoint-ORIG-GUID: 7A0yER5TuzicOzdnIqMHgbCjTPW8nSiw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On Tue, 2025-10-28 at 09:11 +0800, Bibo Mao wrote:
>=20
> On 2025/10/27 =E4=B8=8B=E5=8D=888:29, Niklas Schnelle wrote:
> > On Wed, 2025-10-22 at 14:24 -0700, Farhan Ali wrote:
> > > On s390 systems, which use a machine level hypervisor, PCI devices ar=
e
> > > always accessed through a form of PCI pass-through which fundamentall=
y
> > > operates on a per PCI function granularity. This is also reflected in=
 the
> > > s390 PCI hotplug driver which creates hotplug slots for individual PC=
I
> > > functions. Its reset_slot() function, which is a wrapper for
> > > zpci_hot_reset_device(), thus also resets individual functions.
> > >=20
> > > Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot ob=
ject
> > > to multifunction devices. This approach worked fine on s390 systems t=
hat
> > > only exposed virtual functions as individual PCI domains to the opera=
ting
> > > system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunction=
s")
> > > s390 supports exposing the topology of multifunction PCI devices by
> > > grouping them in a shared PCI domain. When attempting to reset a func=
tion
> > > through the hotplug driver, the shared slot assignment causes the wro=
ng
> > > function to be reset instead of the intended one. It also leaks memor=
y as
> > > we do create a pci_slot object for the function, but don't correctly =
free
> > > it in pci_slot_release().
> > >=20
> > > Add a flag for struct pci_slot to allow per function PCI slots for
> > > functions managed through a hypervisor, which exposes individual PCI
> > > functions while retaining the topology.
> >=20
> > I wonder if LoongArch which now also does per PCI function pass-through
> > might need this too. Adding their KVM maintainers.
>=20
> Hi Niklas,
>=20
> Thanks for your reminder. Yes, LoongArch do per PCI function=20
> pass-throught. In theory, function pci_slot_enabled_per_func() should=20
> return true on LoongArch also. Only that now IOMMU driver is not merged,=
=20
> there is no way to test it, however we will write down this as a note=20
> inside about this issue and verify it once IOMMU driver is merged.
>=20
>=20
> Regards
> Bibo Mao
>=20

Hi Bibo,

Is your ability to test if it works for you also hindered for my other
patch touching pci_scan_slot()? It sounded like Huacai was looking into
testing that.

Thanks,
Niklas

