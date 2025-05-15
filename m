Return-Path: <linux-pci+bounces-27812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4411DAB8C7A
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88491BC114A
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753D9220F38;
	Thu, 15 May 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpG7mRu8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A021FF4D;
	Thu, 15 May 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326590; cv=none; b=Avta/4aQVJftjtR3RrtNNeMcoA/8W24q83RYL4l+lVACRjucuJZ9R73AzE6Dh4Tukd0NgC7oybwUozDYDI0N87Y5Nox6Q/hdPEzWP85wV0I9/efjl3xZdD8sj1ciz2d60UdZM6BPyRsgov2BipSOEFngOyi0OHSK4IhWeAc+240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326590; c=relaxed/simple;
	bh=SP3jLLDqgppb0BWsw2wDAUmu6LjLbVfd/CLpji6vLqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK4c0rZL8ctv/9fFmVZzPb7jUE/Fo2+v8UM0+poHrR9/BaNcLb70yPQihpgmMBm2RRbaL61D2CtqD518eD13DtiVnDvCeyUVAZiPOUD++7gflM5XGvTals/udS/ibPikVkhB+7UPaa5+keeJQtgsC1y2JWaVtmdV3tRzPKWTJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpG7mRu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE553C4CEE7;
	Thu, 15 May 2025 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747326589;
	bh=SP3jLLDqgppb0BWsw2wDAUmu6LjLbVfd/CLpji6vLqY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tpG7mRu8EOJIwf4I9eWaTx5wMK2XKXohHjjh0ZxpsOILBzW8vJ/C/SZr0z6hKh0PO
	 3H0nip3s8bmI0Fj8dSmgyEa7t1pCox6jQ8pcfMb21c8m0DdYZx2oKUcO5EcIp0Jh8w
	 CsHY8UazTnRltYy6Qg4Lwb5Q4NsvSPTNRaxab8uF1UJmTcVeesrFFOV0fZ6lzf9Yqm
	 pNJ5t3j9uukmn86hOOJUbjvgRWygnh3Jl3W9458FE4sL3l08706CXf/axvx2yEEB9y
	 2/gDrhRA82FNmOqcaQg6qp/bqrV+7tCwS8I85glP5WjLbvH3DQggLCU47CnzogAMbW
	 z/Kr24FZ8cXMA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/1] PCI: Update Link Speed after retraining
Date: Thu, 15 May 2025 16:29:45 +0000
Message-ID: <174732656472.65286.1704390633596082407.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514132821.15705-1-ilpo.jarvinen@linux.intel.com>
References: <20250514132821.15705-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

> PCIe Link Retraining can alter Link Speed. pcie_retrain_link() that
> performs the Link Training is called from bwctrl and ASPM driver.
> 
> While bwctrl listens for Link Bandwidth Management Status (LBMS) to
> pick up changes in Link Speed, there is a race between
> pcie_reset_lbms() clearing LBMS after the Link Training and
> pcie_bwnotif_irq() reading the Link Status register. If LBMS is already
> cleared when the irq handler reads the register, the interrupt handler
> will return early with IRQ_NONE and won't update the Link Speed.
> 
> [...]

Applied to bwctrl, thank you!

[1/1] PCI: Update Link Speed after retraining
      https://git.kernel.org/pci/pci/c/6ade6e81f898

	Krzysztof

