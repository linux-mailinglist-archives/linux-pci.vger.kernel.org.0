Return-Path: <linux-pci+bounces-30661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ED4AE9069
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E013B8353
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0985225E803;
	Wed, 25 Jun 2025 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYQ7w1nZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DC25BF11;
	Wed, 25 Jun 2025 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888017; cv=none; b=hrsWrZY98p1rc8mg4+JSt0o/YYhlMCUSsIlfKmt7sKo9QwSuSpl4uAF1i5A+s9hODZ1+11tMuuL0h1xX1Sn3wNYz/pjL/8P0HSN+baX/3+yfIYiPhzUbJ7W4pO3U+TgsdIvg4nLDurJZw9DX+nW41AMzy6vGwMece4QoQD7oQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888017; c=relaxed/simple;
	bh=rP0WyBPNVewCeJIIMueDmqciWzxLfKXmCz5SEfqzKHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9JdSZYwtsW+Ms9ROQC6QMxxKVR8VXdPhekwnJ2jxAc5CawK02+wWZIOewQpxYRRPwle1CRAnspGTqmeQarEWUijm8rFPV+vG76Y/DCiZO2av9iOIQBuz7K4UBSQs5ovi6wzY+gZuaisnrC1XNZ1utBywKQy9l5JUBNlMGLKWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYQ7w1nZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD87DC4CEEA;
	Wed, 25 Jun 2025 21:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750888017;
	bh=rP0WyBPNVewCeJIIMueDmqciWzxLfKXmCz5SEfqzKHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYQ7w1nZ7Jtv6C59J4um6Pb8Gg9HSCTZNbn5fe7V6pGdSPXw7CDZibZxkKT2Xf5h9
	 pUqypdtM/d3RhNIPNPjJvxo1Z8jRQLMLZ2+aKe5reEmifaV/Z+LWGUHU9P+g9w0AVy
	 +KA7WeM4AHKGeMEadUTycV138byHWUzVfSMsLYG6Z2e3R+OddtXN14o3by84r9vsPN
	 A4RcrzLg6vH7j7h/ux+FM/UmUVEtp2r+tPqELdoj8wH5vUoPBEjBSNgvkccVHUKZx9
	 +e11QGTS6Q5Umv0aQB/JFXhvc1yGEuBjNUcc7X58N0yW6GfI2e1BIfrFd1r5a5ONi4
	 Msdpp25yqr3yA==
Date: Wed, 25 Jun 2025 15:46:54 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: xilinx: Wait for link-up status during
 initialization
Message-ID: <vwipw5opvx42e6l7ofphg47rlsoebbts7dwzq5knaf4iz4hmhw@gk6lo4b6plxh>
References: <20250610185734.GA819344@bhelgaas>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.bd37b5e5-7e20-4db7-b2f4-b11b97bc1326@emailsignatures365.codetwo.com>
 <9f8a7c43-4862-45aa-951c-bf3e3c1f5513@topic.nl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f8a7c43-4862-45aa-951c-bf3e3c1f5513@topic.nl>

On Wed, Jun 11, 2025 at 08:48:51AM +0200, Mike Looijmans wrote:
> 
> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topic.nl
> W: www.topic.nl
> 
> Please consider the environment before printing this e-mail
> On 10-06-2025 20:57, Bjorn Helgaas wrote:
> > On Tue, Jun 10, 2025 at 04:39:03PM +0200, Mike Looijmans wrote:
> > > When the driver loads, the transceiver and endpoint may still be setting
> > > up a link. Wait for that to complete before continuing. This fixes that
> > > the PCIe core does not work when loading the PL bitstream from
> > > userspace. Existing reference designs worked because the endpoint and
> > > PL were initialized by a bootloader. If the endpoint power and/or reset
> > > is supplied by the kernel, or if the PL is programmed from within the
> > > kernel, the link won't be up yet and the driver just has to wait for
> > > link training to finish.
> > > 
> > > As the PCIe spec allows up to 100 ms time to establish a link, we'll
> > > allow up to 200ms before giving up.
> > > +static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
> > > +{
> > > +	u32 val;
> > > +
> > > +	/*
> > > +	 * PCIe r6.0, sec 6.6.1 provides 100ms timeout. Since this is FPGA
> > > +	 * fabric, we're more lenient and allow 200 ms for link training.
> > > +	 */
> > > +	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
> > > +			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2 * USEC_PER_MSEC,
> > > +			2 * PCIE_T_RRS_READY_MS * USEC_PER_MSEC);
> > > +}
> > I don't think this is what PCIE_T_RRS_READY_MS is for.  Sec 6.6.1
> > requires 100ms *after* the link is up before sending config requests:
> > 
> >    For cases where system software cannot determine that DRS is
> >    supported by the attached device, or by the Downstream Port above
> >    the attached device:
> > 
> >      ◦ With a Downstream Port that does not support Link speeds greater
> >        than 5.0 GT/s, software must wait a minimum of 100 ms following
> >        exit from a Conventional Reset before sending a Configuration
> >        Request to the device immediately below that Port.
> > 
> >      ◦ With a Downstream Port that supports Link speeds greater than
> >        5.0 GT/s, software must wait a minimum of 100 ms after Link
> >        training completes before sending a Configuration Request to the
> >        device immediately below that Port. Software can determine when
> >        Link training completes by polling the Data Link Layer Link
> >        Active bit or by setting up an associated interrupt (see §
> >        Section 6.7.3.3).  It is strongly recommended for software to
> >        use this mechanism whenever the Downstream Port supports it.
> > 
> Yeah, true, I misread the comment in pci.h. I cannot find any #define to
> match the "how long to wait for link training". Each driver appears to use
> its own timeout. So I should just create my own?
> 

We recently merged a series that moved the timing definitions to
drivers/pci/pci.h:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/linkup-fix&id=470f10f18b482b3d46429c9e6723ff0f7854d049

So if you base your series on top this branch, you could reuse the definitions.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

