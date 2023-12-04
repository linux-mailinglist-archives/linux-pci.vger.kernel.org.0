Return-Path: <linux-pci+bounces-399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821F3802DCE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 10:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4531F21073
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859FFFC1F;
	Mon,  4 Dec 2023 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vr93YOHi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279ACCD
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 01:07:46 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231204090743epoutp03e9653dfd9e955e64aba54bb284ec09b8~dlbqm9OgF3258532585epoutp03Z
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 09:07:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231204090743epoutp03e9653dfd9e955e64aba54bb284ec09b8~dlbqm9OgF3258532585epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701680863;
	bh=vcYt1R54N2+/4tQmNYRaPFiz1z4tnQB4WN87TIBJZak=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Vr93YOHiz277qB3ikTnJbJc3wtLkOmx2TEz0ScHWiO5SYlshvKMAOf5xScSXHd/el
	 AMmo+vWXaoKxhsf2EMq0Kt4H3kcuWPsSIVMJsXP9SoJsEos5oktrIFeHjTYUJRNP9c
	 +qH7IEIaIfXplNzr84VQNGRvh4JWj9soKJfwdpV0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231204090742epcas5p14f3287fba4f6e6f13bcfdd50f19bfbd9~dlbqF6_cA0703007030epcas5p11;
	Mon,  4 Dec 2023 09:07:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SkHqw69zkz4x9Q0; Mon,  4 Dec
	2023 09:07:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.90.09672.CD69D656; Mon,  4 Dec 2023 18:07:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231204084016epcas5p24e21f003c76b82ad8907fa182f150eb7~dlDs7ZB0O1129011290epcas5p2c;
	Mon,  4 Dec 2023 08:40:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231204084016epsmtrp17451a4f40ea7029593c957e077bc8adb~dlDs6DULo1653516535epsmtrp1-;
	Mon,  4 Dec 2023 08:40:16 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-26-656d96dcb64d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.66.08817.0709D656; Mon,  4 Dec 2023 17:40:16 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231204084014epsmtip10473e532106c4e53cbf96f371a2e5391~dlDrF8zG52464424644epsmtip1T;
	Mon,  4 Dec 2023 08:40:14 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<gustavo.pimentel@synopsys.com>, <josh@joshtriplett.org>,
	<lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
	<pankaj.dubey@samsung.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
In-Reply-To: <20231130165514.GW3043@thinkpad>
Subject: RE: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Date: Mon, 4 Dec 2023 14:10:06 +0530
Message-ID: <000001da268d$81210500$83630f00$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG/Q0WxGB9EWFeblm7N70OL8blxhQGR1/IBAmU4G1qwrtlAgA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmpu6dabmpBnuWaFssacqw2HW3g91i
	1ra5jBYrvsxkt/i/IN+ioec3q8XlXXPYLM7OO85m0fKnhcWi5Wg7i8Xdlk5Wi0VbvwCV7dnB
	7sDrsXPWXXaPBZtKPW69tvXYtKqTzePOtT1sHk+uTGfy2PhuB5NH35ZVjB5b9n9m9Pi8SS6A
	KyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfociWF
	ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
	dsaeZdvZCq4qVvzp4Ghg3C3dxcjJISFgInGk6z8jiC0ksJtRonkjcxcjF5D9iVGita2bFcL5
	xijx98I9NpiOa9MbmSASexkl7jW/YYNwXjBKLN28hwmkik1AR+LJlT/MILaIgINE+9tPLCBF
	zAJ7mSS2vtrNCpLgFNCVWDjzK1iDsECwxPSpXSwgNouAisTMeWeApnJw8ApYSkw7WQAS5hUQ
	lDg58wlYCbOAtsSyha+ZIS5SkPj5dBkrxC4nidYf15ghasQljv7sAftHQuABh8TljdvZIRpc
	JBqOnYZ6R1ji1fEtUHEpiZf9bVB2usTKzTOgFuRIfNu8hAnCtpc4cGUOC8htzAKaEut36UOE
	ZSWmnlrHBLGXT6L39xOocl6JHfNgbGWJL3/3sEDYkhLzjl1mncCoNAvJa7OQvDYLyQuzELYt
	YGRZxSiZWlCcm55abFpgnJdaDo/v5PzcTYzgdK3lvYPx0YMPeocYmTgYDzFKcDArifDOu5Wd
	KsSbklhZlVqUH19UmpNafIjRFBjcE5mlRJPzgRkjryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQh
	gfTEktTs1NSC1CKYPiYOTqkGpp6kDBelI7tst0m47nrruzfn9VWRp06vcreml2Tffv/jg1uy
	f+P5w182hrv9ePdd2LGXQzsosvBvltpzt+S9EYL8Se3ntW6t2fe//ehz77fWk4xu3pQ7u2l5
	1mexdWFp57h8pA//nXl7/YSOEgcLw8frE1U3qzCuVuP55J/e8nj9wtLCiEcbK/yFXPb091Ud
	rpyg+IOhxdUlRFZn1X7FmAaDf8snfmHdlKG8zItb5ih7hdapK90e8Yf/shsvnvHS7cZ7zgOL
	uH+2PbDcrh3+uWVy2ZJfhX69Cuv339y18vIXr8vs/TbvHXRXzLy/+tN1o/++BvwtskZC8aY5
	vl/qdT7a5ex4HJ52W2Zn+dSpKkosxRmJhlrMRcWJAHzFY+pgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSnG7BhNxUg/NT+CyWNGVY7LrbwW4x
	a9tcRosVX2ayW/xfkG/R0POb1eLyrjlsFmfnHWezaPnTwmLRcrSdxeJuSyerxaKtX4DK9uxg
	d+D12DnrLrvHgk2lHrde23psWtXJ5nHn2h42jydXpjN5bHy3g8mjb8sqRo8t+z8zenzeJBfA
	FcVlk5Kak1mWWqRvl8CVcbj1K2PBPMWKF7t+sTYw/pbqYuTkkBAwkbg2vZGpi5GLQ0hgN6PE
	2wVHmCESkhKfL65jgrCFJVb+e84OUfSMUWJX1wFGkASbgI7Ekyt/wBpEBBwk2t9+YgEpYhY4
	ySSx7cZhZoiOtYwSvXemglVxCuhKLJz5FWyssECgxNaNb8FsFgEViZnzzrB1MXJw8ApYSkw7
	WQAS5hUQlDg58wkLiM0soC3x9OZTOHvZwtdQlypI/Hy6jBXiCCeJ1h/XmCFqxCWO/uxhnsAo
	PAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC41ZLawfj
	nlUf9A4xMnEwHmKU4GBWEuGddys7VYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvt9e9KUIC6Ykl
	qdmpqQWpRTBZJg5OqQYmbUn5m61Tzq+ZdZ1ns/JkVe874odLrSZX9pZr1Zjsalxc4fn62laR
	gL93DioWKHSl/Sxs9Sq+v1xMTCw02WeakbNfw9vgGVMc3tf0rryWlWU+Jev5kXsXXjk/OlLx
	yGPVa3GuKRr7pXV6jnkUTPzFfN/zbzzzlU2bb2xgjSn70r4w+bSBzu0b9/32Vh54/0St4kT0
	notNMTcuRPlYrJff/H2+v7p4ZzPH8j08J/5z8RdL/dcV5eLjXRsWdG1e7/Edz7+07NW4IHZs
	pp+Y35z6FNHfS/865b70OmXPtvvEt8g1yqZq7ccMY5PmXEyYvkiJOaj+57VngqIyb46buykG
	NZf9Y9H49+pHup3WerXnSizFGYmGWsxFxYkAlsqWlUoDAAA=
