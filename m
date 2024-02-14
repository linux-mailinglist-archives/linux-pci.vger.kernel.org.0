Return-Path: <linux-pci+bounces-3458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A461854F75
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 18:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37472B22CD8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420D35DF0D;
	Wed, 14 Feb 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aGmdNHw2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6460864;
	Wed, 14 Feb 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930261; cv=none; b=RE+sdtV7InIJK4E7Nu1m2WkOgRavC5EAcB3CicKj5p5FybXrtHoulOfJXM9wMBV0GfO4jQ4CK5iC77cIHyn0/BvdfJIid1TMksfe3Bzgx/Fb8aWHk2CyBHFz0Ytks6fQwzD1bWoMIv1zGSwXy8WtkzLFCLIFfGNrkSTf4r/E+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930261; c=relaxed/simple;
	bh=1cXJYhjHiLin0wIW2fMe06uKIO+gJp9378M26epkUjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=BNjJ6NSWspP77+TaGzunImirUUkyeMTA6TuLdBARP/EUO2I4DhCfZDwjEhzxSFIX8nhManG02QeeRzbEs9iPF24a390ftAs/34GfiEptmopM0imNqMQWoVesFf/KP1H9E5ZQCvdqJfyPe9a0TUSWAWqnH4Q/mJoeEs+X814yPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aGmdNHw2; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240214170410usoutp01769c6e25ffd864139ad722c70a48a050~zyYOOvomP0041900419usoutp01j;
	Wed, 14 Feb 2024 17:04:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240214170410usoutp01769c6e25ffd864139ad722c70a48a050~zyYOOvomP0041900419usoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707930250;
	bh=YtoIcxIjVpT8BnnPLrnzK0hvALjZLW8dvHfgRts0Qjc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=aGmdNHw2hbdocL2bf2YtZmO1dkVtSOXnbbXPpmr3iPQ8mcf0RQhG6ZU91FsTY8GIo
	 uVLv3FSvzgozq2sKt1rcZ5hRB68qhwhF5l01k8L8a2MiAHWEvGDRZu6JNa1ODrq3Ph
	 +udkPA0HtpyX8muWrgOMyyL3HVVRPDO6hbVfGm4c=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240214170410uscas1p2f00f19d678ad15d7d0ad77fcc337d6c0~zyYN2ognw1117011170uscas1p2R;
	Wed, 14 Feb 2024 17:04:10 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id F4.62.09678.A82FCC56; Wed,
	14 Feb 2024 12:04:10 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240214170409uscas1p1e04d5916cb91670ea7f6413f0347d9ca~zyYNiK1Oa1217212172uscas1p1v;
	Wed, 14 Feb 2024 17:04:09 +0000 (GMT)
X-AuditID: cbfec36d-acdff700000025ce-ce-65ccf28a4046
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id F7.3F.50167.982FCC56; Wed,
	14 Feb 2024 12:04:09 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 14 Feb 2024 09:04:08 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	14 Feb 2024 09:04:08 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Leon Romanovsky <leonro@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>, =?iso-8859-1?Q?Pierre_Cr=E9gut?=
	<pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert
 "PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes"
