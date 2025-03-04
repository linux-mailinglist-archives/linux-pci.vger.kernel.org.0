Return-Path: <linux-pci+bounces-22929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF7A4F542
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 04:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D78F16C2A4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 03:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACBC18A6D7;
	Wed,  5 Mar 2025 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HNnxajzQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26869186E56
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144606; cv=none; b=vBtZoTSXpUpOtnyB1ESdgkvTSRq/aabSBnTGFglAw+hM96djVjUynv3vBK+PFW8WfP0etdM+8mDMwuUxuBjGuEcYVLFRTzVGvW3PwqrWYuOqOWyWJ6IVq0XxWhSLpiJd+D/EUswSPRtVCDP7ro2yCxML2oE7exySftHW5rRBevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144606; c=relaxed/simple;
	bh=yUnqr75OoCvUiSRApxk6t53XmWVcdinIUHGuIV/vlgc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=TTpuLfWB+hmJy97/dxHXyOvAzkilMy2vu87XysNaAYvDhnPI3bVcE0lF+/iMmlCfYVtmycfk1jBywzEoPTAPzA0KlwHFnJlOIqNAvyfRX1aiJUqsViOeIJva4psGfAaRARJ+6zZbVAAF348LpFXtaZsOO1JhVAQk2sZIVHOB4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HNnxajzQ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250305031641epoutp0276eb191cdd13cf45a8fb246c450ca720~pyco3894Z0633506335epoutp02H
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 03:16:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250305031641epoutp0276eb191cdd13cf45a8fb246c450ca720~pyco3894Z0633506335epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741144601;
	bh=yUnqr75OoCvUiSRApxk6t53XmWVcdinIUHGuIV/vlgc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HNnxajzQW9ktUHZKaLgXr2GuMbqGysHb4ZcKmdsdw/rKaaX+9P2LbfWEDUYkkyxln
	 2EkFpFJAhj9rgaU2ssd2jmpUSXRV7292Bu5pRVMEhn32zUaBEBxEX5foLMRGfmej5l
	 eWz4S+gdXbxpbthBtuuX+/wzkeMQqEa/xtrfwRYM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250305031640epcas5p17112cb670dbd138db618b188e4c14264~pycoJdGRR1492314923epcas5p1D;
	Wed,  5 Mar 2025 03:16:40 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z6yPy4SPRz4x9Px; Wed,  5 Mar
	2025 03:16:38 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E0.02.20052.612C7C76; Wed,  5 Mar 2025 12:16:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250304170103epcas5p167ff23f37994f7465edfcf0c7228128b~pqDHjxXv62873728737epcas5p1a;
	Tue,  4 Mar 2025 17:01:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250304170103epsmtrp1341325dae096ffea3adb264573f4dbea~pqDHij8aB2899628996epsmtrp1s;
	Tue,  4 Mar 2025 17:01:03 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-99-67c7c216f562
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.69.18949.EC137C76; Wed,  5 Mar 2025 02:01:03 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250304170100epsmtip25c61f68cfcc753ee4402054c958c813f~pqDEvT7ue0734807348epsmtip2G;
	Tue,  4 Mar 2025 17:01:00 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: =?iso-8859-2?Q?'Krzysztof_Wilczy=F1ski'?= <kw@linux.com>, "'Manivannan
 Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<lpieralisi@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<jingoohan1@gmail.com>, <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
	<nifan.cxl@gmail.com>, <a.manzanares@samsung.com>,
	<pankaj.dubey@samsung.com>, <cassel@kernel.org>, <18255117159@163.com>,
	<xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>,
	<will@kernel.org>, <mark.rutland@arm.com>
