Return-Path: <linux-pci+bounces-27289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4565AACC48
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2420F3BF77D
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB526FA5F;
	Tue,  6 May 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oj27vMXl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C8207E03;
	Tue,  6 May 2025 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552947; cv=none; b=k7FfnUBnZheBGyzAXeFafLdEax9NFgbYBVmlfsfDbrBd/6odqWqggr6uGwLCrDgR97gLkutAUHxxVAnyrrMuseQSHv4J856yoBJhBeRMT6iursvj+WhxjY6+0RyYO42N3pvbLUNnQsHi18Mc5CxpYI+oboBIdcmZ9SQcseKQFNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552947; c=relaxed/simple;
	bh=6dCb2gzrseaVkzCTxqVoMcuyJE/6Bfgbf03X5MRhkFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=om1b5JOQF3F0WhF0eRKWYwQqxC6zCvTihcsyAPXQMB4jSohMQSG4gzrxFkN+Px+1AAQeE4q6q3L+nboFP2rxb/rtoiA0Ig5MMZdyFhCQhvS+v0grTqCuFEj2rRQSbtb0IrRe+OqEe/g3sKxAT9Dtyd7f2Aa3bFQRK1pD5nTA5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oj27vMXl; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZmNA4
	c+Oojm6jH43yAx2JRj1VUwsumuexFyexRksMZ4=; b=oj27vMXlyT9pECI6x5V31
	AKjSaNUSrju8+cNTVQbDMN+Qyu/8bVhpETmylPLoWEQptAOYOf5kMqKKIqxR94E+
	WlKKd2ptt51BxanXvH9m/TBX5pm3oidaq/N4TmxYAYOgLehmXJgLsQ6Dma5iqD6e
	eYpEf2f+1eSkZFdGa02kgM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAX_U4ySBpoVmZeEw--.15363S2;
	Wed, 07 May 2025 01:34:43 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	manivannan.sadhasivam@linaro.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 0/3] Configure root port MPS during host probing
Date: Wed,  7 May 2025 01:34:36 +0800
Message-Id: <20250506173439.292460-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX_U4ySBpoVmZeEw--.15363S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1fZw43GryUtrWfJryxXwb_yoWfCFb_uF
	WfuFWDJw47JFyvyFyFgF4Iyry5Zan3uryjq3WvqFWYyF9xXr13Xws3WFW2gF1UWFWSyFsx
	Cr1kZr4rAr1xZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMeOJUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOghFo2gaREltXgAAsY

1. PCI: Configure root port MPS during host probing
2. PCI: dwc: Remove redundant MPS configuration
3. PCI: aardvark: Remove redundant MPS configuration

---
Changes for v3:
- The new split is patch 2/3 and 3/3.
- Modify the patch 1/3 according to Niklas' suggestion.

Changes for v2:
- According to the Maintainer's suggestion, limit the setting of MPS
  changes to platforms with controller drivers.
- Delete the MPS code set by the SOC manufacturer.
---

Hans Zhang (3):
  PCI: Configure root port MPS during host probing
  PCI: dwc: Remove redundant MPS configuration
  PCI: aardvark: Remove redundant MPS configuration

 drivers/pci/controller/dwc/pci-meson.c | 17 -------
 drivers/pci/controller/pci-aardvark.c  |  2 -
 drivers/pci/probe.c                    | 66 ++++++++++++++------------
 3 files changed, 35 insertions(+), 50 deletions(-)


base-commit: 01f95500a162fca88cefab9ed64ceded5afabc12
-- 
2.25.1


