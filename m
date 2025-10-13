Return-Path: <linux-pci+bounces-37866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D177EBD1641
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 06:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DF9C346514
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 04:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98423AB8D;
	Mon, 13 Oct 2025 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZFXQUgOa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C166286410
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330814; cv=pass; b=Y9P4mck9BwvTK6Lc7djPWps0F1A63GQywefjKHy6JI4FZkkbDLO+EfHnH4M9+I5xUY5NiWWjEY+evwVOfm+wkithjyCb66q3JVHU1xTHvz89oc+2oGSutZ5iKcFUkYOcAa6RghqY1HxIkAjLWFBcfq413G12getX5pxnrgBNHhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330814; c=relaxed/simple;
	bh=/sUZbUC/NHx+EHE+TODSDoPxe7p7A45mWhxaNP+gbdc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=FtAMpyzFAU8ojxMzhstrTMid6U6unjBAYoEMsImuzZVnZ5ntAnIWgR9aPoYhU2PgPbiSKNmDkbpzW8xiVWoUogk149OtRk1uASpXH2XO8A1tTIBy/nGDfJXWa42vpOdJ0Oa7FD3HZkxu47SfolZ8rYz30odxJmtZl2kbSvPYX30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=ZFXQUgOa; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760330785; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ntccy0sy0hg9HwaKxQC5hSXVG7QYcmlmpYTjKmx/no6BHi3ws1mokKGIN68nPhWkuU
    f7qgpxXYcJhaRXCqlkSfoSj9Xzz8LYAkXqmsKSkIuMe68sSVF08H7T42KUs54yxdRm0e
    IpIUj12V2qHcN5rUv7ImsIuHitjdekt4ORyQ3K3Ro0JSL7aCnmok3FCppO6irS2eGEuQ
    TgSXKQ5qyTgDLWvDCZF0230IN2x8DUIQ+Bj9+IqpY3YHh9EPDekhMxR/dV9q92zr2zpu
    7zEp1sPYM/QiA1zV1jdpeELm4ZIEzjrxMSHtKU4NFlNlRp4ecIJKHf4jqECW/70Co8og
    xeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760330785;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=fZxToLjYnoS353OgzuhhmLgCZy7eCZMC/R02n7ti78c=;
    b=BrTyVuBWxP2HLFQxcOmsVBXOSBEkLHFYVbCPeAsAEhcOCB4H/u6GeZrlBADbUM2u6k
    ERS+gR6tYAt6ZohKsKlCvRu+AkoykERVn+CxdyzsHZq7bHhof0Ualmqm4W3s2fk8S0F5
    sunx6KHBp9n4UPgNnOt4Sy5UgQgNe1ogiuTU3v6NWx5q6+Dlu+kJIOSlmXps5i/kGAu/
    Pgo7AK/W4cw3z2Oh5FUEnC9Sq41yQxPCb7EdDARHS3dZ5dQGpfkCNvqw5yZtv2gslBGW
    mtQrPXD1y1nxSafStc3DDgYpRtss07HkjwOwjSIcjXEe9Qlpa8xLmGDROCpw994A0nGn
    vwBg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760330785;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=fZxToLjYnoS353OgzuhhmLgCZy7eCZMC/R02n7ti78c=;
    b=ZFXQUgOamnBtg8JQMgRsZfVbbGPDsqmHsUTESTBkXnrvclAtNnltdjwAKrYIPxpyWl
    voUdCUIBiM307ie638VjS1esWBTPC1cKe92Y949Q7hyJkSY+bCkyS+m2siadD//Hm8f8
    lXxxf7vB8jN029wDaYRB1/MpoB0r7oAwSTvjvalrIgd4De7dCV8vO64BfzO2jbIC9Nia
    CFnR/h24XwKSCTIv67Rn9aVSMCZPPSL+mhNtzihOkaxQHwmd1GkBy7hIw1MMAXOYENcU
    G9+RD8VRwmWddrbWvm9sfxclkfSooFnnQlr94e03xdn/V8O0PqSqKgS8D7z/tAOCOCnj
    z45A==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5mws3+VAS+pE6REQPvdUsV9fT7R/x5YSqXopuk="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619D4kOKN9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 13 Oct 2025 06:46:24 +0200 (CEST)
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
Date: Mon, 13 Oct 2025 06:46:13 +0200
Message-Id: <0BE6C5AD-8DFD-4126-9B18-C012B522B442@xenosoft.de>
References: <iv63quznjowwaib5pispl47gibevmmbbhl67ow2abl6s7lziuw@23koanb5uy22>
Cc: Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org
In-Reply-To: <iv63quznjowwaib5pispl47gibevmmbbhl67ow2abl6s7lziuw@23koanb5uy22>
To: Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: iPhone Mail (23A355)


> On 11 October 2025 at 07:36 pm, Manivannan Sadhasivam <mani@kernel.org> wr=
ote:
>=20
> Hi Lukas,
>=20
> Thanks for looping me in. The referenced commit forcefully enables ASPM on=
 all
> DT platforms as we decided to bite the bullet finally.
>=20
> Looks like the device (0000:01:00.0) doesn't play nice with ASPM even thou=
gh it
> advertises ASPM capability.
>=20
> Christian, could you please test the below change and see if it fixes the i=
ssue?
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..e006b0560b39 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_de=
v *dev)
>  */
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_=
l0s_l1);
>=20
> +
> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6738, quirk_disable_aspm_all=
);
> +
> /*
>  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>  * Link bit cleared after starting the link retrain process to allow this
>=20
>=20
> Going forward, we should be quirking the devices if they behave erraticall=
y.
>=20
> - Mani
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=E0=
=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=AF=
=8D

Hello Mani,

> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6738, quirk_disable_aspm_all)=
;

Is this only for my AMD Radeon HD6870?

My AMD Radeon HD5870 is also affected.

And I tested it with my AMD Radeon HD5870.

What would the line be for all AMD graphics cards?

Thanks,
Christian=