In-Reply-To: <20250304153509.GA2310180@rocinante>
Subject: RE: [PATCH v7 4/5] Add debugfs based error injection support in DWC
Date: Tue, 4 Mar 2025 22:30:58 +0530
Message-ID: <061301db8d27$02e0ced0$08a26c70$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJfby7SiE0e/TbLvAHLJIl0P7SXpgJyxCsJAS8UdNQCRCuPiwHsN3CQAvWEj/yyBTAYoA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHPb19Mce8Fhhn6LTcoZFNunYUdljG3CLBa7Zl+FqY/gFXuGmR
	0tY+nOKCwKoIQy0DNmhGeXVYeWWjQEAeg4K8ZkkmDSN0qNvqwjAbOHkKiJQWw3+fc87nd87v
	e04OF+NlcAK4SXINrZJTMoK9jdncExwcstPaLxEuOl5E9qxlDrrcE4hMmVLUpzdjKLNmgoXM
	s8UcVF0+ykbpucss1HB/lIVGfrzCRjZjPxvZm+qZSLeiY6IJXTYLXb19i4FWmzsAqmia5aDy
	8w8BWmtv4SDdnTA0vWRhH/UjK80FLLLWWAvIVsMEhyxr0JK63kcssqE6m03eGW1nk613I0in
	/TKDtJi+IL9trAbk3w0vxGx/P/mwlKYSaRWflicoEpPkkkji+Dtxr8eFhQtFIaIIdJDgy6kU
	OpKIOhETEp0kW09K8D+hZNr1qRhKrSb2HzmsUmg1NF+qUGsiCVqZKFOKlQI1laLWyiUCOa05
	JBIKD4Sti/HJ0oymGqAc2PnpojULSwcLfjnAiwtxMRy6bWPlgG1cHt4GoLN70jN4AmB+6SWO
	y+Lh8wAWPw7YrCgxmD1SB4Bd+nrPYBLA1cxOlsti469Cp30Fc7Evfg7eL+xkuyQMv8CEjUOz
	wLXghYvgnKNlg33wE9D8r2ODmXgQXLtYtbGRNx4B8yqymG5+Fg4WOzcYwwXwwZDBw/tgVfmf
	mLs9Plz6w13ri5+GI+Y6ttvxhz8t5WKuJiBe6QWNv9k8BVFw4O48w80+cKq/kePmAPjwu688
	LIE/WIo8vgzOW0we/zXYZb/CdPNuWDhUz3AftgN+s+z0ON6wxbjJe+DsarvH3wWNfSMsPSAM
	W7IZtmQzbMlm2JKhDDCrwS5aqU6R0OowpUhOn/3/zRMUKQ1g4y/sfbMFTPw+I7ACBhdYAeRi
	hK93ZU6/hOedSH2WSqsUcSqtjFZbQdj6jedhAX4JivXPJNfEicQRQnF4eLg4IjRcRPh7n2/V
	SXi4hNLQyTStpFWbdQyuV0A6w38p7dCvu6281B33PhoZPzn38Zq4Y9+0iZaFSOsYDr2St9RR
	miY49njhWrR4LfTIK50Xu21nnwtcienNr3pQnXbdp3Pg0iBLH1n3XsxCdu3zx3tjB7VPmo+e
	ahtjTP2V8TURlZ0anfTuDbTn3unS66aXGgMT7LIKviW0bS3Q/2lTfLnt2C/6blNzfJww/2Vt
	ApU2Y1398ODb56aCHGccsfOfB493xY5PflAyPl1Uc+vnxfaxoilB6P632qZV1/C8m3VEifAN
	Rb7fcNnwU6ICbLzgS3pyYdTitJn/uaGoOZA7d6HnzNRMI3eobKxQn3O1c9BysyQ2T7J9OHqy
	8BH3++xngvoIplpKifZiKjX1H1EEwT+UBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGfXcuO45Wpznz1VnmqCiteVZab1BRH8Jjdwr6ENQaeZia07GT
	3SOzVWpZpka4dDkzm1NHzjQtu2kpBSnlssv0g7TsKlpe8pbGXIHffvA8v4f/hz+FSb7gAVRs
	wgFOn6COl5MivLpBHrSkRdmkYa6fwpDj3KgQXW0IRkUpMagx04KhlNIOAln6c4XIam4jUfKF
	UQLZP7YRqPVeHolemppI5Kiy4cgwZsBRhyGNQDffvhKgP9UPACqs6hci8+mvAE3U1QiRoT0C
	9QxXkmt92RuWHIItM5UBttbYIWQL7Ems4Wk3wdqtaSTb3lZHsrWdK1mX46qArSw6yV68YwVs
	n33Otmm7RKuiufjYg5w+bM1eUcyLviGgG5pxuNlZDpKBSZwOvClIh8N8o4VIByJKQt8HMN+U
	J/AE/rDvle0f+8CS8c9CT6kLwNG2N8AdkPRi6HKMYW6W0sdhnnMEd5cw2ozDjsxK4DFuC+Cd
	lBahu+VNK+GAs2bS9qE3Qcu4c5Jxeh6cyCom3CymV8LLhedwD8+Ez3Ndk4zRDCwyjwg8HAqL
	zd8xz3lz4fAnjyuld8JWSznp6fjBZ8MXsEzgY5wyZZwyZZwyZZyiFADcCvw5Ha/VaHmlbmkC
	d0jBq7V8UoJGsS9RaweTzxASUgPqrL2KeiCgQD2AFCaXiiP6GjUScbT6yFFOn6jSJ8VzfD2Q
	UbjcTzz4PSNaQmvUB7j9HKfj9P9TAeUdkCy4u/YHsS+PezsRfOsBE5eq89MhSXlV9rve4/yx
	NcU9y+Wrz5SkK649CXtxS/4tWLpj4Vi1zMaP/3x5MzN/Vvcm46nNltDuVb2OnOuyx18i/SRx
	WZ3dM294yQLjfDOSmciNgQb/Ff0lrukcW1pQkqq6u310/8DFtFrteleDVRpVfz+l6P3R6dm0
	ThGkkexmTgye+aD6sCcnt3124ZKdofbzDN/cKR4x22zvozbOz/nlUj7qmm9QqgLC8R1bd2+W
	BcOHDOX8SW/Dlz3NWKpbz1xZVOH1bUMFqAt/12XaohKBsKbImtcVp9kF9y71j8RmGEKfn21N
	XOa9bp2WGaikfs+W43yMWhmC6Xn1X5Rmp217AwAA
