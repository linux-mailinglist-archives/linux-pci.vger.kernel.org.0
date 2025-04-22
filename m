Return-Path: <linux-pci+bounces-26370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71231A96014
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 09:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5E1792C1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 07:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4322CBE2;
	Tue, 22 Apr 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zScW9N7J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bXGDSq+z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QjJ1V68G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q3eNK295"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02D1EE7B7
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308454; cv=none; b=b9/52N9Re7Hi4GPq4XMhqQCpvbJ2sydRv+o65IoSLbZtIQrpKdqD10BaJGsXXg/cLmWlrYsGwiH3+z8YSRlruxHIVI3ei/mgL99ACfnDP9wOeXEF0jci05EXDjaZnYmccw3oTp+wXU+oLLXa0ZN58u88G0cAiVtRG0c2YW02bYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308454; c=relaxed/simple;
	bh=XbTnWxqJpjeU4cXZvYrWQ2xtURwjHRsAIXF5mG/O/5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrAbuDFGuOf5oWyUs+QBvWl1CQE5MDyXco2QHxPTmpoeJbPMByISPnj2KoZhE01graTnvA1X0PJ8xPyG5q8vZ4mT1TLbnRbsfdbkYSwUTvzIzvxQc5stiKncvVO+4tNMUGOpfFZTXAlmolG/3rqzQibABl4ppVDf0TGiaDanLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zScW9N7J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bXGDSq+z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QjJ1V68G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q3eNK295; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBA6821187;
	Tue, 22 Apr 2025 07:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745308450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QfkteNnsOmORwj1o6bHeet/zm4MW5xqJNxTV+2ZWcgE=;
	b=zScW9N7JM7NJDRmTrZZFSVgtnfXL16bVZFrYqYtyZPjhD1SdXX9lLNk9wKtiR1VA4kKa4e
	+/PggA81G5tnELJOpcovM1e7q4e7Opk8bn7pe/wuYPs7IY3FaP8PPOvGbfWRwIabg88S48
	/Fv3mdl4kdqFAqK1xr8m0eKg1lJ/tzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745308450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QfkteNnsOmORwj1o6bHeet/zm4MW5xqJNxTV+2ZWcgE=;
	b=bXGDSq+z9dKZd8az37TUlqKUO5TlvKNWwwXhfyH2iatYn8n+XqM89fKeyzdk8VzDSTEGqf
	3svLJ4XciZFYhMDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745308448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QfkteNnsOmORwj1o6bHeet/zm4MW5xqJNxTV+2ZWcgE=;
	b=QjJ1V68Grec2JGzk4a/qjVqIzKvHJ8++eEH7LsbX7kejoijp4KxIOUAWcbvkp1UFDYw1Ct
	yZf+NtxPnsIo7JurV/Gq/qU0u+9AziStUmmMfEwxqMWVmeg74nNV9xCBCNr5jS5jKwdBK1
	GEIsn1oU4Yff6Bw4gioiJaBNyZw2Y0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745308448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QfkteNnsOmORwj1o6bHeet/zm4MW5xqJNxTV+2ZWcgE=;
	b=q3eNK295uXP5T8Es6q1D94zCSEPe2VtTs/SulQdbfaC/CdkVxj5leLMI14pIR8rUStJVOZ
	xjL7Vg8SKBQAgtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABBD4139D5;
	Tue, 22 Apr 2025 07:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rh4gKCBLB2jRQwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 22 Apr 2025 07:54:08 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	iivanov@suse.de,
	tiwai@suse.de
Cc: bhelgaas@google.com,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] video: screen_info: Relocate framebuffers behind PCI bridges
Date: Tue, 22 Apr 2025 09:49:57 +0200
Message-ID: <20250422075056.12989-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Apply bridge window offsets to screen_info framebuffers during
relocation. Fixes invalid access to I/O memory.

Resources behind a PCI bridge can be located at a certain offset
in the kernel's I/O range. The framebuffer memory range stored in
screen_info refers to the offset as seen during boot (essentialy 0).
During boot up, the kernel may assign a different memory offset to
the bridge device and thereby relocating the framebuffer address of
the PCI graphics device as seen by the kernel. The information in
screen_info must be updated as well.

The helper pcibios_bus_to_resource() performs the relocation of
the screen_info resource. The result now matches the I/O-memory
resource of the PCI graphics device. As before, we store away the
information necessary to update the information in screen_info.

Commit 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated
EFI framebuffers") added the code for updating screen_info. It is
based on similar functionality that pre-existed in efifb. Efifb uses
a pointer to the PCI resource, while the newer code does a memcpy of
the region. Hence efifb sees any updates to the PCI resource and avoids
the issue.

v2:
- Fixed tags (Takashi, Ivan)
- Updated information on efifb

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: "Ivan T. Ivanov" <iivanov@suse.de>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1240696
Tested-by: "Ivan T. Ivanov" <iivanov@suse.de>
Fixes: 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated EFI framebuffers")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
---
 drivers/video/screen_info_pci.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
index 6c5833517141..c46c75dc3fae 100644
--- a/drivers/video/screen_info_pci.c
+++ b/drivers/video/screen_info_pci.c
@@ -8,7 +8,7 @@
 static struct pci_dev *screen_info_lfb_pdev;
 static size_t screen_info_lfb_bar;
 static resource_size_t screen_info_lfb_offset;
-static struct resource screen_info_lfb_res = DEFINE_RES_MEM(0, 0);
+static struct pci_bus_region screen_info_lfb_region;
 
 static bool __screen_info_relocation_is_valid(const struct screen_info *si, struct resource *pr)
 {
@@ -31,7 +31,7 @@ void screen_info_apply_fixups(void)
 	if (screen_info_lfb_pdev) {
 		struct resource *pr = &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
 
-		if (pr->start != screen_info_lfb_res.start) {
+		if (pr->start != screen_info_lfb_region.start) {
 			if (__screen_info_relocation_is_valid(si, pr)) {
 				/*
 				 * Only update base if we have an actual
@@ -69,10 +69,21 @@ static void screen_info_fixup_lfb(struct pci_dev *pdev)
 
 	for (i = 0; i < numres; ++i) {
 		struct resource *r = &res[i];
+		struct pci_bus_region bus_region = {
+			.start = r->start,
+			.end = r->end,
+		};
 		const struct resource *pr;
 
 		if (!(r->flags & IORESOURCE_MEM))
 			continue;
+
+		/*
+		 * Translate the address to resource if the framebuffer
+		 * is behind a PCI bridge.
+		 */
+		pcibios_bus_to_resource(pdev->bus, r, &bus_region);
+
 		pr = pci_find_resource(pdev, r);
 		if (!pr)
 			continue;
@@ -85,7 +96,7 @@ static void screen_info_fixup_lfb(struct pci_dev *pdev)
 		screen_info_lfb_pdev = pdev;
 		screen_info_lfb_bar = pr - pdev->resource;
 		screen_info_lfb_offset = r->start - pr->start;
-		memcpy(&screen_info_lfb_res, r, sizeof(screen_info_lfb_res));
+		memcpy(&screen_info_lfb_region, &bus_region, sizeof(screen_info_lfb_region));
 	}
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY, 16,
-- 
2.49.0


