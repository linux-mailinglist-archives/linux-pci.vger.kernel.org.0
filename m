Return-Path: <linux-pci+bounces-3638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B233858718
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 21:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1FD28924A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837E1509B7;
	Fri, 16 Feb 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dh/RVxIT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7014F9CB
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115611; cv=none; b=fjrX4Jnyw2M/XN+EzDNeUyCc7Mge9XyBH6JKspYLg3pBbKvW4w7yGzpMpYCqMUFm6XZNxDiJlBifkzUCMTMSWkSYFLOGk79j/55b5cKy4zDG34lJWzR06U0SvpifK742k00mEQvEjtZNa9iMcbI6ATwPiX1RCKqBbg7NbC5X/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115611; c=relaxed/simple;
	bh=1MzVv0nSisKV/T8y8z+7k5GcP430Ri3hmser4aGxhTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KItovPraEyr9eVs8dJRFS+OkYWTGV32d83U+1ZE1m2kXYg1hVBhpQy+DNqy3F2OKn5P1ylAETd+5Td4eUureiBMrKcXFPwF44OyYgp/GT41ML317/c69RsrhQvMEJ63dDWNku2Y8boGMcL7KWhuJ40Li8BuMJBM4BeMtdkaftEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dh/RVxIT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d208d0b282so29024321fa.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115607; x=1708720407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eErBIOjTQ5lnZfiQvyC9U9P7RJRdhki8x/CaBEW0suw=;
        b=dh/RVxITCtXQhFAY6jllUpH6ijZmzSl3oVgfciKAwSldS0aKth9QMGwJOlCO4EfBQ2
         WRDOESAwQsPgDwqk5uyyMJiclBn+cnAR9x7eOPzEZjIi5ojzpGoVM6ac18dW2K+pNdDv
         WmWv23ry3sVEaBIsaZ7CHDxdvi+lI3Dl5Md35UOVXjDtYzoSVn/JEVGexjNforZG20d/
         KKIsMec5L9Ua1UE115q6masiZyyaAqT3eQXZaz0Uj7MAcvM1hyrieLFRN6t2yScFTiwQ
         pBzOa5n3sRpP/HtksgKDyUM71kZjtjL4a4HNUYZRAHRYdzCemSftVAbwYLdk2BdWm5dy
         ZGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115607; x=1708720407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eErBIOjTQ5lnZfiQvyC9U9P7RJRdhki8x/CaBEW0suw=;
        b=MYcba5tnurniI9/eWtDFWptw+ZY5+k0RfuX+Lfz0k+Bfx7Ch73TCJWJhD1h/LaKbFI
         98e+IcyxOYlaT6TW2HLvCcY3hVoNGtA2011SnAX26FK4JlQ5W6q3Bz2QOcP/HI/f+ARW
         1gvjKobQtRIOdvuidE1ESAREG1d76YgEyDZ+uu8HuKNsZTL084Etc45w9hDUiAfv7PyE
         5zw+bDl3V5m5INS5HNqetZpZE+o9RPufjPofSiRH5Ao/CBfYQhhphLU6hlGc/dm3BGe8
         HhMUsaDKyo9JQaAz09g//2TrpiXpZ/EeqBNAKSLbVgK6Oyc9CqbxDUaJRphhx68VUIlH
         aO2A==
X-Forwarded-Encrypted: i=1; AJvYcCVMG3R8oXUXyrLQUuW/W42z/ihAEGeYngll7FU28pnPmsqjf48DK6l76Uluyt+wPi8r4vyb6fKbc9tFrzXGFnZyx88tdDorpA4s
X-Gm-Message-State: AOJu0YxMtOebu1/qXsh2XHNj8W9lmwA9eAAji8CKsE5MYDkQecUt0W7G
	g7Hefu7twH2DZ2Td6n7J9BiSEI+mTBzZtNFj91gClSWmMP1AzMDV+XODozC7NaI=
X-Google-Smtp-Source: AGHT+IEGi5tv9AIVQSVPvOrOZQQ9v1N9yVfrGqntVvYxcBnIqc7VX5XHcJUa0nQEF7j51CNJg9AgoQ==
X-Received: by 2002:a05:651c:10c7:b0:2d2:1107:3a7 with SMTP id l7-20020a05651c10c700b002d2110703a7mr3197736ljn.8.1708115607005;
        Fri, 16 Feb 2024 12:33:27 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:26 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 10/18] PCI: hold the rescan mutex when scanning for the first time
Date: Fri, 16 Feb 2024 21:32:07 +0100
Message-Id: <20240216203215.40870-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With the introduction of PCI device power control drivers that will be
able to trigger the port rescan when probing, we need to hold the rescan
mutex during the initial pci_host_probe() too or the two could get in
each other's way.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 467c16358f17..f8ba073ffc9b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3066,7 +3066,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	struct pci_bus *bus, *child;
 	int ret;
 
+	pci_lock_rescan_remove();
 	ret = pci_scan_root_bus_bridge(bridge);
+	pci_unlock_rescan_remove();
 	if (ret < 0) {
 		dev_err(bridge->dev.parent, "Scanning root bridge failed");
 		return ret;
-- 
2.40.1


