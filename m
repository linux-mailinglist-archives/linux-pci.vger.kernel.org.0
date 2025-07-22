Return-Path: <linux-pci+bounces-32725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A89B0D982
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40F03A5096
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610E2E9729;
	Tue, 22 Jul 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfifZ1wo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8280244695;
	Tue, 22 Jul 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186951; cv=none; b=Fe0kT06jdiuEz5/3U7pBx/+ore8D/0xVyoucnq8KgYi7DTgyHKDTYLh1+V+R5diok2WugBxmdkFlPhHcQ+g557lYVffx/s2IDVJqnMFgmUEDrCKlei78PaFpdCgTYWTpdUh9gvtlfeZR5iQyzGS5GCCDBh5Cj7s48i1NW2+oNwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186951; c=relaxed/simple;
	bh=tsa1Roe7wGwli/LZJRe4GgFwBYhR9gq3UlMLlPNQNc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USOxgE+5qKHuw2TCPDY0ruvtyGYtPvlKufUSNIrqzsv+beqipn88GT1bswkJ+m+jFquAOhRd0OvxnysSESEDpb+xTKH6w60AcXhsgc7g/bT5UHNO4cHVf7OTpvsy5vc7Ie+TH0HW88wndvRDAILPclJZVAXjjX591KrqaiyMecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfifZ1wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6B4C4CEEB;
	Tue, 22 Jul 2025 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753186950;
	bh=tsa1Roe7wGwli/LZJRe4GgFwBYhR9gq3UlMLlPNQNc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfifZ1woUL7CNtXmT7O6E5+ES5/yr5VykYclG/J7ymFsOoncvwXwNQEqTpluFaYNH
	 KOxyeLKuNNC8vqdCKFFcAdqhDMId6oC+wvgtrtE/CkqYOiSv6VeVVUzV0MRS+w8d5V
	 fJdS3eaOOhunXeQk05MOpiR5CAvSu/FRhV5xe+WKBfMPhlCTKQiXeHRJl8Y56hsn6n
	 T1+j5LDOM8rWFGA/d1UAVlESp7qW7UcsV95H7xYISg9x3qUk30/3wIELRXxRNO9Mhc
	 o1ks4itqkjiLGHUEyxe7gS/Vz1DQSTHTG3bjtWXReT7sWi6kpuBBvq/R5ocftfCoHG
	 Ne0gcnGzvy8cw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueC0h-000000002qX-1Zj5;
	Tue, 22 Jul 2025 14:22:20 +0200
Date: Tue, 22 Jul 2025 14:22:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
Message-ID: <aH-Ce0obEcm1S2N9@hovoldconsulting.com>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
 <20250718081718.390790-4-ziyue.zhang@oss.qualcomm.com>
 <aHobmsHTjyJVUtFj@hovoldconsulting.com>
 <86e14d55-8e96-4a2d-a9e8-a52f0de9dffd@oss.qualcomm.com>
 <c7342ed4-5705-4206-8999-e11d13bea1f2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7342ed4-5705-4206-8999-e11d13bea1f2@oss.qualcomm.com>

On Tue, Jul 22, 2025 at 01:13:34PM +0800, Ziyue Zhang wrote:
> On 7/18/2025 6:53 PM, Konrad Dybcio wrote:
> > On 7/18/25 12:02 PM, Johan Hovold wrote:
> >> On Fri, Jul 18, 2025 at 04:17:17PM +0800, Ziyue Zhang wrote:
> >>> gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
> >>> pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
> >>> replace it with gcc_phy_aux_clk.
> >> Expanding on why this is a correct change would be good since this does
> >> not yet seem to have been fully resolved:
> >>
> >> 	https://lore.kernel.org/lkml/98088092-1987-41cc-ab70-c9a5d3fdbb41@oss.qualcomm.com/

> > I dug out some deep memories and recalled that _PHY_AUX_CLK was
> > necessary on x1e for the Gen4 PHY to initialize properly. This
> > can be easily reproduced:

> > @@ -3312,7 +3312,7 @@ pcie3_phy: phy@1be0000 {
> >                          compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy";
> >                          reg = <0 0x01be0000 0 0x10000>;
> >   
> > -                       clocks = <&gcc GCC_PCIE_3_PHY_AUX_CLK>,
> > +                       clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
> >                                   <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
> >                                   <&tcsr TCSR_PCIE_8L_CLKREF_EN>,
> >                                   <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>,
> >
> > ==>
> > [    6.967231] qcom-qmp-pcie-phy 1be0000.phy: phy initialization timed-out
> > [    6.974462] phy phy-1be0000.phy.0: phy poweron failed --> -110
> >
> > And the (non-PHY_)AUX_CLK is necessary for at least one of them, as
> > removing it causes a crash on boot

Thanks for checking. I too had noticed that the pcie4 and pcie5 was
using the non-phy aux clocks, and those are indeed gen3.

> I tried remove PHY_AUX_CLK in sa8775p platform like this, and
> it will cause a crash on boot. And I checked the clock documentation
> for sa8775p and found that the PHY_AUX_CLK  is also required.

Thanks, would still be good to say something in the commit message about
the difference between the PHY_AUX_CLK and AUX_CLK clocks and why
(only?) the gen4 PHYs need it (we seem to have other Qualcomm non-gen4
PHYs using the PHY_AUX clock too).

That is, please clarify which PHYs need the PHY_AUX_CLK and why they
don't also need the AUX_CLK like some PHYs do.

Johan

