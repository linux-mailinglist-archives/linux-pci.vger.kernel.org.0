Return-Path: <linux-pci+bounces-43285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF8CCBB72
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7FFB3063C1B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A0D32D0D2;
	Thu, 18 Dec 2025 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D2Xvn0m2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67D287247;
	Thu, 18 Dec 2025 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059415; cv=none; b=VGV6GMWVEtEAVd7ZP49m0kXfcK1fBdSlrK4nh7hrDIKpQcaqPGWmzEShcXT7cJkpAN49UKxfS65YiFy7A9yNX0ZIrOjkWO8q9GULbzvxiyBRdUrHt+3FOZKJSZw5tJVbEQHrN2tpSVSTnhSSLfp4Dhwwg+7ko9o8xTYBpjkjcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059415; c=relaxed/simple;
	bh=9LuDdPk5T3J6n/oTpbZlmhaL9aKSCUlq55Bh9nzNFAM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jc8QLcPZQyoOfUD6410JtCiSMS2mDPunBM3X1umLsAsw/xxo7QsgWjrlHc2ajNumsQcJYmqz4JCTb8w+9cvnYrpzzVGdpDa1gCOwz2WVmBw2/w+qUBtuohBA7I+sWGsdQBkEetypDJMbiEI3ILVROYVEBDU+5YXyU2GBvz0Y73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D2Xvn0m2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI5qa0F006963;
	Thu, 18 Dec 2025 12:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XzmHaA
	OhPEhotYxmTOenEn0G6AIxWtfmLBydIcFLEzA=; b=D2Xvn0m2e5V7cYuXuN4Tng
	kODAkatgVkTxhzqHyHXdVj335YLT5y9O6DrrxlNRRS7YYKv9XVVILQSSMvye2aRq
	M126TyVQH46oN9bjIzBh7d8kaPlOOOKu0G8yr54J46jQDHIVocpGh3pjCHj/u+tQ
	CKdKjubUIwBplDaaqsiScr3xjPG7erdQONQ+wta3AkBP8mNknvRHsPBDlkQV+XKw
	LmQpTemABWfbDos19KdnycubeSDWJIdw52NgZTznWQS54mV3lKlXCX2vKaJueDGy
	i6K04I0lD6bpmgoCxbgYvwT6tHPrJARImYcPE2VcCXCDTt6M5K6BscjoMrIvryhQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm9jr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 12:03:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BIBvfAl027483;
	Thu, 18 Dec 2025 12:03:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm9jr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 12:03:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI9HB9h005806;
	Thu, 18 Dec 2025 12:03:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgp6tyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 12:03:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BIC2vhV30868154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 12:02:57 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E884B5805F;
	Thu, 18 Dec 2025 12:03:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4651D58053;
	Thu, 18 Dec 2025 12:03:10 +0000 (GMT)
Received: from [9.111.15.29] (unknown [9.111.15.29])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Dec 2025 12:03:10 +0000 (GMT)
Message-ID: <39e1536d956bfe061a4da7446c41a1b21eac0b37.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] PCI: Fix isolated PCI function probing with ARI
 and SR-IOV
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-s390	 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev,
        Farhan
 Ali	 <alifm@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald
 Schaefer	 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle	 <svens@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer
 <gbayer@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
In-Reply-To: <CAAhV-H6GE3q4qaPo9OvNkYOzatR-8BMYeGQ8hdmvKVZXbQF2rw@mail.gmail.com>
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
	 <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com>
	 <CAAhV-H6qqppoX_G5KrWmPor16bXfvNTE2x8Xx6yajAYPqxpigw@mail.gmail.com>
	 <958ef380be4ea488698fab05245d631998c32a48.camel@linux.ibm.com>
	 <CAAhV-H7iMKmLnisD-874D2ZC919sDYeWy3tw=+eUqifK--6-Dg@mail.gmail.com>
	 <8dd0f3df4b18a6c9f8b49ede7bc2ab71e40fd8f9.camel@linux.ibm.com>
	 <CAAhV-H4MNSiUqYpE919YcCaC-_-Q3GBwxRL13ggjsyLahQ-t1A@mail.gmail.com>
	 <7385677843a7790e01158644f63ae4dbb3353bfe.camel@linux.ibm.com>
	 <298aaf6b2815e59d1a94efffdd0e3b002c000cea.camel@linux.ibm.com>
	 <CAAhV-H7fgaZUuFSpE0VsMtptnrUTzh0TS=B9ZBUZ_=TH-XjKtg@mail.gmail.com>
	 <ba63ea826472b4f2d2a318784b710ee91fdca202.camel@linux.ibm.com>
	 <CAAhV-H6GE3q4qaPo9OvNkYOzatR-8BMYeGQ8hdmvKVZXbQF2rw@mail.gmail.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Dec 2025 13:02:09 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vgrpNl24YGyDx20ameyedl2cbLBpixmN
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=6943ed85 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=3P2TbqwfN0uRoQdgQsYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: W7uqNGQtZAmX7KmxRaciEjx68fhhEEQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX3sBwI6MTUQNp
 6JzZyUzh4niPL2EGkwplzLoVRn249gQAg4vyspmrMF1cm5dMmbFBWAGYjTimM/XKsc/Tib4gyIZ
 2Gjkp2AShgjqSrgKQNAsKKl0KQmCiYGdOtfW3gLlJ90ChnJ1oYDnD1J9IF8nnQB1beM+HDRXZGR
 sGvLFVY7NGRKcRzfYXLYe7IWZ3r4NajW9/tpjjXVmxn1UvwsijGlUvg6g3Aws/VS3LKvUZSvbTk
 mAYCSLbch5Hqgirv1Znd2V2zCQR6y0PMgWHAiLrArW9KUxxmlprkaPdNe0ZPczs+S97pw79w47a
 37vUtO9eJ9N5X7kvfuQ0FMI1CmjIs6PpD+Euq78x7Tc+aeUFT6Jgw3afftDzChtuSMMH6Gna7fd
 Xz6Tx1Di75djQiMxZXGGzGz4KEZxlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009

