Return-Path: <linux-pci+bounces-36866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1531DB9AE03
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C988D17B60D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2818C034;
	Wed, 24 Sep 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCzIJm8w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDED30C622;
	Wed, 24 Sep 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758731271; cv=none; b=mLrO1SgawucxkE46NVWqTdHshoCa0lJBfF7i5gvuzAkv/wSUlZCkDUqrwm4D/zyExp1BxKvXTUdafHYjs7Q6KD2vrFryoZotAmXIVzW5ppv33usO5ATXPM9iju9fe8q/qWGB5Rr010nGYYc0yakmdo5WbSFuPuAnrgw/4j1xLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758731271; c=relaxed/simple;
	bh=S0GG/oxsHIj92A6uVZuJnqQfoDoVTBR11CukgPlll5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijeixneoLdINP0QZd3le5SOl5RTL/03Z0poDUo2gMTG/OP9Zd+NbejqF6EJOJCqc2MiDJhKjvOfaMkYU8LCb6ZtuU9+Teai9ASJaqUKCBRkLHFS9V9KU8WmgaNObHq13vIjx81nlBreyJItu3pC6vRMJNmcgvsyVZIWDUs11aoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCzIJm8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D439EC4CEE7;
	Wed, 24 Sep 2025 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758731270;
	bh=S0GG/oxsHIj92A6uVZuJnqQfoDoVTBR11CukgPlll5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCzIJm8wheGfCeQC4Pq/vfEozaghr7NcMHZveSg8o6mn2I/E0brSFXikr8yw+Y+sc
	 BJ477OUu4UF1iE4O7JZZLvQMN+nLnLmNUAObpnsS8a4KJRSRsGiVdcK3OAIOe2oMvt
	 qZ5CZCM+rtEPaF6plk5zTNgmHrn3QDW/SBOSaGkK6CjBZqNCWx3csKT1oM7k2z74Wh
	 MgzC/7DgOWdrz8lK/KUbGFGukIBiFYOGQhwk0oM4n2AqXs4JFNj3feGibVSyhTrSSU
	 slafTR9wMoF1pWjKU84XM4kMGaPJ+hwVvmpnuU7t5CPU4TUgUL+53TeHQPeNUkkz6H
	 AlDgzV2uPdHTA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thierry Reding <treding@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 0/3] tegra194 PCI endpoint fixes
Date: Wed, 24 Sep 2025 21:57:40 +0530
Message-ID: <175873117614.9403.12977856551944635014.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922140822.519796-5-cassel@kernel.org>
References: <20250922140822.519796-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 22 Sep 2025 16:08:23 +0200, Niklas Cassel wrote:
> Shin'ichiro and I have recently been trying to get the Jetson to run the
> PCI endpoint kselftests on a tegra based board. These patches ensure that
> the BAR test cases and MSI test cases pass. The MSI-X test cases still fail.
> 
> 
> Dependency
> ==========
> "PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()" requires commit
> 27fce9e8c6f0 ("PCI: endpoint: Drop superfluous pci_epc_features initialization")
> which is currently queued on branch pci/endpoint.
> 
> [...]

Applied, thanks!

[1/3] PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()
      commit: b640d42a6ac9ba01abe65ec34f7c73aaf6758ab8
[2/3] PCI: tegra194: Reset BARs when running in PCIe endpoint mode
      commit: 308c6d4cf3ef9725054c431b1b8e3db0dc38de34
[3/3] PCI: tegra194: Handle errors in BPMP response
      commit: b308dcd8b385f93c7d210be3a48aaa590739ba17

Note: I've splitted the patch 1 into two to keep the bug fix separate:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=82f1cc171ce95544c024837c20a54d1954a67a76

- Mani

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

