Return-Path: <linux-pci+bounces-2124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC0882C4AE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 18:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4F51C216CD
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6122626;
	Fri, 12 Jan 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgxB2Jqy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7F22623;
	Fri, 12 Jan 2024 17:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029B1C433C7;
	Fri, 12 Jan 2024 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705080475;
	bh=SdilHwTIC8KXIhvK6EeSp8y5CKlPN+Estba9/roh6r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KgxB2JqyoQoBXWviihHRomjfj+q9PtihS6s+IcB+YsaotVxJZlwE8VrQHorD5gE1y
	 FCfoPIv4lrG5rIGFwA0IirimuK6uDyCFw6DOFd6HCjCyKbkaXC7dykHtIu4V9bWlr0
	 b752LKBRw9o/VnarNyivU4+ILg/K+Xn1MtDvVcIr29cjNGpVCeEzu7qCLIdEhaU51P
	 S4RwN9mhonSOQKFUbWxWwA5n7WLwX1hGKh3BEI1hsEcriWiG2+kdbTRov8Tupp632y
	 urUc13tyEsuDKfq4IcXpMVrIofImAFgIA+lxxLoYDwYnWeNGv/YvmVWp975iO3q5lH
	 wXpV4DyhtnXQA==
Date: Fri, 12 Jan 2024 17:27:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: PCI: qcom: Add interconnects path as
 required property
Message-ID: <20240112-patrol-map-10b7f964f5f0@spud>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-1-77bbf7d0cc37@quicinc.com>
 <20240112-spotty-unplug-23790509cbe5@spud>
 <CAA8EJpoLqs6xs4OF4YxBKQesfvAeXzoHPR9G9EeS4+WXjwb9yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zl8iK4z2MiFyPNju"
Content-Disposition: inline
In-Reply-To: <CAA8EJpoLqs6xs4OF4YxBKQesfvAeXzoHPR9G9EeS4+WXjwb9yw@mail.gmail.com>


--Zl8iK4z2MiFyPNju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 07:12:01PM +0200, Dmitry Baryshkov wrote:
> On Fri, 12 Jan 2024 at 18:55, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Fri, Jan 12, 2024 at 07:52:00PM +0530, Krishna chaitanya chundru wro=
te:
> > > Add the interconnects path as required property for sm8450 platform.
> >
> > There's no explaination here as to why you need two different
> > compatibles for the instances on this device. Please add one.
>=20
> Note, these are not new compatible strings. They are already defined
> (separate because port0 and port1 have different sets of NoC clocks).

Ahh, my bad. My comment can be disregarded.
:wq
>=20
> >
> > Thanks,
> > Conor.
> >
> > >
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > index eadba38171e1..bc28669f6fa0 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > @@ -777,6 +777,8 @@ allOf:
> > >                - qcom,pcie-sa8540p
> > >                - qcom,pcie-sa8775p
> > >                - qcom,pcie-sc8280xp
> > > +              - qcom,pcie-sm8450-pcie0
> > > +              - qcom,pcie-sm8450-pcie1
> > >      then:
> > >        required:
> > >          - interconnects
> > >
> > > --
> > > 2.42.0
> > >
>=20
>=20
>=20
> --=20
> With best wishes
> Dmitry

--Zl8iK4z2MiFyPNju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaF2lAAKCRB4tDGHoIJi
0gl9AP4hIFmjccspxz7TAUCCvF0DYL0uL7coNn3jdSI33l6ahgD/QDeHOICIsNpW
5CQ64pAObjkb4naoHM63lvIL1+g/tQ8=
=8u7R
-----END PGP SIGNATURE-----

--Zl8iK4z2MiFyPNju--

