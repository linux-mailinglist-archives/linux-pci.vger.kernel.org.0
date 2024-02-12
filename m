Return-Path: <linux-pci+bounces-3373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE688521D3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 23:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4441CB21753
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA3481DE;
	Mon, 12 Feb 2024 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EENFP+Sa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A347B1EEFD;
	Mon, 12 Feb 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778755; cv=none; b=jTO/HmEqAWtFpHfWgRj7+puyrCerriyW26IfnL8mHFouSE05AFpw8W4wtYbfY0x3L9apVSeskv/EjxYW6tXtAIvVRGDx+TWsNtzp0i4HCLCFYBRvKGy2MQR1kMnNxt0LuBpusjaTbCkzch3wbwh2PinKIp1PcdbddW90dmLf3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778755; c=relaxed/simple;
	bh=/IcbQ9F3i5FWS1KdxMZEU750F4jB3yQ80Z/SL0lekqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=HQmjMGxeM+9d/nD6VrSAMwbd3J+MZAW4ciP3Q71XVj0xLr6I2217cb0Th65RwrOualgLjxjvi2iRl40mmQCCa7crpkjeGVrEOp/NmvFBisJC8+GTbp+nhn9Haa6FzONuxMQpiAdbIgSFM6VQV/EPYobF9so8JAjSey0W9JI051s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EENFP+Sa; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240212225905usoutp01775a0b9e99bb26e2d6c41511797ae663~zP7iHgSu21607316073usoutp01W;
	Mon, 12 Feb 2024 22:59:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240212225905usoutp01775a0b9e99bb26e2d6c41511797ae663~zP7iHgSu21607316073usoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707778745;
	bh=rCBYMNZA9n1Rqer+C8kp5Cw//MHQoNI0pQbiRBskjZA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=EENFP+Sa9+lZLkGbw9ZzNpuMIA+vCh+HF7D/VkVUVouIA7YPhEwbWC974mxlrkvSV
	 m+M/eeGMSJ/5ajWRGWrxoucl/3sJRs6tYDWRmxT0fUQFLDJM8P4Bo2i7r/5RcCK6zI
	 F+7Aymh5lcbFCT0ypTiEBXBcYoYNlIKpvyftgPaM=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240212225905uscas1p29c49bb670d7acabc9804d715707ddf15~zP7h17VMP2719427194uscas1p2p;
	Mon, 12 Feb 2024 22:59:05 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id DC.7F.09760.9B2AAC56; Mon,
	12 Feb 2024 17:59:05 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240212225904uscas1p19a3d7743607a0abe3627fb8c4829f27b~zP7hmquKs2097020970uscas1p1F;
	Mon, 12 Feb 2024 22:59:04 +0000 (GMT)
