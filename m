Return-Path: <linux-pci+bounces-36465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2281FB885DC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 10:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48AB567458
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 08:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB3C2D9796;
	Fri, 19 Sep 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aduFlHHp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A727FD71;
	Fri, 19 Sep 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269760; cv=none; b=i0b8nmpwvhu3rqyDrehUOaR1X+X/OAK/ipkLbIhx+ja6iQ+V7KBGWBwVmY6u+i1zOc4lJfIWiRiPLXFKSYEpEcLhONgpX8gxKCT9oyOaHZbGZkFvdDGOVhxXPFGGTYnmCa5Uu6lzPU1lze6303+RViuzX08ZKuzEA8tLbBC9ygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269760; c=relaxed/simple;
	bh=VxTAjSklRSGqESyW8iAN9ut3qajeB4/ZGEoQ1sC9AGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjqePxo111cBziWdO+xo77qP5OP56ljKQur5giit85mSVjHAxwaqiuDbvHKOfgEBmmtWX8haRC1YxSLK+PSLuDgCtnDGAkI4tWjxC2/uhFhAmyxRqjj/MM0AN4/gJEpis27pQae2Ocp87QMxNEOBUe/lZndv2kwUHlGZsdHzPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aduFlHHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8FAC4CEF0;
	Fri, 19 Sep 2025 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758269759;
	bh=VxTAjSklRSGqESyW8iAN9ut3qajeB4/ZGEoQ1sC9AGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aduFlHHpk5thnaiNT9P64Li/+3xf6NFuLJ0K2/6m57BH17S00nClFhpJJkvSGMcx/
	 FG2FWJmu0sXcdVr3znKtPHiuysD4gSew11FaMSpfpEnSL/XKzV9NaSdAAzo2CQo3oK
	 +Npzxtvvafi7SKiQRZDZxvYp/qhXl39HRJa36AOIZsNd2B6JRcO68BIGraQkX1Kz54
	 ayZTWtsZfE8DjK4AyTvrgxoO0WyOgMVi4ET7aPTph55fEdRmrNpsYZnWZUrHEkoxh9
	 z3cNG71qmYRzZRM+nu3UauFTAQ/zBMmZP3WNIXwfB0yU8mBVySI1cCsQPrcGSOQJpX
	 BHabaLVJrQp+w==
Date: Fri, 19 Sep 2025 13:45:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 4/4] PCI: qcom: Allow pwrctrl core to control PERST#
 if 'reset-gpios' property is available
Message-ID: <nxcr6ymgspcdofoy7cv4lok34qqucwrm4cxn7a7spqrszgmvin@x3mhucqy2tb3>
References: <gnaubphg6iyh23vtf2flsjxoot7psgla7cr2c5jpecaozh4vf3@mzcmg74g3ogk>
 <20250918185356.GA1879416@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918185356.GA1879416@bhelgaas>

On Thu, Sep 18, 2025 at 01:53:56PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 17, 2025 at 03:53:25PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Sep 16, 2025 at 03:48:10PM GMT, Bjorn Helgaas wrote:
> > > On Fri, Sep 12, 2025 at 02:05:04PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > 
> > > > For historic reasons, the pcie-qcom driver was controlling the
> > > > power supply and PERST# GPIO of the PCIe slot.
> > > 
> > > > This turned out to be an issue as the power supply requirements
> > > > differ between components. For instance, some of the WLAN
> > > > chipsets used in Qualcomm systems were connected to the Root
> > > > Port in a non-standard way using their own connectors.
> > > 
> > > This is kind of hand-wavy.  I don't know what a non-standard
> > > connector has to do with this.  I assume there's still a PCIe link
> > > from Root Port to WLAN, and there's still a PERST# signal to the
> > > WLAN device and a Root Port GPIO that asserts/deasserts it.
> > 
> > If we have a non-standard connector, then the power supply
> > requirements change.  There is no longer the standard 3.3v, 3.3Vaux,
> > 1.8v supplies, but plenty more.  For instance, take a look at the
> > WCN6855 WiFi/BT combo chip in the Lenovo X13s laptop:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts#n414
> > 
> > These supplies directly go from the host PMIC to the WCN6855 chip
> > integrated in the PCB itself. And these supplies need to be turned
> > on/off in a sequence also, together with the EN/SWCTRL GPIOs, while
> > sharing with the Bluetooth driver.
> 
> It sounds like the WCN6855 power supplies have nothing to do with the
> qcom PCIe controller, the Root Port, or any switches leading to the
> WCN6855.  And I guess the same for the wlan-enable, bt-enable, and
> swctrl GPIOs?
> 
>   wcn6855-pmu {
>           compatible = "qcom,wcn6855-pmu";
>           wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
>           bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
>           swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
>           regulators {
>                   vreg_pmu_rfa_cmn_0p8: ldo0 {
>                           regulator-name = "vreg_pmu_rfa_cmn_0p8";
>                   ...
> 
>   &pcie4_port0 {
>           wifi@0 {
>                   compatible = "pci17cb,1103";
>                   vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
>                   ...
> 
> But I guess PERST# isn't described in the same place (not in
> wcn6855-pmu)?  Looks like maybe it's this, which IIUC is part of the
> pcie4 host bridge?
> 
>   &pcie4 {
>           max-link-speed = <2>;
>           perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
>           wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
> 
> Does that mean this PERST# signal is driven by a GPIO and routed
> directly to the WCN6855?  Seems like there's some affinity between the
> WCN6855 power supplies and the WCN6855 PERST# signal, and maybe they
> would be better described together?

Yes, 'perst-gpios' is the PERST# signal that goes from the host system to the
WCN6855 chip. But we cannot define this signal in the WCN6855 node as the DT
binding only allows to define it in the PCI bridge nodes. This is why it is
currently defined in the host bridge node. But when this platform switches to
the per-Root Port binding, this property will be moved to the Root Port node as
'reset-gpios'.

Because of this reason, the host controller driver has to parse PERST# from all
PCI bridge nodes (like if there is a switch connected, there might be PERST# per
downstream port) and share them with the pwrctrl framework.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

