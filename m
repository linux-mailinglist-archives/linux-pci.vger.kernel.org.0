Return-Path: <linux-pci+bounces-1218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419C3819E1C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 12:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25C928AD1A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 11:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C61208A6;
	Wed, 20 Dec 2023 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue8ojmu8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245F2136C;
	Wed, 20 Dec 2023 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77f48aef0a5so278740885a.2;
        Wed, 20 Dec 2023 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703071942; x=1703676742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxgS9u6mFX9Ztz+0R/k8TQqg/aAzdW+aDbsddeXhpos=;
        b=Ue8ojmu80hBzCWFTKLGqRr6styg386bR8K+JsW/w3MXhsl0CULtuaW+Ed0lc8l2az5
         tkqq59HzvG0RBhZ2XVTkJm/4HykGLz8qXPZ/pTc6P20UtO94Ak9S/q+9CCJb7T+qCBuK
         QgPAmorxCrOdm8u1f0jqH8i+AFiYbMBMr+jD+awxtfrMkrQr5mBLCtRD4evKTkm5HyJW
         Q9fo7tttUkJNwiyYM6VXOz65FNukcEHt650pVYDMra4SS6cRV2/plvahSjcd+owU7htm
         i/+i+dE7m6qMOgabWIky/C6znQII7tLe7Mkf9UpWDOUr7wN0kx0XSANVrnDKkhmby9iY
         R+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071942; x=1703676742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxgS9u6mFX9Ztz+0R/k8TQqg/aAzdW+aDbsddeXhpos=;
        b=S4q1SCAbPUXq5GWzkfGV5pXDYxTPOK05eT3WixswcOBd+0D/vZ0oA5nWW6qOPJlF7S
         iwg4WGuhcIpiw/zHUHpW3g1q+KwUfKJzSgxq3b0XQyp2thvmbX37gMiRVLcTJeyjiDDZ
         3XXoNBHbtaa+ccHoncy9PbPcI2VVyxVB0Twtlj+QT8+ObTvwRj8g0cwmRG3aV0vzkNk2
         XdkrhXAxgg+g+hmGyD2xoE/RzSX/v09W6WV0zezQFymslP+lNYtUxIMUtGQkmMNBplY2
         G749GUejPC41VxhDXH2G2EFZRsXtKPOdsrNnCDVuMgMK1Hr3vrdFJjYIEae6jGGYWDFM
         3N1g==
X-Gm-Message-State: AOJu0Yxs+zc45oXQwnjT/m/fFXK7P9PMRwd12sGq+7FYrkzDMGS8Xu+z
	ozl6BjH91qTxNXsYjYnKJMI=
X-Google-Smtp-Source: AGHT+IE6EECnpVJXCAv9L9t6SHEec7vLbyEGxkPTXd4Vcz28TeLelCP82vA+JuGKvqz78NqqgjykRQ==
X-Received: by 2002:a05:620a:15a4:b0:77d:85d9:c655 with SMTP id f4-20020a05620a15a400b0077d85d9c655mr14993188qkk.14.1703071942321;
        Wed, 20 Dec 2023 03:32:22 -0800 (PST)
Received: from morpheus.home.roving-it.com (2.1.9.e.d.3.3.1.6.1.e.d.5.3.a.e.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:ea35:de16:133d:e912])
        by smtp.googlemail.com with ESMTPSA id d3-20020a05620a240300b007788c1a81b6sm561717qkn.46.2023.12.20.03.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 03:32:21 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Joseph <tjoseph@cadence.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] PCI: cadence: Fix TI J721E PCIe SoC dependencies
Date: Wed, 20 Dec 2023 11:32:08 +0000
Message-ID: <20231220113214.413632-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The J721E PCIe is hardware specific to the TI SoC parts
so add a depenency on that so it's available for those
SoC parts and for compile testing but not necessarily
everyone who enables the Cadence PCIe controller.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/pci/controller/cadence/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 291d12711363..1d5a70c9055e 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -47,6 +47,7 @@ config PCI_J721E
 
 config PCI_J721E_HOST
 	bool "TI J721E PCIe controller (host mode)"
+	depends on ARCH_K3 || COMPILE_TEST
 	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCI_J721E
@@ -57,6 +58,7 @@ config PCI_J721E_HOST
 
 config PCI_J721E_EP
 	bool "TI J721E PCIe controller (endpoint mode)"
+	depends on ARCH_K3 || COMPILE_TEST
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
-- 
2.43.0


