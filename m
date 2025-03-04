Return-Path: <linux-pci+bounces-22930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E82A4F544
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 04:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577D616C3CC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 03:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288C319006B;
	Wed,  5 Mar 2025 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EHT122Q5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C15118A924
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144612; cv=none; b=gT2uQnqoMDXlJpxs7LO5aqrslgAuQ841j9TwPps0K5/wECMr4NNdSrw9zZoujx1T+WJuVHIZFZ1vAl2sgeDGMDYVaU99JeeV+E7G+TIem0LsB7r0aZnzP+omDFoOF7MiF8GeSvIPImGBj8rOjTJffy86Bkso1OV5CBG+NF8RgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144612; c=relaxed/simple;
	bh=aQs0s0mc62itgISldMpMaFv5obruag2Z3oivBTsK8fc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Kg3wvd81TGTl5WJ0Yg51xusNqL52OxO6L/ghn5kjfM0X3+NxuZQRIF+TDESu7fzoK1Z40y5K0/VcS/4AUVz9TP9p2itEt92g3OwpP03L22qfPZnujCjkqRp/7rLpd8eTiEI+TnqyLMMJWUjzzANczP4nUSaH7fBUBL1c0n3wTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EHT122Q5; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250305031644epoutp0389d4875feaa1a2c84f23b4952967ca6f~pycsSuIbs0875008750epoutp030
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 03:16:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250305031644epoutp0389d4875feaa1a2c84f23b4952967ca6f~pycsSuIbs0875008750epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741144605;
	bh=aQs0s0mc62itgISldMpMaFv5obruag2Z3oivBTsK8fc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=EHT122Q55g6v4lu3NFNZ/zRFKwajJwVFgCrjk3xB8CdFVJ+T99ZdCoy1pVtIYxr0K
	 uSlFopGted76iiQvaDyRXqEnUzlyI1Ne5wOeQTDbiNCQlLCrsF6lmH+QEng5L5NQci
	 RW270qeEMabIsSMQz2ESCulfGJ9oUbHlCWwugrPQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250305031644epcas5p29a0d00ec7271f43e0cb448fbf3697345~pycr4YPYs1527015270epcas5p28;
	Wed,  5 Mar 2025 03:16:44 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z6yQ25whFz4x9Q2; Wed,  5 Mar
	2025 03:16:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.02.20052.A12C7C76; Wed,  5 Mar 2025 12:16:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250304171047epcas5p38c683bd8cbc6ea4fc82377aebc2428e0~pqLnopuGX2766727667epcas5p36;
	Tue,  4 Mar 2025 17:10:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250304171047epsmtrp21378ba7aca27944c3795cea39249de95~pqLnmmsVG2056620566epsmtrp2r;
	Tue,  4 Mar 2025 17:10:47 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-a0-67c7c21a2917
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.D4.18729.71437C76; Wed,  5 Mar 2025 02:10:47 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250304171044epsmtip129b87446f6672498fe5275da77041a94~pqLk5ayRH0826908269epsmtip1n;
	Tue,  4 Mar 2025 17:10:44 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Fan Ni'" <nifan.cxl@gmail.com>,
	=?UTF-8?Q?'Krzysztof_Wilczy=C5=84ski'?= <kw@linux.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<Jonathan.Cameron@huawei.com>, <a.manzanares@samsung.com>,
	<pankaj.dubey@samsung.com>, <cassel@kernel.org>, <18255117159@163.com>,
	<xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>,
	<will@kernel.org>, <mark.rutland@arm.com>
In-Reply-To: <Z8YZEALV71PUkXpF@debian>
Subject: RE: [PATCH v7 5/5] Add debugfs based statistical counter support in
 DWC
