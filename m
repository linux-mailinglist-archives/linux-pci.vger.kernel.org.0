Return-Path: <linux-pci+bounces-1078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8FA815354
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 23:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E64F1C242E1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 22:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C07013B128;
	Fri, 15 Dec 2023 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UxXsFG7X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75413B12C;
	Fri, 15 Dec 2023 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231215221119usoutp023fb644809b43e26f021783371c1e4803~hIN_xEqLE1802018020usoutp02W;
	Fri, 15 Dec 2023 22:11:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231215221119usoutp023fb644809b43e26f021783371c1e4803~hIN_xEqLE1802018020usoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702678279;
	bh=KvZvvlGPICQFkYjf7KEZNtzlEaLHKZVdgQyZ9zCYw/s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=UxXsFG7XrYslZwcgwEMc42vJEg06zJNqeahqEe6wcRL8LbBspCpZekgpzjFYDzn/h
	 v/X59DYaWBeHzllxFXT+DV9WMBEwKhaZVx8pscNZ8cYTOo+8oByuxTN4KqWasZXA+g
	 Dng+64vnYC8qbVKC/X+f/ExM4KSULVNGyRG5RrWg=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231215221119uscas1p22efb0ad26c168906661c06a07cc275fe~hIN_qWGPZ0138301383uscas1p2N;
	Fri, 15 Dec 2023 22:11:19 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 9B.F4.09678.70FCC756; Fri,
	15 Dec 2023 17:11:19 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231215221118uscas1p1b407f67deb53a75ae03d67247653b30b~hIN_Z2okP2295022950uscas1p1Y;
	Fri, 15 Dec 2023 22:11:18 +0000 (GMT)
X-AuditID: cbfec36d-85fff700000025ce-54-657ccf07df13
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id BD.4D.09813.60FCC756; Fri,
	15 Dec 2023 17:11:18 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 15 Dec 2023 14:11:18 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	15 Dec 2023 14:11:18 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] pci/iov: fix kobject_uevent() ordering in
 sriov_enable()
Thread-Topic: [PATCH] pci/iov: fix kobject_uevent() ordering in
	sriov_enable()
