Return-Path: <linux-pci+bounces-33939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2EDB248E3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 13:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584C1626D56
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 11:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601722F83CA;
	Wed, 13 Aug 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="15NOOiAC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029B2F8BED;
	Wed, 13 Aug 2025 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086143; cv=none; b=NR525lawoTlUtHeelf2QCie7C/AqcrV/uAe2MzWQ1pnYH9BvXYhprsTLWrJVhodBRe2d5iVmugWBJV8E/13io/uPnq7jJ0CRzfVI0C1KITZJzLAjW3Hom6MCGO20KqARvPfJ3tQVLcvoRLVaGmvRBXirTylYNy4QiGpjXge0ss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086143; c=relaxed/simple;
	bh=gN1Bc0kZQonA2fSSUxvrABAaMJdLWsTnw+YGHmRaGuY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rXk2TmKKn9nxoARciQkQfxlRJLiDCQEzZUy76bzlqL0x1YAmVGS6lx1YaKdk9z6p5ecXxJW2No7QsQOTWYYayeG2D6iDiwrlw9h1kRtYYLX66JbZNPZnuOAZtzHdYeW8Yp5ualqzKCnfDW4hTv/1ljA++xYhZ4DMsJ9Y8+Mqge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=15NOOiAC; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBn5Bn008281;
	Wed, 13 Aug 2025 13:55:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=PFZKPQG+k1gfjsY3a1ZAOk
	Yj+KM4A3F6NxUPB1WMPvo=; b=15NOOiACV8P2LRL/T3X7nWZjJ2DyJJTPufMbmy
	0tVJpCRAlu0UdNJV1KWcgrIuxrzGI6HfioEEaReCJkrNEjkCyjiHPECc2r++KA1f
	SU514XoFEogWxO9wmVEa8zAlEqrKImNsr3aYFJI4YEzC877HS4G1szBlj4X7ZiZo
	NcBpjxyo9U86COA4KQEIwnNAwiwxhycVmn9pY9VgLlveBz1/eP1wd+yCS3zdx9oJ
	ySJv3LqK9CoUs1UOC9Jbrnk+F9ArQ+hsR7BbO2L/24nGzHVA5VGFw9NFhO1KaxVr
	4IwgjNz2Jm4qVL70aZGStpHmdd0Z1ehOxXhCoLd6Wm9JbN8g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48duf8xsg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 13:55:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C20314002D;
	Wed, 13 Aug 2025 13:54:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A72073FE23;
	Wed, 13 Aug 2025 13:53:32 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 13:53:31 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <linus.walleij@linaro.org>
CC: <linux-pci@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH v1] PCI: stm32: use pinctrl_pm_select_init_state() in stm32_pcie_resume_noirq()
Date: Wed, 13 Aug 2025 13:53:19 +0200
Message-ID: <20250813115319.212721-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01

Replace direct access to dev->pins->init_state with the new helper
pinctrl_pm_select_init_state() to select the init pinctrl state.
This fixes build issues when CONFIG_PINCTRL is not defined.

Depends-on: <20250813081139.93201-3-christian.bruel@foss.st.com>
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506260920.bmQ9hQ9s-lkp@intel.com/
Fixes: 633f42f48af5 ("PCI: stm32: Add PCIe host support for STM32MP25")
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
Changes in v1:
 - pinctrl_pm_select_init_state() return 0 if the state is not defined.
   No need to test as pinctrl_pm_select_default_state() is called.
---
 drivers/pci/controller/dwc/pcie-stm32.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
index 50fae5f5ced2..8501b9ed0633 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.c
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -90,14 +90,10 @@ static int stm32_pcie_resume_noirq(struct device *dev)
 
 	/*
 	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
-	 * thus if no device is present, must force it low with an init pinmux
-	 * to be able to access the DBI registers.
+	 * thus if no device is present, must deassert it with a GPIO from
+	 * pinctrl pinmux before accessing the DBI registers.
 	 */
-	if (!IS_ERR(dev->pins->init_state))
-		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
-	else
-		ret = pinctrl_pm_select_default_state(dev);
-
+	ret = pinctrl_pm_select_init_state(dev);
 	if (ret) {
 		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
 		return ret;
-- 
2.34.1


