Return-Path: <linux-pci+bounces-4991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0169D886B60
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 12:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C95E1F228A9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6133F8D0;
	Fri, 22 Mar 2024 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jva2DrDM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DD81CAA3
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107447; cv=none; b=rZXhelr+TnLtgMQAATxcBDATR8D0rfvOQySXBOBASKDO6EnzzE7PgLfA7vL/1/Ps+e2Tvxdb4OjhH+LevsxuxUOB6pkoMS8eoWKTv1yY2694ywMAKWNTo4AiAXIe5tOXPBXGebuxpaS8dPk/c+U1OcCLUjTE4oZ0sGCIqqDEJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107447; c=relaxed/simple;
	bh=TimyXEnSMCMupMVrXo/0kXThu421K8Ag8jSJ5Wm6oiI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=XJ2LT5Uw5ioCm+aru8WPsqDTFywl6pYy5cFd51p1p+ly/lmve8X/+2xFx34+OyAEmaIv9ycGPBJGh8gw2xTYJN7CpitNYPG3iZEZn2neNhGFk2M/ogAkgKLX5ijCjUGY0Kc4s+8Y+v+FoXkIDA/eUibS4tw4OK3W+CTsiJr/qqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jva2DrDM; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240322113716epoutp03f929aae8d19a6e2db6b11fd4333cd575~-EyXklxK-1634716347epoutp03Q
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 11:37:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240322113716epoutp03f929aae8d19a6e2db6b11fd4333cd575~-EyXklxK-1634716347epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711107436;
	bh=BOmetlTwaNKvKFKIwahvFByB4VTueYCmBSAEBsP4hfg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=jva2DrDMTl4lascGE1aYTh0nl5Mazwe7LSXiOUrWnp/+ipGrQ+ZM9jqU9ay0WhACf
	 XLbXftMOLRpefHdLTrUT6tFaGtJvZeLngfU9tq5+bWjUim97dizFYjezS/FYIfzW+b
	 9R2YC8Ac8SkSwm4q2dNdcNmY7TiQDgRFH/xQrhHY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240322113716epcas5p3820487949e0305da87345b43702074b0~-EyW3nfGT1001910019epcas5p3l;
	Fri, 22 Mar 2024 11:37:16 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4V1L0B291Bz4x9Q1; Fri, 22 Mar
	2024 11:37:14 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.C9.08600.A6D6DF56; Fri, 22 Mar 2024 20:37:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240322112129epcas5p1b94af4317c52764b4129598734786fa0~-EklN6Ppc0150001500epcas5p1f;
	Fri, 22 Mar 2024 11:21:29 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240322112129epsmtrp290e630b497127149d59220e98053708f~-EklM3o_u1200512005epsmtrp2u;
	Fri, 22 Mar 2024 11:21:29 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-90-65fd6d6a9f98
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.77.19234.9B96DF56; Fri, 22 Mar 2024 20:21:29 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240322112124epsmtip289e536244f68a967d0e4f3dc5ac1b555~-EkgxMauO1632316323epsmtip2T;
	Fri, 22 Mar 2024 11:21:24 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>, "'Jonathan
 Cameron'" <Jonathan.Cameron@Huawei.com>
Cc: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
	<jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
	<josh@joshtriplett.org>, <lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
	<pankaj.dubey@samsung.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vidyas@nvidia.com>, <gost.dev@samsung.com>,
	<alim.akhtar@samsung.com>, <shiju.jose@huawei.com>, "'Terry	Bowman'"
	<Terry.Bowman@amd.com>
