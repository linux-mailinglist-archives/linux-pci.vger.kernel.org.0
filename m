Return-Path: <linux-pci+bounces-41725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ABBC721C8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 04:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E17164E966A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 03:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C32FB09C;
	Thu, 20 Nov 2025 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxNKms2y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6842DC77E;
	Thu, 20 Nov 2025 03:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763610279; cv=none; b=Sp5d1kKPEeO1E/qFmQyF2juWrknNRE4UBYxbmD0lV8QpyzcFwedo5M7LtPrtAzsiMQDy6VHuyS8jBX445WxQgpI8vgfQCiJOK1S9Sl8hAMRUBtOgqD59Nyvqf4NVzK1S5QbpnbrO/Qdg64f7d09JuTGJ4dPOlH7oATOei+lAzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763610279; c=relaxed/simple;
	bh=AjdxR6TUqq3Wcw+p33wfaWFBJDTgg/OZKKZdG+hrWVU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CjPdhFeYQnJdLW3crY1R5782abEhbRkSb8xlM4OHSwMgNl8ZSUjuikrZR2iGVhz7NkXNqfHarTo8Hwzc84f9oq2ORO04PB5sEOXJ5r67LJhG+0HgQkVm4Wlk2zm10oj/k+OVK70FxULO8CwohxGJ9tAIPXY2pK8Rjc72bO8U0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxNKms2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F80C4CEF5;
	Thu, 20 Nov 2025 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763610278;
	bh=AjdxR6TUqq3Wcw+p33wfaWFBJDTgg/OZKKZdG+hrWVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PxNKms2yk1pVNaHxO1/75tbCaZ2Y+w7UQgCVbLiXP1frzW8HEzJWotYTj4sNgdysV
	 5loVSEyeMx6OFe5LajWbF7OKXRhpDhr/1WPHG96YhEWrXrDRc5T6Df66T88h5SY5Ta
	 d/AxjzQoAMnsc0mRBjpl9V5q4C6gGgZBkbKfPOORE1cARNO86cHsb/mnttbXtXmwng
	 ZU7tjdYER9j3hciyCBMrB2FiQzCJ5jYc/avhTfFm0hgtrcKKK6dCRLTzCvGLfbVJVh
	 Rqy+BIPuomcsUnvDb+EOgkUcD2GYDl/urauwbudkNGLLQqDTc0jE56rYk+KCLAB3+u
	 +7cYNUP/G8Dww==
Date: Wed, 19 Nov 2025 21:44:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1 1/5] PCI: rockchip: Fix Link Control register offset and
 enable ASPM/CLKREQ
Message-ID: <20251120034437.GA2625966@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgRHuwoQjr95sXp-X97=L-X3vqUPxjR5=2jNtFZA+4gnwQ@mail.gmail.com>

On Wed, Nov 19, 2025 at 07:49:06PM +0530, Anand Moon wrote:
> On Tue, 18 Nov 2025 at 23:20, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 17, 2025 at 11:40:09PM +0530, Anand Moon wrote:
> > > As per the RK3399 TRM (Part 2, 17.6.6.1.31), the Link Control register
> > > (RC_CONFIG_LC) resides at an offset of 0xd0 within the Root Complex (RC)
> > > configuration space, not at the offset of the PCI Express Capability List
> > > (0xc0). Following changes correct the register offset to use
> > > PCIE_RC_CONFIG_LC (0xd0) to configure link control.
> ...

> > Don't do two things at once in the same patch.  Fix the register
> > offset in one patch.  Actually, as I mentioned at [1], there's a lot
> > of fixing to do there, and I'm not even going to consider other
> > changes until the #define mess is cleaned up.

> > [1] https://lore.kernel.org/r/20251118005056.GA2541796@bhelgaas
> 
> According to the RK3399 Technical Reference Manual (TRM), and pci_regs.h
> already includes the correct, pre-defined offsets for all PCI Express
> device types
> and their capabilities registers. To avoid overlapping register mappings,
> we should explicitly remove the addition of manual offsets within the code.

> Here is the example. Is this the correct approach?

> -       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> +       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC);
>         status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> -       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> +       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC);

No.  The call should include PCI_EXP_LNKCTL because that's what we
grep for when we want to see where Link Control is updated.

See my example from [1] above:

  rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_DEVCAP)
  rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_LNKCTL)

You should have a single #define for the offset of the PCIe
Capability, e.g., ROCKCHIP_RP_PCIE_CAP.  Every access to registers in
that capability would use ROCKCHIP_RP_PCIE_CAP and the relevant
PCI_EXP_* offset, e.g., PCI_EXP_DEVCAP, PCI_EXP_DEVCTL,
PCI_EXP_DEVSTA, PCI_EXP_LNKCAP, PCI_EXP_LNKCTL, PCI_EXP_LNKSTA, etc.

Bjorn

