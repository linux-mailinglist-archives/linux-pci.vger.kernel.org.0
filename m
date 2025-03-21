Return-Path: <linux-pci+bounces-24377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D788A6C036
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF4A3BACDF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22922DFBF;
	Fri, 21 Mar 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cgqH6cRH"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF63B22DFA1;
	Fri, 21 Mar 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575125; cv=none; b=lBJOSxQG7uFF0sWMkQob4jETJZBV/983NXKAXwOgY+eYN3151GPD7Ob4ChHCL5HMfMr3NB9BIfIqlNgnuvEAvzFzmxhClUV/5vTmbfva5THPhdbew1nkp+t6DTVQcxsHiqKvGXUVY/64r1QU31R8nTW9Z6o1Uoq4OvbWOTSUUWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575125; c=relaxed/simple;
	bh=YKtEr9wF3Q9oj+jVbKYrVT+BIWYZzl5DDzbLu+pO4Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n0FIoXmomCaJnSXN02xpDSS/x4jzz/BTn6iGhg4UjBpV5Us4ueGX/HGwmRC471lWrbp+bho0hGJ1ykPUVihNjzAMGSxT98oUtDS59or80jFiTvLjTeyTWar4mQuEFkK5oSqSM5EwtZ1Z3pl3oRVk/8lXfn6wl1Y5Ao3E+fHyEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cgqH6cRH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yh4Jx
	v4hhAHkYmuK74y/G1BO0VulqF5y3DNr9kAR0lE=; b=cgqH6cRH3yQ25K+r0760a
	Qv3sizcOBKDkPjWtZjZUmVz7Zxvz0ax8ET2572Ooi46Pnf5mZ7eFUonaAUvcKdbD
	J65ZgREB0fHcjCvjASM3r6lFpHaIsRa2z0qn4OxQHgjzvJpnnldrJkAWROXnjEgy
	VGozd0JcLRshTvAQqa+FYA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC30e7sld1nnmPrAw--.48109S2;
	Sat, 22 Mar 2025 00:38:04 +0800 (CST)
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
Subject: [v5 0/4] Introduce generic capability search functions
Date: Sat, 22 Mar 2025 00:37:59 +0800
Message-Id: <20250321163803.391056-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC30e7sld1nnmPrAw--.48109S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFyfGw4rtrykCw15uF1xZrb_yoW8Jr1UpF
	yrG3Z3Ar4rAFWa9an3Aa1F9Fy3X3Z7J3y7J3y7Kw1fXF1xAayDKr4kKF1rArZrX397X3sx
	XF4UJr95KF1qyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEGYLPUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhsXo2fdjwDO-AABsT

1. Introduce generic capability search functions.
2. dwc/cdns use common PCI host bridge APIs for finding the capabilities.
3. Use cdns_pcie_find_*capability to avoid hardcode.

Changes since v4:
- Resolved [v4 1/4] compilation warning.
- The patch subject and commit message were modified.

Changes since v3:
- Resolved [v3 1/4] compilation error.
- Other patches are not modified.

Changes since v2:
- Add and split into a series of patches.

Hans Zhang (4):
  PCI: Introduce generic capability search functions
  PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
  PCI: cadence: Use common PCI host bridge APIs for finding the
    capabilities
  PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode.

 .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++----
 drivers/pci/controller/cadence/pcie-cadence.c | 25 ++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  8 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 71 ++-------------
 drivers/pci/pci.c                             | 86 +++++++++++++++++++
 include/linux/pci.h                           | 16 +++-
 6 files changed, 157 insertions(+), 89 deletions(-)


base-commit: a1cffe8cc8aef85f1b07c4464f0998b9785b795a
-- 
2.25.1


