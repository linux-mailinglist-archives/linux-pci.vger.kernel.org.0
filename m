Return-Path: <linux-pci+bounces-44371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DFDD0AED7
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 16:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D68CB3092B2F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B635BDBF;
	Fri,  9 Jan 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7q+/jLq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E04320A0B;
	Fri,  9 Jan 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972472; cv=none; b=rvSbAcoQIqgMO0oBtnFy4Jh2vtvmivu2V3KXG9YwV9z9O+Xska/PD0K4TQybKBcO9+aT4/TCXugUP6zAB/WQ+B7vzAPr5TbzJQynuQPFGOcJ38oCpxSoIxTua4n8ldTZMMSmE1bj7jfT9YUt166AzwOrpsNVFdtf13gMV+p+qXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972472; c=relaxed/simple;
	bh=3jT1bPp2jAjL1e9B+m/2zxJkpLEgA9Jqq3llmKYGRE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MmK9EBl2X0dtdLBPDpSk7QAHPnKdnVLz23vpBmoYc462O2KdcZXv/5xBUNNDzXz3NdOH1wU8Iik8mQRfymy0VY1q0AaIImSKXOM1GjkoJLJ7WYHe4UcNpP0+CdOfswfN11HmRHK+0+HGFgp8/+aTZFMjbcvZU6QcqiCFFC2zl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7q+/jLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FB2C4CEF1;
	Fri,  9 Jan 2026 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767972472;
	bh=3jT1bPp2jAjL1e9B+m/2zxJkpLEgA9Jqq3llmKYGRE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A7q+/jLq9PLESbVwGX9xCVfHvYVeMw5bbr2mb8E0gN6K4yZENLpDPaGJoW41tEfX7
	 Nc0+n7oWvo3F0zui9FpB5XnLLG7SsqVFkU3xgcAwRtt8zblCstEnYQfV0108zJpLlS
	 LKKdEIoR6C/NdoLF74N+WFdJHKXwCvPP4cxjdPfGRqzUtd9mdM2Nu02u4E1w/+ynsS
	 uHEydFVQ0wEopcbkb4JtyZNAnlspdwRKpdWYwssTPg1OXdmjN1O/1FXENaJ1YRUMsj
	 wjufefM4MNQIpWBt4ZB2sbXIirmpCfBO5S4HKrweGLM3TBliBUysVTqTwcrrLM+/J6
	 6Bl7tdKkIG0Nw==
Date: Fri, 9 Jan 2026 09:27:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/11] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Message-ID: <20260109152750.GA544801@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB88334B71E559AC00907BDE028C82A@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Fri, Jan 09, 2026 at 02:10:07AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2026年1月9日 5:50
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> > robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 08/11] PCI: dwc: Invoke post_init in
> > dw_pcie_resume_noirq()
> > 
> > On Wed, Oct 15, 2025 at 11:04:25AM +0800, Richard Zhu wrote:
> > > If the ops has post_init callback, invoke it in dw_pcie_resume_noirq().
> > 
> > I'm trying to write the merge commit log for this branch, and I don't quite
> > understand this.
> > 
> > The effect is to apply the GEN3_ZRXDC_NONCOMPL workaround for the
> > ERR051586 erratum, and Mani added the hint that this enables REFCLK
> > during resume.  But it seems weird that we apply a REFCLK workaround
> > after the link is already up.
> > 
> > During probe, .post_init() is run after pci_host_probe(), so we apply the
> > workaround after enumerating all the devices, which means REFCLK must
> > already be valid and the link is already up.
> > 
> > Is "enabling REFCLK" actually what imx_pcie_host_post_init() does?
>
> The codes are used to clean up the CLKREQ# override active low
> configurations after link is up and the CLKREQ# is drove to low by
> remote endpoint device at this point(support-clkreq is TRUE).
>
> It paves the way to support the CLKREQ# toggling mandatory required
> by L1SS.
>
> > Could the workaround be done in imx_pcie_host_init() before the
> > link is brought up?  If it could, it looks like we wouldn't need
> > imx_pcie_host_post_init() at all.
>
> Two actions are done in imx_pcie_post_init().
>
> One is to apply the workaround of ERR051586 by commit 744a1c20ce93
> ("PCI: imx6: Add workaround for errata ERR051586"). It should be
> applied after link is up.
>
> The other one is to clean up the CLKREQ# override active low
> configurations previous set in imx_pcie_host_init().

Right.  I'm not asking about the CLKREQ# part.  I'm asking about the
IMX_PCIE_FLAG_8GT_ECN_ERR051586 part.

The current commit log for this patch is this:

  Some SoCs like i.MX95 require enabling REFCLK after resuming from suspend
  in their post_init callback. So invoke the callback at the end of
  dw_pcie_resume_noirq() if available.

When .post_init() is called, the link is already up and PCIe devices
have already been enumerated.  I think REFCLK is required for the link
to come up, so it doesn't sound right to me that .post_init() would be
*enabling* REFCLK.

> > For now, I put this in the merge commit log:
> > 
> >   - Apply i.MX95 ERR051586 erratum workaround for REFCLK issue during
> >     resume (Richard Zhu)

