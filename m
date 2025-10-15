Return-Path: <linux-pci+bounces-38250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7BABDFD32
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAD93BF0DF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14812CD88;
	Wed, 15 Oct 2025 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="XUVRtuVe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A898221DAD
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548588; cv=pass; b=KbCMzBWQHOvI1j5RIgre5qo+rTPpXpYfovG+q6C5OeL/TsI5YMK3F1G28vOfCAWj8GS4PeQLm2KvyI4UarcfnVrduq10gKNSPbOb3gHigS30Ntgoz4W8mWJNyJs/2RVtZak9rnUiyZnfgw28Gn6eccHC0HCj3CQIBne1H7SNK2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548588; c=relaxed/simple;
	bh=/gEiG0X0UAridMSchKU6avFHbRWdFnCLg53DADkJUdA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=TdWHg0vLP22NrbUUMDv3STPmIHiO1Yvnzh3e+G9nHcEi2c20qlIxkp589LE6eoZrCElkGQy79bxM5jBspq6ubhylA2vYb0DwcR0MdTNe3CZL3WW5l4y7ugVLtrKsKUDL4r8w1YycoGYmo/6Z9smYFQNT4RtVkUe1FzfMlGvgKGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=XUVRtuVe; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760548562; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dw2JzGlArfW5XF0MlYkXghfQgL+saubV1wh+ECcZC/0PQhNgK2Fgs9AsZymdoWLMWK
    i00i6DICzpBi4l39CFu60dIB0PjuXKC1BmchzV4UUCyp+HBCO6Tp1MyJ9IcwxoOCX23g
    P6UhMPBli2eDs4l8vx/Dqquh2DCqqlsHsZsWQFOcIoZ6GAsNxenbvO/lKxQTrAPgor4g
    GeBDoG957i6Dxidn3EbRLdp3KPnaJDpNltoLwzmG2XkE0zAMnisLAlC0RXxth3v8rW9B
    Xgt0jFnFZ7ZynTnqqUIrmtdUDAFZF9a4xWhIYBnDZbh5lsdif67cJ29foERnyVx+2WVu
    zckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760548562;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=mN7F9fEBnozfv11Tt5u96tzW+BvAMVreqPKTX7UG8vo=;
    b=V64mkKEJxTQy0TcuY0A5rEhVi0wcwQwJq5ccMPCE7mN0dUubSj+cG/eFLD/h35VEDe
    MunyqXCJbPC14fPRhbNH7Bp3shP6PJ+BDDRNzjlbxBwyhmd/rMgnlEFKwGa3EfuA1q1/
    eWdEOBKGOtbX9/nYvOjk8ry3Adxc3GtotMzfAHaSYbTlByfa9eiAVZDtIYmll6Jyuxy9
    MZPIgE6dVyVyOVlGFx+GqnBJK3plZwwp9SBbktSHkRFXvOeeG4PQS8HW+WCdojOC0kHE
    esEejWTykiRXYZJrWZpIQCsgSm029Sm7jq753j/nKEfekQV3ugT+J+xeCzlOO7cbXmId
    rCoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760548562;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=mN7F9fEBnozfv11Tt5u96tzW+BvAMVreqPKTX7UG8vo=;
    b=XUVRtuVe/N2UF+coE850spdKxjnk5mn2hfULUORgHdk30qOFmC4xlGcwJQfNXADNSm
    2Uk6s58wRGKoYs3p7iRWPtOAcWNqjtee1Ym3LOucdg90Nz3Rn99CZk7xRW7RJL/l3+zY
    Y0RjUSd+kgDuEgbbTwzvt5vf/mQYwdODk8IJjG42w4H3NgNdds/TNqDHxEhBG9enGu3g
    QvwCjpiJ+7zEfdjOAIZLlO3IW6qDynLLGFEzCRuZ3EGshZk/39iBJd5n5J3fN37gTDQj
    mXjdM3ekyxAvBWhQzTQp/q5mUURH+jy7V+0S/V9TmLBEe4EHMd8lT7cwyIgqpmyTAn7R
    1/Mg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5qwsy/HXXazq4HBi2zvo2F6xNGeYCT//RDyeg=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619FHG1YXz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 15 Oct 2025 19:16:01 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Date: Wed, 15 Oct 2025 19:15:51 +0200
Message-Id: <6A12CA6A-0798-49D3-A4AB-C2D5AD616F69@xenosoft.de>
References: <523e2581-9c78-4c37-9c97-578df079f008@xenosoft.de>
Cc: Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>
In-Reply-To: <523e2581-9c78-4c37-9c97-578df079f008@xenosoft.de>
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: iPhone Mail (23A355)

Oh sorry, it was an old Mail from Bjorn but the lspci -vv and the kernel con=
fig below are new. I have used the search field and open an old mail.
I have very small time slots and try to work fast.

> On 15 October 2025 at 06:55 pm, Christian Zigotzky <chzigotzky@xenosoft.de=
> wrote:
>=20
> =EF=BB=BF
>=20
>     Bjorn wrote:
>=20
>     Sorry for the breakage, and thank you very much for the report. Can
>     you please collect the complete dmesg logs before and after the
>     pci-v5.16 changes and the "sudo lspci -vv" output from before the
>     changes?
>=20
>     You can attach them at https://bugzilla.kernel.org/ if you don't have
>     a better place to put them.
>=20
>     You could attach the kernel config there, too, since it didn't make it=

>     to the mailing list (vger may discard them -- see
>     http://vger.kernel.org/majordomo-info.html).
>=20
>     Bjorn
>=20
>=20
>=20
> Hello,
>=20
> sudo lspci -vv -> https://github.com/user-attachments/files/22931961/lspci=
_cyrus_plus.txt
>=20
> Kernel config -> https://github.com/user-attachments/files/22932038/e5500_=
defconfig.txt
>=20
> I have already posted some boot logs.
>=20
> Further information and boot logs: https://github.com/chzigotzky/kernels/i=
ssues/17
>=20
> Thanks,
> Christian
>=20


