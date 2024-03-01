Return-Path: <linux-pci+bounces-4305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D586DF51
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E5E2837F0
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9A339B1;
	Fri,  1 Mar 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kdkx9Y2i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71796BFA2
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289476; cv=none; b=TN4xd8yJdZCVDVECHGsC5e/nxVhsAe/zJ9VJDf5lhih5NKG8p9+KpOW6FvxyETJAAiqrvaT6fNdtXlzLW682C3dgYcIc4ptRi98As0kQs5KNx5MfofEgT7myLRrwwoJ4FD/musz1wLQ52Nf7KRdX0SVk4rXsTBZHcCOVjQdYA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289476; c=relaxed/simple;
	bh=xKhyqXO0n0OodQ/OItqgMq3UmDlMDbHgMVmlX/VRCNY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=p/OZouVp1VJJ3wBqkCX02NgJ0/Bc0L4slCYAuEHZLuHs9TgZXgBxSh3d750CepSfnDyvLEWbYWb559NLZ7OsyO9GE3axFrbRe17hasf5S7cE721J016tCasfe/431lpwyaX9AuSbMBuTehOEDpfLti9Kj10+uOV77fcLYiAoXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Kdkx9Y2i; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240301103746epoutp04710a91e88f79f1a70a575acb93d267ed~4nbaU1ujK1811718117epoutp045
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 10:37:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240301103746epoutp04710a91e88f79f1a70a575acb93d267ed~4nbaU1ujK1811718117epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709289466;
	bh=xKhyqXO0n0OodQ/OItqgMq3UmDlMDbHgMVmlX/VRCNY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Kdkx9Y2i+JJ6+WZU8X4C2B/wM/X/AGTWi6g3S1LXNLjHRsNnJmbwPuqdp3E4npjCl
	 9coBfbYxy8+drGO0+vi6eG2GvJ3Ga4YEmHv88HQMyYkoqUssEj2LLu8IxAtpK+GcSs
	 blw+BjIv9sawe/rJK3hg16U4sqWXWN1yAgQJCLds=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240301103745epcas5p2cc84e531277fb122a52ef7125c4c892c~4nbZkEJ6d2339723397epcas5p2H;
	Fri,  1 Mar 2024 10:37:45 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TmPgC3Mk2z4x9Q0; Fri,  1 Mar
	2024 10:37:43 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.13.09634.6FFA1E56; Fri,  1 Mar 2024 19:37:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240301103724epcas5p3dd9a405b3b0c5a818db3a3e82e8558d0~4nbF15T5N0707407074epcas5p3f;
	Fri,  1 Mar 2024 10:37:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240301103724epsmtrp24a71f06d5c0f2aff61f745e4b6850e65~4nbF1H02c1351713517epsmtrp2F;
	Fri,  1 Mar 2024 10:37:24 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-45-65e1aff63777
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.A7.08817.3EFA1E56; Fri,  1 Mar 2024 19:37:23 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240301103722epsmtip12d45b2ac56414e903af8c0ec5d8143db~4nbEnyx1U1091810918epsmtip1c;
	Fri,  1 Mar 2024 10:37:22 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Niklas Cassel'" <cassel@kernel.org>, "'Lorenzo Pieralisi'"
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?'Krzysztof_Wilczy=F1ski'?=
	<kw@linux.com>, "'Manivannan Sadhasivam'"
	<manivannan.sadhasivam@linaro.org>, "'Kishon Vijay Abraham I'"
	<kishon@kernel.org>, "'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>
In-Reply-To: <ZeDO8RakU49eqXAl@fedora>
Subject: RE: [PATCH 2/2] PCI: endpoint: Set prefetch when allocating memory
 for 64-bit BARs