On Wed, 2025-12-17 at 14:55 +0800, Huacai Chen wrote:
> On Thu, Dec 4, 2025 at 5:45=E2=80=AFAM Niklas Schnelle <schnelle@linux.ib=
m.com> wrote:
> >=20
> > On Mon, 2025-12-01 at 22:45 +0800, Huacai Chen wrote:
> > >=20
> > --- snip ---
> > > You said that "it feels like this is just a hack to probe an odd
> > > topology". Yes, to some extent you are right.
> > >=20
> > > 1, One of our SoC (LS2K3000) has a special device which has func1 but
> > > without func0. To let the PCI core scan func1 we can only make
> > > hypervisor_isolated_pci_functions() return true.
> > > 2, In the above case, PCI_SCAN_ALL_PCIE_DEVS has no help.
> > > 3, Though we change hypervisor_isolated_pci_functions() to resolve th=
e
> > > above problem, it also lets us pass isolated PCI functions to a guest
> > > OS instance.
> > >=20
> > > As a summary, for real machines commit a02fd05661d73a850 is a hack to
> > > probe an odd device, for virtual machines it allows passing isolated
> > > PCI functions.
> >=20
> > Ok, thanks for the answer. So let's see how we can debug this and get
> > to a solution that works for both of us. Looking around a bit I see
> > that your pci_loongson_map_bus() has some special handling for trying
> > not to access non-existent devices added by your commit 2410e3301fcc
> > ("PCI: loongson: Don't access non-existent devices"). I wonder if with
> > this patch applied we're running into this same issue but with a devfn
> > that was previously not tried and is not covered by your checks? And
> > maybe since your root complex doesn't return 0xff for these non-
> > existent devices we could end up trying to probe AHCI on such an empty
> > slot misinterpreting whatever it returns as matching device/vendor?
> Commit 2410e3301fcc seems to have no relationship with current problems.

I'm not so sure. The only thing this patch is potentially supposed to
change is which devfns get enumerated and thus config space accessed
looking for a device. And that commit talks about accessing non
existent devices causing a system hang so that does seem fitting in
principle.

> >=20
--- snip ---
> > Could you try redoing the test with the AHCI hang but add a print of
> > the affected bus/device/function that AHCI thinks it is probing? Then
> > if the above theory applies we should see it trying to probe on a
> > device that is missing in the correctly booted case and got past your
> > existing checks.
> By redoing this test we found there is only one AHCI detected, and the
> BDF is: bus=3D0, device=3D8, fun=3D0.
>=20
> With or without this patch, only one AHCI. But without this patch, the
> AHCI initialization doesn't hang.
>=20


This is all very odd. Just so there is no chance of misunderstanding.
You did check the BDF that the ahci driver is trying to probe directly?
I.e. something like what I added as the top commit here:
https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=3Dloo=
ngarch_debug

This is because with the AHCI controller having a devfn 08.0 devfn and
likely dev->multifunction not set this patch would make a difference in
that it would try to enumerate 08.1 and so on while without this  patch
these would be skipped because of the=C2=A0dev && !dev->multifunction
condition even though isolated function probing should look at all
functions.=C2=A0And I was thinking maybe this causes us to end up trying to
probe an AHCI controller where there is none.

Another thing I could imagine, especially with commit 2410e3301fcc
("PCI: loongson: Don't access non-existent devices") in mind is that
accessing the device/vendor config space for some non existent devices
leaves your PCIe controller in some bad state and then the MMIOs for
the AHCI enable go lost or something. Maybe you could add debug code in
the relevant parts of drivers/pci/controller/pci-loongson.c to check
which devices get accessed with this patch vs without it? Would it help
if I provided a debug patch for that? Though I really don't know what
part is relevant for the system you're seeing the problem with.

Thanks,
Niklas