X-AuditID: cbfec36f-7f9ff70000002620-c8-65caa2b9b0c7
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id D1.8D.50948.8B2AAC56; Mon,
	12 Feb 2024 17:59:04 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Mon, 12 Feb 2024 14:59:03 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
	12 Feb 2024 14:59:03 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Leon Romanovsky <leonro@nvidia.com>, Kuppuswamy Sathyanarayanan
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
Thread-Index: AQHaW7MAtwi2xwjfZkaUZDAOVEJQA7EDbuYAgAHuDQCAAlV9AIAAKmoA
Date: Mon, 12 Feb 2024 22:59:03 +0000
Message-ID: <ZcqitnWTh+zQ+H4p@ubuntu>
In-Reply-To: <20240212202714.GA1142983@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3A79157BD081A34FBC00A59BC81DF820@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djX87o7F51KNbhzjcXi2/8eNoslTRkW
	r86sZbO48m8Po8WmDU9YLC7vmsNmcXbecTaL9V/fs1m0r7zC6sDpsWBTqcemVZ1sHvNOBnr0
	Nr9j82h5dpLN4/2+q2wenzfJBbBHcdmkpOZklqUW6dslcGU0zP/DWvBQveL3hhmMDYwb5LsY
	OTkkBEwk5t1qY+5i5OIQEljJKLF441ImCKeVSeLsqS9sMFVLXr1ghUisYZRYvu0JI4TziVFi
	f/93qJZljBLXD99nBGlhE9CU+HVlDVCCg0NEQE2iqz0UpIZZYAWzxJL7j9hBaoQFUiU+9S9n
	ArFFBNIkrp2+xAhhu0lMWDSZBcRmEVCVeLXvJzOIzQtkzzi+ih1kJqeAgcTaC4EgYUYBMYnv
	p9aAjWEWEJe49WQ+E8TVghKLZu9hhrDFJP7tegj1jaLE/e8v2SHq9SRuTJ3CBmHbSfx9/5IF
	wtaWWLbwNdRaQYmTM5+wQPRKShxccYMF5BcJgS8cEj1n57JDJFwkOpf2QNnSEtPXXIZqyJZY
	ub4DHA4SAgUSDUeCIMLWEgv/rGeawKgyC8nZs5CcNAvJSbOQnDQLyUkLGFlXMYqXFhfnpqcW
	G+WllusVJ+YWl+al6yXn525iBCaw0/8O5+9gvH7ro94hRiYOxkOMEhzMSiK8l2acSBXiTUms
	rEotyo8vKs1JLT7EKM3BoiTOa2h7MllIID2xJDU7NbUgtQgmy8TBKdXANKPa5ZuBf9TyZYGn
	T4rVXhNTXGd2WXfa0dxT0xKKqvturJM3PiPc5ZoQce7ytU3PLBc8cFKcJHczrniTzD8nzV1d
	xmdip4exZr7jmiEWUS1zn9NIUiuKrc5RKanu9mp1FdcJ2fuinwtaRp191547Z3Ly0ZenpMvO
	vXefXWi7SYB54+KTN4QnBi+zulZatOvs1b6Fu00OHBTqE+MuvsPuoRGlGpotnH7/QHfBNBVH
	nm3HP5bdaNfNY/KWWfrw/Z+MJXMLGvjK7OO6T/N+M8xgar28p9PS9cttzegfy8vDft8oeft9
	48/j065qMqx8pHxNxH+tF/exoxf/bOM4H3JJoVbIsVDhxc6k9ysqn3RVKbEUZyQaajEXFScC
	AEwoxY7PAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWS2cDsrLtj0alUg55fhhbf/vewWSxpyrB4
	dWYtm8WVf3sYLTZteMJicXnXHDaLs/OOs1ms//qezaJ95RVWB06PBZtKPTat6mTzmHcy0KO3
	+R2bR8uzk2we7/ddZfP4vEkugD2KyyYlNSezLLVI3y6BK6Nh/h/WgofqFb83zGBsYNwg38XI
	ySEhYCKx5NUL1i5GLg4hgVWMEr8fNjBCOJ8YJXru7GeDcJYxSsy/2McI0sImoCnx68oapi5G
	Dg4RATWJrvZQkBpmgRXMEkvuP2IHqREWSJXoebaDBcQWEUiTuHb6EiOE7SYxYdFksDiLgKrE
	q30/mUFsXiB7xvFVYL1CAkESh77fA5vPKWAgsfZCIEiYUUBM4vspkLWcQLvEJW49mc8E8YGA
	xJI955khbFGJl4//sULYihL3v79kh6jXk7gxdQobhG0n8ff9SxYIW1ti2cLXUCcISpyc+YQF
	oldS4uCKGywTGCVmIVk3C8moWUhGzUIyahaSUQsYWVcxipcWF+emVxQb56WW6xUn5haX5qXr
	JefnbmIERv/pf4djdjDeu/VR7xAjEwfjIUYJDmYlEd5LM06kCvGmJFZWpRblxxeV5qQWH2KU
	5mBREue9+0AjVUggPbEkNTs1tSC1CCbLxMEp1cCUeiuIXeSmRdnEH54ZUX7ODdv0W5ljg9/v
	23v3o5VukKIf84zwU+6CpkvvPmh0mPOlYjXHjOAbq6Xkll/PuJXDsG1JQ0nrrP+1GbNyj1V9
	q3vA2Ln3M98v08pr1QxCew+nlPxQWyrUabpmzspvb05qtb7eoLVDf8K9WcGR2Vab1Lw+L3Q/
	VjzXzUGfMeCO2npj8Wtmb//cmKNcv8NSOZu72yb2k0Od4aVgp4+JLpqx3TftDaK2JZiHpLGY
	a0We0jOt/fLitnLrt/t7UrUN7J/yBR26c+vxJ6FdXJl3Doldnxkhm7xgf0SK+OLjTP6/197/
	qCOz1V1Wv05AOPZjuc4Rvjq1jrBl0h/0FidnrVBiKc5INNRiLipOBABFeS7bbQMAAA==
X-CMS-MailID: 20240212225904uscas1p19a3d7743607a0abe3627fb8c4829f27b
CMS-TYPE: 301P
X-CMS-RootMailID: 20240212225904uscas1p19a3d7743607a0abe3627fb8c4829f27b
References: <20240211084844.GA805332@unreal>
	<20240212202714.GA1142983@bhelgaas>
	<CGME20240212225904uscas1p19a3d7743607a0abe3627fb8c4829f27b@uscas1p1.samsung.com>

