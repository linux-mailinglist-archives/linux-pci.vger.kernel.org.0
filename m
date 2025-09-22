Return-Path: <linux-pci+bounces-36704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4BCB923D5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 18:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BA71894117
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71DB311C22;
	Mon, 22 Sep 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir7EXn7S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B96330C625;
	Mon, 22 Sep 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558801; cv=none; b=iYWWkxHRzVL6abThiMi/e0+uDGi1S5fQgqFg/IsVRXQolpNItJiOSX9zJ7LErujk0ZfdklAmfioqAew2w8Y9OvJyNmqLuSc0Ihl09Sh6Aq7jowkiHEt9JlM8dSSYejBsVwSqOXhgAUJ4aCVPtjkvwZ6NYb77g8fUx8lNOHdQO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558801; c=relaxed/simple;
	bh=xMmGNRC++VxwgdXGhecb5pzo/fRO7nnjJ1/3o+lBhYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFafA9z95KMG2OTf+/BZ6dwGqoN2Io9xsfz6JoGXRT5tx5xvq1CjPriXVkUviAr9vHFbp5vzr4l7h3yAqG3pRHtrooEdytzFiBL0B2ptfkW2WNeQoyvFE7xaIqc9vdv8atGxSS/BGPCp1RLzhmC9M++iV+HtlEY5YOO7P/rKNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir7EXn7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBF5C4CEF0;
	Mon, 22 Sep 2025 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758558801;
	bh=xMmGNRC++VxwgdXGhecb5pzo/fRO7nnjJ1/3o+lBhYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ir7EXn7SDJYv8gLjFwbbEPemzVsmpLsvC4+b1mSdgUeMwJP6u/5u656Rm9CDKjHba
	 eG9x9/oIt0ijkGY35g0zrAQOK1TtLyAegIsdEuo6zZhzGQ4QZPtCjZi/LoXGavaU6i
	 Y6kvuq2LAgBytIPKaVn5blQvGnyqNV0zArFbX/hT4N5DvrLvXdZuozjXESdBt+uBY8
	 ZOGzkd4dbRHA6Bbh81mOJuhxIr51BnuGIbzq4jwVgpn0uV0YVqEymlfSPYjMX95Drs
	 UGmcJXLXLAaGv4GMizdHYcZ7ggxvySUwF5jKwrFBCA++B4c7P0L8jWNzSvUGKHCDEA
	 qp6ECsjgOnfrA==
Date: Mon, 22 Sep 2025 22:03:12 +0530
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
Message-ID: <zlogycfwvdclx2wpxyzhdm7m5edsckcfscz4ddor5seyhmiyf4@kd7ueiga6aaq>
References: <nxcr6ymgspcdofoy7cv4lok34qqucwrm4cxn7a7spqrszgmvin@x3mhucqy2tb3>
 <20250922160041.GA1972113@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922160041.GA1972113@bhelgaas>

