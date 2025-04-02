Return-Path: <linux-pci+bounces-25161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3B7A78EC5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F043AB7B6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0BA239592;
	Wed,  2 Apr 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W/NTC3Gl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC44853A7;
	Wed,  2 Apr 2025 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597499; cv=none; b=rPFjoEIl0nC6AoovgLbEd+sSWACkY1FWkM35bHxDbKIRhrz2uwsLw3SY8eTniwXA0YX9mcokvwGpIis5vNvd9jboEyVtT3laAC/535KIVPOp11HWJ2iwRWer7oyD15I0Tt1VMdHkwlZ5etB7I7J4uGqPYBC5h2CmNz+VUgbdwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597499; c=relaxed/simple;
	bh=r3pcQv3TWClO650O09hMt1da44NNqNj3C/wcGPQoifw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YCsvCCLJEKIsEFqjPxT842oTbIzF7immjoMQgsaNFEgZPFVqHQVxy35eq53HOU4oGNuEbwPr4J4JelZ6P+lOkxc2dZJ7T9v7aijbB6oyiDe3atTYFFGvJG4KhcCRQiQKKyH7YqLT9U3sYcG8XdKsjS2PzvtNv5cvQwpsLKoW4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W/NTC3Gl; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=s7Q/H
	BLTb9ISe4YgGhFV75ejBEQE/ZjrOsxIZf4gJG4=; b=W/NTC3Glv9GsVM1QYZ2Ze
	D3mQudpIQsGWkQGkE44HgT8Q2RJ0mnHRi/Ho6I3q8C922Wsm5BgeP4yaxlt7CnJT
	1E42+5muCbamjtVw8d9sfjQGTtnOjsR/V/jdqF20zoIImheJce9yJf6ZTx/zLIVs
	fjVGLLRIjYx/idAVII7BAM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCXrkiUL+1nL3+IAA--.22499S2;
	Wed, 02 Apr 2025 20:37:43 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v8 0/5] Refactor capability search into common macros
Date: Wed,  2 Apr 2025 20:37:31 +0800
Message-Id: <20250402123736.55995-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCXrkiUL+1nL3+IAA--.22499S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xKr4xCw45Xr4fJFy5Arb_yoW8ZryrpF
	yfJ3Z3C3WrArWa93Z3Xa1FvFW3X3Z7ArW7JrWfK34SqF1fuF4Dtrn7KF1rAFy7J397X3Zx
	ZF45Jr95KFnxA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE031iUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgojo2ftJvzjoAAAsj

1. Refactor capability search into common macros.
2. Refactor capability search functions to eliminate code duplication.
2. DWC/CDNS use common PCI host bridge macros for finding the
   capabilities.
3. Use cdns_pcie_find_*capability to avoid hardcode.

Changes since v7:
- Patch 2/5 and 3/5 compilation error resolved.
- Other patches are unchanged.

Changes since v6:
- Refactor capability search into common macros.
- Delete pci-host-helpers.c and MAINTAINERS.

Changes since v5:
- If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
  the kernel's .text section even if it's known already at compile time
  that they're never going to be used (e.g. on x86).
- Move the API for find capabilitys to a new file called
  pci-host-helpers.c.
- Add new patch for MAINTAINERS.

Changes since v4:
- Resolved [v4 1/4] compilation warning.
- The patch subject and commit message were modified.

Changes since v3:
- Resolved [v3 1/4] compilation error.
- Other patches are not modified.

Changes since v2:
- Add and split into a series of patches.

Hans Zhang (5):
  PCI: Refactor capability search into common macros
  PCI: Refactor capability search functions to eliminate code
    duplication
  PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
  PCI: cadence: Use common PCI host bridge APIs for finding the
    capabilities
  PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode.

 .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++----
 drivers/pci/controller/cadence/pcie-cadence.c | 28 +++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 18 +++--
 drivers/pci/controller/dwc/pcie-designware.c  | 72 ++---------------
 drivers/pci/pci.c                             | 80 ++++++------------
 drivers/pci/pci.h                             | 81 +++++++++++++++++++
 include/uapi/linux/pci_regs.h                 |  2 +
 7 files changed, 177 insertions(+), 144 deletions(-)


base-commit: acb4f33713b9f6cadb6143f211714c343465411c
-- 
2.25.1