On Mon, Feb 12, 2024 at 02:27:14PM -0600, Bjorn Helgaas wrote:
> On Sun, Feb 11, 2024 at 10:48:44AM +0200, Leon Romanovsky wrote:
> > On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wr=
ote:
> > > On 2/9/24 3:52 PM, Jim Harris wrote:
> > > > If an SR-IOV enabled device is held by vfio, and the device is remo=
ved,
> > > > vfio will hold device lock and notify userspace of the removal. If
> > > > userspace reads the sriov_numvfs sysfs entry, that thread will be b=
locked
> > > > since sriov_numvfs_show() also tries to acquire the device lock. If=
 that
> > > > same thread is responsible for releasing the device to vfio, it res=
ults in
> > > > a deadlock.
> > > >
> > > > The proper way to detect a change to the num_VFs value is to listen=
 for a
> > > > sysfs event, not to add a device_lock() on the attribute _show() in=
 the
> > > > kernel.
>=20
> The lock was not about detecting a change; Pierre did this:
>=20
>   ip monitor dev ${DEVICE} | grep --line-buffered "^${id}:" | while read =
line; do \
>     cat ${path}/device/sriov_numvfs; \
>=20
> which I assume works by listening for sysfs events.  The problem was
> that after the event occurred, the sriov_numvfs read got a stale value
> (see https://bugzilla.kernel.org/show_bug.cgi?id=3D202991).

I don't think 'ip monitor dev' listens for any sysfs events. Or at least if
I have this running and write values to sriov_numvfs, I don't see any
output.

It looks like the original bug report was against v5.0 (matching by dates
and the patch file attached). In that code, we have:

    kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
    iov->num_VFs =3D nr_virtfn;

which is identical to how the code looks today. Is it possible that
userspace could react to this uevent and read the stale num_VFs before
iov->num_VFs gets written here? I mean, theoretically it's possible, but
from the bug report it seems like the scenario Pierre was facing was
100% reproducible.

It would be great if we could get input from Pierre on this. It isn't clear
to me from the bug report what exactly is updating the sriov_numvfs sysfs
entry, and what is triggering that update.

We could also revisit my original suggestion, which was to use a
discrete lock just for this sysfs entry, rather than overloading the
device lock. That probably has lower risk of introducing an unintended
regression.

https://lore.kernel.org/linux-pci/ZXNNQkXzluoyeguu@bgt-140510-bm01.eng.stel=
lus.in/

>=20
> So I would drop this sentence because I don't think it accurately
> reflects the reason for 35ff867b7657.
>=20
> > > Since you are reverting a commit that synchronizes SysFS read
> > > /write, please add some comments about why it is not an
> > > issue anymore.
> >=20
> > It was never an issue, the idea that sysfs read and write should be
> > serialized by kernel is not correct by definition.=20
>=20
> I think it *was* an issue.  The behavior Pierre observed at was
> clearly wrong, and we added 35ff867b7657 ("PCI/IOV: Serialize sysfs
> sriov_numvfs reads vs writes") to resolve it.
>=20
> We should try to avoid reintroducing the problem, so I think we should
> probably squash these two patches and describe it as a deadlock fix
> instead of dismissing 35ff867b7657 as being based on false premises.
>=20
> It would be awesome if you had time to verify that these patches also
> resolve the problem you saw, Pierre.
>=20
> I think we should also add:
>=20
>   Fixes: 35ff867b7657 ("PCI/IOV: Serialize sysfs sriov_numvfs reads vs wr=
ites")
>=20
> as a trigger for backporting this to kernels that include
> 35ff867b7657.
>=20
> Bjorn
>=20
> > > > This reverts commit 35ff867b76576e32f34c698ccd11343f7d616204.
> > > > Revert had a small conflict, the sprintf() is now changed to sysfs_=
emit().
> > > >
> > > > Link: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/
> > > > Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Signed-off-by: Jim Harris <jim.harris@samsung.com>
> > > > ---
> > > >  drivers/pci/iov.c |    8 +-------
> > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > > > index aaa33e8dc4c9..0ca20cd518d5 100644
> > > > --- a/drivers/pci/iov.c
> > > > +++ b/drivers/pci/iov.c
> > > > @@ -395,14 +395,8 @@ static ssize_t sriov_numvfs_show(struct device=
 *dev,
> > > >  				 char *buf)
> > > >  {
> > > >  	struct pci_dev *pdev =3D to_pci_dev(dev);
> > > > -	u16 num_vfs;
> > > > -
> > > > -	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs=
 */
> > > > -	device_lock(&pdev->dev);
> > > > -	num_vfs =3D pdev->sriov->num_VFs;
> > > > -	device_unlock(&pdev->dev);
> > > > =20
> > > > -	return sysfs_emit(buf, "%u\n", num_vfs);
> > > > +	return sysfs_emit(buf, "%u\n", pdev->sriov->num_VFs);
> > > >  }
> > > > =20
> > > >  /*
> > > >
> > > --=20
> > > Sathyanarayanan Kuppuswamy
> > > Linux Kernel Developer
> > > =

