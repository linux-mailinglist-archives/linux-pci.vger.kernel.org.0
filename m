Return-Path: <linux-pci+bounces-41767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818DC73374
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 10:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B89135768B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98923C8C7;
	Thu, 20 Nov 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TJDJn4eW"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4902DC78E;
	Thu, 20 Nov 2025 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631334; cv=none; b=tRx7v2T1bzOmapCVEHxdZxCpmH0p1Q4Fg8f/a8HpZUMUVMjPGaMwdOWay7d0hhAljF5hwU2MXypjgdtUBg9FOlraildycljzv2gIjq0U681aJ5DujyzpVS69g1jrLbS5sIsRbp1TO3vLIpANBfL15DNfuCo+BL+hZLbOyZSiRm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631334; c=relaxed/simple;
	bh=9MK2mOASgJtEjSWkzvr/kUloqLGj5NEHg5Xj61eW/rM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B4BQlhPiB1GDH9v4jnFHNufsW3z8p5r92ee6gJ+y93NIJGeQm9qcrcbXN0Fv41Jaz2pSy574HfOw0LKRhqAVe27UwtmL9oBILi1+LMjSyWVvnPvb89Q3PDKXAhUek+9H/rgL3qS2bCyfqCEjnIjHmGGWaMRwQumtS7yCeD8cISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TJDJn4eW; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763631327; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WJ0rBYBZKke7jiLGNlj+0s9VInlH8gkQ5EVWYGddQC8=;
	b=TJDJn4eWo9tKyauLVr7IapgGH2jsceqQK51iMjHATB16X4nCcZ88p7ds78hhz86FZetOU+/+uApnG+16wY056CXzSsfrCMYUb9rMjcSfq+r2NPbRe0yLPf4uW2MNRoQaRTYKjUmIWL2kX5jbxxPL9FUdw7ZOhp6HD3xuUJIgUaA=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Wsv4Gz5_1763631319 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Nov 2025 17:35:27 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: lpieralisi@kernel.org
Cc: kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] PCI: cadence: remove unneeded semicolon
Date: Thu, 20 Nov 2025 17:35:18 +0800
Message-ID: <20251120093518.2760492-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/pci/controller/cadence/pcie-cadence.h:217:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=27326
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 717921411ed9..311a13ae46e7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -214,7 +214,7 @@ static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_re
 		break;
 	default:
 		break;
-	};
+	}
 	return offset;
 }
 
-- 
2.43.5


