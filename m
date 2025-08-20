Return-Path: <linux-pci+bounces-34344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF77B2D558
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680B716EB45
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 07:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035B2D8DA4;
	Wed, 20 Aug 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SS7suCg6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2E2D6E6D;
	Wed, 20 Aug 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676702; cv=none; b=REZIo1vmfP2i9qWNu5bCpqa8XEeT7OfBj9Qm7xhDEqxG+hH5gT5tMjnR6tUEK6FLSB67TQJcR7N5/9V93zpDtpqe2FrlfotFFqyfXdMAovAPWZZp2KmhPGTRLqi/OKRRglGWZO/MUTZVqN9PXJ4UQRkvivlNflVObwVq5AVVfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676702; c=relaxed/simple;
	bh=kE2hUcnOyBsjubDOen4g/zLapLO9z14SFDKnLQpo7tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkYhSvm1VbWjLH1tIbD3Io21KLbYMfdANilNd+uwTrsWw8b9bLn0a4n9920xpaltUzFNY43/FdTfmPd3wWV+VpgKZdxpoNBqmqKLef49nLx4SGvzl9qq6d/x7W+QdSQXqQM09kL5MIA70pq0MHAn8F89hCGcLiF783tr3CX/Oyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SS7suCg6; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K7mDOJ000448;
	Wed, 20 Aug 2025 09:57:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	8txGAUy5q8aVXARAAwJvS4Nx8Zyxd/W6wnU4kX//qGE=; b=SS7suCg6QDMmDeZ3
	M/Dxaa5hU9bWnY7K5yFdrXiY5xaZ1GdGedhG81mZx4Y7IVjHjILPD44fDUQ/bIRy
	TWHjzQHbMejYycAy80ykvish8DX8yy+MDviqhxCvfR5C29bZrCgXghi0JLwr7riK
	MObCE2pJdAQdjKnoPbHBfkZZYcy7bDPlL/il75bkDxSkyY7IP1sdOMlN6+ZSz9UO
	o8lCHa/HKPLutGJr9W4jYQW5ZJHLo3T5oajRHzWWhVPUEuKMqwfvhCvBv4U9ibaL
	dL+jzWXGEWWZHkk6b6KyZydw8uKevY+BcqpKf0s5cvB5vLdId92L2NvlRXyW8T1j
	pXoqgQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n7548wyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:57:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DDB554004D;
	Wed, 20 Aug 2025 09:56:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E01C5E8108;
	Wed, 20 Aug 2025 09:54:49 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 09:54:48 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linus.walleij@linaro.org>, <corbet@lwn.net>, <p.zabel@pengutronix.de>,
        <shradha.t@samsung.com>, <mayank.rana@oss.qualcomm.com>,
        <namcao@linutronix.de>, <qiang.yu@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <inochiama@gmail.com>,
        <quic_schintav@quicinc.com>
CC: <johan+linaro@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v13 02/11] pinctrl: Add pinctrl_pm_select_init_state helper function
Date: Wed, 20 Aug 2025 09:54:02 +0200
Message-ID: <20250820075411.1178729-3-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820075411.1178729-1-christian.bruel@foss.st.com>
References: <20250820075411.1178729-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01

If a platform requires an initial pinctrl state during probing, this
helper function provides the client with access to the same initial
state.

eg:
 xxx_suspend_noirq
    ...
    pinctrl_pm_select_sleep_state

 xxx resume_noirq
    pinctrl_pm_select_init_state
    ...
    pinctrl_pm_select_default_state

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pinctrl/core.c           | 13 +++++++++++++
 include/linux/pinctrl/consumer.h | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 73b78d6eac67..c5dbf4e9db84 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1655,6 +1655,19 @@ int pinctrl_pm_select_default_state(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pinctrl_pm_select_default_state);
 
+/**
+ * pinctrl_pm_select_init_state() - select init pinctrl state for PM
+ * @dev: device to select init state for
+ */
+int pinctrl_pm_select_init_state(struct device *dev)
+{
+	if (!dev->pins)
+		return 0;
+
+	return pinctrl_select_bound_state(dev, dev->pins->init_state);
+}
+EXPORT_SYMBOL_GPL(pinctrl_pm_select_init_state);
+
 /**
  * pinctrl_pm_select_sleep_state() - select sleep pinctrl state for PM
  * @dev: device to select sleep state for
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 73de70362b98..63ce16191eb9 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -48,6 +48,7 @@ int pinctrl_select_default_state(struct device *dev);
 
 #ifdef CONFIG_PM
 int pinctrl_pm_select_default_state(struct device *dev);
+int pinctrl_pm_select_init_state(struct device *dev);
 int pinctrl_pm_select_sleep_state(struct device *dev);
 int pinctrl_pm_select_idle_state(struct device *dev);
 #else
@@ -55,6 +56,10 @@ static inline int pinctrl_pm_select_default_state(struct device *dev)
 {
 	return 0;
 }
+static inline int pinctrl_pm_select_init_state(struct device *dev)
+{
+	return 0;
+}
 static inline int pinctrl_pm_select_sleep_state(struct device *dev)
 {
 	return 0;
@@ -143,6 +148,11 @@ static inline int pinctrl_pm_select_default_state(struct device *dev)
 	return 0;
 }
 
+static inline int pinctrl_pm_select_init_state(struct device *dev)
+{
+	return 0;
+}
+
 static inline int pinctrl_pm_select_sleep_state(struct device *dev)
 {
 	return 0;
-- 
2.34.1


