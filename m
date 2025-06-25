Return-Path: <linux-pci+bounces-30645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF22AE8E8A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F057D4A13E9
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3572DCBE0;
	Wed, 25 Jun 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="JacgysDP"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521A25D521;
	Wed, 25 Jun 2025 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879550; cv=none; b=leMuE5qwAV4P7kvaCZhIk3l8zbmdNpnrs6011yZa9/+ivBMN6z3QY5il3Djc6b0J6cmW9Fpl5uItSl81ZosYRxAsLJPQVFDVYThpWIU0ACwlyBR3Vf8iRQp4XbEhiJ5w+M4J4PH1WIM38hDt6c2wbvydZ9gDuOgPV1XQUAEpx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879550; c=relaxed/simple;
	bh=fL07ed664b8KHRpK4by83bnQ93V9mCeY948pv7sxCyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMOOZ5Na41aRcct6lSWYkNIRvC6rgRM63bPpRDwAhmjfWM+rthPEPvL28Kb4OJAuFtsQf2l2gJVxiJYDIdq9OCmxUoWprcW3hPQhz70mQJKhbffZlbvrmxwDyQ3jrcT1SN4HqFPk8CFOql6RmcoNJlcUVFu3mmtQQmxB8ZEupmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=JacgysDP; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7CC6966E7BD;
	Wed, 25 Jun 2025 21:25:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750879540;
	bh=fL07ed664b8KHRpK4by83bnQ93V9mCeY948pv7sxCyU=;
	h=From:Subject:Date;
	b=JacgysDPvCJAfvx00Lg1BilMrYnnZzEwW9oP7TgcyTF4UuBOf8BzZ0Uygn7kNv4hy
	 W30SmVsxXcrd7jNrh4444w3Uwl7yRPn+i64znnGuszKRpZ7pv2lqN2I7bWPsBNLInt
	 qbrIDBhQb4bGPGRVgEQ5Z+IWypTSEJsO7RCrn02dHPvKFkLrkRwTc2Wpx9/eOgojPT
	 xvkAMFlmSpFRv8RsaMJODXmkBeIVsfTkZGeOvmkOI4oUcEEvPiyhQ/HNHscMXCfkJI
	 W1XYbbPBxmemjnWUb+YYGt1L3PGpItwFUj4U1+vl1RgPJEAlhRU4wiK9dX8+JSqMnr
	 H7b1uCFMYh4Eg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v1 8/9] ACPI: PM: Set/clear power.strict_midlayer during attach/detach
Date: Wed, 25 Jun 2025 21:24:27 +0200
Message-ID: <1916173.atdPhlSkOF@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFsHB4ndHl+EixzVvfcW9Mmmy1kJBTax7trknkJLaM7+K738OXHPnCLWL71aVWNGrvB6SMUqGuVyxhuQ+ooiLNs2MbM4c4D0d0tOrBg/iqNv0NqZnl4bI7AjHbqvRt2zNkln610HrDv5mcESQciqXkjUvPbGU2EDCNxbdy4W0+PztFwXuz2PoVolx+WqtpeqA/IjF5HnJOewYMwBLd3YUcwVvpscrXqL25wGO+dHcovAc/0P/JFJdFj7a2OZUqN+PhZCSQpVtIs9I8x2nQlmx9gfVUTLdqVFWNLWvDXpj2m/7jpvs2hYMUoWA1lIxHkWnadOR0nWIatMTQTpWUFdoNAnsp4krQvH27ZQg3rDTlJj3aETi5LzRYEBJyx/qw/ZRd23vJwz9J/wza1zzh5NAgsfGrrGEU5yvBImkk0/nuuedQ4UxCufzCEzWgP8wg8Hq2diqWUpw14NDJSDymQz7XKmBYUojlq+QfGjEEJ4K1o8XvbVnU/S8T9z6GkHmLEbxE9WfHJ32tBUUDKtJhhT3rWAlJKnpcgdtwA85SkI2Tq6u2txG44GBsTB/ad+HGFUuXwENwtADqabvgHnxul6UxXOclNmFnd+7+gcwZ8X8fsNk8QzDQD50zWjtYlswCS0W9FaAdT9M1vGnbyxRMjoG9QxReXkcKImqO/vXzLdtq0VA
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI general PM domain does not expect its runtime PM callbacks,
acpi_subsys_runtime_suspend() and acpi_subsys_runtime_resume(), to
be invoked at any point during system-wide suspend and resume, so
make it express that expectation by setting power.strict_midlayer
for devices that it is attached to.  Also make it clear that flag
when it detaches from those devices.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This depends on

https://lore.kernel.org/linux-acpi/4665476.LvFx2qVVIh@rjwysocki.net/

---
 drivers/acpi/device_pm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1404,6 +1404,7 @@
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 
 	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
+		dev_pm_strict_midlayer(dev, false);
 		dev_pm_domain_set(dev, NULL);
 		acpi_remove_pm_notifier(adev);
 		if (power_off) {
@@ -1463,6 +1464,7 @@
 
 	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
 	dev_pm_domain_set(dev, &acpi_general_pm_domain);
+	dev_pm_strict_midlayer(dev, true);
 	if (power_on) {
 		acpi_dev_pm_full_power(adev);
 		acpi_device_wakeup_disable(adev);




