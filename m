Return-Path: <linux-pci+bounces-42371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A07DCC97CB7
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 15:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DC30341374
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41632318152;
	Mon,  1 Dec 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fLHGQTB2"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198F315789;
	Mon,  1 Dec 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598470; cv=none; b=Su0sIR7fVz8QSq/MvRSLAWzMF++MPkoA7sXhO1lzcMQbN7+RNiSCwYNurn+KtzKdUorZH9DkYnec5vvfzC9GCWsQ/GPyc+CEuNZ/kZVuPN8mXiK3ILclLDpkaRjXzvkREu7oPvUDlzeRayK49EcStmulnE2k/w4TLhB4HxdFcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598470; c=relaxed/simple;
	bh=4jcweNi6psPpjlZDmC6qZ/Q4mO7N38WsRkszImaw/p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugT5gVk4HEgalqNNYUGzwMViIAUTWtX+EwiyqrPnDXQhAgcOhQYt4J64EYPBH0pD76M1iA7h3g9U4DHLks8lpD/VIw2/V2o7RWaqdcp3eSup/jZZHIrgpRfc6OytjQ48ii4LA50hwxN/Y3R/MjI9wO5WlMq2zDpX2j3/q7o2gu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fLHGQTB2; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=4jcweNi6psPpjlZDmC6qZ/Q4mO7N38WsRkszImaw/p0=;
	b=fLHGQTB2wwpyAu5ym/trd8UA27IhVG8yhhJGQFFZO+C46/FSaJA398a3OGiE8y
	oFIgx/AYYq+CfIXUNiV56NthlUeuQ5u/Rzhktg0uOuS5P0rXaxxtf2RRu0oaXWnC
	dhNBE1cSq399PRWZNKq/vhKcLL4cdIKcBq8vAySanWS1Q=
Received: from emily-VMware-Virtual-Platform.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3Ha9Qoi1p2MM7GA--.20690S2;
	Mon, 01 Dec 2025 22:12:34 +0800 (CST)
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
Date: Mon,  1 Dec 2025 22:12:29 +0800
Message-ID: <20251201141230.12656-1-huyuye812@163.com>
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
X-CM-TRANSID:PigvCgC3Ha9Qoi1p2MM7GA--.20690S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4DWr1ruFy8AFWkArykGrg_yoWfuwc_Kr
	1kAFyDZw4fK3W7tFy3GFykJFW3K3yagr9xGayIq392kw43Zan8Cws29r4Iyr45CFWxGrn0
	kr13Zw47K34a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjVOptUUUUU==
X-CM-SenderInfo: 5kx135bhyrjqqrwthudrp/1tbioBkXCGktloy9jAADsK

> Hi, sunilvl

> Based on the above patch, I understand that you previously >resolved dependencies between Link devices and PCI Host Bridges by >calling acpi_dev_clear_dependencies(device). I would like to ask: >on RISC‑V platforms, if we need to manage dependencies between >multiple PCI Host Bridges, could this be addressed by adding a >call to acpi_dev_clear_dependencies(device) at the end of the >acpi_pci_root_add enumeration function?

> Initialization order dependencies can be defined via the ACPI >_DEP method in the DSDT. For example, if host bridge B depends on >host bridge A, bridge B should not be enumerated until bridge A is >fully initialized.

> Yes, that should work.
> Regards,
> Sunil

Hi,Sunil

I'm truly honored by your affirmation of my answer.Do you think this solution has a chance of being accepted into the upstream kernel? Are there any unintended side effects we may have overlooked?

Regards,
Yuye


