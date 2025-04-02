Return-Path: <linux-pci+bounces-25172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29428A78FB3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC60116C524
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D517E23A99E;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtH73OU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEF23959B;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600421; cv=none; b=AH9xwMPgDpInymRCHi37yAdKOLMWcAIIe9JY8/V/dXZLCX0SLJ4zmIMbMwhnhQt53t165iKd52BtlvhEEa0suqbm4LT1g++SR7qjezA4OR8IdMwJDD8yrRJTKaUJPjh6/Jv0pvyXKFhiQ+FvnALN1ykZOA1V8BCXVqlTdEP1zyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600421; c=relaxed/simple;
	bh=ClNiKdAaagNCBF9poM6ZVmYqqOtAci1UecszB5V3I5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dh9S4qSBqkGlYAP7RFR2NOpfCNe9a10yzc1NYrK5dJehPMAyPTHoUwdZLntAeipocGPZ9FcCgywj88+izole9OsLwq9zQcUgy/P5VR5t0LU9bnSCrVhM/cDc9b6jPilevH6zUH1DQdlUQb3VvTBW+x2LvZC53YDHCI4dhi/cvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtH73OU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255AEC4CEE9;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743600421;
	bh=ClNiKdAaagNCBF9poM6ZVmYqqOtAci1UecszB5V3I5c=;
	h=From:To:Cc:Subject:Date:From;
	b=UtH73OU/kW3B3D43xBbmfrpfLXDrN7UH9K2u9Xr+YmIyZLa7+A0rlj9pQUMSzrdwN
	 SqYlJeNcA4LgKBPe6wjPh4bXUrlele19Yx/kkPTWT/ZECaSZw1G75/GnIfjYrEJ3Cv
	 LSR+eouyTdZF3guzUAiF+buNxaoGIuqDwHIogrSCI3eOOh9j5L66OqPEzIkP0Ev+Nd
	 Gds33G9CNdXLMMLWGx0Nun1b3tffn848JcPeVxNJiULVykTsTjtX2t0t5GxG8z7wEI
	 1d1erz0Yb0jZHYFr0fzt9H86qKHoZVgB81RLEJ6ioGrbjJ7dAcbf91NerpywAfaqlz
	 CSb7puTLyYjEA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tzy7V-000000004iG-2W68;
	Wed, 02 Apr 2025 15:27:06 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig symbols
Date: Wed,  2 Apr 2025 15:26:30 +0200
Message-ID: <20250402132634.18065-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
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

The ath11k, ath12k and arm64 changes could go theoretically go through
the corresponding subsystem trees in turn once they have the new
symbols, but to avoid tracking dependencies over multiple cycles it is
much preferred to have all of these go in through the PCI tree.

The wifi patches have been acked by Jeff and I don't think Will or
Catalin will mind the single rename in arm64 if they don't see this
message in time.

Note that the patches could be squashed into one, but keeping them
separate highlights the changes done to other subsystems. I also find it
easier to review the changes this way.

There are some new pwrctrl drivers and an arm64 defconfig change on the
lists, but the former should also go in through PCI anyway while we can
make sure that the defconfig update matches the new slot symbol.

Note that getting this rename into rc1 would be great as that way it
would end up in most subsystem trees soon as well.

Johan


Changes in v2:
 - drop deprecated symbol for the new slot driver to avoid having to a
   add a new user visible symbol (e.g. any early adopters will be asked
   to enable the renamed option again)

 - move arm64 patch last two avoid temporarily not having the pwrseq
   driver selected (Jonas)

Johan Hovold (4):
  PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
  wifi: ath11k: switch to PCI_PWRCTRL_PWRSEQ
  wifi: ath12k: switch to PCI_PWRCTRL_PWRSEQ
  arm64: Kconfig: switch to HAVE_PWRCTRL

 arch/arm64/Kconfig.platforms            |  2 +-
 drivers/net/wireless/ath/ath11k/Kconfig |  2 +-
 drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
 drivers/pci/pwrctrl/Kconfig             | 22 ++++++++++++++++------
 drivers/pci/pwrctrl/Makefile            |  8 ++++----
 5 files changed, 23 insertions(+), 13 deletions(-)

-- 
2.49.0