Date: Tue, 4 Mar 2025 22:40:43 +0530
Message-ID: <061401db8d28$5f0a4b40$1d1ee1c0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJfby7SiE0e/TbLvAHLJIl0P7SXpgHkH4XnAk8q5KUB3hA60AHBUHtxAYzlJhCyEHTswA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHPXt37y7qMldc47iCgxuWSMCuLsvZEGuU8hZOojTOZA50gzu7
	xLK7s48eTgMEmwWDiRP52ICFeMRuhMXDQMExHjKKobA7IAkliBZRsjwyeSy0y5Xiv8/5ne/v
	9/39zpkfD/N5jAt5yWoDrVNTKhG+mn2hNSgoRNjSoRCbfwhCjk/muOhM6xZUlqlEV/MqMVQ5
	fY6LbCW9OMrIneOgmnu9HGS/WICjn4o6cOSor2Yj07yJjQZN2RxU3tfNQq4LzQB9VT/NRSVZ
	owAtNjVwkWkgHI3P1OIvCsjSynwOWVVUBchG8yCXLK4xkqa2vzhkjS0bJwd6m3CycUhOjjjO
	sMjasnTyszobIKdqNseuPZKyS0lTSbQugFYnapKS1YooUUxcwt6EcJlYEiKRowhRgJpKpaNE
	0ftjQ15OVrmHFAW8S6mM7lAspdeLwnbv0mmMBjpAqdEbokS0NkmllWpD9VSq3qhWhKppw/MS
	sXhHuFv4VoqyLbcK13b6v28duItlgD6/HODFg4QU/nm/G/ewD3EJwPacZ3PAajdPAlhQYAbM
	4RGA9q5CsJzRdakLYy6aAcxabMOZw+8A5lofcj0qnHgOjjjmMQ8LiHg4Omlne0QYkcmG9Qs9
	HM+FF/EMfJx/0y3i8dYTh+CNia2eMJsIhAu3Tiy58Qk5vD0/ymF4Hbx2boTtYYwIhhUlYxjT
	UQCcuV/BYbwOw59P9XMZjS9sn8ld6hQSFi/Yc7OI6/GCRDR0WlRM7nr4R0cdl2EhnHrYjDOs
	gNbas0/qq+Cj2jIWwy/AK44CtqcMRgTB8xfDmLA//OJ6NYux9YYn5kaeyPmwoWiZn4bTriY2
	wxth0VU7Jw+IzCsmM6+YzLxiAvP/bsWAbQMbaa0+VUHrw7USNf3ef/+dqEmtAUsrsP2VBjB4
	1xnaAlg80AIgDxMJ+KU5HQoffhL1wTFap0nQGVW0vgWEu5/7FCbckKhx75DakCCRysVSmUwm
	le+USUS+/KxGk8KHUFAGOoWmtbRuOY/F8xJmsDbkfKk/6Yy5Pj80niPcWfGtvxjfJ4geSupt
	fSr2QG/wUdvBB5HiwHYrVxa3J+5jNGY5ev7G6Tf6eqzDMOZgIH+/77r+4mvmfd+VU5//9kvm
	rPz4a3aB0bVp8VD6sZNrbpVwfV9PKKzrj9xizb08aTKp9h7JPHBayUpLb5sxaCxrPh3v1vit
	9b7Ds219UznhHRGZfrbCHI+0t8tj2vykf8dHQGFP1KZt91y1r0ZeifT7MI3P8ldSzqnhMdVx
	rJjnXPX9mG5zocD1oHQ2qvrXyeCMl7rznWX2H1vivnb903nZyuesmliwdO7WpffvkKUdHsoe
	3vb2nY/ecYSZUyyzWcV5ld+I2HolJdmO6fTUv/FzBj2LBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCSnK64yfF0g5l3uCyutP9mt5h+WNFi
	SVOGxbEJK5gtVnyZyW6xauE1NouGnt+sFpseX2O1uLxrDpvF2XnH2SyubF3HYtHyp4XF4m5L
	J6vF0usXmSz+btvLaLFo6xd2i4XNLxkt/u/ZwW7RcsfU4v3PzWwOIh6LV0xh9Vgzbw2jx85Z
	d9k9Fmwq9Wg58pbVY9OqTjaPO9f2sHnsfGjp8eTKdCaPzUvqPfq2rGL0+LxJLoAnissmJTUn
	syy1SN8ugSvj0aT7jAVrRStO/LrJ2sB4SLCLkZNDQsBE4tzuc8xdjFwcQgK7GSVOvL7HCpGQ
	lPh8cR0ThC0ssfLfc3aIomeMEv2fnrGAJNgEdCSeXPnDDGKLCMRJvPx0mQWkiFlgGovE/7Nn
	GCE6pjBJXL32CWwUp4CaxI8p58E6hAUCJH5u6gezWQRUJP5d6GUEsXkFLCVu/HnJCmELSpyc
	+QRsG7OAtkTvw1ZGGHvZwtfMEOcpSPx8uowV4oowiVsTb7JD1IhLHP3ZwzyBUXgWklGzkIya
	hWTULCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBKcDLc0djNtXfdA7xMjE
	wXiIUYKDWUmE1/TzsXQh3pTEyqrUovz4otKc1OJDjNIcLErivOIvelOEBNITS1KzU1MLUotg
	skwcnFINTKIPjrub7Oo/UecW0iAeHfB0e4X1n8+z+ZMXWqYJ8EmL8xzzLzWV2jnDW2zK5Yc/
	/iz7UKracb5h2rvPZmvipsr2X+J+3V5jNdUla+3kbfZ/q8S782K8f577tu0yW8G25yYHC99v
	KlbPTT79ZwfPh8u1mZVvZoVfNDvc9ihxaxvzZdel0sWLpWX3Jb3dcG+qT5nVfv+a7t33gtnW
	qaT3J1102sVzsXure/TeXws4XRbd8J97S1SXO1/cRIgl6s/siECZvvOvpDxYzU2y754Ja4wN
	3n7s6rsFk3/+97gXd8DOZfndRxYLdtrJ/ubblFP66m3Gj5ObFt8UkpjW6jLZSSn2QraW7smv
	WqIBN9OqrZRYijMSDbWYi4oTAfA3KJV2AwAA
