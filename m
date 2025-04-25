Return-Path: <linux-pci+bounces-26762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B4A9CC05
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1844B3AF29F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BA2522B5;
	Fri, 25 Apr 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKl8NZlw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D428EC;
	Fri, 25 Apr 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592516; cv=none; b=sILg/0P4FIUwJQ5Y0tMyL4cYd2n3we6VUNe93pHUqJVObsTpvKg3CtKXysuj8oF+MUUxG5YLU8YVRXQ5bkt4AOyOKMje+xIKEel0tYS3yVdt4UMKHZ88KS7tMfT6ZMtjoEl1XmHB6BAq1kUiz2Dh3D4rQt+kp6WmPN5R3Re8jrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592516; c=relaxed/simple;
	bh=KDUox8GA2oucW2IHvoNGUjFxLfRIXY7o2PmS3rDE6Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6Bl1qGGuxSL/Rc97g7SXt38V7NTmTAp09+W5G+IVmOrddZGPOWqtDLUHeBCZxlLGLKWQTZgo2l/08/xTEPDgtacozLqgLQfzm+6mm+l9GmrNGyY5lO7ON7sHvueOzPNDMGDPVwaOJ3vXnDQdfHuka16zR2Sa6eYTR09ptc8ZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKl8NZlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4DBC4CEE4;
	Fri, 25 Apr 2025 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745592516;
	bh=KDUox8GA2oucW2IHvoNGUjFxLfRIXY7o2PmS3rDE6Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKl8NZlwLRlW4kpoxJ4k+RzyAk1LXABalhUzrvYuCoSB+Db10S8lovwARF9uHS4cB
	 fsgaTbEHIP2DU0rgG95WyvS8Fr7c63gTz0JcfbfJn3dAYB5IOpo1FEFx4NfyM3CYUD
	 XbmLF1HSr5KTYfwsdRgcpIAc7SYei6U0RikIzbVFFhUvlHJExJlqQZaDFbkKCubkmN
	 If4zJcguSfsJcALucDPzyWzkbY+fW+3VMVugnNhqMJiLitiGQnpy6v7HsMXDBqW6Gx
	 2daAJnJCJ4RScpg2f6+vV3cxHnhoFv8Ak+DJssf34e3ltPzY1Dgn6tOqIxYidP2dsl
	 +HelGIKwFuFvQ==
Date: Fri, 25 Apr 2025 15:48:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"peter.chen@cixtech.com" <peter.chen@cixtech.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
Message-ID: <20250425-drained-flyover-4275720a1f5a@spud>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-3-hans.zhang@cixtech.com>
 <20250424-elm-magma-b791798477ab@spud>
 <20250424-proposal-decrease-ba384a37efa6@spud>
 <CH2PPF4D26F8E1CB9CA518EE12AFDA8B047A2842@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YSHiTXw2ppnu3Qg2"
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1CB9CA518EE12AFDA8B047A2842@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>


--YSHiTXw2ppnu3Qg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 02:19:11AM +0000, Manikandan Karunakaran Pillai wro=
te:
> >
> >
> >On Thu, Apr 24, 2025 at 04:29:35PM +0100, Conor Dooley wrote:
> >> On Thu, Apr 24, 2025 at 09:04:41AM +0800, hans.zhang@cixtech.com wrote:
> >> > From: Manikandan K Pillai <mpillai@cadence.com>
> >> >
> >> > Document the compatible property for HPA (High Performance
> >Architecture)
> >> > PCIe controller EP configuration.
> >>
> >> Please explain what makes the new architecture sufficiently different
> >> from the existing one such that a fallback compatible does not work.
> >>
> >> Same applies to the other binding patch.
> >
> >Additionally, since this IP is likely in use on your sky1 SoC, why is a
> >soc-specific compatible for your integration not needed?
> >
>=20
> The sky1 SoC support patches will be developed and submitted by the Sky1
> team separately.

Why? Cixtech sent this patchset, they should send it with their user.

--YSHiTXw2ppnu3Qg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaAugvwAKCRB4tDGHoIJi
0gB5AQCACzFzQHuCqe72kGCjbhOhwAatlY537t14V31mwO9lzQD/frLiUHnUcp99
02MWIHJn51Re+9M9sdIohy0Q4dXCsQ4=
=dfKM
-----END PGP SIGNATURE-----

--YSHiTXw2ppnu3Qg2--

