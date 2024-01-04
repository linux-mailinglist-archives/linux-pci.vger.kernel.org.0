Return-Path: <linux-pci+bounces-1668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62061824243
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 14:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D9D287A0C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A122EE1;
	Thu,  4 Jan 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zESwugOz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761722EEF
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so374139f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 05:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704373327; x=1704978127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm8mMOJsxux6ZmWUG3F7cuu+H2vgOte3WZWDy9og3kI=;
        b=zESwugOzZQWroLH3AzdFt7/hlzlCWNPWAY42tOmmQ1m+tQ1HgQT13NHkIGN54DaX3O
         w1aYnbe//4y09pGoNAkqCGL45RrOrRJQBEkvTkizscaQkkbH7nJA/HXjqdYkssHhCUzG
         aWLRnX93EEBj8JC2RHltW+mnbFvDKrfA8TSLxDjpo0xofw0MTHAsJsnEG1T0PSl90ZHY
         uX35iKTLEbTNFcMkes0gJ7taDIqUR06yYePDmN1YjJO6/0nlWcxgt5iIHWNAXfwXePJX
         n3mTT8jWJkaCoGeZ2n2uE2FQ85t68XGguhZCYoSMf0glh68o34oOtdEF21pVeDD2+Dyv
         iRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373327; x=1704978127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dm8mMOJsxux6ZmWUG3F7cuu+H2vgOte3WZWDy9og3kI=;
        b=aTxU1FoXoO5xaRGk/yrgLhpzkKG+NR1SsXZZvqWROUj0xNmbGyi3xyh0YIlE59hPlL
         puKrfZLnvwAWDeyQ0CvRbUvLamCuHrhFFKV+xRe2WZBFaGCVT9wv6HBnA8W/u8lP01Tb
         vYHzSH+mm9zSs80BLwE6tLnzDGoaSGCBpUQx2LokQTa/icMr/IVsf9ZcyCwtavC3OKjI
         Cb9eL2DBQtNjW3eFt+FCAWo6P/gFqLWh0tsjN+8PDRHvbdgSQ1jOF6ogWFJNEnl6YmQW
         hUoGX6t6Y9nyu/NJrsKFjm7VjEM30E1HM/LJOhlJq1p5ARD+mIao9af/DtK51aZMzAT0
         2mJg==
X-Gm-Message-State: AOJu0Ywt4e6jh59etlN4ThTn0IxZHHgm4bcBvn4iiNceFCHBbCZBFnK6
	WYrcCqAnJARWn4vff4fVy9ctMVWrh6fEVw==
X-Google-Smtp-Source: AGHT+IEAmqT1dLhz8yMZPRNlwfwkfnr08tFlrQ2qx2EHGz1pEWzlFjlA+PDg16ga3IpH7ARH2S4IxQ==
X-Received: by 2002:adf:b199:0:b0:337:175:a079 with SMTP id q25-20020adfb199000000b003370175a079mr327095wra.80.1704373327126;
        Thu, 04 Jan 2024 05:02:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm32887387wrv.116.2024.01.04.05.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:02:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
Date: Thu,  4 Jan 2024 14:01:17 +0100
Message-Id: <20240104130123.37115-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>
References: <20240104130123.37115-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to introduce PCIe power-sequencing, we need to create platform
devices for child nodes of the port driver node. They will get matched
against the pwrseq drivers (if one exists) and then the actuak PCIe
device will reuse the node once it's detected on the bus.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pcie/portdrv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..401fb731009d 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/of_platform.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/string.h>
@@ -715,7 +716,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		pm_runtime_allow(&dev->dev);
 	}
 
-	return 0;
+	return devm_of_platform_populate(&dev->dev);
 }
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
-- 
2.40.1