X-CMS-MailID: 20231204084016epcas5p24e21f003c76b82ad8907fa182f150eb7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231130115055epcas5p4e29befa80877be45dbee308846edc0ba
References: <CGME20231130115055epcas5p4e29befa80877be45dbee308846edc0ba@epcas5p4.samsung.com>
	<20231130115044.53512-1-shradha.t@samsung.com>
	<20231130165514.GW3043@thinkpad>



> -----Original Message-----
> From: Manivannan Sadhasivam =5Bmailto:manivannan.sadhasivam=40linaro.org=
=5D
> Sent: 30 November 2023 22:25
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> bhelgaas=40google.com; jingoohan1=40gmail.com;
> gustavo.pimentel=40synopsys.com; josh=40joshtriplett.org;
> lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com;
> pankaj.dubey=40samsung.com; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org
> Subject: Re: =5BPATCH v2 0/3=5D Add support for RAS DES feature in PCIe D=
W
> controller
>=20
> On Thu, Nov 30, 2023 at 05:20:41PM +0530, Shradha Todi wrote:
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
> > eases the effort to understand and use the register information for
> debugging.
> >
> > v1 version was posted long back and for some reasons I couldn't work
> > on it. I apologize for the long break. I'm restarting this activity
> > and have taken care of all previous review comments shared.
> > v1:
> > https://lore.kernel.org/all/20210518174618.42089-1-shradha.t=40samsung.=
c
> > om/T/
> >
>=20
> There is already a series floating to add similar functionality via perf
> subsystem: https://lore.kernel.org/linux-pci/20231121013400.18367-1-
> xueshuai=40linux.alibaba.com/
>=20
> - Mani
>=20

Hi Mani,

The series proposed in perf includes only time based-analysis and event cou=
nters which will monitor performance (Group 6 and 7). The patch or framewor=
k that we have proposed includes debug information, error injection facilit=
y and error counters (Group 0 - 5) which are not included as part of the fu=
nctionality implemented via perf. In my opinion, these functionalities don'=
t count as performance monitoring or counters but rather as debug counters.=
 How about we take this up as a debugfs framework as proposed in my patch?=
=20
Or if others feel it can be taken via perf driver then I am happy to extend=
 the perf driver if authors do not have objection. Let me know what you thi=
nk of this? Meanwhile I will review the perf patches and share my feedback.

> > Shradha Todi (3):
> >   PCI: dwc: Add support for vendor specific capability search
> >   PCI: debugfs: Add support for RASDES framework in DWC
> >   PCI: dwc: Create debugfs files in DWC driver
> >
> >  drivers/pci/controller/dwc/Kconfig            =7C   8 +
> >  drivers/pci/controller/dwc/Makefile           =7C   1 +
> >  .../controller/dwc/pcie-designware-debugfs.c  =7C 476
> ++++++++++++++++++
> >  .../controller/dwc/pcie-designware-debugfs.h  =7C   0
> >  drivers/pci/controller/dwc/pcie-designware.c  =7C  20 +
> > drivers/pci/controller/dwc/pcie-designware.h  =7C  18 +
> >  6 files changed, 523 insertions(+)
> >  create mode 100644
> > drivers/pci/controller/dwc/pcie-designware-debugfs.c
> >  create mode 100644
> > drivers/pci/controller/dwc/pcie-designware-debugfs.h
> >
> > --
> > 2.17.1
> >
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D=0D=0A=0D=0A

