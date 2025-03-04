Return-Path: <linux-pci+bounces-22928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF974A4F53D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 04:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED037A4AD8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75901126C13;
	Wed,  5 Mar 2025 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S2kU2CI2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC359B71
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144600; cv=none; b=b/rvypq2ALbbpUqzdITK5d9znCzRiJTS1+XnpV1uytxuWmk9HbmM1h+hmaJq5+Jt1wLXDxiwZI/r/jVUuJV5am7fmpKEn8WQjd7yDvZWhU74d/ZoFv9ydkQxL/lopA057331m32XcpQQYhBEFbthrLHDo/HdMA72+Ps3hNUzj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144600; c=relaxed/simple;
	bh=EsR4nGnyBDS/VIb+LpQZpmXrF5wEoCQl1Mo8HIK7ch4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=FH2Q2h2zsDPtl3i4+6PnpH8RRz9JurLRrkoGEM6PTlHSQvOaGfHi7/8Orsaude/WiRbViPMW9grKlThetEblFiyrzhrs/ukcCJioaOEB5wzOsQRgr3cq+GrxWHYaPcQ4i616cetC8dnvUYPQ9hF1rqqix7W3ZdUc4yyrFs0qW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S2kU2CI2; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250305031635epoutp0216fb23c21310e7f63e39bc5b65ff0c09~pycj1VRfQ0633506335epoutp02D
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 03:16:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250305031635epoutp0216fb23c21310e7f63e39bc5b65ff0c09~pycj1VRfQ0633506335epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741144595;
	bh=EsR4nGnyBDS/VIb+LpQZpmXrF5wEoCQl1Mo8HIK7ch4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=S2kU2CI2xje+emjK4Jg/RqSa3jUUwct/k0/OAPWmDVT7bNcG9njUDddd6pyFnPPXs
	 580vcBYClflQEHljRseFhrwy9+azvOjBcElBcpeZahTb6D0f8ueNkft4vzkWrk5Thr
	 fKX5zjSmjSk36yE/SQiEF+IZvo1XWpzH1NeUZioM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250305031635epcas5p32f97f9dce2000f5a89b131741355e606~pycjCzNs01185711857epcas5p38;
	Wed,  5 Mar 2025 03:16:35 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z6yPs2WBxz4x9Pr; Wed,  5 Mar
	2025 03:16:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DD.49.19933.112C7C76; Wed,  5 Mar 2025 12:16:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250304165250epcas5p39c2b800a8bfb14a9c5c1b01865e65869~pp78jai0Z1538215382epcas5p3e;
	Tue,  4 Mar 2025 16:52:50 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250304165250epsmtrp2f94931dc5f059ee5cd572b39f5f6e6ac~pp78iRIID0997409974epsmtrp2Y;
	Tue,  4 Mar 2025 16:52:50 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-9b-67c7c2114726
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.51.23488.2EF27C76; Wed,  5 Mar 2025 01:52:50 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250304165247epsmtip2e395c7a173fdc48666237081c1b53dbb~pp75iQzcE3269232692epsmtip22;
	Tue,  4 Mar 2025 16:52:46 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: =?UTF-8?Q?'Krzysztof_Wilczy=C5=84ski'?= <kw@linux.com>, "'Geert
 Uytterhoeven'" <geert@linux-m68k.org>
Cc: "'Fan Ni'" <nifan.cxl@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>,
	<lpieralisi@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<jingoohan1@gmail.com>, <Jonathan.Cameron@huawei.com>,
	<a.manzanares@samsung.com>, <pankaj.dubey@samsung.com>, <cassel@kernel.org>,
	<18255117159@163.com>, <xueshuai@linux.alibaba.com>,
	<renyu.zj@linux.alibaba.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	"'Yoshihiro Shimoda'" <yoshihiro.shimoda.uh@renesas.com>, "'Linux-Renesas'"
	<linux-renesas-soc@vger.kernel.org>