Thread-Topic: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Thread-Index: AQHaW7MAtwi2xwjfZkaUZDAOVEJQA7EDbuYAgAHuDQCAAlV9AIAAuocAgACNHQCAAB2nAIAAIYAAgADA4wCAAKQ8gA==
Date: Wed, 14 Feb 2024 17:04:08 +0000
Message-ID: <Zczyhya/+454IaQM@ubuntu>
In-Reply-To: <20240214071618.GE52640@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <29CAD9892A45E6448C9198E23903385E@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djX87pdn86kGjy6wGbx7X8Pm8WSpgyL
	V2fWsllc+beH0WLThicsFpd3zWGzODvvOJvF+q/v2SzaV15hdeD0WLCp1GPTqk42j3knAz16
	m9+xebQ8O8nm8X7fVTaPz5vkAtijuGxSUnMyy1KL9O0SuDI6fp9kLNglUbH2XSN7A+Ns4S5G
	Tg4JAROJNU3LGLsYuTiEBFYySrzbcpINwmllkri38RsjTNXsvomsEIk1jBK7pvQwQzifGCV6
	1n1hgXCWMUocn3CcFaSFTUBT4teVNUwgtoiAusSHVRfB2pkFljNLtMz7CpYQFkiV+NS/HKoo
	TeLa6UuMEHaWxLcl68HiLAKqEnNWn2cGsXmB7Hn/28BsTgEdiakTz4PVMAqISXw/BbGMWUBc
	4taT+UwQdwtKLJq9hxnCFpP4t+shG4StKHH/+0t2iHo9iRtTp7BB2HYSzY+nQc3Rlli28DXU
	XkGJkzOfsED0SkocXHED7GMJgRccEhPXLYAGkovErndfoWxpiavXp0ItzpZYub4DaCgHkF0g
	0XAkCCJsLbHwz3qmCYwqs5CcPQvJSbOQnDQLyUmzkJy0gJF1FaN4aXFxbnpqsWFearlecWJu
	cWleul5yfu4mRmASO/3vcO4Oxh23PuodYmTiYDzEKMHBrCTCO6n3TKoQb0piZVVqUX58UWlO
	avEhRmkOFiVxXkPbk8lCAumJJanZqakFqUUwWSYOTqkGprYsT1v9WB222Z3POl+Z+fupbXHI
	nLCub/tWiRcrLU+//tf6KqKk++RhhYQdqbvM5lce/ZEdJ5yUURgqJ7O2OmDuZr+QoqJL11SP
	rMjfvbFhstPcm013Fp652vV3H3N9U+fvDfwnFs2uT/3poNKSrJ7xXXFVx7cc+ScdbaKHJzNX
	Zh0t//NkXnVQIy9rf/+Uzo7d7XzJOVWfjh1+cEw7ZtYauZ8My39alUhGeTUuKjmfY2e04Wd1
	rL7Z7V1Tst9YH/PWtZaft4N55k2hzs+N5bIbwt36fVXNPj7WiU3UuOv+N89FVlbxd42T2/pF
	bp95dylMsjo0i/eyeaCBVkdx+vqgXB3GiXEFLb7dUzyUWIozEg21mIuKEwFFvK2A0QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWS2cDsrNv56UyqwczvWhbf/vewWSxpyrB4
	dWYtm8WVf3sYLTZteMJicXnXHDaLs/OOs1ms//qezaJ95RVWB06PBZtKPTat6mTzmHcy0KO3
	+R2bR8uzk2we7/ddZfP4vEkugD2KyyYlNSezLLVI3y6BK6Pj90nGgl0SFWvfNbI3MM4W7mLk
	5JAQMJGY3TeRtYuRi0NIYBWjxLPza5khnE+MEmcO7GeHcJYxSnx8cpcJpIVNQFPi15U1YLaI
	gLrEh1UXwdqZBZYzS7TM+wqWEBZIleh5toMFoihN4trpS4wQdpbEtyXrwWpYBFQl5qw+zwxi
	8wLZ8/63gdlCAoUS3650soHYnAI6ElMnngerZxQQk/h+CmIxs4C4xK0n85kgfhCQWLIHYo6E
	gKjEy8f/WCFsRYn731+yQ9TrSdyYOoUNwraTaH48DWqOtsSyha+hbhCUODnzCQtEr6TEwRU3
	WCYwSsxCsm4WklGzkIyahWTULCSjFjCyrmIULy0uzk2vKDbMSy3XK07MLS7NS9dLzs/dxAhM
	AKf/HY7cwXj01ke9Q4xMHIyHGCU4mJVEeCf1nkkV4k1JrKxKLcqPLyrNSS0+xCjNwaIkznv3
	gUaqkEB6YklqdmpqQWoRTJaJg1OqgYnbbYsC30zz4N7okiXvjV6IX7ubpyxpyya8qcZ80Xtu
	kfTHdzgMHS0d3359f6vIabvSu0MnDjYfnvaVfaL53wvvLn2YKB5W/+6I/5WsX9xJx7+/cLt1
	wP5nXDTH3LJVcie/8ondu51/M3Gmjvpv28Jd6v9W7D6943bO8loT3eVpWZtnt6VV7lXwcIrR
	MXtfdZzVRSjwpVncRY1fJo4qB0Qtv0qGt6d8PuEfWPmCRffhJ2meMH0nph01xVtrjL5kH3O8
	7rXErs7hpV+MV78My4MHtnol3mm+rhoHnVNWWZ10/VbAeFHlw6LEQ4a5n32WmX6acL/33NVp
	H933xQhuSpWSPuJVLnc/6XOuk4zAUiWW4oxEQy3mouJEAK+E41hvAwAA
