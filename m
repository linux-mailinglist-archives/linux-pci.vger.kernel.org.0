Return-Path: <linux-pci+bounces-37719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48690BC60D9
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6063519E2407
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BCE2BE03C;
	Wed,  8 Oct 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="K37BATtv"
X-Original-To: linux-pci@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E4A2BE03D
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941646; cv=none; b=Z5rc+O2wvL2KgUghXWfGQ2M+j3LpGRqzDPnF6ksj0Y+kyWLOas9RFZ6QWVJMNYZbA+I3R3mwQ3OQGKdOys1wGVvl7xzdD+I0Sou9M7+7QmqDzLrcmVdKaSplIdDsLl+kCsH9Aeq5bx7qX4ufD4lhWm6R8d5l9w5UrQZz9iXoL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941646; c=relaxed/simple;
	bh=kolqMjWkmgQI554o3kJICAnGaToFxd5aHeIohtAWxNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4qceHyk5xhUtOupzl47ftoKWnltHgIjbfoMLKGmFldg/675n3oKgFEH/LPT1QpDnGwhVjSA3UVNfP5SBrH93OskOTPpOWm1MBoQkLFU7IV8TYuztVeGe/5dMMPkX0hg89iwL2bI5bh1Aqy08B1FGQBLJjlVKVHbZKgAPjboz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=K37BATtv; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=58sd36tFGVnNXqqC47refmJdy2dXlmsovJ3elpdQM44=; t=1759941642;
	x=1760546442; b=K37BATtv6wkjunb1sfIYYeKKsVogDME+9yid3Jp2DgWClOEwqjXsKWc0kWusE
	virbv8gVfX8SMa7YA3GpnbfVa1mZ8FB2ijVksoVPo5RuSHASnlCdwoEGU+xAmOXC45AXkqZ+teqEX
	JCJCpoK/WuTVP/hS9gWT62NsPrkao26NmLR8R3ULH9ghx9ZhNsKH+0fy6hSXyMTBVmf+3RTT40HiS
	oS2uib5Y8dDvHZdUxyUOULdsu7Btj1qSWsR0DTNubWtCpdtIUgsInGGf0p/n1z/87NbhmHEFVDkki
	iZ1zjMdaHc+P5UMxJ8IviWkVKfLClCXSdSs2lBjwr44om+mqzA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v6XDN-00000002lpi-2vfv; Wed, 08 Oct 2025 18:40:33 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v6XDN-00000002XNX-1uAx; Wed, 08 Oct 2025 18:40:33 +0200
Message-ID: <3574beaa3ae41167f8a7f3f32b862288e7410d1f.camel@physik.fu-berlin.de>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, Bjorn Helgaas	
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Cc: mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
  Christian Zigotzky	 <info@xenosoft.de>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, 	hypexed@yahoo.com.au, Darren Stevens
 <darren@stevens-zone.net>,  "debian-powerpc@lists.debian.org"	
 <debian-powerpc@lists.debian.org>
Date: Wed, 08 Oct 2025 18:40:32 +0200
In-Reply-To: <db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de>
References: <3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de>
	 <15731ad7-83ff-c7ef-e4a1-8b11814572c2@xenosoft.de>
	 <17e37b22-5839-0e3a-0dbf-9c676adb0dec@xenosoft.de>
	 <3b210c92-4be6-ce49-7512-bb194475eeab@xenosoft.de>
	 <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
	 <87mtma8udh.wl-maz@kernel.org>
	 <c95c9b58-347e-d159-3a82-bf5f9dbf91ac@xenosoft.de>
	 <87lf1t8pab.wl-maz@kernel.org>
	 <a02c370d-1356-daac-25c4-02d222c91364@xenosoft.de>
	 <87ilwx8ma5.wl-maz@kernel.org>
	 <d044e62f-c7f8-4ec7-dbc6-ce61767e295f@xenosoft.de>
	 <0baf0f26-ab82-ca19-ea9f-7f461ce32aa5@xenosoft.de>
	 <db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Christian,

On Wed, 2025-10-08 at 18:35 +0200, Christian Zigotzky wrote:
> Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
>=20
> Without the pci-v6.18-changes, the PPC boards boot without any problems.
>=20
> Boot log with error messages:=20
> https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_c=
hanges.log
>=20
> Further information: https://github.com/chzigotzky/kernels/issues/17
>=20
> Please check the pci-v6.18-changes. [2]

Can you try bisecting this issue? The commit you are referring to is a merg=
e
commit and contains a lot of changes, so tracking down the problem is not
easy unless we know the exact commit that has introduced the problem.

Thanks for testing!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

