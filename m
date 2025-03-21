Return-Path: <linux-pci+bounces-24322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F5A6B89A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 11:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29259482533
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F5D1F585C;
	Fri, 21 Mar 2025 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OeBXtyr8"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3864D2AE6A;
	Fri, 21 Mar 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552285; cv=none; b=kSQa5+QujgQCjHW8PCbpRcYsLQUB7whZOtxNJqKZSl8xvj8tjKcZOcZz75G89ZZhkZhCxri0EueoRmVDYi6QGo3iEVbLzSVRL9zs41vqRnQk0hUSs83DrJ2izEuoAEh7J1iE5Cx9p/GvTeFt4jFWDl9GqwehwsmOrhRKt7JTRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552285; c=relaxed/simple;
	bh=rMeWRHKHUpPcUeWgQif5Yw8um54LUTIRYRDGLGKszGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eGM4y/h+5W1+IMP8QOXGK0bP5fY73kWdTmPHwIaxdGjIT8TI77nhsnUOlvOIJSsFwnIRBCb8bGBjNDbbjyBbcBNtjH5O0vSVPJZgQYpNrV4G2LMLJ1k7hGRMRVtjTIPUHwRvbTfN9+rTx7Fvtv75yCAWHLNReUD4w9/iabXc8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OeBXtyr8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1Gwxk
	5l8w1oAuHTEdurv7jwjGQeM6ATEIA0at1Ql0OM=; b=OeBXtyr85vcpa+Zl5b8jD
	A+UKxUvFiwYv8mKyNHXuWNnQd7Gjux5Y1j3EGcsZ6cXTakLUyycO+Sz0L5fq3zPd
	CRE5C9UpUgmwnRZ8+Itsv0Q67q25hLnL1KZ/0e31HeQrcCVW08eno39CV1lutd0l
	5Qsh2aLztuWrl+19hX83CE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnKl+oPN1n7W5_AA--.28658S2;
	Fri, 21 Mar 2025 18:17:13 +0800 (CST)
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
Subject: [v4 0/4] Introduce generic capability search functions
Date: Fri, 21 Mar 2025 18:17:06 +0800
Message-Id: <20250321101710.371480-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnKl+oPN1n7W5_AA--.28658S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gw43KFW8Xr15Cw4xCr15Jwb_yoW8Jr1rpF
	yxC3W3Cw4fArWavan3Aa1q93W3WF93ArW7J3y3K34fXF17Ca4DKr4ktryrJF9rCrWIqF13
	XrWUJFykKFnrA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEwID3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwoXo2fdN0OTeAABsV

1. Introduce generic capability search functions.
2. Replace dw_pcie_find_capability() and dw_pcie_find_ext_capability().
3. Add configuration space capability search API.
4. Use cdns_pcie_find_*capability to find capability offset instead of
hardcore.

Changes since v3:
- Resolved [v3 1/4] compilation error.
- Other patches are not modified.

Changes since v2:
- Add and split into a series of patches.

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
 include/linux/pci.h                           | 14 +++-
 6 files changed, 152 insertions(+), 89 deletions(-)


base-commit: a1cffe8cc8aef85f1b07c4464f0998b9785b795a
-- 
2.25.1


