Return-Path: <linux-pci+bounces-1582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D27C88214C1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 18:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5B8281ABD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 17:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFE48F4E;
	Mon,  1 Jan 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXIidgFC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B1945F;
	Mon,  1 Jan 2024 17:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5DDC433C7;
	Mon,  1 Jan 2024 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704130271;
	bh=IpekLPO/bhpfBR6SUNYWxaC/ReSzdsaQ7WSCC67bnig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXIidgFCydJ7lOwp6GAux/HddHuebpNAQQLZb3D+Tgqcf+IHFk0IxV8SphswNb5DF
	 CMIsrE0G38xmLC7IP+diwVNBx7VUcV61TLdPPx/hI501JeghX9+26nRB5YryGFBjZR
	 3bsOIjF6d0A7MSrWxmm4rXYQWCJuqEDk4Wv9dXxAA6UJycXqEsjrzlQCMBptPRaWOP
	 4reTQ3QGMvi/WU5VEcffQ/B5ANtkx3F81G4NF0/Ng+4tDIRRWjxWjjAxANtiGbBiZV
	 GjxCtmCbJSbr6zuyucTecnzo+4VHFGFyN+87UPqrY6Tk9K1jiAAp+klxhm366IuFUu
	 MTov9lRWd2KiQ==
Date: Mon, 1 Jan 2024 23:01:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20240101173100.GB3280@thinkpad>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> 
> Adding the read in the GCC driver .probe ensures we get the
> unmodified data, as all GCC consumers must wait for it to probe. 
> 
> PCIE3A is used for WLAN on the CRD, btw.
> 

I get what you are trying to do, but I should say that your justification so far
didn't do the justice.

Your point is that, if the PCIe BCR is asserted during boot (which can happen if
the bootloader didn't initialize PCIe for things like storage), then trying to
enable clocks will result in the "clk stuck" error from GCC. But in the case of
sc8280xp, bootloader would've already initialized PCIe during boot as it is uses
NVMe for things like firmware. But when you do a full power down during suspend
(CX power collapse), then while reinitializing the controller during resume, you
are hitting the "clk stuck" error because at that time, the BCR reset would be
asserted (POR value).

But I really suspect if that is the case... Because, the same init function is
being used by other SoCs (sm8150, sm8250, etc... even sdx55) and I'm pretty sure
that in those SoCs, the bootloader wouldn't have initialized PCIe during boot as
there is no use case.

So I cross checked it on SM8450, but I saw the BCR status being "0" during boot
(same as on sc8280xp). Then I checked the HPG and came to know that when the
PCIe GDSC is uncollapsed, some of the BCRs would be deasserted in the back.
Though it mentioned only PHY_BCR and not the PCIE_n_BCR. But I think the
behavior might be same for both. You can verify it by printing the state of all
BCRs during resume from suspend. This will give us some clue...

> >  
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
> 

I do not have any strong argument here as there are too many things happening
that determines whether the controller is properly powered or not. So I'd say
that if you do not have any power numbers, it is best to leave it as it is.

- Mani

> >  
> >>> so should at least go in a separate patch if it should
> >>> be done at all.
> > 
> >> I'll grumpily comply..
> > 
> > I suggest you leave it deasserted unless you have documentation
> > suggesting that the opposite is safe and recommended for this piece of
> > hardware.
> >  
> >>>> Fixes: ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe controller")
> >>>
> >>> I think you're being way to liberal with your use of Fixes tags. To
> >>> claim that this is a bug, you need to make a more convincing case for
> >>> why you think so.
> > 
> >> The first paragraph describes the issue that this patch fixes.
> > 
> > Yes, but this is all very hand-wavy so far. With a complete commit
> > message I may agree, but you still haven't convinced me that this is a
> > bug and not just a workaround from some not fully-understood issue on
> > one particular platform.
> 
> Right, reading it again, it doesn't really tell the whole story.
> 
> >  
> >>> Also note Qualcomm's vendor driver is similarly asserting reset after
> >>> enabling the clocks.
> > 
> >> It's also not asserting the reset on suspend, see below.
> > 
> > Right, as I mentioned.
> >  
> >>> That driver does not seem to reset the controller on resume, though, in
> >>> case that is relevant for your current experiments.
> > 
> >> I know, the vendor driver doesn't fully shut down the controller. This
> >> is however the only sequence that we (partially) have upstream, and the
> >> only one that is going to work on SC8280XP (due to hw design).
> >>
> >> On other platforms, a "soft shutdown" (i.e. dropping the link, cutting
> >> clocks but not fully resetting the RC state) should be possible, but
> >> that's not what this patchset concerns.
> > 
> > The commit message does not even mention suspend, it just makes a
> > clearly false general claim about a clock being stuck unless you reorder
> > things.
> 
> No, I insist that this general statement, while indeed lacking a full
> description of the problem, is provably true. The AUX clock will not
> turn on if the PCIe reset is asserted, at least on SC8280XP.
> 
> Konrad

-- 
மணிவண்ணன் சதாசிவம்