In-Reply-To: <20250304154638.GB2310180@rocinante>
Subject: RE: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Date: Tue, 4 Mar 2025 22:22:36 +0530
Message-ID: <061201db8d25$dd1e2bd0$975a8370$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJfby7SiE0e/TbLvAHLJIl0P7SXpgHiQm8TAh/83CQB4BrFQwHvpDbsAQ7NFRkCkbJgbLH/1d8A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOaU8vgHWH4sYHC0t3ZHEwuRRpPVVQjGQ5ypZ0YHRjWfAEDuXS
	mz0FcS4ZGx1TghaYl7UgwrgEuga0pQiMyuQqZm4SWVkmLBaYiog0A4ncZL3Axr/nfd7nvTzf
	l5dN55axAtmZcjWpkhNSlOkNt/aE7Ajz7R6QRNqv+WDD3y6zsMs9b2O1X2dg/SUNdOzRn1Ya
	1jCvY2GGahsTyy9eZmCmCRsDu99RwcTuVg4wsWFLE4xZpp7TMM2KBsbGNGcZWN3IEA1bbbVC
	2A+WeRZWXTAFYWudbSxMMyrAZhfNTOyFdY4Z54/XNFxg4MZKI4S368dYeJUpB9f0zjBwk+Es
	Ex+1dTLx7p4zzqRdhE8OX6bh5tov8YVfSmH8fIsBwudMb4m3JmfHZJBEGqnikfJURVqmXBKL
	JiSlHEwRCCP5YXwRthvlyQkZGYvGfyAOez9T6nSP8nIJaY6TEhMUhUbsi1EpctQkL0NBqWNR
	UpkmVUYrwylCRuXIJeFyUr2HHxkZJXAKj2dnDLZb6EpHVN7N608Y+dAtfhHkxQZINOhs/YZZ
	BHmzuchPEJht6WF4gn8gMPRIS/cECxC4ojVCGyWtXdPrJVYINNc10F0JLvIEAit23IWZyE4w
	Obzi5rch2WBVX+FuS0d0DKD/TsdyJbwQPhi80uTu6occBo12O+zCMBIM9NcMTg2bzUFEoP1l
	kovmIL5gUDfpltCR90B99TTdsxAPLP5dz/DMSga63i6GR+MP+haL3Q4AcscLFNbdXXcQD6ZN
	NqYH+4GnAy0sDw4Ec8+t67wENJq/Xx8gBQvmWpoH7wc/D1fArt3oSAho7ojw0EHg4p0mmmfu
	VnBueXJdzgFtlRt4O5hf7YQ9OABU9t9nlECofpM1/SZr+k0W9P9Pq4JgAxRAKimZhKQEyig5
	efK/D09VyEyQ+zhCD7dB9oeO8G6Ixoa6IcCmo9s4NUUDEi4njTj1OalSpKhypCTVDQmcz11K
	D3w9VeG8Lrk6hR8tiowWCoXRol1CPurPKWjXSLiIhFCT2SSpJFUbdTS2V2A+7WqVd2i8TLb3
	RuB+aryk9I8gv/KA2fm4AwlJxz7T5q1aXnGo8+nN4kPvNN47yO06VXxdvPbXBJl/YzRhV1lm
	1Md1lZfQm7f8svz74dMjpwu15eP+CTKD7KmgLPhcwfiBpXKfj4qOWOsMJ7eUjTwwh5jSM3u7
	DsWEpJ+YWcz+SrpTfwFfEidmjSOJO2oIiy2h/6XPdCLv09+NZ4ZGw4ilqomsvVUgAkRtae84
	Kn8cfMn+xhdTD3V9L167Z+6zSGcuth7bI3sVFGfv3z7kEDk+tF3lrTmOjn2SXJ975Bkv4Ecj
	OaO9DSfn9Zgdt5892C1MLy38VaU9Lsy1v/vmb77afcYTj1GYyiD4oXQVRfwLARpbpaUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCSvO4j/ePpBm+O8Fhcaf/NbjH9sKLF
	kqYMi2MTVjBbPLu1l8lixZeZ7BarFl5js2jo+c1qsenxNVaLy7vmsFmcnXeczeLK1nUsFltf
	vmOyaPnTwmJxt6WT1WLp9YtMFn+37WW0WLT1C7vFwuaXjBb/9+xgt2i5Y2rx/udmNouvez+z
	OYh7LF4xhdVjzbw1jB47Z91l91iwqdSj5chbVo9NqzrZPO5c28PmcehwB1DyoaXHkyvTmTw2
	L6n3+HZmIotH35ZVjB6fN8kF8EVx2aSk5mSWpRbp2yVwZfw518pasEepYnb/Z9YGxr9SXYyc
	HBICJhLb9r9m62Lk4hAS2M0osW3BRRaIhKTE54vrmCBsYYmV/56zQxQ9Y5T4MGsiM0iCTUBH
	4smVP2C2iEC2xJTbNxhBipgF1rNKnLn8khmi4wmTxJWPi1lBqjgFDCVOzl3HCGILC3hJrHz4
	EGwdi4CKxKwNq4BWcHDwClhK7PwRDBLmFRCUODnzCVgJs4C2RO/DVkYYe9nC18wQ1ylI/Hy6
	jBXiiCiJmUf2s0LUiEsc/dnDPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucmGxYY5qWW
	6xUn5haX5qXrJefnbmIEpw8tjR2M77416R9iZOJgPMQowcGsJMJr+vlYuhBvSmJlVWpRfnxR
	aU5q8SFGaQ4WJXHelYYR6UIC6YklqdmpqQWpRTBZJg5OqQYmlr/h53kuaXvxZ39nmpl5wCE+
	u12S+9zRxxsfqmjZagreer5VaNJRYUGWh2b+PzXqs2LS718JOOK7yiW/zVhl9vum+mdMIlPU
	DHVXr9/RGN3+eYbRfhWn63suKpbM/dfPVnHp/zWR3ENuCVFt769W9L+V0jtvZ8Yz4Rl7naX/
	5BV3Qk5O7T1a1ZRf+v7W/4MfT3wvTPXevUMmZOeSmnS2OZ3VD2PF3mSdb0xYoRT3Ncvr+Y7J
	3fenT1t7P3/SAn6hVQZTGY4tb5FctWn1ZOOy84JdD/1Kl8QWcCR98RF9p8kmOm366s3bF0Ts
	6Pj54kDPfkaZzkwzhwvGy0/0v3ojyXWuSGLy9YfvzN6+6H+cqMRSnJFoqMVcVJwIAAaza3SO
	AwAA
