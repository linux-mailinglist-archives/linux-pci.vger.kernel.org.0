Return-Path: <linux-pci+bounces-4342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6186E77A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 18:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75171F260A2
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985A5848E;
	Fri,  1 Mar 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw4zy5NL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26A11723;
	Fri,  1 Mar 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314813; cv=none; b=Kdo/Ga/CB3hi1XOOy0HjMR2DDcrQU3rB0K7s+zseSZypnTVzTRdU+NoeMrJFEfYPjECMbp0jeatI3d/5DWa+w/38UYpCtTApBiGO2pN+X49PoZg4ZTtpl9TJVP3bU0X6gNOtKZA8n+9b3SurGNqdZA/VvDqQw5HeWVpUNmpYLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314813; c=relaxed/simple;
	bh=NY2+S+4ftdoGJbkK25bKSEu+LmVTZzCG/sAQVPrZHfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Mdfa3VI1m58/vhNsMKrvcMwBC4ZevZ3VhB67heUlcYNUwmQSktrh18czAC27RFbZ+MaZ7dLMmYMIx+3B0/bcYfyEnm0k2cxCErPM65j5q0hNIpimtAty+TlQsOT5FWhjSmhMFcNaiyDof4rygDyIirFNP8A+LVGISMfbVkcwV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw4zy5NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21ABC43394;
	Fri,  1 Mar 2024 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709314813;
	bh=NY2+S+4ftdoGJbkK25bKSEu+LmVTZzCG/sAQVPrZHfA=;
	h=From:Date:Subject:To:Cc:From;
	b=Jw4zy5NL+gUW+xYZRwSOxIMS892o/JzeH/fWgQ5pnYcAksKcylFf8BKPSFrvutFgF
	 Hh4RCxlXluFIz465yJe1hQ0JkLiAElexKhz6pU++XKlcDP9cJ6AN0LRhy4CpFWHyyK
	 s7dBUsPwkPKrYTLE1KODk7ISJMDRODUVsuI1v23KELZIXJarA81mLSFZ81Cqk6gyci
	 wevgn6dW9o02x1J+5E4oChTgbuq562ijd5pRpcHNYKQfDMWv/KmSpu7uwlTMJ2rANM
	 HhEPCNN3sGbGLI+xcEotFOCZK+4sVvF4wgcJzp4yFG5wyR3BDBgiyUNrAibt5Z93j/
	 iN6LAGKzFSskw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 01 Mar 2024 10:40:01 -0700
Subject: [PATCH] PCI: imx6: Fix clang -Wimplicit-fallthrough in
 imx6_pcie_probe()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-pci-imx6-fix-clang-implicit-fallthrough-v1-1-db78c7cbb384@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPAS4mUC/x3NSwqEMAwG4KtI1gZSdQTnKoMLbVMbqFpaZxDEu
 xtm+cH/uKBwFi7wri7I/JMi+6YwdQU2TNvCKE4NDTUdtWQwWUFZzx69nGijRpQpipUD/RTjEfL
 +XQK6ee7d8CLjqQNdS5m18X/6jPf9AD5JdPh5AAAA
To: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
 kw@linux.com
Cc: robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
 linux-imx@nxp.com, Frank.Li@nxp.com, manivannan.sadhasivam@linaro.org, 
 p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=nathan@kernel.org;
 h=from:subject:message-id; bh=NY2+S+4ftdoGJbkK25bKSEu+LmVTZzCG/sAQVPrZHfA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmPhH4rJWUov71fwT4321UsZ2JzVHe/ndH7kMxX98vYv
 /rp+1R0lLIwiHExyIopslQ/Vj1uaDjnLOONU5Ng5rAygQxh4OIUgInYzWJkeH5LcWGBuLw755wM
 hYZSFTfxBVN3MdaVBT8v0t7wMSyviuF/maHzJNuX3+/I71XVOHy6L44x58Azqx2bXr8slCk9etm
 HEQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y or W=e):

  drivers/pci/controller/dwc/pci-imx6.c:1333:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
   1333 |         default:
        |         ^
  drivers/pci/controller/dwc/pci-imx6.c:1333:2: note: insert 'break;' to avoid fall-through
   1333 |         default:
        |         ^
        |         break;
  1 error generated.

Clang is a little more pedantic than GCC, which does not warn when
falling through to a case that is just break or return. Clang's version
is more in line with the kernel's own stance in deprecated.rst, which
states that all switch/case blocks must end in either break,
fallthrough, continue, goto, or return. Add the missing break to silence
the warning.

Fixes: 666a7beb942c ("PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2004
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403011431.vIVOdwob-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7cd165d03649..99a60270b26c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1330,6 +1330,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
+		break;
 	default:
 		break;
 	}

---
base-commit: b73259dcd67094e883104a0390852695caf3f999
change-id: 20240301-pci-imx6-fix-clang-implicit-fallthrough-dbb6d9501f04

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


