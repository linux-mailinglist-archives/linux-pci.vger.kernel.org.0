Return-Path: <linux-pci+bounces-3308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709208500A0
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 00:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31208286F88
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 23:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BED374C1;
	Fri,  9 Feb 2024 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YZBJ8hjN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF6219E4;
	Fri,  9 Feb 2024 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520529; cv=none; b=V/8dxkyoI6geN082Q72JSDZKuF1DbD5TKKwOt++5kvZSqhqYx1ms15JZUUGhOF6cp6og1cCE8Z/uaDXIb+qACgcv5Vrh8mLWh5TYby9pYaST2gMGhnY3uDC9eEMbL68z8rM33QPuSiFzfU5RkGmyrbL/eWW0dYCs2WfVKMgZStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520529; c=relaxed/simple;
	bh=iHOiWx3N44/V0chuIC+CU2VPdA0byhu2KNToSA2kEB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=HE3SG0yap1xFfiFQxC5fgHs/zOty+7QnO8VLSMy5LbeRL5vHKiQPV7+pJ841CnbaZN8d86hjWyUpmTJMMdWvI6eZqjh7LSc3rEdBUmJZWqHbkLJrN/VJPtR3G+Ghr1VLuwGv2earbSu+H1YOyR6YRm3Eo3mpNebSgXLnf+wLukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YZBJ8hjN; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240209230630usoutp02488d1d4a6cfd6c79586faedf938f0bdc~yVGJVUUO52937329373usoutp02g;
	Fri,  9 Feb 2024 23:06:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240209230630usoutp02488d1d4a6cfd6c79586faedf938f0bdc~yVGJVUUO52937329373usoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707519990;
	bh=9streDRSc+PJVyGG8oa28gukDCVkQV34TxJf+8p7MM4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=YZBJ8hjN0RY/u27tBlnPxiyaK1fpSvwwtx2FYEBOoKx8CGtbAUOjAtwOS8N+pcBIb
	 JAdJSrr0hFGYuNA7Gq+Z2yFkvu9z8FEZcorqtY8KZXBbMLY4+ylX+PU6I2nFuyNG2u
	 6gpk2u6Q/3XCcWRcPKtWjnAReQIs2uz7bdBNazyI=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209230629uscas1p21e53a766dbba7d8927b89dab3666dc76~yVGJMLzRi3086030860uscas1p2L;
	Fri,  9 Feb 2024 23:06:29 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 03.FD.09678.5FFA6C56; Fri, 
	9 Feb 2024 18:06:29 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209230629uscas1p2a12ec31d123307de2ef5babc608c2912~yVGJA_FWL0162101621uscas1p2D;
	Fri,  9 Feb 2024 23:06:29 +0000 (GMT)
X-AuditID: cbfec36d-85fff700000025ce-15-65c6aff54764
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 86.4C.45319.5FFA6C56; Fri, 
	9 Feb 2024 18:06:29 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 9 Feb 2024 15:06:24 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	9 Feb 2024 15:06:24 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?Q?Pierre_Cr=E9gut?= <pierre.cregut@orange.com>
Subject: Re: [PATCH 0/2] pci/iov: avoid device_lock() when reading
 sriov_numvfs
Thread-Topic: [PATCH 0/2] pci/iov: avoid device_lock() when reading
	sriov_numvfs
