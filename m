Return-Path: <linux-pci+bounces-32353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2338EB084FF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 08:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C443A480B6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323072153D2;
	Thu, 17 Jul 2025 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zwpw7zys"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8479C0;
	Thu, 17 Jul 2025 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734022; cv=none; b=DN9br/G/2Ongmve2VnjgN4h1cwHsdRZ++GzNPvSaDh3nTocMJNhHBUk57PrXUDSZRMleQUdrVDq+n4wPLameIlXIQ0iLFHAIFM/bJH3c30VmaB7I0vEFfXujtUZV7HKRns7b6K11466R4C/Sxf+nhEr0BxBQe1XZ7jJ3MFvf7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734022; c=relaxed/simple;
	bh=GOIe9sjlet2UCg9ci5sw6sqnb0MVMHIplEF/bD68i08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ABoheojw+poOzcsELiWkhNkb/raF9gdl749MdOVnvMGf1nQUBg2Z9PtTT6os3HkEclNZbF/MHdYhxIgqzM7VDlFP3sbsHSs5taMgOfLFumol/+mQ6/zqZqdOk/A4vK6OVRgr4RvGGOFNRoYu9HmMWCSr2QNpy5PoEemZke3MWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zwpw7zys; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H3JZgc002491;
	Thu, 17 Jul 2025 08:33:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=9+83B+YVA2IQexnB34FIHC
	dUO9DtPuBnRUPeGm8YfyI=; b=zwpw7zysfZNtRoySikCC+q234YX5RB8Bc8BzOF
	cDtWT+fQfA6T7aEMcOYsHie0mGFDvC0iM1PnRYzbDJz8VmPFGg/EiKdo8e/mp2bZ
	cHvBfFD3aDp/3cZYcs92yl/WIA/jPd7Y2xHOTAJlk7s6ruhI7djq2pszUgTkxJY0
	HbGVr9pHp5ACw82ZsuUgbNQZGE/B+bdndLLupIUGgMBisYqFn9DXvWjPoh90kn5L
	2gbaODDtV+2B7JYH/xvuUt9KlbWmwngjhpBg/tJRo6uYRHSIWeYaK4JgAVa7jE3u
	Wi/lgjE8r6ZI/vVh8CdCGqiPlQpi/YCHGvpFdKOcJ03c6sGw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47v2np3eca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 08:33:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A6D564004C;
	Thu, 17 Jul 2025 08:32:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DC0C978C56E;
	Thu, 17 Jul 2025 08:31:10 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 08:31:10 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <linus.walleij@linaro.org>
CC: <linux-pci@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [RESEND PATCH 0/2] Add pinctrl_pm_select_init_state helper function
Date: Thu, 17 Jul 2025 08:30:40 +0200
Message-ID: <20250717063042.2236524-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
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
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01

We have the helper functions pinctrl_pm_select_default_state and
pinctrl_pm_select_sleep_state.
This patch adds the missing pinctrl_pm_select_init_state function.

The STM32MP2 needs to set the pinctrl to an initial state during
pm_resume, just like in probe. To achieve this, the function
pinctrl_pm_select_init_state is added.

This allows a driver to balance pinctrl_pm_select_sleep_state()
with pinctrl_pm_select_default_state() and
pinctrl_pm_select_init_state() in pm_runtime_suspend and pm_runtime_resume.

Christian Bruel (2):
  pinctrl: Add pinctrl_pm_select_init_state helper function
  PCI: stm32: use pinctrl_pm_select_init_state() in
    stm32_pcie_resume_noirq()

 drivers/pci/controller/dwc/pcie-stm32.c | 10 +++++++---
 drivers/pinctrl/core.c                  | 13 +++++++++++++
 include/linux/pinctrl/consumer.h        | 10 ++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)


base-commit: 5a972a01e24b278f7302a834c6eaee5bdac12843
-- 
2.34.1


