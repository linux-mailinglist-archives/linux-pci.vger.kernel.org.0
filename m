Return-Path: <linux-pci+bounces-21392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C01A3515F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674EC3ACEA7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFD26E17C;
	Thu, 13 Feb 2025 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pZp4J/a8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314ED266B74
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486333; cv=none; b=lv/6DiwaHagdsc4fZt0713gAWQ3lNtpFuHVeaVdhMacxzR2HWMrrtzuEi33ysEiXwVm41ANtJoqx26JLlchW9+fxxYnTfbvSkTuF8nI4rz88MWjNq37ZRZLqQUOEm35TJj0mFBhTfCUNKAb1W/QZWDPP/XYYZdiHbl5vXpzg3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486333; c=relaxed/simple;
	bh=XzxNwZFgCKSezZ/DRf2OAQFYLa6FGvaFw5cd3EkILA4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=mRcGeH3aRnbz3hPFweMQogTW1zXM1i3oCiltpgFYltsu7jEHy3GbC+gNTcUJInrl4jbisMKVTavgNOse8gd8QtlOKW5cD6X5At8JpP5xYrvRNkNkwKz1e6goJyLZAmBiolByvlQ6ounrVBpIWeBZf8Vs160A0umcA+JrL61uiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pZp4J/a8; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250213223847epoutp0234efc0bb8887d623a8d48d8310ab5727~j5ZkmcEFY2673326733epoutp02g
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 22:38:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250213223847epoutp0234efc0bb8887d623a8d48d8310ab5727~j5ZkmcEFY2673326733epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739486327;
	bh=RuEImCMT9T5FHom+Ma10BET9FTMNrytuqdhryy082to=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=pZp4J/a8sb8wc0sESt8Kj80D6HIrzSFfwYcWTNurZmNtVYmCa0MSNJ0aRgOwMLb9m
	 drpdEH/Bq3Dn5m97MQFnzk8HK2GpTnCZj/IIqvO21+KPEbWf100EjNUJyIvn01fPp9
	 EEOLDhSlqXtZHu8blOxEouC0k0MfpN9FI8OnxTsc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250213223846epcas5p16f0f984ecb4be034d11532f7b2973acb~j5ZkBSDta0308003080epcas5p1p;
	Thu, 13 Feb 2025 22:38:46 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yv9844gMPz4x9Pr; Thu, 13 Feb
	2025 22:38:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.FF.29212.4747EA76; Fri, 14 Feb 2025 07:38:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250213173709epcas5p1e5f6d77a80e6a86400560ca7ef06053a~j1SNz_UGW1079310793epcas5p1s;
	Thu, 13 Feb 2025 17:37:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250213173709epsmtrp133b77dffaa8f767abd09e30e300f0748~j1SNzHW352551925519epsmtrp1i;
	Thu, 13 Feb 2025 17:37:09 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-a9-67ae74740ab8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.60.33707.5CD2EA76; Fri, 14 Feb 2025 02:37:09 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250213173707epsmtip12999bbba75b007dcc8005d07e7e89281~j1SLoqaCe3248332483epsmtip1M;
	Thu, 13 Feb 2025 17:37:06 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Niklas Cassel'" <cassel@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <pankaj.dubey@samsung.com>,
	<quic_nitegupt@quicinc.com>, <quic_krichai@quicinc.com>,
	<gost.dev@samsung.com>
