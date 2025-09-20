Return-Path: <linux-pci+bounces-36596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041FB8CBCA
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AED3B6D6D
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CD22127B;
	Sat, 20 Sep 2025 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYGzpZS8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC946B5;
	Sat, 20 Sep 2025 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382830; cv=none; b=cLk/3c0MEHu5O5BBYZPgVPku+Nei5s8qGk03vsYCgS15qCIT/d2QyCburKzd54dqvKOYnKiGeErJS7h1SSeyQ+LdRZHOYt1UJ5uWzsBGDR5GiMdtvSRdYAFKWPKD6ZMvnSsskBNHtXlM+Fj59f/6Y2wXgeHa4FOYbN3Q2Cpa5Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382830; c=relaxed/simple;
	bh=aasJG5JjOLjFKE8NEkADLnnYDlbPA5oupWfOKr2lOak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqgdDliZOwJf42WwB0lVdkxexm3Fw410xoAayN0TL/lpNJfQ+9vL4BHtkSr3gsCmCOQCOA53YfSUElckjcZKaWqajMgmRxVtDO1+F4BCBSRb39oZZcVa0Y3rqNfWnys51idFpdOedln+d/k44bE0QTcnUIpFh+lZEPID55Klz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYGzpZS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FD4C4CEEB;
	Sat, 20 Sep 2025 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758382829;
	bh=aasJG5JjOLjFKE8NEkADLnnYDlbPA5oupWfOKr2lOak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYGzpZS81kH1NiiGY9jNhe9hKCvDNRz5TEsU415diHtU2wKTxvXRRUaRV/kXwaVwP
	 t8m5xd0DuMEDlHFHq8gRQKV8tesLPEFLf0EkQds4bbyYJH+RBeYoHsIwPGnxKqbNw9
	 Xyn8MfhQ17SKhDkWY5q6mVpCTfAqmr/PqAbZ/bCpBFsmNKo4x6cGKCrNh+XqJOsUWY
	 p48amOGOD4jdCnGN8HgM3u8n93OUdazHZg2tCwihta+qC1I+T6FHGc9u7AMqqpodEl
	 qr0RW+BStpSYuJGZos/E6RbpjRewfhZSdXC0N4f565y/NQ5jaw35oP9I04SprhfehI
	 bu7adPuBVwlsQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Fix duplicate pll disable
Date: Sat, 20 Sep 2025 21:10:19 +0530
Message-ID: <175838274651.17577.4183778050259320426.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911093021.1454385-2-cassel@kernel.org>
References: <20250911093021.1454385-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Sep 2025 11:30:22 +0200, Niklas Cassel wrote:
> During PERST# assertion tegra_pcie_bpmp_set_pll_state() is currently
> called twice.
> 
> pex_ep_event_pex_rst_assert() should do the opposite of
> pex_ep_event_pex_rst_deassert(), so it is obvious that the duplicate
> tegra_pcie_bpmp_set_pll_state() is a mistake, and that the duplicate
> tegra_pcie_bpmp_set_pll_state() call should instead be a call to
> tegra_pcie_bpmp_set_ctrl_state().
> 
> [...]

Applied, thanks!

[1/1] PCI: tegra194: Fix duplicate pll disable
      commit: 3fab9e8102f7f7c5099d69f8e00f478e8795f528

Note: I've added the Fixes tag a54e19073718, which added the duplicate
tegra_pcie_bpmp_set_pll_state() call.

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

