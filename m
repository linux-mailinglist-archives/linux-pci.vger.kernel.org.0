Return-Path: <linux-pci+bounces-40066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD32C29061
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 15:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4246188D926
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ED81DF75B;
	Sun,  2 Nov 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NS2qx2WQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104D13635C;
	Sun,  2 Nov 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093988; cv=none; b=C7v4PvGFxngH043WxCz4J1EC+bX701p63DkMMj0fi3niAHotUlHRWMy23rLhijOLX9nRRiaeTW+53/6QZ+XIG1bBqWJDLZGVlg/KJIEsLj2Fdlc8RwRbzWgibD/zVxLSdv/MjFk2Y9EQhfF5ofZlRSNTMSQRPJSbq/khkfBuF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093988; c=relaxed/simple;
	bh=SUFoT1Ho86irZ2qe5sADqbVUA01BgPZPxKItIwcb/v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UDfmbYfdnwRN+spn6954FgzotxGEKe7OnHjZaz08YZN+BlZSUNotfzMugiSwB8F3lWJlxU76DsIhKYGrxq7vujRQNuK+/FEfoPZgYp5HQoI7CzymdUo4XLKmZBRBQEouZdfPNZxwy5Gujf2zb4kxMjU4oAXstC20ZWpo+X6G3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NS2qx2WQ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bc
	cFNt1y2dau95wGvmzi10/Beu5XQmahdlvrr5CH0FQ=; b=NS2qx2WQ6wWZxq3Xne
	yTeOE/hGmHSGs60dFfn1vSmNzW6FVqrNkFvk1cLfjA7AiVD72m7IaSViR2WdN7lW
	ydxy3tnb5SIvWTs9Gj22x9OnBnVT27RFh1fwWk7k5viDPU0K/FGfqqHrjuztvUP4
	vu671Ao1UesL9Al4VDxIF/leI=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAH5VdpawdpqU+1BA--.1772S2;
	Sun, 02 Nov 2025 22:32:09 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 0/3] PCI: Refactor PCIe speed validation and conversion functions
Date: Sun,  2 Nov 2025 22:32:03 +0800
Message-Id: <20251102143206.111347-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5VdpawdpqU+1BA--.1772S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1Uur17WF15Jr43Kw1rJFb_yoW8GFyxpa
	y3tayfArW7G3sxGws3X3W8KFy5WFs3JrW8Xry3J3s3Zr13ZFn7tr18Kr1rKr9FyrWIqr12
	9F1UZFyDCF1jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pifMa5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgP5o2kHZr1iSwAAs-

This series refactors PCIe speed validation and conversion logic to
shared functions in the public header, eliminating code duplication
and ensuring consistency across drivers.

---
Changes for v4:
- Maintain O(1) array-based lookup for speed conversion (addressing
  performance concerns from v3 feedback)
- Move pcie_valid_speed() and pci_bus_speed2lnkctl2() to pci.h
- Update dwc driver to use the shared functions
- Rebase to v6.18-rc3.

This addresses the feedback from Lukas Wunner and Manivannan Sadhasivam
on the v3 submission, ensuring no runtime performance regression while
achieving code reuse.

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20250816154633.338653-1-18255117159@163.com/

- Rebase to v6.17-rc1.
- Gentle ping.

Changes for v2:
- s/PCIE_SPEED2LNKCTL2_TLS_ENC/PCIE_SPEED2LNKCTL2_TLS
- The patch commit message were modified.
---

Hans Zhang (3):
  PCI: Add public pcie_valid_speed() for shared validation
  PCI: Move pci_bus_speed2lnkctl2() to public header
  PCI: dwc: Use common speed conversion function

 drivers/pci/controller/dwc/pcie-designware.c | 18 +++-------------
 drivers/pci/pci.h                            | 22 ++++++++++++++++++++
 drivers/pci/pcie/bwctrl.c                    | 22 --------------------
 3 files changed, 25 insertions(+), 37 deletions(-)


base-commit: 691d401c7e0e5ea34ac6f8151bc0696db1b2500a
-- 
2.34.1