On Mon, Sep 22, 2025 at 11:00:41AM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 19, 2025 at 01:45:51PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Sep 18, 2025 at 01:53:56PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 17, 2025 at 03:53:25PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Sep 16, 2025 at 03:48:10PM GMT, Bjorn Helgaas wrote:
> > > > > On Fri, Sep 12, 2025 at 02:05:04PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > > 
> > > > > > For historic reasons, the pcie-qcom driver was controlling the
> > > > > > power supply and PERST# GPIO of the PCIe slot.
> > > > > 
> > > > > > This turned out to be an issue as the power supply requirements
> > > > > > differ between components. For instance, some of the WLAN
> > > > > > chipsets used in Qualcomm systems were connected to the Root
> > > > > > Port in a non-standard way using their own connectors.
> > > > > 
> > > > > This is kind of hand-wavy.  I don't know what a non-standard
> > > > > connector has to do with this.  I assume there's still a PCIe link
> > > > > from Root Port to WLAN, and there's still a PERST# signal to the
> > > > > WLAN device and a Root Port GPIO that asserts/deasserts it.
> > > > 
> > > > If we have a non-standard connector, then the power supply
> > > > requirements change.  There is no longer the standard 3.3v, 3.3Vaux,
> > > > 1.8v supplies, but plenty more.  For instance, take a look at the
> > > > WCN6855 WiFi/BT combo chip in the Lenovo X13s laptop:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts#n414
> > > > 
> > > > These supplies directly go from the host PMIC to the WCN6855 chip
> > > > integrated in the PCB itself. And these supplies need to be turned
> > > > on/off in a sequence also, together with the EN/SWCTRL GPIOs, while
> > > > sharing with the Bluetooth driver.
> > > 
> > > It sounds like the WCN6855 power supplies have nothing to do with the
> > > qcom PCIe controller, the Root Port, or any switches leading to the
> > > WCN6855.  And I guess the same for the wlan-enable, bt-enable, and
> > > swctrl GPIOs?
> > > 
> > >   wcn6855-pmu {
> > >           compatible = "qcom,wcn6855-pmu";
> > >           wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
> > >           bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
> > >           swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
> > >           regulators {
> > >                   vreg_pmu_rfa_cmn_0p8: ldo0 {
> > >                           regulator-name = "vreg_pmu_rfa_cmn_0p8";
> > >                   ...
> > > 
> > >   &pcie4_port0 {
> > >           wifi@0 {
> > >                   compatible = "pci17cb,1103";
> > >                   vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
> > >                   ...
> > > 
> > > But I guess PERST# isn't described in the same place (not in
> > > wcn6855-pmu)?  Looks like maybe it's this, which IIUC is part of the
> > > pcie4 host bridge?
> > > 
> > >   &pcie4 {
> > >           max-link-speed = <2>;
> > >           perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
> > >           wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
> > > 
> > > Does that mean this PERST# signal is driven by a GPIO and routed
> > > directly to the WCN6855?  Seems like there's some affinity between the
> > > WCN6855 power supplies and the WCN6855 PERST# signal, and maybe they
> > > would be better described together?
> > 
> > Yes, 'perst-gpios' is the PERST# signal that goes from the host
> > system to the WCN6855 chip. But we cannot define this signal in the
> > WCN6855 node as the DT binding only allows to define it in the PCI
> > bridge nodes. This is why it is currently defined in the host bridge
> > node. But when this platform switches to the per-Root Port binding,
> > this property will be moved to the Root Port node as 'reset-gpios'.
> 
> I'm questioning what the right place is to describe PERST#.  Neither
> the host bridge/Root Complex nor the Root Port has any architected
> support for asserting PERST#, so we can't write generic code to handle
> it.
> 

True.

> The PERST# signal is defined by the CEM specs, so can be physically
> included in a standard connector or cable that carries the Link.  The
> Link is originated by a Downstream Port, and the PCIe spec tells us
> how to operate the Link using the DP's Link Control, Link Status, etc.
> 
> But PERST# might not originate in the Downstream Port, and the spec
> doesn't tell us how to assert/deassert it, so I'm not sure it really
> fits in the same class as things like 'max-link-speed' and
> 'num-lanes'.  Maybe it doesn't need to be in either the host bridge or
> the Root Port?
> 

While I agree that PERST# has nothing to do with the Downstream Port, we don't
have any better way to represent it in devicetree. Either this has to be defined
in Host Bridge or Root Port/Bridge or Endpoint node. Currently, the devicetree
spec allows it to be defined in both Host Bridge and Root Port nodes, but not in
the Endpoint node. AFAIU, this is due to the fact that PERST# is a host
controlled signal, not device (unlike WAKE#). So we cannot put it in the
Endpoint node.

Moreover, if it is defined in the Host Bridge node, then we cannot do
PERST#<->device mapping in the case of multiple PERST# signals. So defining it
in the Root Port/Bridge node seemed to be the ideal place (till when there is a
single PERST# per slot/downstream port).

Maybe Rob could share more of the insight.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