In-Reply-To: <20240322103935.GD3638@thinkpad>
Subject: RE: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Date: Fri, 22 Mar 2024 16:51:16 +0530
Message-ID: <14ef01da7c4b$15dbaac0$41930040$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG/Q0WxGB9EWFeblm7N70OL8blxhQGR1/IBAmU4G1oB/2O7JgJFQ8VeAXfQWL0B/DJ/LQGGIYRVASmme0ECIZ7L6wMFIzwCsN3dMoA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc25vby/Mmstj45QMYXWoKI+WRz0obCwguwluIyNxRFyw0LuW
	UdraFjfdsnVYJgg4JDpHB4jCcFbixmOsQFEEBIE5EYGpyHARBwx5hKLT8Fqh4Pjv8zvn+z3f
	3++cHJLlWMpxJZMUWkatEMv5hD1e0+y12efjlHlGUDVCogdFNQQqTZMhy88LBLrbWIuhuoEM
	DjLUFAI0ePk8hn6cyecg49k+Ai0WK5Eue5aNbtcVEOhGURuB9HN6HOmvHcXRgD6Tjcoq5zB0
	7pcZDlo0mzjoqrECQ5aeZoD6r99ko8ddf+Ko71duGKT/TT+O0+nd8wRdXlQO6FrDAIcurkyl
	9S3jbLrEPIrR98ZC6UpjJkHf7zMT9FDPaYzOOTJB0BUTJow+Xm0EdPUVC6AtlRuiqb3JITJG
	LGHUHowiUSlJUkhD+VEx8eHxQSKB0EcYjLbzPRTiFCaUH7E72icySW69Db7HQbE81boULdZo
	+H5vhKiVqVrGQ6bUaEP5jEoiVwWqfDXiFE2qQuqrYLQ7hAKBf5BVuD9ZVj5yD6hGEj7Na5vG
	dSDrnWPAjoRUIBzNKiaOAXvSkaoH8JmxmWUrpgEsrOjAXxT9phFi1XLmUTfbtlELYF7+1yuW
	EQArfhjGllQE5Q2HeuZYS+xMHYQnpseWHSyqGofGvzOXRXaUD+x83AmW2ImKgadPHcOXGKc8
	4URFDXuJuVQwTKsz4DZ2gO35Q8vMorbBsrNjLFtLHvD5ozL2alhZbith07jAa8+zl7uDVLcd
	zMmawm2GCFg/McmxsRP8p616hV2hZaJhZU4pvFD13UqAHD6tKsVs/CZs7CmwnkNaA7zgT3V+
	tmU3eKrjEmbLXQ9zZodW5FxoKlrljXBm3rzSAg8Wtd5m5wK+Yc1ohjWjGdaMYPg/rRjgRsBj
	VJoUKZMYpBIqmE9ePHmiMqUSLH+XrREmcOfMgm8TwEjQBCDJ4jtzTYtzjCNXIj50mFEr49Wp
	ckbTBIKs932C5fpyotL63xTaeGFgsCBQJBIFBgeIhHwX7lh6ocSRkoq1TDLDqBj1qg8j7Vx1
	WFzvFpeWScGzDH9eFLffpV59ZPj3rzxfDw7xz3MgdUzklNq+/9xvfe2dzt4L4vURm9wkGbNd
	U9+/794hGj+6u9e0LnfTnouFrTzuF5ZdpNNge1jD/sGnMbmvhDkcOHl4Q/HFtsgHV2v3frBN
	27hzXdc+bAt9F3iHy266X8rX/eE3/BEde3I6zi38iTSntiHroT5gu2PB8FiUZ1p2Z26advPo
	h2/Ftbz3mTbp0MYv75u/HcK68ZKQHeaHvgP+vCfXr7yrfqlTP6t7jYC9zqa/drWp9MzOb0q4
	dbegl5IcZd+Q7PG8FZYQe8f/cuKrOnf1eEKPKKBJNJUBRy8UvB3L+3zy/L4DfFwjEwu3stQa
	8X+/vgbotwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZdlhJXndn5t9Ug+bnwhYP5m1js1jSlGHx
	ecM/NoubB3YyWey628FuMWvbXEaL+/uWM1ms+DKT3WLVwmtsFv8X5Fs09Pxmtbi8aw6bxdl5
	x9ksWv60sFi0HG1nsbjb0slqsWzTHyaLRVu/sFv837OD3eLgqo1MFp+vHGa0uH3iPKvFmwv3
	WCyubed1kPD43trH4tF66S+bx5p5axg9ds66y+6xYFOpR8uRt6wei/e8ZPK49drWY9OqTjaP
	O9f2sHk8uTKdyaO3+R2bx8Z3O5g8+rasYvTYsv8zo8fnTXIBAlFcNimpOZllqUX6dglcGdOn
	L2Uu2JVY0XD4AGsD4wLvLkZODgkBE4n5Ty+xdjFycQgJbGeU2L3hCDNEQlLi88V1TBC2sMTK
	f8/ZIYqeMUqcn7SUESTBJqAj8eTKH7AGEYEyiWvHt7OAFDELnGOROPigAWrsA2aJC9f2gnVw
	CuhKnH5zGswWFgiU2LrxLdgKFgFViXcbt7GC2LwClhJNu2axQNiCEidnPgGzmQW0JXoftjLC
	2MsWvoY6VUHi59NlrDBXLJtwjA2iRlzi6M8e5gmMwrOQjJqFZNQsJKNmIWlZwMiyilE0taA4
	Nz03ucBQrzgxt7g0L10vOT93EyM4sWgF7WBctv6v3iFGJg7GQ4wSHMxKIrw7/v9JFeJNSays
	Si3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamAy2n21KeHhGuHHx0Iu
	+Nt23lb137115Yerb29Pt/Ir2fKpuWW2duzGU/4if3pDj6UHP09f0Rt1YsN/63dv3t49Z7VQ
	3eLDfqdZHzmMrCfEc8a8m/j9vfRduW+hlaxX+Z7MMQs8uefEhqePndf7NR07N7O0y/nMK+/v
	V5jbjRO2tthxaUw+tOnkU4PHk15Fpc3+Y2ulLcTssMntmCjnavZjJ/r0al1KZ/ZE5b7esHez
	0frg10sn/g7WZZ/hbzf16b+keg/rwu/31V6+uDHv4+pPzqXb2Xmdktq3X56Uf65c4d/3x3yf
	edx+eaZEtVS3uJ7y0pATVF77bt/dAw8m7FeruhqYcdSVhfvMsUjehezPqpRYijMSDbWYi4oT
	AYWR5+SbAwAA
