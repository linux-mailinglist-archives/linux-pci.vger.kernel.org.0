Return-Path: <linux-pci+bounces-42264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF4C9222A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 14:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082403A6657
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177117A2F6;
	Fri, 28 Nov 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PYRaixLw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920D1A704B;
	Fri, 28 Nov 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336667; cv=none; b=Zj3UvhKtJJPg8mz6ZLt3+4YeAr2jEfu+CFmkmBCCn4gVwfoTEJTGkk0nWSncNWeY+JptA7tjQsoL4WVTDGcZSdOH1JtzOHZcc8mEgc7244Igzcmv9Tzy03iP+DgEFLxTcpLoW64R06yXYOchI9jRe+YiAZLNHc0awaHveZBCXWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336667; c=relaxed/simple;
	bh=+Mj9FTDQF7lL22MBA6jEDxvqLDfbjFX4Npa8q1V4TnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jAQP9MgHD8tyDwx8rznoLNPxtL91485T4RciAOPpTWZx+AI6OHQNL+yF9SoQ8ItTcLBks3lgiaQGg9RdYXIGEigGfs4/0LPs7EUMPZhHbWud8u4sUNH/YjeBlOh29DCcS2PTSpr7njpG1DaoO6vbjDJpPu9OoSIeHlVAd1ZpHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PYRaixLw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS8a7Lw019841;
	Fri, 28 Nov 2025 13:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Mj9FT
	DQF7lL22MBA6jEDxvqLDfbjFX4Npa8q1V4TnI=; b=PYRaixLwx0KYY2RtUkytRM
	3GoebQqXsEFU8E78piBVDDSz2AoEyJA6qvgWovQURhNpk+ttX2f1IxXtL0gbo6zL
	2O4gIWw4nVLna8NpxqGJ85a00sGGVOWUsBgtEIQvcO+zWQjCw7Vuj5cpm7bKE5ie
	dMP5pfBwvcjuI8xtRJGFXvRY0iiPSqshbVAdKbFMwMwZcy9v4H3ARZxUlpARYZMa
	Bx4ZnapEy/Ka0C+ihKn622HdMXSna3M7v011Fv9CXayGckNVG+42csXuhvtHZnXD
	/LyTR4rzxELg2aF/JH0HlORwvDTKSZjv80s5P4aJ3a/o0H0xJ/FPKKoGtVUDIhkw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvpk3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 13:30:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ASDNsON001898;
	Fri, 28 Nov 2025 13:30:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvpk3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 13:30:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ASBUGpN030842;
	Fri, 28 Nov 2025 13:30:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgswahf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 13:30:45 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ASDUiU327066964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 13:30:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AB0658059;
	Fri, 28 Nov 2025 13:30:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33C4A58063;
	Fri, 28 Nov 2025 13:30:41 +0000 (GMT)
Received: from [9.87.141.41] (unknown [9.87.141.41])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Nov 2025 13:30:41 +0000 (GMT)
Message-ID: <298aaf6b2815e59d1a94efffdd0e3b002c000cea.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] PCI: Fix isolated PCI function probing with ARI
 and SR-IOV
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Huacai Chen <chenhuacai@kernel.org>,
        Tianrui Zhao
 <zhaotianrui@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>, Bjorn Helgaas
 <bhelgaas@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
        linux-s390
 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev,
        Farhan Ali
 <alifm@linux.ibm.com>,
        Matthew Rosato	 <mjrosato@linux.ibm.com>,
        Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer	
 <gbayer@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date: Fri, 28 Nov 2025 14:30:40 +0100
In-Reply-To: <7385677843a7790e01158644f63ae4dbb3353bfe.camel@linux.ibm.com>
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
		 <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com>
		 <CAAhV-H6qqppoX_G5KrWmPor16bXfvNTE2x8Xx6yajAYPqxpigw@mail.gmail.com>
		 <958ef380be4ea488698fab05245d631998c32a48.camel@linux.ibm.com>
		 <CAAhV-H7iMKmLnisD-874D2ZC919sDYeWy3tw=+eUqifK--6-Dg@mail.gmail.com>
		 <8dd0f3df4b18a6c9f8b49ede7bc2ab71e40fd8f9.camel@linux.ibm.com>
		 <CAAhV-H4MNSiUqYpE919YcCaC-_-Q3GBwxRL13ggjsyLahQ-t1A@mail.gmail.com>
	 <7385677843a7790e01158644f63ae4dbb3353bfe.camel@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX1d+1eSa76rEn
 tKZjxRW8cld9HJV7v5UWoaT9TsycbLF4TNVqBAflmv6ZWti0XXsBtnysELI4UWP9nN9m1bJFUR0
 tTdP6rOBBzT1ugO6kQyk67TZXxHciUnYCm+4LpPQg1YcEY8PJceV7w3JjVge4acepjmjnfPqElD
 zcpCqas5xt3R4uSTua5+fTXNWMCK+L4WBG1MxNJZzs1OQqgQbdQP962weaB91TvOtnZbTp0PdX7
 hQ3VueHl7RjM6tWb9An5jlbqajqA0LWCZcTeKMLl0k3yj9mUOJGlAQQglJj1raBqVmE2u0c91zz
 2lNjrk3GjnUc5NlU9zrRkcsWZowbqM6NaIhOOAzgF835bcLfBti8PLeH337hzqKEN0qxmXnuT3W
 lueDF3uRYX7/+beXQtqL6F7zT78oUA==