In-Reply-To: <Z64EFN2QZ2AOF11I@ryzen>
Subject: RE: [PATCH v5 0/4] Add support for RAS DES feature in PCIe DW
Date: Thu, 13 Feb 2025 23:07:05 +0530
Message-ID: <005201db7e3d$e82427b0$b86c7710$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIF6yWfo3JYTHonCeozG/+o+TePrwHR/GHkAfXiPF+y0mU98A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmpm5Jybp0g5Y7ihbTDytaLGnKsDg2
	YQWzRdPqu6wWNw/sZLJY8WUmu8WqhdfYLBp6frNaXN41h83i7LzjbBYtf1pYLO62dLJaLNr6
	hd3iwYNKi845R5gt/u/Zwe4g4LFz1l12jwWbSj1ajrxl9di0qpPN4861PWweT65MZ/KYuKfO
	o2/LKkaPz5vkAjijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
	fAJ03TJzgF5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+Wl
	llgZGhgYmQIVJmRnzN74ia3ggW7FxXNbmRsYOzW6GDk5JARMJLrnH2LvYuTiEBLYwyjxff9G
	ZpCEkMAnRonV9/QgEkD276vzWWE6ju28zgZRtJNRonddIETRC0aJaysngxWxCehIPLnyB2yS
	iICmxJqf28FWMAvMYJY4c/IGWBGngKrEzKV/WEBsYQE3iTefnoA1sADF+7pWMYHYvAKWEieb
	21ggbEGJkzOfgNnMAtoSyxa+Zoa4SEHi59NlrBDLnCRWzf/ADFEjLnH0Zw8zyGIJgSccEpMv
	zWPsYuQAclwkLlwJh+gVlnh1fAs7hC0l8bK/DcpOl1i5eQbU/ByJb5uXMEHY9hIHrsxhARnD
	DPTY+l36EGFZiamn1jFBrOWT6P39BKqcV2LHPBhbWeLL3z0sELakxLxjl1knMCrNQvLZLCSf
	zULywSyEbQsYWVYxSqUWFOempyabFhjq5qWWwyM8OT93EyM4hWsF7GBcveGv3iFGJg7GQ4wS
	HMxKIrwS09akC/GmJFZWpRblxxeV5qQWH2I0BYb3RGYp0eR8YBbJK4k3NLE0MDEzMzOxNDYz
	VBLnbd7Zki4kkJ5YkpqdmlqQWgTTx8TBKdXAZFcedKn34PkH3J/ur92jrriiX/ow59KbybnV
	6XM6mjMSPRUPfvmkn79t1ZWU8NvrDH0OMpWUtdoW2zq6eRbxnJvflGX0YpGbtEh/2jF56bCj
	Ir2To6c7MDJbeCoFu0k/8D31hmet0PZj7/vssnI2OhzoOPo2ZWrtHQFG3SnmqnIKYTZ7Z/Vy
	p7w1y5izc92SRct+SHypjX7PIR+YzJA/p1X4mtfK7uD/3x93/jPsy0gV+d/D5Kp/fGeBQ0h7
	l5+2zKmXrFZZveeVmpe9PNx/1VbIUCc2YuMbD51/rPOnlu8IrtvQ2a7Eecpzwu+Tz5ZcK0lT
	cV3Z31VjMMMx8tSSZ8cLCktlmRMzPq1bFabEUpyRaKjFXFScCADsU9FHagQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSnO5R3XXpBk/X8ltMP6xosaQpw+LY
	hBXMFk2r77Ja3Dywk8lixZeZ7BarFl5js2jo+c1qcXnXHDaLs/OOs1m0/Glhsbjb0slqsWjr
	F3aLBw8qLTrnHGG2+L9nB7uDgMfOWXfZPRZsKvVoOfKW1WPTqk42jzvX9rB5PLkynclj4p46
	j74tqxg9Pm+SC+CM4rJJSc3JLEst0rdL4Mq4ON25YKF6xeUtV5gbGKfLdzFyckgImEgc23md
	rYuRi0NIYDujxKG7h5kgEpISny+ug7KFJVb+e84OUfSMUWLTrB42kASbgI7Ekyt/mEFsEQFN
	iTU/t4MVMQusYJY4su8pE0THUkaJX3dfMIJUcQqoSsxc+ocFxBYWcJN48+kJWDcLULyvaxXY
	Ol4BS4mTzW0sELagxMmZT8BsZgFtid6HrYww9rKFr5khzlOQ+Pl0GSvEFU4Sq+Z/YIaoEZc4
	+rOHeQKj8Cwko2YhGTULyahZSFoWMLKsYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAiOYK2g
	HYzL1v/VO8TIxMF4iFGCg1lJhFdi2pp0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLp
	iSWp2ampBalFMFkmDk6pBiazzd9UlCby5Cx7aJsvKGNsdWstz3NH1fdNu5N5O3Q2r9Tbn2zA
	kJOcvKrTWPPL4qenJ59f/Pn+qokta1yMOszuqV5M3ytnrFW76dzMc58mxDy9UdGyunH2uW+r
	+v+c1txvKv8hwlSvRHqXvKOx1PypExyWvvTZwD4zWm/Bz6stZzPYj675vSaofWp2lZek306x
	lUmWW+Mr1+hp3+B/sqB2S4rAtfexLDelDp4M+jdh4q99FTP+XrxSz/xPa40qb8u/02c8L4ow
	sZ/TXr/Qhmvl58NafsrKu77WSyzzeeByTTa0NGPJ+////x/rqT27vyFhQu8vJ/kZ084wtUnc
	ti/ZXpuSfHOTuFCvMLt30mp7JZbijERDLeai4kQA3tJjcE8DAAA=