X-CMS-MailID: 20250304165250epcas5p39c2b800a8bfb14a9c5c1b01865e65869
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250221132035epcas5p47221a5198df9bf86020abcefdfded789
References: <20250221131548.59616-1-shradha.t@samsung.com>
	<CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
	<20250221131548.59616-4-shradha.t@samsung.com> <Z8XrYxP_pZr6tFU8@debian>
	<20250303194647.GC1552306@rocinante>
	<CAMuHMdWens9ZZrjNH1Bd2AN3PJEP1KSUGdiJcBCt0uPGH_GiiA@mail.gmail.com>
	<20250304154638.GB2310180@rocinante>



> -----Original Message-----
> From: Krzysztof Wilczy=C5=84ski=20<kw=40linux.com>=0D=0A>=20Sent:=2004=20=
March=202025=2021:17=0D=0A>=20To:=20Geert=20Uytterhoeven=20<geert=40linux-m=
68k.org>=0D=0A>=20Cc:=20Fan=20Ni=20<nifan.cxl=40gmail.com>;=20Shradha=20Tod=
i=20<shradha.t=40samsung.com>;=20linux-kernel=40vger.kernel.org;=20linux-=
=0D=0A>=20pci=40vger.kernel.org;=20linux-arm-kernel=40lists.infradead.org;=
=20linux-perf-users=40vger.kernel.org;=20manivannan.sadhasivam=40linaro.org=
;=0D=0A>=20lpieralisi=40kernel.org;=20robh=40kernel.org;=20bhelgaas=40googl=
e.com;=20jingoohan1=40gmail.com;=20Jonathan.Cameron=40huawei.com;=0D=0A>=20=
a.manzanares=40samsung.com;=20pankaj.dubey=40samsung.com;=20cassel=40kernel=
.org;=2018255117159=40163.com;=0D=0A>=20xueshuai=40linux.alibaba.com;=20ren=
yu.zj=40linux.alibaba.com;=20will=40kernel.org;=20mark.rutland=40arm.com;=
=20Yoshihiro=20Shimoda=0D=0A>=20<yoshihiro.shimoda.uh=40renesas.com>;=20Lin=
ux-Renesas=20<linux-renesas-soc=40vger.kernel.org>=0D=0A>=20Subject:=20Re:=
=20=5BPATCH=20v7=203/5=5D=20Add=20debugfs=20based=20silicon=20debug=20suppo=
rt=20in=20DWC=0D=0A>=20=0D=0A>=20Hello,=0D=0A>=20=0D=0A>=20>=20This=20patch=
=20is=20now=20commit=201ff54f4cbaed9ec6=20(=22PCI:=20dwc:=20Add=20debugfs=
=0D=0A>=20>=20based=20Silicon=20Debug=20support=20for=20DWC=22)=20in=20pci/=
next=20(next-20250304).=0D=0A>=20>=0D=0A>=20>=20On=20Mon,=203=20Mar=202025=
=20at=2020:47,=20Krzysztof=20Wilczy=C5=84ski=20<kw=40linux.com>=20wrote:=0D=
=0A>=20>=20>=20=5B...=5D=0D=0A>=20>=20>=20>=20>=20+int=20dwc_pcie_debugfs_i=
nit(struct=20dw_pcie=20*pci)=20=7B=0D=0A>=20>=20>=20>=20>=20+=20=20=20char=
=20dirname=5BDWC_DEBUGFS_BUF_MAX=5D;=0D=0A>=20>=20>=20>=20>=20+=20=20=20str=
uct=20device=20*dev=20=3D=20pci->dev;=0D=0A>=20>=20>=20>=20>=20+=20=20=20st=
ruct=20debugfs_info=20*debugfs;=0D=0A>=20>=20>=20>=20>=20+=20=20=20struct=
=20dentry=20*dir;=0D=0A>=20>=20>=20>=20>=20+=20=20=20int=20ret;=0D=0A>=20>=
=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20>=20+=20=20=20/*=20Create=20main=20di=
rectory=20for=20each=20platform=20driver=20*/=0D=0A>=20>=20>=20>=20>=20+=20=
=20=20snprintf(dirname,=20DWC_DEBUGFS_BUF_MAX,=20=22dwc_pcie_%s=22,=20dev_n=
ame(dev));=0D=0A>=20>=20>=20>=20>=20+=20=20=20dir=20=3D=20debugfs_create_di=
r(dirname,=20NULL);=0D=0A>=20>=20>=20>=20>=20+=20=20=20debugfs=20=3D=20devm=
_kzalloc(dev,=20sizeof(*debugfs),=20GFP_KERNEL);=0D=0A>=20>=20>=20>=20>=20+=
=20=20=20if=20(=21debugfs)=0D=0A>=20>=20>=20>=20>=20+=20=20=20=20=20=20=20=
=20=20=20=20return=20-ENOMEM;=0D=0A>=20>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=
=20>=20+=20=20=20debugfs->debug_dir=20=3D=20dir;=0D=0A>=20>=20>=20>=20>=20+=
=20=20=20pci->debugfs=20=3D=20debugfs;=0D=0A>=20>=20>=20>=20>=20+=20=20=20r=
et=20=3D=20dwc_pcie_rasdes_debugfs_init(pci,=20dir);=0D=0A>=20>=20>=20>=20>=
=20+=20=20=20if=20(ret)=0D=0A>=20>=20>=20>=20>=20+=20=20=20=20=20=20=20=20=
=20=20=20dev_dbg(dev,=20=22RASDES=20debugfs=20init=20failed=5Cn=22);=0D=0A>=
=20>=20>=20>=0D=0A>=20>=20>=20>=20What=20will=20happen=20if=20ret=20=21=3D=
=200?=20still=20return=200?=0D=0A>=20>=0D=0A>=20>=20And=20that=20is=20exact=
ly=20what=20happens=20on=20Gray=20Hawk=20Single=20with=20R-Car=0D=0A>=20>=
=20V4M:=20dw_pcie_find_rasdes_capability()=20returns=20NULL,=20causing=0D=
=0A>=20>=20dwc_pcie_rasdes_debugfs_init()=20to=20return=20-ENODEV.=0D=0A>=
=20=0D=0A>=20Thank=20you=20for=20testing=20and=20for=20catching=20this=20is=
sue.=20=20Much=20appreciated.=0D=0A>=20=0D=0A>=20>=20>=20Given=20that=20cal=
lers=20of=20dwc_pcie_debugfs_init()=20check=20for=20errors,=0D=0A>=20>=0D=
=0A>=20>=20Debugfs=20issues=20should=20never=20be=20propagated=20upstream=
=21=0D=0A>=20=0D=0A>=20Makes=20complete=20sense.=20=20Sorry=20for=20breakin=
g=20things=20here=21=0D=0A>=20=0D=0A>=20>=20>=20this=20probably=20should=20=
correctly=20bubble=20up=20any=20failure=20coming=20from=0D=0A>=20>=20>=20dw=
c_pcie_rasdes_debugfs_init().=0D=0A>=20>=20>=0D=0A>=20>=20>=20I=20made=20up=
dates=20to=20the=20code=20directly=20on=20the=20current=20branch,=20have=20=
a=20look:=0D=0A>=20>=0D=0A>=20>=20So=20while=20applying,=20you=20changed=20=
this=20like:=0D=0A>=20>=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20re=
t=20=3D=20dwc_pcie_rasdes_debugfs_init(pci,=20dir);=0D=0A>=20>=20=20=20=20=
=20-=20=20=20=20=20=20=20if=20(ret)=0D=0A>=20>=20=20=20=20=20-=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20dev_dbg(dev,=20=22RASDES=20debugfs=20init=
=20failed=5Cn=22);=0D=0A>=20>=20=20=20=20=20+=20=20=20=20=20=20=20if=20(ret=
)=20=7B=0D=0A>=20>=20=20=20=20=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20dev_err(dev,=20=22failed=20to=20initialize=20RAS=20DES=20debugfs=5Cn=
=22);=0D=0A>=20>=20=20=20=20=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20return=20ret;=0D=0A>=20>=20=20=20=20=20+=20=20=20=20=20=20=20=7D=0D=0A>=
=20>=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20return=200;=0D=0A>=20=
>=0D=0A>=20>=20Hence=20this=20is=20now=20a=20fatal=20error,=20causing=20the=
=20probe=20to=20fail.=0D=0A>=20=0D=0A>=20I=20removed=20the=20changed,=20and=
=20also=20move=20the=20log=20level=20to=20be=20a=20warning,=20per:=0D=0A>=
=20=0D=0A=0D=0AHey=20Krzysztof,=0D=0AI=20think=20we=20shouldn't=20move=20th=
e=20log=20level=20to=20be=20a=20WARN.=20I=20believe=20many=20controllers=20=
might=20not=20support=0D=0ARAS=20DES=20feature=20in=20their=20design=20and=
=20giving=20a=20warn=20dump=20would=20draw=20unnecessary=20attention.=0D=0A=
My=20opinion=20is=20to=20silently=20let=20it=20fail=20unless=20the=20user=
=20is=20actually=20interested=20in=20getting=20the=20RAS=20DES=20feature=20=
up.=0D=0AWe=20can=20wait=20for=20Mani's=20response=20though.=20But=20good=
=20catch=20to=20also=20add=20the=20error=20type,=20that's=20definitely=20a=
=20more=0D=0Ainformative=20error=20log.=0D=0A=0D=0A>=20=0D=0A>=20https://we=
b.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=3Dcontrolle=
r/dwc&id=3Dc6759a967e69aba16aef0d92f43e527b=0D=0A>=20112e98a5=0D=0A>=20=0D=
=0A>=20Would=20this=20be=20acceptable=20here?=0D=0A>=20=0D=0A>=20Mani,=20wo=
uld=20this=20be=20acceptable=20to=20you,=20too?=20=20Given=20that=20you=20p=
osted=20the=20following=20recently:=0D=0A>=20=0D=0A>=20=20=20https://lore.k=
ernel.org/linux-pci/20250303200055.GA1881771=40rocinante/T/=23mab9cbd583439=
0d259afea056eee9a73d8c3b435f=0D=0A>=20=0D=0A>=20That=20said,=20perhaps=20mo=
ving=20the=20log=20level=20to=20a=20debug=20would=20be=20better=20served=20=
here.=0D=0A>=20=0D=0A>=20=09Krzysztof=0D=0A=0D=0A

