Return-Path: <linux-pci+bounces-9698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AFC9253A7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 08:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D91C22E77
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 06:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F11311AC;
	Wed,  3 Jul 2024 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Gxsoe0HD"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1089130A58;
	Wed,  3 Jul 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988198; cv=none; b=omRZKaquo2Kz9bBV2DqflrGLN3tgBbogx///6V4BcRcdTILSPMcAbBauVQVLLJvsgZ4UPJ3jR+RESEfMcVm9fvnKQ5iLSIUyqc+nUokubyCDlHun5Begpqxw0mnMLY3TkRhyJeilftAKYqY84w+uYPB9vy07R0vbUAl5YQOm40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988198; c=relaxed/simple;
	bh=uNhuDjLWZorDbXDOWnVhHDPlY99NnQewwMxhnvVsgtQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD6t/EB7OPjc/Trou7EnbIBEWXKpVaQ6h9UuGIXbKHeaxa5y7iaQPb9fYzKFzNu2PDYjFuigoRx9HByJg8XkQgbBVKPOLfTJ/wmcf0D/Xv3UdGbdAONbbPn1R5xFVlvSpjqcwMGS1a8pUWZBskeCnRNt/ouoXZOINL7zWRXX0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Gxsoe0HD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719988196; x=1751524196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uNhuDjLWZorDbXDOWnVhHDPlY99NnQewwMxhnvVsgtQ=;
  b=Gxsoe0HDr1vqSeikiipVO5TI/gFLTolVGrIn0jHuD0KYVjfCBy1UEBSZ
   BpRYiUfnCkff/9qnCQ/66s7om2eDgQhzRramGfsq0ofYBKt6ovGOuxD4p
   L3rqkMjoVJq1x3N9qU7Ad23WyCHMDsySnLd7M+kdKfVHRgXYZ55Lrbkvt
   bWW+7NYk6yDaSSaPabbtDt/H1D3dqxqPp2abyJm0KRvzmRlmtXOSMW9v1
   Gj6syKdrKT8gsFo5Q3dlaBpwOUYypWKzlaa+f3iV4/Im69c5JdnNLkZ4d
   04MEJkypyA8ZfmuQN9+0piLgjC2U7qdhCBpqQm0e+oXr9xYQ9mm5UaUTh
   A==;
X-CSE-ConnectionGUID: uIiTarkbQoeuHwrRiGsmdg==
X-CSE-MsgGUID: 7MEjGxCjQO6357/Nmml1zg==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="asc'?scan'208";a="31406626"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2024 23:29:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jul 2024 23:29:26 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 2 Jul 2024 23:29:12 -0700
Date: Wed, 3 Jul 2024 07:28:53 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Tengfei Fan <quic_tengfan@quicinc.com>, <andersson@kernel.org>,
	<konrad.dybcio@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <djakov@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<manivannan.sadhasivam@linaro.org>, <will@kernel.org>, <joro@8bytes.org>,
	<conor@kernel.org>, <tglx@linutronix.de>, <amitk@kernel.org>,
	<thara.gopinath@gmail.com>, <linus.walleij@linaro.org>,
	<wim@linux-watchdog.org>, <linux@roeck-us.net>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <vkoul@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
	<robimarko@gmail.com>, <quic_gurus@quicinc.com>,
	<bartosz.golaszewski@linaro.org>, <kishon@kernel.org>,
	<quic_wcheng@quicinc.com>, <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
	<bvanassche@acm.org>, <agross@kernel.org>, <gregkh@linuxfoundation.org>,
	<quic_tdas@quicinc.com>, <robin.murphy@arm.com>, <daniel.lezcano@linaro.org>,
	<rui.zhang@intel.com>, <lukasz.luba@arm.com>, <quic_rjendra@quicinc.com>,
	<ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
	<otto.pflueger@abscue.de>, <quic_rohiagar@quicinc.com>, <luca@z3ntu.xyz>,
	<neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
	<bhupesh.sharma@linaro.org>, <alexandre.torgue@foss.st.com>,
	<peppe.cavallaro@st.com>, <joabreu@synopsys.com>, <netdev@vger.kernel.org>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
	<ahalaney@redhat.com>, <krzysztof.kozlowski@linaro.org>,
	<u.kleine-koenig@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
	<quic_cang@quicinc.com>, <danila@jiaxyga.com>, <quic_nitirawa@quicinc.com>,
	<mantas@8devices.com>, <athierry@redhat.com>, <quic_kbajaj@quicinc.com>,
	<quic_bjorande@quicinc.com>, <quic_msarkar@quicinc.com>,
	<quic_devipriy@quicinc.com>, <quic_tsoni@quicinc.com>,
	<quic_rgottimu@quicinc.com>, <quic_shashim@quicinc.com>,
	<quic_kaushalk@quicinc.com>, <quic_tingweiz@quicinc.com>,
	<quic_aiquny@quicinc.com>, <srinivas.kandagatla@linaro.org>,
	<linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-crypto@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<linux-gpio@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<kernel@quicinc.com>
Subject: Re: [PATCH 00/47] arm64: qcom: dts: add QCS9100 support
Message-ID: <20240703-manager-armless-b13b18c79192@wendy>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703035735.2182165-1-quic_tengfan@quicinc.com>
 <7417fd8c-e852-45ee-bac9-d92921036e2f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5oSvLfaqEVebv1DP"
Content-Disposition: inline
In-Reply-To: <7417fd8c-e852-45ee-bac9-d92921036e2f@kernel.org>

--5oSvLfaqEVebv1DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 06:45:00AM +0200, Krzysztof Kozlowski wrote:
> On 03/07/2024 05:56, Tengfei Fan wrote:
> > Introduce support for the QCS9100 SoC device tree (DTSI) and the
> > QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
> > While the QCS9100 platform is still in the early design stage, the
> > QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
> > mounts the QCS9100 SoC instead of the SA8775p SoC.
>=20
> The same huge patchset, to huge number of recipients was sent twice.
> First, sorry, this is way too big. Second, it has way too many
> recipients, but this is partially a result of first point. Only
> partially because you put here dozen of totally unrelated emails. Sorry,
> that does not make even sense. See form letter at the end how this
> works. Third, sending it to everyone twice is a way to annoy them off
> twice... Fourth,
>=20
> Please split your work and do not cc dozen of unrelated folks.

One of the extra recipients is cos that of that patch I sent adding the
cache bindings to the cache entry, forgetting that that would CC the
riscv list on all cache bindings. I modified that patch to drop the riscv
list from the entry.

Cheers,
Conor.

--5oSvLfaqEVebv1DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoTvpQAKCRB4tDGHoIJi
0iuiAP9Wgtx8LiFpImc+BXo3h8CTF/4nY5kHoihO91fC51FsogEAnEhd56PAeLdE
Uxg8sGMCKh5qjR+u3kQIZlblyU1rmwA=
=Khim
-----END PGP SIGNATURE-----

--5oSvLfaqEVebv1DP--

