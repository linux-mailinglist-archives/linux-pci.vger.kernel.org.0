Return-Path: <linux-pci+bounces-7275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFEA8C0840
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 02:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D093B21303
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33438C;
	Thu,  9 May 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pC4Q1ZRN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42665195;
	Thu,  9 May 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213350; cv=none; b=Mb/iOI8rwSap3CR+f/C1v5AX1MQJ9LCOh61Ez/SzIp/ET9SFuLDCKbEx0HtRzhON9NURwg2yyz+zQAdTThu8elsCafUMd6c+68aQv0/IMBjwaFGgL3zRn+qcDh70mIs6F+WhfveYqR2+Ht7Ke9+WOXfA+GxsmjxGUfUCkMb/UBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213350; c=relaxed/simple;
	bh=7HPx7ytB8yzsrqlvCHjViQu/yiO3QQK/0llEhSgBExQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioA8sudvMLiUJTZIjz9A6BsBXFD4cl6e1bQShxVv6TEWOux7ssnxPUrFf3ZzZmu6mucDlPtS544cDyrqsAdd26CN4AbpM6vGmztz5PYRpePid0wdyw7S6tWRa8XDCr59fcn7sSYcTAV18sO2hbkwKhp63WbkRrxjaARbVuiDeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pC4Q1ZRN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=y2dMD6eMEIJlGJUVSAMoOwfNsxSv8AwnivqVHzlW4IA=; b=pC4Q1ZRNqutcgQ1c
	4FU1JpGaHK4PL+St4xWONQljBqRBNY80Ixt2dEwXgVhJ0VKwOy/279zbq6O5klyjoPnVa0Gwhs5Wr
	FctNHUNk+7Wiz/Q3ZsXNhIeSVtSNAXG6J8KJbzHkJ9GFSB8YvlVgYnF9FxR88AKKtnmqqV7HaIDvz
	NKu82Bm0gOI0d8PLaW695UWACQATwzLV4koShwr6ELuyZhvLbZMl1oQ7ErPgTZpkj2unxD7+34UaI
	3ddpyePrVmoZtoh41pTchOlBzOPSsDkBvM/XxUSTK/3+A1WDZ3nSDcn38+AbROg+cmCbKXr+Vs5k6
	rJ1Go/W+AKVQ50mvyg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s4rLH-0006zp-21;
	Thu, 09 May 2024 00:09:00 +0000
From: linux@treblig.org
To: bhelgaas@google.com,
	rafael@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ACPI: PCI: Remove unused struct 'acpi_handle_node'
Date: Thu,  9 May 2024 01:08:58 +0100
Message-ID: <20240509000858.204114-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'acpi_handle_node' is unused since
Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/acpi/pci_root.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 58b89b8d950ed..59e6955e24edb 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -293,11 +293,6 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
 }
 EXPORT_SYMBOL_GPL(acpi_pci_find_root);
 
-struct acpi_handle_node {
-	struct list_head node;
-	acpi_handle handle;
-};
-
 /**
  * acpi_get_pci_dev - convert ACPI CA handle to struct pci_dev
  * @handle: the handle in question
-- 
2.45.0


