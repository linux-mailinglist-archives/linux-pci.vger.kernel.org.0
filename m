Return-Path: <linux-pci+bounces-33239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61ECB1717D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 14:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251471AA20AC
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9502BE647;
	Thu, 31 Jul 2025 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BdQBsazb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEF23536A
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966165; cv=none; b=hZJAJ4kRv071SSGsYSvBIZSSovvHra+rcjwoZ+vpbC221hK10KYR1b8yH1XEOLuOk8tgS/lhrxMW8vwLyBDgwpXfihlXCVo3d87ykIYkH5cx1baDdue0GiGdgfp1Lzm11QAZPZOm7/FjKcDAU8IXgSfddpa796MkXRMeSEWfixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966165; c=relaxed/simple;
	bh=mkVOj2NTyAxnVS5zp9jHmusEh4Rd9O9gQokE52ch1aQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nbeqovx7BfgzfrGkrb6D4wRGU2ue3K7KdpsXe7CqnJzx0Ga9jkOBHjN7xL/TgFvD5ihmrZViGCluSJju3seqqbfjiooa+gWnejImNWFXPQou3ljkIz3fuTWluqk95l85E00fmEhsSZ6PZWKumoSAWjleHz9ePfkPBCDMJVYLCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BdQBsazb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so5695835e9.1
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753966160; x=1754570960; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83qJAscvMaL252urhMvFnilSG/WgmVTwHxPwthrKmiE=;
        b=BdQBsazbEM31OQEtt0K2aIfdbsPKjvXw4D/Zq441xdtPIY+X9sPozVvzW6Vla2xlxB
         03eDyHHXsa6WJSz6iJmwWECmo0uOCpw7Ff1HWHWoM0k1DTM8i56UQmt1pO8pNkeUCdkc
         x0GTofAjhxasWyWqSp1uuQ5n55GKRVVV0FdmN5cs+hvs+pVfK5Z6uBFHDHXRJ0+/p73W
         nAEvzsRRCFZw7azfWUwX3BX8q8Izu+bf0V4Jpqy4R5LkALkkLR3yPemjne2xBb/a7GAs
         ARVHPSutIfdUeTYDP+BkrrG/evJQk1tEnPRrihQ4Erl9J/7r3QhGgnG6kv/tWN4UgoLh
         gIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753966160; x=1754570960;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83qJAscvMaL252urhMvFnilSG/WgmVTwHxPwthrKmiE=;
        b=TxnicZCkjR+Yat2T/SEapEk8gkv5WqUgRBzYVnv6Cn+2fpJzTkVp0A48ARwK0iOTmi
         n41LKs1e9AbkZ7s00mdeggCLWEHprEEGQzKsNzh6b5ouF2egkDajQseLUA+NWmPJR4Bq
         ECWd117ukR55MghJXaisf5oMwg9WS9snxr3GUEIjFwmLu4BjmDiTkYfBcPMsXHCMLG1z
         XT+Nk2IWnq4kjs7xZwGJKzy3w+9IksjY2QXIiGhcKzWw+Wi3zOmGA7r4ai/88Vhj4vEr
         JReqk1olMnAJtLs20n22dEBZVbgGp0ve+YyeqpszeT7fDupkGTBpGzwVdLjVQD1ziexq
         GHsw==
X-Forwarded-Encrypted: i=1; AJvYcCUGEnHvGzUiHj4sAFu6HYtPGBeKz1bp3VSf4NXEX7bsN0XgWoMm41lkJ73Gg674P8IY06vKItcuGEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mDIi/MXdg9a/pURVtop6Sc49gmN6WzlNaPbgDZdPjeHhclcR
	zGTZ45VeX2vMpxE0iBhoLhG6BXLL/G4TjpmCHlD2GSld2KJ2YCrzJen6AsukwnsWew8=
X-Gm-Gg: ASbGncuRjiHtAEwFarriCBvbo8vaKc4UaVivj3ir9ZPwCFjtHAmcKs30YYAAdmATNFb
	9SXLxMV3Nf0rJPNsCLv16gl/6qu4BX3Qyc32nBg4d8gxlixuGrfz9M0T3HG+YMm4Z4a23RXtzW9
	HOHPAtAPhs0O7OH38KeCedFfldytCbt3+lKgOWI5wGKVR4FeukPWOjOAm624rrBRiQ+3VlYdD/e
	Pi85uBwL589NG74i58ECXxmuD7oAzbDelBrt/2pg0ClHK/klccG83+ImbKSnnhJXFpUbmUfX2h/
	Aj0Z5V5+SscinrTbt46hBzP1wa7MtTQP6DEI9f/TO4caLahvnyZRFdrMvR5tXu/MbUnrfthJCCG
	SE04lswJQ0CvURyLtaNaxf/Otzi5WT8N/BMek