X-CMS-MailID: 20250213173709epcas5p1e5f6d77a80e6a86400560ca7ef06053a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250121115157epcas5p15f8b34cd76cbbb3b043763e644469b18
References: <CGME20250121115157epcas5p15f8b34cd76cbbb3b043763e644469b18@epcas5p1.samsung.com>
	<20250121111421.35437-1-shradha.t@samsung.com> <Z64EFN2QZ2AOF11I@ryzen>



> -----Original Message-----
> From: Niklas Cassel <cassel=40kernel.org>
> Sent: 13 February 2025 20:09
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-kernel=40vger.kernel.org; linux-pci=40vger.kernel.org; manivann=
an.sadhasivam=40linaro.org; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com; jingoohan1=40gm=
ail.com; Jonathan.Cameron=40huawei.com;
> fan.ni=40samsung.com; a.manzanares=40samsung.com; pankaj.dubey=40samsung.=
com; quic_nitegupt=40quicinc.com;
> quic_krichai=40quicinc.com; gost.dev=40samsung.com
> Subject: Re: =5BPATCH v5 0/4=5D Add support for RAS DES feature in PCIe D=
W
>=20
> On Tue, Jan 21, 2025 at 04:44:17PM +0530, Shradha Todi wrote:
> > DesignWare controller provides a vendor specific extended capability
> > called RASDES as an IP feature. This extended capability  provides
> > hardware information like:
> >  - Debug registers to know the state of the link or controller.
> >  - Error injection mechanisms to inject various PCIe errors including
> >    sequence number, CRC
> >  - Statistical counters to know how many times a particular event
> >    occurred
> >
> > However, in Linux we do not have any generic or custom support to be
> > able to use this feature in an efficient manner. This is the reason we
> > are proposing this framework. Debug and bring up time of high-speed
> > IPs are highly dependent on costlier hardware analyzers and this
> > solution will in some ways help to reduce the HW analyzer usage.
> >
> > The debugfs entries can be used to get information about underlying
> > hardware and can be shared with user space. Separate debugfs entries
> > has been created to cater to all the DES hooks provided by the controll=
er.
> > The debugfs entries interacts with the RASDES registers in the
> > required sequence and provides the meaningful data to the user. This
> > eases the effort to understand and use the register information for deb=
ugging.
> >
> > v5:
> >     - Addressed Fan's comment to split the patches for easier review
> >     - Addressed Bjorn's comment to fix vendor specific cap search
> >     - Addressed style related change requests from v4
> >     - Added rasdes debugfs init call to common designware files for hos=
t
> >       and EP.
> >
> > v4: https://lore.kernel.org/lkml/20241206074456.17401-1-shradha.t=40sam=
sung.com/
> >     - Addressed comments from Manivannan, Bjorn and Jonathan
> >     - Addressed style related change requests from v3
> >     - Added Documentation under Documentation/ABI/testing and kdoc styp=
e
> >       comments wherever required for better understanding
> >     - Enhanced error injection to include all possible error groups
> >     - Removed debugfs init call from common designware file and left it
> >       up to individual platform drivers to init/deinit as required.
> >
> > v3: https://lore.kernel.org/all/20240625093813.112555-1-shradha.t=40sam=
sung.com/
> >     - v2 had suggestions about moving this framework to perf/EDAC inste=
ad of a
> >       controller specific debugfs but after discussions we decided to g=
o ahead
> >       with the same. Rebased and posted v3 with minor style changes.
> >
> > v2: https://lore.kernel.org/lkml/20231130115044.53512-1-shradha.t=40sam=
sung.com/
> >     - Addressed comments from Krzysztof Wilczy=C5=84ski,=20Bjorn=20Helg=
aas=20and=0D=0A>=20>=20=20=20=20=20=20=20posted=20v2=20with=20a=20changed=
=20implementation=20for=20a=20better=20code=20design=0D=0A>=20>=0D=0A>=20>=
=20v1:=0D=0A>=20>=20https://lore.kernel.org/all/20210518174618.42089-1-shra=
dha.t=40samsung.c=0D=0A>=20>=20om/T/=0D=0A>=20>=0D=0A>=20>=20Shradha=20Todi=
=20(4):=0D=0A>=20>=20=20=20PCI:=20dwc:=20Add=20support=20for=20vendor=20spe=
cific=20capability=20search=0D=0A>=20>=20=20=20Add=20debugfs=20based=20sili=
con=20debug=20support=20in=20DWC=0D=0A>=20>=20=20=20Add=20debugfs=20based=
=20error=20injection=20support=20in=20DWC=0D=0A>=20>=20=20=20Add=20debugfs=
=20based=20statistical=20counter=20support=20in=20DWC=0D=0A>=20>=0D=0A>=20>=
=20=20Documentation/ABI/testing/debugfs-dwc-pcie=20=20=20=20=7C=20144=20+++=
++=0D=0A>=20>=20=20drivers/pci/controller/dwc/Kconfig=20=20=20=20=20=20=20=
=20=20=20=20=20=7C=20=2010=20+=0D=0A>=20>=20=20drivers/pci/controller/dwc/M=
akefile=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=201=20+=0D=0A>=20>=20=20.=
../controller/dwc/pcie-designware-debugfs.c=20=20=7C=20561=20++++++++++++++=
++++=0D=0A>=20>=20=20.../pci/controller/dwc/pcie-designware-ep.c=20=20=20=
=7C=20=20=205=20+=0D=0A>=20>=20=20.../pci/controller/dwc/pcie-designware-ho=
st.c=20=7C=20=20=206=20+=0D=0A>=20>=20=20drivers/pci/controller/dwc/pcie-de=
signware.c=20=20=7C=20=2019=20+=0D=0A>=20>=20drivers/pci/controller/dwc/pci=
e-designware.h=20=20=7C=20=2016=20+=0D=0A>=20>=20=208=20files=20changed,=20=
762=20insertions(+)=0D=0A>=20>=20=20create=20mode=20100644=20Documentation/=
ABI/testing/debugfs-dwc-pcie=0D=0A>=20>=20=20create=20mode=20100644=0D=0A>=
=20>=20drivers/pci/controller/dwc/pcie-designware-debugfs.c=0D=0A>=20>=0D=
=0A>=20>=20--=0D=0A>=20>=202.17.1=0D=0A>=20>=0D=0A>=20=0D=0A>=20Shradha,=0D=
=0A>=20=0D=0A>=20Thank=20you=20for=20this=20awesome=20feature=21=0D=0A>=20=
=0D=0A>=20It=20would=20be=20great=20if=20we=20could=20get=20it=20included=
=20in=20v6.15.=0D=0A>=20=0D=0A>=20Are=20you=20intending=20to=20send=20out=
=20a=20v6?=0D=0A>=20=0D=0A>=20=0D=0A>=20Kind=20regards,=0D=0A>=20Niklas=0D=
=0A=0D=0AYes=20Niklas,=20I=20added=20some=20changes=20as=20discussed=20in=
=20the=20patch=20sent=20by=20Hans=20which=20separates=0D=0Arasdes_init=20an=
d=20debugfs_init=20and=20the=20structures=20so=20as=20to=20not=20make=20thi=
s=20file=20rasdes=20specific.=0D=0AIn=20the=20process=20of=20testing=20and=
=20will=20send=20it=20out=20soon.=0D=0A=0D=0A

