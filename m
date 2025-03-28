Return-Path: <linux-pci+bounces-24946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2AA74CE9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E06B3A7D00
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018A4188596;
	Fri, 28 Mar 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhE2tGtw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844C140E5F;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172877; cv=none; b=bO7Z0Y1Ay2Tqwz7KYART1Fdf9AKdGGkgtPXMgk2Dnk+a11ndgs0bh5gO2YqRcsjzSko3PVpfItl7znaJjL9NXdrvYUoA4gfkTkwTZxCU6uQA76YpZguc0pA3DoXgGJXx2E4xJu/YPBtG5Rty6TPqxWB7RYMJKnudujHDaLaTW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172877; c=relaxed/simple;
	bh=y7cHCyZAEfSlg6AyD3uU4qQU2vhubF/C2tytpK45mgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+g9YJYMMSomxHbC/9B0u6C8cv6gT5V/lqSp9y07jb6dh1TVz3NlaYNN2aFQcKa8yw55BjHCsTMS3a1mKhqj1aeswf7fa92p7DRVcuZVXgA0fKintcnvAHJASBzVqjqb3i9I4PlR60gYiRcwNpykdtlezTJlN8C+EyrajXXHfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhE2tGtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416FFC4CEE4;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172877;
	bh=y7cHCyZAEfSlg6AyD3uU4qQU2vhubF/C2tytpK45mgI=;
	h=From:To:Cc:Subject:Date:From;
	b=FhE2tGtwR/3+u2Pxi0Nic1s8CgrzGIuTvwq6WqBTWMA2CxUrHpLNg8V5M5U/5NMbz
	 sfkvii5DH4bxQq9Wr7+QsOJT4hKvSiENvMymmNdqLgyirCpuhaIYs7T+X60hfE5Hd4
	 lyBqTyiMMZDj2qBNM5DGdqCFo/YJV0xjBkQlmYgePwNu8IbTQ4v6baT/nbgkY7ZaPa
	 OX4ew5klYUT0UvgmxuRhinMtYq17kp5BPn5KPgAkGg2HaskmQyiom7Y2sYKWeet0g+
	 C/ZFo5TZh/XU7FjWncQ7FilvaeVkgqk2TAkB1WBn1jZ0nX/JdUN7k8bb2tuLrzsMzc
	 6Iif3uzKrFgBw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tyAte-000000007JE-3B3i;
	Fri, 28 Mar 2025 15:41:22 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig symbols
Date: Fri, 28 Mar 2025 15:36:42 +0100
Message-ID: <20250328143646.27678-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI pwrctrl framework was renamed after being merged, but the
Kconfig symbols still reflect the old name ("pwrctl" without an "r").

This leads to people not knowing how to refer to the framework in
writing, inconsistencies in module naming, etc.

Let's rename also the Kconfig symbols before this gets any worse.

The arm64, ath11k and ath12k changes could go through the corresponding
subsystem trees once they have the new symbols (e.g. in the next cycle)
or they could all go in via the PCI tree with an ack from their
maintainers.

There are some new pwrctrl drivers and an arm64 defconfig change on the
lists so we may need to keep deprecated symbols for a release or two.

Johan


Johan Hovold (4):
  PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
  arm64: Kconfig: switch to HAVE_PWRCTRL
  wifi: ath11k: switch to PCI_PWRCTRL_PWRSEQ
  wifi: ath12k: switch to PCI_PWRCTRL_PWRSEQ

 arch/arm64/Kconfig.platforms            |  2 +-
 drivers/net/wireless/ath/ath11k/Kconfig |  2 +-
 drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
 drivers/pci/pwrctrl/Kconfig             | 27 +++++++++++++++++++------
 drivers/pci/pwrctrl/Makefile            |  8 ++++----
 5 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.48.1


