Return-Path: <linux-pci+bounces-3472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82238855661
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 23:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E3C1F2C9B0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 22:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FAA2E629;
	Wed, 14 Feb 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zgs10DNi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D263250F6;
	Wed, 14 Feb 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951343; cv=none; b=aclRR33K7FmXefMGqov9bQCGdqUeDykXytPKicrsK7PeQiHvKFoy/9zoGukHYdT/bDCgHTuXQgomMqcZPssErXn0PiDyNd6gbDxu1RyFzP2wIenVSJxK00dAvFpERJ4oEbrnSCsUYuFRqO2Cii4u89ypcJvXTGnY/nswVh3ATDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951343; c=relaxed/simple;
	bh=0+cg/xnEl8pLBBzYZbEugcpP7E4uoOwj6ToG5UYN5aI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=R0OqupYMl1hqzx48RZDwYqPiDwEukUAaigcECgDCBzhPjp6IHb6rrHkx3EcUYDm7SlI30/BWfpqV1Fj+GYs6QE6VuHJK5Ewd838B8UYKnom4qJXKqUavyIfwdIK13nG8A7IRUt61Hlz86rMjMpzbZN6SjMzN11uKMALGoTuEB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Zgs10DNi; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240214225539usoutp0138cc055b6f98c374b1e0e1b463a1295a~z3LGY5RzI2570225702usoutp013;
	Wed, 14 Feb 2024 22:55:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240214225539usoutp0138cc055b6f98c374b1e0e1b463a1295a~z3LGY5RzI2570225702usoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707951339;
	bh=hzYFUuVAQk0FCSPELf76ZGU4cGQXXNSqGnjqdzUhN60=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Zgs10DNiJbDcyf2kAi2AEfSosi1fXUR2EyMjQNOClVkj8WUVteL/ean0J2U9Q0aSc
	 FwRqMs8U3jCYNu2XjNIU+VP4ypUOtlmtEHEiLcuJHnN965wM7U2/zwSWxXP/aTE1Li
	 Hen9nfmo+qGrT2UdxBMMG55+2pncXNi0pUzLBYa8=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240214225538uscas1p1a0bd544707f70208daadf8e306aadb9f~z3LGJg21t0998609986uscas1p1m;
	Wed, 14 Feb 2024 22:55:38 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id FF.46.09550.AE44DC56; Wed,
	14 Feb 2024 17:55:38 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240214225538uscas1p2d6502c3bd144e4d90d4506acf4847159~z3LFzDyZq1875018750uscas1p2I;
	Wed, 14 Feb 2024 22:55:38 +0000 (GMT)
