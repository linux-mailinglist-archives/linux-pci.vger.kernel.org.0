Return-Path: <linux-pci+bounces-1592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E58821986
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090B31C21A5E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F7D2E2;
	Tue,  2 Jan 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA0Nu7tG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5DD292;
	Tue,  2 Jan 2024 10:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C492C433C7;
	Tue,  2 Jan 2024 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704190668;
	bh=jiBwZ5dchDkw03vTAO8SBjv+oWAMHIaTv6i021/t1ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RA0Nu7tG1q3bcqfkaWEFMLFy0OwAWJShaIzJvdv8XEOhMyu+4MNeacs8eo9viwHAI
	 0FVF+6zGz+OYENdWGLEni2qL58xswCohz99Vu/upJMvGAFX4Cxqdji9umsYGPEuly2
	 5a9vugHP/4mwqk63JR3RUHdvaUD7Id1/EN+aHnctubIc5P+zy2y2VaSpMgJo2hbbtr
	 hgO2OmpJcN6CmnH6imffiLHuzUU2C2NBuy60d74wUvlOEXVcbtz/TFm+bxJd7yog5D
	 g2//k+xlO2FB8wqIGznKFEdL3878A5onz/K0eG1o/vemN0m0xBcVoCGnP+7BZ1sdUH
	 DUVHDY1XhaYAQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rKbq6-0002Ef-1M;
	Tue, 02 Jan 2024 11:17:39 +0100
Date: Tue, 2 Jan 2024 11:17:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: qcom: Reshuffle reset logic in 2_7_0 .init
Message-ID: <ZZPiwk1pbhLyfthB@hovoldconsulting.com>
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
 <20231227-topic-8280_pcie-v1-1-095491baf9e4@linaro.org>
 <ZY7R581pgn3uO6kk@hovoldconsulting.com>
 <fa0fbadc-a7c3-4bea-bed7-0006db0616dc@linaro.org>
 <ZY7l828-mSGXVwrk@hovoldconsulting.com>
 <598ede70-bc01-4137-b68b-981c3d420735@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598ede70-bc01-4137-b68b-981c3d420735@linaro.org>

On Sat, Dec 30, 2023 at 02:16:18AM +0100, Konrad Dybcio wrote:
> On 29.12.2023 16:29, Johan Hovold wrote:
> > [ Again, please remember to add a newline before you inline comments to
> > make you replies readable. ]
> > 
> > On Fri, Dec 29, 2023 at 04:01:27PM +0100, Konrad Dybcio wrote:
> >> On 29.12.2023 15:04, Johan Hovold wrote:
> >>> On Wed, Dec 27, 2023 at 11:17:19PM +0100, Konrad Dybcio wrote:
> >>>> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
> >>>> AUX_CLK will be stuck at 'off'.
> >>>
> >>> No, this path is exercised on every boot without the aux clock ever
> >>> being stuck at off. So something is clearly missing in this description.
> > 
> >> That's likely because the hardware has been initialized and not cleanly
> >> shut down by your bootloader. When you reset it, or your bootloader
> >> wasn't so kind, you need to start initialization from scratch.
> > 
> > What does that even mean? I'm telling you that this reset is asserted on
> > each boot, on all sc8280xp platforms I have access to, and never have I
> > seen the aux clk stuck at off.
> > 
> > So clearly your claim above is too broad and the commit message is
> > incorrect or incomplete.
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index 0b7801971dc1..6650bd6af5e3 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -7566,6 +7566,18 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_put_rpm;
>  
> +       int val;
> +       regmap_read(regmap, 0xa0000, &val);
> +       pr_err("GCC_PCIE_3A_BCR = 0x%x\n", val);
> +       regmap_read(regmap, 0xa00f0, &val);
> +       pr_err("GCC_PCIE_3A_LINK_DOWN_BCR = 0x%x\n", val);
> +       regmap_read(regmap, 0xa00fc, &val);
> +       pr_err("GCC_PCIE_3A_NOCSR_COM_PHY_BCR = 0x%x\n", val);
> +       regmap_read(regmap, 0xa00e0, &val);
> +       pr_err("GCC_PCIE_3A_PHY_BCR = 0x%x\n", val);
> +       regmap_read(regmap, 0xa00e4, &val);
> +       pr_err("GCC_PCIE_3A_PHY_NOCSR_COM_PHY_BCR = 0x%x\n", val);
> +
>         pm_runtime_put(&pdev->dev);
>  
>         return 0;
> 
> 
> [root@sc8280xp-crd ~]# dmesg | grep BCR
> [    2.500245] GCC_PCIE_3A_BCR = 0x0
> [    2.500250] GCC_PCIE_3A_LINK_DOWN_BCR = 0x0
> [    2.500253] GCC_PCIE_3A_NOCSR_COM_PHY_BCR = 0x0
> [    2.500255] GCC_PCIE_3A_PHY_BCR = 0x0
> [    2.500257] GCC_PCIE_3A_PHY_NOCSR_COM_PHY_BCR = 0x0
> 
> 
> 0 meaning "not asserted".

We're clearly talking past each other. When I'm saying reset is asserted
on each boot, I'm referring to reset being asserted in
qcom_pcie_init_2_7_0(), whereas you appear to be referring to whether
the reset has been left asserted by the bootloader when the driver
probes.

I understand what you meant to say now, but I think you should rephrase:

	At least on SC8280XP, if the PCIe reset is asserted, the
	corresponding AUX_CLK will be stuck at 'off'.

because as it stands, it sounds like the problem happens when the driver
asserts reset.

> PCIE3A is used for WLAN on the CRD, btw.

You meant to say WWAN (modem).

> >>>> Assert the reset (which may end up being a NOP if it was previously
> >>>> asserted) and de-assert it back *before* turning on the clocks to avoid
> >>>> such cases.
> >>>>
> >>>> In addition to that, in case the clock bulk enable fails, assert the
> >>>> RC reset back, as the hardware is in an unknown state at best.
> >>>
> >>> This is arguably a separate change, and not necessarily one that is
> >>> correct either
> > 
> >> If the clock enable fails, the PCIe hw is not in reset state, ergo it
> >> may be doing "something", and that "something" would eat non-zero power.
> >> It's just cleaning up after yourself.
> > 
> > How can it do something without power and clocks?
> 
> Fair point.
> 
> As far as power goes, the RC hangs off CX, which is on whenever the
> system is not in power collapse. As for clocks, at least parts of it
> use the crystal oscillator, not sure if directly.
> 
> > And leaving reset
> > asserted for non-powered devices is generally not a good idea.
> 
> Depends on the hw.

That's why I said "generally".

> > The commit message does not even mention suspend, it just makes a
> > clearly false general claim about a clock being stuck unless you reorder
> > things.
> 
> No, I insist that this general statement, while indeed lacking a full
> description of the problem, is provably true. The AUX clock will not
> turn on if the PCIe reset is asserted, at least on SC8280XP.

I agree, I was misinterpreting the commit message.

Johan

