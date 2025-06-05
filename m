Return-Path: <linux-pci+bounces-29014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D51ACEA8A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 08:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83C83A9F70
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9FF1F181F;
	Thu,  5 Jun 2025 06:59:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB51C84D9;
	Thu,  5 Jun 2025 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106774; cv=none; b=HrUiNA2uofwf7B2XkWCQRhPXJ57OYaogDVfowyVRwOpjZ5xFUSueH7YSXu29lrbOVl7c9HhexPV3WBwh/Ln4aPhUaNH5DWrAgb3UrS3dcfUbKvf3GgL1cZomNwBYHwIIqKhxWB42eRus2iQAjm9zttE49oO9esGAMZ6jUTaOxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106774; c=relaxed/simple;
	bh=Th8cpMh0swdJHkc4hP6J8Je8ONA76xwO1Xsebxi5l+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CelC8vqI/kqmv4UjY+TE5qI3tSbYLefGeJHLdT1a9ZILaQwFXlvbEeenxo0Zc5q46iWo1QrpXqy3w58A11BqprwG9Qozj3URo6mmZZ2Rz/cLzQmO7Q5xcapqsomPpnsoIAK8dMPirS5DAB1XUw+n8iK3hWeu4sJLnZC6QfDDXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.dBaQkI6_1749106758 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Jun 2025 14:59:19 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoushengqing@ttyinfo.com
Subject: [PATCH v6 0/2] Revise some PCI _DSM method implement 
Date: Thu,  5 Jun 2025 06:58:12 +0000
Message-Id: <20250605065814.41298-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[1/2]PCI/ACPI: Add rev 2 check for PRESERVE_BOOT_CONFIG function
[2/2]PCI/ACPI: Add acpi_check_dsm() for PCI _DSM definitions

 drivers/pci/pci-acpi.c | 58 ++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 14 deletions(-)

-- 
2.39.2


