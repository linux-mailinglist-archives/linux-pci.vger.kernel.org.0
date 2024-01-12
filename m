Return-Path: <linux-pci+bounces-2118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E182C410
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BECD2855D5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258F97763C;
	Fri, 12 Jan 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqkmWrif"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385F7762B;
	Fri, 12 Jan 2024 16:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31544C433C7;
	Fri, 12 Jan 2024 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705078520;
	bh=PcazOkIWjzLsmq5KuqLCVTolsMXYCnRASgmcRQYURAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqkmWrifleooikcdX4tcXl4vk5E1OdvdT7rXIVOuAQp1B+k7vhYAV79K6MzEs3Vxv
	 Ozs8UtLj5VNW3t5wcbnxVgZ4p6mE9hzFIvmhRVmd2M7lSMuWc1+6aqOxFEZPC8Z46K
	 DOXzf9dY4lqGvYW2QwYq2AuwByLmRznBTSiZkpF8fVAimceXi7rgklRy9oPL1qTYpu
	 mNEdHk0szsEe62DzsH8eg9A0Le6lE4+dxEuOvYWieUfspDMuSL7gGslknq55p7f4tN
	 aOvipYvOOcwBcJT2R3CIdeyIwwdK0qMIqR9e4vN32gDEKvbK0CAjjwvj2pCz/BnfQ6
	 wUsiL4dVIgEuQ==
Date: Fri, 12 Jan 2024 16:55:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20240112-spotty-unplug-23790509cbe5@spud>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-1-77bbf7d0cc37@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fZ1OjBY90vApCp9r"
Content-Disposition: inline
In-Reply-To: <20240112-opp_support-v6-1-77bbf7d0cc37@quicinc.com>


--fZ1OjBY90vApCp9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 07:52:00PM +0530, Krishna chaitanya chundru wrote:
> Add the interconnects path as required property for sm8450 platform.

There's no explaination here as to why you need two different
compatibles for the instances on this device. Please add one.

Thanks,
Conor.

>=20
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Docum=
entation/devicetree/bindings/pci/qcom,pcie.yaml
> index eadba38171e1..bc28669f6fa0 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -777,6 +777,8 @@ allOf:
>                - qcom,pcie-sa8540p
>                - qcom,pcie-sa8775p
>                - qcom,pcie-sc8280xp
> +              - qcom,pcie-sm8450-pcie0
> +              - qcom,pcie-sm8450-pcie1
>      then:
>        required:
>          - interconnects
>=20
> --=20
> 2.42.0
>=20

--fZ1OjBY90vApCp9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaFu8QAKCRB4tDGHoIJi
0gbCAQD/lNEBnbgpsNuQcV25CJ4coOfOWcaad1FDzIPJFxsaIwD+Nfbum+5GewxL
I2VUdPA3NsBN0ezSTlHrEkL1io/CRQE=
=yKwa
-----END PGP SIGNATURE-----

--fZ1OjBY90vApCp9r--

