Return-Path: <linux-pci+bounces-30647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF62AE8E93
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731CE1C2069B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B482DFA42;
	Wed, 25 Jun 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="K1aoIQuV"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198F2DA76D;
	Wed, 25 Jun 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879551; cv=none; b=MH0JQK64EK7UOexp9IaOCw07bmRu2Vn+L1M4H7/6gCpl5HODhtcrvehxIeUYfajvjoo+nSxXbQkAJXIjnZA+iFjHFQS5GiNbmtgSL97xRq45ncEH3Iqtlfd7lXT1vFqlWEihJ3KEjCj4qO9XRMZnvxwnn5PUaOacK6OCpQH3+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879551; c=relaxed/simple;
	bh=jxivFLr78nWv4zamdS1SvrfawUIvx3vEs3eExPVBSTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlZjas1lrXwDo5qp2QLIyBOefM5gjOU3atNwpI9FfWyqlT88OfqgS8JVNoXfLhNbBSCols1uc4m4HprwL3lMpCIDz04/92IbxEdQs8sgMa3vlyrmxrmIQUHP5K6SlCerY0rQn8QFSpO0vm+kGIeCeJrLpUFZe+5dutrwwxrLP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=K1aoIQuV; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 59CB366E7D9;
	Wed, 25 Jun 2025 21:25:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750879541;
	bh=jxivFLr78nWv4zamdS1SvrfawUIvx3vEs3eExPVBSTM=;
	h=From:Subject:Date;
	b=K1aoIQuVGm4Ei4fIvNNM/1LT7hvr0NfOp90BO34yYlzle9hGrktVQhNSr5MtKrBW6
	 +eyARTvqYOhED5nv5KSXv2ulsW8Qan+h3gkG8VZcAHzBnm18Uuk+ItT8j6njXVsCiE
	 YCv3f408hiyjGBTbehiuetyXGSg2k2zd3KYEAyM7kov6qlUbpx/yGez5ShmMV8989h
	 QWVLf53VmptnWayMoxj6z+6j4rBtehgs+oh0+o4z8IRr3ULJKmm/Ejx5dK4dgEtthr
	 gQ+QPQdLI32wlzDL4rxPVF3dpgCyUO8lOGx8+x7ZzQAfYF8hVbV3PSQa62CQ/yDjvM
	 HQnujmmwoKA/A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 5/9] PM: Move needs_force_resume under CONFIG_PM_SLEEP
Date: Wed, 25 Jun 2025 21:20:42 +0200
Message-ID: <1947441.CQOukoFCf9@rjwysocki.net>
In-Reply-To: <22759968.EfDdHjke4D@rjwysocki.net>
References: <22759968.EfDdHjke4D@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTFU16MN1onAmfTggu3iKnPYA/STqEnOhMRWZkwNQSI5OpDf+u5DT2NkIXE+Nhe4mqxr9ks7U05Tnfbp21L5zWLAY+X8uGCUnkPai/a2KG4xxKx6eBqQiVngKpLwnPSZjvR8Q4dQfv5MKNDuphWx1Et6P/rcNTpUFGeZ3Ng1C9/8uA5jpLaNlvEnYZjWpU/0SCP+rHDTsSrswgF9Mks70F5evvoz0a/MhrLqsCe8JTvEOP0IBVuaTh/K6p4bcE/yKwFXFB6GIgqfD+zcy9GvwASdPeWl27ugbAiFeVCNlB4LFehOIpnBvg5juGRVEZAUcpiQXLbFVpM3kyVvpaAi61rFUVPziiGIl/qioLy9qJ3cNM0QfkBI1HMCZAPW9eawzWgdIbY7DDxrvfRGxZLBQvXnL+mnuvmI9vpRdJa0rytUUBRNEdJKpPW46gqiP8FsFNvlcDv08Wb4/+MAe+36v+8u5GRoWqTK3encyCtY48yHJiDO8aOF6v0nVNfqS3I2fvn9+UJn+QiSQP/J05CHXcV2AIK2fYSPDcokX6n42rRI/tuY5zGpTIBOvpi9ymlke5nHgrgncIPqWWk9ad12pzz66R0epSedwbhvaIj+xHNvoxgII1OSeQgPg25xls5+tugGxlQr3iIxIlztFCbUe7B90vAHSC+ZDeQj3Mazg/3AqA
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All of the code using the needs_force_resume flag in struct dev_pm_info
is under CONFIG_PM_SLEEP now, so move that flag under CONFIG_PM_SLEEP
too.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -683,6 +683,7 @@
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
+	bool			needs_force_resume:1;
 #else
 	bool			should_wakeup:1;
 #endif
@@ -698,7 +699,6 @@
 	bool			idle_notification:1;
 	bool			request_pending:1;
 	bool			deferred_resume:1;
-	bool			needs_force_resume:1;
 	bool			runtime_auto:1;
 	bool			ignore_children:1;
 	bool			no_callbacks:1;




