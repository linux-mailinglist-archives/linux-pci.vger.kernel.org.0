Return-Path: <linux-pci+bounces-40456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6247C39452
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 07:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB393AC3CE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 06:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F42D94A7;
	Thu,  6 Nov 2025 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRJJ1H4J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69D2C235D;
	Thu,  6 Nov 2025 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410281; cv=none; b=f/XFpDHz6XstVk96n/CJ+H0+Gqa8KHRlDJ7BrVtS/XSwa76BuvMd56g6SZ7M6lqG8POGvknbp2ljyODYSlh8Ojabf9ccNHk1GwMBP9oKESdh6jh+bm+3iybrpzplfDRlx2Qds5dWrGYiMEnEaScyWF4M7p9GS2EZtAWJk+j0Gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410281; c=relaxed/simple;
	bh=27Pe8FUEHZhfluKmwcfeGnyxW6smtWLMLoJyzAni44c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJzJ1yTq5GC3BKp6eRIjmSF7t5dyzjQ/YMLj25rjUQuO9AfNCSY7Vn5mRuQiynM37YB8m/Ioh8mMFHTI5iZKzTb3ga9CjGyThxXBBkP8OidaW77C8/bc9vouZMJLJBsSkTelsNiIk3qdFBrRUsqGpXBkGieWRCGbn6i1XsUs/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRJJ1H4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519A4C4CEF7;
	Thu,  6 Nov 2025 06:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762410281;
	bh=27Pe8FUEHZhfluKmwcfeGnyxW6smtWLMLoJyzAni44c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRJJ1H4J3GeszBfV1hToQ3FtuV2IZEsEKV/wI2DSAElwJWUkObr/RtpW4V6AYAP7j
	 kzclCPXk+of9CsLTi2sSUCxjJBEAp546g7hVvQ5QLnmvK1fDLHtlC6tjVFdArJ7gGS
	 2h6x1fEGQtiQXr6udYxVlomrcH9shBfv2Q2TR65zqezowcDzPVs1L4B+f2/0aZ7poF
	 3lnYtSrjmzPzmz9HEpOO6+Jsma6kar+0PT7QVz2y1MTlYYiwQXrrDRWqjYv8evl2Fz
	 z118nreIhF0LaUS2a8xKhbsBrpnuKsHH1kXUf+LcthYry1Qt7DOczlxwYgaHUWUzy2
	 /5Snmb3l/In7g==
Date: Thu, 6 Nov 2025 11:54:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com, 
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, 
	bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, cassel@kernel.org, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Christian Bruel <christian.bruel@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <vrgjkulv22hzbx65olh3zpyqxq6dr7d5mepngjwgc3gudjoxwo@ll7xc2teya2s>
References: <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>
 <20251106000531.GA1930429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106000531.GA1930429@bhelgaas>

On Wed, Nov 05, 2025 at 06:05:31PM -0600, Bjorn Helgaas wrote:
> [+cc imx6, layerscape, stm32 maintainers for possible suspend bug]
> 
> On Fri, Oct 24, 2025 at 08:50:46AM +0200, Vincent Guittot wrote:
> > On Wed, 22 Oct 2025 at 21:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> > > > Add initial support of the PCIe controller for S32G Soc family. Only
> > > > host mode is supported.
> 
> > > > +static void s32g_init_pcie_controller(struct s32g_pcie *s32g_pp)
> > > > +{
> > > > ...
> > > > +     /*
> > > > +      * Make sure we use the coherency defaults (just in case the settings
> > > > +      * have been changed from their reset values)
> > > > +      */
> > > > +     s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> > >
> > > This seems sketchy and no other driver uses memblock_start_of_DRAM().
> > > Shouldn't a physical memory address like this come from devicetree
> > > somehow?
> > 
> > I was using DT but has been asked to not use it and was proposed to
> > use memblock_start_of_DRAM() instead
> 
> Can you point me to that conversation?
> 
> > > > +     s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> > > > +     if (IS_ERR(s32g_pp->ctrl_base))
> > > > +             return PTR_ERR(s32g_pp->ctrl_base);
> > >
> > > This looks like the first DWC driver that uses a "ctrl" resource.  Is
> > > this something unique to s32g, or do other drivers have something
> > > similar but use a different name?
> > 
> > AFAICT this seems to be s32g specific in the RM
> 
> It does look like there's very little consistency in reg-names across
> drivers, so I guess it's fine.
> 
> > > > +static int s32g_pcie_suspend_noirq(struct device *dev)
> > > > +{
> > > > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > > > +     struct dw_pcie *pci = &s32g_pp->pci;
> > > > +
> > > > +     if (!dw_pcie_link_up(pci))
> > > > +             return 0;
> > >
> > > Does something bad happen if you omit the link up check and the link
> > > is not up when we get here?  The check is racy (the link could go down
> > > between dw_pcie_link_up() and dw_pcie_suspend_noirq()), so it's not
> > > completely reliable.
> > >
> > > If you have to check, please add a comment about why this driver needs
> > > it when no other driver does.
> > 
> > dw_pcie_suspend_noirq returns an error and the suspend fails
> 
> The implication is that *every* user of dw_pcie_suspend_noirq() would
> have to check for the link being up.  There are only three existing
> callers:
> 
>   imx_pcie_suspend_noirq()
>   ls_pcie_suspend_noirq()
>   stm32_pcie_suspend_noirq()
> 
> but none of them checks for the link being up.
> 

If no devices are attached to the bus, then there is no need to broadcast
PME_Turn_Off and wait for L2/L3. I've just sent out a series that fixes it [1].
Hopefully, this will allow Vincent to use dw_pcie_{suspend/resume}_noirq() APIs.

- Mani

[1] https://lore.kernel.org/linux-pci/20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com/

-- 
மணிவண்ணன் சதாசிவம்