X-CMS-MailID: 20250304170103epcas5p167ff23f37994f7465edfcf0c7228128b
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250221132039epcas5p31913eab0acec1eb5e7874897a084c725
References: <20250221131548.59616-1-shradha.t@samsung.com>
	<CGME20250221132039epcas5p31913eab0acec1eb5e7874897a084c725@epcas5p3.samsung.com>
	<20250221131548.59616-5-shradha.t@samsung.com>
	<20250303095200.GB1065658@rocinante>
	<20250304152952.pal66goo2dwegevh@thinkpad>
	<20250304153509.GA2310180@rocinante>



> -----Original Message-----
> From: Krzysztof Wilczy=F1ski=20<kw=40linux.com>=0D=0A>=20Sent:=2004=20Mar=
ch=202025=2021:05=0D=0A>=20To:=20Manivannan=20Sadhasivam=20<manivannan.sadh=
asivam=40linaro.org>=0D=0A>=20Cc:=20Shradha=20Todi=20<shradha.t=40samsung.c=
om>;=20linux-kernel=40vger.kernel.org;=20linux-pci=40vger.kernel.org;=20lin=
ux-arm-=0D=0A>=20kernel=40lists.infradead.org;=20linux-perf-users=40vger.ke=
rnel.org;=20lpieralisi=40kernel.org;=20robh=40kernel.org;=20bhelgaas=40goog=
le.com;=0D=0A>=20jingoohan1=40gmail.com;=20Jonathan.Cameron=40huawei.com;=
=20fan.ni=40samsung.com;=20nifan.cxl=40gmail.com;=0D=0A>=20a.manzanares=40s=
amsung.com;=20pankaj.dubey=40samsung.com;=20cassel=40kernel.org;=2018255117=
159=40163.com;=0D=0A>=20xueshuai=40linux.alibaba.com;=20renyu.zj=40linux.al=
ibaba.com;=20will=40kernel.org;=20mark.rutland=40arm.com=0D=0A>=20Subject:=
=20Re:=20=5BPATCH=20v7=204/5=5D=20Add=20debugfs=20based=20error=20injection=
=20support=20in=20DWC=0D=0A>=20=0D=0A>=20Hello,=0D=0A>=20=0D=0A>=20=5B....=
=5D=0D=0A>=20>=20>=20>=20+=09=0929)=20Generates=20duplicate=20TLPs=20-=20du=
plicate_dllp=0D=0A>=20>=20>=20>=20+=09=0930)=20Generates=20Nullified=20TLPs=
=20-=20nullified_tlp=0D=0A>=20>=20>=0D=0A>=20>=20>=20Would=20the=20above=20=
field=20called=20=22duplicate_dllp=22=20for=20duplicate=20TLPs=20be=0D=0A>=
=20>=20>=20a=20potential=20typo?=20=20Perhaps=20this=20should=20be=20called=
=20=22duplicate_tlp=22?=0D=0A>=20>=20>=0D=0A>=20>=0D=0A>=20>=20Looks=20like=
=20a=20typo.=20As=20per=20Synopsys=20documentation,=20there=20is=20only=20'=
duplicate=20TLP'=0D=0A>=20>=20field.=0D=0A>=20>=0D=0A>=20>=20Good=20catch=
=21=0D=0A>=20=0D=0A>=20Updated.=20=20Thank=20you=21=0D=0A>=20=0D=0A=0D=0ASo=
rry,=20this=20was=20a=20typo.=20Krzysztof,=20we=20need=20another=20change=
=20for=20this=20typo.=0D=0A=0D=0Adiff=20--git=20a/drivers/pci/controller/dw=
c/pcie-designware-debugfs.c=20b/drivers/pci/controller/dwc/pcie-designware-=
debugfs.c=0D=0Aindex=20729ac14ff700..4d77db3ca6ae=20100644=0D=0A---=20a/dri=
vers/pci/controller/dwc/pcie-designware-debugfs.c=0D=0A+++=20b/drivers/pci/=
controller/dwc/pcie-designware-debugfs.c=0D=0A=40=40=20-113,7=20+113,7=20=
=40=40=20static=20const=20struct=20dwc_pcie_err_inj=20err_inj_list=5B=5D=20=
=3D=20=7B=0D=0A=20=20=20=20=20=20=20=20=7B=22posted_tlp_data=22,=200x4,=200=
x4=7D,=0D=0A=20=20=20=20=20=20=20=20=7B=22non_post_tlp_data=22,=200x4,=200x=
5=7D,=0D=0A=20=20=20=20=20=20=20=20=7B=22cmpl_tlp_data=22,=200x4,=200x6=7D,=
=0D=0A-=20=20=20=20=20=20=20=7B=22duplicate_dllp=22,=200x5,=200x0=7D,=0D=0A=
+=20=20=20=20=20=20=20=7B=22duplicate_tlp=22,=200x5,=200x0=7D,=0D=0A=20=20=
=20=20=20=20=20=20=7B=22nullified_tlp=22,=200x5,=200x1=7D,=0D=0A=20=7D;=0D=
=0A=0D=0ASo=20sorry=20for=20the=20inconvenience=21=20Should=20I=20post=20a=
=20patch=20for=20this?=0D=0A=0D=0A>=20=09Krzysztof=0D=0A=0D=0A