X-AuditID: cbfec370-933ff7000000254e-f2-65cd44eaae9c
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 50.C5.45319.AE44DC56; Wed,
	14 Feb 2024 17:55:38 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 14 Feb 2024 14:55:37 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	14 Feb 2024 14:55:37 -0800
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
Thread-Index: AQHaW7MAtwi2xwjfZkaUZDAOVEJQA7EDbuYAgAHuDQCAAlV9AIAAuocAgACNHQCAAB2nAIAAIYAAgADA4wCAAKQ8gIAADNIAgABVYgA=
Date: Wed, 14 Feb 2024 22:55:37 +0000
Message-ID: <Zc1E6MFaBKvndAD+@ubuntu>
In-Reply-To: <20240214175000.GA1260022@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <76E6B18DAFFC284592B288B474CBC3ED@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djXc7qvXM6mGhzsULf49r+HzWJJU4bF
	qzNr2Syu/NvDaLFpwxMWi8u75rBZnJ13nM1i/df3bBbtK6+wOnB6LNhU6rFpVSebx7yTgR69
	ze/YPFqenWTzeL/vKpvH501yAexRXDYpqTmZZalF+nYJXBmLrhQVfFSqOHb2F1MD43+pLkZO
	DgkBE4mFj3axdTFycQgJrGSUWLtmPhOE08oksfFgOwtM1dfD51khEmsYJa59WsIO4XxilFj5
	4woLhLOMUWLGu/WMIC1sApoSv66sAZrFwSEioCbR1R4KUsMssIJZYsn9R+wgNcICqRKf+pcz
	gdgiAmkS105fYoSwyySube9iBrFZBFQl5n76xQpi8wLZaxYtAjuJU8BA4uPFNjCbUUBM4vup
	NWBzmAXEJW49mc8EcbagxKLZe5ghbDGJf7seskHYihL3v79kh6jXk7gxdQobhG0n8WhPHzOE
	rS2xbOFrZoi9ghInZz6BBoWkxMEVN8AelhD4wCHx9PASNpAnJQRcJBobkyBqpCX+3l0GdUO2
	xMr1HUwQJQUSDUeCIMLWEgv/rGeawKgyC8nVs5BcNAvJRbOQXDQLyUULGFlXMYqXFhfnpqcW
	G+ellusVJ+YWl+al6yXn525iBKav0/8OF+xgvHXro94hRiYOxkOMEhzMSiK8k3rPpArxpiRW
	VqUW5ccXleakFh9ilOZgURLnNbQ9mSwkkJ5YkpqdmlqQWgSTZeLglGpgEmk+tmeiR7D7FXGz
	4C1x1btDatcXcKvOf/bnOVNugzDPvcLUM5frwrYV2tt/VfD6rHS68Bi3YZuacKJ19ba3FtIn
	L+4OPb+Ne1Vk8KY9zfLVHD/2mDyUqdu/U+KJS9TfJlfVeWb3JkdMO+Ii/t5MV2jfgbXPYn7d
	Of3l18Py5Q2X52yc+d5w/q5j96aW2DVs+jKjmMvj9asb/7gbuYqZZRJEfoVumedxYB/rRu5z
	onWR2yJ3qj7yY2uQX7X15fb/hg0tTwXmhmm9PW3XZH6U10+QYamwfg6DQuGyJeIP1XZK2D64
	myWTE2B5+9w6vi6Z3vhSlrBMX1PVpTVsQW8vXXAPOTbZ/Q638ZnVHu4qSizFGYmGWsxFxYkA
	352Tqc4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWS2cDspPvK5WyqwbfbAhbf/vewWSxpyrB4
	dWYtm8WVf3sYLTZteMJicXnXHDaLs/OOs1ms//qezaJ95RVWB06PBZtKPTat6mTzmHcy0KO3
	+R2bR8uzk2we7/ddZfP4vEkugD2KyyYlNSezLLVI3y6BK2PRlaKCj0oVx87+Ympg/C/VxcjJ
	ISFgIvH18HnWLkYuDiGBVYwS66ZsYQFJCAl8YpS4dUwCIrGMUWLnzVPMIAk2AU2JX1fWMHUx
	cnCICKhJdLWHgtQwC6xgllhy/xE7SI2wQKpEz7MdYINEBNIkrp2+xAhhl0lc294FNodFQFVi
	7qdfrCA2L5C9ZtEiqMWeEn3P94PN4RQwkPh4sQ0sziggJvH9FMheTqBl4hK3nsxngvhAQGLJ
	nvPMELaoxMvH/1ghbEWJ+99fskPU60ncmDqFDcK2k3i0p48ZwtaWWLbwNTPEDYISJ2c+YYHo
	lZQ4uOIGywRGiVlI1s1CMmoWklGzkIyahWTUAkbWVYzipcXFuekVxUZ5qeV6xYm5xaV56XrJ
	+bmbGIGxf/rf4egdjLdvfdQ7xMjEwXiIUYKDWUmEd1LvmVQh3pTEyqrUovz4otKc1OJDjNIc
	LErivHcfaKQKCaQnlqRmp6YWpBbBZJk4OKUamKr4t7/85D/hXzt3s2jplIzU8LbCH8lcvM9k
	7Z4tndhquuLv6VkJ2bJzznS1vp3XVMhdw7qQ61DMoeVHbVnZ2IJ/F2l+el9bGfdNJ3pGWOKa
	w+cN/QwkVYTmfQ3n/bn6afO7+/OqWforb/Nbfzi391b9vdS2Jb1z838a5B20W5okP6XwUurn
	9FnVqaKXj1b9NVAQM5Nfm1sRx6e9x2Af0yFJ5sXV1xuqlxk4mke15B+MUu8Wm16+udTN6MSl
	xaH69+6yaiWH3XSzFrLYvPJyc0f11ZXvVid9CKp9fLg1Rirvh0by29MWohmx3759Dmy8pzPh
	1ZqavDX3pE+YzWPIfPdw2hY3mzPSner8+WsXK7EUZyQaajEXFScCAFXG7HJsAwAA
X-CMS-MailID: 20240214225538uscas1p2d6502c3bd144e4d90d4506acf4847159
CMS-TYPE: 301P
X-CMS-RootMailID: 20240214225538uscas1p2d6502c3bd144e4d90d4506acf4847159
References: <Zczyhya/+454IaQM@ubuntu> <20240214175000.GA1260022@bhelgaas>
	<CGME20240214225538uscas1p2d6502c3bd144e4d90d4506acf4847159@uscas1p2.samsung.com>

