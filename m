Return-Path: <linux-pci+bounces-38077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66296BDAED6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 20:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BE824F10E4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870627979A;
	Tue, 14 Oct 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd/HPIjL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A124DCEF;
	Tue, 14 Oct 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466041; cv=none; b=ruoVZqluduQ71nDBVH4bAWouvWikoVf0Xtcp2AkDWnynPmtWE/denUCxiEnaMoeDhOaNKjZid6RIRdijV7hqRLskc8jwO78WzkxmqSPGV4/IiooPFmMcOEs80wDpH+S4nv34loxB7qzZcIZwH5qFMSqp22ArMWX6UTD+qt0+VcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466041; c=relaxed/simple;
	bh=vhrUh0btdlfm1Rn7+IWBcAWYcgyJkAEWuMqo9pzE76g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XPSeifnxguFtWLiE3v/1QmdxQBTzp19pfq6wxoR4P66QeuRzzfVLPnXowo+8RKTZHIKsGJcMi6F7sIh101EvkJ14lieqC7ue0m9nR172wiVUtVgAoh295Ih2LWTfjcKPkwgErEGTSxES1YDddQKXg+8WBuUOGP/VihQz0VaB3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd/HPIjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D328DC4CEE7;
	Tue, 14 Oct 2025 18:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760466041;
	bh=vhrUh0btdlfm1Rn7+IWBcAWYcgyJkAEWuMqo9pzE76g=;
	h=From:Date:Subject:To:Cc:From;
	b=Nd/HPIjLaY9fzCI/JHtpdMSggma7txWn0D2HAisC3MyL5XOmJGUie/TapyUqPpLMO
	 GpUh1OYC8Fev5kIPO4CUFfjnI2blZxjGD+/pE6zMTihuEqVv62jLHHqKh8x/lKSP0z
	 9ixApxR15Fl8NYwdXvLJSxP+wbozCjbrNppfklKPLrYuohn1bjQBXI5+9zA0FvEp3u
	 tb9v/svNZRoU4ETsbT4ctym6TKzdv1U8x/ZwA/ymZRnLPo/Zne1IMoIE/kCLsYQH2f
	 Rq3WgEDfsSt2n5qnac7zR1Bn8DuTvTOtMRZjvrGSgTidR2cAGh/P6TfQP1mjL9zYWs
	 VxjPZh0Tl0cug==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 14 Oct 2025 11:20:27 -0700
Subject: [PATCH v2] PCI: rcar-host: Add OF Kconfig dependency to avoid
 objtool no-cfi warning
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-rcar_pcie_probe-avoid-nocfi-objtool-warning-v2-1-6e0204b002c6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGqU7mgC/53NQQ6CMBCF4auYrh1DkYK48h6GkLYMMEo6ZCCoI
 dzdyhFc/m/xvlVNKISTuh5WJbjQRBxipMeD8r0NHQI1sVWapEYn+gzirdSjJ6xHYYdgF6YGAvu
 WgN1jZh7gZSVQ6EDbsjDWe5e7XMXHUbCl967dq9g9TTPLZ8cX/Vv/cxYNGoxJL0XuyqxNstsTJ
 eBwYulUtW3bF1F8TKnnAAAA
X-Change-ID: 20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-1a975accb6b6
To: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=nathan@kernel.org;
 h=from:subject:message-id; bh=vhrUh0btdlfm1Rn7+IWBcAWYcgyJkAEWuMqo9pzE76g=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnvppTqhJxlO/hk04K/4jbf3jRLapxanbeD6V+9U5LOg
 eofsvbrO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBE/JcyMszfPj/x8mrujrly
 Putjd3xadc/3WWm3g6+26v2z/H/lbBgZGY4l9P7POd94OPzbNuHAUnO2q/+vPWp5VLgtkS1qIdP
 zhYwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 894af4a1cde6 ("objtool: Validate kCFI calls"), compile
testing pcie-rcar-host.c with CONFIG_FINEIBT=y and CONFIG_OF=n results
in a no-cfi objtool warning in rcar_pcie_probe():

  $ cat allno.config
  CONFIG_CFI=y
  CONFIG_COMPILE_TEST=y
  CONFIG_CPU_MITIGATIONS=y
  CONFIG_GENERIC_PHY=y
  CONFIG_MITIGATION_RETPOLINE=y
  CONFIG_MODULES=y
  CONFIG_PCI=y
  CONFIG_PCI_MSI=y
  CONFIG_PCIE_RCAR_HOST=y
  CONFIG_X86_KERNEL_IBT=y

  $ make -skj"$(nproc)" ARCH=x86_64 KCONFIG_ALLCONFIG=1 LLVM=1 clean allnoconfig vmlinux
  vmlinux.o: warning: objtool: rcar_pcie_probe+0x191: no-cfi indirect call!

When CONFIG_OF is unset, of_device_get_match_data() returns NULL, so
LLVM knows this indirect call has no valid destination and drops the
kCFI setup before the call, triggering the objtool check that makes sure
all indirect calls have kCFI setup.

This driver depends on OF for probing with non-NULL data for every match
so this call will never be NULL in practice. Add a hard Kconfig
dependency on OF to avoid the warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com/
Closes: https://github.com/ClangBuiltLinux/linux/issues/2134
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Switch from NULL check to avoiding CONFIG_OF=n case altogether (Mani,
  Geert).
- Drop Peter and Kees's reviews, as solution is not the same.
- Link to v1: https://patch.msgid.link/20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org
---
 drivers/pci/controller/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 41748d083b93..d8688abc5b27 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -243,6 +243,7 @@ config PCI_TEGRA
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe controller (host mode)"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on OF
 	depends on PCI_MSI
 	select IRQ_MSI_LIB
 	help

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-1a975accb6b6

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