Date: Fri, 1 Mar 2024 16:07:21 +0530
Message-ID: <001001da6bc4$725e36b0$571aa410$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMlPDAOqyVYMQW57jQEzRbQIAXMuwG/qtmkAjrlfm8BuVCupa5fOI4A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmlu639Q9TDdafMLRY0pRhcWzCCmaL
	o63/mS0aen6zWpydd5zNouVPC4vF3ZZOVgd2jwWbSj02repk87hzbQ+bx5Mr05k8Pm+SC2CN
	yrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpCSaEs
	MacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd
	sbLzNFtBk1XFqxd3WRsY11p0MXJwSAiYSEzd59XFyMUhJLCbUeLV5F1sEM4nRonJXReZIZxv
	jBJ3/rQwwnQ8OFUBEd/LKLHlwjUmCOcFo8ScjfOAijg52AR0JJ5c+QPWLSKwkUli/uXz7CAJ
	ZgF5if8PDrCA2JwCahKb5jSBxYUFYiV+Pd3BDLKBRUBF4l9HHkiYV8BS4sqEhewQtqDEyZlP
	WCDG6Ek8OzULytaWWLbwNTOILSGgIPHz6TJWkDEiAm4SVyeaQZSISxz92QN2joTAVA6JPz8W
	s0PUu0hcv3edCcIWlnh1fAtUXEri87u9bBB2usTKzTOg5udIfNu8BKreXuLAlTksELasxNRT
	65gglvFJ9P5+AlXDK7FjHoytLPHl7x6oekmJeccus05gVJqF5LVZSF6bheS1WUh+WMDIsopR
	MrWgODc9tdi0wDAvtRwe4cn5uZsYwWlUy3MH490HH/QOMTJxMB5ilOBgVhLh3c/6MFWINyWx
	siq1KD++qDQntfgQoykwvCcyS4km5wMTeV5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp
	2ampBalFMH1MHJxSDUwJEwoE0jb82D/hPkfy0l87P5UVfmR+37F53+7qJqF/8/KW3PN1LeAy
	/BLiWCf5JuHFpi29ldfei99st97xTE7nxZ32TdI/+Reu/tCtlbivOob92ReBDRV3bF6uc3F4
	pndW0Xhz55pEvr9mWrZTJjo9Lr0zbY9msxbLB4ekIt757j9+L4r123v41d6Zygav5XdM2GNl
	VG4769vSN8d7zrK+v+k0YYnVwi033xgpJbrkBt10fh62SqA/itNJvjtr4rqkPEbJqO9L7koc
	6b2ttP1rqYHJd0c91r6q5NBg0Yxd18MjImdpuAmaPuyVXfZsSiNzWF9AYU8/tyXz0/ilnhIx
	shOvSrFGitl+Uvw7g0GJpTgj0VCLuag4EQD05EGRLAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJTvfx+oepBncPW1gsacqwODZhBbPF
	0db/zBYNPb9ZLc7OO85m0fKnhcXibksnqwO7x4JNpR6bVnWyedy5tofN48mV6UwenzfJBbBG
	cdmkpOZklqUW6dslcGWs/HyZqeCmWsWjht9sDYzz5boYOTgkBEwkHpyq6GLk4hAS2M0oceHR
	B9YuRk6guKTE54vrmCBsYYmV/56zQxQ9Y5TYc/wnO0iCTUBH4smVP8wgCRGBzUwSj1sbwLqZ
	BeQl/j84wALRcZ5R4mF/K1iCU0BNYtOcJrBuYYFoiQun7zOCnMEioCLxryMPJMwrYClxZcJC
	dghbUOLkzCcsEDMNJJYs/MUEYWtLLFv4mhniOgWJn0+XsYKMERFwk7g60QyiRFzi6M8e5gmM
	wrOQTJqFZNIsJJNmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOJK0tHYw
	7ln1Qe8QIxMH4yFGCQ5mJRHe/awPU4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIkkJ5Y
	kpqdmlqQWgSTZeLglGpgana5YJMT8eCCvnPDO64KoUfPEqzyZvL6Wt1VvvpL/usX0/27k2Vb
	8k3W/+KskJl2Z959f99kV8O5VUfn/taOjFloFXZuadf9ZanL/7zuT/853ba95cCO1M3XPzjM
	7+nZuPbs9/hjSz97fThqyhP+Quti+KL3lvnM2+68OKSj6d32NVX/b8jGyZ1R6x9zNjKtLco6
	eepO5V7HYx+ZXXbLnpLU1zMTvOK1jcPFRK39zfTbR/tMHX7xLyr7yHt3ndfqFeXbRHLlC756
	tR2PSax+UWU++9VZxWYzHbkzuYZ16++XTfB6t2RPEstbsQtz5R/8OL4iacKF0tresvTby5YU
	uLyZHB/4WONP3LmUq6dKxZVYijMSDbWYi4oTAeLF7H4TAwAA
