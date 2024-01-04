Return-Path: <linux-pci+bounces-1689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6CC824A6A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 22:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5071C22558
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C772C6B4;
	Thu,  4 Jan 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKOeXtE5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E512C843;
	Thu,  4 Jan 2024 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d89105365so8299285e9.0;
        Thu, 04 Jan 2024 13:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704404354; x=1705009154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJK+F6Qom6bOuWneTyWgoS7yf7BlaLPC5ulr8n237s8=;
        b=RKOeXtE5JZsXYS0xVwvNiXJfiCCmb0Te4qqlY0+OJj2A0YrUEZCiLI52Xzp2ZNOEsW
         wbSbmXl3UZ1dwDJy18kEZZmO6LkX28ecv+NrWOgyH73hoQt1nyS8+CQ5VaHPrM8yIEVx
         SHcHvZFzp6Bl33jpCUYhaEZbMrVaQyMyOKyeyJ4gKtOK+I2ljmrAwxB2/XjBk4o8wbGc
         lUMME/CrhlIko1flKezQuC5sqNdu4axFz2ewI7ZSBglrgXSW+wsoTR4utJODogOkUd6O
         +WH14zmZhI3w4McEZ4fbfHBbL5Qzq7beWzQt/Iw5lQglawJvIIeuTuVIm9eBfzulSlQr
         TeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704404354; x=1705009154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJK+F6Qom6bOuWneTyWgoS7yf7BlaLPC5ulr8n237s8=;
        b=QJ9WZVqYSCGZxwxDv6lCXnL0scPg8dq0STZqvaGuvILjKXmbJu3NwZN+hlIUCAW5cl
         aOyVQiv4RjD5MNeKI8+oteQnOIQaAEAvzE5QQSppuT3tT8WJD9DRajSt31yPPTz1x8T1
         D3LQHWTdYa/uPztNxSNVGBqLrCz3XTs2tAsC4CAwcXx1YK/11aUMolzXAv+f017rvsmX
         2ZahMFmUhT0jJ0VFwmR+kRKwitf9Fw6QSlO2g9ptqRYZvn8PyB19IZkQcQlMPHaf1ZEY
         TnQHs4jn470ZJ6pXPz1VJ/Lzpek/d35Mx3xEMI7ahCgHTybDKeO6NEG+SIXvhX/XgfAh
         Rwpg==
X-Gm-Message-State: AOJu0YxNJS0QJH5XHKSlxkieR47tvFZRPhS2E7jeTwnr/n+igPDq6uJv
	4ur7bOe9mPSujpvfsfynlMo=
X-Google-Smtp-Source: AGHT+IGUSpPKUOlFx8Hvt/+kL8lQQXcoyUmCDZZSmiYinw277t7s4AGRimP9gM6yliLNDF7WF3J0bw==
X-Received: by 2002:a05:600c:3b96:b0:40d:8849:5737 with SMTP id n22-20020a05600c3b9600b0040d88495737mr651462wms.62.1704404354434;
        Thu, 04 Jan 2024 13:39:14 -0800 (PST)
Received: from morpheus.home.roving-it.com.com (2.1.9.e.d.3.3.1.6.1.e.d.5.3.a.e.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:ea35:de16:133d:e912])
        by smtp.googlemail.com with ESMTPSA id m1-20020a05600c4f4100b0040d5b849f38sm6967460wmq.0.2024.01.04.13.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 13:39:13 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Joseph <tjoseph@cadence.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2] PCI: cadence: Make TI J721E depend on ARCH_K3
Date: Thu,  4 Jan 2024 21:39:06 +0000
Message-ID: <20240104213910.1426843-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The J721E PCIe is hardware specific to TI SoC parts so add a dependency
on that so it's available for those SoC parts and for compile testing but
not necessarily everyone who enables the Cadence PCIe controller.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v2:
Update subject, extend lines to 75 chars, fix spelling.

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


