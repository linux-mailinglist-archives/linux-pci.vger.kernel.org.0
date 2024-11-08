Return-Path: <linux-pci+bounces-16297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27B9C132F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 01:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87AF1F22F77
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 00:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F11C36;
	Fri,  8 Nov 2024 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI3gSewB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2F610D;
	Fri,  8 Nov 2024 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025468; cv=none; b=afyD2Zq4X8SksbGf0KjDr9hQ3t8XLxFdKsVyJvY0zjB6+fnYhSTnDIc7iBS162veppaQVqiAwWW8kNjQepTyOPSciLk7Qlvw+rkWOSIXrLLSNactOvki83FX0zAh628xtF3F6soX/OTQvNsh5Xxp2DOkvtm/ZIBhn2lTVMrJeYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025468; c=relaxed/simple;
	bh=5ySH9Y9XuFgDzil3SM458QkbU//Avf5c5Hm79IqMzVs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oMqH8iVhm50qp5HNhb9fQywliLdmkJLyXnJ6dzLHha3KK2j9o9Crhv6W8Mf2VNrKpFTrMEun4ccMfpWm82pg845BP7szDJT5jEpMxCnj3dSV320j0dXm1suwXCdQflwYrgR0Q60O7EJE2SgCW5P7qvg9Ls9pcXfvdZ/2GuXez+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI3gSewB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD8DC4CECC;
	Fri,  8 Nov 2024 00:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731025468;
	bh=5ySH9Y9XuFgDzil3SM458QkbU//Avf5c5Hm79IqMzVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EI3gSewBcUUd55EPL2LuyfcoHPA1mH0ninGzguvWAhZsY4Doi5kLvxCTVoUZcFUFt
	 FFBBsyH1ZyEv+fqODb5/OmR0pG8ShyuCSJr8dfrJjJWJDDe22EyFIjNmd7i9kcx5JU
	 gI4F7q8m5Kqq8m9W3H+LeMEouB0OJ/m2Bx72sGvHp15e8ab27TIfUiLP2pNQcFeT2a
	 rYIPCkAQpKAuP2KTmic05RR+c4cVc0U0Wj+iuw2astUBvvky2fILP/b71Riuau4wnf
	 bqVABmsAZAoldlDT4pAatpnA1CyfOQslYyURCdZgLmGuVARPb34DbKAIz7VL2Bac4C
	 A3K46rVZZCBSA==
Date: Thu, 7 Nov 2024 18:24:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, jingoohan1@gmail.com,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, frank.li@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20241108002425.GA1631063@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111334.n23ebkbs3uhxivvm@thinkpad>

On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam wrote:
> On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> > Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's
> > safe to send PME_TURN_OFF message regardless of whether the link
> > is up or down. So, there would be no need to test the LTSSM stat
> > before sending PME_TURN_OFF message.
> 
> What is the incentive to send PME_Turn_Off when link is not up?

There's no need to send PME_Turn_Off when link is not up.

But a link-up check is inherently racy because the link may go down
between the check and the PME_Turn_Off.  Since it's impossible for
software to guarantee the link is up, the Root Port should be able to
tolerate attempts to send PME_Turn_Off when the link is down.

So IMO there's no need to check whether the link is up, and checking
gives the misleading impression that "we know the link is up and
therefore sending PME_Turn_Off is safe."

> > Remove the L2 poll too, after the PME_TURN_OFF message is sent
> > out.  Because the re-initialization would be done in
> > dw_pcie_resume_noirq().
> 
> As Krishna explained, host needs to wait until the endpoint acks the
> message (just to give it some time to do cleanups). Then only the
> host can initiate D3Cold. It matters when the device supports L2.

The important thing here is to be clear about the *reason* to poll for
L2 and the *event* that must wait for L2.

I don't have any DesignWare specs, but when dw_pcie_suspend_noirq()
waits for DW_PCIE_LTSSM_L2_IDLE, I think what we're doing is waiting
for the link to be in the L2/L3 Ready pseudo-state (PCIe r6.0, sec
5.2, fig 5-1).

L2 and L3 are states where main power to the downstream component is
off, i.e., the component is in D3cold (r6.0, sec 5.3.2), so there is
no link in those states.

The PME_Turn_Off handshake is part of the process to put the
downstream component in D3cold.  I think the reason for this handshake
is to allow an orderly shutdown of that component before main power is
removed.

When the downstream component receives PME_Turn_Off, it will stop
scheduling new TLPs, but it may already have TLPs scheduled but not
yet sent.  If power were removed immediately, they would be lost.  My
understanding is that the link will not enter L2/L3 Ready until the
components on both ends have completed whatever needs to be done with
those TLPs.  (This is based on the L2/L3 discussion in the Mindshare
PCIe book; I haven't found clear spec citations for all of it.)

I think waiting for L2/L3 Ready is to keep us from turning off main
power when the components are still trying to dispose of those TLPs.

So I think every controller that turns off main power needs to wait
for L2/L3 Ready.

There's also a requirement that software wait at least 100 ns after
L2/L3 Ready before turning off refclock and main power (sec
5.3.3.2.1).

Bjorn