X-Authority-Analysis: v=2.4 cv=PLoCOPqC c=1 sm=1 tr=0 ts=6929a407 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=9YU_gSLzOsAJnfYzwUAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NdMEprHNgVZa1g7F17S2cOL6dAqG01ZB
X-Proofpoint-GUID: 5CoJFNddypBoHofAxD7uoHOt_Pjyya5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

On Mon, 2025-11-10 at 14:08 +0100, Niklas Schnelle wrote:
> On Fri, 2025-11-07 at 15:19 +0800, Huacai Chen wrote:
> > On Wed, Nov 5, 2025 at 5:46=E2=80=AFPM Niklas Schnelle <schnelle@linux.=
ibm.com> wrote:
> > >=20
> > > On Wed, 2025-11-05 at 09:01 +0800, Huacai Chen wrote:
> > > > On Mon, Nov 3, 2025 at 7:23=E2=80=AFPM Niklas Schnelle <schnelle@li=
nux.ibm.com> wrote:
> > > > >=20
> > > > > On Mon, 2025-11-03 at 17:50 +0800, Huacai Chen wrote:
> > > > > > Hi, Niklas,
> > > > > >=20
> > > > > > On Wed, Oct 29, 2025 at 5:42=E2=80=AFPM Niklas Schnelle <schnel=
le@linux.ibm.com> wrote:
--- snip ---
> > > > > > >=20
> > > > > > > Still especially the first issue prevents correct detection o=
f ARI and
> > > > > > > the second might be a problem for other users of isolated fun=
ction
> > > > > > > probing. Fix both issues by keeping things as simple as possi=
ble. If
> > > > > > > isolated function probing is enabled simply scan every possib=
le devfn.
> > > > > > I'm very sorry, but applying this patch on top of commit a02fd0=
5661d7
> > > > > > ("PCI: Extend isolated function probing to LoongArch") we fail =
to
> > > > > > boot.
> > > > > >=20
> > > > > > Boot log:
> > > > > >=20
--- snip ---
> > > > >=20
> > > > >=20
> > > > > This looks like a warning telling us that AHCI enable failed / ti=
med
> > > > > out. Do you have Panic on Warn on that this directly causes a boo=
t
> > > > > failure? The only relation I can see with my patch is that maybe =
this
> > > > > AHCI device wasn't probed before and somehow isn't working?
> > > > The rootfs is on the AHCI controller, so AHCI failure causes the bo=
ot
> > > > failure, without this patch no boot problems.
> > > >=20
> > > > Huacai
> > > >=20
> > >=20
> > > Ok, I'm going to need more details to make sense of this. Can you tel=
l
> > > me if ARI is enabled for that bus? Did you test with both patches or
> > > just this one? Could you provide lspci -vv from a good boot and can y=
ou
> > > tell which AHCI device the root device is on? Also could you clarify
> > > why you set hypervisor_isolated_pci_functions() in particular this
> > > seems like a bare metal boot, right? When running in KVM do you pass-
> > > through individual PCI functions with the guest seeing a devfn other
> > > than 0 alone, i.e. a missing devfn 0? Or do you need this for bare
> > > metal for some reason? If you don't need it for bare metal, does the
> > > boot work if you return 0 from hypervisor_isolated_pci_functions() wi=
th
> > > this patch?
> > 1. ARI isn't enabled.
> > 2. Only test the first patch.
> > 3. This is a bare metal boot.
> > 4. If hypervisor_isolated_pci_functions() return 0 then boot is OK
> > 5. PCI information please see the attachment.
> >=20
> > Huacai
>=20
> Thanks for the input. As far as I can see the lspci from a good boot
> shows no holes in your devfn space so this particular system doesn't
> seem to need the isolated function probing at all. But even then using
> it should only try out all devfns and thus never skip one that is found
> without isolated function probing.
>=20
> To sanity check this, I just booted my personal AMD Ryzen 3900X system
> with this series plus a two-liner to unconditionally enable isolated
> function probing also on x86_64 and it came up fine including AMD
> graphics and my Intel NIC with enabled SR-IOV.=C2=A0
>=20
> So I'm really perplexed and coming back to the thought that a device on
> your system is misbehaving when probing is attempted and maybe due to a
> similar issue as what I saw with SR-IOV it wasn't probed so far but
> really should be probed if isolated function probing is enabled. I also
> still don't understand your use-case. If it is for VMs then maybe you
> could limit it to those? Otherwise it feels like this is just a hack to
> probe an odd topology and I wonder if you should rather set
> PCI_SCAN_ALL_PCIE_DEVS to find those?
>=20
> Thanks,
> Niklas

Hi LoongArch Maintainers, Hi Bjorn,

Sorry for the ping but I'd really like to somehow get this unstuck and
I haven't heard back on my previous questions. From my testing on s390
this patch fixes a real logic error which prevents the scanning of some
devfns which I believe should be scanned if isolated functions are
possible. And in all my testing, including on x86 as stated in the
previous mail, the code does exactly what I think it is supposed to do.
So to me it really looks like something goes wrong with your use of
hypervisor_isolated_pci_functions() on your specific hardware.

One idea I had is if maybe you need to somehow exclude known empty
slots in you config space accessors?

And just in general I'd really like to better understand your use-case
for the isolated PCI functions. And speaking of that, I'm sorry for
having been so blunt in my last mail saying that it felt like a hack.
I'm just worried, that we've run into incompatible interpretations or
uses of this feature that now prevent us from fixing actual bugs.

Thanks in advance,
Niklas Schnelle

