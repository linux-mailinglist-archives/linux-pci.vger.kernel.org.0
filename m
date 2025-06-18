Return-Path: <linux-pci+bounces-30133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C8ADF74F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 21:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9EB4A3A30
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 19:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34E219E8F;
	Wed, 18 Jun 2025 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5hCWJOq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8EF204F93;
	Wed, 18 Jun 2025 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276622; cv=none; b=KjqE6f+lyW6LqC+eA9jGbEMQTVLEXL/IsrASbdkWEA1PADK3Qt1g4SvjjQdKlYdVPR0PiziKhltlxuuqDT43fOFE3x4nnqqgtTCUXjwtHsuhOXYFS/d/7lfDnHYjhsE0auk4j2ecis7acsMHVnEfSy7hmcl5ackeCG6EIjU5QXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276622; c=relaxed/simple;
	bh=LODV13BAO/vPV1KR/ZrA48zSFSV7rhVVCDbvUO9rbCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXDYZiEHXpDfR0RBBjXxW3J90OIX7pmqmbZr0PYlsHOt9f7pCmUBTNqj3iG6fXC+3y+w7zYbyI1uqTrzLFlFVYXf5KxltgC3SrMNBiI+M8MFehV1pj1wTuXF/RbWdCQ6lI61mw2JE1AQBc4xCVyDYnUmuK14Ri6E2DlaNpCfOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5hCWJOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE1C4CEE7;
	Wed, 18 Jun 2025 19:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750276622;
	bh=LODV13BAO/vPV1KR/ZrA48zSFSV7rhVVCDbvUO9rbCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5hCWJOq4BPeCPXNeDRpGBKL2aPnSMqJBqxjXFAR2SRBa5EnDn9dkzuxqDQNbEvyn
	 fBe9dyKKEvuzysSk8KQ23rW2e7DLfVl9W5bfq+MXDQ2Ekk2CLxIjwOSoJXi6Te+TBl
	 7C7XaAGn751Ko9xb2RGqAgP++GyMpDvi45jTrj7Gu9DNQMrl5OeFEzN2kVcrOODzc3
	 RgCEUVqJMI0ocsFhgdbB/HSfQ/5Axvz1EE9TR+bE74oNsRAZn/zPC0vcN8fzSP6w4r
	 Zk7b15ng+BIjJxGmbqNZXFT54eLakscZ6nBXx0fgBDNjo9rIXEJK5DhLmHgahFpL5P
	 2T7sA59b8j31w==
Date: Wed, 18 Jun 2025 21:56:54 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 24/27] irqchip/gic-v5: Add GICv5 ITS support
Message-ID: <aFMaBlByS8xPq6kc@lpieralisi>
References: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
 <20250618-gicv5-host-v5-24-d9e622ac5539@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-gicv5-host-v5-24-d9e622ac5539@kernel.org>

On Wed, Jun 18, 2025 at 12:17:39PM +0200, Lorenzo Pieralisi wrote:

[...]

> +static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
> +				  int nvec, msi_alloc_info_t *info)
> +{
> +	struct msi_domain_info *msi_info;
> +	struct device_node *msi_node;
> +	struct pci_dev *pdev;
> +	phys_addr_t pa;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	msi_node = pci_msi_get_device_msi_ctlr_node(pdev);
> +	if (!msi_node)
> +		return -ENODEV;
> +
> +	ret = its_translate_frame_address(msi_node, &pa);
> +	if (ret)
> +		return -ENODEV;
> +
> +	of_node_put(msi_node);
> +
> +	/* ITS specific DeviceID */
> +	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain->parent, pdev);

Heads-up: it turned out I was too optimistic and reusing

pci_msi_domain_get_msi_rid()

on GICv5 does not work (or better it works incorrectly).

It calls (for DT) of_msi_map_id() with the IRQ domain of_node (why, I am
not sure but for GICv3 it works because the phandle in the msi-map and
the IRQ domain of_node are equivalent). This does _not_ work on GICv5,
I failed to spot it because in of_msi_map_id() if the IRQ domain of_node
and msi-map phandle do not match a 1:1 translation is carried out, which
ironically is what the RID<->DID translation looks like in the test
platform. Sigh.

I have already patched the code to augment:

pci_msi_get_device_msi_ctlr_node()

so that it grabs the msi-controller of_node pointer in msi-map AND maps the
RID->DID (and to be honest that's what I should have done but I wanted to
reuse pci_msi_domain_get_msi_rid(), it does not work for GICv5 unless I
change it but I fear I could break platforms, we don't fix what it is not
broken).

Long story short: apologies, I missed this snag for the reasons above, I
will update it for v6.

Thanks,
Lorenzo