Thread-Index: AQHaM5gBfWDt8KjT2UOEaPDLPlceorEB/SkAgAF66wA=
Date: Fri, 9 Feb 2024 23:06:24 +0000
Message-ID: <Zcav5ppteV/6PEr6@ubuntu>
In-Reply-To: <20240209003002.GA984052@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <73E21C11A76604428B69E749A22EFB52@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3c5Ow6s40n0yUBolZTabGWwyiS6cTDQrhQW1MqTE3VbO1m2
	blaT1DTyVjZNM610aItlZWoLzbRp9SEn1rrDGKnoMm+VbpU7Bvv2e573//L8npcX55JGfgCe
	oDhCqxWyJBEm5D1sG329ZNTQRi/V6pZLx/5kY9LKc3Jp38taTGpxNSGp8Z6NJ+1qKMGkr0rb
	Malh1IGtxakbxhTKqM/EqJzzgxiltZsxymHqxqhhY+AWLFYYEUcnJRyl1WGR+4XyibESnuoy
	mWrNfSlIQ/Uzs5AXDkQ4WO0ufhYS4iRRjeBSbb6ALdI50NUxiv1P5RnOcqaYJGoQZBTL2dAQ
	gqEHGYgtbiHQ1WW6UxixGH5bav4xjvsSQZB1YedUhku858B46VXBVGY2sRVy6orRFPsS26C5
	rJPP8ip4/OiJm3nEAnC8G3TnvYmF0GK56TbyIsLgjsPp7iPCD8Y7atxzuYQ/WG1lHNbaB24W
	N3FZ9gNXw9fpbebB5/FeAZsXw9vCAozlSLA7zHyWQ+B2eT+XnesD5ms2Hnt3DjRXvZ3mbzg0
	NyeyvAE6L7RO9+eC8+PtaYdEqDZkuN8BCBWktW5j26uhfNLAuYwW6DysdR5GOg8jnYeRzsPo
	BuLrkX8KwyTH04xEQR8TM7JkJkURLz6oTDaif9+q0/UsuR7VW4fELYiDoxYEOFfk672jspUm
	veNkxzW0WrlPnZJEMy1oLs4T+XtL1pgPkkS87AidSNMqWv3/lIN7BaRxstuodZ8rnr9pFzLO
	gauxfZaVT/WF2wXzfljLhzpVpMRRQX4oUmo22kt/2mzOzfymmvVR85VnSuUm132qsc6nOmhz
	ekxeWNEfuiuwqj0EWxGTG5ebb/k1ElSkVfgFRk2IWk3Lup+pDvT83NKzr3csa8nRQ3Pe3c3c
	O7zbWfW7yhpAhfNOV3RXf230uTIA6TEdod8HYlWNRSExmXJqxu6e6E0ZL2gTRaW+OKklvfwK
	gg9Ha01R5SPKyJE8TcOqnEsfZoUnmEMfmU58+lKbpFdEXD/ZP1mSMKKfkNw/l29/k7NrveZ1
	niaY/vQqbe+M3j2hw5WLEm8pL5aJD9SdmvyWLeIxcpkkmKtmZH8BLrA4WsUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWS2cDspPt1/bFUg9PfVCy+/e9hs1jSlGHx
	6sxaNosr//YwWmza8ITF4vKuOWwWZ+cdZ7NY//U9mwOHx4JNpR6bVnWyefQ2v2PzaHl2ks3j
	/b6rbB6fN8kFsEVx2aSk5mSWpRbp2yVwZfz+NoelYIJQxa2JZ9gbGHfwdTFyckgImEhMWt/I
	1MXIxSEksIpRYtK8XkYI5yOQ0/GeBcJZyigxbe08JpAWNgFNiV9X1gDZHBwiAmoSXe2hIDXM
	AreZJL7Pm84OUiMsECjRu2U2I4gtIhAkcW5ZB5RtJbFz+15WEJtFQEXi/c13YPW8AqoSh64s
	YgOxhQTqJH4fWwe2i1NAX2L5+79gNYwCYhLfT60BizMLiEvcejKfCeIFAYkle84zQ9iiEi8f
	/2OFsBUl7n9/yQ5RrydxY+oUNgjbTuLZ+5OsELa2xLKFr5khbhCUODnzCQtEr6TEwRU3WCYw
	SsxCsm4WklGzkIyahWTULCSjFjCyrmIULy0uzk2vKDbKSy3XK07MLS7NS9dLzs/dxAiM9tP/
	DkfvYLx966PeIUYmDsZDjBIczEoivCFLjqQK8aYkVlalFuXHF5XmpBYfYpTmYFES5737QCNV
	SCA9sSQ1OzW1ILUIJsvEwSnVwFRVlnd8Zudd/pi3WkwHinteOytkm/Qb/515d2Gxv+x8zgbf
	iHX/qzw2xn7ctvtNgNmnwx3/u/fyTa+fY55xd0mo1RVmjUOzbI3mF05TFV+gETjVN0pZ9JKy
	w6PM/XG6tp++5eaon/9XH/dn0k1H6Xxnf7MvvhEP9Fc4KTEUGDbxRKxasPLJgl2T7K/o6b/3
	zWQ+umyFf4Lnx7AWueBXkzZfmuetGn5ueqBzkNzB3edmSr7hLHW9Uun1SfHn8gPV/y4qfzvy
	n/P8/m25fGzzeGwMGj4aPKp/qHODS7Dplu2rZcsbMraXsD+uc782x3r9Npa7HxR0tNrsF5yT
	sfy3OvfglpusH47MSJnOv/b/AQUlluKMREMt5qLiRAA1Y8c/ZQMAAA==
