Return-Path: <linux-pci+bounces-41406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1FC6453E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47E894E752D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F8330B11;
	Mon, 17 Nov 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c550pCdk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08930CD8B;
	Mon, 17 Nov 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385438; cv=none; b=qJE0v06Jut7TZYpFX2+dzjl0X4qQ1oVcJqws648lTCL0RMn+fajn941PrNgxK7XC9XqjpkLVXbBCEFhs1xlYTSM2mS5qs2emUF/AJzd0UQs1dfjDT8hYs+eyoegWT3FfwNukjbRCZ2V7KZ6IOIS3lmmM1g3inmPKPBELEkutgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385438; c=relaxed/simple;
	bh=xxRVdtfTiOQTO2jyXwimxqWcnuxgrlQL288pVe0i6qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEoyfZ+oJ6NusewLR3veCPwBcYpdDbgFsyIJ36FgMEOn2HPL1KtNjUMIjlmxXfsRL8FLSYMAqz+X6kWxm6nW51fQ1nD5MXE7o7Zx2eqZ/pFxI3W7c8bZvH0TEdb9r2/qFT3YP/0l6N2hdLlvpmzcbz+PScD/QuKPfXc3RgMkbSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c550pCdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1280AC113D0;
	Mon, 17 Nov 2025 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763385438;
	bh=xxRVdtfTiOQTO2jyXwimxqWcnuxgrlQL288pVe0i6qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c550pCdkJK+yNP+DqSVvgoIJBsW5teGVE/5W3xmfUaLaCBThmuk6hVhdtUlBiF7by
	 9jlT5Jh/yvA9YhcGpMQ1u8uASYsLwvKT/uRST5Roi8Vnlnh7fVWaCNufPO1LAeHX+K
	 n6EmpyuEPUAfZYq8ZnhIQIqr+8k42SYM12NdHdlzkmgi9KIuJj+NrXzcW2YzbvHR3D
	 KmiQIlFhd8FdBdGNGaGf43d6sPx9z9hcSecSYDWUaJrXRm1FMTkgYxMi1SJZud2CXv
	 mewJQAaui7JyPnt0PCiMXwbLgR+Sfucy+bp71fdeTcqLiMHSpEPXhb1fs3ggQMNVgT
	 ABimt9Z0vvmuA==
Date: Mon, 17 Nov 2025 18:47:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Alex Elder <elder@riscstar.com>, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, dlan@gentoo.org, 
	aurelien@aurel32.net, johannes@erdfelt.com, p.zabel@pengutronix.de, 
	christian.bruel@foss.st.com, thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com, 
	mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com, shradha.t@samsung.com, 
	inochiama@gmail.com, guodong@riscstar.com, linux-pci@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] PCI: spacemit: Add SpacemiT PCIe host driver
Message-ID: <7f5r2lnlrsltowfninu76bivebgwkr5i3pdorj3hywg22mtmdz@m35cpser6opt>
References: <20251113214540.2623070-1-elder@riscstar.com>
 <20251113214540.2623070-6-elder@riscstar.com>
 <f55e2df3fcd025148b7262c3753e5136cc324b09.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f55e2df3fcd025148b7262c3753e5136cc324b09.camel@gmail.com>

On Mon, Nov 17, 2025 at 01:01:04PM +0000, Vitor Soares wrote:

[...]

> > +static int k1_pcie_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct k1_pcie *k1;
> > +       int ret;
> > +
> > +       k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
> > +       if (!k1)
> > +               return -ENOMEM;
> > +
> > +       k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
> > +                                                      SYSCON_APMU, 1,
> > +                                                      &k1->pmu_off);
> > +       if (IS_ERR(k1->pmu))
> > +               return dev_err_probe(dev, PTR_ERR(k1->pmu),
> > +                                    "failed to lookup PMU registers\n");
> > +
> > +       k1->link = devm_platform_ioremap_resource_byname(pdev, "link");
> > +       if (IS_ERR(k1->link))
> > +               return dev_err_probe(dev, PTR_ERR(k1->link),
> > +                                    "failed to map \"link\" registers\n");
> > +
> > +       k1->pci.dev = dev;
> > +       k1->pci.ops = &k1_pcie_ops;
> > +       k1->pci.pp.num_vectors = MAX_MSI_IRQS;
> > +       dw_pcie_cap_set(&k1->pci, REQ_RES);
> > +
> > +       k1->pci.pp.ops = &k1_pcie_host_ops;
> > +
> > +       /* Hold the PHY in reset until we start the link */
> > +       regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
> > +                       APP_HOLD_PHY_RST);
> > +
> > +       ret = devm_regulator_get_enable(dev, "vpcie3v3");
> > +       if (ret)
> > +               return dev_err_probe(dev, ret,
> > +                                    "failed to get \"vpcie3v3\" supply\n");
> > +
> 
> Hi,
> 
> While investigation a similar PCIe setup, I come across this patch series and
> had a question regarding regulator handling.
> 
> In the patch, the host controller explicitly enables the vpcie3v3. However, the
> pci-pwctrl-slot driver (compatible pciclass,0604) is also instantiated via
> device tree and is supposed to manage the slot supply.
> 
> I'm wondering whether it's actually necessary to enable the regulator in the
> host controller, since the slot driver should already take care of it. However,
> in my tests, the endpoint is not discovered unless the host driver enables the
> regulator early. It's not entirely clear whether this is due to the PHY and
> reset sequence, or the timing of the vpcie3v3 regulator activation.
> 
> @Manivannan: In the patch, the host controller driver enables the vpcie3v3
> regulator, even though the pci-pwrctrl-slot driver (pciclass,0604) is supposed
> to manage it. Is this duplication intentional, or is there a preferred way to
> ensure the supply is active before bus scanning? Any guidance would be
> appreciated.
> 

Yes, the regulator handling is duplicated now. This is due to missing PERST#
handling in the pwrctrl-slot driver. We are working on a series to be posted
this week that will fix this issue, but until then, pwrctrl-slot driver is not
reliable to power up the endpoint. So I've asked Alex to handle the regulator
and PERST# in the controller driver for now. Once my rework series gets merged,
this part can be dropped from the controller driver and there is no change
required in the binding/dts.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

