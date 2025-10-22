Return-Path: <linux-pci+bounces-39069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2155BBFE72A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 00:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16221A0571A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF7261B70;
	Wed, 22 Oct 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yqfl5Czt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8D211472;
	Wed, 22 Oct 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761173155; cv=none; b=eLQ23Mx3KTKpq7Pb/1KFyXAcbhRJ36SFvjTeB7k4B1skOs/13lE5pJbKxu2X+zWKqFqLkUFszdRUUb/39CA/5orTvbFu+1ZtN80nPAbGwCtre/jeZpxkVqLhgYBNpZOTIUbilWIBqUolrab9fUDkg2aUS3KtByvVqmgqE0R0iW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761173155; c=relaxed/simple;
	bh=ynTdZ7Aj4V2OqHNG4FGr5zyTF0msUaMb3nD6PXj6uP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DBsjJDm0pSAehQNb6ehLNpUw7xegKxZjvXTJT9CA3aDEP8SfPsE5v19V5ZYVTcfBUUdUQOI4aWcPklbQDUBygEvM3BZifERCwkhvrZwgmy9x0Pp3KXLBy+fqdSzroqV8hy4oYhgVvJP0sHX47X3ax8KHSOBu4lKR7AyixQs9nRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yqfl5Czt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37F4C4CEE7;
	Wed, 22 Oct 2025 22:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761173154;
	bh=ynTdZ7Aj4V2OqHNG4FGr5zyTF0msUaMb3nD6PXj6uP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Yqfl5CztoX8gCmT3Y7k2CeoIq0NY/ShnRnfOTwgXoxdN4Gg4WCZq0BIQjXAKZcRzd
	 PQN7Ef5z6lLm4/cg5Lfg+Iwd5DaUIVZ0Aoku6AOPEufutqhcxIAlNqRe+YwdBYvTuI
	 bMuq8lhq+7Mhk3lVC8AJq3CulFwn3cF33WZuekumOG72GFWSYFPN6ri26xAlO8tbop
	 HEWr7fFSlK0MEC6HjNM0LhiSMEwCogXSnAYryJNlcr3YFRdjeAF7YKgotYputtDLD9
	 n38rSDmiikUaOYBtmrBkR0v1cPSN77PWeB6wB0PcvR9iOK+V6LWf1cJkOWR1WFCf8e
	 y0c+UevrynxFQ==
Date: Wed, 22 Oct 2025 17:45:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: brcmstb: Fix use of incorrect constant
Message-ID: <20251022224553.GA1271981@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003170436.1446030-1-james.quinlan@broadcom.com>

On Fri, Oct 03, 2025 at 01:04:36PM -0400, Jim Quinlan wrote:
> The driver was using the PCIE_LINK_STATE_L1 constant as a field mask for
> setting the private PCI_EXP_LNKCAP register, but this constant is
> Linux-created and has nothing to do with the PCIe spec.  Serendipitously,
> the value of this constant was correct for its usage until after 6.1, when
> its value changed from BIT(1) to BIT(2);
> ...

>  #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
>  #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
> -#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00

This all tangential questions for possible future changes, not
anything for *this* patch.

We have these in include/uapi/linux/pci_regs.h:

  #define PCI_EXP_LNKCAP          0x0c    /* Link Capabilities */
  #define  PCI_EXP_LNKCAP_MLW     0x000003f0 /* Maximum Link Width */
  #define  PCI_EXP_LNKCAP_ASPMS   0x00000c00 /* ASPM Support */
  #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */

Since you're using PCI_EXP_LNKCAP_ASPM_L0S below for writes to
PCIE_RC_CFG_PRIV1_LINK_CAPABILITY, I assume
PCIE_RC_CFG_PRIV1_LINK_CAPABILITY is another name for PCI_EXP_LNKCAP?

If so, it looks like we should also use PCI_EXP_LNKCAP_MLW instead of
PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK (although the
value is different for some reason; maybe 0x1f0 just reflects the
limits of brcmstb).

It would be nice to have a #define for the base of the PCIe
Capability so we could use that plus PCI_EXP_LNKCAP instead of
PCIE_RC_CFG_PRIV1_LINK_CAPABILITY.

But you did something like that already for PCI_EXP_LNKCTL2 using
BRCM_PCIE_CAP_REGS (0x00ac), which means LNKCTL2 and LNKCAP must be
at:

  LNKCTL2: 0x00dc (0x00ac + 0x30)
  LNKCAP:  0x04dc (0x04d0 + 0x0c)

which doesn't look at all like they would both be in the actual PCIe
Capability format.

>  #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
>  #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8

From its usage to "un-advertise L1 substates",
PCIE_RC_CFG_PRIV1_ROOT_CAP looks like it might be related to 
PCI_L1SS_CAP, but 0xf8 doesn't really match up to
PCI_L1SS_CAP_L1_PM_SS (0x10)

If this is really related to PCI_L1SS_CAP, can we use the names from
pci_regs.h somehow?

>  	/* Don't advertise L0s capability if 'aspm-no-l0s' */
> -	aspm_support = PCIE_LINK_STATE_L1;
> -	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> -		aspm_support |= PCIE_LINK_STATE_L0S;
>  	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> -	u32p_replace_bits(&tmp, aspm_support,
> -		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> +	if (of_property_read_bool(pcie->np, "aspm-no-l0s"))
> +		tmp &= ~PCI_EXP_LNKCAP_ASPM_L0S;
>  	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
>  	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */

