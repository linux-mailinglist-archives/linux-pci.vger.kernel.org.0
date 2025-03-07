Return-Path: <linux-pci+bounces-23190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4708FA57BBE
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 17:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E85C16F1C1
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7C214A8B;
	Sat,  8 Mar 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p8tH4Cgy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB771758B
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449633; cv=none; b=hrRcfK8+RguR9fbdlgD2NHzNQBVHrBxE6lzuyCV0dr4Z/ngamHmZQs5j1IYySA2wdMyIlAPCnLLodMxIAfVDwyp575+/kK5NPxtOmsj+xS8Rz+k+sWMowxZAw5c4fMhYvD4p2mnbAePvmObZB6d5ct2x0W5N1p/2NLvbDS4QLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449633; c=relaxed/simple;
	bh=x2Kk7zM0eOg+x2C4vQ/WSq9xOyqsqVq7QtUIFCoh00Q=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=XGuwgX4ktsMbg79BdaSMV8axy4ghNleRPgjIM96xgF7nGt3r4NTGQHnLlsUCq8dy1BdODev8kChCpL+DnAPWlTzm0YY0Ml1ED6oAAeOlcN6zvblNL4fxIRIbFCwsgNvLCPE95axx3/iiQ7KaNMbqpamcZLlSnXMoCtSLRHix1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=p8tH4Cgy; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250308155411epoutp02715f21bd091cb5decdcc19a7e9c1123d~q3t4gtr6I0385603856epoutp02b
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 15:54:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250308155411epoutp02715f21bd091cb5decdcc19a7e9c1123d~q3t4gtr6I0385603856epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741449251;
	bh=x2Kk7zM0eOg+x2C4vQ/WSq9xOyqsqVq7QtUIFCoh00Q=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=p8tH4CgyJFH6eqasRyYeM3RAuXuKF/5JGxOiakhX29CtDdG+g8ni1x1kVob47+y42
	 ho5MrYSAHHwSz+w5q63081gK5gsaxl2Nwsth735NvODZaDjDLviHqIS2r1yfL2mJIx
	 vnzPdsBlVUqHupzEbH6zMurPdsFb/QcMCWRGkhKo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250308155409epcas5p31ec0bded70d0235ef1078dad3134d8b0~q3t27g-tx2173221732epcas5p3l;
	Sat,  8 Mar 2025 15:54:09 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z974b6Tccz4x9Pp; Sat,  8 Mar
	2025 15:54:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.91.20052.F186CC76; Sun,  9 Mar 2025 00:54:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250307094754epcas5p49b48fe616b8f4cbe880f979fa1341708~qfEyNozm60463904639epcas5p4-;
	Fri,  7 Mar 2025 09:47:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250307094754epsmtrp20a5e1096d994e76a5c86cef66f52243d~qfEyMlfzP2554325543epsmtrp2T;
	Fri,  7 Mar 2025 09:47:54 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-5d-67cc681f2b8f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.E4.18729.9C0CAC76; Fri,  7 Mar 2025 18:47:53 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250307094751epsmtip280ce2f05b4121b89120543ee4f99d4b0~qfEvdJFPB3075730757epsmtip2l;
	Fri,  7 Mar 2025 09:47:51 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Fan Ni'" <nifan.cxl@gmail.com>
Cc: =?UTF-8?Q?'Krzysztof_Wilczy=C5=84ski'?= <kw@linux.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<Jonathan.Cameron@huawei.com>, <a.manzanares@samsung.com>,
	<pankaj.dubey@samsung.com>, <cassel@kernel.org>, <18255117159@163.com>,
	<xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>,
	<will@kernel.org>, <mark.rutland@arm.com>
In-Reply-To: <Z8fSWcR_aXyxmFEZ@debian>
Subject: RE: [PATCH v7 5/5] Add debugfs based statistical counter support in
 DWC