On Wed, Feb 14, 2024 at 11:50:00AM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 14, 2024 at 05:04:08PM +0000, Jim Harris wrote:
> > On Wed, Feb 14, 2024 at 09:16:18AM +0200, Leon Romanovsky wrote:
> > > On Tue, Feb 13, 2024 at 01:45:56PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Feb 13, 2024 at 07:46:02PM +0200, Leon Romanovsky wrote:
> > > > > On Tue, Feb 13, 2024 at 09:59:54AM -0600, Bjorn Helgaas wrote:
> > > > > ...
> > > >=20
> > > > > > I guess that means that if we apply this revert, the problem Pi=
erre
> > > > > > reported will return.  Obviously the deadlock is more important=
 than
> > > > > > the inconsistency Pierre observed, but from the user's point of=
 view
> > > > > > this will look like a regression.
> > > > > >=20
> > > > > > Maybe listening to netlink and then looking at sysfs isn't the
> > > > > > "correct" way to do this, but I don't want to just casually bre=
ak
> > > > > > existing user code.  If we do contemplate doing the revert, at =
the
> > > > > > very least we should include specific details about what the us=
er code
> > > > > > *should* do instead, at the level of the actual commands to use
> > > > > > instead of "ip monitor dev; cat ${path}/device/sriov_numvfs".
> > > > >=20
> > > > > udevadm monitor will do the trick.
> > > > >=20
> > > > > Another possible solution is to refactor the code to make sure th=
at
> > > > > .probe on VFs happens only after sriov_numvfs is updated.
> > > >=20
> > > > I like the idea of refactoring it so as to preserve the existing
> > > > ordering while also fixing the deadlock.
> > >=20
> > > I think something like this will be enough (not tested). It will et t=
he number of VFs
> > > before we make VFs visible to probe:
> >=20
> > I'll push a v3, replacing the second patch with this one instead. Altho=
ugh
> > based on this discussion it seems we're moving towards squashing the re=
vert
> > with Leon's suggested patch. Bjorn, I'll assume you're still OK with ju=
st
> > squashing these on your end.
>=20
> Yep.
>=20
> > I would like some input on how to actually test this though.
> > Presumably we see some event on device PF and we want to make sure
> > if we read PF/device/sriov_numvfs that we see the updated value. But
> > the only type of event I think we can expect is the PF's
> > sriov_numvfs CHANGE event.
> >=20
> > Is there any way for VFs to be created outside of writing to the
> > sriov_numvfs sysfs file? My understanding is some older
> > devices/drivers will auto-create VFs when the PF is initialized, but
> > it wasn't clear from the bug report whether that was part of the
> > configuration here. Pierre, do you have any recollection on this?
> >=20
> > Or maybe testing for this case just means compile and verify with
> > udevadm monitor that we see the CHANGE event before any of the VFs
> > are actually created...
>=20
> I just want to make sure that Pierre's existing code continues to work
> unchanged.
>=20
> Ideally we could revert 35ff867b7657 ("PCI/IOV: Serialize sysfs
> sriov_numvfs reads vs writes"), reproduce the problem with the shell
> script attached to https://bugzilla.kernel.org/show_bug.cgi?id=3D202991
> (I assume Pierre used a /sys/.../sriov_numvfs write to trigger the
> change).
=20
That shell script generates no output when writing to sriov_numvfs, so I'm
unable to reproduce the problem.

Terminal 1:
# ip monitor dev ens7f0np0

Terminal 2:
# echo 1 > /sys/class/net/ens7f0np0/device/sriov_numvfs
#

No output in terminal 1.

I've done what testing I can with the proposed patch below, I'll send out t=
he
v3 series here shortly.

> Then we could verify that with 35ff867b7657 still reverted but the
> change below added, the problem is no longer reproducible.
>=20
> > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > > index aaa33e8dc4c9..0cdfaae80594 100644
> > > --- a/drivers/pci/iov.c
> > > +++ b/drivers/pci/iov.c
> > > @@ -679,12 +679,14 @@ static int sriov_enable(struct pci_dev *dev, in=
t nr_virtfn)
> > >  	msleep(100);
> > >  	pci_cfg_access_unlock(dev);
> > > =20
> > > +	iov->num_VFs =3D nr_virtfn;
> > >  	rc =3D sriov_add_vfs(dev, initial);
> > > -	if (rc)
> > > +	if (rc) {
> > > +		iov->num_VFs =3D 0;
> > >  		goto err_pcibios;
> > > +	}
> > > =20
> > >  	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> > > -	iov->num_VFs =3D nr_virtfn;
> > > =20
> > >  	return 0;
> > >  =

