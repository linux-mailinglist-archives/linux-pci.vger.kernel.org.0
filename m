Return-Path: <linux-pci+bounces-19600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02245A0720C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17DE1681B0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A08214808;
	Thu,  9 Jan 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gNMjdMaY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC0217677;
	Thu,  9 Jan 2025 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415985; cv=none; b=PP/6Kc6BxKvDLJAG+ERwD+tnqWOd+3KO6Ce6nVDG2C+p9Q13m4MyfznhHnjVk+ebwyji3Mwl/I0uKWwXb8iruCRHtydv2kZeq7kzlzyPxAc0MjU1mnQTqk3QK0+poquJt2/DBEfm53MuYyNjsZnmlIEft2MURqRzbn/kRlZHfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415985; c=relaxed/simple;
	bh=kZ5sqmrhe9u6a8L/QnhHrpDXOkvkVm+4jN+QiZQ1k0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qa4MLOSy5uLJEtabYEu2pogyRJ9ADdeOWQ6sTnwpiOtyTpO1W6NDJwA+fDK8d7O8yzjfRZW9JIqwUt6KJpJHSyBHpY+btvjB27UDg4fxQc2w30kENY+X7f15o7qtjPTCFRbGFVgUVhmYdYDIK/qFdlKy8cJctnWtyIV7+nYfs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gNMjdMaY; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8IIDF
	Ah1A9PBAP4mETOEx1UvH7HEpaCnUBlXq0p3TqI=; b=gNMjdMaYHRvLGj0AM7snE
	HRvEKDvtVTa0PtrTHCEtN7JvpRXdMXj56hL7dSe7bECe9xZ97M8ZYGeMe1u4+Uya
	aIuSCOrP4GtTEuJhn0EBGs5LoT4+a2ssJwwlHHi3iz8/P4rmFWQsf/HJIXyo4d9z
	ugOpn2CwSHzq/x5NTO9GD0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3t7rYmn9nRKzYEw--.38788S2;
	Thu, 09 Jan 2025 17:46:01 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>
Subject: [v11 0/2] misc: pci_endpoint_test: Fix overflow of bar_size.
Date: Thu,  9 Jan 2025 17:45:54 +0800
Message-Id: <20250109094556.1724663-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t7rYmn9nRKzYEw--.38788S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUFLvKUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDw7Po2d-kzQzswADsR

1. Remove the "remainder" code.
2. Fix overflow of bar_size.

Hans Zhang (2):
  misc: pci_endpoint_test: Remove the "remainder" code
  misc: pci_endpoint_test: Fix overflow of bar_size

 drivers/misc/pci_endpoint_test.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)


base-commit: ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
-- 
2.25.1


