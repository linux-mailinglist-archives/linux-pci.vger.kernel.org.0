Return-Path: <linux-pci+bounces-39260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2ECC05910
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6232835BB8C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81E30FC24;
	Fri, 24 Oct 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OjdqHOtE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989F30F95A;
	Fri, 24 Oct 2025 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301661; cv=none; b=PT/lzLij2xNZijKV8Z6RuDTr1iZ3B+v35XwituKGM/BkK0LVoHy3iRA0vJMrk6N0QnW94NGNnydcs6P3lQCDvDzzkRWhLxAc32uS+N9Z4RmHXcRsSf5eludnd2E7oPXdaiM8MpJwT11A4Y+SeZpO/w9AKYaYZJ4tMna9xj8VTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301661; c=relaxed/simple;
	bh=Qcr0AH4NBBDwIkxjxqfEp4Ryph/lRbmVNocbpKGbTvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHlVMIHnXQlTA6la2HZa5h+HkkWclN9GE+lApIjxruIwEC8GTxfl9kEHPDjacJ1ITq+ZbIiKIeDiS3JesNOsm1ih44Io6thig2Sa+ie5bgypEwAJ+VKXtOowMtZXQxtiI/sf7sAx/EUHDvk78T8GM9ZlmeAuLazTfwWttfOeFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OjdqHOtE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O30IjF028945;
	Fri, 24 Oct 2025 10:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qcr0AH
	4NBBDwIkxjxqfEp4Ryph/lRbmVNocbpKGbTvg=; b=OjdqHOtEfI/cvBK3zg0DTg
	4C839JM5/oll4Wv5WF/VK7ansQE3WyrzS/9Y+dPteMZO0ZQH+2XjqJVwVC952U9v
	uZtSLj0de75Tjxm1S4r/IO04vxnKGyslcLXYJbv7eSJWy+mfGIUXZDLhM7Vge+KC
	NMKcNTRZbzh5FRIyjevQacRAZvmIRg6LDADPhROoevu5S4fJch0RVlIRGTpjbQoj
	aRo6ZOfl5KW5puxAwlJqP+ElE/NJ54U9FiZROOd9zNNVdA8A/qO6JRp1eEEDaffg
	6XdrYkGW2ezZtvb+dDDG0uwi353W//BY9bhfTLmPeSLqTGbFS46FJDOEw34c5i2A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3276tpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 10:27:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O78fCm011020;
	Fri, 24 Oct 2025 10:27:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1jb78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 10:27:23 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59OARMMw27984606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 10:27:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41F395805D;
	Fri, 24 Oct 2025 10:27:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FE6358059;
	Fri, 24 Oct 2025 10:27:20 +0000 (GMT)
Received: from [9.111.76.213] (unknown [9.111.76.213])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 10:27:19 +0000 (GMT)
Message-ID: <f35bc644d828f5b9014fb11ac6439314e279a5da.camel@linux.ibm.com>
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
Date: Fri, 24 Oct 2025 12:27:19 +0200
In-Reply-To: <CAAhV-H58cjSgPLPfSSZD4DSSct_bKLF6SYMSJpBwdUT8NY3AhA@mail.gmail.com>
References: <d3f11e8562f589ddb2c1c83e74161bd8948084c3.camel@linux.ibm.com>
	 <CAAhV-H4Q932R0fAbL6JyygZcgALdO_HJZ1Cqo88EhNMm04yjtQ@mail.gmail.com>
	 <163456ca8cf900e24fe3b9ce71fdad7b68398058.camel@linux.ibm.com>
	 <CAAhV-H58cjSgPLPfSSZD4DSSct_bKLF6SYMSJpBwdUT8NY3AhA@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fb548c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=5Zwm3hv9jxCSVIX1CyEA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2OwVJYLA+Jcs
 BTat2w//VULR93Yej3DUCkL2vzwBKQ1hRG7rm/wuShl504UVi207UKvIe+VPHukaLKkR2U4PbsX
 Xr0xuGKw5EPPdw0HU4Pma251/cpWycpqCs3buFTo0ZvH9O/LHSNMHJSzLMrZf7ElVw4YX0+MDDP
 NthY+0xnbxbTVzurZl1C3H/tomkS94YH8O7sQhj7IIB7imiPQVLlHbO0Qawy45d15yNIPEdcu4y
 HwhU30QBZTCkhTjON7FCHGkmbGfH5XlKZnRgvRkjEEkDQAY4JlsG3wWAlfXmtESUIdh1zVjofzk
 kEpJUF24dOhKou5NYMHZOzyyZS/gsCrz8BEZ6lc3R2n/GiRo8CWfx21SbWTQeIufOUy/TF38XAm
 ahghcC9sx+No2GZlT8s1jsMOxw8sQA==