Thread-Index: AQHaLfZbfzSE7OYN20WpA0TR5aL0dLCoHtUAgANSmoA=
Date: Fri, 15 Dec 2023 22:11:17 +0000
Message-ID: <ZXzPBTZ2rK/CPy5o@ubuntu>
In-Reply-To: <20231213192652.GA1054534@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9BE0741C2887B4194448243347D1463@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djX87rs52tSDT4fZLb49r+HzWJJU4bF
	qzNr2Syu/NvDaLFpwxMWi8u75rBZnJ13nM2B3WPBplKPTas62Tx6m9+xebzfd5XN4/MmuQDW
	KC6blNSczLLUIn27BK6MFSvPsRec5a3oazzE2sD4kquLkZNDQsBEouPEftYuRi4OIYGVjBK7
	FpxihnBamSTa1t5ihKm6uOYuI0RiDaPEtb2X2CCcT4wSP1evYIFwljFKnP5+kBmkhU1AU+LX
	lTVMXYwcHCICahJd7aEgNcwCc5gk5j87wA5SIyzgLzFxxikWiJoAiecv60HCIgJWEmeedLCC
	2CwCqhLLbk8Bu4IXyN4/eSELiM0pYCAx4/FtJhCbUUBM4vupNWA2s4C4xK0n85kgrhaUWDR7
	DzOELSbxb9dDNghbUeL+95fsEPU6Egt2f2IDOYFZwE7i3BwBiLC2xLKFr5kh1gpKnJz5hAWi
	VVLi4IobYO9KCNzhkHi7ZBs7RMJFYuPHA1BF0hJ/7y6DuiFbYuX6DnAwSAgUSDQcCYIIW0ss
	/LOeaQKjyiwkV89CctEshItmIbloFpKLFjCyrmIULy0uzk1PLTbMSy3XK07MLS7NS9dLzs/d
	xAhMS6f/Hc7dwbjj1ke9Q4xMHIyHGCU4mJVEeBesrU4V4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zmtoezJZSCA9sSQ1OzW1ILUIJsvEwSnVwOQw640y0967K8w2x29SO8rHce8eF3NoyTSjX0nP
	xM5V8lyeWXG7Z/te5WTVLYmvpzNZfXgmaf97r9q8dU/EBNiV9MsmO38U7rw4TZ3r+6wdmiKB
	3eo6K91VliQ9e7dJrcK9J3BLTFl0wSlR9nNKLgWf7LfVFXy5GurQtm3KwtY7CSVX7Bp5Z56f
	cu3T1gIh/+PVhu+LMsu3LVUVn+2VXaRluiJlh4eY9KPZX5psd/2JCWN6ctxxS8s23iKOefO3
	BVzqW8avdshVbg3HPcmzkwoaHYNLvLi19AUXqBjaijBfuXXiy76Fu8U11nzzjv26b8r0uPXe
	ftf1RWbO/7aHd++H6lXPvil7cffmdX3V81NiKc5INNRiLipOBAA4IEp/ugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWS2cDsrMt2vibV4PZSPYtv/3vYLJY0ZVi8
	OrOWzeLKvz2MFps2PGGxuLxrDpvF2XnH2RzYPRZsKvXYtKqTzaO3+R2bx/t9V9k8Pm+SC2CN
	4rJJSc3JLEst0rdL4MpYsfIce8FZ3oq+xkOsDYwvuboYOTkkBEwkLq65y9jFyMUhJLCKUeL+
	yQNsIAkhgU+MEh/uFkEkljFKHPj0jxkkwSagKfHryhqmLkYODhEBNYmu9lCQGmaBOUwS858d
	YAepERbwlfi2/QzYIBEBP4nTd65A2VYSZ550sILYLAKqEstuT2EEsXmB7P2TF7JALGtklGi8
	+AJsEKeAgcSMx7eZQGxGATGJ76fWgNnMAuISt57MZ4J4QUBiyZ7zzBC2qMTLx/9YIWxFifvf
	X7JD1OtILNj9iQ3kaGYBO4lzcwQgwtoSyxa+Zoa4QVDi5MwnLBCtkhIHV9xgmcAoMQvJtllI
	Js1CmDQLyaRZSCYtYGRdxSheWlycm15RbJSXWq5XnJhbXJqXrpecn7uJERjVp/8djt7BePvW
	R71DjEwcjIcYJTiYlUR4F6ytThXiTUmsrEotyo8vKs1JLT7EKM3BoiTOe/eBRqqQQHpiSWp2
	ampBahFMlomDU6qBqXmK80zLul/VD7mz7e+aeFZHfhDfblIkKHRm4/lV33gbjrSfcu2cY/nm
	3tRyxYU/Ozdqd1VoV7m0/bkWs/xqyIUkrcoi8cbYKXfzMr/tMFueEn13ssd97cPyTjwHk4vL
	tm84PMlC78+qsItTuha9+l76M2j1N8tVEaY577zY/U/xSTJv7c3g8TWZkrPWYcKRbR3T7oq8
	CzuivEcs6KvsI4uLK3u2KuVdk2Zap73LiiHXNa9cdcfk1b+PWG3yr3mz5+6cN1yy9e6OW02u
	ZSoJStVefBu2fIlU5qNVsTc4kidt/VDX+KzTy+y/VEA0J7/AB02blaoB9p3B7YH/vl5Zlv2D
	3+bB1GS27euPZQs/UmIpzkg01GIuKk4EAPZ0q/VZAwAA
X-CMS-MailID: 20231215221118uscas1p1b407f67deb53a75ae03d67247653b30b
CMS-TYPE: 301P
X-CMS-RootMailID: 20231215221118uscas1p1b407f67deb53a75ae03d67247653b30b
References: <170249390826.436889.13896090394795622449.stgit@bgt-140510-bm01.eng.stellus.in>
	<20231213192652.GA1054534@bhelgaas>
	<CGME20231215221118uscas1p1b407f67deb53a75ae03d67247653b30b@uscas1p1.samsung.com>

On Wed, Dec 13, 2023 at 01:26:52PM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 13, 2023 at 06:58:28PM +0000, Jim Harris wrote:
> > Wait to call kobject_uevent() until all of the associated changes are d=
one,
> > including updating the num_VFs value.
>=20
> This seems right to me.  Can we add a little rationale to the commit
> log?  E.g., something about how num_VFs is visible to userspace via
> sysfs and we don't want a race between (a) userspace reading num_VFs
> because of KOBJ_CHANGE and (b) the kernel updating num_VFs?  (If
> that's the actual reason.)
>=20
> If there's a problem report about this, include that reference as
> well.

There's a second patch that I haven't pushed yet that has more of the
rationale that led to this suggestion from Leon - see thread
"Locking between vfio hot-remove..." I'll push the two patches as a series.

The second patch will effectively revert 35ff867b7, since Leon felt the
reasoning behind that patch was incorrect. I'll tie all of that into the
cover letter.

-Jim

>=20
> > Suggested by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Jim Harris <jim.harris@samsung.com>
> > ---
> >  drivers/pci/iov.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 25dbe85c4217..3b768e20c7ab 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -683,8 +683,8 @@ static int sriov_enable(struct pci_dev *dev, int nr=
_virtfn)
> >  	if (rc)
> >  		goto err_pcibios;
> > =20
> > -	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> >  	iov->num_VFs =3D nr_virtfn;
> > +	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> > =20
> >  	return 0;
> > =20
> > =

