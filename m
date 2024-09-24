Return-Path: <linux-pci+bounces-13451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4018984906
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000911C22BB2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E111AB534;
	Tue, 24 Sep 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ4yEG9b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E91E49B;
	Tue, 24 Sep 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193863; cv=none; b=b4dYwTtqYvvQ/f3cOuCWgBT1/ZI0U01RsE/oGb4qcm1kf9GNp6JNEMZbGSnckcgL1th8zQH6UBRj247RatNUNU4t40Ssk0J+vewLYM97H0g4wt5vj0UiIbI3762KvwHgtZNddkHGUrOCQquEocQA7JxXV6HATV0vmN9dPPZdjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193863; c=relaxed/simple;
	bh=U92bSuEAZjnU4w+FGU/py+Q//Fe1SulLSbofqyLyPhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6zkgSfnsr+sG8yg30oRKKMHlODM6SWnkt3/Qr9MlCCAqO0pmoghRFBYoAxWH5p0Y8ELHJCS9mmvG5bH5VoXh9ycOEBkvTUZiPF08eyOhR5ixNOBoEeDp6dUgm/2a7yl/ZkvXmsnX2YvkU5kMVaqWhGyuhqD7r7w5lYOz5j+cNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ4yEG9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A4CC4CEC7;
	Tue, 24 Sep 2024 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727193863;
	bh=U92bSuEAZjnU4w+FGU/py+Q//Fe1SulLSbofqyLyPhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJ4yEG9beL4nwlPOLmbryx5h75ub112hfFpa8teutRosJNeJVXJ0kWmX0xXWXITf0
	 bFJPKsJKg9Ks9T1cbndwhb8va9OCsjSgICncZG0raZWYqy0Ai6lGKts2zE8o6XrKZS
	 exvhIKnqi4iXflPDvO/ZKhFYOfPphrg8nK3xfZ76hr+XHfe239Hjq98QlqeQ3tDHZS
	 gg8HL9p4wSZChyjMFsh4sLv2yOAb77WsZ5E6kJP7c1JP2mvDlgHswDjq69vdMKb4eg
	 mCKQ4ZOLPCGWAEp8nbhOaR5y3Lk2KprJlVzJNlil4Ywhp6TPSJkbaMBTZVlUzkoCpe
	 0tVVNVvhCV3Jw==
Date: Tue, 24 Sep 2024 17:04:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	kwilczynski@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	robh+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v1 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe
Message-ID: <20240924-spoilage-fanfare-357c65b8418e@spud>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-2-git-send-email-hongxing.zhu@nxp.com>
 <20240924-ended-unlaced-cc7ddf87af90@spud>
 <ZvLZWqRFnAtgFo3B@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2y7ZEn7oTFy8mHq6"
Content-Disposition: inline
In-Reply-To: <ZvLZWqRFnAtgFo3B@lizhi-Precision-Tower-5810>


--2y7ZEn7oTFy8mHq6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:23:06AM -0400, Frank Li wrote:
> On Tue, Sep 24, 2024 at 11:08:20AM +0100, Conor Dooley wrote:
> > On Tue, Sep 24, 2024 at 11:27:36AM +0800, Richard Zhu wrote:
> > > Add one ref clock for i.MX95 PCIe. Increase clocks' maxItems to 5 and
> > > keep the same restriction with other compatible string.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > It'd be really good to mention why this clock is appearing now, when it
> > did not before. You're just explaining what you've done, which can be
> > seen in the diff, but not why you did it.
>=20
> Previous reference clock of i.MX95 is on when system boot to kernel. But
> boot firmware change the behavor, so it is off when boot. So it need be
> turn on when it use. Also it need be turn off/on when suspend and resume.
> Previous miss this feature.

Please put this in the commit message Richard.

Thanks,
Conor.

--2y7ZEn7oTFy8mHq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLjAQAKCRB4tDGHoIJi
0hOYAP0XcNVPuI7V62UHF/QiRSFVkV0CAHFfd9a51umMSxHx9wEAtYpToWp7Adbl
rLzKRXA23fuI970EAdxYZ8ZzmkY9rA4=
=Rfph
-----END PGP SIGNATURE-----

--2y7ZEn7oTFy8mHq6--

