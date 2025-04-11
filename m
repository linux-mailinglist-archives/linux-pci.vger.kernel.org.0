Return-Path: <linux-pci+bounces-25687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51028A86550
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B24C77ED
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8689C23E342;
	Fri, 11 Apr 2025 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYFuECb0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10E2327A7;
	Fri, 11 Apr 2025 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395414; cv=none; b=ZzRCSbJMn96VEQv8v5xq14peRU6Kd0vkhAizTUjosPWmEbAhJrUh5KM3U8Sh9jjTaPTQnH3xpVXG6+pqC551PVLfB/CSm8hGeDECV4A/9s/Du/0VSyqKRAK4qVNixxu4SvfrWl7qn4vkSTOms6bwpaVTxqULgb7REQ1axaH1iU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395414; c=relaxed/simple;
	bh=XNtqqAHgR695XgtcHPHjLS8pXle7c+HwYMOiA7eo3Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fwb372C6Las37q30DtfSMbP9Eaakqgj9kqT9rARqzdnYLUyzENt3PgyLjCjAy0O8y85XJcjlQqR/LzFc8On9ZWTWqIV+IKQPLh71aXfudlBjXrOjVRCOMHyiDWprRoxjPZXJYCd8wRkB1DviDiYn4gppshNtZRnihLN0NfO6SgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYFuECb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C668C4CEE2;
	Fri, 11 Apr 2025 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744395413;
	bh=XNtqqAHgR695XgtcHPHjLS8pXle7c+HwYMOiA7eo3Yk=;
	h=Date:From:To:Cc:Subject:From;
	b=OYFuECb0NNpnTKoGuCwefHFNYdNH8h+Xdtqa2j6p/yqSucd3UhC6iMBHT8QvU3Lgq
	 beAOjX87+GvYEnJreoXarAXtRXrAsPF6Vcox4Zfo7T6CRiI/vfKu661z8Gh9zA+ZaX
	 AQ1nK4pd8ZH+Onv3cXNR9Pf7fhYdqeVsuFW8DPyh31SMrywhpUuUALiK4ukux2qx3d
	 LVCAzNjuhTXicQanAHVzyTxmzVav/psRQ3j4Ii62cpvmCBGM4Xr5OihhV5q4FTlAJL
	 SoH1SZkN+1fjZONtIkp2jf5an9pcevsAa96Iqh5XNv6mv5cMNF4mnz6nCeKwTaCRuO
	 iIRa2wAEAB/IQ==
Date: Fri, 11 Apr 2025 13:16:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: [GIT PULL] PCI fixes for v6.15
Message-ID: <20250411181650.GA372618@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.15-fixes-1

for you to fetch changes up to c8ba3f8aff672a5ea36e895f0f8f657271d855d7:

  PCI: Run quirk_huawei_pcie_sva() before arm_smmu_probe_device() (2025-04-11 12:53:21 -0500)

----------------------------------------------------------------

- Run quirk_huawei_pcie_sva() before arm_smmu_probe_device(), which depends
  on the quirk, to avoid IOMMU initialization failures (Zhangfei Gao)

----------------------------------------------------------------
Zhangfei Gao (1):
      PCI: Run quirk_huawei_pcie_sva() before arm_smmu_probe_device()

 drivers/pci/quirks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

