Return-Path: <linux-pci+bounces-35526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1787B45659
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 13:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271925A3392
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 11:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31FE342C99;
	Fri,  5 Sep 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sve5TodF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D3342CA2;
	Fri,  5 Sep 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071667; cv=none; b=dAjIkez17ABExdItNcai7ttpTGgzqtAFHJym5SZVa3M3UtAgvVPzb7OOzSyznZNCYktTjvl7WxoXc2KzyUoa1oW8sropf+Vm8XLbbAtxaJ65aYCoJmIdDp//kQaf0c/LLJeEFMzDR4/FqIZ15eBvdiBodg5NVD7FKKqpnWnGLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071667; c=relaxed/simple;
	bh=J1a4RT+5dXN6HRhSrBG1mu+m8hweH6tEvr3mf/M7CsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqzCu0QoQ+D1mvlTPqm6XZsm2m7La82LrPPLICORUjBVTfcYIk4IaGNgsbELyKe+P6pJ3HWQEt+nyDCfRBsVAY554qNUuZD+utS7m+SzDtTLe7OidCTt2oBjKeRk7Dvsf3qaDDsSUaUNAa89cnrnhmQFWvEYmntgec3KxgBn390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sve5TodF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4fa6cd2377so1255694a12.2;
        Fri, 05 Sep 2025 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757071665; x=1757676465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BvNSdgfroz2AQh+V+YdAGx7lMSQySMqfI1R60lc+cXY=;
        b=Sve5TodFetSUF04gLCDAeasrh+YMed4/Ta1Ia7Q4bPY9ykVdEuDUVRBmhC11VUEj3S
         /nVc8YXcjqscy6CLzQsduCoOpeh4RhxKEHnNeQhANiyK8NuXqetNMpmugUGk0LJnJ1Ab
         eh/67vSQBYgekKJROlNwYVR4EVqRO5GlTsBP/dcE9Tf+uXN4ZJmoBhb86kXzvwpqOF5q
         5TT1b8WybCZEXlne0ikSDw4SJaaQpWD1PMB7sOleI0OHsAB5ZpIW/TtWTXffI0D/Ejnm
         kasE17haV/3akxzr+GlqoHIoewjbkG7r8hL2LcMyFHn3hfKX31m2F9X3jF7LKtD2bk0Q
         PbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757071665; x=1757676465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvNSdgfroz2AQh+V+YdAGx7lMSQySMqfI1R60lc+cXY=;
        b=Vbg6Jg1b3bxhan0vkORDJQXYV632N8rUb6VT0Y6tnsk3jI9bNJbKqEcTSf+nHstkab
         paLRARSWJNoKlQfDgTh8MG3PV17HAwVhBmWTia2jRFzSQjHCmpOk4Ea6m2O77JR3pHyc
         0/K7v9adIuNCgZNmH3CMul/r2wnJQMlPNo4AMyoYePn+2O93CxE2k0wEK4ofc22Z2BuR
         +TyYvEfn8RiidOlF2o9g4k7HZT43dk4PSdOe8mV27MhDmDerG37eJWoPU2XkHWyEOGp2
         Zjs4xj+9rtDWAuRU39pj3sKpU9p0yziDtFt3euiCTfq0Ck1PoFzebPdBWBDSla9Sqxt3
         lAtg==
X-Forwarded-Encrypted: i=1; AJvYcCXRtFmx5JJubfd4nt0xDC17i/UnsiLdS8jMHHRnnkrRjKbixCRWPRVZLLBM5xaDS8YJ8AL0UDaf0GrO@vger.kernel.org, AJvYcCXmqC6P7ru0S08R7zoZmDLazPdY/hnuOz+MXpmms+d2AvuTi/rljU4AXwAhgBySJJB9QD87hY1rTjR5YPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJRhL3Ya7u/tx+K5PZkvT5mGJVy0H0+8JkA+f27LtNj8KN30e
	olQdFf0gKzjdx9rvthK+RqwSv7m7SmRnFJE58rbwQ+z+M3IAaTZofDk3
X-Gm-Gg: ASbGnctiKpQoUZIHox8CDYn3OFV5+YoVd45jXvD/EGUszcHd1vpXvfVoQFBv/VPxADr
	dCuOsb05q6BNEmuoUCLKohrhiJdGpeBmTR+MJJVc20gBaYZr3IIuubitS+WSiKSJ3k6B4jZfOtQ
	LfNk1e/Fs+KxMELskqI3TdBoYMn/MonYIgItWfFsbO+rnieip55QlhN8YU7XzsxI1qw2r/pWL5o
	ctuBPFLGufaB/UMZy6HeS5N9b4VYx4lJeS234GfSNx0DyMxodwf6fX7ouZn7Y/hrczd5WQaK+iW
	c3HRQBU0uZP/c1ng8wQYUPr5Ntpv2p3yj2nzH6yUWqzQIZZOSnU9EOZvqNv4IZzy4kZWWKS00tC
	ZPq6C8r38/2j38x/ghjewfWizhRMzY90=
X-Google-Smtp-Source: AGHT+IGvR4zQ0L9DATfW6OC24buFgtcy9qBxyqE0QsalCQFZz8jZdjfaS+y+TmQZ4bZufc0KdMQo+g==
X-Received: by 2002:a17:90b:3e44:b0:32b:bc1c:8d65 with SMTP id 98e67ed59e1d1-32bbc1c8e51mr3401055a91.30.1757071665181;
        Fri, 05 Sep 2025 04:27:45 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e6d6d4b2sm10390179a91.0.2025.09.05.04.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:27:44 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
Date: Fri,  5 Sep 2025 16:57:25 +0530
Message-ID: <20250905112736.6401-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual get/enable logic with devm_regulator_get_enable_optional()
to reduce boilerplate and improve error handling. This devm helper ensures
the regulator is enabled during probe and automatically disabled on driver
removal. Dropping the vpcie3v3 struct member eliminates redundant state
tracking, resulting in cleaner and more maintainable code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 +++++--------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index b5f5eee5a50e..56baca52c3e9 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -76,7 +76,6 @@ struct rockchip_pcie {
 	unsigned int clk_cnt;
 	struct reset_control *rst;
 	struct gpio_desc *rst_gpio;
-	struct regulator *vpcie3v3;
 	struct irq_domain *irq_domain;
 	const struct rockchip_pcie_of_data *data;
 };
@@ -644,22 +643,15 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	/* DON'T MOVE ME: must be enable before PHY init */
-	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
-	if (IS_ERR(rockchip->vpcie3v3)) {
-		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
-					"failed to get vpcie3v3 regulator\n");
-		rockchip->vpcie3v3 = NULL;
-	} else {
-		ret = regulator_enable(rockchip->vpcie3v3);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to enable vpcie3v3 regulator\n");
-	}
+	ret = devm_regulator_get_enable_optional(dev, "vpcie3v3");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret,
+				     "failed to enable vpcie3v3 regulator\n");
 
 	ret = rockchip_pcie_phy_init(rockchip);
 	if (ret)
-		goto disable_regulator;
+		return dev_err_probe(dev, ret,
+				     "failed to initialize the phy\n");
 
 	ret = reset_control_deassert(rockchip->rst);
 	if (ret)
@@ -692,9 +684,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
-disable_regulator:
-	if (rockchip->vpcie3v3)
-		regulator_disable(rockchip->vpcie3v3);
 
 	return ret;
 }

base-commit: d69eb204c255c35abd9e8cb621484e8074c75eaa
-- 
2.50.1


