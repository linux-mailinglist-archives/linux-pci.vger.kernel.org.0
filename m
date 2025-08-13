Return-Path: <linux-pci+bounces-33934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C520CB24310
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 09:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5E91B63622
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B82E36EB;
	Wed, 13 Aug 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BumDLob7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48082DEA7D;
	Wed, 13 Aug 2025 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071289; cv=none; b=WHUPyRRx6u5XyNrwfq+cOnOGP3r4vsps5nMKcQ6h/b1jWXs9vEsoNU6h+dQnx7Nb5uPjHeVGDt+rZIce7SXIID3msmzC5ZTwt8dFqhtuie4pb/LLv+mqrrPqWKL5JqQO3h/7C64+u21IYppG0LHc9Ogw+mQZX+E22ngkenJkUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071289; c=relaxed/simple;
	bh=JCYBg4OAgn17xVDSuwNbbRjqaPtlyKjd0RtPJOqdhRM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uqHeguqRZoRQ9xx43wUi/vCSE4d9ir+Eq8XM6drXAGpMe+JiI5jr3JHbr0ijck9ISD5lD2YNzj6jhU8h1dcWmPloG6fokI9DUXN6+TknYFx/4Wi7yJH4kuVA/5sttyUo+4aF/UuHKPmolWsZ1sAfNrCPf3DhVARiZtvwa2FV0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BumDLob7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQPmL016645;
	Wed, 13 Aug 2025 07:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JCYBg4
	OAgn17xVDSuwNbbRjqaPtlyKjd0RtPJOqdhRM=; b=BumDLob73wKOv6Xdu/g7o/
	l9pPkE99gnd06AmeidEWeCd4JZOpbl1/bbyJsOOXYH9UJ4YG2cPJZaa5K1CjzxjJ
	JL2HbDvFPHZX/ITBxLlEsu2l39gk+2MvHT8hx9j8pKLW6s7JeFDRzsp5v+3D0/O5
	GmglIKgVwRUs0zOb2xsXHdJX+2X/+ao6qZNuLFJb4kon1pG45X2kUJ4N3Sd64O3G
	VrZFY9vVRSVDOdQHmsj5uujd1+pYwTolFu83Fktpcnp9N2IntadIbCVMwUs4Iu7p
	md9Bcq/mMm167Mqsu4QmUJ8jHk6cqK/H7gxOVhTvoXqwjcroASQJkNOPV/7lfIqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14k68r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 07:47:58 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57D7l1hS026807;
	Wed, 13 Aug 2025 07:47:57 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14k68m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 07:47:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6K6Lf010832;
	Wed, 13 Aug 2025 07:47:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnupg45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 07:47:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57D7ltdf39060110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 07:47:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F31DC58053;
	Wed, 13 Aug 2025 07:47:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E33E58043;
	Wed, 13 Aug 2025 07:47:51 +0000 (GMT)
Received: from [9.111.52.106] (unknown [9.111.52.106])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 07:47:51 +0000 (GMT)
Message-ID: <8d5b5e0450ac4a4f8ca0a9d7b9399a7b0b5eee00.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Hans Zhang <18255117159@163.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Manivannan Sadhasivam
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
        Rob Herring <robh@kernel.org>, geert@linux-m68k.org
Date: Wed, 13 Aug 2025 09:47:50 +0200
In-Reply-To: <9d0cce06-25fa-4ca6-8cd1-388e932d1ffc@163.com>
References: <20250731183944.GA3424583@bhelgaas>
	 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
	 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
	 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
	 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
	 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
	 <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
	 <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
	 <06012cc6-824d-4a7d-85c9-9995ec915382@163.com>
	 <6efa10219a41907ebdd7b75fc8d9249e115e8864.camel@linux.ibm.com>
	 <9d0cce06-25fa-4ca6-8cd1-388e932d1ffc@163.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
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
X-Proofpoint-ORIG-GUID: 1_vyGLtzX7V_HecwOFMXLGRdnWWIN-aa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfXwHvEx7Z0vvO1
 g2Hl+peYe/Hd9eOEkJiou/NmEN1g/FQbITUuQ8gH7t+Mn4qdzpj+Fo8u0o79SLGnCN9xZsIegYn
 cOE9zPk5cD0l21lkK6wj2YXuMtc3mYBTsbFkkLKlUCxaeMZc3gdkVaDhp1jh40oChIG3Z0SYP9P
 DfMf8irBJvlG44wf0h5eNbwbUqnyF0gtE3UXXmpWA0fAMBq/LbOEIHbBobGKlQnVGpLDpPI5A8b
 vxnCD4JImUgWi6rRN2VwtJXQp+yALALd/bdECTjqtYj1qXhZDyDCQ/yZeIHJ8hPmlWrLzpqOshG
 1OnQUZyLl9OEAU9ANiEouAWnLMUBFgViZIOs0tASBrUztivWw3ejdf9GRcvqnjKqChREliOYCpB
 F8eK9rPu
X-Proofpoint-GUID: -mgwkKpG30YvipniN3jUEyvm8saiPP3K
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689c432e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=JnRP6V50eTwq9YoO59MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

On Tue, 2025-08-12 at 22:44 +0800, Hans Zhang wrote:
>=20
> On 2025/8/4 18:09, Gerd Bayer wrote:
> > On Mon, 2025-08-04 at 11:06 +0800, Hans Zhang wrote:
> > >=20
> > > On 2025/8/1 19:30, Gerd Bayer wrote:
> > > > On Fri, 2025-08-01 at 16:24 +0530, Manivannan Sadhasivam wrote:
> > > >=20
> > > > <--- snip --->
> > > >=20
> > > > > > >=20
> > >=20
> > > Dear all,
> > >=20
> > > According to the issue mentioned by Lukas and Mani. Gerd has already
> > > been tested on the s390. I have tested it on the RK3588 and it works
> > > fine. RK3588 uses Synopsys' PCIe IP, that is, the DWC driver. Our
> > > company's is based on Cadence's PCIe 4.0 IP, and the test function is
> > > normal. All the platforms I tested were based on ARM.
> > >=20
> > > The following is the patch based on the capability-search branch. May=
 I
> > > ask everyone, do you have any more questions?
> > >=20
> > > Gerd, if there's no problem, I'll add your Tested-by label.
> >=20
> > Before you add that I'd like to re-test with the "final" patch.
> >=20
> > > Branch:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=3D=
capability-search
> > >=20
> > > Patch:
> >=20
> > <--- snip --->
> >=20
> > Please bear with me while I'm working on that.
>=20
>=20
> Dear Gerd,
>=20
> May I ask if there is any update?
>=20
>=20
>=20
> I plan to submit the v15 version of my series based on v6.17-rc1.
> The modification method is like the previous comment:
> https://lore.kernel.org/linux-pci/06012cc6-824d-4a7d-85c9-9995ec915382@16=
3.com/
>=20
> Best regards,
> Hans
>=20

Hi Hans,

Gerd is currently out so I just gave the patch you provided against
capability-search-v14 a try on s390. Didn't see any issues with the
previously broken device probing. As I understand it Bjorn asked you to
send a complete v15 and then for people to test that. I like that
approach and would prefer to provide a Tested-by for v15 rather than
via a patch on top. Gerd should be back next week too. Does that work
for you?

Thanks,
Niklas Schnelle