X-CMS-MailID: 20240214170409uscas1p1e04d5916cb91670ea7f6413f0347d9ca
CMS-TYPE: 301P
X-CMS-RootMailID: 20240214170409uscas1p1e04d5916cb91670ea7f6413f0347d9ca
References: <20240213174602.GD52640@unreal>
	<20240213194556.GA1219770@bhelgaas> <20240214071618.GE52640@unreal>
	<CGME20240214170409uscas1p1e04d5916cb91670ea7f6413f0347d9ca@uscas1p1.samsung.com>

On Wed, Feb 14, 2024 at 09:16:18AM +0200, Leon Romanovsky wrote:
> On Tue, Feb 13, 2024 at 01:45:56PM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 13, 2024 at 07:46:02PM +0200, Leon Romanovsky wrote:
> > > On Tue, Feb 13, 2024 at 09:59:54AM -0600, Bjorn Helgaas wrote:
> > > ...
> >=20
> > > > I guess that means that if we apply this revert, the problem Pierre
> > > > reported will return.  Obviously the deadlock is more important tha=
n
> > > > the inconsistency Pierre observed, but from the user's point of vie=
w
> > > > this will look like a regression.
> > > >=20
> > > > Maybe listening to netlink and then looking at sysfs isn't the
> > > > "correct" way to do this, but I don't want to just casually break
> > > > existing user code.  If we do contemplate doing the revert, at the
> > > > very least we should include specific details about what the user c=
ode
> > > > *should* do instead, at the level of the actual commands to use
> > > > instead of "ip monitor dev; cat ${path}/device/sriov_numvfs".
> > >=20
> > > udevadm monitor will do the trick.
> > >=20
> > > Another possible solution is to refactor the code to make sure that
> > > .probe on VFs happens only after sriov_numvfs is updated.
> >=20
> > I like the idea of refactoring it so as to preserve the existing
> > ordering while also fixing the deadlock.
>=20
> I think something like this will be enough (not tested). It will et the n=
umber of VFs
> before we make VFs visible to probe:

I'll push a v3, replacing the second patch with this one instead. Although
based on this discussion it seems we're moving towards squashing the revert
with Leon's suggested patch. Bjorn, I'll assume you're still OK with just
squashing these on your end.

I would like some input on how to actually test this though. Presumably we =
see
some event on device PF and we want to make sure if we read PF/device/sriov=
_numvfs
that we see the updated value. But the only type of event I think we can
expect is the PF's sriov_numvfs CHANGE event.

Is there any way for VFs to be created outside of writing to the
sriov_numvfs sysfs file? My understanding is some older devices/drivers wil=
l
auto-create VFs when the PF is initialized, but it wasn't clear from the bu=
g
report whether that was part of the configuration here. Pierre, do you have
any recollection on this?

Or maybe testing for this case just means compile and verify with udevadm
monitor that we see the CHANGE event before any of the VFs are actually
created...

>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index aaa33e8dc4c9..0cdfaae80594 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -679,12 +679,14 @@ static int sriov_enable(struct pci_dev *dev, int nr=
_virtfn)
>  	msleep(100);
>  	pci_cfg_access_unlock(dev);
> =20
> +	iov->num_VFs =3D nr_virtfn;
>  	rc =3D sriov_add_vfs(dev, initial);
> -	if (rc)
> +	if (rc) {
> +		iov->num_VFs =3D 0;
>  		goto err_pcibios;
> +	}
> =20
>  	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> -	iov->num_VFs =3D nr_virtfn;
> =20
>  	return 0;
>  =

