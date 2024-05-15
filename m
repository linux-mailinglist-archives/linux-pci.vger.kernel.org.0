Return-Path: <linux-pci+bounces-7528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A648C6D16
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 22:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DBB2830FF
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F615B0E0;
	Wed, 15 May 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="B0RN8miP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4615ADAC
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715803821; cv=none; b=XTBs3Ni490qc5gWTc/FoqM+sBwYa+JUIfytfpDhGoi4GqlKOezeX8HK608ncZpFnVRSZpvZxtwalcQRfzWHyN0gFP0PAyTso2TgHCVN3l6vYSkAKyHcxvFu5htwrO+B/Xxs4pSYvqgyzEVwlOCobajiFUCtqo7WUf2Q8z75TJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715803821; c=relaxed/simple;
	bh=s9TT8lsoEBdBtea51Akg86AkRCWiOEUvW+YMSo1GYDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvgJBypcSkDUoTrOlrSHyQb8HrwH3uAawA5xGGj10sg8oRBaSulvt2ZybWPazgJouNekH0OKY4y0CwdqqeXTp66m4PT+etn3FgiNBQQB/bUroNFB0cxtjeUdy+t5WTScDA9Lq11wXhIJC724d9CNBHTfVeHzWSFv0LeGQamS0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=B0RN8miP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=8FXO
	08frs4hL17ofURhVpLDRG7xWgW1nb8MJfzBWYkI=; b=B0RN8miPsk0F4nH2tSfi
	lGU6g7eRdF0cZB/w1chizm282Fvx7j5wWm66d5Ty68dz5G/3XH+sMd/0MQJhOiJF
	sHFd78LujS2BYJh3NYCy4ZKgWKEdPguQRNbP85GwhyfGGUjZZbbsiM9zReplJGLG
	FYww1wd9mAPitw0rZczzyPIP/nxoMAvUKzZzRMDZhbExBIGRRR0MN2z8pKqBnvHm
	Mcz6MYSeJOnCprSDfo8IWPHOyPcEG1dAuuOt+aYwdKBOQeL2jHp6NtfMXbKXJAKo
	THeSzJx3dDaziqeJAlB8LUkqi2v+IL6TFtEbqBnyQ4u1mh+jtKF8/lju+zSizW2v
	CQ==
Received: (qmail 2935422 invoked from network); 15 May 2024 22:10:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 May 2024 22:10:14 +0200
X-UD-Smtp-Session: l3s3148p1@8mvetIMYjIdehhtP
Date: Wed, 15 May 2024 22:10:13 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <53sfkav45djcaapqkzsps6ofsinf5lnxbhrjvgsevt3w6qcms6@e2vptwrj645q>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-7-yoshihiro.shimoda.uh@renesas.com>
 <20240511080257.GF6672@thinkpad>
 <TYCPR01MB110409C8FC92A7C466627E0A2D8E32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <20240515075954.GB4488@thinkpad>
 <l62l4ksr2rkxxi7kwatd3pfwmwv4ytfumhwkthjsurgla2prno@felahg5h5g7o>
 <ZkTiGWxJK4tbOF5y@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bwr76ejofef5m7kw"
Content-Disposition: inline
In-Reply-To: <ZkTiGWxJK4tbOF5y@ryzen.lan>


--bwr76ejofef5m7kw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> If Renesas could bother to spend the effort to be legally allowed to
> include the firmware in linux-firmware, do we want to spend the effort
> to maintain the support for this PCIe controller in mainline?

We (including me) have no indication if Renesas bothered or not. Maybe
they tried but could not convince a third party. I don't know.

> Is there even an example of a device driver that *requires* firmware
> that is not in linux-firmware?

Sure thing!

=3D=3D=3D snip here

$ cat Documentation/admin-guide/media/opera-firmware.rst
=2E. SPDX-License-Identifier: GPL-2.0

Opera firmware
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Author: Marco Gittler <g.marco@freenet.de>

To extract the firmware for the Opera DVB-S1 USB-Box
you need to copy the files:

2830SCap2.sys
2830SLoad2.sys

=66rom the windriver disk into this directory.

Then run:

=2E. code-block:: none

	scripts/get_dvb_firmware opera1

and after that you have 2 files:

dvb-usb-opera-01.fw
dvb-usb-opera1-fpga-01.fw

in here.

Copy them into /lib/firmware/ .

After that the driver can load the firmware
(if you have enabled firmware loading
in kernel config and have hotplug running).

=3D=3D=3D snap

And this is probably not the only driver where you need to get firmware
out of a Windows driver (media drivers and webcam drivers are good
candidates). And the redistribution of such drivers is likely to be
limited as well.

Happy hacking,

   Wolfram


--bwr76ejofef5m7kw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZFFqEACgkQFA3kzBSg
Kbad1A/7Bk4NUul1dwzsSaW8EpeJchgIZuXPrS43xegnTA3B1HbO6gCsdplAZ8sc
V2X9FBEguM3p4TIFIVasgxPYYars1xVtwVPwFiTmhIO6pJSOwQaZc8zWZnPBXNEK
2hC5SyJqC0E5paMmFXD5iEhPDaO6JimOaI3hp2fR8FyqqXngEjB21A3bkfEeBlEJ
/2lRT30UPnlXGfu3111MipK+sM+xBUClv2ZjItFi97fAfkn6q8dERedihkAP40Kg
9rpz2O099S9QMUnJwxqnYF4pz7v8OISBCQ6QFoyCU+nTjNkFyM85wNq4gHaYO5h0
aB5fh8b/w5LT4fVbrWSLfOHVNOInfMsLQJKiFjzgZoZcZ/v3KsxPiFjnVbekvzFv
sqT2lfVzxb5yfn2o4iDdkx7m1fwv8nSfSCdaIOJ6fuh8FPI5UQrvpZ4HRBIQJFQG
FHCtRq9W9Hl55ickgZLekwv0TRjF8xtfiAarmQBxrXcCwdETODa+UZPe59EKuMCh
BbKyRADkTkx/z7LG2fIiSdlGNCpOm6s1z2Bnl4cNk6JhA7mIfULG3NwTX9a0Dx8A
BiCsCXDJ8k20QbWxBA9P+oe0qHJAn4nz8ox9jVGleJgPO/ghvkn5wkabwy7S+xGf
vpQlO1tb+R1k5t95ARMWyacEHo3zQpm9eGWngzVH+JolKWeMwPU=
=Fgq4
-----END PGP SIGNATURE-----

--bwr76ejofef5m7kw--