X-Proofpoint-GUID: CwDF-HNum2cyy9Bp2IVpj4wQbKBGQzj7
X-Proofpoint-ORIG-GUID: CwDF-HNum2cyy9Bp2IVpj4wQbKBGQzj7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Fri, 2025-10-24 at 18:05 +0800, Huacai Chen wrote:
> Hi, Niklas,
>=20
> On Thu, Oct 23, 2025 at 11:25=E2=80=AFPM Niklas Schnelle <schnelle@linux.=
ibm.com> wrote:
> >=20
> > On Wed, 2025-10-22 at 22:49 +0800, Huacai Chen wrote:
> > > Hi, Niklas,
> > >=20
> > > On Wed, Oct 22, 2025 at 7:40=E2=80=AFPM Niklas Schnelle <schnelle@lin=
ux.ibm.com> wrote:
> > > >=20
> > > > Hi Huacai, Hi Jan, Hi Bjorn,
> > > >=20
> > > > I noticed that with commit a02fd05661d7 ("PCI: Extend isolated func=
tion
> > > > probing to LoongArch") LoongArch now also makes use of the isolated
> > > > function probing. First, nice to see this sees more users and that =
the
> > > > interface is useful to you.
> > > >=20
> > > > Seeing this, I was reminded of an issue I ran into when using this
> > > > mechanism with SR-IOV capable devices. In that case VFs with devfn =
> 7
> > > > and PCI_SLOT(devfn) !=3D 0 wouldn't get probed.
> > > > This is because if a device is found next_fn() will check whether d=
ev-
> > > > > multifunction is set. So if for example devfn =3D=3D 8 is found (=
fn =3D=3D 0)
> > > > dev->multifunction won't be set in pci_scan_slot() and for VFs it's
> > > > also not set via PCI_HEADER_TYPE_MFD. So we won't check for devfn =
=3D=3D 9
> > > > even though that could very well be there.
> > > >=20
> > > > Now for s390 this currently doesn't cause issues because for all
> > > > multifunction devices we have, we either get a VF alone and then si=
nce
> > > > commit 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs") use d=
evfn
> > > > =3D=3D 0, or we have the parent PF passed-through and then VFs alwa=
ys get
> > > > hot plugged after SR-IOV enable, which then uses
> > > > pci_scan_single_device(). And for non VFs we always have devfn =3D=
=3D 0
> > > > and/or devfn =3D=3D 1 and multifunction via the header. So in a sen=
se the
> > > > above commit works around the issue, though that wasn't its primary
> > > > intention.
> > > >=20
> > > > Did either of you also run into this issue or can reproduce it?
> > > >=20
> > > > Somewhat related, if ARI is enabled this would also break the isola=
ted
> > > > function case including on s390 where ARI is used by the platform
> > > > firmware, but detected as off by Linux because there is no struct
> > > > pci_dev associated with the PCI bus. If I patch Linux to correctly
> > > > detect ARI, it no longer finds an isolated PF with devfn =3D=3D 1.
> > > LoongArch do have some problems after commit a02fd05661d7 ("PCI:
> > > Extend isolated function probing to LoongArch"). Please see:
> > > https://lore.kernel.org/linux-pci/20251014074100.2149737-1-chenhuacai=
@loongson.cn/
> > >=20
> > > Now we don't know what happens exactly, so I haven't answered Bjorn's
> > > question...
> > >=20
> > > Huacai
> > >=20
> >=20
> > Hi Huacai,
> >=20
> > I have now send[0] a fix proposal together with correctly exposing ARI
> > enablement in s390. I also reproduced both the issue I saw with SR-IOV
> > and with ARI and confirmed that the first patch in the series fixes
> > them. You're on Cc and I'd highly appreciate if you could test whether
> > this fixes your issues as well.
> >=20
> > Thanks,
> > Niklas
> >=20
> > [0]
> > https://lore.kernel.org/linux-pci/20251023-ari_no_bus_dev-v4-0-8482e2ed=
10bd@linux.ibm.com/
>=20
> There are two patches in this series. If LoongArch has a similar
> problem as S390, only the first patch is enough, or should we need an
> architectural change similar to the second patch?
>=20
> Huacai

Just for probing the devices the first patch should be enough. That
said if the way you do PCI pass-through means you also end up without a
struct pci_dev representing PCI bridges (bus->self is NULL for all PCI
busses), then something like the s390 specific part of the second patch
might be necessary to correctly detect ARI. Also it shouldn't hurt to
test with both patches.

Thanks,
Niklas

