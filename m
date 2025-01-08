Return-Path: <linux-pci+bounces-19510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A05A054C2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3DC3A1E6D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 07:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAF71ABEC5;
	Wed,  8 Jan 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BenqbBte"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A1A59;
	Wed,  8 Jan 2025 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736322127; cv=none; b=IVADgJ/ImnNaYxPDUe/halgWFJsPPEV+6BXsU8jynvEyYanMRgvM4o733T1cHC4NEBxPxIlMcwOA0M48Mly8a+EtkeQw74cFm7bYgd8bH6icqEqf2wad9hTcLbqLELdWK2Dr0IbjoZtCi7eop6ljDGKAkqXC95H72OTPlJ43UnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736322127; c=relaxed/simple;
	bh=MwisekUH3r8LZRuzgNi7nU+vXmpqQL0thrEVNwt3SOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WoOunfKjaB3ySwmXrP1dzp+DZ+xwGKUe6yl6Kg6tlQbt4Zt4Y1/fhqXE18xjy9NST48Th7zD0E7NYN6v1Q2uonUA+mXCVlYFgKjo/ciQhoslSgY8rUDse8piFffFQQiVuDrcTaBurryOd7DFhCIgmadjKkg37xmF2k33kr4/XJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BenqbBte; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zS7YW
	FUmYrTrTlU7GQeMG4h/5ZBOqIU2VSHZIoBYDh8=; b=BenqbBtejAPzVS0/uAN85
	tE9NxALncmDLm9k0OjJPNK48gT/zrfWwRvdubT+hrFc+x943x/dlx7TchW15Qt0w
	a7hYhu7LPjiIS9DR3BihmATH9Shwxnb9BDEqv+KHwZpkKAgivlaNVPOgTM/Q1WUa
	5sdgNDP/ietSDy7oClQPwo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHk3pWKH5nJeDMEQ--.48179S2;
	Wed, 08 Jan 2025 15:25:12 +0800 (CST)
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
Subject: [v9 0/2] misc: pci_endpoint_test: Fix overflow of bar_size.
Date: Wed,  8 Jan 2025 15:25:02 +0800
Message-Id: <20250108072504.1696532-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHk3pWKH5nJeDMEQ--.48179S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU24EEUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw3Oo2d+IkS0AAAAsk

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


