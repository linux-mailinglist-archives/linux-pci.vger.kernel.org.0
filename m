Return-Path: <linux-pci+bounces-8313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666398FC9EC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 13:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BAF2818C9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DD51922F6;
	Wed,  5 Jun 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXvanTAi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FEA49645;
	Wed,  5 Jun 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585969; cv=none; b=IguG7bvOn1mvxk2FUp8si5mTrOl7IqibKr5xldbr5qOCWt2/A8UavpnFvMJTW4HfSgFj139WIznbCmei8I0IfPJh32LUTF2fHCiy4f8BXXU1ymYdfWGvMbFqeUdsImDQSnm+6PmAWCzqPtIfuWjA5leV91hhE3w+SouPF5JjUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585969; c=relaxed/simple;
	bh=yYAj163noFkob5L7lXkiWLT1nMsl/P7iRUgZ6mMxCvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/r3kWxi2xCG8MAIY1VVw2Z9EgybVDDoP767z1HRJCDACWEWpVeeyLbateOhqauwcazigChQd4g5b985hp3PWyrIpkQuZeLgtqn5C8nMJQwBr69O5dKDVO+czkTc9n/e+gag9odWfLz6SqoBsSiNlQ92stc2HDI1yN6+SfprJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXvanTAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C4C32786;
	Wed,  5 Jun 2024 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717585969;
	bh=yYAj163noFkob5L7lXkiWLT1nMsl/P7iRUgZ6mMxCvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXvanTAihYAPX/RJQpmYDHZb43VOd2kMMK/Hi3Ffzhpmrs+iX8mOmJ93cqF6ZQO+9
	 N2AH7FCTKu9GBr/SW4Bq0kfYXgJFDRpUPxsEdC1GLTxmBbsus3CmJKx4XXuBlBoOF4
	 y/daZufRlf0Q2x2hYGl5PgYltv3WUuuWQqCOl31qsY826eQOplQep9OWxxhrHkoIYT
	 NIApGI8rmQzjAtznelf2nu7sLBeNs31TUjBI1tef6CBmq2dqgRNDBH6NgyCPiT+eeF
	 SrvdpFtgm3dYC0phg7owIH7IrrmbD6dIvyh5itRgsCZ14/J3QgOUUan3e+WDH2HL5R
	 w+KruQVRvX7/Q==
Date: Wed, 5 Jun 2024 12:12:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 01/17] regulator: dt-bindings: describe the PMU module
 of the QCA6390 package
Message-ID: <21a00ea1-1749-4fcc-87cd-1af8876a7efd@sirena.org.uk>
References: <20240528-pwrseq-v8-1-d354d52b763c@linaro.org>
 <20240604173021.GA732838@bhelgaas>
 <CAMRc=MeNPvZUyu6rtsWtdvXFmOOpmjKCEpkoc5zBfJy6qBpxrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ja+GgII04rJlrfXo"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeNPvZUyu6rtsWtdvXFmOOpmjKCEpkoc5zBfJy6qBpxrg@mail.gmail.com>
X-Cookie: Simulated picture.


--Ja+GgII04rJlrfXo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 11:13:04AM +0200, Bartosz Golaszewski wrote:
> On Tue, Jun 4, 2024 at 7:30=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:

> > LDO?  Again below, but maybe this is obvious to everybody.

> Yes, this is an acceptable abbreviation to use, it's all over the
> bindings and regulator drivers.

Vastly more people are going to understand LDO than would be able to
expand the acronym.

--Ja+GgII04rJlrfXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZgSCUACgkQJNaLcl1U
h9ByZgf/TG0Lj2GpWhjqjqffaI1t0B0aafiDHRBlSOkaq9el1b4FEPEjjrECf1Qh
ne5c8PYSt81tN22LJRsh4gK53Ff9ziSn2l0KjKes7LCUwu58zAXDKgrsji++9+Vw
vqxnhPdP5to25T28H3ds9QoF2jluYqiT/aQXtpRxZWWkO2xHYZ7eAwJe0vOn4rx8
cqMEBHu9a57G8kN5BIs6cwaNmwlorGxdPKyLdXx3F6+3NvqtbvHGT9XDAkIU+GtC
2QjuqiW8jM+xvSVYi+ALcYY0djf8Q7J8gmhyQaZa6UNFwO1H8AibziDOF9X7v7nB
oouRPtsj7Oma2IMcaDj8MW3Ry5Jhsw==
=tpqW
-----END PGP SIGNATURE-----

--Ja+GgII04rJlrfXo--

