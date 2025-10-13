Return-Path: <linux-pci+bounces-37939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FBABD5B2A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 20:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94A693511E8
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E162D73A5;
	Mon, 13 Oct 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbVRqVIj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA52D739B;
	Mon, 13 Oct 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379962; cv=none; b=Vv4uITvxxA5MjmFPgO8F/d35Rq1tm6ULXPvMhR0W5bmPL+c8h/2tBL1uimNFDEsy8W3FTqwWDHsIs7qawdxFlEfeII4HcatrxuwXOt0vDq24bUgVYxxLSh4GXBLqr7X0Axb9afxeggS2ApdZdL9iiJJGxxdUodz14woPUxmOzQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379962; c=relaxed/simple;
	bh=IbjallnL0fhMN27dTZKt3qvk8uPiXVxAt0Oai4AKDlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QbD/uLIGY0SXzwbfmnHcNivTw7rHXxeCgSH2wlHl7qgaRt2gU7QnATy3pA9E3wwYCoQBBPm6ZfSzgT8IfXmaCNvIgF6qUCGuu0vwXLUeNf5phKNj/E5OS+3WQn1zwZAJjn/lZzn3ChX1zIEnIo/3mKPi7koN+zT3VYSC6M45HUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbVRqVIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A51C4CEFE;
	Mon, 13 Oct 2025 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760379960;
	bh=IbjallnL0fhMN27dTZKt3qvk8uPiXVxAt0Oai4AKDlc=;
	h=From:Date:Subject:To:Cc:From;
	b=XbVRqVIj1R+XjbRcPyE8KocV8FRTmweUiKiM5eAVGsUn+sAZU0h1rxxQXzFG1AtGZ
	 A32o8HVkr0YsOdW11lZMxhcyVNT519jdAFiizkoMUbP5bqZuzFXpK3w44BZZvRcfi+
	 FcF5+OFUHCrmzkJeBxmye9kFnGvMU39D6Z+MoUnQJYBhlfi41Nrq6WnxrBYntP9LEG
	 n3dgOK+DVIF1fj+Xos7QqW9SLHV+IJGSzWDbg9mD/osAU+ZBaL7Z6rfczXNHnoztLp
	 B1bmCafDP3t87IvfKV/U74pIE4J3KJ/qRv0XmOc6bXS5cfPTPf8544UxBZNrG0ByLJ
	 8gRqh4j1EpUSA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 13 Oct 2025 11:25:49 -0700
Subject: [PATCH] PCI: rcar-host: Avoid objtool no-cfi warning in
 rcar_pcie_probe()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org>
X-B4-Tracking: v=1; b=H4sIACxE7WgC/x3NQQrCQAxA0auUrA10Kq3oVURKJk1rRCZDplSh9
 O4OLt/m/x2KuEqBW7ODy6ZFLVWEUwP8pLQI6lQNXdv1oQ1ndCYfM6uM2S0K0mY6YTKeFS2+VrM
 3fsiTpgUDXS89McchDlCL2WXW7/92fxzHD6VNN7B9AAAA
X-Change-ID: 20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-1a975accb6b6
To: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Kees Cook <kees@kernel.org>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=nathan@kernel.org;
 h=from:subject:message-id; bh=IbjallnL0fhMN27dTZKt3qvk8uPiXVxAt0Oai4AKDlc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBlvXUzCPO57T+w/2/jdp4qLQ67OoJnPQU7atO+ZWL/st
 Yruq/s7SlkYxLgYZMUUWaofqx43NJxzlvHGqUkwc1iZQIYwcHEKwEQC+xgZzvqWTez0PJiZKiC0
 LoBL7uGRau647FkXmGJOynHZddoZMDLMuruKec+DXoOPbp4HVnR2CN4TF7z/dnX7EoYD53KqvHZ
 zAAA=
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

Check that host->phy_init_fn is not NULL before calling it to avoid the
warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com/
Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Another alternative is to make this driver depend on CONFIG_OF since it
clearly requires it but that would restrict compile testing so I went
with this first.
---
 drivers/pci/controller/pcie-rcar-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 213028052aa5..15514c9c1927 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -981,7 +981,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 
 	host->phy_init_fn = of_device_get_match_data(dev);
-	err = host->phy_init_fn(host);
+	err = host->phy_init_fn ? host->phy_init_fn(host) : -ENODEV;
 	if (err) {
 		dev_err(dev, "failed to init PCIe PHY\n");
 		goto err_clk_disable;

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-1a975accb6b6

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