X-CMS-MailID: 20250304171047epcas5p38c683bd8cbc6ea4fc82377aebc2428e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250221132043epcas5p27fde98558b13b3311cdc467e8f246380
References: <20250221131548.59616-1-shradha.t@samsung.com>
	<CGME20250221132043epcas5p27fde98558b13b3311cdc467e8f246380@epcas5p2.samsung.com>
	<20250221131548.59616-6-shradha.t@samsung.com> <Z8XuuNb6TRevUlHH@debian>
	<20250303194228.GB1552306@rocinante> <Z8YZEALV71PUkXpF@debian>



> -----Original Message-----
> From: Fan Ni <nifan.cxl=40gmail.com>
> Sent: 04 March 2025 02:33
> To: Krzysztof Wilczy=C5=84ski=20<kw=40linux.com>=0D=0A>=20Cc:=20Fan=20Ni=
=20<nifan.cxl=40gmail.com>;=20Shradha=20Todi=20<shradha.t=40samsung.com>;=
=20linux-kernel=40vger.kernel.org;=20linux-=0D=0A>=20pci=40vger.kernel.org;=
=20linux-arm-kernel=40lists.infradead.org;=20linux-perf-users=40vger.kernel=
.org;=20manivannan.sadhasivam=40linaro.org;=0D=0A>=20lpieralisi=40kernel.or=
g;=20robh=40kernel.org;=20bhelgaas=40google.com;=20jingoohan1=40gmail.com;=
=20Jonathan.Cameron=40huawei.com;=0D=0A>=20a.manzanares=40samsung.com;=20pa=
nkaj.dubey=40samsung.com;=20cassel=40kernel.org;=2018255117159=40163.com;=
=0D=0A>=20xueshuai=40linux.alibaba.com;=20renyu.zj=40linux.alibaba.com;=20w=
ill=40kernel.org;=20mark.rutland=40arm.com=0D=0A>=20Subject:=20Re:=20=5BPAT=
CH=20v7=205/5=5D=20Add=20debugfs=20based=20statistical=20counter=20support=
=20in=20DWC=0D=0A>=20=0D=0A>=20On=20Tue,=20Mar=2004,=202025=20at=2004:42:28=
AM=20+0900,=20Krzysztof=20Wilczy=C5=84ski=20wrote:=0D=0A>=20>=20Hello,=0D=
=0A>=20>=0D=0A>=20>=20=5B...=5D=0D=0A>=20>=20>=20>=20+static=20ssize_t=20co=
unter_value_read(struct=20file=20*file,=20char=20__user=0D=0A>=20>=20>=20>=
=20+*buf,=20size_t=20count,=20loff_t=20*ppos)=20=7B=0D=0A>=20>=20>=20>=20+=
=09struct=20dwc_pcie_rasdes_priv=20*pdata=20=3D=20file->private_data;=0D=0A=
>=20>=20>=20>=20+=09struct=20dw_pcie=20*pci=20=3D=20pdata->pci;=0D=0A>=20>=
=20>=20>=20+=09struct=20dwc_pcie_rasdes_info=20*rinfo=20=3D=20pci->debugfs-=
>rasdes_info;=0D=0A>=20>=20>=20>=20+=09char=20debugfs_buf=5BDWC_DEBUGFS_BUF=
_MAX=5D;=0D=0A>=20>=20>=20>=20+=09ssize_t=20pos;=0D=0A>=20>=20>=20>=20+=09u=
32=20val;=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=09mutex_lock(&rinfo=
->reg_event_lock);=0D=0A>=20>=20>=20>=20+=09set_event_number(pdata,=20pci,=
=20rinfo);=0D=0A>=20>=20>=20>=20+=09val=20=3D=20dw_pcie_readl_dbi(pci,=20ri=
nfo->ras_cap_offset=20+=20RAS_DES_EVENT_COUNTER_DATA_REG);=0D=0A>=20>=20>=
=20>=20+=09mutex_unlock(&rinfo->reg_event_lock);=0D=0A>=20>=20>=20>=20+=09p=
os=20=3D=20scnprintf(debugfs_buf,=20DWC_DEBUGFS_BUF_MAX,=20=22Counter=0D=0A=
>=20>=20>=20>=20+value:=20%d=5Cn=22,=20val);=0D=0A>=20>=20>=20>=20+=0D=0A>=
=20>=20>=20>=20+=09return=20simple_read_from_buffer(buf,=20count,=20ppos,=
=20debugfs_buf,=0D=0A>=20>=20>=20>=20+pos);=20=7D=0D=0A>=20>=20>=0D=0A>=20>=
=20>=20Do=20we=20need=20to=20check=20whether=20the=20counter=20is=20enabled=
=20or=20not=20for=20the=0D=0A>=20>=20>=20event=20before=20retrieving=20the=
=20counter=20value?=0D=0A>=20>=0D=0A>=20>=20I=20believe,=20we=20have=20a=20=
patch=20that=20aims=20to=20address,=20have=20a=20look=20at:=0D=0A>=20>=0D=
=0A>=20>=0D=0A>=20>=20https://lore.kernel.org/linux-pci/20250225171239.1957=
4-1-manivannan.sa=0D=0A>=20>=20dhasivam=40linaro.org=0D=0A>=20=0D=0A>=20May=
be=20I=20missed=20something,=20that=20seems=20to=20fix=20counter_enable_rea=
d(),=20but=20here=20is=20to=20retrieve=20counter=20value.=0D=0A>=20How=20dw=
_pcie_readl_dbi()=20can=20return=20something=20like=20=22Counter=20Disabled=
=22?=0D=0A>=20=0D=0A>=20Fan=0D=0A=0D=0AHey=20Fan,=0D=0ASo=20the=20counter=
=20value=20will=20show=200=20in=20case=20it=20is=20disabled=20so=20there=20=
will=20not=20be=20any=20issues=20as=20per=20say.=20We=20could=20add=20the=
=0D=0Acheck=20here=20but=20I=20feel=20I=20have=20already=20exposed=20the=20=
functionality=20to=20check=20if=20a=20counter=20is=20enabled=20or=20disable=
d,=20(by=20reading=20the=0D=0Acounter_enable=20debugfs=20entry)=20so=20this=
=20could=20be=20handled=20in=20user=20space=20to=20only=20read=20the=20coun=
ter=20if=20it's=20enabled.=0D=0A=0D=0A>=20>=0D=0A>=20>=20Thank=20you=21=0D=
=0A>=20>=0D=0A>=20>=20=09Krzysztof=0D=0A=0D=0A

