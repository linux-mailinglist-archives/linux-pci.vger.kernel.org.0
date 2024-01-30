Return-Path: <linux-pci+bounces-2767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F6841C64
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 08:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F28AAB220E0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC945012;
	Tue, 30 Jan 2024 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQUzVE32"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D045006;
	Tue, 30 Jan 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598902; cv=none; b=LdMPMJ4CEM3oeDvc11KP+e8lGLj0XbXKz9U+z/Em0zRlEVG/GiC7c3MpC+WDfuLWK5e0W9EwZrxeAw7fald65avp3+q9uyDItA6iH9Slwu30NziyWm1qvMykpizvAxOOIf2PGYWzfhMl4lg+1FTY4mmbKjFKI19rqZKJWTeN+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598902; c=relaxed/simple;
	bh=3O2f3C735+i3w3e95T2JFKr5hUPP5tDZtu+rWvTmjuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+GPi7OSLEbT8I1LPymYNfJcdDJKTUAdNrD9+O8IQYEcsKNYezOLzBfweGVgB0duWclWvvPT2UUeeA4eKsL/8nmvhA5lq8HPxj0K6ZeX1HX6V7jU9arosD3o7GQYq9OBmbaUUYP7WngHln0FoJYUVycSS/9uniiE6aH8NUJRInw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQUzVE32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7E5C433C7;
	Tue, 30 Jan 2024 07:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706598901;
	bh=3O2f3C735+i3w3e95T2JFKr5hUPP5tDZtu+rWvTmjuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQUzVE32pRfeLHULf0XVo2M0xQIfe8i4jvnS8c2seESF4a9Uwx+lGrzKu/FLDdNXS
	 Zk3inblB2vJfluBo6SBAYsbGf6rbjFM7kV2IhN3cR09JMjXi2Dc/zxAx6O1itT9Os2
	 mpfxSjZjTcw4cuHQ9vUdvxwrbeJ+Kzfb8MFkQnGgNKT4mlQMcmjQx8CFZb4J65BK1c
	 jvXq0zFxhESchT72bs03+YznWaPr5Cndpnphex39hCYFpShT85x64J9QQodCDlM6ND
	 fYcwZ+QeUdDkSg7g098MdLFezdzVVgTGoRKN3hQGnYQbFF4GArgSo25LLYOiU4dsxj
	 25v2pDD0LeViw==
Date: Tue, 30 Jan 2024 12:44:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <20240130071449.GG32821@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>

On Tue, Jan 30, 2024 at 11:41:11AM +0530, Viresh Kumar wrote:
> On 29-01-24, 21:34, Manivannan Sadhasivam wrote:
> > On Fri, Jan 12, 2024 at 07:52:04PM +0530, Krishna chaitanya chundru wrote:
> > > PCIe needs to choose the appropriate performance state of RPMH power
> > > domain and interconnect bandwidth based up on the PCIe gen speed.
> > > 
> > > Add the OPP table support to specify RPMH performance states and
> > > interconnect peak bandwidth.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8450.dtsi | 74 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 74 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > index 6b1d2e0d9d14..eab85ecaeff0 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > @@ -1827,7 +1827,32 @@ pcie0: pcie@1c00000 {
> > >  			pinctrl-names = "default";
> > >  			pinctrl-0 = <&pcie0_default_state>;
> > >  
> > > +			operating-points-v2 = <&pcie0_opp_table>;
> > > +
> > >  			status = "disabled";
> > > +
> > > +			pcie0_opp_table: opp-table {
> > > +				compatible = "operating-points-v2";
> > > +
> > > +				opp-2500000 {
> > > +					opp-hz = /bits/ 64 <2500000>;
> > > +					required-opps = <&rpmhpd_opp_low_svs>;
> > > +					opp-peak-kBps = <250000 250000>;
> > 
> > This is a question for Viresh: We already have macros in the driver to derive
> > the bandwidth based on link speed. So if OPP core exposes a callback to allow
> > the consumers to set the bw on its own, we can get rid of this entry.
> > 
> > Similar to config_clks()/config_regulators(). Is that feasible?
> 
> I don't have any issues with a new callback for bw. But, AFAIU, the DT
> is required to represent the hardware irrespective of what any OS
> would do with it. So DT should ideally have these values here, right ?
> 

Not necessarily. Because, right now the bandwidth values of the all peripherals
are encoded within the drivers. Only OPP has the requirement to define the
values in DT.

> Also, the driver has already moved away from using those macros now
> and depend on the OPP core to do the right thing. It only uses the
> macro for the cases where the DT OPP table isn't available. And as
> said by few others as well already, the driver really should try to
> add OPPs dynamically in that case to avoid multiple code paths and
> stick to a single OPP based solution.
> 

Still I prefer to use OPP for bandwidth control because both the voltage and
bandwidth values need to be updated at the same time. My only point here is, if
OPP exposes a callback for bw, then we can keep the DT behavior consistent.

- Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்

