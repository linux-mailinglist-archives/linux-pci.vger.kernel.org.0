Return-Path: <linux-pci+bounces-19518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C0EA0554C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111C6162B14
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11E1DFD85;
	Wed,  8 Jan 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eUdxISpk"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284513B288;
	Wed,  8 Jan 2025 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324831; cv=none; b=HJ0neu32xvqWeF8W7+dR4gBb9qcyknf/4aeYVLJ5CVq8ir0+ES3iut6MaT9NKiY+YqxsWlmU+8I+tRhvf0OgTiU+Mxe0/uda0J/dNppxLIYC2tHIl3X9ErGPkPZIBoWE8pGBx73KPbYQm5JX+xf33FcQGpk7+nuxe1W7bCd4uyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324831; c=relaxed/simple;
	bh=MwisekUH3r8LZRuzgNi7nU+vXmpqQL0thrEVNwt3SOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=auTByGaD0ki/tsxaTz3FiQhqtSxbl+JY5EJ8DEZpoMx0U8p9zTsTg56wB54GZWjeaHuhGPobWVHJxFyX2rREB1XnaSPD4uBDQJIxy/wxEDiSADrslesXqJDYjW+icKhcKNK2rj7Wb4txUs7k3pfmLKzjTA/GcRy+omG2pSaQoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eUdxISpk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zS7YW
	FUmYrTrTlU7GQeMG4h/5ZBOqIU2VSHZIoBYDh8=; b=eUdxISpkNc0WaEJ6LVLOl
	1PE9zjf3NbbYMJQaMQ+iq92B61RD3AezlaLMY0UD6gbXfK4FBbXqdH+bnORDqUEz
	4m5R4klqHbLE9suIgV7QWgLbNRj8w81AB32Nka1KYef1s2c6VTGIYdDe+HgvefoC
	F17wc9Dud0Npr4VCqL2GSE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBH9z0ZM35ntarHEg--.53777S2;
	Wed, 08 Jan 2025 16:11:07 +0800 (CST)
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
Subject: [v10 0/2] misc: pci_endpoint_test: Fix overflow of bar_size.
Date: Wed,  8 Jan 2025 16:09:49 +0800
Message-Id: <20250108080951.1700230-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH9z0ZM35ntarHEg--.53777S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7Pr4UUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwjOo2d+LfBDCQABsx

1. Remove the "remainder" code.
2. Fix overflow of bar_size.

Hans Zhang (2):
  misc: pci_endpoint_test: Remove the "remainder" code
  misc: pci_endpoint_test: Fix overflow of bar_size

 drivers/misc/pci_endpoint_test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)


base-commit: ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
-- 
2.25.1


