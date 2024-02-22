Return-Path: <linux-pci+bounces-3859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0BA85F66C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 12:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42692287B87
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30973FB17;
	Thu, 22 Feb 2024 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bPkTZJ1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4057F3E49E
	for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599772; cv=none; b=gYG4zNsYIb9JP7BJlwZNZQ/ZPlX4lrj71g7pQTka7mOeQ0HzcbcFmexcU17+olfOV08Zj3mFdjKDRCeka/Iai/iORxQk8780jFZyPGtIhhjwY79g+KOyBLexjdrLhijRz8zQMRClWK5Qkl+hbfIQSd4YUSJy+ZmzqIdnvt8b2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599772; c=relaxed/simple;
	bh=gVNODxT+fq8xEtd0ZpI9uufjY4ghRe6rz4gfD7pnSAQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=cJ+pUxVOHBJqvqDjnYKtZDDhMt5z4gDUmAa+dy/6yBUYhwRh2tp0OpykI4q4MC5C46tAXbkOC+XGIRuPP5qfEC8yHyNWDb4oePKoPfOgq8lWFfA83zGisGtKfOSP0EuqYp49/2VWfreXqNOG6hXKAyScMeuj5y0bpU4tsydyn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bPkTZJ1B; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240222110246epoutp029bc6e8c6fca34a3a9fa2bf5194c0eb9f~2Km9Rk5HX1193911939epoutp02i
	for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 11:02:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240222110246epoutp029bc6e8c6fca34a3a9fa2bf5194c0eb9f~2Km9Rk5HX1193911939epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708599766;
	bh=8PIOFhJsIIMWYPJyMowiCezKsT6vzjmiMmWx/wIf0DE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=bPkTZJ1BUKjP1PZ/v9PDX0JSRrr5gRE80VIjQLTEa92lqZn622VIKIx9mst9tBsaj
	 89UeAftbUEIg8nkTb1rP0e33POgxOKo+kV6x2XN6jL97oZrNIrFX/RBN6JV2Cziom7
	 SWcaPbc2MQqVyzqOnt5N2Nwm3q3PN4OpyGBcvfcE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240222110245epcas5p21be6d117cb540b0f8f5e6f22ddf9b631~2Km8eTBAS1220712207epcas5p2t;
	Thu, 22 Feb 2024 11:02:45 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TgVbl3X2nz4x9Px; Thu, 22 Feb
	2024 11:02:43 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.3D.10009.3D927D56; Thu, 22 Feb 2024 20:02:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240222110052epcas5p30249ded603442e6419507200ba072ddf~2KlTikoA42617126171epcas5p3-;
	Thu, 22 Feb 2024 11:00:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240222110052epsmtrp190ef866fac03b45f81659d76b6d414df~2KlThh8uy0673606736epsmtrp1R;
	Thu, 22 Feb 2024 11:00:52 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-b1-65d729d3b5c3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.88.07368.46927D56; Thu, 22 Feb 2024 20:00:52 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240222110049epsmtip2e311e4dffe3492c337bb8a7104a3bb85~2KlQZY8PA2687826878epsmtip2M;
	Thu, 22 Feb 2024 11:00:49 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
Cc: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<gustavo.pimentel@synopsys.com>, <josh@joshtriplett.org>,
	<lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
	<pankaj.dubey@samsung.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vidyas@nvidia.com>, <gost.dev@samsung.com>,
	<alim.akhtar@samsung.com>
In-Reply-To: <20240216134921.GH2559@thinkpad>
Subject: RE: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Date: Thu, 22 Feb 2024 16:30:47 +0530
Message-ID: <120d01da657e$66b9d3b0$342d7b10$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG/Q0WxGB9EWFeblm7N70OL8blxhQGR1/IBAmU4G1oB/2O7JgJFQ8VeAXfQWL0B/DJ/LbDu3RAw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTfd3t72xJLrgjxE3nlThLAUakr3UWBuWG2G5ymCYkbMsYaelcI
	pe3aAmMhgyCKNsA0yqMVSxmvjqe0vIeAbCgqTHmoUceAjREBQ3AQCVLnCi0b//3OOb/fd87v
	fDlshouW5c5OlGtolVwsIzAntO1nf7/AMf9HdJC1HZJThjaMrMxOIJev/YORj/s6EbJr4hyL
	1LddBeRkTw1CmlZ0LPKNUUFm5a0zybGuUowcNtzCyBxrDkrmDOSi5ETOeSZZbbYi5A+tKzZu
	dweLvFHbjJDP7/+Okg/buUfcqNUzBShVb6gHVKd+gkUZzSlURfccQj1ZCKPMtecx6reH3Rg1
	M16MUPmnFzGqebEDoQpaagHV0rsMqGWzl8j5VFJoAi2W0CofWh6vkCTKpWHEsai4iLhgYRA/
	kB9Cvkf4yMXJdBhx9BNR4EeJMptpwidVLEuxpURitZo4EB6qUqRoaJ8EhVoTRtBKiUwpUPLU
	4mR1ilzKk9OaQ/ygoIPBNuKXSQlND6oQ5dND3zzN78GyQOsBLeCwIS6Ak8MjmBY4sV3wnwAc
	Mq0i9uBvAI3DU0x78BLAs41WbEtS1vXCUbgO4PTMIMMePANw9pc/0A0Whr8DZ8atmwVXvA7A
	pYpeZKPAwHMZMNscrQVsNgcPhL/WSDbSu/AoWFyo3dSiuC/seT24SefiIdA8O4ja8U54WzeD
	2p/ZD6vLFxj2iXzg2l/VzA3sip+Clns3WHbObjiwlrc5A8QtHPi4t4ZpFxyFRQ1XUDveBedv
	tbDs2B3OfX/WgaXwR0uJo4EMvrRUInb8PuwbL0U35mfg/rCpy7FIT1h4p9Fh0Rnmr8846FzY
	YdjCb8OV192Otnug4eYY8wIg9Nus6bdZ02+zoP+/mxGgtWAPrVQnS2l1sPKgnE7778fjFclm
	sHkUAZEdYHpqidcPEDboB5DNIFy5aNo47cKViNO/pVWKOFWKjFb3g2Dbvi8y3N3iFbarkmvi
	+IKQIIFQKBSEvCvkE7u5C2euSlxwqVhDJ9G0klZt6RA2xz0LSRRYh3ZYvs70DX32QcaaTpHp
	t89V6+1hOckxtjL86mQvbvfF+l4/wcOMe+uXyt66HF0wFqTKqPQ65/X53akHMYtF7KGY0fhw
	6xJxIXJstOGzaycvJlqv1DZEReheedSvdf/5aUlAevb6iY+9E7DR4JIArii2LrqfmuOk8TpC
	vNqfEI/2+4yMNj6HBdXNNw+3RYsu3131PmZSDlOGNd5XTXs9OotSQyNFfBp4Xpp/NW3YsbPx
	SOyb9JjIcCfsnqjgPqf8zlKh54cD4VKC2uebdzrKVC8p/c45Y9CNaaqoOjyfHVmso/lCY8vs
	8Yiy8Yy4OVb56Ejm8apU06TuC5dcLYGqE8T8AIZKLf4X5iz8Np0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CLcRzHfZ/n2bNnnbmnFb44xXPnzGgZ3fnmV7hLj/MPLg7nqmmPftjW
	bOXX+VEaKdaF3NoilRSdX01lZaFcCadCSlPjjxYOuW5cjYQ1XP+9Pvf+8fn88aFwkYuYSiWo
	kzmtWq5kSB+i+gETGKSY08nNf1UYgN4WVJOo5Eg8ct0cIVHX/RoM1fYc5yNz9XmA3twtw9Dl
	ryY++lWYhFJP/uChF7XnSPS04CGJ9MN6AukbMwjUo8/koVLLMIaKq77+8dqsfFRfXoGhT20O
	AnXcFq6YyA4ezSbYqwVXAVtj7uGzhZYU9qLtA8baPy5jLeWZJNvdYSPZ3nYjxhrS+0m2ot+K
	sdmV5YCtvOcCrMsSsG7CVp+lCk6ZsJvTBi+P8Yl/1nmM0GQv3mttcvBSwWNpFhBQkA6BF2oH
	eFnAhxLRdwDsu2bFvcIU6Hp2HfOyH7wy8o7vNfUB+KGjG3gEkp4He9uHcY/gT1cAONB6BngG
	nDbi0H3C8bf3CQbP5rj/5ClKQAfBljKFJ+1Hr4dVFZ9HVxD0LHj3Z/MoC+lQaOlrJrzsCx+Z
	ekcZp+dCZ5fzP5cWffx76gzodpbyPOxPb4W3Wuv5Xs9k2Og+iecAP/OYKvOYKvOYKvOYSCEg
	ysEUTqNTxaliZRqZmtsj1clVuhR1nDQ2SWUBo38hEVuB48KItAFgFGgAkMIZfyGxp50TCRXy
	ffs5bVK0NkXJ6RrANIpgJgtlefkKER0nT+Z2cpyG0/5TMUowNRUramt+GRV4L4YXnj39faZa
	qc0YHyC+tSYtdIub2e5csbz2c7Q4MMgWPjOsbkgV5iu+Y3hvXFAlTq8zBBhVmG1jj70mzDGw
	2Xg0mI4XbJGMi325qO5yVIzQ1NKhPHXgxmu6zLQpDRua0ILyNn5LXKlfzeTmNphk0gi7da1k
	oFh17vThH/VZJbYYZ6LTIK/ZkWfZJijqrBuMKjuYbnBEzA4ZSk74cuXXz5A39sgnoaKLrmkH
	IroHE/px3/x25+ZV0xlDdPXgorRtjau+hy3Qrj60UByX03S2ZPyMEn14L2CoGxldyi/G55GL
	s+xL4K4NE4ObYndpJkn4+YmVl1r1s9sYQhcvl0lwrU7+G3pjpLaGAwAA
