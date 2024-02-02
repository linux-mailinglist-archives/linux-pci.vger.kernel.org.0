Return-Path: <linux-pci+bounces-3032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0480847452
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 17:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062271C251A6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903291482F4;
	Fri,  2 Feb 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7YvTGd6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3071474A1;
	Fri,  2 Feb 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890169; cv=none; b=R2wU+0c9w8JiE89whoLDVEZ87XVxNlNEksb09wpxz7wE43d9DYVCt0FEVTg/FP0TQnYWpf2qMI6Fq10m5lnS4enwXqpLVSq4zl1OYJlq4ofwRThX7SaMl1eYnLGT4/wNyYqED5loEMd4vRqUrtRGVSSJm86w1WtXNnm6+gpsCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890169; c=relaxed/simple;
	bh=JKjik19irTKxH29Yeweq9zfMl6xdzxEg/mcUMqTql/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKyFF+Mg7vUQTLzggEEE6HMcS+F2OOsqAZIAMqTi41StXh5tm5/aiQ4NHpFV7WYf3LOcd53ysqpxJK7wVXLZ0xd3q16HRtdSXc+k7mjptRrHsixkE8AYYz/m21jKOWLPR3Fq8OoHPRsEcsMMpShg4OfyVJvJXsKNQM7kjJjx5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7YvTGd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28503C43390;
	Fri,  2 Feb 2024 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706890168;
	bh=JKjik19irTKxH29Yeweq9zfMl6xdzxEg/mcUMqTql/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7YvTGd6PqeZiR/6qwBVmTm6pnRj4NRc0t7Fe3yBdyiZueJYfHWnjr/WF33qsQ3NM
	 9BkYwn4HAtLckhN4p+XA5NePJpResF+HzXgsnwJf6gnOIMUu7LTOypFH6JbL53mXJZ
	 SSD5BOtTIJgyjm0c56PUA0Ayk/lu9aggST3FmdNxx7J5eEputg3mPURGBbkT0tQAPZ
	 4CaU2c3foqmWduaXLmEuFxDK0Vif8gqBw0M23ydFLgO6qgSQmMP0iEZTtomVzA8nog
	 fIun+LiASDvAXFh9yGnQxorH8bK4L9bDiZs+r6Xlgcvcm7nPX9rHVEQjXPwua2SvW2
	 +mclvUQYrBzNA==
Date: Fri, 2 Feb 2024 10:09:25 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: Re: [RFC 2/9] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
Message-ID: <sdxnybvszlcfrjexc2fuqkozormhsrx6guauvnlozuh5c6poec@kj2wlb4tnbnz>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-3-brgl@bgdev.pl>
 <5lirm5mnf7yqbripue5nyqu6ej54sx4rtmgmyqjrqanabsriyp@2pjiv5xbmxpk>
 <CAA8EJpp=gYhx6XKHNzyR5n8i7vg-MJXN5XJp4CPKZMYS5GBHvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpp=gYhx6XKHNzyR5n8i7vg-MJXN5XJp4CPKZMYS5GBHvw@mail.gmail.com>

