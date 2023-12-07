Return-Path: <linux-pci+bounces-609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA278084B8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 10:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292C328394F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E11341BD;
	Thu,  7 Dec 2023 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBXRsV2o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E132C61;
	Thu,  7 Dec 2023 09:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DE0C433C8;
	Thu,  7 Dec 2023 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701941483;
	bh=ic0z5MdiV/0Is1elWTXze/Uq9YLCT3pb49zs6lpdupM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBXRsV2obUFdVvgOkKaTQaGJdzTrnhg9uSomhvsreRT8HRHyc5IG+RMnyWtyzvZpb
	 f3GdVQvOTZ9gkuxJLMI83k4bELO1q4xaViHGbpt7ZmZEOqicjc3wqx3clO2sgBNsfZ
	 rV946/t9MsngKplwyDm0tMpjkfbYstmcymvkQDL+942ZbTuaaDQbJg7HH3oUqVYAJ6
	 9oQiTWxwzjNyCUxnuTX62sBPbCtXyLJ80kT4O408PLO/zLcUTwYGsO3ro106Y1xPUX
	 dtpHUO10E6Gy8eIxVOgLDweVqaJrguuBu1Qd7IP0bYqnVZJTVUaND7gjEQq4BTvHEz
	 z4SDPBma0Wxhg==
Date: Thu, 7 Dec 2023 15:01:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, thierry.reding@gmail.com, petlozup@nvidia.com,
	rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
	jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
	jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
	viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
	steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
	vidyas@nvidia.com
Subject: Re: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
Message-ID: <20231207093112.GH2932@thinkpad>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com>
 <20231206153627.GJ12802@thinkpad>
 <c86e8f75-f74a-491e-9ac0-2431a6ec4b80@nvidia.com>
 <20231207075952.GG2932@thinkpad>
 <6e282e1b-39d2-4a08-bdd4-a9d02b2b7f74@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e282e1b-39d2-4a08-bdd4-a9d02b2b7f74@nvidia.com>

On Thu, Dec 07, 2023 at 02:23:46PM +0530, Manikanta Maddireddy wrote:
> 
> On 07-12-2023 13:29, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Dec 07, 2023 at 12:54:04PM +0530, Manikanta Maddireddy wrote:
> > > On 06-12-2023 21:06, Manivannan Sadhasivam wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy wrote:
> > > > > Add PCIe port node under the PCIe controller-1 device tree node to support
> > > > > PCIe WAKE# interrupt for WiFi.
> > > > > 
> > > > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > > > ---
> > > > > 
> > > > > Changes in v14:
> > > > > New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
> > > > > 
> > > > >    .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 +++++++++++
> > > > >    1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > > > index 8a9747855d6b..9c89be263141 100644
> > > > > --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > > > +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > > > @@ -2147,6 +2147,17 @@ pcie@14100000 {
> > > > > 
> > > > >                         phys = <&p2u_hsio_3>;
> > > > >                         phy-names = "p2u-0";
> > > > > +
> > > > > +                     pci@0,0 {
> > > > > +                             reg = <0x0000 0 0 0 0>;
> > > > > +                             #address-cells = <3>;
> > > > > +                             #size-cells = <2>;
> > > > > +                             ranges;
> > > > > +
> > > > > +                             interrupt-parent = <&gpio>;
> > > > > +                             interrupts = <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
> > > > > +                             interrupt-names = "wakeup";
> > > > WAKE# should be part of the PCIe controller, not device. And the interrupt name
> > > > should be "wake".
> > > > 
> > > > - Mani
> > > Hi,
> > > 
> > > Please refer to the discussion in below link, WAKE# is per PCI bridge.
> > > https://patchwork.ozlabs.org/project/linux-pci/patch/20171226020806.32710-2-jeffy.chen@rock-chips.com/
> > > 
> > PCIe Host controller (RC) usually represents host bridge + PCI-PCI bridge. We do
> > not represent the PCI-PCI bridge in devicetree for any platforms, but only RC as
> > a whole.
> > 
> > Moreover, PERST# is already defined in RC node. So it becomes confusing if
> > WAKE# is defined in a child node representing bridge.
> > 
> > So please move WAKE# to RC node.
> > 
> > - Mani
> 
> Hi,
> 
> We can define PCI-PCI bridge in device tree, refer to below device tree
> which has 3 ports under a controller,
> with PERST#(reset-gpios) defined per port.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/apple/t8103.dtsi#n749
> 

Hmm. For RCs with single bridge, we never defined a DT node (atleast on Qcom
platforms). But I think it is the time to fix them.

> Also, of_pci_setup_wake_irq() in below patch is parsing "wakeup" from PCI
> bridge, not from the host bridge.
> https://patchwork.ozlabs.org/project/linux-pci/patch/20230208111645.3863534-4-mmaddireddy@nvidia.com/
> 

I didn't say that WAKE# should be parsed from host bridge, it doesn't make
sense. But I get your point.

> If a controller has only one port it has to define a PCI bridge under
> controller device tree node and
> add wakeup interrupt property, refer to below patch from original author.
> 
> https://www.spinics.net/lists/linux-pci/msg135569.html
> 

Yes, I agree. Thanks for the clarification.

- Mani

> Thanks,
> Manikanta
> > 
> > > I carried wakeup name defined in previous version, but wake seems to be
> > > sufficient.
> > > 
> > > Thanks,
> > > Manikanta
> > > > > +                     };
> > > > >                 };
> > > > > 
> > > > >                 pcie@14160000 {
> > > > > --
> > > > > 2.25.1
> > > > > 
> > > > --
> > > > மணிவண்ணன் சதாசிவம்
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

