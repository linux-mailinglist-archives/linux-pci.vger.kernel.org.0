Return-Path: <linux-pci+bounces-40336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9DC34EF1
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE46E34D9E3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C43043DA;
	Wed,  5 Nov 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qF64ITM0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B4270557;
	Wed,  5 Nov 2025 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336030; cv=none; b=SAn9IgHs4MJ8U6Dp6s3HmTorKNvtUK4N0+T1XO2r+iRqhNOVk+YGGLzjBMek3GF7AYfPord69mE8CVg7H5e6zJNN7i4uAU3Vj6skSAlBotyGmRyWZJeJ0UJPaAVfQNrksoVLOPS8b8XhWFp67XdD52fIfFYkmKsNJPcQpiIe3X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336030; c=relaxed/simple;
	bh=Q715GEIFHrSvu2pmp1V2UpvJASXLBK/PbZ88nmydt80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQW53kZdNzH+VhLccBJPn718q698jT66ItoKa3rRq+3RNAB72mLo1FqOeA8NPgh9noGfrLJJgz/VBFEnTQ/mwDDPmWz2/n8YQl/bB12ylz3JmIwWMJFDPOSElcW65NKrCJrjf2hD96AAuY8KzEhxXj2nPaAj8oHxoub/weqOVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qF64ITM0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A58YC5f028475;
	Wed, 5 Nov 2025 09:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SadkCi
	Ay5OJy+5qYjipr9N4OtB9+6k1iE/Py0QOvLrM=; b=qF64ITM0ISmjupTRuKl4sM
	0WarbziNdOKRew3qG8Hv/N+u4EnXaf9loiU/64/CDUEB4OAihBy+gkei4AcXbewX
	o0gJHEvEjmdCInBp0iE3aMgh43NwQFUWtJX0ZEXmIN8u/Q46Xk/Ljfc8YtL+BRvq
	BZV0sm/veX2eL5yAQsWzsHcrbATUUdlUMfbZosy0S8t6LwYJ5SJ17a4OVNAHOTtF
	b9uRs3wNi0Bxr8J+qPIJtUUe/YKJFTnCzJggTu04mQP0HQF8fMkFpk6WvThOPip1
	wKAXjash5v9w9VwmKqtLgDvPgymUe+lmwH0r7YoOgvCTiwqgxPgIl8j5JV66chVg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mm09ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 09:46:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A59fs2U013826;
	Wed, 5 Nov 2025 09:46:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mm09ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 09:46:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A570Ecc027464;
	Wed, 5 Nov 2025 09:46:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwyfh43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 09:46:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A59kmZs24511168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 09:46:48 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36E7C58060;
	Wed,  5 Nov 2025 09:46:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A16FF58056;
	Wed,  5 Nov 2025 09:46:45 +0000 (GMT)
Received: from [9.152.212.150] (unknown [9.152.212.150])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 09:46:45 +0000 (GMT)
Message-ID: <8dd0f3df4b18a6c9f8b49ede7bc2ab71e40fd8f9.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] PCI: Fix isolated PCI function probing with ARI
 and SR-IOV
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jan Kiszka
 <jan.kiszka@siemens.com>,
        Bibo Mao <maobibo@loongson.cn>,
        linux-s390
 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev,
        Farhan Ali
 <alifm@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tianrui
 Zhao	 <zhaotianrui@loongson.cn>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer	
 <gbayer@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date: Wed, 05 Nov 2025 10:46:45 +0100
In-Reply-To: <CAAhV-H7iMKmLnisD-874D2ZC919sDYeWy3tw=+eUqifK--6-Dg@mail.gmail.com>
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
	 <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com>
	 <CAAhV-H6qqppoX_G5KrWmPor16bXfvNTE2x8Xx6yajAYPqxpigw@mail.gmail.com>
	 <958ef380be4ea488698fab05245d631998c32a48.camel@linux.ibm.com>
	 <CAAhV-H7iMKmLnisD-874D2ZC919sDYeWy3tw=+eUqifK--6-Dg@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: sqPFjC6l1K1BCudm4kAdyk0tNXCmVXXy
X-Proofpoint-GUID: L05nCPKSTgiJYzow5iQ2hsacYnGvaWtW
X-Authority-Analysis: v=2.4 cv=SqidKfO0 c=1 sm=1 tr=0 ts=690b1d0a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=MG3tck3BdzmQzJWRLAwA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwOSBTYWx0ZWRfXzlhHTNiQuxwD
 15w1huLfO9mVpp7Y5n+LmuaaqSfRorqGvM49oMHO87mi5e84o7o4pLXUm9GmNI1jKV0PZC7NJov
 6lPq36vxVj217mp+t4hVdU8wVb8pbPZUw3vxE8X9d3wquCXu4tSURSmjeFtT4M8+w6oH32R4j5m
 bFoDLQ18Q17OwbUxXR1ZvPjKmtcDQGWFmZ6Fb1heQoaz+1m161IP3xBsnOHfT3ZPW3vjCq08gdw
 0x+Xmwa3+KYeddHGLwwLcGO1BfdeeDx1+sUroa1spbmiFUFQ48TPgx6R+stbxi7/gUC7wXKCC2C
 Km66hOCq3GpXEhOe4ku8PX3b0brwViiwI3uv/2fH5U5OF+NyW2ba2oCQ102bZBTIwfK7qv2hVV6
 AJoeFoSNqIKEVyFOpF/xmtzl09Zj9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010009

