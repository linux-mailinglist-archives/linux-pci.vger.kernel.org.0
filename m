Return-Path: <linux-pci+bounces-29637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F23AD823F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 07:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294261896870
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE190248F6F;
	Fri, 13 Jun 2025 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE2jeHGp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C51FDA89;
	Fri, 13 Jun 2025 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749790991; cv=none; b=Vw/LJRLk7NvesPpbyomh4rwXoSGotM5vm6boLHbhwDqrZ7coxOSEEgTCQd4BKTQOr4XpjeiFC+bVZknVBiddOC2gcuoNmjgrzjUvERf3WLsOqP0Tih6JyfAUFZ73qk31WnS4NL7bxQg4/Y9MctsBlUKFelUrk4H8zjQE+b8NBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749790991; c=relaxed/simple;
	bh=28rc7+v2kVerXbyWw3H3/T6kr4GP6Mq7cNkFNrIXQNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMlGHbwAu5Avd1QdXa5ly/4lVBd3vqxXW8908i1Oh2rwBqad9CTlub6y8X75ixTe7wHPYzatQZlMIMcG0+jIIX5q+bGAQcV0L4jHmBrt4IL/5Cpz8Jd4XxsNt/TvPB++7cl/foHzNgEvuelhZ8m5dkuUHTzzTlQ6luIzwSPn+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE2jeHGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888CDC4CEED;
	Fri, 13 Jun 2025 05:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749790991;
	bh=28rc7+v2kVerXbyWw3H3/T6kr4GP6Mq7cNkFNrIXQNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE2jeHGpZEIpEa7JSqyBP6T/bb04h6phgaAJVRf8pB34y1utOutI5D7WNH9Bu6yFi
	 1K6N84HfvDGSEL9GTJ60egmOOykPwwCURDOLzjiAX0ACTkxIbm5KdFkzgPyvZTLZEq
	 8xkVvtiuxgeWCMVZ7Hd+cYopqEBpAjo/njYAl7x3fGSkMSXTsoU7BUW1lsb5uXKs9m
	 DohChY2Ptfp0wC/uCNJZ3q9+0DrX2qqu9Izj6/Ia60v6QyQHxXdrDtLNNEjXAqmexn
	 so2m4sfzyeFoyv1FKH3dFyLk/OLNHG1DGOSy4qtkTNuUBWiWzT+ntZZpu83WhO05EX
	 Z2HOOEtG2IX0g==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Niklas Cassel <cassel@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Shradha Todi <shradha.t@samsung.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 0/2] riscv: sophgo Add PCIe support to Sophgo SG2044 SoC
Date: Fri, 13 Jun 2025 10:32:54 +0530
Message-ID: <174979096373.22387.8666752122012744282.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504004420.202685-1-inochiama@gmail.com>
References: <20250504004420.202685-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 04 May 2025 08:44:17 +0800, Inochi Amaoto wrote:
> Sophgo's SG2044 SoC uses Synopsys Designware PCIe core
> to implement RC mode.
> 
> For legacy interrupt, the PCIe controller on SG2044 implement
> its own legacy interrupt controller. For MSI/MSI-X, it use an
> external interrupt controller to handle.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
      commit: a202f09e3e30622fdcae7d740dbf87fb0f032dd5
[2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
      commit: 74ab255bab3082fa6bd2a925a986526e093d615b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

