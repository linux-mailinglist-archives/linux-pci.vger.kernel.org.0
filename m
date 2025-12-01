Return-Path: <linux-pci+bounces-42366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4337DC978C1
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 14:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EE33A9977
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 13:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51BF30FC39;
	Mon,  1 Dec 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LmEAuJIA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E592F2603;
	Mon,  1 Dec 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594599; cv=none; b=F2s1h4dGpFLD+FCSQLqelVJaTgOezOvtqu/xNwm8o3AYmoSLZW/kDtlvhqyrvIsuMFqfNY8H9y8YsZthSr76kcPRhSyaQqgZHIk/+Y/YKo/85IPWlTgUSr5821aHtrufJxE1KIR8ltUdcMhVYGeYOEM/P9nZmiN3CD/TXZDrz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594599; c=relaxed/simple;
	bh=zg2mBZ9w8LQ344DKjJnn30Gx+/5hAbRUGgtojX6y6sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljgVl1f9R8dQqt49xYZBWcLQ6Rw00G6m0URko2Lg09kSs2XSmLWvCc81HYRlchizVL6kKRcVFwjZrxw3lFvqKO44orfS11zoY7LALFRcLx8mOYLxu9HcdXQ6lmHF7yEfKRMf+AQYIDS7SqGWddswZIoZAHnjaNsSLYIAHMH5iNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LmEAuJIA; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=zg2mBZ9w8LQ344DKjJnn30Gx+/5hAbRUGgtojX6y6sg=;
	b=LmEAuJIAIde6QXYHQ81OHgJz/63qNbztwo7RKc9HSU2kL+6HQUmsIwmwTzY61b
	24JKl6HgbWpx+FHYgqa1uOXnjRjezS2c/iu7CqODxB3RUNKIQPe7mFVaHkM4W2OW
	RCQMMEfJL2NStEMEqXO59/rG6HG9VW+iDV9WWWRP4ck+A=
Received: from emily-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHrZAvky1pnbQPDw--.3674S2;
	Mon, 01 Dec 2025 21:08:01 +0800 (CST)
From: huyuye <huyuye812@163.com>
To: sunilvl@ventanamicro.com
Cc: ajones@ventanamicro.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atishp@rivosinc.com,
	bhelgaas@google.com,
	catalin.marinas@arm.com,
	conor.dooley@microchip.com,
	dfustini@tenstorrent.com,
	haibo1.xu@intel.com,
	lenb@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	rafael@kernel.org,
	robert.moore@intel.com,
	samuel.holland@sifive.com,
	tglx@linutronix.de,
	will@kernel.org,
	dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn,
	guo.chang2@zte.com.cn,
	liu.qingtao2@zte.com.cn,
	wu.jiabao@zte.com.cn,
	lin.yongchun@zte.com.cn,
	hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn,
	huyuye <huyuye812@163.com>
Subject: Re:[PATCH v7 08/17] ACPI: pci_link: Clear the dependencies after probe
Date: Mon,  1 Dec 2025 21:07:55 +0800
Message-ID: <20251201130757.7032-1-huyuye812@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729142241.733357-9-sunilvl@ventanamicro.com>
References: <20240729142241.733357-9-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHrZAvky1pnbQPDw--.3674S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUZF13Kw4xAry7Cw48WFg_yoWxZFbEgr
	n5AFyDZw4ftw17Gry3WF97JFW3K3y29r9xGa4xXrZ7Gw4fAa1DCan7Cr12vr15GF4xGr4a
	kr15uw47GwsI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjVOptUUUUU==
X-CM-SenderInfo: 5kx135bhyrjqqrwthudrp/xtbBzwgXCGktkDVHogAAsc

Hi, sunilvl

Based on the above patch, I understand that you previously resolved dependencies between Link devices and PCI Host Bridges by calling acpi_dev_clear_dependencies(device). I would like to ask: on RISC‑V platforms, if we need to manage dependencies between multiple PCI Host Bridges, could this be addressed by adding a call to acpi_dev_clear_dependencies(device) at the end of the acpi_pci_root_add enumeration function?

Initialization order dependencies can be defined via the ACPI _DEP method in the DSDT. For example, if host bridge B depends on host bridge A, bridge B should not be enumerated until bridge A is fully initialized.

Best regards,
Yuye


