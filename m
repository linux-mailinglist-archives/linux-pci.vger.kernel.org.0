Return-Path: <linux-pci+bounces-26732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E9A9C481
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA029A6494
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9223816E;
	Fri, 25 Apr 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HeJAnu+C"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C3C2367A7;
	Fri, 25 Apr 2025 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575117; cv=none; b=lDiXooblF2DSh8KurF1K5SewGvt5frD7XBjFoJ7lbz1ov0pNbk0YRdrvAiun4KHslm4t7aoPO1KQf07HQLdVzbQQMNvTu4WW5t8Nch7RavgNPg+i92+y0ZAMpDIvs/IBbXjr8vltTrKzqrsGwLG3yg8M57nlPK9NV994fnqvcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575117; c=relaxed/simple;
	bh=mcxV9MtgCbW8TXB/6cZoRj5iyU6vWRqIMhPap2bVoeI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A6edi8f+PCpHUnq6S7mjsw9SQLZYOCB8OwGOcILCKCwKQlmazcR36RCxkvHZMte62Sc5OTBtm2fcnF6mb896QhqILspWdRen49UzfKUp/UaBw561rheWjR+TUu56BDGBJSlRPuq7LpLWsx4+9BtItudn99BEgw55SVNT2sMZkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HeJAnu+C; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=t0GMs
	iX+PNcYUNByUhlt8Q1u2Zb69tZfn2IGuli2hOE=; b=HeJAnu+CBywael0uJdlqO
	vgZ/eUMwqpnVS6oiP+aShhCWnV5VPMNYvvC48R8yHZ9oN0TsJTCqbz9gTO8SGxGJ
	nW/nHcyJjCfZ50vVLXDL9Wl5J+p0RPxPhXVtCqA1/ip8w/BdBEI0FWK09p8KuSJE
	eCHhHgSMYqvFrP2NXhBPHY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnfJt2XAtowU4iAw--.17018S2;
	Fri, 25 Apr 2025 17:57:12 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	thomas.petazzoni@bootlin.com,
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
Subject: [PATCH v2 0/2] PCI: Configure max payload size on pci_host_probe
Date: Fri, 25 Apr 2025 17:57:06 +0800
Message-Id: <20250425095708.32662-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnfJt2XAtowU4iAw--.17018S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW8Xw4rCF13Jw1fKryrXrb_yoW3Jrb_uF
	WI9a4DAw4UCFy0yFyrKF4IqryYva1kXFyjv3WvqFW5AasFqr15Wrn7uFWjgF1UWF4rAFs0
	9ryDZrs5Ar1xAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_dcTDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxc6o2gLWsg4PgAAsi

1. PCI: Configure root port MPS to hardware maximum during host probing.
2. PCI: Remove redundant MPS configuration.

---
Changes for v2:
- According to the Maintainer's suggestion, limit the setting of MPS
  changes to platforms with controller drivers.
- Delete the MPS code set by the SOC manufacturer.
---

Hans Zhang (2):
  PCI: Configure root port MPS to hardware maximum during host probing
  PCI: Remove redundant MPS configuration

 drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
 drivers/pci/controller/pci-aardvark.c  |  2 --
 drivers/pci/probe.c                    | 12 ++++++++++++
 3 files changed, 12 insertions(+), 19 deletions(-)


base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
-- 
2.25.1


