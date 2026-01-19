Return-Path: <linux-pci+bounces-45184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A49D3AE82
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C82A0300ACC4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3C37BE62;
	Mon, 19 Jan 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wedekind.de header.i=@wedekind.de header.b="AAIwYYZL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.wedekind.de (mail.wedekind.de [80.153.46.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18F34FF59
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.153.46.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835193; cv=none; b=rlNwJ6c+oKWl26HrE1xUAuxYE63BsEgv//DZjyN7ZOiCfmN1EmTpwSMJ0qZS384lW5Ci+8KusZGOtMR50T4vPVwP+JedAWxrpdCkI4zfGpTR0cbXDgm29JNBP+URDqZZjAFEfaejIakLnYVTY/aj1gcObIuynw+NHgxfihhIpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835193; c=relaxed/simple;
	bh=iegCgUpjcxEyCWYNPZnoYKBgv4tG1UGY0oPuvkutQQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=urJa21FjkQ/5T0rveSUufuOirwjuO4NdUplQmTt9UPUG8krPnzeuUJKFShWetnlUrEqt7BJDXfoQcbh5DlxuTdXs7uZP0butwN6jHVl3qyZamf0Ad3irHWbSpx+UCMGSHaWXgL8No2BhMx4vShijusPVPzM0eiF6+lKW+hnXYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wedekind.de; spf=pass smtp.mailfrom=joerg.wedekind.de; dkim=pass (1024-bit key) header.d=wedekind.de header.i=@wedekind.de header.b=AAIwYYZL; arc=none smtp.client-ip=80.153.46.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wedekind.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joerg.wedekind.de
X-Virus-Scanned: amavis at wedekind.de
Received: from 127.0.0.1 (helo=authenticated.user-IP.removed)
	(authenticated bits=0)
	by wedekind.de (8.18.1/8.17.1/SUSE Linux 0.8) with ESMTPSA id 60JEWCau023582
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO); Mon, 19 Jan 2026 15:32:12 +0100
	(envelope-from joerg@joerg.wedekind.de)
DKIM-Filter: OpenDKIM Filter v2.11.0 wedekind.de 60JEWCau023582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wedekind.de;
	s=mail201912; t=1768833132;
	bh=iegCgUpjcxEyCWYNPZnoYKBgv4tG1UGY0oPuvkutQQg=;
	h=From:To:Cc:Subject:Date;
	b=AAIwYYZLosVZN+5XspGXTRAOlyCCdQ3+3Lc4Uc3sb2aBI8nriowcYzPThsNOdfrv+
	 bY9I4m6pfDmvEiUI4jJv8CyBUdSTar348FmArcD4/yFJ0Z/CXKdumAAx39rbGP5YqC
	 YwO+NRnNisL1MGbPGCrC0M/SFVTSBX1E67RjXwmo=
Received: by joerg.wedekind.de (Postfix, from userid 1000)
	id E182D41CD9; Mon, 19 Jan 2026 15:32:11 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>
To: linux-pci@vger.kernel.org
Cc: aradford@gmail.com, =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>
Subject: PCI: Mark 3ware-9650SA Root Port Extended Tags as broken
Date: Mon, 19 Jan 2026 15:31:10 +0100
Message-ID: <20260119143114.21948-1-joerg@wedekind.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (wedekind.de [192.168.17.251]); Mon, 19 Jan 2026 15:32:12 +0100 (CET)

Per PCIe r6.1, sec 2.2.6.2 and 7.5.3.4, a Requester may not use 8-bit Tags
unless its Extended Tag Field Enable is set, but all Receivers/Completers
must handle 8-bit Tags correctly regardless of their Extended Tag Field
Enable.

Some devices do not handle 8-bit Tags as Completers, so add a quirk for
them.  If we find such a device, we disable Extended Tags for the entire
hierarchy to make peer-to-peer DMA possible.

The 3ware 9650SA seems to have issues with handling 8-bit tags. Mark it as
broken.

This fixes PCI Parity Errors like :

  3w-9xxx: scsi0: ERROR: (0x06:0x000C): PCI Parity Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000D): PCI Abort: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000E): Controller Queue Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x0010): Microcontroller Error: clearing.

Link: https://lore.kernel.org/r/20240219132811.8351-1-joerg@wedekind.de
Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=202425
Signed-off-by: Jörg Wedekind <joerg@wedekind.de>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 280cd50d693b..211b7f72d103 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5581,6 +5581,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1005, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);

