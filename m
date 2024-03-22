Return-Path: <linux-pci+bounces-4996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B810886C75
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 13:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ED31F22276
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91992446AB;
	Fri, 22 Mar 2024 12:58:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7F446A0;
	Fri, 22 Mar 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112305; cv=none; b=eV/S2cr2nOyw/Z1/Prlht7ig9u8a+RLxeo7HPADcyRircibMX7cNa+hXQ1OPHwnzuF06mYJJj1GVVgyVj/L+dsUpJEAI2OXgoxJ6+/ZahAkYuhrki1sYWONHfZwU4jLq5MuLd/93J2gATbw0UEkCxmqUnBV48CpDns8WMxMgRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112305; c=relaxed/simple;
	bh=R8CEgZzdkISYvI1frNeDpEPHLFmDlh3VCwkh/8paHe4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9JUQ/du9KLoKN7JmLpMKQzS/8CkL5VPrElkl8c4qKCmZwcRERpY6zOEOAoiJv/iwe7S2PDGq92+nJEnWtxSvzhJhNstZe85TrmWwUQurGSwBRleYL1kH/9vfUd21gVZZNe485pmBbqtQ9Q6suKY26m1UXt4ZkLkscyKlOf+WMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V1Mn01kzRz6K5sX;
	Fri, 22 Mar 2024 20:57:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 92353140A90;
	Fri, 22 Mar 2024 20:58:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 22 Mar
 2024 12:58:17 +0000
Date: Fri, 22 Mar 2024 12:58:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
CC: Shradha Todi <shradha.t@samsung.com>, <bp@alien8.de>,
	<tony.luck@intel.com>, <james.morse@arm.com>, <mchehab@kernel.org>,
	<rric@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<gustavo.pimentel@synopsys.com>, <josh@joshtriplett.org>,
	<lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
	<pankaj.dubey@samsung.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vidyas@nvidia.com>, <gost.dev@samsung.com>,
	<alim.akhtar@samsung.com>, <shiju.jose@huawei.com>, "Terry Bowman"
	<Terry.Bowman@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Message-ID: <20240322125817.0000791f@Huawei.com>
In-Reply-To: <20240322103935.GD3638@thinkpad>
References: <CGME20231130115055epcas5p4e29befa80877be45dbee308846edc0ba@epcas5p4.samsung.com>
	<20231130115044.53512-1-shradha.t@samsung.com>
	<20231130165514.GW3043@thinkpad>
	<000601da3e07$c39e5e00$4adb1a00$@samsung.com>
	<20240104055030.GA3031@thinkpad>
	<0df701da5ff0$df1165a0$9d3430e0$@samsung.com>
	<20240216134921.GH2559@thinkpad>
	<120d01da657e$66b9d3b0$342d7b10$@samsung.com>
	<20240319163315.GD3297@thinkpad>
	<20240320100144.0000056c@Huawei.com>
	<20240322103935.GD3638@thinkpad>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 22 Mar 2024 16:09:35 +0530
'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org> wrote:

> On Wed, Mar 20, 2024 at 10:01:44AM +0000, Jonathan Cameron wrote:
> > On Tue, 19 Mar 2024 22:03:15 +0530
> > 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org> wrote:
> >  =20
> > > On Thu, Feb 22, 2024 at 04:30:47PM +0530, Shradha Todi wrote: =20
> > > > + Borislav, Tony, James, Mauro, Robert
> > > >=20
> > > > Hi All,
> > > >=20
> > > > Synopsys DesignWare PCIe controllers have a vendor specific capabil=
ity (which
> > > > means that this set of registers are only present in DesignWare con=
trollers)
> > > > to perform debug operations called "RASDES".
> > > > The functionalities provided by this extended capability are:
> > > >=20
> > > > 1. Debug: This has some debug related diagnostic features like hold=
ing LTSSM
> > > > in certain states, reading the status of lane detection, checking i=
f any PCIe
> > > > lanes are broken (RX Valid) and so on. It's a debug only feature us=
ed for diagnostic
> > > > use-cases.
> > > >=20
> > > > 2. Error Injection: This is a way to inject certain errors in PCIe =
like LCRC, ECRC,
> > > > Bad TLPs and so on. Again, this is a debug feature and generally no=
t used in
> > > > functional use-case.
> > > >=20
> > > > 3. Statistical counters: This has 3 parts
> > > >  - Error counters
> > > >  - Non error counters (covered as part of perf [1])
> > > >  - Time based analysis counters (covered as part of perf [1])
> > > >=20
> > > > Selective features of  the above functionality has been implemented
> > > > by vendor specific PCIe controller drivers (pcie-tegra194.c) that u=
se
> > > > Synopsys DesignWare PCIe controllers.
> > > > In order to make it useful to all vendors using DWC controller, we =
had
> > > > proposed a common implementation in DWC PCIe controller directory
> > > > (drivers/pci/controller/dwc/) and our original idea was based on de=
bugfs
> > > > filesystem. v1 and v2 are mentioned in [2] and [3].
> > > >=20
> > > > We got a suggestion to implement this as part of EDAC framework [3]=
 and
