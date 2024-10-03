Return-Path: <linux-pci+bounces-13786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D058C98F801
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 22:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6131C20EC6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF521B85CC;
	Thu,  3 Oct 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOrNmNEQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065581B85CB
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987004; cv=none; b=jheqGrDKqL+BDhwnvoCnpk3Zr1igHG0JOqzT2U2Y9c4P5AfbPza4TozOozkKM4anqNXshkgXNG+3Z6H5cz4qqXvPVx1Wmh0ig6VyNQv44mjGC0SsRFxkPTnqUrE0A19QAqkUPlw2ew2cJ/63ib4eJvhrmq3uShA2zbdjq6qyMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987004; c=relaxed/simple;
	bh=KRh2ZmygcVw9SDznIqmZtb+/5FTOwn1WS8IIPxQPy6c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vl0V5EA7Ak91NmnDTXVxXRNMPO5syP6MWcsqDH6qivCfv4MfXB/Y0LMX8CHvox4a6ybqDq1qN8LWODuiwn/mJrDKMVwbLO6vtAgxwg1IM7G5DzTEdzjqUAxlOq5OEVupUTY0/7wNdUHhCplOOe6OX3QGWrIMXLQA7CCXSZCyAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOrNmNEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EBFC4CECC;
	Thu,  3 Oct 2024 20:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727987003;
	bh=KRh2ZmygcVw9SDznIqmZtb+/5FTOwn1WS8IIPxQPy6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BOrNmNEQx9Lu73GJgXPn+lWmBWtxDWP5W6kzM/G/W3xPeol9EFwBd/CYcnmRubXqn
	 OoCDQilTHXAxhHYQ9hd7CoOCVzyhEgGkcNygP1DFgxD3pfKLoRfz8etAen6vcpAZq1
	 zNSIRZe5WcsnDIAXIpLJDAs2xIropPTonNbDcRj2F+rbuaORr/AIOIdxxv2cXX7gnj
	 j+ZdVpTJ+e5xCTInZNO8Zn8BUy0HeqSoU3oyfJ8A6J7ccc0wlH61EjAm4+0czZhaK0
	 LbA2R1y1gs7MnUQt2gfs7tWLg+X/exv4qKu4U+EW4KgO/Rh3RYoGFqlJ87PCW+GooP
	 fA3JkU5WBxeuA==
Date: Thu, 3 Oct 2024 15:23:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <20241003202321.GA321551@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv7TLs9_CMaYQ--b@google.com>

On Thu, Oct 03, 2024 at 10:53:58PM +0530, Ajay Agarwal wrote:
> On Thu, Oct 03, 2024 at 12:01:22PM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 03, 2024 at 06:55:03PM +0530, Ajay Agarwal wrote:
> > > The current sequence in the driver for L1ss update is as follows.
> > > 
> > > Disable L1ss
> > > Disable L1
> > > Enable L1ss as required
> > > Enable L1 if required
> > > 
> > > With this sequence, a bus hang is observed during the L1ss
> > > disable sequence when the RC CPU attempts to clear the RC L1ss
> > > register after clearing the EP L1ss register.
> > 
> > Thanks for this.  What exactly does the bus hang look like to a user?
> >
> The CPU is just hung on reading the RC PCI_L1SS_CTL1 register. After
> some time, the CPU watchdog expires and the system reboots.

Wow.  Good to know that this is outside the PCIe domain.  I think this
is a good change, and since it is partly motivated by hardware
behavior that might be legal but seems somewhat unusual, can we
identify the hardware (CPU and PCIe Root Complex) involved here?

> > I guess the problem happens in pcie_config_aspm_l1ss(), where we do:
> > 
> >   pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)
> >   pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)
> > 
> > where clearing the child (endpoint) PCI_L1SS_CTL1_L1_2_MASK works, but
> > something goes wrong when clearing the parent (RP) mask?  The
> > clear_and_set will do a read followed by a write, and one of those
> > causes some kind of error?
> >
> During ASPM disable, in pcie_config_aspm_l1ss(), we do:
>    1. pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)
>    2. pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)
>    3. pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)
>    4. pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)
> 
> We observe that the steps 1 and 2 go through just fine. But the read of
> PCI_L1SS_CTL1 register in the step 3 hangs. I am not sure why.
> The issue is pretty difficult to reproduce, and adding prints around
> these steps masks the issue.

I guess the L1 disable is between 2 and 3, right?  And 3 and 4 may
enable L1 SS (using val, not 0)?

  1. same
  2. same
  2.5 pcie_capability_clear_word(child, PCI_EXP_LNKCTL_ASPM_L1)
  2.6 pcie_capability_clear_word(parent, PCI_EXP_LNKCTL_ASPM_L1)
  3. pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ...  val)
  4. pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ...  val)

Bjorn

