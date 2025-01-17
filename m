Return-Path: <linux-pci+bounces-20077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E07A1587F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 21:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59771686C3
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 20:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F21A9B52;
	Fri, 17 Jan 2025 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WePJh3Pd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0295187550;
	Fri, 17 Jan 2025 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737145631; cv=none; b=t/UQgskh6Cvet4cxH5FpPbcsVkVV8TMJHEH3/2/m+ZS0GFVToYjKQx78l7ZjNvOGWuzZNIlo1GNCOjpITXbCJo0Oz5IgJm+vMTK/PeTwDYF8ss38fAagJq+2QyhEBNgHGhTv4aZfXmxmYkrOtNtlfb1db1PKTHAOTPFzbcbdn4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737145631; c=relaxed/simple;
	bh=Ct2YwrpPXaoKNAMpYvMgQTLQEkb+M++rRR9iD27FrGs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m+S0dKtkOWJa6FpVeRY/NGLQ5+udBaLxlK4zGM8xoTYfy7MdPDnCkjDywzeiBId8SiR+2AvOFaQDQ4FZmTiRmJ2Oyw1NNnto+6yxiWFGC1ZLGaxKTkcS/Bn4ZHP8NghfFe/pM28CabyK921A89bQnwws38JpUoKjnPYstH3LvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WePJh3Pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23304C4CEDD;
	Fri, 17 Jan 2025 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737145630;
	bh=Ct2YwrpPXaoKNAMpYvMgQTLQEkb+M++rRR9iD27FrGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WePJh3Pd3VRkENxPcR2AjlfdrFrhh6XiJCNEs5yil1pXBj1r7qSUqyRAAIhUr0tTe
	 yLw/0awyrdE0kFMpTrQUxFAHKNV6rb8Ld7SwKsxUt+uFTcW2pH5vvZhn3u7a9ZlQuL
	 E1DiIf54u25Wha4Kcx5n0D2YsLVfey3VtB4rr7wVybECAUi1jWc5IQ8xMvciQsbDW+
	 fLgcAocAs2EC0a2398UniivYGe/K1iqxkqCzPzhIV8tF7AW9JBL/vS7RIoSWTSvVPq
	 0ExGWvIVc/F2vO4/QYxNCoCpmiSBVycmx0sYSfTQxlA6ULNVU9ihg+yd52bJtEcQAw
	 u5f9J7U4tAyCg==
Date: Fri, 17 Jan 2025 14:27:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com,
	dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Praveenkumar I <quic_ipkumar@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Message-ID: <20250117202708.GA655559@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4dqnr9+MTue3VbX@hu-varada-blr.qualcomm.com>

On Wed, Jan 15, 2025 at 01:28:22PM +0530, Varadarajan Narayanan wrote:
> On Wed, Jan 08, 2025 at 12:32:35PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 02, 2025 at 05:00:18PM +0530, Varadarajan Narayanan wrote:
> > > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> > >
> > > Add phy and controller nodes for pcie0_x1 and pcie1_x2.

> > > +		pcie1: pcie@18000000 {
> > > +			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
> > > +			reg = <0x00088000 0x3000>,
> > > +			      <0x18000000 0xf1d>,
> > > +			      <0x18000f20 0xa8>,
> > > +			      <0x18001000 0x1000>,
> > > +			      <0x18100000 0x1000>,
> > > +			      <0x0008b000 0x1000>;
> > > +			reg-names = "parf",
> > > +				    "dbi",
> > > +				    "elbi",
> > > +				    "atu",
> > > +				    "config",
> > > +				    "mhi";
> > > +			device_type = "pci";
> > > +			linux,pci-domain = <1>;
> > > +			bus-range = <0x00 0xff>;

> > > +			num-lanes = <2>;
> > > +			phys = <&pcie1_phy>;
> > > +			phy-names = "pciephy";
> >
> > I think num-lanes and PHY info are per-Root Port properties, not a
> > host controller properties, aren't they?  Some of the clock and reset
> > properties might also be per-Root Port.
> >
> > Ideally, I think per-Root Port properties should be in a child device
> > as they are here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/mvebu-pci.txt?id=v6.12#n137
> > but it looks like the num-lanes parsing is done in
> > dw_pcie_get_resources(), which can only handle a single num-lanes per
> > DWC controller, so maybe it's impractical to add a child device here.
> >
> > But I wonder if it would be useful to at least group the per-Root Port
> > things together in the binding to help us start thinking about the
> > difference between the controller and the Root Port(s).
> 
> This looks like a big change and might impact the existing
> SoCs/platforms. To minimize the impact, should we continue
> supporting the legacy method in addition to the new per-Root port
> approach. Should we take this up separately? Kindly advice.

I just meant to change the order they're listed in the binding, not
add any new device stanzas.

E.g., maybe it could be arranged like this, where things that apply to
the Root Complex as a whole (bus-range, #address-cells, #size-cells,
ranges, etc) are listed first, and the Root Port-related things
(num-lanes, phys, etc) are listed later:

+               pcie1: pcie@18000000 {
+                       compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
+                       device_type = "pci";
+                       linux,pci-domain = <1>;
+                       bus-range = <0x00 0xff>;
+                       #address-cells = <3>;
+                       #size-cells = <2>;
+
+                       ranges = <0x01000000 0 0x18200000 0x18200000 0 0x00100000>,
+                                <0x02000000 0 0x18300000 0x18300000 0 0x07d00000>;
+                       interrupts = <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>, ...
+                       clocks = <&gcc GCC_PCIE3X2_AXI_M_CLK>, ...
+                       resets = <&gcc GCC_PCIE3X2_PIPE_ARES>, ...
+                       interconnects = <&gcc MASTER_SNOC_PCIE3_2_M ...

Everything above is potentially shared; everything below applies to a
single (the only one in this case) Root Port.

+                       num-lanes = <2>;
+                       phys = <&pcie1_phy>;
+
+                       status = "disabled";
+               };

I want people to think about which things belong to the Root Port and
which are shared for the whole Root Complex.

For new drivers, I think we should actually add "pcie@1,0" stanzas for
each Root Port, even if there is only one.

But for existing drivers that would have to be modified to comprehend
new stanzas, collecting the Root Port things so they are together in
the PCI controller stanza would be a good start (unless the order of
properties in the DT makes a functional difference, of course).

Bjorn