> > > > we looked into the same. But as far as I understood, what I am tryi=
ng to
> > > > implement is a very specific feature (only valid for Synopsys DWC P=
CIe controllers). =20
> >=20
> > For error part there are (at least superficially) similar features in t=
he PCIe
> > standard that we've started thinking about how to support.
> >=20
> > See Flit Logging Extended capablity (7.7.8 in PCIe Base Spec rev6.
> > That has the benefit that they are part of the standard so we can
> > support them directly in portdrv / EP drivers using some library code i=
n the
> > PCI core.
> >  =20
>=20
> Sounds good. But v6 is a relatively new version and the DWC RAS predates =
that.
> So we still need to support it somehow (either in EDAC or in
> drivers/pci/controller/dwc).
>=20
> > There are other interconnect and PCI PMU drivers that log retries etc w=
hich are also basically error
> > counts. At least some of that is done through perf today.=20
> >  =20
>=20
> IMO all the RAS support should be exposed through EDAC, otherwise it defe=
ats the
> purpose of the subsystem.

Some RAS flows go nowhere near EDAC today.  Individual drivers poke out
the tracepoints and userspace tooling deals with it. One example is
CXL but there are plenty of others.

Perhaps that should not be the case, but there is definitely
precedence for ignoring edac when considering error flows.

Jonathan

>=20
> - Mani
>=20
> >  =20
> > > > This doesn't seem to fit in very well with the EDAC framework and w=
e can=20
> > > > hardly use any of the EDAC framework APIs. We tried implementing a
> > > > "pci_driver" but since a function driver will already be running on=
 the EP and
> > > > portdrv on the root-complex, we will not be able to bind 2 drivers =
to a single
> > > > PCI device (root-complex or endpoint). Ultimately, what I will be d=
oing is
> > > > writing a platform driver with debugfs entries which will be presen=
t in EDAC
> > > > directory instead of DWC directory. =20
> >=20
> > The addition of this type of functionality to pordrv is a long running =
question.
> > Everyone wants a solution, I believe some people are looking at it (+CC=
 Terry)
> >=20
> > Terry, another case for your long list.
> >=20
> > For the EP end, this should be fired up by the EP driver, whilst it mig=
ht be
> > infrastructure used on a bunch of devices,  it is a feature of that par=
ticular
> > EP - so you'd want to provide any functionality in a form that could be=
 used
> > by both the EP driver and a nice shiny new portdrv replacement.
> >  =20
> > > >=20
> > > > Can  you please help us out by going through this thread [3] and le=
tting us
> > > > know if our understanding is wrong at any point. If you think it is=
 a better
> > > > idea to integrate this in the EDAC framework, can you guide me as
> > > > to how I can utilize the framework better?
> > > > Please let me know if you need any other information to conclude.
> > > >=20
> > > > [1] https://lore.kernel.org/linux-pci/20231121013400.18367-1-xueshu=
ai@linux.alibaba.com/
> > > > [2] https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@sa=
msung.com/T/
> > > > [3] https://lore.kernel.org/all/20231130115044.53512-1-shradha.t@sa=
msung.com/
> > > >    =20
> > >=20
> > > Gentle ping for the EDAC maintainers.
> > >=20
> > > - Mani
> > >  =20
> > > > Thanks,
> > > > Shradha
> > > >    =20
> > > > > -----Original Message-----
> > > > > From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
> > > > > Sent: 16 February 2024 19:19
> > > > > To: Shradha Todi <shradha.t@samsung.com>
> > > > > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > > > bhelgaas@google.com; jingoohan1@gmail.com;
> > > > > gustavo.pimentel@synopsys.com; josh@joshtriplett.org;
> > > > > lukas.bulwahn@gmail.com; hongxing.zhu@nxp.com;
> > > > > pankaj.dubey@samsung.com; linux-kernel@vger.kernel.org; linux-
> > > > > pci@vger.kernel.org; vidyas@nvidia.com; gost.dev@samsung.com
> > > > > Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PC=
Ie DW
> > > > > controller
> > > > >=20
> > > > > On Thu, Feb 15, 2024 at 02:55:06PM +0530, Shradha Todi wrote:   =
=20
> > > > > >
> > > > > >   =20
> > > > >=20
> > > > > [...]
> > > > >    =20
> > > > > > > For the error injection and counters, we already have the EDAC
> > > > > > > framework. So adding them in the DWC driver doesn't make sens=
e to me.
> > > > > > >   =20
> > > > > >
> > > > > > Sorry for late response, was going through the EDAC framework t=
o understand   =20
> > > > > better how we can fit RAS DES support in it. Below are some techn=
ical challenges
> > > > > found so far:   =20
> > > > > > 1: This debugfs framework proposed [1] can run on both side of =
the link i.e. RC   =20
> > > > > and EP as it will be a part of the link controller platform drive=
r. Here for the EP
> > > > > side the assumption is that it has Linux running, which is primar=
ily a use case for
> > > > > chip-to-chip communication.  After your suggestion to migrate to =
EDAC
> > > > > framework we studied and here are the findings:   =20
> > > > > > - If we move to EDAC framework, we need to have RAS DES as a
> > > > > > pci_driver which will be binded based on vendor_id and device_i=
d. Our
> > > > > > observation is that on EP side system we are unable to bind two
> > > > > > function driver (pci_driver), as pci_endpoint_test function dri=
ver or
> > > > > > some other chip-to-chip function driver will already be bound. =
On the
> > > > > > other hand, on RC side we observed that if we have portdrv enab=
led in
> > > > > > Linux running on RC system, it gets bound to RC controller and =
then it
> > > > > > does not allow EDAC pci_driver to bind. So basically we see a p=
roblem
> > > > > > here, that we can't have two pci_driver binding to same PCI dev=
ice
> > > > > > 2: Another point is even though we use EDAC driver framework, w=
e may not be   =20
> > > > > able to use any of EDAC framework APIs as they are mostly suitabl=
e for memory
> > > > > controller devices sitting on PCI BUS. We will end up using debug=
fs entries just via
> > > > > a pci_driver placed inside EDAC framework.
> > > > >=20
> > > > > Please wrap your replies to 80 characters.
> > > > >=20
> > > > > There is no need to bind the edac driver to VID:PID of the device=
. The edac driver
> > > > > can be a platform driver and you can instantiate the platform dev=
ice from the
> > > > > DWC driver. This way, the PCI device can be assocaited with whate=
ver driver, but
> > > > > still there can be a separate edac driver for handling errors.
> > > > >=20
> > > > > Regarding API limitation, you should ask the maintainer about the=
 possibility of
> > > > > extending them.
> > > > >    =20
> > > > > >
> > > > > > Please let me know if my understanding is wrong.
> > > > > >   =20
> > > > > > > But first check with the perf driver author if they have any =
plans
> > > > > > > on adding the proposed functionality. If they do not have any=
 plan
> > > > > > > or not working on it, then look into EDAC.
> > > > > > >
> > > > > > > - Mani
> > > > > > >   =20
> > > > > >
> > > > > > Since we already worked and posted patches [1], [2], we will co=
ntinue to work   =20
> > > > > on this and based on consent from community we will adopt to most=
 suitable
> > > > > framework.   =20
> > > > > > We see many subsystems like ethernet, usb, gpu, cxl having debu=
gfs files that   =20
> > > > > give information about the current status of the running system a=
nd as of now
> > > > > based on our findings, we still feel there is no harm in having d=
ebugfs entry based
> > > > > support in DesignWare controller driver itself.
> > > > >=20
> > > > > There is no issue in exposing the debug information through debug=
fs, that's the
> > > > > sole purpose of the interface. But here, you are trying to add su=
pport for DWC
> > > > > RAS feature for which a dedicated framework already exists.
> > > > >=20
> > > > > And there will be more similar requests coming for vendor specifi=
c error protocols
> > > > > as well. So your investigation could benefit everyone.
> > > > >=20
> > > > > From your above investigation, looks like there are some shortcom=
ings of the
> > > > > EDAC framework. So let's get that clarified by writing to the EDA=
C maintainers
> > > > > (keep us in CC). If the EDAC maintainer suggests you to add suppo=
rt for this
> > > > > feature in DWC driver itself citing some reasons, then no issues =
with me.
> > > > >=20
> > > > > - Mani
> > > > >=20
> > > > > --
> > > > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=
=E0=AE=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=
=E0=AE=AE=E0=AF=8D   =20
> > > >=20
> > > >    =20
> > >  =20
> >  =20
>=20


