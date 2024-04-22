Return-Path: <linux-pci+bounces-6526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9CB8AD31D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 19:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B941F22268
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11163153BD2;
	Mon, 22 Apr 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQwGaxlI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4826153839;
	Mon, 22 Apr 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805745; cv=none; b=A8cUfX9vzxxnCmw1vk/u3CfIqgujtkf/dg5SM48bZQn5aRqVUT+0vg1vmML1vjj5xkI1HwoomWWOYthmVLb4Z8yMICYjVM4kuqxKA9rREj3cnBg/JkjJ1U5pCtWCY0K07AfsHsCOVPN3E5u9VFiLQDrVY1Ced6U4KznIK43SyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805745; c=relaxed/simple;
	bh=+gIC4KdUtfmTwuaNPgYrW2N0OiI+7zGr44ir/9OqFhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqrYkJTFDXFC0Wx2doZ3jnzvfYPOgTkcOc4jFWxv0pn5gNIlpCD8TIG/zt1dJnv/hGFBOGozz1H/oisBH8tsn5wltjK8nigChts6QJ1uzFIekZFlxhZIBw7diUfSo1xV/oCTfzT/qkOwmQ7wyWqg9DWddlDySspuCDkDHRpHaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQwGaxlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC6AC113CC;
	Mon, 22 Apr 2024 17:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713805744;
	bh=+gIC4KdUtfmTwuaNPgYrW2N0OiI+7zGr44ir/9OqFhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQwGaxlIPaHJP73+DrBusG65P+8fNgSoFXCy+lJLRAF4UYA0NXuAnRrSMPEtjOJ6A
	 wVi3FL3AKf0brAjJ8AsMq0WeASveHhJM2NPjtooKhiJnvhxZITiX5nGGDwM/rkZ5+Q
	 xM3E5R+l3tOpkSVi3Z8plKVzk6qWqJLy0zrimEFmEU5E+tCLUuoiI3IkTLt9AaG1E5
	 WAXd6vbd+M86WAUGiRxMJZqw1IINNveEqEsYAyqMMGJkTaISiVhYzqI3FREegk4xEw
	 xELTbLPxLSzFJkLZ2xokPXafDMYfPrXRtz/oDuS3vHLdeu9BgxilBpWDU+B1fkZyIk
	 25BVKD69v4B7A==
Date: Mon, 22 Apr 2024 22:38:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org,
	bmasney@redhat.com, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v10 4/6] arm64: dts: qcom: sm8450: Add OPP table support
 to PCIe
Message-ID: <20240422170847.GI9775@thinkpad>
References: <20240409-opp_support-v10-0-1956e6be343f@quicinc.com>
 <20240409-opp_support-v10-4-1956e6be343f@quicinc.com>
 <20240422144431.GE9775@thinkpad>
 <aaee8605-848f-fe9c-63aa-af4ae2d399a6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaee8605-848f-fe9c-63aa-af4ae2d399a6@quicinc.com>

On Mon, Apr 22, 2024 at 10:25:06PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 4/22/2024 8:14 PM, Manivannan Sadhasivam wrote:
> > On Tue, Apr 09, 2024 at 03:43:22PM +0530, Krishna chaitanya chundru wrote:
> > > PCIe needs to choose the appropriate performance state of RPMh power
> > 
> > 'PCIe host controller driver'
> > 
> > > domain and interconnect bandwidth based up on the PCIe data rate.
> > 
> > 'based on the PCIe data rate'
> > 
> > > 
> > > Add the OPP table support to specify RPMh performance states and
> > 
> > 'Hence, add...'
> > 
> > > interconnect peak bandwidth.
> > > 
> > > Different link configurations may share the same aggregate bandwidth,
> > 
> > 'It should be noted that the different...'
> > 
> > > e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same bandwidth
> > > and share the same OPP entry.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sm8450.dtsi | 77 ++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 77 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > index 615296e13c43..9dfe16012726 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > @@ -1855,7 +1855,35 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> > >   			pinctrl-names = "default";
> > >   			pinctrl-0 = <&pcie0_default_state>;
> > > +			operating-points-v2 = <&pcie0_opp_table>;
> > > +
> > >   			status = "disabled";
> > > +
> > > +			pcie0_opp_table: opp-table {
> > > +				compatible = "operating-points-v2";
> > > +
> > > +				/* GEN 1 x1 */
> > > +				opp-2500000 {
> > > +					opp-hz = /bits/ 64 <2500000>;
> > > +					required-opps = <&rpmhpd_opp_low_svs>;
> > > +					opp-peak-kBps = <250000 1>;
> > > +				};
> > > +
> > > +				/* GEN 2 x1 */
> > > +				opp-5000000 {
> > > +					opp-hz = /bits/ 64 <5000000>;
> > > +					required-opps = <&rpmhpd_opp_low_svs>;
> > > +					opp-peak-kBps = <500000 1>;
> > > +				};
> > > +
> > > +				/* GEN 3 x1 */
> > > +				opp-8000000 {
> > > +					opp-hz = /bits/ 64 <8000000>;
> > 
> > I doubt this value. See below...
> > 
> > > +					required-opps = <&rpmhpd_opp_nom>;
> > > +					opp-peak-kBps = <984500 1>;
> > > +				};
> > > +			};
> > > +
> > >   		};
> > >   		pcie0_phy: phy@1c06000 {
> > > @@ -1982,7 +2010,56 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> > >   			pinctrl-names = "default";
> > >   			pinctrl-0 = <&pcie1_default_state>;
> > > +			operating-points-v2 = <&pcie1_opp_table>;
> > > +
> > >   			status = "disabled";
> > > +
> > > +			pcie1_opp_table: opp-table {
> > > +				compatible = "operating-points-v2";
> > > +
> > > +				/* GEN 1 x1 */
> > > +				opp-2500000 {
> > > +					opp-hz = /bits/ 64 <2500000>;
> > > +					required-opps = <&rpmhpd_opp_low_svs>;
> > > +					opp-peak-kBps = <250000 1>;
> > > +				};
> > > +
> > > +				/* GEN 1 x2 GEN 2 x1 */
> > > +				opp-5000000 {
> > > +					opp-hz = /bits/ 64 <5000000>;
> > > +					required-opps = <&rpmhpd_opp_low_svs>;
> > > +					opp-peak-kBps = <500000 1>;
> > > +				};
> > > +
> > > +				/* GEN 2 x2 */
> > > +				opp-10000000 {
> > > +					opp-hz = /bits/ 64 <10000000>;
> > > +					required-opps = <&rpmhpd_opp_low_svs>;
> > > +					opp-peak-kBps = <1000000 1>;
> > > +				};
> > > +
> > > +				/* GEN 3 x1 */
> > > +				opp-8000000 {
> > > +					opp-hz = /bits/ 64 <8000000>;
> > 
> > GEN 3 x1 frequency is lower than GEN 2 x2? This looks strange. Both should be of
> > same frequency.
> > 
> Gen2 is 5GT/s where as GEN3 is 8GT/s. so the freq for 3 x1(8 x1 GT/s) is
> less than Gen2 x2(5 x2 GT/s)
> 

Sorry, that's my bad. I missed the fact that the spec doubled the data rate
starting from GEN 3 only.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

