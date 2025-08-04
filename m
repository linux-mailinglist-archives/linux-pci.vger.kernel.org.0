Return-Path: <linux-pci+bounces-33355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C093CB19F7B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 12:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC86F162E9C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A931222565;
	Mon,  4 Aug 2025 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UY9Vi8HB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3882200113;
	Mon,  4 Aug 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302208; cv=none; b=aq1i8MeNtoJVP/TksOQ3pdQWKCpIqPyOyJ3faaUMoFR+6Z2D2jjZ2i/qCcSLGmAeoW36ijG6UAZHHRiJ00AIFMgUHmJ325eeqeZYLFJgSE7Jlv7kNGoxT5PtM1s/zDFsgblrA7SCGsJlDQxv3wJ+93XXr0x8dOQi5yNDnI9VHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302208; c=relaxed/simple;
	bh=kCIchFC91452xWiDloGI6pBYIBOUJAAvwMrZE/NTCJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2jKOVpRZjbLNQP3MgN3A0NrHi+b+EAqamkpe8SizqDzUgplVJkKmAyQZOxevMSQVYw6SCz1AcP5KYE0HTJ5TAb3ymsPujtAHmrYyhGNDHLzpgj+EcETMd49VxO+7dcLf0nrlgLDX5QBsloEWC51ok/W+i98zr207dPG3XTK2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UY9Vi8HB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5744Y4d7023414;
	Mon, 4 Aug 2025 10:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kCIchF
	C91452xWiDloGI6pBYIBOUJAAvwMrZE/NTCJE=; b=UY9Vi8HB7cvg0CNVS4+YgH
	QhZjl91sJ7RvUL0RFfLBiZ8XuqWC8AfkSh4hVRKGCbHTS3oJXv5EvWRTdxbQ7Vuh
	lccBuFbJKTWZ4jPHLIp613jpW/v+4qT5ch87wS4womSGMtatY7n6EUjmwptaACxk
	SQ+ENRAw0MsC3+wAsuTWS6dsiYP/S0IB5ZXDJwE6RW+mhIDqFR8vcKozmDFtNSm7
	pp5r1ii+kyu5v+0ASyGNCtku4TCZix0kf0xNYrvobIuHEao4LgRlmM50k9Lpu4LT
	+dvMwQUEz1zodHGVpcFmaUUfFjBkiLZ2LHf760lvVnQ3H7KVmJYZQkHksfbO7blg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4a9v802-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 10:09:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5749vnmU011650;
	Mon, 4 Aug 2025 10:09:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4a9v800-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 10:09:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5749lLPB001893;
	Mon, 4 Aug 2025 10:09:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489wcywc8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 10:09:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 574A9o7I19333514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 10:09:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06A8A20091;
	Mon,  4 Aug 2025 10:09:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 127F12009C;
	Mon,  4 Aug 2025 10:09:49 +0000 (GMT)
Received: from [9.111.44.231] (unknown [9.111.44.231])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Aug 2025 10:09:48 +0000 (GMT)
Message-ID: <6efa10219a41907ebdd7b75fc8d9249e115e8864.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Hans Zhang <18255117159@163.com>, Manivannan Sadhasivam
 <mani@kernel.org>,
        Hans Zhang <hans.zhang@cixtech.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        bhelgaas@google.com, Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
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
Date: Mon, 04 Aug 2025 12:09:48 +0200
In-Reply-To: <06012cc6-824d-4a7d-85c9-9995ec915382@163.com>
References: <20250731183944.GA3424583@bhelgaas>
	 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
	 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
	 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
	 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
	 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
	 <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
	 <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
	 <06012cc6-824d-4a7d-85c9-9995ec915382@163.com>
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
X-Proofpoint-GUID: OZzhOq8J5iZn496zPRbscm-5Hy0dBrtO
X-Authority-Analysis: v=2.4 cv=dNummPZb c=1 sm=1 tr=0 ts=689086f4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KeptLckSEblKyysDGeUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: j6p5zJLpsip5j-2v6i90-PlIrzZuLfHR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA1MyBTYWx0ZWRfX6aNNP/68Zpyr
 8lpqw2QcidMFKrCzDxDrKDKQtaQhnZnnhaW5MyvRF/wzvR1lklNLeZE53DsQwtU72NNYXxpo8O6
 dpivStlLuL8nzhybh2j8vaXk+vN+pALHKh92OR9DzrnXXXaPVRPikwBjsR6rjOWfpjQto57Axo+
 +41/yohAugkeJX6QlN0GyqdPqiNsUE/EvrQkBrQN8yEJt3+ixkFU8CqwOp8BfDKvfry2CFHqFFN
 yEoB2fdweG1nsFm0naIhGOhKStSmoce5DX6EUN5urVkZNVfy5cLWX4GtRBgKeDlHEL43HPVJwZF
 4D/WXX37Uir8pTwm6hWFc+aen0fQ0X8eh0WZ8v5SCJZD3jkwKLIo+YdWANJBZNTl9hCLPBrItbY
 TRnCuec3P3YVHPDFKC2qL7/Ihhq5NDELATMOcQ0mbEoFFEX0msYqYoToWq4tTBCw6x8N4qzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=970
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040053

On Mon, 2025-08-04 at 11:06 +0800, Hans Zhang wrote:
>=20
> On 2025/8/1 19:30, Gerd Bayer wrote:
> > On Fri, 2025-08-01 at 16:24 +0530, Manivannan Sadhasivam wrote:
> >=20
> > <--- snip --->
> >=20
> > > > >=20
>=20
> Dear all,
>=20
> According to the issue mentioned by Lukas and Mani. Gerd has already=20
> been tested on the s390. I have tested it on the RK3588 and it works=20
> fine. RK3588 uses Synopsys' PCIe IP, that is, the DWC driver. Our=20
> company's is based on Cadence's PCIe 4.0 IP, and the test function is=20
> normal. All the platforms I tested were based on ARM.
>=20
> The following is the patch based on the capability-search branch. May I=
=20
> ask everyone, do you have any more questions?
>=20
> Gerd, if there's no problem, I'll add your Tested-by label.

Before you add that I'd like to re-test with the "final" patch.

> Branch:=20
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=3Dcapa=
bility-search
>=20
> Patch:

<--- snip --->

Please bear with me while I'm working on that.

Thanks, Gerd

