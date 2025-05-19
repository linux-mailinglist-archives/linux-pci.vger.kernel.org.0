Return-Path: <linux-pci+bounces-27956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42351ABBB90
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 12:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81DB17C01C
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6C1F5833;
	Mon, 19 May 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="fe2phNgz"
X-Original-To: linux-pci@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABECB67A;
	Mon, 19 May 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652313; cv=none; b=r5l1fTQewbFB4ZPmE0vS9eegW5FUluvuafCEZTi60CdItDlqy4n4GF6xQlI5gWpPKPoyPy8DkNK0WFuOVoPTgMg+jni7c3ETUq1f6LdNmoainue3WPjFz6If8ZJKVeNBvvZ2Hih+W1Pz5IKE5Mc+gNePkPBieDxLjD1C1tRdVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652313; c=relaxed/simple;
	bh=lR3ufQjfCMt0wa1qQJnPCIl39LwV+E/PY8mCye8iihU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb78aBP9NoZbIu88d9+RhN9HIb3O19MWWZAQorVbmMHB3UeyhuyVPUAmPKKPZNxlc4HEGw5XteTu2xMvXPmLlRHWVyIycozUvArXmD6TkcpUCffBvhrLEOTfqpiCPvhcGIY7dsd1nPyfJtkeCVOCsE0Bfu/VkF6+TrjPphExJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=fe2phNgz; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8A5411C00B2; Mon, 19 May 2025 12:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1747651890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqHSHMNjwPahuHRb2M/03gC2UK+sZwBdUQwHO3smOZs=;
	b=fe2phNgzKQNmp8uKjoSeP53Hj3aPw4ryW4AhnKgHl9OELLyCaJ62HkTIhxy7TuvIp2+bn9
	KMzT35GYGQfU10PxHPtLaYNH8ntH1nPWYJrbhHWSLQ/gip26CAGLtQgMmYr6qdc0yyjy3t
	Fh2QliFEWwV2qot/FI59YjG2w+0rRaY=
Date: Mon, 19 May 2025 12:51:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Hutter <hutter2@llnl.gov>, linux-leds@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	mariusz.tkaczyk@linux.intel.com, minyard@acm.org,
	linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 RESEND] PCI: Introduce Cray ClusterStor E1000 NVMe
 slot LED driver
Message-ID: <aCsNMvfSWptltx5k@duo.ucw.cz>
References: <553813b6-1d44-488c-b41b-4be08e1c1733@llnl.gov>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0WdGnjK/qdBFyct"
Content-Disposition: inline
In-Reply-To: <553813b6-1d44-488c-b41b-4be08e1c1733@llnl.gov>


--/0WdGnjK/qdBFyct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
> The driver provides hotplug attention status callbacks for the 24 NVMe
> slots on the E1000.  This allows users to access the E1000's locate and
> fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
> entries.  This driver uses IPMI to communicate with the E1000 controller
> to toggle the LEDs.
>=20
> Signed-off-by: Tony Hutter <hutter2@llnl.gov>

We have LED subsystem.

> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -231,6 +231,27 @@ Description:
>  		    - scXX contains the device subclass;
>  		    - iXX contains the device class programming interface.
> =20
> +What:		/sys/bus/pci/slots/.../attention
> +Date:		February 2025
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		The attention attribute is used to read or write the attention
> +		status for an enclosure slot.  This is often used to set the
> +		slot LED value on a NVMe storage enclosure.
> +
> +		Common values:
> +		0 =3D OFF
> +		1 =3D ON
> +		2 =3D blink (ampere, ibmphp, pciehp, rpaphp, shpchp)
> +
> +		Using the pciehp_craye1k extensions:
> +		0 =3D fault LED OFF, locate LED OFF
> +		1 =3D fault LED ON,  locate LED OFF
> +		2 =3D fault LED OFF, locate LED ON
> +		3 =3D fault LED ON,  locate LED ON
> +
> +		Other values are no-op, OFF, or ON depending on the driver.
> +

And this should use it.

Best regards,
									Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--/0WdGnjK/qdBFyct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCsNMgAKCRAw5/Bqldv6
8gL9AJ9ioZr4CiKLusY4swf/Km1O2Q0M2QCggc56FgkysxptA3E0mCfEeZhf3o8=
=9ag7
-----END PGP SIGNATURE-----

--/0WdGnjK/qdBFyct--

