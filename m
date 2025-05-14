Return-Path: <linux-pci+bounces-27711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB67CAB6A4A
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBFB1B651B9
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E5427FD45;
	Wed, 14 May 2025 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAQPaTMZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8252777F1;
	Wed, 14 May 2025 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222684; cv=none; b=HHHJP62gA1WMRa5CUuQDXgqs6IQ/GJkkcFzzyhIVOzdHK8HMMf0q/IjAEUwpzqiGM5HkqKPmTmir7GCvKWyfvD3S536WhQ01byRAbbh1F+ghqoshALMaARKBuPdvl+/017LbS1EEmetuo4e3i36UDyH5Oa2NY/DgnrGnkXcHyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222684; c=relaxed/simple;
	bh=IAEbqL9prrVvU/NyH2e1c1dOTs1NgVRmxCn7iasm5FA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K1a7/X662mxNkYdYfj36UfLzGdWAz6YF5Ia+Ev87hQbNqVtj3uaVqsh/gPOIhuNQmXscT9RCxUa7sUiLz4+nnghUMSEy8sEb82MHM/3grN0DwUjTCne9+jdx8xL3wVQi/gkYT/Xf8u+52tGvNOr0mb2uQh5qEz4dtmnJw9xLtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAQPaTMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D37C4CEE9;
	Wed, 14 May 2025 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747222684;
	bh=IAEbqL9prrVvU/NyH2e1c1dOTs1NgVRmxCn7iasm5FA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pAQPaTMZq9gy9lPmIk5+NMzvMpGCDT2LITdvRKW4qeJ5KrofwwSa4goARt8v8BD5z
	 GEIfRClS1nQK82nIhMic4mmCVPDCHsqnsoeWRaX4wY+Dsm78Y+eq/EdXw0pP1WejPB
	 GhTYfnW310gkaOAUDfrnM7xnKA42IttasmxR9dQ4eMiFNRH/+1cOtO68dE4OsYvcWI
	 qV4adceT43wMhkzd3JQbeFR/+eC39VdHJmq5ZefoLn2msp2aODXb/YYSsGDyqAa1j0
	 jijF30bTBgpJZ6gZUFW9oVUitt0AH67xOVSjXtM+G7EpFS/gAlo8YfWFvkwdGIllBa
	 QB1Nj0/ZpxRPg==
From: Vinod Koul <vkoul@kernel.org>
To: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
 robh@kernel.org, bhelgaas@google.com, cassel@kernel.org, 
 Vidya Sagar <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com, 
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
In-Reply-To: <20250508051922.4134041-1-vidyas@nvidia.com>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <20250508051922.4134041-1-vidyas@nvidia.com>
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Message-Id: <174722268141.85510.14696275121588719556.b4-ty@kernel.org>
Date: Wed, 14 May 2025 12:38:01 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 08 May 2025 10:49:22 +0530, Vidya Sagar wrote:
> Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> check for the Tegra194 PCIe controller, allowing it to be built on
> Tegra platforms beyond Tegra194. Additionally, ensure compatibility
> by requiring ARM64 or COMPILE_TEST.
> 
> 

Applied, thanks!

[1/1] PCI: dwc: tegra194: Broaden architecture dependency
      (no commit info)
[1/1] phy: tegra: p2u: Broaden architecture dependency
      commit: 0c22287319741b4e7c7beaedac1f14fbe01a03b9

Best regards,
-- 
~Vinod



