Return-Path: <linux-pci+bounces-30813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7938AEA535
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1C216E60B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7C22EE60F;
	Thu, 26 Jun 2025 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UfkC2P/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED62EE606;
	Thu, 26 Jun 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961979; cv=none; b=c4f9oQotC8v5TAig+c25IFFu1w3UxKC4uA7C0+qNY/14pfaXmqxeKCIigW48+jKsE4dNhF0n3Zyd0IM4UKbr/RRUyWrj7BPaObtHsXZyf9G+sKeiBXIN3Yvvl/FSYRFutBwhGvI0WLXB7JxwIuGMC9O6T5Tp0r8P7a7wv+UPI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961979; c=relaxed/simple;
	bh=QNkQXNj81suZNdgejPQ/g8TgMMxfckamBb6SyqSWugk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cUqx/0bly7mzloOuhm6UxjdXHPjx+w+8PWzrTx6Q9sgIMmRckZs2U+kmcNI9EOIXvNnJ08xPaN9pFMBS+ass5eU257z6K7GU4wuq7sdgPv3IAGSKjuxcGf0xGFVnU2SbYxkJRrIBCk+hrZNwFz1pxznG6y5bdnT3v66qAR7Jvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UfkC2P/I; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QG6Ak2025531;
	Thu, 26 Jun 2025 20:19:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=v4xN43MYu3e3S0oexgiTVn
	3iIbbwbmNw+3LdQPITQ9s=; b=UfkC2P/IykYF5tUIvNYKlakfc/jQsk7sbMry14
	CpFISpfAe/7UADp8LrZfoJo4JDLQF7Iwxw8VE0I8YZu78MPG9s9x5MNCffwVkJKV
	Opzevu9WwtdPeoGVtJkiglWOvYxwJ/diU22cSbgLyyxhorRIbA6UdduPqjlw1qA6
	BLHpPVwotIrJaGfWrw6px1xeAxLYC3ozWYZEy8kTQhrTPWbAqEFWSUR1JfCqHZ54
	6q2bbYW8FkSv4oEM9crQzD9Ta85vltZjcRsGzwWlj72zVLi+IIfGwIIlBVsJSrhk
	3CA3VsmVWsl2sovE0OUZVKJjiNufHxH3xa8yDzEDkQtDOWDg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dhvbysfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 20:19:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DF59540055;
	Thu, 26 Jun 2025 20:18:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2FC45BAE253;
	Thu, 26 Jun 2025 20:15:41 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 20:15:40 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <linus.walleij@linaro.org>
CC: <linux-pci@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH 0/2] Add pinctrl_pm_select_init_state helper function
Date: Thu, 26 Jun 2025 20:15:35 +0200
Message-ID: <20250626181537.1872159-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01

Some platforms need to set the pinctrl to an initial state during
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


