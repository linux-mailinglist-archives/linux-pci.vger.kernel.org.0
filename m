Return-Path: <linux-pci+bounces-42594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FFDCA1B55
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 22:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBF7301A725
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 21:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95BF2DC76D;
	Wed,  3 Dec 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wf78Om6L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD42D7DDC;
	Wed,  3 Dec 2025 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798327; cv=none; b=DCcNZ8b+Daoi9Arbf1N4dQu3PXcYJyCXUJNBZbhw+PhDMHIgU+oEQwgctBAC+m/4WoAgKY2rQojiKd/N0G80EIKh0/HYFt8+3fk2d5owjb9o41iJYTAgSP7GSU20RtYn4U7qudB70NTvhgR1obGPqrO/Y4/C5STLhcuhGxk2YTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798327; c=relaxed/simple;
	bh=XgbLLlO7v6nyZY5doFPfjPz9ifoAQt8AXNBb+SVODXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sy2zHJflKD/YM0CRHwur8bw0hOQBdf/yjlSoC6Ix7eMSsK4tSY88cxBqnJqqlEKrYEHOskXD7BighuusM9Zu6DRHSZZ7tMzsYRyEdYDMqyxSxZtFgsRdquQ2ZYMT3EnGZ+Njy59RfobStocmt70KXARJjCACStHzGwKbssIkbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wf78Om6L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3GPBWZ017878;
	Wed, 3 Dec 2025 21:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XgbLLl
	O7v6nyZY5doFPfjPz9ifoAQt8AXNBb+SVODXI=; b=Wf78Om6Lkggwo4GU2ZhKKC
	DBgBsI78KU3WeBt34nigt/Mc3TEuM4NDc2Ltmmet/UgAVlhFlClt3fnx4lp1cDVx
	+9V/Y9/OUbJ7ksSmaBNXIGpqdqC8+ZlYLmPauFVx8Y++9gef7aGqtjfLCfanmBNz
	WYemOxBE257/z63F/GghjApJQ3YS981+1y3VDzdTQBa/F8SclXQQO9QetPGvyoHD
	8nAsVn5kmct7mt7Efs8Bgbw8vEBciPOrnqiWa6aKKE9JyyzVfnlC/46nPi3XYHQ1
	fNxqL35a8K0/MZsSLtMlTgBxdwtON86x61iLKJu/fOCiWD1CuRyUSHsBKKVolSZg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q4twf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 21:45:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B3Lhbvs002751;
	Wed, 3 Dec 2025 21:45:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q4twd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 21:45:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3K8ku4029328;
	Wed, 3 Dec 2025 21:45:10 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1m95q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 21:45:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B3Lj9O810945156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 21:45:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED50958069;
	Wed,  3 Dec 2025 21:45:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD73858053;
	Wed,  3 Dec 2025 21:45:05 +0000 (GMT)
Received: from [9.111.80.152] (unknown [9.111.80.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Dec 2025 21:45:05 +0000 (GMT)
Message-ID: <ba63ea826472b4f2d2a318784b710ee91fdca202.camel@linux.ibm.com>
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
Date: Wed, 03 Dec 2025 22:45:04 +0100
In-Reply-To: <CAAhV-H7fgaZUuFSpE0VsMtptnrUTzh0TS=B9ZBUZ_=TH-XjKtg@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX+NzvQYtOWsv0
 lKEtpag2NIcrdLEaMnzbCBFivFzKQMan2pG6NTEPKAmW4Jds8s0dF41rCxd2YXOhu3nWY5JzeJr
 OhKXaVzRKoxppy8Q8ngdoI+DrObt/Esm524cflLAh4i16ahhoHrZ2yzwTavRDyy/5HkS6gLYfpJ
 MxkwC3IMbngcYCykJKJF3saQyp1K1D/v8cq6eyiKXD6sEb/nrgsTsQ2f25WvamJAivqIwRrw9qV
 tTKlO7NbbltlNq3hMvQQVI8/LKUHKUmEJZPi5fErxIzCbdBZStwiSRKxw/pesvKUs6YSKkESLjp
 rWUaYrLiy6zUjkEsYSzZSv+OR81UWQP3chM8rFdryliOLi6B/LEKVJfpA4d++RrZyNWlDmCAZIX
 Mt7jDJBtJPmgEhcipvPpCcatYwqlfA==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=6930af67 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=5gJIf5bccVYq2KwzBKQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: M16xe1CiTStw0iZsDQA8qMh-U4aKzUFD
X-Proofpoint-GUID: KDfZ4tdNi--A2JNzvpmoJxaHIFoQ0u7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

On Mon, 2025-12-01 at 22:45 +0800, Huacai Chen wrote:
>=20
--- snip ---
> You said that "it feels like this is just a hack to probe an odd
> topology". Yes, to some extent you are right.
>=20
> 1, One of our SoC (LS2K3000) has a special device which has func1 but
> without func0. To let the PCI core scan func1 we can only make
> hypervisor_isolated_pci_functions() return true.
> 2, In the above case, PCI_SCAN_ALL_PCIE_DEVS has no help.
> 3, Though we change hypervisor_isolated_pci_functions() to resolve the
> above problem, it also lets us pass isolated PCI functions to a guest
> OS instance.
>=20
> As a summary, for real machines commit a02fd05661d73a850 is a hack to
> probe an odd device, for virtual machines it allows passing isolated
> PCI functions.

Ok, thanks for the answer. So let's see how we can debug this and get
to a solution that works for both of us. Looking around a bit I see
that your pci_loongson_map_bus() has some special handling for trying
not to access non-existent devices added by your commit 2410e3301fcc
("PCI: loongson: Don't access non-existent devices"). I wonder if with
this patch applied we're running into this same issue but with a devfn
that was previously not tried and is not covered by your checks?=C2=A0And
maybe since your root complex doesn't return 0xff for these non-
existent devices we could end up trying to probe AHCI on such an empty
slot misinterpreting whatever it returns as matching device/vendor?

And looking at pdev_may_exist() does the "device <=3D 20" really make
sense with 20 in decimal? If I pull in the negation I get "device > 19"
But if it was 0x20 I'd get "device > 0x1f" which would match the
maximum value of PCI_SLOT(), though then the check would be redundant
since the device value already comes out of PCI_SLOT().

Could you try redoing the test with the AHCI hang but add a print of
the affected bus/device/function that AHCI thinks it is probing? Then
if the above theory applies we should see it trying to probe on a
device that is missing in the correctly booted case and got past your
existing checks.

Thanks,
Niklas Schnelle

