Return-Path: <linux-pci+bounces-43832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3920ACE94C9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBAE73018967
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB12E7BD6;
	Tue, 30 Dec 2025 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFvy0ze8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB562E764D;
	Tue, 30 Dec 2025 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088658; cv=none; b=TIDKwXAhcGPQ49kGFTW1DOudXgZq2F6vonny1TGA7oOjhh7TNx5oDW9fkzNrD/xmEpXvfSlcHG463OBSdQqqJGIwR4M7ed9YI6DgqXUPSoebAvP03Arbyw1v8trTAvTAhEg0nzhc6HQPsCEdNhR9nOlR5fdCwEwS77mZczKz9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088658; c=relaxed/simple;
	bh=HGx1ic1t7aTiIFW+Y1/81F3eQnEoNSTUIq+92dzQeiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pb/ULNwlAc/lUqIXsPKvSpOlTNn5jTPR9z2Ok+ZYxVTW2xqWXhKjRxOF7dj7h18CBpl54+TKpiyCvBlAcxy9/u5su/RprKb9u+P/qjRsrvCVgmgEPBpxyM1tdpWtONlbc02M01kLjKRtTOYnASmDB37KePJQn9nGyWBnYVenoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFvy0ze8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02537C4CEFB;
	Tue, 30 Dec 2025 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767088658;
	bh=HGx1ic1t7aTiIFW+Y1/81F3eQnEoNSTUIq+92dzQeiM=;
	h=From:To:Cc:Subject:Date:From;
	b=aFvy0ze8OCx9tudNxMpTaspzCWyiPazxYFu+Ba+mxVUL+I+5KUENDvs1w4geMal5s
	 EVKhWor08kfcHi5XLU8SMWEJO2O671fGANBt23jHdW0a+9Lqb46zFn8xSawAyomknD
	 myS3tf+bqT2JGtOaeHTDb6+BVi2oewOary6Ln4OzCDgknYC1TQW2g16L8eS5VvYUC8
	 nty/nFOcWDAZOKoitVyi3OPOIxICLAbpeTL4OPoZC+SGst+rNgwoB3j1f3ruCTc3bP
	 YJ+uNNCi0ZXT7SvB63hY0ns+6t2j/pwYps01KzyJWnSBcLr+ViMCBqcmEZWka0pROi
	 /A0TIXNcxD43g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Alex Hung <alexhung@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH v1] ACPI: scan: Use resource_type() for resource type checking
Date: Tue, 30 Dec 2025 10:57:34 +0100
Message-ID: <12814730.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To follow a well-established existing pattern, use resource_type() for
resource type checking in acpi_scan_claim_resources().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a follow-up to

https://lore.kernel.org/linux-acpi/7888874.EvYhyI6sBW@rafael.j.wysocki/

which is present in linux-next.

---
 drivers/acpi/scan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2624,7 +2624,7 @@ static void acpi_scan_claim_resources(st
 		if ((res->flags & IORESOURCE_DISABLED) || res->end < res->start)
 			continue;
 
-		if (res->flags & IORESOURCE_IO) {
+		if (resource_type(res) == IORESOURCE_IO) {
 			/*
 			 * Follow the PNP system driver and on x86 skip I/O
 			 * resources that start below 0x100 (the "standard PC
@@ -2635,7 +2635,7 @@ static void acpi_scan_claim_resources(st
 				continue;
 			}
 			r = request_region(res->start, resource_size(res), regionid);
-		} else if (res->flags & IORESOURCE_MEM) {
+		} else if (resource_type(res) == IORESOURCE_MEM) {
 			r = request_mem_region(res->start, resource_size(res), regionid);
 		} else {
 			continue;