X-Google-Smtp-Source: AGHT+IEeICcdaMQqoN/ClD3HLTeMYL8IlY10D3jv6jriHDKAB7/clGIWi4TbgOJ/MIilsJhI71LUHA==
X-Received: by 2002:a05:600c:8b81:b0:456:eb9:5236 with SMTP id 5b1f17b1804b1-45892ba3686mr75462595e9.15.1753966160507;
        Thu, 31 Jul 2025 05:49:20 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:bc36:d1e4:f06a:e214])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4589edfcdc3sm26496785e9.12.2025.07.31.05.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:49:19 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 31 Jul 2025 14:49:01 +0200
Subject: [PATCH] Documentation: PCI: endpoint: document BAR assignment
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-vntb-doc-v1-1-95a0e0cd28d0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADxmi2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc2ND3bK8kiTdlPxk3eSU1MTEpDQzw1QLEyWg8oKi1LTMCrBR0bG1tQD
 x83rpWgAAAA==
X-Change-ID: 20250731-vntb-doc-cdeaabf61e84
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Frank Li <Frank.li@nxp.com>, linux-pci@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bjorn Helgaas <helgaas@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=mkVOj2NTyAxnVS5zp9jHmusEh4Rd9O9gQokE52ch1aQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoi2ZLWZsA+zFwQXX+0XvAuP8szM4lJiXZoW2NQ
 zWY0y6HNwSJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaItmSwAKCRDm/A8cN/La
 hZTWD/95gKRIYfDY7sLoWcKrl4/uzvnfPfhoznwDtIsDVj+Nhd6x6YFiS8jRwOZUmM2x8FLBobw
 /xTSk9jI1eShAtn/pWBe/7eTzyNysVBuvZdkLYFiPasHr2gzuIpXuNdJzFZJxt4cqQPlmtAcmEm
 bbeaS15x//hNbGxBQaFM//HAcDLBqQhsVq+RdIJ5IYbvwq6gs5J0U894J0f8zqqbGBDumex3d+K
 ySeztabQKF58mL7Cjdx56edW1uhz3uWX+jBd4D/7VeCNm/Ljfm9evE3k46Ydyt5Grg6KavMXk2a
 gUnIZ9/oNxAkg+VWLetopjqunZqYqGV6xkVxAkzhMoWnKrqXZ/01/Ug2qftZHc1MrI0/pMOhiwC
 YFF68QYeWO0hnpwlrKAb/ZSgMU7pHOcBMm0hTrQ4b2/0Zm/lkAHXZaX/A6b4skPZlSPXVgCvth+
 uE0XJc8Rj4+4kEXYRLZGNREewFKQeudakaZ4Ov9IHgtAHi8ASQDbt5ghQj9wamDGwmOP9ozV02b
 nUCa1/D8vwqn2/W009XDS+M2m+U5oWCl7xRuUfvhoL/0OSRlxx/B3gR7wlWKjOgzFiA76nflxkw
 FTydrfWNRwNbtMHoeYTMrX1n7SuV9ESaiarTFyFlo4mc+fM04O6CeFLSPnGdBNJbSEvPhd7TtK3
 PmFCY6lTg/EbJWQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

It is now possible to assign BARs while creating a vNTB endpoint function.
Update the documentation accordingly.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 70d3bc90893f3315a7dff394d57e45c8378e2a54..9a7a2f0a68498e8b4297f24261954558d45c43a9 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -90,8 +90,9 @@ of the function device and is populated with the following NTB specific
 attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-	db_count    mw1         mw2         mw3         mw4         num_mws
-	spad_count
+	ctrl_bar  db_count  mw1_bar  mw2_bar  mw3_bar  mw4_bar	spad_count
+	db_bar	  mw1	    mw2      mw3      mw4      num_mws	vbus_number
+	vntb_vid  vntb_pid
 
 A sample configuration for NTB function is given below::
 
@@ -100,6 +101,10 @@ A sample configuration for NTB function is given below::
 	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
 	# echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
 
+By default, each construct is assigned a BAR, as needed and in order.
+Should a specific BAR setup be required by the platform, BAR may be assigned
+to each construct using the related ``XYZ_bar`` entry.
+
 A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid

---
base-commit: e046b1731006b4c6c94bcb4ef1c6692a30014c43
change-id: 20250731-vntb-doc-cdeaabf61e84

Best regards,
-- 
Jerome


