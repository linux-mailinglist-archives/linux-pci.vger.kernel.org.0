Return-Path: <linux-pci+bounces-32364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E75B089ED
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C78C170EC6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6410291C30;
	Thu, 17 Jul 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss0gnunK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB60291C24;
	Thu, 17 Jul 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746004; cv=none; b=CsCCRug5hoVWsEg5wkj+RqQtws1GMs04d8m2sKmdPntCuR0B2xNuYv8od15yZh4F8E0ZweQ05tq+yW/Kemhzecf72mn9hk2+PaWSjYlktASdATkbKMD3Tj5/oFH93qzPMsN55zx9Yu/wZG29o5nw6tBtx/bWiY9uC3MJJXlp2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746004; c=relaxed/simple;
	bh=79WBhvJn26OfZelR9I5aNME3T7KKPk5kwAHzs9mtrWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTrEegAcJyWWVMlq1d2/TMoFiIr7+GWrfX+fdbwn1/MBVpGCmY3P/VsqKfW/PJkVqYxa0SNeifra/opgozd54U2aHAivINZAJigGLRZEfAoi/b4hKcTc0639mMzosvdOgMb6UcjgR6BbN4V4FkjS8a6MzLhKfLIeshfxSj3w24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss0gnunK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4A2C4CEF7;
	Thu, 17 Jul 2025 09:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752746004;
	bh=79WBhvJn26OfZelR9I5aNME3T7KKPk5kwAHzs9mtrWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ss0gnunK0w/lqoGyuWXzxn6IwCftyipoYUczlCWvEDN+/XwvvnFYfs1jIosBn07yK
	 cBoW022cIxh5mkGU2bumukgtJsQyRtXkbjei3Xjj0Tgqj6GP7tMJKK1NNfqdQzgoLf
	 aMvPe3hknB23C1KbLKhwhqbVe/WZP58Uipek/jWOS3r81AN9JJlnmmZRhMaPdFqAoE
	 utgRTYqMYqFBTjyIJ43+VDtxfa8OkTi+lTRq5Cf8sEZZFW5bGSPgcKBWuuBCCSXLDI
	 iofq45uEXG5IK3sDKpz8vHdmx/1I2/BLOm3IHfbC7Qtwr3uNC58Iq5DViELTQU/ryR
	 erchg6tWqfAWQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Toan Le <toan@os.amperecomputing.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/13] PCI: xgene: Fix and simplify the MSI driver
Date: Thu, 17 Jul 2025 11:52:38 +0200
Message-ID: <175274579907.217726.8694214469184941348.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250708173404.1278635-1-maz@kernel.org>
References: <20250708173404.1278635-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Jul 2025 18:33:51 +0100, Marc Zyngier wrote:
> Having recently dipped into the xgene-msi driver to bring it to use
> the MSI-parent concept, I have realised that some of it was slightly
> sub-par (read: downright broken).
> 
> The driver is playing horrible tricks behind the core code, missing
> proper affinity management, is terribly over-designed for no good
> reason, and despite what MAINTAINERS says, completely unmaintained.
> 
> [...]

Applied to controller/xgene, thanks!

[01/13] genirq: Teach handle_simple_irq() to resend an in-progress interrupt
        https://git.kernel.org/pci/pci/c/fad9efd72b5f
[02/13] PCI: xgene: Defer probing if the MSI widget driver hasn't probed yet
        https://git.kernel.org/pci/pci/c/b3ffac51b6a7
[03/13] PCI: xgene: Drop useless conditional compilation
        https://git.kernel.org/pci/pci/c/1ded8cc14884
[04/13] PCI: xgene: Drop XGENE_PCIE_IP_VER_UNKN
        https://git.kernel.org/pci/pci/c/14a347069f71
[05/13] PCI: xgene-msi: Make per-CPU interrupt setup robust
        https://git.kernel.org/pci/pci/c/84cb4108bf6f
[06/13] PCI: xgene-msi: Drop superfluous fields from xgene_msi structure
        https://git.kernel.org/pci/pci/c/61aeded55e5b
[07/13] PCI: xgene-msi: Use device-managed memory allocations
        https://git.kernel.org/pci/pci/c/a782a50689d6
[08/13] PCI: xgene-msi: Get rid of intermediate tracking structure
        https://git.kernel.org/pci/pci/c/9a7ca398f2d4
[09/13] PCI: xgene-msi: Sanitise MSI allocation and affinity setting
        https://git.kernel.org/pci/pci/c/7112647f6d19
[10/13] PCI: xgene-msi: Resend an MSI racing with itself on a different CPU
        https://git.kernel.org/pci/pci/c/b43fa1b0691b
[11/13] PCI: xgene-msi: Probe as a standard platform driver
        https://git.kernel.org/pci/pci/c/a435be2c3318
[12/13] PCI: xgene-msi: Restructure handler setup/teardown
        https://git.kernel.org/pci/pci/c/f7d447633452
[13/13] cpu/hotplug: Remove unused cpuhp_state CPUHP_PCI_XGENE_DEAD
        https://git.kernel.org/pci/pci/c/8db22d697c52

Thanks,
Lorenzo