On Wed, 2025-11-05 at 09:01 +0800, Huacai Chen wrote:
> On Mon, Nov 3, 2025 at 7:23=E2=80=AFPM Niklas Schnelle <schnelle@linux.ib=
m.com> wrote:
> >=20
> > On Mon, 2025-11-03 at 17:50 +0800, Huacai Chen wrote:
> > > Hi, Niklas,
> > >=20
> > > On Wed, Oct 29, 2025 at 5:42=E2=80=AFPM Niklas Schnelle <schnelle@lin=
ux.ibm.com> wrote:
> > > >=20
> > > > When the isolated PCI function probing mechanism is used in conjunc=
tion
> > > > with ARI or SR-IOV it may not find all available PCI functions. In =
the
> > > > case of ARI the problem is that next_ari_fn() always returns -ENODE=
V if
> > > > dev is NULL and thus if fn 0 is missing the scan stops.
> > > >=20
> > > > For SR-IOV things are more complex. Here the problem is that the ch=
eck
> > > > for multifunction may fail. One example where this can occur is if =
the
> > > > first passed-through function is a VF with devfn 8. Now in
> > > > pci_scan_slot() this means it is fn 0 and thus multifunction doesn'=
t get
> > > > set. Since VFs don't get multifunction set via PCI_HEADER_TYPE_MFD =
it
> > > > remains unset and probing stops even if there is a devfn 9.
> > > >=20
> > > > Now at the moment both of these issues are hidden on s390. The firs=
t one
> > > > because ARI is detected as disabled as struct pci_bus's self is NUL=
L
> > > > even though firmware does enable and use ARI. The second issue is h=
idden
> > > > as a side effect of commit 25f39d3dcb48 ("s390/pci: Ignore RID for
> > > > isolated VFs"). This is because VFs are either put on their own vir=
tual
> > > > bus if the parent PF is not passed-through to the same instance or =
VFs
> > > > are hotplugged once SR-IOV is enabled on the parent PF and then
> > > > pci_scan_single_device() is used.
> > > >=20
> > > > Still especially the first issue prevents correct detection of ARI =
and
> > > > the second might be a problem for other users of isolated function
> > > > probing. Fix both issues by keeping things as simple as possible. I=
f
> > > > isolated function probing is enabled simply scan every possible dev=
fn.
> > > I'm very sorry, but applying this patch on top of commit a02fd05661d7
> > > ("PCI: Extend isolated function probing to LoongArch") we fail to
> > > boot.
> > >=20
> > > Boot log:
> > > [   10.365340] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16
> > > 00:01:03 EST 2006)
> > > [   10.372628] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 =
EST 2006)
> > > [   10.379564] megasas: 07.734.00.00-rc1
> > > [   10.383222] mpt3sas version 54.100.00.00 loaded
> > > [   10.388304] nvme nvme0: pci function 0000:08:00.0
> > > [   10.395088] Freeing initrd memory: 45632K
> > > [   10.469822] ------------[ cut here ]------------
> > > [   10.474409] WARNING: CPU: 0 PID: 247 at drivers/ata/libahci.c:233
> > > ahci_enable_ahci+0x64/0xb8
> > > [   10.482804] Modules linked in:
> > > [   10.485838] CPU: 0 UID: 0 PID: 247 Comm: kworker/0:11 Not tainted
> > > 6.18.0-rc3 #1 PREEMPT(full)
> > > [   10.494397] Hardware name: To be filled by O.E.M.To be fill To be
> > > filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
> > > Loongson-UDK2018-V4.0.
> > > [   10.508139] Workqueue: events work_for_cpu_fn
> > > [   10.512468] pc 900000000103be2c ra 900000000103be28 tp
> > > 900000010ae44000 sp 900000010ae47be0
> > > [   10.520769] a0 0000000000000000 a1 00000000000000b0 a2
> > > 0000000000000001 a3 9000000001810e0c
> > > [   10.529069] a4 9000000002343e20 a5 0000000000000001 a6
> > > 0000000000000010 a7 0000000000000000
> > > [   10.537373] t0 d10951fa66920f31 t1 d10951fa66920f31 t2
> > > 0000000000001280 t3 000000000674c000
> > > [   10.545673] t4 0000000000000000 t5 0000000000000000 t6
> > > 9000000008002480 t7 00000000000000b4
> > > [   10.553972] t8 90000001055eab90 u0 900000010ae47b68 s9
> > > 9000000002221a50 s0 0000000000000000
> > > [   10.562272] s1 ffff800032435800 s2 0000000000000000 s3
> > > ffffffff80000000 s4 9000000002221570
> > > [   10.570571] s5 0000000000000005 s6 9000000101ccf0b8 s7
> > > 90000000023dd000 s8 900000010ae47d08
> > > [   10.578869]    ra: 900000000103be28 ahci_enable_ahci+0x60/0xb8
> > > [   10.584665]   ERA: 900000000103be2c ahci_enable_ahci+0x64/0xb8
> > > [   10.590461]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC =
-WE)
> > > [   10.596609]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> > > [   10.600937]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> > > [   10.605698]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> > > [   10.610458] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
> > > [   10.615994]  PRID: 0014d010 (Loongson-64bit, Loongson-3C6000/S)
> > > [   10.621875] CPU: 0 UID: 0 PID: 247 Comm: kworker/0:11 Not tainted
> > > 6.18.0-rc3 #1 PREEMPT(full)
> > > [   10.621877] Hardware name: To be filled by O.E.M.To be fill To be
> > > filled by O.E.M.To be fill/To be filled by O.E.M.To be fill, BIOS
> > > Loongson-UDK2018-V4.0.
> > > [   10.621878] Workqueue: events work_for_cpu_fn
> > > [   10.621881] Stack : 900000010ae47848 0000000000000000
> > > 90000000002436bc 900000010ae44000
> > > [   10.621884]         900000010ae47820 900000010ae47828
> > > 0000000000000000 900000010ae47968
> > > [   10.621887]         900000010ae47960 900000010ae47960
> > > 900000010ae47630 0000000000000001
> > > [   10.621890]         0000000000000001 900000010ae47828
> > > d10951fa66920f31 9000000100414300
> > > [   10.621893]         80000000ffffe34d fffffffffffffffe
> > > 000000000000034f 000000000000002f
> > > [   10.621896]         0000000000000063 0000000000000001
> > > 000000000674c000 9000000002221a50
> > > [   10.621899]         0000000000000000 0000000000000000
> > > 90000000020b6500 90000000023dd000
> > > [   10.621902]         00000000000000e9 0000000000000009
> > > 0000000000000002 90000000023dd000
> > > [   10.621905]         900000010ae47d08 0000000000000000
> > > 90000000002436d4 0000000000000000
> > > [   10.621908]         00000000000000b0 0000000000000004
> > > 0000000000000000 0000000000071c1d
> > > [   10.621910]         ...
> > > [   10.621912] Call Trace:
> > > [   10.621913] [<90000000002436d4>] show_stack+0x5c/0x180
> > > [   10.621918] [<900000000023f328>] dump_stack_lvl+0x6c/0x9c
> > > [   10.621923] [<9000000000266eb8>] __warn+0x80/0x108
> > > [   10.621927] [<90000000017d1910>] report_bug+0x158/0x2a8
> > > [   10.621932] [<900000000180b610>] do_bp+0x2d0/0x340
> > > [   10.621938] [<9000000000241da0>] handle_bp+0x120/0x1c0
> > > [   10.621940] [<900000000103be2c>] ahci_enable_ahci+0x64/0xb8
> > > [   10.621943] [<900000000103beb8>] ahci_save_initial_config+0x38/0x4=
d8
> > > [   10.621946] [<90000000010391b4>] ahci_init_one+0x354/0x1088
> > > [   10.621950] [<9000000000d16cdc>] local_pci_probe+0x44/0xb8
> > > [   10.621953] [<9000000000286f78>] work_for_cpu_fn+0x18/0x30
> > > [   10.621956] [<900000000028a840>] process_one_work+0x160/0x330
> > > [   10.621961] [<900000000028b208>] worker_thread+0x330/0x460
> > > [   10.621964] [<9000000000295fdc>] kthread+0x11c/0x138
> > > [   10.621968] [<900000000180b740>] ret_from_kernel_thread+0x28/0xa8
> > > [   10.621971] [<9000000000241484>] ret_from_kernel_thread_asm+0xc/0x=
88
> > > [   10.621973]
> > >=20
> > >=20
> >=20
> > This looks like a warning telling us that AHCI enable failed / timed
> > out. Do you have Panic on Warn on that this directly causes a boot
> > failure? The only relation I can see with my patch is that maybe this
> > AHCI device wasn't probed before and somehow isn't working?
> The rootfs is on the AHCI controller, so AHCI failure causes the boot
> failure, without this patch no boot problems.
>=20
> Huacai
>=20

Ok, I'm going to need more details to make sense of this. Can you tell
me if ARI is enabled for that bus? Did you test with both patches or
just this one? Could you provide lspci -vv from a good boot and can you
tell which AHCI device the root device is on? Also could you clarify
why you set hypervisor_isolated_pci_functions() in particular this
seems like a bare metal boot, right? When running in KVM do you pass-
through individual PCI functions with the guest seeing a devfn other
than 0 alone, i.e. a missing devfn 0? Or do you need this for bare
metal for some reason? If you don't need it for bare metal, does the
boot work if you return 0 from hypervisor_isolated_pci_functions() with
this patch?

Thanks,
Niklas

