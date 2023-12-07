Return-Path: <linux-pci+bounces-604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE901808248
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 09:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4905DB215CD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 08:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795561DA2E;
	Thu,  7 Dec 2023 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isIq0Z1Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4AB12E57;
	Thu,  7 Dec 2023 08:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB39C433C7;
	Thu,  7 Dec 2023 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701936004;
	bh=I681gHWMUSa0Ipi09gdgntlBhUESlz33stQ0H29C43o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isIq0Z1Zo2xyN9yQmONswOxPpZI/SHW+J6RK13AEY+reg6kdXEMFUqnajpRgxtE9p
	 TVYV2YD6CTK7DynnWBIwybKrVQ+38vg/j7jZCv11QEbzPwCzaZ1fi+hcB6G0rl91Ww
	 08D9+pnkkOBNUsF5+VBm5Uj0XtODYcCoArh+EJ7AZ2e7fmO0Eql9hVbjrMqW1zhXjH
	 bK/3tBQ4GkxuG34ULsud3h/+pMxbP54UdhZf+J3talfW3WZGQ2DML9ie2Kx5FPixLU
	 qoUKVBMRgBug4xnCswBjbfrpWFqO7gU0LBsRgvmAHzWVlPr13yWRaedbNqyiPYr7BV
	 Dz88b1LGr7pgg==
Date: Thu, 7 Dec 2023 13:29:52 +0530
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
Message-ID: <20231207075952.GG2932@thinkpad>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com>
 <20231206153627.GJ12802@thinkpad>
 <c86e8f75-f74a-491e-9ac0-2431a6ec4b80@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c86e8f75-f74a-491e-9ac0-2431a6ec4b80@nvidia.com>

On Thu, Dec 07, 2023 at 12:54:04PM +0530, Manikanta Maddireddy wrote:
> 
> On 06-12-2023 21:06, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy wrote:
> > > Add PCIe port node under the PCIe controller-1 device tree node to support
> > > PCIe WAKE# interrupt for WiFi.
> > > 
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > ---
> > > 
> > > Changes in v14:
> > > New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
> > > 
> > >   .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > index 8a9747855d6b..9c89be263141 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > @@ -2147,6 +2147,17 @@ pcie@14100000 {
> > > 
> > >                        phys = <&p2u_hsio_3>;
> > >                        phy-names = "p2u-0";
> > > +
> > > +                     pci@0,0 {
> > > +                             reg = <0x0000 0 0 0 0>;
> > > +                             #address-cells = <3>;
> > > +                             #size-cells = <2>;
> > > +                             ranges;
> > > +
> > > +                             interrupt-parent = <&gpio>;
> > > +                             interrupts = <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
> > > +                             interrupt-names = "wakeup";
> > WAKE# should be part of the PCIe controller, not device. And the interrupt name
> > should be "wake".
> > 
> > - Mani
> Hi,
> 
> Please refer to the discussion in below link, WAKE# is per PCI bridge.
> https://patchwork.ozlabs.org/project/linux-pci/patch/20171226020806.32710-2-jeffy.chen@rock-chips.com/
> 

PCIe Host controller (RC) usually represents host bridge + PCI-PCI bridge. We do
not represent the PCI-PCI bridge in devicetree for any platforms, but only RC as
a whole.

Moreover, PERST# is already defined in RC node. So it becomes confusing if
WAKE# is defined in a child node representing bridge.

So please move WAKE# to RC node.

- Mani

> I carried wakeup name defined in previous version, but wake seems to be
> sufficient.
> 
> Thanks,
> Manikanta
> > 
> > > +                     };
> > >                };
> > > 
> > >                pcie@14160000 {
> > > --
> > > 2.25.1
> > > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

