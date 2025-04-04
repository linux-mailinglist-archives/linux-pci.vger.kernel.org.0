Return-Path: <linux-pci+bounces-25267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DBCA7B6D6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 06:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969543B8DD8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124ED13BAE3;
	Fri,  4 Apr 2025 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="TtBjpuRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637741A8F;
	Fri,  4 Apr 2025 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743740799; cv=none; b=BnlWbeJecgHgZ6cseDAR1pWrdqOcPeVQ2GHXKeM5BYssli6/BwhlEutfUac30G4oD7DUkf37iioxz3E+b+OZ9FV852M7QLkmpgjjCp3Ck+R1MhZPQc+SW/IdcsPpnFzy2klFyCXmmVgs4lakFfgsb1K1wE4kaXCeG/gx0omUetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743740799; c=relaxed/simple;
	bh=A/cZPvww3Ad+U+8Y4dNgBrnTZwnWcMnzKOcn+dtyrdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TIWCuP+O2M8ZvU2G5F7e+yB2cuCNZfToc0EPzf2q8BBN08pbYt0VLiU6KWEjyyx8EVvSxb6L50y1z/lv7FaqsrHv84YsR4FfubRQh73YSwp8JPWm0LWGQQMJ55GrOMQbbEpXRJp9VcLIKsi4iP8bF6sU5mz3KAV3grijDImjIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=TtBjpuRy; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 5FFC082878A5;
	Thu,  3 Apr 2025 23:18:14 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3t03eeFtjAEE; Thu,  3 Apr 2025 23:18:13 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C13338287D28;
	Thu,  3 Apr 2025 23:18:13 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com C13338287D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1743740293; bh=jRiQbVybKjEcDuhXdoz/6+j4pLASO6re8oUagrPcVLA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=TtBjpuRy2roKw6anjOiVGHi1nFullHiYIjLmrAjleSddBBnNuiJnC9Izy9x2UYtCW
	 fzmWg4y/y3DXgLiqRaJ5xWiQlL9NdK6hc+eVLjP+K8WHUl5nZ0352ghRHyptB+A5c3
	 yrGV0vm0xTTj/sMLYB0bDP0orTBSocMGOJalEXEY=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oB17kzBUJWU5; Thu,  3 Apr 2025 23:18:13 -0500 (CDT)
Received: from raptor-ewks-026.lan (5.edge.rptsys.com [23.155.224.38])
	by mail.rptsys.com (Postfix) with ESMTPSA id 18DA58287182;
	Thu,  3 Apr 2025 23:18:12 -0500 (CDT)
From: Shawn Anastasio <sanastasio@raptorengineering.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	tpearson@raptorengineering.com,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [PATCH 0/3] PowerNV PCIe Hotplug Driver Fixes
Date: Thu,  3 Apr 2025 23:18:07 -0500
Message-Id: <20250404041810.245984-1-sanastasio@raptorengineering.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hello all,

This series includes two fixes for bugs in the PowerNV PCIe hotplug
driver that were discovered in testing with a Microsemi Switchtec PM8533
PFX 48xG3 PCIe switch on a PowerNV system, as well as one workaround for
PCIe switches that don't correctly implement slot presence detection
such as the aforementioned one. Without the workaround, the switch works
and downstream devices can be hot-unplugged, but the devices never come
back online after being plugged in again until the system is rebooted.
Other hotplug drivers (like pciehp_hpc) use a similar workaround.

Thanks,

Shawn Anastasio (3):
  pci/hotplug/pnv_php: Properly clean up allocated IRQs on unplug
  pci/hotplug/pnv_php: Work around switches with broken presence
    detection
  pci/hotplug/pnv_php: Fix refcount underflow on hot unplug

 drivers/pci/hotplug/pnv_php.c | 110 +++++++++++++++++++++++++++-------
 1 file changed, 88 insertions(+), 22 deletions(-)

--
2.30.2


