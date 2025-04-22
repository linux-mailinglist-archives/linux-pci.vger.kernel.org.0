Return-Path: <linux-pci+bounces-26373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B46A96570
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C8D3A4D10
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0D215066;
	Tue, 22 Apr 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mw2om6QX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745E214815;
	Tue, 22 Apr 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316477; cv=none; b=htE/awepdxZNtYrFlBt569MfPZSEGnPtr6t8Zj4FG7UmYRB1YE25t+JxCAtlSwm7LVDB96OfTFbPI/P6H6Zzh0vAQWt084DJ2AGpiNIOfyrp9db4Y/ZyAqgNOe2t2FZa+lVZvlku8gJbj1afJUJ1bIbF6vfhlGr9A2EKJ5etcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316477; c=relaxed/simple;
	bh=8cOGVJxDOge6yd1h4WUPOxxzzkPc5/AYCo0p4Re+mLA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n5WwvMJIgEoAgc6FZmGNeZyNl5ZHeeWMhHINDiBPgtQXBNP3/GalgEUYZFm5XDGuzfb8gb7mykoKWseMmFhrxGY+n/Q0lXj7Qlr297TmTfvmVl2C4xJkODjoQstCvMApI6p7T+ZqlqE97wv5lpG4Yf3SaHXAgqocBxZSWxtCHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mw2om6QX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M87hVK014841;
	Tue, 22 Apr 2025 10:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y0zwdS
	/anOdu3jGgJ6+CBGkd+gprMEsGjEvIXahhhsw=; b=mw2om6QXra8BWuGgkLYpgo
	NTzCd6HXyCx9FL0xLnJg7Yj0XTgOzYOH/XUzJx95fFIEXA41YdgQFWApWOPItOLH
	Z/AhKiipqtfbvQC0KxBGBdIeNu8AGbHr8w4fgCkhRv0rLPRrBPhhhRBTN1rhT9i6
	cPmUvDe2pTVm3agAZ1lgQJGBAoieHM5Emf6ouaUB67J3q0YGQ4mz0TD/JgCr4+wD
	Abmnl4vzy6kyUE8bbJIZLMMg5miHBENhHiwiJaO4SGT+BIxSbZC6RPRpQ8RHZejX
	4PdvMbEMWFVJzCGFumvIkyxzrFhEIO19ekdcqGSNnJTr4u/8s1M29ZjNZfF+Z5PQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4667ap0jm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:07:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M9x1iD011529;
	Tue, 22 Apr 2025 10:07:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4667ap0jky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:07:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M6d9XT002965;
	Tue, 22 Apr 2025 10:07:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464q5njb98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:07:17 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53MA7H4K28902116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 10:07:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E64005803F;
	Tue, 22 Apr 2025 10:07:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80C6E58056;
	Tue, 22 Apr 2025 10:07:12 +0000 (GMT)
Received: from [9.111.69.144] (unknown [9.111.69.144])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 10:07:12 +0000 (GMT)
Message-ID: <6a0357d08784348e677d631b76dfcc3fe79d56b7.camel@linux.ibm.com>
Subject: Re: [PATCH 6.14 000/449] 6.14.3-rc1 review
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju
	 <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        hargar@microsoft.com, broonie@kernel.org,
        PCI <linux-pci@vger.kernel.org>, linux-s390@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam	
 <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski	
 <krzysztof.kozlowski@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 22 Apr 2025 12:07:11 +0200
In-Reply-To: <2025041852-unlined-rug-e71e@gregkh>
References: <20250417175117.964400335@linuxfoundation.org>
	 <CA+G9fYvz0kujF4NjLwwTMcejDF-7k7_nhmroZNUJTBg4H4Kz8Q@mail.gmail.com>
	 <2025041852-unlined-rug-e71e@gregkh>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5pNKzws c=1 sm=1 tr=0 ts=68076a57 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=KKAkSRfTAAAA:8 a=LU2pTsyjGqQukD67lgoA:9
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Sjhf-4i1oGQsJ_c9vU_7NQNc16E5wjo_
X-Proofpoint-GUID: f_rNDMdCFB1W1utfRXdsBrLzl8_MYyDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxlogscore=867
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220075

On Fri, 2025-04-18 at 13:03 +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 18, 2025 at 12:00:33PM +0530, Naresh Kamboju wrote:
> > On Thu, 17 Apr 2025 at 23:23, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >=20
> > > This is the start of the stable review cycle for the 6.14.3 release.
> > > There are 449 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >=20
> > > Responses should be made by Sat, 19 Apr 2025 17:49:48 +0000.
> > > Anything received after that time might be too late.
> > >=20
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.14.3-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.14.y
> > > and the diffstat can be found below.
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > Regressions on arm64 and s390 allmodconfig and allyesconfig builds fail=
ed
> > on the stable rc 6.14.3-rc1 with gcc-13 and clang-20.
> >=20
> > There are two different types of build errors on arm64 and s390.
> > These regressions on arm64 are also found on stable-rc 6.13 and 6.12.
> >=20
> > First seen on the 6.14.3-rc1
> >  Good: v6.14.2
> >  Bad:  v6.14.2-450-g0e7f2bba84c1
> >=20
> > Regressions found on arm64 s390:
> >   - build/gcc-13-allmodconfig
> >   - build/gcc-13-allyesconfig
> >   - build/clang-20-allmodconfig
> >   - build/clang-20-allyesconfig
> >=20
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducibility? Yes
> >=20
> > Build regression: arm64 s390 ufs-qcom.c implicit declaration
> > 'devm_of_qcom_ice_get'
> >=20
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >=20
> >=20
--- snip ---
>=20
> >=20
> > ## Build log s390
> > arch/s390/pci/pci_fixup.c: In function 'zpci_ism_bar_no_mmap':
> > arch/s390/pci/pci_fixup.c:19:13: error: 'struct pci_dev' has no member
> > named 'non_mappable_bars'
> >    19 |         pdev->non_mappable_bars =3D 1;
> >       |             ^~
>=20
> Will go drop the offending commit now too, thanks!
>=20
> greg k-h

Hi Greg,

This looks like we're missing commit 888bd8322dfc ("s390/pci: Introduce
pdev->non_mappable_bars and replace VFIO_PCI_MMAP") which is a
prerequisite. I wonder if you might want that anyway to keep struct
pci_dev consistent when other backports might touch it. The original
commit aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except
for ISM devices") isn't strictly a fix but it adds quirk support so
could be relevant for future backports. There is also a chance that we
may backport it for RHEL/SLES/Ubuntu in the medium term.

Thanks,
Niklas