X-CMS-MailID: 20240322112129epcas5p1b94af4317c52764b4129598734786fa0
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
	<120d01da657e$66b9d3b0$342d7b10$@samsung.com>
	<20240319163315.GD3297@thinkpad> <20240320100144.0000056c@Huawei.com>
	<20240322103935.GD3638@thinkpad>



> -----Original Message-----
> From: 'Manivannan Sadhasivam' <manivannan.sadhasivam=40linaro.org>
> Sent: 22 March 2024 16:10
> To: Jonathan Cameron <Jonathan.Cameron=40Huawei.com>
> Cc: Shradha Todi <shradha.t=40samsung.com>; bp=40alien8.de;
> tony.luck=40intel.com; james.morse=40arm.com; mchehab=40kernel.org;
> rric=40kernel.org; lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel=
.org;
> bhelgaas=40google.com; jingoohan1=40gmail.com;
> gustavo.pimentel=40synopsys.com; josh=40joshtriplett.org;
> lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com;
> pankaj.dubey=40samsung.com; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org; vidyas=40nvidia.com; gost.dev=40samsung.com;
> alim.akhtar=40samsung.com; shiju.jose=40huawei.com; Terry Bowman
> <Terry.Bowman=40amd.com>
> Subject: Re: =5BPATCH v2 0/3=5D Add support for RAS DES feature in PCIe D=
W
> controller
>=20
> On Wed, Mar 20, 2024 at 10:01:44AM +0000, Jonathan Cameron wrote:
> > On Tue, 19 Mar 2024 22:03:15 +0530
> > 'Manivannan Sadhasivam' <manivannan.sadhasivam=40linaro.org> wrote:
> >
> > > On Thu, Feb 22, 2024 at 04:30:47PM +0530, Shradha Todi wrote:
> > > > + Borislav, Tony, James, Mauro, Robert
> > > >
> > > > Hi All,
> > > >
> > > > Synopsys DesignWare PCIe controllers have a vendor specific
> > > > capability (which means that this set of registers are only
> > > > present in DesignWare controllers) to perform debug operations call=
ed
> =22RASDES=22.
> > > > The functionalities provided by this extended capability are:
> > > >
> > > > 1. Debug: This has some debug related diagnostic features like
> > > > holding LTSSM in certain states, reading the status of lane
> > > > detection, checking if any PCIe lanes are broken (RX Valid) and so
> > > > on. It's a debug only feature used for diagnostic use-cases.
> > > >
> > > > 2. Error Injection: This is a way to inject certain errors in PCIe
> > > > like LCRC, ECRC, Bad TLPs and so on. Again, this is a debug
> > > > feature and generally not used in functional use-case.
> > > >
> > > > 3. Statistical counters: This has 3 parts
> > > >  - Error counters
> > > >  - Non error counters (covered as part of perf =5B1=5D)
> > > >  - Time based analysis counters (covered as part of perf =5B1=5D)
> > > >
> > > > Selective features of  the above functionality has been
> > > > implemented by vendor specific PCIe controller drivers
> > > > (pcie-tegra194.c) that use Synopsys DesignWare PCIe controllers.
> > > > In order to make it useful to all vendors using DWC controller, we
> > > > had proposed a common implementation in DWC PCIe controller
> > > > directory
> > > > (drivers/pci/controller/dwc/) and our original idea was based on
> > > > debugfs filesystem. v1 and v2 are mentioned in =5B2=5D and =5B3=5D.
> > > >
> > > > We got a suggestion to implement this as part of EDAC framework
> > > > =5B3=5D and we looked into the same. But as far as I understood, wh=
at
> > > > I am trying to implement is a very specific feature (only valid for=
 Synopsys
> DWC PCIe controllers).
> >
> > For error part there are (at least superficially) similar features in
> > the PCIe standard that we've started thinking about how to support.
> >
> > See Flit Logging Extended capablity (7.7.8 in PCIe Base Spec rev6.
> > That has the benefit that they are part of the standard so we can
> > support them directly in portdrv / EP drivers using some library code
> > in the PCI core.
> >
>=20
> Sounds good. But v6 is a relatively new version and the DWC RAS predates =
that.
> So we still need to support it somehow (either in EDAC or in
> drivers/pci/controller/dwc).
>=20

For all PCIe spec standard errors (All of those mentioned in 6.2 in PCIe Ba=
se Spec rev6 like AER,
FLIT logging, DPC, SR-IOV Baseline Error Handling), extending the EDAC / po=
rtdrv / EP drivers
seems like the best way. But this particular RAS-DES functionality exists o=
nly for Synopsys
DesignWare controller, hence I feel the *DWC controller driver* should exte=
nd this as it is a
controller specific feature. What would you suggest?
Unless there a plan to support vendor specific implementations through EDAC=
 or
portdrv callbacks? Because writing a new pci driver would cause 2 driver bi=
nding problem.

> > There are other interconnect and PCI PMU drivers that log retries etc
> > which are also basically error counts. At least some of that is done th=
rough perf
> today.
> >
>=20
> IMO all the RAS support should be exposed through EDAC, otherwise it defe=
ats
> the purpose of the subsystem.
>=20
> - Mani
>=20

Yes, I see that lot of non-error based counters like memory packet tx/rx re=
ceived,
nak dllp received, etc is done as a part of perf today. But I believe, the =
functionality I want to
implement has features like error injection which would not be suitable to =
be a part of perf.

> >
> > > > This doesn't seem to fit in very well with the EDAC framework and
> > > > we can hardly use any of the EDAC framework APIs. We tried
> > > > implementing a =22pci_driver=22 but since a function driver will
> > > > already be running on the EP and portdrv on the root-complex, we
> > > > will not be able to bind 2 drivers to a single PCI device
> > > > (root-complex or endpoint). Ultimately, what I will be doing is
> > > > writing a platform driver with debugfs entries which will be presen=
t in EDAC
> directory instead of DWC directory.
> >
> > The addition of this type of functionality to pordrv is a long running =
question.
> > Everyone wants a solution, I believe some people are looking at it
> > (+CC Terry)
> >
> > Terry, another case for your long list.
> >
> > For the EP end, this should be fired up by the EP driver, whilst it
> > might be infrastructure used on a bunch of devices,  it is a feature
> > of that particular EP - so you'd want to provide any functionality in
> > a form that could be used by both the EP driver and a nice shiny new po=
rtdrv
> replacement.
> >
> > > >
> > > > Can  you please help us out by going through this thread =5B3=5D an=
d
> > > > letting us know if our understanding is wrong at any point. If you
> > > > think it is a better idea to integrate this in the EDAC framework,
> > > > can you guide me as to how I can utilize the framework better?
> > > > Please let me know if you need any other information to conclude.
> > > >
> > > > =5B1=5D
> > > > https://lore.kernel.org/linux-pci/20231121013400.18367-1-xueshuai=
=40
> > > > linux.alibaba.com/ =5B2=5D
> > > > https://lore.kernel.org/all/20210518174618.42089-1-shradha.t=40sams=
u
> > > > ng.com/T/ =5B3=5D
> > > > https://lore.kernel.org/all/20231130115044.53512-1-shradha.t=40sams=
u
> > > > ng.com/
> > > >
> > >
> > > Gentle ping for the EDAC maintainers.
> > >
> > > - Mani
> > >
> > > > Thanks,
> > > > Shradha
> > > >
> > > > > -----Original Message-----
> > > > > From: 'Manivannan Sadhasivam' <manivannan.sadhasivam=40linaro.org=
>
> > > > > Sent: 16 February 2024 19:19
> > > > > To: Shradha Todi <shradha.t=40samsung.com>
> > > > > Cc: lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> > > > > bhelgaas=40google.com; jingoohan1=40gmail.com;
> > > > > gustavo.pimentel=40synopsys.com; josh=40joshtriplett.org;
> > > > > lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com;
> > > > > pankaj.dubey=40samsung.com; linux-kernel=40vger.kernel.org; linux=
-
> > > > > pci=40vger.kernel.org; vidyas=40nvidia.com; gost.dev=40samsung.co=
m
> > > > > Subject: Re: =5BPATCH v2 0/3=5D Add support for RAS DES feature i=
n
> > > > > PCIe DW controller
> > > > >
> > > > > On Thu, Feb 15, 2024 at 02:55:06PM +0530, Shradha Todi wrote:
> > > > > >
> > > > > >
> > > > >
> > > > > =5B...=5D
> > > > >
> > > > > > > For the error injection and counters, we already have the
> > > > > > > EDAC framework. So adding them in the DWC driver doesn't make
> sense to me.
> > > > > > >
> > > > > >
> > > > > > Sorry for late response, was going through the EDAC framework
> > > > > > to understand
> > > > > better how we can fit RAS DES support in it. Below are some
> > > > > technical challenges found so far:
> > > > > > 1: This debugfs framework proposed =5B1=5D can run on both side=
 of
> > > > > > the link i.e. RC
> > > > > and EP as it will be a part of the link controller platform
> > > > > driver. Here for the EP side the assumption is that it has Linux
> > > > > running, which is primarily a use case for chip-to-chip
> > > > > communication.  After your suggestion to migrate to EDAC framewor=
k we
> studied and here are the findings:
> > > > > > - If we move to EDAC framework, we need to have RAS DES as a
> > > > > > pci_driver which will be binded based on vendor_id and
> > > > > > device_id. Our observation is that on EP side system we are
> > > > > > unable to bind two function driver (pci_driver), as
> > > > > > pci_endpoint_test function driver or some other chip-to-chip
> > > > > > function driver will already be bound. On the other hand, on
> > > > > > RC side we observed that if we have portdrv enabled in Linux
> > > > > > running on RC system, it gets bound to RC controller and then
> > > > > > it does not allow EDAC pci_driver to bind. So basically we see
> > > > > > a problem here, that we can't have two pci_driver binding to
> > > > > > same PCI device
> > > > > > 2: Another point is even though we use EDAC driver framework,
> > > > > > we may not be
> > > > > able to use any of EDAC framework APIs as they are mostly
> > > > > suitable for memory controller devices sitting on PCI BUS. We
> > > > > will end up using debugfs entries just via a pci_driver placed in=
side EDAC
> framework.
> > > > >
> > > > > Please wrap your replies to 80 characters.
> > > > >
> > > > > There is no need to bind the edac driver to VID:PID of the
> > > > > device. The edac driver can be a platform driver and you can
> > > > > instantiate the platform device from the DWC driver. This way,
> > > > > the PCI device can be assocaited with whatever driver, but still =
there can
> be a separate edac driver for handling errors.
> > > > >
> > > > > Regarding API limitation, you should ask the maintainer about
> > > > > the possibility of extending them.
> > > > >
> > > > > >
> > > > > > Please let me know if my understanding is wrong.
> > > > > >
> > > > > > > But first check with the perf driver author if they have any
> > > > > > > plans on adding the proposed functionality. If they do not
> > > > > > > have any plan or not working on it, then look into EDAC.
> > > > > > >
> > > > > > > - Mani
> > > > > > >
> > > > > >
> > > > > > Since we already worked and posted patches =5B1=5D, =5B2=5D, we=
 will
> > > > > > continue to work
> > > > > on this and based on consent from community we will adopt to
> > > > > most suitable framework.
> > > > > > We see many subsystems like ethernet, usb, gpu, cxl having
> > > > > > debugfs files that
> > > > > give information about the current status of the running system
> > > > > and as of now based on our findings, we still feel there is no
> > > > > harm in having debugfs entry based support in DesignWare controll=
er
> driver itself.
> > > > >
> > > > > There is no issue in exposing the debug information through
> > > > > debugfs, that's the sole purpose of the interface. But here, you
> > > > > are trying to add support for DWC RAS feature for which a dedicat=
ed
> framework already exists.
> > > > >
> > > > > And there will be more similar requests coming for vendor
> > > > > specific error protocols as well. So your investigation could ben=
efit
> everyone.
> > > > >
> > > > > From your above investigation, looks like there are some
> > > > > shortcomings of the EDAC framework. So let's get that clarified
> > > > > by writing to the EDAC maintainers (keep us in CC). If the EDAC
> > > > > maintainer suggests you to add support for this feature in DWC dr=
iver
> itself citing some reasons, then no issues with me.
> > > > >
> > > > > - Mani
> > > > >
> > > > > --
> > > > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=
=E0=AE=A9=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=
=E0=AE=AE=E0=AF=8D=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=0D=
=0A>=20>=0D=0A>=20=0D=0A>=20--=0D=0A>=20=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=
=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=
=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=AF=8D=0D=0A=0D=0A

