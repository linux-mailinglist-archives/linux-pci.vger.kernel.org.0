Return-Path: <linux-pci+bounces-19173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B859FFC0E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 17:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379D116253B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 16:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30279481CD;
	Thu,  2 Jan 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T16iawhO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9UZWLLFC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T16iawhO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9UZWLLFC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB31C8FE;
	Thu,  2 Jan 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836202; cv=none; b=XKaCMINKn+6bzNp4Zo59dXC+N3EaZ1RHdiF1cCZNzzWc0i64DFPBNbgCz4baSBoW86GDHJbnqxrJKM0icL3hAuH6zprHW78r3b7c2r1tnm9pq2NU+tEbfh7+dJVvyerWZKtux2SLu+8+i9JnqNISu9xcBhZ2NE42By43bbMigIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836202; c=relaxed/simple;
	bh=9I9jzaF2uWbmc1r0yyQsNVOWAX0k07wB7MbOw49sqro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7NujZWxraiCoRvEzk+6CC6zNJFYPmAQJki7IPIxko9y8L4IDlYNuYb+0pugUUntKBfU0jfftoEyt66YnKfOSmxmXvo63HuQDO6YhznYgjUqzcnWylstxlvksCbbXLkFvpy2JKhPsreBGiig8ahia2fHWU5M/jwe9vpSxxHilUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T16iawhO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9UZWLLFC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T16iawhO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9UZWLLFC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDF4621174;
	Thu,  2 Jan 2025 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735836197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PS9lBiCat/TxqCgkUW1aegGPB7m78UBAnLCf/Y2Oc5A=;
	b=T16iawhO92JtIygNWb1ty9hxuImpM6gePShuZM4naQqu+nTgj59BsbbCamx5B6xk4cTtp+
	pPyP7+UIeOqu4pi+wzgmaTHdRpw8ZmsFIhCrZY4i26ogdVoEO5Bc9MbjxiwBalFOVahRK0
	ZhPGWC0NKRxVp4HV+LGz2gaBFmwo3Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735836197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PS9lBiCat/TxqCgkUW1aegGPB7m78UBAnLCf/Y2Oc5A=;
	b=9UZWLLFCJCwmNXjVSGaeRmRoEn1xpkb+XSm3aLHcHPDCSTPTIIp1HTskE44WkG57Hsb2h4
	FGr/0IgswUhWbwDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T16iawhO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9UZWLLFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735836197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PS9lBiCat/TxqCgkUW1aegGPB7m78UBAnLCf/Y2Oc5A=;
	b=T16iawhO92JtIygNWb1ty9hxuImpM6gePShuZM4naQqu+nTgj59BsbbCamx5B6xk4cTtp+
	pPyP7+UIeOqu4pi+wzgmaTHdRpw8ZmsFIhCrZY4i26ogdVoEO5Bc9MbjxiwBalFOVahRK0
	ZhPGWC0NKRxVp4HV+LGz2gaBFmwo3Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735836197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PS9lBiCat/TxqCgkUW1aegGPB7m78UBAnLCf/Y2Oc5A=;
	b=9UZWLLFCJCwmNXjVSGaeRmRoEn1xpkb+XSm3aLHcHPDCSTPTIIp1HTskE44WkG57Hsb2h4
	FGr/0IgswUhWbwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97A0B13418;
	Thu,  2 Jan 2025 16:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pH+mIyXCdmdpNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 02 Jan 2025 16:43:17 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/DPC: Yet another quirk for PIO log size on Intel Raptor Lake-P
Date: Thu,  2 Jan 2025 17:43:13 +0100
Message-ID: <20250102164315.7562-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BDF4621174
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

There is yet another PCI entry for Intel Raptor Lake-P that shows the
  error "DPC: RP PIO log size 0 is invalid":
  0000:00:07.0 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #0 [8086:a76e]
  0000:00:07.2 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #2 [8086:a72f]

Add the corresponding quirk entry for 8086:a72f.

Note that the one for 8086:a76e has been already added by the commit
627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root
Ports").

Link: https://bugzilla.suse.com/show_bug.cgi?id=1234623
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 76f4df75b08a..4ed3704ce92e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6253,6 +6253,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
-- 
2.43.0


