Return-Path: <linux-pci+bounces-3033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A73D847521
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 17:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BF4285885
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E861487FF;
	Fri,  2 Feb 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO06o+M0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDBE148306;
	Fri,  2 Feb 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892110; cv=none; b=k+uXD0+cUKBqi3EIahBRgkpYfvZHnH7/6F/ZnNI8m7qBlaa/5hQJeO29n/9OUMTSAZPUluPEMXkmCba70aMuDcnUHrND9US01DLSzbqbYW2I4mdrpcNwK2/ZoO3n6lHfJLznKEIfiO11i6hzEzqTanNBAfGaKdZis0us4YgmAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892110; c=relaxed/simple;
	bh=byD/uDmfIyGSSgmTUNx/D1BNsUYtDcKiObLVnogvsyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=janjqrkaRYxmvdMNBIQLSf70vRhhYKC/6ZYN2zAcqyj/heVnWn4N2rrTxMGM8SKjKEAMTHCFAFxFL7GoYpdfU388P9+0F9wrA3c5b61XAhDyfwfxwuveXp/0/hXeCwXgTdcYKnuHshFQbcRyhGsQsKY26KTINvWkjAa7il6oDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO06o+M0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD42BC433C7;
	Fri,  2 Feb 2024 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892109;
	bh=byD/uDmfIyGSSgmTUNx/D1BNsUYtDcKiObLVnogvsyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AO06o+M05qQ8e93mZISuKzCx9WQQR05CLtuLzIizUFWyh2XDcCWktt/jIclTmGXRJ
	 LX0dyc0S9HRcTQd7xJ1xq+KHDPV1tFV+HqFlyAj4Qcen+vIEsewo+vCdg0BYlzXh6p
	 O1UWR/WGjIYgxG1539gLUjRi85hab/OiKyHOpfQuPPBRW7VphXNbYqqYEm7hjpXten
	 xqEusjonXZ6RtqGBkSevEz59m++Geqe11ZuD5GqZzfmzCXpOETDnlEmOHrVywpSYeN
	 6up0KtAxZiIgRT0uaB+WcTZ9xYPsQV0UzfHhJdWl/ZnF0Is1Yy13+360nMmTlc5fpf
	 cUq0I/fPh1EUw==
Date: Fri, 2 Feb 2024 10:41:46 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: Re: [RFC 2/9] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
Message-ID: <iifyazcucnghjpnmzq4qtyj6o25upntmmst6abyugpom4jrs3p@mly5h7s7owl3>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-3-brgl@bgdev.pl>
 <5lirm5mnf7yqbripue5nyqu6ej54sx4rtmgmyqjrqanabsriyp@2pjiv5xbmxpk>
 <CAMRc=Mcq8a7T06DaX9nirfHOXPs+Bh51rKgO3FksxKH+Hph2FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcq8a7T06DaX9nirfHOXPs+Bh51rKgO3FksxKH+Hph2FA@mail.gmail.com>

On Fri, Feb 02, 2024 at 02:23:49PM +0100, Bartosz Golaszewski wrote:
> On Fri, Feb 2, 2024 at 5:34 AM Bjorn Andersson <andersson@kernel.org> wrote:
> >
> 
> [snip]
> 
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
> >
> 
> Why are you so fixated on the driver implementation matching the
> device-tree 1:1? I asked that question before - what does it matter if
> we use the regulator subsystem or not?

I'm sorry, I must have missed this question. I'm not questioning why the
DT needs to match the Linux implementation, I was really questioning if
the hardware you describe here existed.

> This is just what HW there is.
> What we do with that knowledge in C is irrelevant. Yes, I don't use
> the regulator subsystem because it's unnecessary and would actually
> get in the way of the power sequencing.

Then describe that in your commit messages.

> But it doesn't change the fact
> that the regulators *are* there so let's show them.
> 
> What isn't there is a "power sequencer device". This was the main
> concern about Dmitry's implementation before.

I don't agree. The concerns that I saw being raised with Dmitry's
proposed design was that he used connected the WiFi controller to the
QCA6391 using power-domains, etc.

> We must not have
> "bt-pwrseq = <&...>;" -like properties in device-tree because there is
> no device that this would represent. But there *are* LDO outputs of
> the PMU which can be modelled and then used in C to retrieve the power
> sequencer and this is what I'm proposing.
> 

Performing device-specific power sequences is extremely common, but we
so far don't have a separate abstraction of this because it's generally
not an matter external to any given device.

If we're going to introduce a power sequence framework, it needs to be
made very clear that it is there to solve the problem that you have
devices on separate busses that need to share that sequence.

This also implies that for most examples out there where we have a need
for doing "PCI power sequencing", I don't think we would use the
power-sequence framework.

Regards,
Bjorn

> Bartosz
> 
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
> >
> 
> Yes, I forgot to remove it, I'll do it next time.
> 
> Bartosz
> 
> [snip]

