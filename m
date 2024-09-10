Return-Path: <linux-pci+bounces-12990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A149973B76
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8F31C24ED0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B91A257C;
	Tue, 10 Sep 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lAPozrCA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EyiFb4hk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lAPozrCA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EyiFb4hk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375661A08CA;
	Tue, 10 Sep 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981558; cv=none; b=g6CpelKiN+iejXedxiaB6G0JpC1mDf0N7/GgxQakyBmn0TYcccURW0neOVWQKWtMN32zI7TqAaBUCc8m66S0Y/BuP1btWtk17VrWonDBRYWGW1phoPzrKsx7UtaL4d+7qq0lSCQPwqFwchNNxZ/NH9IcIPG2n80GE004qRmmaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981558; c=relaxed/simple;
	bh=NP2Q1uIdeBH30H7m1V/AOLjL67bgpP3VmbetIr/QYOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzwpSsVTs5ixORWHCayWBP+5Y59Pi3BG07bYma9sGYYtAhOwfIhN/j5jZvxyOOLuQHcDfR271w02yoPDy5SzgOULo9vAuIOt66Hu0uHVUPmGT2Qd9xrD7ELbXRYgwuBXi0Qny0stl67d09unpMKsGUf66CEaalcBrgaPRH3sFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lAPozrCA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EyiFb4hk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lAPozrCA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EyiFb4hk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68E7521A61;
	Tue, 10 Sep 2024 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fq5Ppnpne2lpLxXXxocINbxKRySgWI/RMl2TL2aGC5E=;
	b=lAPozrCAr02E1JsHVDGdW0n9JoQVNz3SojITKXrbDjBoAPbIdOXGnMMR2aYFO6WYG4xlkp
	/brdPK/7fTdg3n2hbVbouBZhsjlrki364W563xDxuhwxuW5jL4V4ENnO62yh7rRbsA6sfg
	EL/r8am7c55DeX+ahALfBdPe6ivRCJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fq5Ppnpne2lpLxXXxocINbxKRySgWI/RMl2TL2aGC5E=;
	b=EyiFb4hkeWicESYjPxLW0H9gR8QbGJ8mddQ0ijW34dOrLy3YMRZ3B2QPC0ymG8r7HOOylB
	bXked3DtdEw3aeDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fq5Ppnpne2lpLxXXxocINbxKRySgWI/RMl2TL2aGC5E=;
	b=lAPozrCAr02E1JsHVDGdW0n9JoQVNz3SojITKXrbDjBoAPbIdOXGnMMR2aYFO6WYG4xlkp
	/brdPK/7fTdg3n2hbVbouBZhsjlrki364W563xDxuhwxuW5jL4V4ENnO62yh7rRbsA6sfg
	EL/r8am7c55DeX+ahALfBdPe6ivRCJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fq5Ppnpne2lpLxXXxocINbxKRySgWI/RMl2TL2aGC5E=;
	b=EyiFb4hkeWicESYjPxLW0H9gR8QbGJ8mddQ0ijW34dOrLy3YMRZ3B2QPC0ymG8r7HOOylB
	bXked3DtdEw3aeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4681C13A8F;
	Tue, 10 Sep 2024 15:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yOnGDnJj4GaxQgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 10 Sep 2024 15:19:14 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v2 -next 05/11] PCI: brcmstb: Restore CRS in RootCtl after prstn_n
Date: Tue, 10 Sep 2024 18:18:39 +0300
Message-ID: <20240910151845.17308-6-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910151845.17308-1-svarbanov@suse.de>
References: <20240910151845.17308-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.30
X-Spam-Flag: NO

RootCtl bits might reset by perst_n during probe, re-enable
CRS SVE here in pcie_start_link.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7bd85566c242..f2a7a8e93a74 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1271,7 +1271,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	void __iomem *base = pcie->base;
-	u16 nlw, cls, lnksta;
+	u16 nlw, cls, lnksta, tmp16;
 	bool ssc_good = false;
 	int ret, i;
 
@@ -1319,6 +1319,17 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		 pci_speed_string(pcie_link_speed[cls]), nlw,
 		 ssc_good ? "(SSC)" : "(!SSC)");
 
+	/*
+	 * RootCtl bits are reset by perst_n, which undoes pci_enable_crs()
+	 * called prior to pci_add_new_bus() during probe. Re-enable here.
+	 */
+	tmp16 = readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_RTCAP);
+	if (tmp16 & PCI_EXP_RTCAP_CRSVIS) {
+		tmp16 = readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_RTCTL);
+		u16p_replace_bits(&tmp16, 1, PCI_EXP_RTCTL_CRSSVE);
+		writew(tmp16, base + BRCM_PCIE_CAP_REGS + PCI_EXP_RTCTL);
+	}
+
 	return 0;
 }
 
-- 
2.35.3


