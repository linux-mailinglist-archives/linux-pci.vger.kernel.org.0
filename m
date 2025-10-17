Return-Path: <linux-pci+bounces-38423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA968BE670F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 07:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51E21354A92
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 05:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144519DF66;
	Fri, 17 Oct 2025 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="p4asQUKS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A44334686
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760679386; cv=pass; b=MDnrZcURIkCEfknDD7EC+uT+BvlxTXUWhfN0CBT/3ZYAzPiM+soZoAznjfi+tA85sos6gyl2i5VT9evDNlSLUbg56dW50DMXxS/OG1aTTsJeDr2pMDxwULWQ2KELQE1nhoHEirGtV9a+NEUzJHry+yRxRYGgVxuFGjniYg5PHkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760679386; c=relaxed/simple;
	bh=V1ftbw/xifrEz+CnZmZ9tWc6u8KjSUSp7/wj1ZCuhEc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=S9DeI8cdIHIOXV/2H3EfiVSpd0v68/b/0TmUQzV25yTN5h4wqqEUhzJcHeMmCFkMOLIN2ZBEcS2jXz/nTVRpY8ZR0C9Yo7LIwyW4Nc2mtaWNZ84jihtxBLLpR9iRFdz2EyT6wpPeHwXgBcKg3W3WZsVFkpZANLwdTipPRj1D+8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=p4asQUKS; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760679367; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nhaG7J1bL5R3UVYFEqUMyRAXLvDeOGEBH0GwwStIKRzZmitjWzfSLves0X4yemOq87
    YZqJk1mkqE5kxr6z0514MIlwXBikvZ54t/iv81jO0s8ucf8V834VDayX9IUBmk442x0Q
    uxD6eo5d490H9ZOq2t4moBXoxmIc+HIeUBYSoS0JnkgXUY8/FcEINvlZ8WnGVm2JiblH
    ReMZB/Og5GDX47qHHJ1XiAwOIP5rywE5jpkuV0ZVmnV0xOXS2POt2Ogr9q372HHrZh7J
    nk2OzxYBin7HalI6pRKtJjwuOplT0CrMnk/1eZfwGUcJl8rnvpS4sra9yNf9jBpAE+0I
    jivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760679367;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=V1ftbw/xifrEz+CnZmZ9tWc6u8KjSUSp7/wj1ZCuhEc=;
    b=VD8MpKzJG0ZPaoQ+QS/m+C3DkxPsf+s3VSREIUyke9kOnWmzHbkczysz7kWH2BpdYz
    gQK5Y0/1QMfWE0/4UgomRUREobDn9yBNpKOk7YSfRb+sIfXW6yTykxfew0oKu80zZkxL
    LzbjeHtwIYYcJ0Q9PRvsIKBdi2uYyD+vsOgiScPiEgKSeGzbfMJ9MTXDDKqjrYF92xJW
    bCCJ4R/S/RJs3bO3Gc/qf1XDqqVDtuEJ2qo5AdoIRKRdrEWizM0OBTRqgFo213gFZNLv
    +LhlSdbnYC+7yx02yshw02AHZqe+RsLNYUNNk/t0TJy5C3l2CmiqWjCcZcE7yBKMCLRm
    YOsA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760679367;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=V1ftbw/xifrEz+CnZmZ9tWc6u8KjSUSp7/wj1ZCuhEc=;
    b=p4asQUKSpu5XH3qU789oDLxeuFzQF1kBnJlCSH87DZ2QghYoZVc3C8LR/rwDSn/QqS
    pCppXdOL699TmmGd2Eo49mJHjMPzYJA/xvRb7ur81NfidkYYNagDA/A1OMyqDZ/eIho+
    5mALXmcOKCC3vj0jnhP8PbqASVJa6ns27Oo5HOGf0lA45SetKR3Gzfv6dS2y0nqzZunq
    UD90Yn6Vhi2S1aVvSei29r1Bu60wQH56NVOCmUgQ2/JbrKWv1VS3H52cF6ub2Hr4DeOy
    xAMzhczzZKflh3T23PYK6udZN7mnUQiFvECvx9BMMgHfRbN0HDIDFVdnDvrzTPSeLXff
    0oIQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5mysy6RDnaymUgyFB+wT2Hhua3CmtV3D8PNDg=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619H5a6eqB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 17 Oct 2025 07:36:06 +0200 (CEST)
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
Date: Fri, 17 Oct 2025 07:35:55 +0200
Message-Id: <7110C357-F7D5-405D-895D-20DB5CBD3849@xenosoft.de>
References: <6E949EB0-CC46-4B08-80BA-706FBD23D256@xenosoft.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>
In-Reply-To: <6E949EB0-CC46-4B08-80BA-706FBD23D256@xenosoft.de>
To: Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: iPhone Mail (23A355)



> On 16 October 2025 at 12:45 am, Christian Zigotzky <chzigotzky@xenosoft.de=
> wrote :
>=20
> =EF=BB=BF
>>> On 16 October 2025 at 09:53 am, Manivannan Sadhasivam <mani@kernel.org> w=
rote:
>>>=20
>>> =EF=BB=BFOn Thu, Oct 16, 2025 at 09:36:29AM +0200, Christian Zigotzky wr=
ote:
>>> Is it possible to create an option in the kernel config that enables or d=
isables the power management for PCI and PCI Express?
>>> If yes, then I don=E2=80=99t need to revert the changes due to boot issu=
es and less performance.
>>>=20
>>=20
>> Wouldn't the existing CONFIG_PCIEASPM_* Kconfig options not work for you?=
 They
>> can still override this patch.
>>=20
>> - Mani
>>=20
>> --
>> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=E0=
=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=AF=
=8D
>=20
> Hi Mani,
>=20
> I will try it.
>=20
> Thanks,
> Christian

Mani,

It works!

Thanks,
Christian=


