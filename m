Return-Path: <linux-pci+bounces-3589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C1E857BA3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 12:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478E81C23C91
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4D853E24;
	Fri, 16 Feb 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wedekind.de header.i=@wedekind.de header.b="pTVl6j3+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.wedekind.de (mail.karten-team.de [80.153.46.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6C77642
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.153.46.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082984; cv=none; b=HN7yvhChW641W9nFS1B4R81fhrTCkAeIILj4tu9Dl5X9a6uPH1z7ivzN6vPqqzZOfhp7q4+mgwCLK7tf5f/20F76HSQZ6qrfXVGQegSHUgOquw+fEBhLj8KJ/vvhGb3cup+rwQT5u0cpPJwdbeySTAqlzsTQ9/MGaG/wSx5oZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082984; c=relaxed/simple;
	bh=M31Lww9iMMUck2dNB0oMid/OzfSBeWz5agwnwgJqvww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BLIcvNouOlCwl1ypQHfQhkC3CL/bdbCrhpI/oGSM2wEtkUAoBAwJp66BTWgiJKazmPcgBwVGO9Dbj24mmqvNpkbuxENKlWUNmWEjhFSVFeOlMmooF2MdggmMiy7BIr+cexr1Oti2QyIJoUzVEeTv5dVY4cQKF1lSiRf7YV8JY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wedekind.de; spf=pass smtp.mailfrom=joerg.wedekind.de; dkim=pass (1024-bit key) header.d=wedekind.de header.i=@wedekind.de header.b=pTVl6j3+; arc=none smtp.client-ip=80.153.46.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wedekind.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joerg.wedekind.de
X-Virus-Scanned: amavisd-new at wedekind.de
Received: from 127.0.0.1 (helo=authenticated.user-IP.removed)
	(authenticated bits=0)
	by wedekind.de (8.17.1/8.17.1/SUSE Linux 0.8) with ESMTPSA id 41GAq3ek014223
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO); Fri, 16 Feb 2024 11:52:04 +0100
	(envelope-from joerg@joerg.wedekind.de)
DKIM-Filter: OpenDKIM Filter v2.11.0 wedekind.de 41GAq3ek014223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wedekind.de;
	s=mail201912; t=1708080724;
	bh=M31Lww9iMMUck2dNB0oMid/OzfSBeWz5agwnwgJqvww=;
	h=From:To:Cc:Subject:Date;
	b=pTVl6j3+sfopDBo3OF46nl2/a8JmXvtW4nBvAezjaxT/x7BdlTvW8axEm/6+sMkyh
	 ZrCZgqUY2mxMP8CMg/qr06kASxWpel5ExdwQVc8MwkEqwQhLJJQQgcfWB+sqIPx4Gt
	 NZFw8XSxKsPj7Q57musVNlMdIG2Nt7gpeKRUa9Fo=
Received: by joerg.wedekind.de (Postfix, from userid 1000)
	id 8208F4176F; Fri, 16 Feb 2024 11:52:03 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>
To: linux-pci@vger.kernel.org
Cc: aradford@gmail.com, linux@3ware.com,
        =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>
Subject: [PATCH] drivers/pci: disable extension-tags on 3w-9xxx controller
Date: Fri, 16 Feb 2024 11:51:41 +0100
Message-Id: <20240216105141.9607-1-joerg@wedekind.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=202425
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (wedekind.de [192.168.17.251]); Fri, 16 Feb 2024 11:52:04 +0100 (CET)

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


