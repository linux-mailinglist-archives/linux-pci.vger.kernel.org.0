Return-Path: <linux-pci+bounces-36434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5FAB86971
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 20:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6291D7BDCD2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C728DB54;
	Thu, 18 Sep 2025 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggOo/wv6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6127B357;
	Thu, 18 Sep 2025 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221638; cv=none; b=cEqnSh9dunaHECkyakMZcLX8enHnBA3iOP0mZ4Ttw4g32tk93nleVHaP3I6plBq4O3uF4WSdMCDu/eV5y9nNyMEo+0JgvaBKEYf5IL68XUMUtlRqSVwKGTGSNK4pEPgc0Roxz3j5ycEmPPfWKod2d+fPUG//wm9DdxoJ76fc5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221638; c=relaxed/simple;
	bh=8pFcwNdTRRXNyhxMg3EVbIUjIj9oGklWQFId1hTxeWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WkDTKSUT7e6vZYBfwufMerreXl7Fv+gxvo1DEOfdH4MCs9emKgc5g8oB7SFkM32ZUqJm7KaATuoevAaMlSd7k3IMYQSrx0eLQRe7pUgQK4I8PuIjSYP5qRLiw0vjLlgtPjCk2w+ps93Ldcf2xkTZrwkF0frDu0n7n4qrEmpuEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggOo/wv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F161BC4CEE7;
	Thu, 18 Sep 2025 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221638;
	bh=8pFcwNdTRRXNyhxMg3EVbIUjIj9oGklWQFId1hTxeWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ggOo/wv6spysNgu8Zxg51el+9c+Z9BAXohzEw+5T15dJ+3eruutBRss9+oDCUC2vW
	 PEeWGEyCt9dR8CEqji9p5mJLcd+FMZrCJNWWjjECY5+khLbKSIa9PoMxqUK4W/T1gu
	 RoSutHlVDJuXpFBeL2IwrWkYFR9Fu0sH50+eZHDzCv6em8UCH6HmvAXQ+iv3EDTHCN
	 dNBxRSIhbGYde6Njg+JNAphhQBxMFlvg/936HWE6jaV/2YoG6IQJkrCeYpXZLL2pqZ
	 JdqFD+eXg8aoLS/s0W2Il8jmiuSOCoGjEPHxSbhwKd/sHAHXDGjgU3t6APcksbGCOH
	 /ISDzYzl48cfg==
Date: Thu, 18 Sep 2025 13:53:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 4/4] PCI: qcom: Allow pwrctrl core to control PERST#
 if 'reset-gpios' property is available
Message-ID: <20250918185356.GA1879416@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gnaubphg6iyh23vtf2flsjxoot7psgla7cr2c5jpecaozh4vf3@mzcmg74g3ogk>

On Wed, Sep 17, 2025 at 03:53:25PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Sep 16, 2025 at 03:48:10PM GMT, Bjorn Helgaas wrote:
> > On Fri, Sep 12, 2025 at 02:05:04PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > For historic reasons, the pcie-qcom driver was controlling the
> > > power supply and PERST# GPIO of the PCIe slot.
> > 
> > > This turned out to be an issue as the power supply requirements
> > > differ between components. For instance, some of the WLAN
> > > chipsets used in Qualcomm systems were connected to the Root
> > > Port in a non-standard way using their own connectors.
> > 
> > This is kind of hand-wavy.  I don't know what a non-standard
> > connector has to do with this.  I assume there's still a PCIe link
> > from Root Port to WLAN, and there's still a PERST# signal to the
> > WLAN device and a Root Port GPIO that asserts/deasserts it.
> 
> If we have a non-standard connector, then the power supply
> requirements change.  There is no longer the standard 3.3v, 3.3Vaux,
> 1.8v supplies, but plenty more.  For instance, take a look at the
> WCN6855 WiFi/BT combo chip in the Lenovo X13s laptop:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts#n414
> 
> These supplies directly go from the host PMIC to the WCN6855 chip
> integrated in the PCB itself. And these supplies need to be turned
> on/off in a sequence also, together with the EN/SWCTRL GPIOs, while
> sharing with the Bluetooth driver.

It sounds like the WCN6855 power supplies have nothing to do with the
qcom PCIe controller, the Root Port, or any switches leading to the
WCN6855.  And I guess the same for the wlan-enable, bt-enable, and
swctrl GPIOs?

  wcn6855-pmu {
          compatible = "qcom,wcn6855-pmu";
          wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
          bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
          swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
          regulators {
                  vreg_pmu_rfa_cmn_0p8: ldo0 {
                          regulator-name = "vreg_pmu_rfa_cmn_0p8";
                  ...

  &pcie4_port0 {
          wifi@0 {
                  compatible = "pci17cb,1103";
                  vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
                  ...

But I guess PERST# isn't described in the same place (not in
wcn6855-pmu)?  Looks like maybe it's this, which IIUC is part of the
pcie4 host bridge?

  &pcie4 {
          max-link-speed = <2>;
          perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
          wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;

Does that mean this PERST# signal is driven by a GPIO and routed
directly to the WCN6855?  Seems like there's some affinity between the
WCN6855 power supplies and the WCN6855 PERST# signal, and maybe they
would be better described together?

