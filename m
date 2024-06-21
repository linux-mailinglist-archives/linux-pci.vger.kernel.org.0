Return-Path: <linux-pci+bounces-9058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC9911BFE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 08:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D5B1C23E10
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614F113E022;
	Fri, 21 Jun 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ngn.tf header.i=@ngn.tf header.b="1sWaEgpG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ngn.tf (ngn.tf [193.106.196.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87250167D83;
	Fri, 21 Jun 2024 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.106.196.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952143; cv=none; b=kbOFgbH57+UgXcD+MO7OeRuqgg8THDHA8Wrqo0xZfKy2UGCOEQlVH8Cfc0Rm94ZmrafahfT5PcJ71mYXSegDIyMFIDm5bijRV7zFEm/U+hiAV6L2/hNbvkvOlX2TxIwKc+4vzX9tlOLRm8ugXr2PFskzmfm5NLNePEd3BC2LPsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952143; c=relaxed/simple;
	bh=SfZ49+qB9E3lPlAObnF9xMBk/gcPk0g5dXd/N+IezMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXJoj9QfujKkBhIpweHJnjVqef+AlX7vi96J33BReyoG55fkumj2YDzf2W6XVz4/p0iiukwoaXqDvEj2VJPl76Oo6uH2Hxy/j7mLZNsaKgSvWW/wK4f5hBmIYWnAE4OQUOEuXbBni/ABcC+ieywdCi1ldmGeiyfI6DlKmh4PGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ngn.tf; spf=pass smtp.mailfrom=ngn.tf; dkim=pass (2048-bit key) header.d=ngn.tf header.i=@ngn.tf header.b=1sWaEgpG; arc=none smtp.client-ip=193.106.196.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ngn.tf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ngn.tf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ngn.tf; s=mail;
	t=1718951788; bh=SfZ49+qB9E3lPlAObnF9xMBk/gcPk0g5dXd/N+IezMI=;
	h=From:To:Cc:Subject;
	b=1sWaEgpGuAVQnScktKAymP8fwjQv+7foXZn8f5dCLzKulWsORo68/w58uHN6Yvvfy
	 AnEGOY7KUiYgOIRncbNL8+9EXbix+oMJ57t8YSB6fz+7LBD9W9YvbdHNV/8FzA5fYI
	 O/bjWiC+JBO0T9j6iibSDKFLOS5kj+/W2HAyf/qeG7WzcmLQhYTcvqIr3MbWlns1A5
	 StLMT0NCWpS8S5ODXxllXirXPjPKtPYpt9Ny4HDRr70iw/Ghouts0rAoPTInuJQ3xT
	 EDwRdjOH4mHP2CHvk4LoutZP5taIjg0ZEDf/E0+OheT3TvMIYQQ+kVyftuL65zQkw4
	 S6b5DQXqmYyRw==
From: ngn <ngn@ngn.tf>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ngn <ngn@ngn.tf>
Subject: [PATCH 0/2] PCI: shpchp: trivial code cleanup patches
Date: Fri, 21 Jun 2024 09:34:59 +0300
Message-ID: <cover.1718949042.git.ngn@ngn.tf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a small and simple patchset that cleans up the old shpchp driver,
a part from fixing checkpatch warnings, this patch set removes the hpc_ops
struct, which is unnecessary. This is explained in the TODO file:
drivers/pci/hotplug/TODO.

Also this is my first patch!! So if you have the time and the enegery
please let me know if I did something wrong :)

ngn (2):
  PCI: shpchp: Remove hpc_ops
  PCI: shpchp: Follow kernel coding style

 drivers/pci/hotplug/shpchp.h       |  84 ++++++++--------
 drivers/pci/hotplug/shpchp_core.c  |  20 ++--
 drivers/pci/hotplug/shpchp_ctrl.c  | 107 ++++++++++----------
 drivers/pci/hotplug/shpchp_hpc.c   | 154 ++++++++++++-----------------
 drivers/pci/hotplug/shpchp_sysfs.c |   7 +-
 5 files changed, 167 insertions(+), 205 deletions(-)

-- 
2.45.1