X-CMS-MailID: 20240301103724epcas5p3dd9a405b3b0c5a818db3a3e82e8558d0
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240229183745epcas5p31e5cdc286a1d879e5e3d552adefd1964
References: <20240229104900.894695-1-cassel@kernel.org>
	<20240229104900.894695-3-cassel@kernel.org>
	<CGME20240229183745epcas5p31e5cdc286a1d879e5e3d552adefd1964@epcas5p3.samsung.com>
	<ZeDO8RakU49eqXAl@fedora>



> -----Original Message-----
> From: Niklas Cassel <cassel=40kernel.org>
> Sent: 01 March 2024 00:08
> To: Lorenzo Pieralisi <lpieralisi=40kernel.org>; Krzysztof Wilczy=F1ski=
=0D=0A>=20<kw=40linux.com>;=20Manivannan=20Sadhasivam=0D=0A>=20<manivannan.=
sadhasivam=40linaro.org>;=20Kishon=20Vijay=20Abraham=20I=0D=0A>=20<kishon=
=40kernel.org>;=20Bjorn=20Helgaas=20<bhelgaas=40google.com>=0D=0A>=20Cc:=20=
Shradha=20Todi=20<shradha.t=40samsung.com>;=20linux-pci=40vger.kernel.org=
=0D=0A>=20Subject:=20Re:=20=5BPATCH=202/2=5D=20PCI:=20endpoint:=20Set=20pre=
fetch=20when=20allocating=20memory=0D=0Afor=0D=0A>=2064-bit=20BARs=0D=0A>=
=20=0D=0A>=20On=20Thu,=20Feb=2029,=202024=20at=2011:48:59AM=20+0100,=20Nikl=
as=20Cassel=20wrote:=0D=0A>=20>=20From=20the=20PCIe=206.0=20base=20spec:=0D=
=0A>=20>=20=22Generally=20only=2064-bit=20BARs=20are=20good=20candidates,=
=20since=20only=20Legacy=0D=0A>=20>=20Endpoints=20are=20permitted=20to=20se=
t=20the=20Prefetchable=20bit=20in=2032-bit=20BARs,=0D=0A>=20>=20and=20most=
=20scalable=20platforms=20map=20all=2032-bit=20Memory=20BARs=20into=0D=0A>=
=20>=20non-prefetchable=20Memory=20Space=20regardless=20of=20the=20Prefetch=
able=20bit=20value.=22=0D=0A>=20>=0D=0A>=20>=20=22For=20a=20PCI=20Express=
=20Endpoint,=2064-bit=20addressing=20must=20be=20supported=20for=0D=0A>=20>=
=20all=20BARs=20that=20have=20the=20Prefetchable=20bit=20Set.=2032-bit=20ad=
dressing=20is=0D=0A>=20>=20permitted=20for=20all=20BARs=20that=20do=20not=
=20have=20the=20Prefetchable=20bit=20Set.=22=0D=0A>=20>=0D=0A>=20>=20=22Any=
=20device=20that=20has=20a=20range=20that=20behaves=20like=20normal=20memor=
y=20should=0D=0A>=20>=20mark=20the=20range=20as=20prefetchable.=20A=20linea=
r=20frame=20buffer=20in=20a=20graphics=0D=0A>=20>=20device=20is=20an=20exam=
ple=20of=20a=20range=20that=20should=20be=20marked=20prefetchable.=22=0D=0A=
>=20>=0D=0A>=20>=20The=20PCIe=20spec=20tells=20us=20that=20we=20should=20ha=
ve=20the=20prefetchable=20bit=20set=0D=0A>=20>=20for=2064-bit=20BARs=20back=
ed=20by=20=22normal=20memory=22.=20The=20backing=20memory=20that=20we=0D=0A=
>=20>=20allocate=20for=20a=2064-bit=20BAR=20using=20pci_epf_alloc_space()=
=20(which=20calls=0D=0A>=20>=20dma_alloc_coherent())=20is=20obviously=20=22=
normal=20memory=22.=0D=0A>=20>=0D=0A>=20>=20Thus,=20set=20the=20prefetchabl=
e=20bit=20when=20allocating=20backing=20memory=20for=20a=0D=0A>=20>=2064-bi=
t=20BAR.=0D=0A>=20>=0D=0A>=20>=20Signed-off-by:=20Niklas=20Cassel=20<cassel=
=40kernel.org>=0D=0A>=20>=20---=0D=0A>=20>=20=20drivers/pci/endpoint/pci-ep=
f-core.c=20=7C=203=20++-=0D=0A>=20>=20=201=20file=20changed,=202=20insertio=
ns(+),=201=20deletion(-)=0D=0A>=20>=0D=0A>=20>=20diff=20--git=20a/drivers/p=
ci/endpoint/pci-epf-core.c=0D=0A>=20>=20b/drivers/pci/endpoint/pci-epf-core=
.c=0D=0A>=20>=20index=20e7dbbeb1f0de..10264d662abf=20100644=0D=0A>=20>=20--=
-=20a/drivers/pci/endpoint/pci-epf-core.c=0D=0A>=20>=20+++=20b/drivers/pci/=
endpoint/pci-epf-core.c=0D=0A>=20>=20=40=40=20-305,7=20+305,8=20=40=40=20vo=
id=20*pci_epf_alloc_space(struct=20pci_epf=20*epf,=20size_t=0D=0A>=20size,=
=20enum=20pci_barno=20bar,=0D=0A>=20>=20=20=09epf_bar=5Bbar=5D.size=20=3D=
=20size;=0D=0A>=20>=20=20=09epf_bar=5Bbar=5D.barno=20=3D=20bar;=0D=0A>=20>=
=20=20=09if=20(upper_32_bits(size)=20=7C=7C=20epc_features->bar=5Bbar=5D.on=
ly_64bit)=0D=0A>=20>=20-=09=09epf_bar=5Bbar=5D.flags=20=7C=3D=20PCI_BASE_AD=
DRESS_MEM_TYPE_64;=0D=0A>=20>=20+=09=09epf_bar=5Bbar=5D.flags=20=7C=3D=20PC=
I_BASE_ADDRESS_MEM_TYPE_64=20=7C=0D=0A>=20>=20+=09=09=09=09=20=20=20=20=20=
=20PCI_BASE_ADDRESS_MEM_PREFETCH;=0D=0A>=20>=20=20=09else=0D=0A>=20>=20=20=
=09=09epf_bar=5Bbar=5D.flags=20=7C=3D=20PCI_BASE_ADDRESS_MEM_TYPE_32;=0D=0A=
>=20=0D=0A>=20This=20should=20probably=20be:=0D=0A>=20=0D=0A>=20if=20(upper=
_32_bits(size)=20=7C=7C=20epc_features->bar=5Bbar=5D.only_64bit)=0D=0A>=20=
=09epf_bar=5Bbar=5D.flags=20=7C=3D=20PCI_BASE_ADDRESS_MEM_TYPE_64;=20else=
=0D=0A>=20=09epf_bar=5Bbar=5D.flags=20=7C=3D=20PCI_BASE_ADDRESS_MEM_TYPE_32=
;=0D=0A>=20=0D=0A>=20if=20(epf_bar=5Bbar=5D.flags=20&=20PCI_BASE_ADDRESS_ME=
M_TYPE_64)=0D=0A>=20=09epf_bar=5Bbar=5D.flags=20=7C=3D=20PCI_BASE_ADDRESS_M=
EM_PREFETCH;=0D=0A>=20=0D=0A>=20so=20that=20we=20set=20PREFETCH=20even=20fo=
r=20a=20EPF=20driver=20that=20had=0D=0A>=20PCI_BASE_ADDRESS_MEM_TYPE_64=20s=
et=20in=20flags=20even=20before=20calling=0D=0A>=20pci_epf_alloc_space.=20W=
ill=20fix=20in=20V2.=0D=0A>=20=0D=0A>=20=0D=0A>=20=0D=0A>=20=0D=0A>=20I=20a=
lso=20found=20a=20bug=20in=20the=20existing=20code.=0D=0A>=20If=20pci_epf_a=
lloc_space()=20allocated=20a=2064-bit=20BAR=20because=20of=20bits=20in=20si=
ze,=20then=0D=0Athe=0D=0A>=20increment=20in=20pci_epf_test_alloc_space()=20=
was=20incorrect.=0D=0A>=20(I=20guess=20no=20one=20uses=20BARs=20>=204GB).=
=0D=0A>=20=0D=0A>=20---=20a/drivers/pci/endpoint/functions/pci-epf-test.c=
=0D=0A>=20+++=20b/drivers/pci/endpoint/functions/pci-epf-test.c=0D=0A>=20=
=40=40=20-865,6=20+865,12=20=40=40=20static=20int=20pci_epf_test_alloc_spac=
e(struct=20pci_epf=20*epf)=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20dev_err(dev,=20=22Failed=20to=20allocate=
=20space=20for=20BAR%d=5Cn=22,=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20bar);=0D=0A>=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20epf_test->reg=5Bbar=5D=
=20=3D=20base;=0D=0A>=20+=0D=0A>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20/*=0D=0A>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=20pci_=
epf_alloc_space()=20might=20have=20given=20us=20a=2064-bit=20BAR,=0D=0A>=20=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=20even=20if=20we=20only=
=20requested=20a=2032-bit=20BAR.=0D=0A>=20+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20*/=0D=0A>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20add=20=3D=20(epf_bar->flags=20&=20PCI_BASE_ADDRESS_MEM_TYPE_64)=20?=0D=
=0A>=20+=202=20:=201;=0D=0A>=20=0D=0A>=20Will=20send=20a=20separate=20fix=
=20with=20the=20above.=0D=0A>=20=0D=0A>=20=0D=0A>=20Kind=20regards,=0D=0A>=
=20Niklas=0D=0A=0D=0AHi=20Niklas,=0D=0A=0D=0AA=20similar=20fix=20should=20g=
o=20for=20pci_epf_test_set_bar()=20as=20well,=20since=0D=0Apci_epc_set_bar(=
)=0D=0Amay=20change=20the=20flags.=0D=0A=0D=0Adiff=20--git=20a/drivers/pci/=
endpoint/functions/pci-epf-test.c=0D=0Ab/drivers/pci/endpoint/functions/pci=
-epf-test.c=0D=0Aindex=20cd4ffb39dcdc..3bf4340e9d7b=20100644=0D=0A---=20a/d=
rivers/pci/endpoint/functions/pci-epf-test.c=0D=0A+++=20b/drivers/pci/endpo=
int/functions/pci-epf-test.c=0D=0A=40=40=20-741,6=20+741,8=20=40=40=20stati=
c=20int=20pci_epf_test_set_bar(struct=20pci_epf=20*epf)=0D=0A=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(bar=20=3D=
=3D=20test_reg_bar)=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20ret;=0D=0A=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0A+=0D=0A+=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20add=20=3D=20(epf_bar->flags=20&=20PCI_BASE_AD=
DRESS_MEM_TYPE_64)=20?=202=20:=201;=0D=0A=20=20=20=20=20=20=20=20=7D=0D=0A=
=0D=0A=20=20=20=20=20=20=20=20return=200;=0D=0A=0D=0ADo=20you=20want=20to=
=20add=20it=20as=20part=20of=20the=20same=20patch?=20Or=20should=20I=20post=
=20another=20patch=0D=0Afor=20this?=0D=0A=0D=0A