On Fri, Feb 02, 2024 at 06:59:48AM +0200, Dmitry Baryshkov wrote:
> On Fri, 2 Feb 2024 at 06:34, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Thu, Feb 01, 2024 at 04:55:25PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Add a node for the PMU module of the QCA6391 present on the RB5 board.
> > > Assign its LDO power outputs to the existing Bluetooth module. Add a
> > > node for the PCIe port to sm8250.dtsi and define the WLAN node on it in
> > > the board's .dts and also make it consume the power outputs of the PMU.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 128 +++++++++++++++++++++--
> > >  arch/arm64/boot/dts/qcom/sm8250.dtsi     |  10 ++
> > >  2 files changed, 127 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > index cd0db4f31d4a..fab5bebafbad 100644
> > > --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > @@ -108,6 +108,87 @@ lt9611_3v3: lt9611-3v3 {
> > >               regulator-always-on;
> > >       };
> > >
> > > +     qca6390_pmu: pmu@0 {
> > > +             compatible = "qcom,qca6390-pmu";
> > > +
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
> > > +
> > > +             vddaon-supply = <&vreg_s6a_0p95>;
> > > +             vddpmu-supply = <&vreg_s2f_0p95>;
> > > +             vddrfa1-supply = <&vreg_s2f_0p95>;
> > > +             vddrfa2-supply = <&vreg_s8c_1p3>;
> > > +             vddrfa3-supply = <&vreg_s5a_1p9>;
> > > +             vddpcie1-supply = <&vreg_s8c_1p3>;
> > > +             vddpcie2-supply = <&vreg_s5a_1p9>;
> > > +             vddio-supply = <&vreg_s4a_1p8>;
> > > +
> > > +             wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
> > > +             bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
> > > +
> > > +             regulators {
> > > +                     vreg_pmu_rfa_cmn: ldo0 {
> > > +                             regulator-name = "vreg_pmu_rfa_cmn";
> > > +                             regulator-min-microvolt = <760000>;
> > > +                             regulator-max-microvolt = <840000>;
> >
> > I'm still not convinced that the PMU has a set of LDOs, and looking at
> > your implementation you neither register these with the regulator
> > framework, nor provide any means of controlling the state or voltage of
> > these "regulators".
> 
> Please take a look at the description of VDD08_PMU_RFA_CMN and
> VDD_PMU_AON_I pins in the spec (80-WL522-1, page 25). I'm not sure if
> I'm allowed to quote it, so I won't. But the spec clearly describes
> VDD_PMU_AON_I as 0.95V LDO input and VDD08_PMU_RFA_CMN as 0.8 LDO
> output generated using that input. I think this proves that the
> on-chip PMU has actual LDOs.
> 

You're correct, thank you for the pointer and clarification. I now agree
with you, the PMU consumes what I saw as the chip input supplies, and
based on WL_EN and BT_EN will provide power on pads, which are then
externally routed to respective block.

> I must admit, I find this representation very verbose, but on the
> other hand Bartosz is right, it represents actual hardware.

I agree, this is actual hardware.

> Maybe we
> can drop some of the properties of corresponding regulator blocks, as
> we don't actually need them and they are internal properties of the
> hardware.
> 

To me this really looks like a fancy "regulator-fixed" with multiple
inputs, two gpios and multiple outputs.

This would also imply that we don't need to invent the power sequence
framework to tie WiFi and BT to the PMU's state.

The PMU is a thing, so we can represent that in DeviceTree, it consumes
M input power rails, and two gpios, it provides N WiFi supplies and O BT
supplies (with some overlap between N and O). The WiFi node consumes its
N supplies, the BT node consumes its O supplies.

If any of the N regulators are requested enabled the qca6390-pmu driver
enables all M input rails, then enables WL_EN. If any of the O BT
regulators are requested enabled, the driver enables all M input rails,
then enables BT_EN.

> >
> > [..]
> > >
> > >  &uart6 {
> > > @@ -1311,17 +1418,16 @@ &uart6 {
> > >       bluetooth {
> > >               compatible = "qcom,qca6390-bt";
> > >
> > > -             pinctrl-names = "default";
> > > -             pinctrl-0 = <&bt_en_state>;
> > > -
> > > -             enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
> > > -
> > > -             vddio-supply = <&vreg_s4a_1p8>;
> > > -             vddpmu-supply = <&vreg_s2f_0p95>;
> > > -             vddaon-supply = <&vreg_s6a_0p95>;
> > > -             vddrfa0p9-supply = <&vreg_s2f_0p95>;
> > > -             vddrfa1p3-supply = <&vreg_s8c_1p3>;
> > > -             vddrfa1p9-supply = <&vreg_s5a_1p9>;
> > > +             vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> > > +             vddaon-supply = <&vreg_pmu_aon_0p59>;
> > > +             vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> > > +             vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> > > +             vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
> > > +             vddrfa0-supply = <&vreg_pmu_rfa_0p8>;
> > > +             vddrfa1-supply = <&vreg_pmu_rfa_1p2>;
> > > +             vddrfa2-supply = <&vreg_pmu_rfa_1p7>;
> > > +             vddpcie0-supply = <&vreg_pmu_pcie_0p9>;
> > > +             vddpcie1-supply = <&vreg_pmu_pcie_1p8>;
> >
> > As I asked before, why does bluetooth suddenly care about PCIe supplies?
> 
> Power sequencing in the same spec describes that PCIe voltages should
> be up even if only BT is being brought up. PMU itself handles
> distributing voltages according to the actual load needs.
> 

You're right, the power sequence diagram in the docs do indicate that
VDD13_PMU_PCIE_I and VDD19_PMU_PCIE_I should be enabled before either
WL_EN or BT_EN are driven high.

But I don't see anything stating that the output from the PMU
(VDD09_PMU_PCIE) in turn is fed to the bluetooth block.

Regards,
Bjorn

> >
> > Regards,
> > Bjorn
> >
> > >       };
> > >  };
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > index 4d849e98bf9b..7cd21d4e7278 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > @@ -2203,6 +2203,16 @@ pcie0: pcie@1c00000 {
> > >                       dma-coherent;
> > >
> > >                       status = "disabled";
> > > +
> > > +                     pcieport0: pcie@0 {
> > > +                             device_type = "pci";
> > > +                             reg = <0x0 0x0 0x0 0x0 0x0>;
> > > +                             #address-cells = <3>;
> > > +                             #size-cells = <2>;
> > > +                             ranges;
> > > +
> > > +                             bus-range = <0x01 0xff>;
> > > +                     };
> > >               };
> > >
> > >               pcie0_phy: phy@1c06000 {
> > > --
> > > 2.40.1
> > >
> >
> 
> 
> -- 
> With best wishes
> Dmitry