Date: Fri, 7 Mar 2025 15:17:50 +0530
Message-ID: <075501db8f45$ff6f9620$fe4ec260$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJfby7SiE0e/TbLvAHLJIl0P7SXpgHkH4XnAk8q5KUB3hA60AHBUHtxAYzlJhAB7JKozgKp5GvQse/7dKA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzO6W1vC1pzrQWOxE12fSyIPAptd7sAI5txd4MpmXNLSBxe4Kwl
	lNumD9kjKowyAkEEpwGqYRYrAoIsRV7KS0AZCCMLDYYBnXM4cYy5ASMwZFtLy8Z/3+873/l9
	v++c/ASYaAn3F6SyBqRjGTWJe3ObegJfDt6pGlSGZV0Ipey5K3yqpOclyvq5irpXVIVRVQtl
	fKrGMopTmQUrPMr20yiPGrl1CaeGyvtwyt54g0uZnpu41KQpj0ddffAdh1ptagdUReMCn7Jk
	PwXUP20tfMo0IaOeLTfgMWL6StV5Hl1bXgvoVvMkn75sM9Km3lkebavJw+mJ0Tacbv1RQU/Z
	Szh0g/U0XXizBtDzthfjNyekRaoQk4J0AYhN1qSkssooMvZI4huJMnmYJFiioF4hA1gmHUWR
	B+Ligw+mqp0hyYATjNropOIZvZ4MjY7UaYwGFKDS6A1RJNKmqLVSbYieSdcbWWUIiwyvSsLC
	wmVO4fE0lWWxi6+dC/94ds7OyQT1knzgJYCEFJbNZvHygbdARNwG8Iu/xrjuYg7Azou9HHex
	COD8QB93/Uqdfcajagdw6dcnuLuYBrC/oGNNhRP74ZT9OebCYmI3XLJXApcII9q4cCzn/NqB
	F7EXPn1yhp8PBIJtxLtw8I89Lprr1H/zswV30UJCAW3PUl20kNgK+8um1tpjRBCstMxg7oEC
	4PLjSp5LLiaS4PAMdEv84N3lAszlColrXrC+zuoJcAA+GFzlu/E2+EvfTQ/2h/O/teNurITV
	DaWe/mq42GDluPFrsMt+ievywohAWH8r1E2/AC8M3OC4fbfAMytTHrkQtpSv411wYbXNM8J2
	WH5vhFcESPOGZOYNycwbIpj/d7sMuDVgO9Lq05VIL9NKWJTx338na9JtYG0F9r3VAiYf/h7S
	DTgC0A2gACPFwr3NA0qRMIX55FOk0yTqjGqk7wYy52sXY/4+yRrnDrGGRIlUESaVy+VSRYRc
	QvoJs1tNShGhZAwoDSEt0q3f4wi8/DM5ddLAzRNnhbUn76yGb/EtCC++7pdYbesIOeHgi4sj
	RJ3GoObxk3feaRRadozdz3Uk9c1GHCs2zCxcVQthqObcTCMaHfIbLz32VSebo+lvjWsbfvjn
	fPPru2VHUmLZvNhTPXkidpOvtHBsE4i+WNWV9mYC+gD5+FIfnYqxlvrKZ3MDv7WUEocMEYr9
	3sHL4qoY2eHv67cW7URDS48S7p42H9cxLenjA007ciqID69Nf73ydm/3uZz58p4OugRzeDXG
	cY+OWMfOZkZW/63I+MERuIeNHA69vfS4Im1XULa9oeNgRldRkg2ffh8ao9SfjaPCL33uRx/N
	is6kD11/75HDQXL1KkayD9PpmX8BI1MvCosEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCSvO7JA6fSDR48sbG40v6b3WL6YUWL
	JU0ZFscmrGC2WPFlJrvFqoXX2Cwaen6zWmx6fI3V4vKuOWwWZ+cdZ7O4snUdi0XLnxYWi7st
	nawWS69fZLL4u20vo8WirV/YLRY2v2S0+L9nB7tFyx1Ti/c/N7M5iHgsXjGF1WPNvDWMHjtn
	3WX3WLCp1KPlyFtWj02rOtk87lzbw+ax86Glx5Mr05k8Ni+p9+jbsorR4/MmuQCeKC6blNSc
	zLLUIn27BK6M86t2Mhc8VK5oWzSZtYHxmUwXIyeHhICJxNorr1lAbCGB3YwSV+4EQMQlJT5f
	XMcEYQtLrPz3nL2LkQuo5hmjxMWTL1lBEmwCOhJPrvxhBrFFBFQkflxZxghSxCxwgUWia8Fd
	Voipd5gkJh0wBrE5BdQkXj7vZQexhQUCJH5u6gdrZgFqPvFsIVsXIwcHr4ClxKb3mSBhXgFB
	iZMzn4AdxyygLdH7sJURxl628DUzxHEKEj+fLmMFaRURSJI4/1oCokRc4ujPHuYJjMKzkEya
	hWTSLCSTZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzgNaGnuYNy+6oPe
	IUYmDsZDjBIczEoivGrbT6UL8aYkVlalFuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpa
	kFoEk2Xi4JRqYGp4cYvpRKBbxsXti15M/haQE3swIUPuD0+x0JmExvMnyz6FzvTe1N7l0/Ns
	8oZTUpVRfHYf/p6xKq+Z150soFEruadlZUSRpGLMw2kPHkxoWaH5T+TDv5Svezx6PTbvSjI7
	GMbsddc48Ere+gtN+pcdo+/OT73dFlT1zZvNpEZJRHe10I5JHywu/i/Zn6+a9m+91s8WPqsr
	k39KiQpEvuxQNJklv0/YoXX69BMFB52/9U9e82qOijvfs5X/otw27l00cdmjnJ8pFs8rl2ju
	cp2Voeh+0+/8igu24n+ztj08Jb7NsNgv9JOTjcCxdv9Xs69uZqr898/qfde9+CifjydL/c4Z
	aVS0iB/TLYs4vVaJpTgj0VCLuag4EQCVKSVzcgMAAA==
