Return-Path: <linux-pci+bounces-3729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B185A4A2
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 14:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8921C21331
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3B3612D;
	Mon, 19 Feb 2024 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wedekind.de header.i=@wedekind.de header.b="iGo0wxxi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.wedekind.de (mail.wedekind.de [80.153.46.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB88282E2
	for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.153.46.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349341; cv=none; b=BSBorBOluoyVN9Llyf77YOnK1SJsEfrUGPTtJ/8RKd8ReM899hZN+REts5smZD4/gdowxhmNHRcBAQuiOH2KwRhqVekVwnXzrB0NXgg0eKHdHMDIkxPjt70yJMpk9zjqihhC+MRxNCFD4BATNWSNouCnk+K/5l4+8BrUk5MU8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349341; c=relaxed/simple;
	bh=PrXs2vMGMNLDI5CiR/0jCDAiOIzGIJBEIEV9cS9pEaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=im8n4Fu85n5fow/5XflXRcLyV2GfS1Yc87CX+YZ9zXTS+EZ1Z8P38HSr1qi6Rfb+G2YCOy32XU+zrhfdhfvPbglgTx/fCaMOHo5w/teHL7Z7UJO0Sf5UQ0OE45t9rORh8gk9O/Tydc7F94DYIZm+dQnvZm87xFrRyBcYXQNIFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wedekind.de; spf=pass smtp.mailfrom=joerg.wedekind.de; dkim=pass (1024-bit key) header.d=wedekind.de header.i=@wedekind.de header.b=iGo0wxxi; arc=none smtp.client-ip=80.153.46.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wedekind.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joerg.wedekind.de
X-Virus-Scanned: amavisd-new at wedekind.de
Received: from 127.0.0.1 (helo=authenticated.user-IP.removed)
	(authenticated bits=0)
	by wedekind.de (8.17.1/8.17.1/SUSE Linux 0.8) with ESMTPSA id 41JDSjZx011054
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO); Mon, 19 Feb 2024 14:28:48 +0100
	(envelope-from joerg@joerg.wedekind.de)
DKIM-Filter: OpenDKIM Filter v2.11.0 wedekind.de 41JDSjZx011054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wedekind.de;
	s=mail201912; t=1708349328;
	bh=PrXs2vMGMNLDI5CiR/0jCDAiOIzGIJBEIEV9cS9pEaE=;
	h=From:To:Cc:Subject:Date;
	b=iGo0wxxi4TSaPW5uAcwf4zE3UPhyffXI8EnGrgEk44yc4+Ey0wSxG3Wg5/Htc927d
	 juF78Qs4+bJp363GmLfN90IpTIhSSVZERTBO9/PlNAycP7T6iWhl5k2ajQ3n181J7m
	 Xfhtz9b+VYauxaAejx0e1HMlnwygRa+gW2f60kew=
Received: by joerg.wedekind.de (Postfix, from userid 1000)
	id 2EBDA41436; Mon, 19 Feb 2024 14:28:45 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>
To: linux-pci@vger.kernel.org
Cc: aradford@gmail.com, =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>
Subject: PCI: Mark 3ware-9650SE Root Port Extended Tags as broken
Date: Mon, 19 Feb 2024 14:28:11 +0100
Message-Id: <20240219132811.8351-1-joerg@wedekind.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (wedekind.de [192.168.17.251]); Mon, 19 Feb 2024 14:28:48 +0100 (CET)

Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
unless its Extended Tag Field Enable is set, but all Receivers/Completers
must handle 8-bit Tags correctly regardless of their Extended Tag Field
Enable.

Some devices do not handle 8-bit Tags as Completers, so add a quirk for
them.  If we find such a device, we disable Extended Tags for the entire
hierarchy to make peer-to-peer DMA possible.

The 3ware 9650SE  seems to have issues with handling 8-bit tags. Mark it
as broken.

This fixes PCI Partiy Errors like :

  3w-9xxx: scsi0: ERROR: (0x06:0x000C): PCI Parity Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000D): PCI Abort: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000E): Controller Queue Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x0010): Microcontroller Error: clearing.

Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=202425
Signed-off-by: Jörg Wedekind <joerg@wedekind.de>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d797df6e5f3e..2ebbe51a7efe 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5527,6 +5527,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
-- 
2.35.3


