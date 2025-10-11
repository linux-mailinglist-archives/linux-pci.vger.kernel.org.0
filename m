Return-Path: <linux-pci+bounces-37844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FEEBCFB63
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 21:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A97204E1A3F
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A425C80E;
	Sat, 11 Oct 2025 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="fxb7nKp+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B1221DB5
	for <linux-pci@vger.kernel.org>; Sat, 11 Oct 2025 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760211301; cv=pass; b=p/bAi0sKrv5+8jlmo3q3YuL2bSUbbCNWXnelG+uyZoYuYW+JgHnb4qlym1N+hbDVWX0pxPsiOK7ifyHQTp6oStwBUCzusbmQHntxj+LbmA6ElcYX8w6raVMdjhOOcpcqYK0JE6kF3R7oCuNlUdA0zIJpE4qRY+JAhrPrp8K4oHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760211301; c=relaxed/simple;
	bh=nNNzvGymUgpkTLqMXCbw33PLf4NbEnWrMjuFoCQsc/4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=oPufpJez09MA4IBPKNiF5aiajiPYE/3lf5MnmmSh8T0XKmjMukOS/6gsKFkHcuyN3GkZFFiCZfo9g6maHJ0QT/4dXEMvpquwQABbm2R03LZ+WUp5Q3fqTcQwd3z++XLfsOx2p/6MPo9BwYkPmTv0Nhc/jPoh2jOO//cHn2G2GQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=fxb7nKp+; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760211278; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lgYA8lnrYtrmWdmT4OJZNikzxIzrBM2oPmGuHHHdSjrYIRMFMGYEbFF6CYvveKe9KC
    rw5ZBzt7hCjq/+PWF/ZPsnWjOL9+Ra7GxnPLvsyJ+Oy03ONrWPLeuNC6ynyQJIxmgUDm
    1ffql/jlfhELGO1e++wtWhu/iPIFrcGitEkdAb4hj7iD3Ak/d44AWk9FbVmZveMlWZ+a
    UsKMDecht9c6BjaEhAknUXbDf+OvqcQUsJ3ec8+yoSiZkW0tuPKJfS7nKCj8nj5tMJxM
    y79QoLnEHpO4uYVoo5njJbDBBc5YrhLUgV3EKo1qUxBY3Q2DNjXdwaSdc98z9GmR93hs
    CM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760211278;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=nNNzvGymUgpkTLqMXCbw33PLf4NbEnWrMjuFoCQsc/4=;
    b=AgxgZA7egXgHuAzYC5oak0svuiYxixPvPVMqEcV0SnfmvdYFzixbF8CyRNXG4mcV6Y
    dllPv0Uo8YtV3lpABvTk9mDkMJFTZlZU1N2o7t8QxVlDmPSmeED86PTBOj2kijj2HYaO
    BmH4B+bygbzCPIZXAjm/fE4JZR1EsHUZwhTmeIoJfXgFAuq8CR6Tw9ZYnCFVtQu9xOXi
    BYKAaJUVWlX34ODHxaUWAYBGwmJjAwHoEq4dw5Euqslg9mtJqA8U+gL2pjz/n9IHPmId
    mtdIX2/9NAnPw9dXrBrvy6CxzBbcFzOtXY8uAPvNJzOl9M2hMKdpEfv5+6oy7qogACHi
    EalQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760211278;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=nNNzvGymUgpkTLqMXCbw33PLf4NbEnWrMjuFoCQsc/4=;
    b=fxb7nKp+x06mqUB7s6SAbzZy6BXTqFhKI71EiWvabEB72lOTXCanc+YR7mrTF7vnsc
    8M8jbRbuSrTFeQwWgi5lrzqZEq1+T9fCgRa1+Q1y6cHJhFLnNIzhN4U66hnlcIurkEXW
    NXGaBPN//F8DXi5Cna+zhPC9lkug5k+IsFGZnA3+RxszbqWBP4vFxyZkVlfHZIOLW7tx
    g/oeWSDKRFKERNOkWF0e6feeXsl17QDNqQjWe1KFV3dW0dMOwStJ5BwGIvZXp5l1wD0W
    Ee4FZlvfPGYuqY/8AKO/v0+iLyjuoxQfcqGMk4/+V6+Hk6cVrvrFnxclxX+ipy2IwgW9
    gaeQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5m3symQCXjUqyw7o0hpeQmgGSciaK9CTQrlRvQ="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619BJYbI1h
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Oct 2025 21:34:37 +0200 (CEST)
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
Date: Sat, 11 Oct 2025 21:34:27 +0200
Message-Id: <10994220-B194-4577-A04B-EBC5DF8F622F@xenosoft.de>
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


Hello Mani,

> On 11. October 2025 at 07:36 pm, Manivannan Sadhasivam <mani@kernel.org> w=
rote:
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

It=E2=80=99s the XFX AMD Radeon HD6870.

>=20
> Christian, could you please test the below change and see if it fixes the i=
ssue?

I will test it tomorrow.

Thanks,
Christian=