X-CMS-MailID: 20250307094754epcas5p49b48fe616b8f4cbe880f979fa1341708
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
	<061401db8d28$5f0a4b40$1d1ee1c0$@samsung.com> <Z8fSWcR_aXyxmFEZ@debian>



> -----Original Message-----
> From: Fan Ni <nifan.cxl=40gmail.com>
> Sent: 05 March 2025 09:56
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: 'Fan Ni' <nifan.cxl=40gmail.com>; 'Krzysztof Wilczy=C5=84ski'=20<kw=
=40linux.com>;=20linux-kernel=40vger.kernel.org;=20linux-pci=40vger.kernel.=
org;=0D=0A>=20linux-arm-kernel=40lists.infradead.org;=20linux-perf-users=40=
vger.kernel.org;=20manivannan.sadhasivam=40linaro.org;=20lpieralisi=40kerne=
l.org;=0D=0A>=20robh=40kernel.org;=20bhelgaas=40google.com;=20jingoohan1=40=
gmail.com;=20Jonathan.Cameron=40huawei.com;=20a.manzanares=40samsung.com;=
=0D=0A>=20pankaj.dubey=40samsung.com;=20cassel=40kernel.org;=2018255117159=
=40163.com;=20xueshuai=40linux.alibaba.com;=20renyu.zj=40linux.alibaba.com;=
=0D=0A>=20will=40kernel.org;=20mark.rutland=40arm.com=0D=0A>=20Subject:=20R=
e:=20=5BPATCH=20v7=205/5=5D=20Add=20debugfs=20based=20statistical=20counter=
=20support=20in=20DWC=0D=0A>=20=0D=0A>=20On=20Tue,=20Mar=2004,=202025=20at=
=2010:40:43PM=20+0530,=20Shradha=20Todi=20wrote:=0D=0A>=20>=0D=0A>=20>=0D=
=0A>=20>=20>=20-----Original=20Message-----=0D=0A>=20>=20>=20From:=20Fan=20=
Ni=20<nifan.cxl=40gmail.com>=0D=0A>=20>=20>=20Sent:=2004=20March=202025=200=
2:33=0D=0A>=20>=20>=20To:=20Krzysztof=20Wilczy=C5=84ski=20<kw=40linux.com>=
=0D=0A>=20>=20>=20Cc:=20Fan=20Ni=20<nifan.cxl=40gmail.com>;=20Shradha=20Tod=
i=0D=0A>=20>=20>=20<shradha.t=40samsung.com>;=20linux-kernel=40vger.kernel.=
org;=20linux-=0D=0A>=20>=20>=20pci=40vger.kernel.org;=20linux-arm-kernel=40=
lists.infradead.org;=0D=0A>=20>=20>=20linux-perf-users=40vger.kernel.org;=
=20manivannan.sadhasivam=40linaro.org;=0D=0A>=20>=20>=20lpieralisi=40kernel=
.org;=20robh=40kernel.org;=20bhelgaas=40google.com;=0D=0A>=20>=20>=20jingoo=
han1=40gmail.com;=20Jonathan.Cameron=40huawei.com;=0D=0A>=20>=20>=20a.manza=
nares=40samsung.com;=20pankaj.dubey=40samsung.com;=0D=0A>=20>=20>=20cassel=
=40kernel.org;=2018255117159=40163.com;=20xueshuai=40linux.alibaba.com;=0D=
=0A>=20>=20>=20renyu.zj=40linux.alibaba.com;=20will=40kernel.org;=20mark.ru=
tland=40arm.com=0D=0A>=20>=20>=20Subject:=20Re:=20=5BPATCH=20v7=205/5=5D=20=
Add=20debugfs=20based=20statistical=20counter=0D=0A>=20>=20>=20support=20in=
=20DWC=0D=0A>=20>=20>=0D=0A>=20>=20>=20On=20Tue,=20Mar=2004,=202025=20at=20=
04:42:28AM=20+0900,=20Krzysztof=20Wilczy=C5=84ski=20wrote:=0D=0A>=20>=20>=
=20>=20Hello,=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20=5B...=5D=0D=0A>=20>=
=20>=20>=20>=20>=20+static=20ssize_t=20counter_value_read(struct=20file=20*=
file,=20char=0D=0A>=20>=20>=20>=20>=20>=20+__user=20*buf,=20size_t=20count,=
=20loff_t=20*ppos)=20=7B=0D=0A>=20>=20>=20>=20>=20>=20+=09struct=20dwc_pcie=
_rasdes_priv=20*pdata=20=3D=20file->private_data;=0D=0A>=20>=20>=20>=20>=20=
>=20+=09struct=20dw_pcie=20*pci=20=3D=20pdata->pci;=0D=0A>=20>=20>=20>=20>=
=20>=20+=09struct=20dwc_pcie_rasdes_info=20*rinfo=20=3D=20pci->debugfs->ras=
des_info;=0D=0A>=20>=20>=20>=20>=20>=20+=09char=20debugfs_buf=5BDWC_DEBUGFS=
_BUF_MAX=5D;=0D=0A>=20>=20>=20>=20>=20>=20+=09ssize_t=20pos;=0D=0A>=20>=20>=
=20>=20>=20>=20+=09u32=20val;=0D=0A>=20>=20>=20>=20>=20>=20+=0D=0A>=20>=20>=
=20>=20>=20>=20+=09mutex_lock(&rinfo->reg_event_lock);=0D=0A>=20>=20>=20>=
=20>=20>=20+=09set_event_number(pdata,=20pci,=20rinfo);=0D=0A>=20>=20>=20>=
=20>=20>=20+=09val=20=3D=20dw_pcie_readl_dbi(pci,=20rinfo->ras_cap_offset=
=20+=20RAS_DES_EVENT_COUNTER_DATA_REG);=0D=0A>=20>=20>=20>=20>=20>=20+=09mu=
tex_unlock(&rinfo->reg_event_lock);=0D=0A>=20>=20>=20>=20>=20>=20+=09pos=20=
=3D=20scnprintf(debugfs_buf,=20DWC_DEBUGFS_BUF_MAX,=20=22Counter=0D=0A>=20>=
=20>=20>=20>=20>=20+value:=20%d=5Cn=22,=20val);=0D=0A>=20>=20>=20>=20>=20>=
=20+=0D=0A>=20>=20>=20>=20>=20>=20+=09return=20simple_read_from_buffer(buf,=
=20count,=20ppos,=0D=0A>=20>=20>=20>=20>=20>=20+debugfs_buf,=20pos);=20=7D=
=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20Do=20we=20need=20to=20chec=
k=20whether=20the=20counter=20is=20enabled=20or=20not=20for=0D=0A>=20>=20>=
=20>=20>=20the=20event=20before=20retrieving=20the=20counter=20value?=0D=0A=
>=20>=20>=20>=0D=0A>=20>=20>=20>=20I=20believe,=20we=20have=20a=20patch=20t=
hat=20aims=20to=20address,=20have=20a=20look=20at:=0D=0A>=20>=20>=20>=0D=0A=
>=20>=20>=20>=0D=0A>=20>=20>=20>=20https://lore.kernel.org/linux-pci/202502=
25171239.19574-1-manivanna=0D=0A>=20>=20>=20>=20n.sa=0D=0A>=20>=20>=20>=20d=
hasivam=40linaro.org=0D=0A>=20>=20>=0D=0A>=20>=20>=20Maybe=20I=20missed=20s=
omething,=20that=20seems=20to=20fix=20counter_enable_read(),=20but=20here=
=20is=20to=20retrieve=20counter=20value.=0D=0A>=20>=20>=20How=20dw_pcie_rea=
dl_dbi()=20can=20return=20something=20like=20=22Counter=20Disabled=22?=0D=
=0A>=20>=20>=0D=0A>=20>=20>=20Fan=0D=0A>=20>=0D=0A>=20>=20Hey=20Fan,=0D=0A>=
=20>=20So=20the=20counter=20value=20will=20show=200=20in=20case=20it=20is=
=20disabled=20so=20there=20will=0D=0A>=20>=20not=20be=20any=20issues=20as=
=20per=20say.=20We=20could=20add=20the=20check=20here=20but=20I=20feel=20I=
=0D=0A>=20>=20have=20already=20exposed=20the=20functionality=20to=20check=
=20if=20a=20counter=20is=20enabled=20or=20disabled,=20(by=20reading=20the=
=20counter_enable=20debugfs=20entry)=0D=0A>=20so=20this=20could=20be=20hand=
led=20in=20user=20space=20to=20only=20read=20the=20counter=20if=20it's=20en=
abled.=0D=0A>=20Ok.=0D=0A>=20Returning=200=20when=20the=20counter=20is=20di=
sabled=20makes=20sense=20to=20me.=0D=0A>=20=0D=0A>=20Just=20some=20thought.=
=0D=0A>=20=0D=0A>=20It=20seems=20natural=20to=20me=20if=20we=20make=20=22co=
unter_value=22=20only=20visiable=20to=20users=20when=20the=20counter=20is=
=20enabled.=0D=0A>=20=0D=0A=0D=0AHey=20Fan,=0D=0A=0D=0AThis=20looks=20like=
=20a=20good=20suggestion=20to=20me.=20I=20have=20implemented=20this=20and=
=20in=20the=20process=20of=20testing.=20Since=20there=20is=20no=20support=
=20in=20the=0D=0Adebugfs=20framework=20for=20conditionally=20hiding=20certa=
in=20files=20from=20user,=20the=20custom=20implementation=20is=20a=20little=
=20tricky=20and=20will=20need=20some=0D=0Adiscussion=20before=20taking=20in=
.=20So=20let's=20take=20this=20up=20as=20a=20top=20up=20patch=20and=20live=
=20with=20returning=200=20when=20the=20counter=20is=20disabled=20for=20now?=
=0D=0A=0D=0AThanks=20a=20lot=20for=20the=20suggestion.=0D=0AShradha=20=0D=
=0A=0D=0A>=20Fan=0D=0A>=20>=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Thank=
=20you=21=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20=09Krzysztof=0D=0A>=20>=
=0D=0A>=20>=0D=0A=0D=0A

