Return-Path: <linux-pci+bounces-37021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF45BA140F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 21:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9185E4C833D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3198B31DDB9;
	Thu, 25 Sep 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQARuqmq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13131DDB7
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829467; cv=none; b=mVBOgsqRd3WNmVUhhJmO6eJkYvlhnk3a2f8ITIJOE9/8Qj4clC/GmLaikdv59uq4ACbSfQ9MYnvvP4JSqjt55WPn6OZC9SSzMfVQ/xngnZaPLEpjzFQ1lLjZAMQ7QN0JcwhqRNSxPVTW+XL10WxLFseVx9DmOVMTMJbGkzPMupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829467; c=relaxed/simple;
	bh=m2k7/3rSK+OZo9U9uGS4+2gFkoE3ZiPQfZQ2n9Lc5Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ElJAPVeyi2Dd9A6NZ7gwUAbdVrO1zG7Dn5AZM8UvZe0Sr7mTBqQZJGYhYjCzy7auWR2dmABSzc9ukNGiRE7eiGvhCQhng5bJyL/dYVs70Z8kfspoUqr8H51xExxiY8Z34FrE/YOOAk2v23fEamKDofvjzxNrLb9RKle6G5Anijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQARuqmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53496C4CEF0;
	Thu, 25 Sep 2025 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758829466;
	bh=m2k7/3rSK+OZo9U9uGS4+2gFkoE3ZiPQfZQ2n9Lc5Cg=;
	h=Date:From:To:Cc:Subject:From;
	b=kQARuqmqF9Hx5q251J+r47Wv5rFDuXEbeVnYNr+ZIv6iYVhYu+EdTi6M6br21XmeL
	 F+jHAzgXa4XqQ5VeLSBYNT1beE1hIsgS/h9h9AIP8FNb8qc+hCHzI0M+RU3P4PN3Xf
	 3oJAZY0QW6XANSgP+Ap28+cfKZ3Df/CfxRj7Gfs5N83bun3+EoK607pkqH0TnrB6Mg
	 bPdi1WLIK7OEVcxtkgPaLWyzJXyYdPWVY1axFa04UEYYsr7tzigQVxSfRsbeBc+qvk
	 UIk/zkCi83mmWzNHSKld2+rVJ5IoF9X5iUf6hz6m599D4yB6lA6ZJMXsCE96gXXvww
	 Xo/WQu+4CR5hA==
Date: Thu, 25 Sep 2025 14:44:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <jim2101024@gmail.com>,
	Jim Quinlan <james.quinlan@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com
Subject: brcmstb PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK issue
Message-ID: <20250925194424.GA2197200@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I think caab002d5069 ("PCI: brcmstb: Disable L0s component of ASPM if
requested") introduced a problem:

  #define PCIE_LINK_STATE_L0S             (BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
  #define PCIE_LINK_STATE_L1              BIT(2)  /* L1 state */

  +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK   0xc00

  +       /* Don't advertise L0s capability if 'aspm-no-l0s' */
  +       aspm_support = PCIE_LINK_STATE_L1;
  +       if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
  +               aspm_support |= PCIE_LINK_STATE_L0S;
  +       tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
  +       u32p_replace_bits(&tmp, aspm_support,
  +               PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);


PCIE_LINK_STATE_L0S is two bits, PCIE_LINK_STATE_L1 is one bit, and
the u32p_replace_bits() tries to put all three bits into the two-bit
PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK field.

Interestingly, the compiler only warns about this when !CONFIG_OF
because in that case the of_property_read_bool() stub always returns
"false".  A Kconfig tweak is needed to build this with !CONFIG_OF.