X-CMS-MailID: 20240222110052epcas5p30249ded603442e6419507200ba072ddf
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
	<000601da3e07$c39e5e00$4adb1a00$@samsung.com>
	<20240104055030.GA3031@thinkpad>
	<0df701da5ff0$df1165a0$9d3430e0$@samsung.com>
	<20240216134921.GH2559@thinkpad>

+ Borislav, Tony, James, Mauro, Robert

Hi All,

Synopsys DesignWare PCIe controllers have a vendor specific capability (whi=
ch
means that this set of registers are only present in DesignWare controllers=
)
to perform debug operations called =22RASDES=22.
The functionalities provided by this extended capability are:

1. Debug: This has some debug related diagnostic features like holding LTSS=
M
in certain states, reading the status of lane detection, checking if any PC=
Ie
lanes are broken (RX Valid) and so on. It's a debug only feature used for d=
iagnostic
use-cases.

2. Error Injection: This is a way to inject certain errors in PCIe like LCR=
C, ECRC,
Bad TLPs and so on. Again, this is a debug feature and generally not used i=
n
functional use-case.

3. Statistical counters: This has 3 parts
 - Error counters
 - Non error counters (covered as part of perf =5B1=5D)
 - Time based analysis counters (covered as part of perf =5B1=5D)

Selective features of  the above functionality has been implemented
by vendor specific PCIe controller drivers (pcie-tegra194.c) that use
Synopsys DesignWare PCIe controllers.
In order to make it useful to all vendors using DWC controller, we had
proposed a common implementation in DWC PCIe controller directory
(drivers/pci/controller/dwc/) and our original idea was based on debugfs
filesystem. v1 and v2 are mentioned in =5B2=5D and =5B3=5D.

We got a suggestion to implement this as part of EDAC framework =5B3=5D and
we looked into the same. But as far as I understood, what I am trying to
implement is a very specific feature (only valid for Synopsys DWC PCIe cont=
rollers).
This doesn't seem to fit in very well with the EDAC framework and we can=20
hardly use any of the EDAC framework APIs. We tried implementing a
=22pci_driver=22 but since a function driver will already be running on the=
 EP and
portdrv on the root-complex, we will not be able to bind 2 drivers to a sin=
gle
PCI device (root-complex or endpoint). Ultimately, what I will be doing is
writing a platform driver with debugfs entries which will be present in EDA=
C
directory instead of DWC directory.

Can  you please help us out by going through this thread =5B3=5D and lettin=
g us
know if our understanding is wrong at any point. If you think it is a bette=
r
idea to integrate this in the EDAC framework, can you guide me as
to how I can utilize the framework better?
Please let me know if you need any other information to conclude.

