Return-Path: <linux-pci+bounces-13423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803C198432B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 12:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DAD1F22FE3
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADB3170A3E;
	Tue, 24 Sep 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqzYzQp9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059B170A3D;
	Tue, 24 Sep 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172506; cv=none; b=ELrymS5/B6bIsXyqAZPv5jwwdNtWCKUV+0eajffPwyJfxfsBboEJxl3nGFE9de4lW13/VoCYZjdpHaJGMLd8s9ttA+SM+dDj02BU1+xMUTuaMauoLZ62VW4+qVyu94Mbz6MeUu7tngTo+voHZiFQPTsiNpNtIj1+be9Q/3/eaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172506; c=relaxed/simple;
	bh=qjRcD8XaCQtfC+CXj8B3RS3iMr5qqtfxn/9w1+Vpwoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVMhjtNoPK6CjHQkBb4NhrZAZqCrjeHg7KLArTO23b9QlmjBCIHt3K77P2OZaMy0q4iK6Xj6spwN0r3wFLJivU1lpfDtsXWR7uU5X2dtLX6VqwSY2tFIGkpoV3dijo6J5OaKxqQRjcOTdqs4cD+FuMAwB8CuY4RzCFU6c1TqEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqzYzQp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6654DC4CEC4;
	Tue, 24 Sep 2024 10:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727172505;
	bh=qjRcD8XaCQtfC+CXj8B3RS3iMr5qqtfxn/9w1+Vpwoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqzYzQp93dGUwuK3crgxPjosYaZsJEloYZeMqEihgotzZQM/CDv8CASzjYnufILO5
	 taIViMjN5jBlchcv6+6gBgO/UxbQbixJvRaO4uwSENJ6IYUPZjYs4nw6NxJRa1MmRa
	 AjrKROcGgot0hbWzNsynhn72O8xNROSGRUMMAzlm2ilYTLu4FIefRlrh2MCwAZY1l1
	 JEunDpHWEfS0EUeDmr9/MPgYV/zsQ5yB4UhciO6ZVy0K5bmj6Y7juXBbtiVcx7++ex
	 EIPfX47cskTKbsSMV/qGaPYbgpu3LMhRX7iZhi2W6aCfVBLKzh6IvnmlSQKsGTjJ3X
	 VK7f45vLMyBSg==
Date: Tue, 24 Sep 2024 11:08:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, frank.li@nxp.com, robh+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v1 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe
Message-ID: <20240924-ended-unlaced-cc7ddf87af90@spud>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QPsNdq4s/PN2L3Fw"
Content-Disposition: inline
In-Reply-To: <1727148464-14341-2-git-send-email-hongxing.zhu@nxp.com>


--QPsNdq4s/PN2L3Fw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:27:36AM +0800, Richard Zhu wrote:
> Add one ref clock for i.MX95 PCIe. Increase clocks' maxItems to 5 and
> keep the same restriction with other compatible string.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

It'd be really good to mention why this clock is appearing now, when it
did not before. You're just explaining what you've done, which can be
seen in the diff, but not why you did it.

--QPsNdq4s/PN2L3Fw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvKPlAAKCRB4tDGHoIJi
0gdqAP9OZE7f2j2BJ6kK0OX4ojssKFgoNCVvarSmVjUoswwluAD9GJRlsy4e4cVO
V+bFllNycrn9H5nOyRGfT0fu8JdWTw8=
=I93h
-----END PGP SIGNATURE-----

--QPsNdq4s/PN2L3Fw--