X-CMS-MailID: 20240209230629uscas1p2a12ec31d123307de2ef5babc608c2912
CMS-TYPE: 301P
X-CMS-RootMailID: 20240209230629uscas1p2a12ec31d123307de2ef5babc608c2912
References: <170311143880.2826.17853753430536108145.stgit@bgt-140510-bm01.eng.stellus.in>
	<20240209003002.GA984052@bhelgaas>
	<CGME20240209230629uscas1p2a12ec31d123307de2ef5babc608c2912@uscas1p2.samsung.com>

On Thu, Feb 08, 2024 at 06:30:02PM -0600, Bjorn Helgaas wrote:
> [+cc Pierre, author of 35ff867b7657 ("PCI/IOV: Serialize sysfs
> sriov_numvfs reads vs writes")]
>=20
> On Wed, Dec 20, 2023 at 10:58:12PM +0000, Jim Harris wrote:
> > If SR-IOV enabled device is held by vfio, and device is removed,
> > vfio will hold device lock and notify userspace of the removal. If
> > userspace reads sriov_numvfs sysfs entry, that thread will be
> > blocked since sriov_numvfs_show() also tries to acquire the device
> > lock. If that same thread is responsible for releasing the device to
> > vfio, it results in a deadlock.
> > =20
> > One patch was proposed to add a separate mutex, specifically for
> > struct pci_sriov, to synchronize access to sriov_numvfs in the sysfs
> > paths (replacing use of the device_lock()). Leon instead suggested
> > just reverting the commit 35ff867b765 which introduced device_lock()
> > in the store path. This also led to a small fix around ordering on
> > the kobject_uevent() when sriov_numvfs is updated.
> >=20
> > Ref: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/=20
>=20
> 1) Cc author of the commit being reverted (Pierre) so he has a chance
> to chime in and make sure the proposed fix works for him as well.

Ack. I'll also Cc Pierre on the v2.

> 2) The revert commit log needs to justify the revert, not merely say
> what the proper way is.  The Ref: above suggests that the current code
> (pre-revert) leads to a deadlock in some cases, so the revert commit
> log should detail that.
>=20
> It's ideal if we never regress, not even between the revert and the
> second patch, so it's possible that they should be squashed into a
> single patch.  But if you keep it as two patches, it's trivial for me
> to squash them if we decide that's best.

The deadlock I hit is fixed by patch 1 alone. Patch 2 is a separate
bug - it's better to update the num_VFs value before sending the notificati=
on
that the num_VFs value changed.

I'll add some more color to that commit message too, to differentiate it
from the revert. I have no issues if you eventually decide to squash them.
>=20
> 3) Follow subject line convention for drivers/pci (use "git log
> --oneline drivers/pci" to learn it).

Will fix in v2.

Thanks,

Jim=