=5B1=5D https://lore.kernel.org/linux-pci/20231121013400.18367-1-xueshuai=
=40linux.alibaba.com/
=5B2=5D https://lore.kernel.org/all/20210518174618.42089-1-shradha.t=40sams=
ung.com/T/
=5B3=5D https://lore.kernel.org/all/20231130115044.53512-1-shradha.t=40sams=
ung.com/

Thanks,
Shradha

> -----Original Message-----
> From: 'Manivannan Sadhasivam' <manivannan.sadhasivam=40linaro.org>
> Sent: 16 February 2024 19:19
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> bhelgaas=40google.com; jingoohan1=40gmail.com;
> gustavo.pimentel=40synopsys.com; josh=40joshtriplett.org;
> lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com;
> pankaj.dubey=40samsung.com; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org; vidyas=40nvidia.com; gost.dev=40samsung.com
> Subject: Re: =5BPATCH v2 0/3=5D Add support for RAS DES feature in PCIe D=
W
> controller
>=20
> On Thu, Feb 15, 2024 at 02:55:06PM +0530, Shradha Todi wrote:
> >
> >
>=20
> =5B...=5D
>=20
> > > For the error injection and counters, we already have the EDAC
> > > framework. So adding them in the DWC driver doesn't make sense to me.
> > >
> >
> > Sorry for late response, was going through the EDAC framework to unders=
tand
> better how we can fit RAS DES support in it. Below are some technical cha=
llenges
> found so far:
> > 1: This debugfs framework proposed =5B1=5D can run on both side of the =
link i.e. RC
> and EP as it will be a part of the link controller platform driver. Here =
for the EP
> side the assumption is that it has Linux running, which is primarily a us=
e case for
> chip-to-chip communication.  After your suggestion to migrate to EDAC
> framework we studied and here are the findings:
> > - If we move to EDAC framework, we need to have RAS DES as a
> > pci_driver which will be binded based on vendor_id and device_id. Our
> > observation is that on EP side system we are unable to bind two
> > function driver (pci_driver), as pci_endpoint_test function driver or
> > some other chip-to-chip function driver will already be bound. On the
> > other hand, on RC side we observed that if we have portdrv enabled in
> > Linux running on RC system, it gets bound to RC controller and then it
> > does not allow EDAC pci_driver to bind. So basically we see a problem
> > here, that we can't have two pci_driver binding to same PCI device
> > 2: Another point is even though we use EDAC driver framework, we may no=
t be
> able to use any of EDAC framework APIs as they are mostly suitable for me=
mory
> controller devices sitting on PCI BUS. We will end up using debugfs entri=
es just via
> a pci_driver placed inside EDAC framework.
>=20
> Please wrap your replies to 80 characters.
>=20
> There is no need to bind the edac driver to VID:PID of the device. The ed=
ac driver
> can be a platform driver and you can instantiate the platform device from=
 the
> DWC driver. This way, the PCI device can be assocaited with whatever driv=
er, but
> still there can be a separate edac driver for handling errors.
>=20
> Regarding API limitation, you should ask the maintainer about the possibi=
lity of
> extending them.
>=20
> >
> > Please let me know if my understanding is wrong.
> >
> > > But first check with the perf driver author if they have any plans
> > > on adding the proposed functionality. If they do not have any plan
> > > or not working on it, then look into EDAC.
> > >
> > > - Mani
> > >
> >
> > Since we already worked and posted patches =5B1=5D, =5B2=5D, we will co=
ntinue to work
> on this and based on consent from community we will adopt to most suitabl=
e
> framework.
> > We see many subsystems like ethernet, usb, gpu, cxl having debugfs file=
s that
> give information about the current status of the running system and as of=
 now
> based on our findings, we still feel there is no harm in having debugfs e=
ntry based
> support in DesignWare controller driver itself.
>=20
> There is no issue in exposing the debug information through debugfs, that=
's the
> sole purpose of the interface. But here, you are trying to add support fo=
r DWC
> RAS feature for which a dedicated framework already exists.
>=20
> And there will be more similar requests coming for vendor specific error =
protocols
> as well. So your investigation could benefit everyone.
>=20
> From your above investigation, looks like there are some shortcomings of =
the
> EDAC framework. So let's get that clarified by writing to the EDAC mainta=
iners
> (keep us in CC). If the EDAC maintainer suggests you to add support for t=
his
> feature in DWC driver itself citing some reasons, then no issues with me.
>=20
> - Mani
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D=0D=0A=0D=0A

