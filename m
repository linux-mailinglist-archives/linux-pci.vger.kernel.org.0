Return-Path: <linux-pci+bounces-37216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7060BAA051
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8829F3AF19C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80C30B509;
	Mon, 29 Sep 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAdycMFq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991919F13F;
	Mon, 29 Sep 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163566; cv=none; b=nbuSN2dBCNwVb4CBE2EaoHkGV/kcgztXZ2DdG9y3drLzNyRDL8Z9ZSzPeRZfh88mTZw+9acYE2tBF1uPCZFLq1gwi3eQU02aDEjuLk0mc7PzYb4falr2PxcEQZr0gC2hj1T943TZNwtB8C7mZU/IZHOqNoJDwtfZe7SAqmq9bSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163566; c=relaxed/simple;
	bh=00sU9i2+IMQ2HaKjeSE/V2mVCUpqM5rcBpzmZjk3ga8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPuT6bmS0xf4wM8IFburizS0EaXZYanjTu9Wq0F/oJFzyL5LlIE8iwfTF9g7aYm2UCzO97qubwNeZtnvVD06qeQv2+yO5QlcqjqbW2EY6rhWKRSLe4jzji/I/t0AKdWpkOAtngyOVMwL+YDMLjKQ3yCOtdBR0k5FDkXITFRSC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAdycMFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFFC4CEF4;
	Mon, 29 Sep 2025 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759163566;
	bh=00sU9i2+IMQ2HaKjeSE/V2mVCUpqM5rcBpzmZjk3ga8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAdycMFqGnevhFuZjQV+y/lH0d8Khsf+9oRa+hz+ueJLA6nf0nm04lTsdktX8Tjr0
	 kdKVtdRrPjPsHwV4CgknI6aHLPsifuoRBSBPtEyMRlBe2/2enF9t47MFWPIpxK8A8f
	 empkHAWjQqVjjsyfv2EXwUjEAZ0bwSMWFg0xvzYjrWle7g0ZDVTBkjPvgQrE0eGAXv
	 x6/QGri5YE9/CIFv+HAa6oQ59SvTueYS5KQ2wWtxprHHdSaAlzNKRkr9zWMJc0IEs5
	 ysFRmWvJolOUvz7bjnMw3DZOztGtg90aKXAr4DwR7UybuAdJyDN3jYDS14B66oPJTb
	 78hTI6C7GhUeA==
Date: Mon, 29 Sep 2025 22:02:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	Frank.li@nxp.com, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Subject: Re: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <xmjgs5ssolugcq2ogjc5j3ccwalcc4q3whl64fcra2aiebhtci@qwobbjtb2wcl>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-3-vincent.guittot@linaro.org>
 <4ee5tqdjv5ogcdtysiebtoxmrvrzhkar4bjcsqi47dxtgwac4c@rezn4waubroh>
 <CAKfTPtAEkegCV-9_x-dXSWQFOoG6kO5JbJq_LToY9YuuRusoVA@mail.gmail.com>
 <lmczw5agheqbcl6xcomlhf7yfbdvfx45pozmaxjmbkkqudsxlu@c7u6s5h4xm6j>
 <CAKfTPtCacFhJztYvWycSdoWMUStaf1WAcGJKHwk3y4n-uEELSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCacFhJztYvWycSdoWMUStaf1WAcGJKHwk3y4n-uEELSw@mail.gmail.com>

On Mon, Sep 29, 2025 at 06:23:05PM +0200, Vincent Guittot wrote:

[...]

> > > > > +static int s32g_pcie_resume(struct device *dev)
> > > > > +{
> > > > > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > > > > +     struct dw_pcie *pci = &s32g_pp->pci;
> > > > > +     struct dw_pcie_rp *pp = &pci->pp;
> > > > > +     int ret = 0;
> > > > > +
> > > > > +     ret = s32g_pcie_init(dev, s32g_pp);
> > > > > +     if (ret < 0)
> > > > > +             return ret;
> > > > > +
> > > > > +     ret = dw_pcie_setup_rc(pp);
> > > > > +     if (ret) {
> > > > > +             dev_err(dev, "Failed to resume DW RC: %d\n", ret);
> > > > > +             goto fail_host_init;
> > > > > +     }
> > > > > +
> > > > > +     ret = dw_pcie_start_link(pci);
> > > > > +     if (ret) {
> > > > > +             /*
> > > > > +              * We do not exit with error if link up was unsuccessful
> > > > > +              * Endpoint may not be connected.
> > > > > +              */
> > > > > +             if (dw_pcie_wait_for_link(pci))
> > > > > +                     dev_warn(pci->dev,
> > > > > +                              "Link Up failed, Endpoint may not be connected\n");
> > > > > +
> > > > > +             if (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL)) {
> > > > > +                     dev_err(dev, "Failed to get link up with EP connected\n");
> > > > > +                     goto fail_host_init;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     ret = pci_host_probe(pp->bridge);
> > > >
> > > > Oh no... Do not call pci_host_probe() directly from glue drivers. Use
> > > > dw_pcie_host_init() to do so. This should simplify suspend and resume functions.
> > >
> > > dw_pcie_host_init() is doing much more than just init the controller
> > > as it gets resources which we haven't released during suspend.
> > >
> >
> > Any specific reason to keep resources enabled, even though you were removing the
> > Root bus? This doesn't make sense to me.
> 
> By ressources I mean everything before  dw_pcie_setup_rc()  in
> dw_pcie_host_init() which are still there after dw_pcie_host_deinit()
> in addition to being a waste of time. Also we don't need to remove
> edma and free msi
> 

Let me take a step back and ask, why do you need to remove Root bus during
suspend() and not just disable LTSSM with dw_pcie_stop_link()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

