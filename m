Return-Path: <linux-pci+bounces-32331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98A2B07F2D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E11A44BA3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D2289E15;
	Wed, 16 Jul 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs7DDZT5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57D1CD2C;
	Wed, 16 Jul 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699363; cv=none; b=X9gyc0L5T9WiPGzL/0dS+OLX7I2rcrATE8G/WCDhR/lLZKaT4WtCxHsYn5OWImZxVyc/8GCrVjxIW6//50XPeRahu7OVd7dWAN+A7N9B/wzmgbiJp7b1/PA6wTlbnxxgUftnxng7C+uQRsZEQSn1yPhiW3AsRqTF5AEJJ/ELzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699363; c=relaxed/simple;
	bh=1eT1bU8K2ROCVSdByZdiqCJahWUYakFk0s/KHQHgDy0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ojDr9Z4BkqzrxaFrQsWrXF1DDIdsimIo7hzlPCbt8lwKXSOkeakB3UU5oqosZsLvgucHTgh87KwdwVUxBgiPo3ljNosLRfiKrpZcpraoy159lFwi/7sqrufOTnEYEgPp4tqnvv8aD4icLrsXm8iouHLnlplOOVmf6oInYGrGMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs7DDZT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1039DC4CEF1;
	Wed, 16 Jul 2025 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752699363;
	bh=1eT1bU8K2ROCVSdByZdiqCJahWUYakFk0s/KHQHgDy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hs7DDZT5y7ghwrrP2RoLIPD/uvZHmLasbXo2TT4fFIO7edIcBrZV86BNmu6s52Pe2
	 GiXm1OSTqbaMlmfNhVJedqxHISA/wrhm2gLbzV7c7jkbfhFiiuLC38tyjBoPUYv2SI
	 c5gN69aqyBcZ6IX7zJxosf4QmOf4AUeQH4BAUNjE40OTOLWHCIupvCvIgEVG53phaI
	 VPoNle4itK3nDgSes+CYKnpEt2/l5BSdcMpFIOkTJ5n6dtkhB5pcJHezOQoRMlgkK5
	 GMrfGRzeI23y1uUdJ81ubwpBoYxkrOfhRw2XxAwcTjK+nQQwp+gBPd1oL5R7lGcE7f
	 CdHEgEcAb4nag==
Date: Wed, 16 Jul 2025 15:56:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	ath12k@lists.infradead.org, ath11k@lists.infradead.org,
	ath10k@lists.infradead.org, ilpo.jarvinen@linux.intel.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/6] PCI/ASPM: Transition the device to D0 (if required)
 inside pci_enable_link_state_locked() API
Message-ID: <20250716205601.GA2555277@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-ath-aspm-fix-v1-2-dd3e62c1b692@oss.qualcomm.com>

On Wed, Jul 16, 2025 at 06:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Both of the current callers of the pci_enable_link_state_locked() API
> transition the device to D0 before calling. This aligns with the PCIe spec
> r6.0, sec 5.5.4:
> 
> "If setting either or both of the enable bits for PCI-PM L1 PM Substates,
> both ports must be configured as described in this section while in D0."
> 
> But it looks redundant to let the callers transition the device to D0. So
> move the logic inside the API and perform D0 transition only if the PCI-PM
> L1 Substates are getting enabled.

> +++ b/drivers/pci/pcie/aspm.c
> @@ -1474,13 +1474,20 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>   * Note that if the BIOS didn't grant ASPM control to the OS, this does
>   * nothing because we can't touch the LNKCTL register.
>   *
> - * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> - * PCIe r6.0, sec 5.5.4.
> + * Note: The device will be transitioned to D0 state if the PCI-PM L1 Substates
> + * are getting enabled.
>   *
>   * Return: 0 on success, a negative errno otherwise.
>   */
>  int pci_enable_link_state(struct pci_dev *pdev, int state)
>  {
> +	/*
> +	 * Ensure the device is in D0 before enabling PCI-PM L1 PM Substates, per
> +	 * PCIe r6.0, sec 5.5.4.
> +	 */
> +	if (FIELD_GET(PCIE_LINK_STATE_L1_SS_PCIPM, state))
> +		pci_set_power_state(pdev, PCI_D0);

This is really just a move, not new code, but this niggles at me a
little bit because my impression is that pci_set_power_state() doesn't
guarantee that the device *stays* in the given state.

Rafael, is there a get/put interface we should be wrapping this with
instead?

I'm also not sure it's worth the FIELD_GET().  This should be a
low-frequency operation and making the power state dependent on the
exact "state" makes more paths to worry about.

>  	return __pci_enable_link_state(pdev, state, false);
>  }

