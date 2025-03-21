Return-Path: <linux-pci+bounces-24302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE66A6B395
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 05:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3821F19C4028
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 04:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFEE1E9B3C;
	Fri, 21 Mar 2025 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PWqTRunS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20641E9B16;
	Fri, 21 Mar 2025 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529903; cv=none; b=PEMAZmjZnd7E4NsULhEcFJ8kjUl5ComwzHL5IIt9GhjRuijcymoVYyFIlqbJ/gkhE9zSKdrXS+M3TlpWrIrgCZtErmFknjmXDHHkmMKNqhR08FSh2Dsp8zNcZjfuNn44ug3MfLlu76PEODNEcYnYxrIWlOUBeV/vSzkeyunnePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529903; c=relaxed/simple;
	bh=FEBaXSU6MEItzx0UFzX2V7JtPTXHPx7p4i0guY4Sx/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=roDuTC+rcXXH1yA/3U7wnC+JwrbgHknR96l5wXliRW3n2NJ8EJUWMGKsZDYiccIWJkg6qVDQcWd24JgPVHpoCl1aDi5GNkELV73f+1+KvcBO9hNitc2vR+nIjs2yPDnGwcc8K9x+45Hd/sRPlX6GPYKmMtMKACwYrF9wQtOy7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PWqTRunS; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tLTY0
	7DDgFf4nTrkH5HU5qGshr+vwCK0ikiqNVkWx08=; b=PWqTRunS8QfhShf2m5D9V
	DXJYKjkmepIRF0Kl2MPW7dQtkNwUOpG5ck3ZXDf/bVXfx3aFowIoT0B50vFkTRGl
	exEq68pmUHharU2LUFtwf8dUm8f00XsuvWXVtBXPzzmosPF+M2e3cRHspKZpDqZm
	v+WtOU3RS2bzAnxksP80uc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3Hxsw5dxnbYNpAw--.34788S2;
	Fri, 21 Mar 2025 12:04:02 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v3 0/4] Introduce generic capability search functions
Date: Fri, 21 Mar 2025 12:03:54 +0800
Message-Id: <20250321040358.360755-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Hxsw5dxnbYNpAw--.34788S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw43KFWfCrWfCw4kWF4fAFb_yoWkGrb_ZF
	W7ZFyxtFW7WF9IkayIkwnayFyrZ3y2gF1jgFyvqFW5AF1Ivw1kGw47XrWUZ3WxWF4DAFy5
	Xr1UZan5A3W2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRCxRhtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxUXo2fc39fRTgAAsW

1. Introduce generic capability search functions.
2. Replace dw_pcie_find_capability() and dw_pcie_find_ext_capability().
3. Add configuration space capability search API.
4. Use cdns_pcie_find_*capability to find capability offset instead of
hardcore.

Add and split into a series of patches.

Hans Zhang (4):
  PCI: Introduce generic capability search functions
  PCI: dwc: Replace dw_pcie_find_capability() and
    dw_pcie_find_ext_capability()
  PCI: cadence: Add configuration space capability search API
  PCI: cadence: Use cdns_pcie_find_*capability to find capability offset
    instead of hardcore

 .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++----
 drivers/pci/controller/cadence/pcie-cadence.c | 25 ++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  8 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 71 ++--------------
 drivers/pci/pci.c                             | 83 +++++++++++++++++++
 include/linux/pci.h                           | 13 ++-
 6 files changed, 151 insertions(+), 89 deletions(-)


base-commit: a1cffe8cc8aef85f1b07c4464f0998b9785b795a
-- 
2.25.1


