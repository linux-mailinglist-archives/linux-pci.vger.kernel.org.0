Return-Path: <linux-pci+bounces-40006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4647C2794E
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 09:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC323A3FE9
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE11A0BF3;
	Sat,  1 Nov 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="rho8inx4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1042264CC
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984009; cv=pass; b=XkwgmpMakyDTqzpCXU3u0OUADL2uN2Ww5VYcMIVyEEECRY1UgjUZU9j8hMG6lvd3AyTdRnb2/Km2n8GmIceBxiWT0K+kj89Kx6Sr6Fx+2YB/q/K5sA2sFbeB9Nrten0GX6UEA14koLK6lE5U7oXFsjpZ+o8tB4mPHAZTJv9gJT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984009; c=relaxed/simple;
	bh=XjP5x5Bgsvr5wyyEs5OOp+96vR7qcdY9kYxub87Mn84=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=bidchSsp89SG5gFuPeI4Vdx32lnhIA7Suw9oYKjdL5EM04AtSesvZuCU9mKamxz2Hc36smzeY5U08d4vRG9ysMFv2F8r4Mt62gMJJjPjPILPyoMKn9ln1OkS9nwIyqZW1LeSHYR0ECHAy4P02Ho8lC9gcp62wepa8O40r9+3oj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=rho8inx4; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1761983988; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kufDPCqeXbYJsOOdu0bImnvOK2gNUmSBIp44LrgnNbw2Ry3Aeo8XJl2UwWQecMbTRH
    7NwZqWkk7v0LmZd1WugxShkYzbGu3PDjR0AG9yz0BfXsZAz5A9/K9VqZdCyAEaaiglo2
    8cFaDivdFcFkPpJhW0PkhFwTEeEMqzGv3Kw/30tTb5+be6IQS1ZFjhvunZkUzhVuv/Bx
    cc1icUUYa+XvhorGdEUY4mqw71E2GHAGjOjJwC1rVhPxpOLjZlByZMxpyVKCUZPjvH0n
    /7VSKyyFvFBhZiIjX4rkiPBkHnZ4OTFqAqIjhplOrlHXd/WCaPOqkxRSaGJS5U0M/oxs
    ZN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761983988;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Date:Cc:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=+3zUXjN3NTSdTgmydFFZq3v8qUJDNiC8H0mmxBV6SGs=;
    b=JyRIx7E2YTEWOKv6FSLcd0vicxmYS2A4NYq08sUW05Tk+txajKh7OHXa+HbeDeTfYU
    l7gbTVfK/3d91BknF2sxWaKl153iaJ2EP3ncshFoKCaOVjxKNyfEgLMdfZdjyZDMk2Jo
    LlP5sDLOoakF9PE+/No0bj3cBDhDjUaQWsrk30GOOwxHmJIZa755Yv1ZceskwTsBgU2j
    Vuow7W2wigY1K1rBeVOgUa7U3lvMIKTzUCM/+VHy2qu6nXDorK1co2vak+vtJ3P/zkSs
    VOb1JPrnCriY3sRFLRyZaXh7oOxmp/v8IY8X7me8mbepCdWYFbphO13nMZ+Cs1TIwWj2
    +7MA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761983988;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:References:Message-Id:Date:Cc:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=+3zUXjN3NTSdTgmydFFZq3v8qUJDNiC8H0mmxBV6SGs=;
    b=rho8inx4rPVjAto+1VxN8lJscQ1smSsIPBGY8zHDOSafiS4+Mh3EUgQWJcEBakhy5O
    PIwItm069ecrfsxh6zZ2eVyRwqAVVpg3yE1nL4616em30YtTTJiEUUy+5uxSar0bIld2
    /NU4vNbnA3kSWe6N39U3NmwmHY0ATiSdD9TEguUiXY5v5CJFCtMxUATdKg+/Qlgmahu7
    JM2fI15BAL8cUc6uSR9TDzgA3mD2u9JprBdtxdw59lZdI3exTkKylYJAgr8YHQswVuhD
    v4d41zmwFB0DzfFauRDFlkWMocXdop3LzujIFjiLXBk1f1G4rEa0N5LnM4BEL8kJkBVf
    RQXg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7VZi2s3yVXnhFqLkx1Gy5BXrtBsVfqVNFrP47WD4="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e288661A17xmX2D
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 1 Nov 2025 08:59:48 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: [PPC] Boot problems after the pci-v6.18-changes
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <545ac5c9-580c-5cf7-dd22-10dd79e6aabf@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam <mani@kernel.org>,
 regressions@lists.linux.dev
Date: Sat, 1 Nov 2025 08:59:37 +0100
Message-Id: <AEBA92BD-B46D-4D1B-A4D1-645B276E34CF@xenosoft.de>
References: <545ac5c9-580c-5cf7-dd22-10dd79e6aabf@xenosoft.de>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: iPhone Mail (23A355)


Bjorn Helgaas <helgaas@kernel.org> wrote:

Oops, I made that fixup run too late.  Instead of the patch above, can
you test the one below?

You'll likely see something like this, which is a little misleading
because even though we claim "default L1" for 01:00.0 (or whatever
your Radeon is), the fact that L0s and L1 are disabled at the other
end of the link (00:00.0) should prevent us from actually enabling it:

pci 0000:00:00.0: Disabling ASPM L0s/L1
pci 0000:01:00.0: ASPM: default states L1

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..27777ded9a2c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *=
dev)
* disable both L0s and L1 for now to be safe.
*/
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0=
s_l1);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_asp=
m_l0s_l1);

/*
* Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain

=E2=80=94

Hi Bjorn,

Thanks for your patch. I patched the RC3 of kernel 6.18 with your new patch a=
nd compiled it again. Unfortunately the FSL Cyrus+ board doesn't boot with y=
our new patch.

Sorry,

Christian

--
Sent with BrassMonkey 33.9.1 (https://github.com/chzigotzky/Web-Browsers-and=
-Suites-for-Linux-PPC/releases/tag/BrassMonkey_33.9.1)

=E2=80=94-

What about with=20

+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID, quirk_disable_aspm_l=
0s_l1);

?

- Christian=


