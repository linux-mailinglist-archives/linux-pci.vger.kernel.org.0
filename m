Return-Path: <linux-pci+bounces-6928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39F8B84EF
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE91C223D6
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCEC4B5AE;
	Wed,  1 May 2024 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA4XYqQa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494F48787;
	Wed,  1 May 2024 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537747; cv=none; b=tEpfOXXPQQVT6fgky+7zR8vB/yp167cvp+8AV8bA6hO8xPRLAMmK6EAYCoE2MZIi1ZHDnsolhAS7lHj4lSQ7ybCeyF7LYb8MmP1QGrHUpF3HQD1dgVKMn0ua+8YaMlyZho0mZCltUjJVK4ku7VdhHVuahflOdve/D/dtd+hSGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537747; c=relaxed/simple;
	bh=2cKONyUhvqsDbdbaoKbjY2AvnOp4SE0Z8KCFA6jaKJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkenGLp5HVzi8Rkgj+1Uz5vr1ugUJC0SSzc69jaJQB0PTFmMKkpZ4UXogA1gu8ClHUi8wc3Aopc6lja7cLcPhzLuDn3q29sxBFsImFcYtqitoAxKnLNn7ZXbYv6yZTJw2SmzgfngJsOqyvBMQyfRAH/nALuvewolPpx6geg8bF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NA4XYqQa; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ee266e2999so1792267a34.2;
        Tue, 30 Apr 2024 21:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537745; x=1715142545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI71NoupknAET1jl5DuELYiP8ivpPOCBg6fYut4RUIg=;
        b=NA4XYqQaDYjO6Ivgul7Hu1RPUQjVyfbkVDv46xo2tnww+3x/haSyRyPnhy1IjQ0inX
         bkrex8JCx7erdqBJ/SAi8jdnALKC5xKv9YhSb0M+jqnS/5h+9J37np5F7cFCxl4odBIK
         zjvAZRA+mbJW0lDzey80YmVI5/y2kqqfRbd9fdRhRO6sEmc8T217OcoWfUMF+6XPZy90
         FcrG/5JLN2QyYc2q3oy+n18b61/QRd8tNwRI61MEnZ9ygnWT7BWXW9APGUai45XRjne3
         FULVaGj5k7TQ4Tc8YlmFNMHsKC0EpBCSYqSORwviJ2eJa++ZCgbNmGsfY4s9QAuv9GoK
         82ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537745; x=1715142545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI71NoupknAET1jl5DuELYiP8ivpPOCBg6fYut4RUIg=;
        b=M9UkN3FHe2VvLyOzu8VTFlbvpZdzONBlzM4fHbKg45MDHTbcJ9RtdBe8k3aQ8RzoqC
         B9SzUXTTQxAA/QXpTFcLRH+/aM0XrP7hSl83F0JBOqGq4o24VTDowA/YQ1BUhzJ9RvMC
         tsa2aNWDgBHyeXH02dveBG00a2iDpjVhT4aPQ6vlL2gq/GDxttJ02JezdCZX666VaoX8
         0rN6uaiaXMisI+addrHa1UMpx30csUWDoS8hmEhNDv4YxtO4G77xwWjg9WaE+9G2MZi2
         MpgcnR59zOPAv3fwuqBfksnhKHAVheEiaWysCkxpzkRtXt+3hIyEL/Qi4rcVN06GLB+T
         JDog==
X-Forwarded-Encrypted: i=1; AJvYcCWWooFbSRCWQoYFIHlof8E6FmH78AOyjBbx+kXPz5HTB+qGFYN+BsnGB6rymUATFD5EJ8tlKZnpx7w1JVguDDSEaQtBH0DjAko//RFWGGaytgFqKOW0wtetYwUVw1yn1XaMu25JrfrAvZVOzTHU0E6LUoAw64XOPkmcSnSYoHorL0SjsbGw3gV01kp3Rtta7TyempPLQo+WV/3/qAuhcReTH4zuZki/3eH3V5xpV8yZ/2drvG5eFC+SNtCooak=
X-Gm-Message-State: AOJu0YwHdlSR4UWHmOsKlIWg0tduLcd1JZXxVgTVQczNhVN6RLvKqLyl
	r8AYz7wp15XhPUhiMxP2KwnuDE2Gs7Auhx3Lui9fcVnh6wYYaviB
X-Google-Smtp-Source: AGHT+IEW5WaGUfL+JvzpQNeZs7pi6YqdiUbKAaXYvweRc4MKw+/bkLFotYWyiDTa1oMgCa3JbZcsBQ==
X-Received: by 2002:a05:6830:12da:b0:6eb:e1ba:6645 with SMTP id a26-20020a05683012da00b006ebe1ba6645mr1695409otq.3.1714537744803;
        Tue, 30 Apr 2024 21:29:04 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id do26-20020a0568300e1a00b006ed6dc9fd54sm2719058otb.25.2024.04.30.21.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:29:04 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v4 RESEND 5/8] PCI: qcom: Add support for IPQ9574
Date: Tue, 30 Apr 2024 23:28:44 -0500
Message-Id: <20240501042847.1545145-6-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPQ9574 has four PCIe controllers: two single-lane Gen3, and two
dual-lane Gen3. The controllers are identical from a software
perspective, with the differences appearing in the PHYs.

Add a compatible for the PCIe on IPQ9574.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ea81ff68d433..e61888e6c63d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1551,6 +1551,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
-- 
2.40.1


