Return-Path: <linux-pci+bounces-27877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2269AABA111
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73302A029AC
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82371DE2CE;
	Fri, 16 May 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gMbhFKJI"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0331C5D46;
	Fri, 16 May 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414393; cv=none; b=n1D4pZf2+226VkvNiaAhX7LkKO8smSPF9Dxe3idmr0vtkz/t/RgB9SJsmjWn/cL2Z2Wkf4AneQXO21wCNHyFv+CnQooFyY9HjT98gVz8/6pMqdzB4JI/B1fUkDqhGufpkqKK7aTZ8Vi1+MZJQPIa1zjmods0fGJbETVGGxOGj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414393; c=relaxed/simple;
	bh=e7r59I1570V/ZTAVNQn6tuVe/hq4uTnS4Xt8CyEI4D8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FoF6W1XJUE/WDDYdj9Gng1rhQiLKfAbQLipHyxdRNik/qyekr8ciYNI+2+v69aKAL6u/UVqIhKz7Lc8KfMAjioAjhUS4GR3Jp4rYTesqlDWPzWcky97ZvtsYZKaXsS9SK6VSNI/jsVHnOHcj7Y2rWVgyfrjZMh72gaR8+e15sBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gMbhFKJI; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zK
	fG+U01Noy/xyIUU1fu+yTBbwmBMuvCo8WgyfdyiDc=; b=gMbhFKJIKu4t8s7/p3
	eqajkqTxi554DWlCWATYq+kVV5RUkdC/681MyiNLS8opTY5mlvfmUzcVRQ2lJZI0
	wlIzI7sy+tOXKlu0xoR4Lm8xir2Ojo/avIKy5WE0BYXbMh6xDnbfXi0t1kroGiXa
	yB8DKgMt/jMKKR8/tFVGsuC+k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn1+RLbSdo12CoBw--.59952S2;
	Sat, 17 May 2025 00:52:28 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	mahesh@linux.ibm.com
Cc: oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/2] PCI: Convert MSI and AER state tracking variables to bool type
Date: Sat, 17 May 2025 00:52:21 +0800
Message-Id: <20250516165223.125083-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1+RLbSdo12CoBw--.59952S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWxAw17tw4rtFWrtryxXwb_yoWftrg_u3
	4kXrW7Kr4j9rsrAF1Fvr4fZryY93y0vF1kXw1Fvryayas7Zw1UXFWUXr95u3WfWFn3tFyY
	9wnrArnFyr1xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuzuWtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx1Po2gnaWRfNwAAsA

This patch series converts MSI/AER state tracking variables from int to
bool type to improve code clarity and align with kernel coding standards.

These variables inherently represent boolean states (enabled/disabled).
Existing code already treats them as truth values in condition checks.
Explicit bool type eliminates ambiguity between integer 1/0 and
true/false. Follows modern kernel practices for state tracking with proper
type semantics.

No functional changes - pure code cleanup to enhance readability and
maintainability.

Hans Zhang (2):
  PCI/MSI: Use bool for MSI enable state tracking
  PCI/AER: Use bool for AER disable state tracking

 drivers/pci/msi/api.c  | 2 +-
 drivers/pci/msi/msi.c  | 4 ++--
 drivers/pci/msi/msi.h  | 2 +-
 drivers/pci/pcie/aer.c | 4 ++--
 include/linux/pci.h    | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)


base-commit: fee3e843b309444f48157e2188efa6818bae85cf
-- 
2.25.1


