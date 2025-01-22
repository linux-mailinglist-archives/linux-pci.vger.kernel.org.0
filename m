Return-Path: <linux-pci+bounces-20255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA33A19AEA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 23:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861DE188CE18
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC6A1C9B9B;
	Wed, 22 Jan 2025 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UUeGjhWn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mOt5QrSV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UUeGjhWn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mOt5QrSV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76331C5D60;
	Wed, 22 Jan 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585019; cv=none; b=GtnEZX94YIrp0xKAhVfgr8tzUwPEHjXt/yN6wkEIezi17ttWvb0PHWEhtOYfKAs+mAUjfYT2+K8L2Y4eH/w8WHfF0IwqXiHtxX6y+SMRVGHwvYfZJjiA4Cp3C+1viJp8G8XwHYqgySAVGzx7WHKC51BCWUQvO241zz35SnGP7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585019; c=relaxed/simple;
	bh=uLHwnFCpTcHU9LKHIp+6fJKUCswJZSb3uxzKJlL2SW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcZMrmxsPK+vnqjJAhN/9NtcPRLQDMu8MBDJHQ6PJWuaX4Esk+dx+TfZ58O514yDuoNhW/a0Ut4V2JexEtYDGkHKHVAZOw9dOZDjDl3JQ2oX/D0RdIxv4L3bHzwOMpVj0uXNeELyGtjLdfoFuJV8XL5/yJHdb8eLagklpG15QgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UUeGjhWn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mOt5QrSV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UUeGjhWn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mOt5QrSV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE07B2115D;
	Wed, 22 Jan 2025 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737585014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Xos+iPEOgtcwGXoWIUpdh6SUPLxn4fe3D3r1m6hKDLA=;
	b=UUeGjhWnH4XaVdiJil15fMp8lJI/WXEKHhlX5mh6xNkzXQ8i53ecu0TJFdceRIxuZeijNX
	bvvrUyJusnMfZ380gcYFzBVzc0bzi4ZTlgOiscV+1qWtVUjghPYeKBjkMw6ec7tq0EvFbg
	4c/L5vqr+HXDuz0uxumk7pwPMWAMU1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737585014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Xos+iPEOgtcwGXoWIUpdh6SUPLxn4fe3D3r1m6hKDLA=;
	b=mOt5QrSVEop+Dh/j7X8hyrVUGOLOmQ06CyKv1tG/UuqaA5VX8hgwnW97RaulQVnq4BbL2R
	QAzcA0mYz7BY6EBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UUeGjhWn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mOt5QrSV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737585014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Xos+iPEOgtcwGXoWIUpdh6SUPLxn4fe3D3r1m6hKDLA=;
	b=UUeGjhWnH4XaVdiJil15fMp8lJI/WXEKHhlX5mh6xNkzXQ8i53ecu0TJFdceRIxuZeijNX
	bvvrUyJusnMfZ380gcYFzBVzc0bzi4ZTlgOiscV+1qWtVUjghPYeKBjkMw6ec7tq0EvFbg
	4c/L5vqr+HXDuz0uxumk7pwPMWAMU1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737585014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Xos+iPEOgtcwGXoWIUpdh6SUPLxn4fe3D3r1m6hKDLA=;
	b=mOt5QrSVEop+Dh/j7X8hyrVUGOLOmQ06CyKv1tG/UuqaA5VX8hgwnW97RaulQVnq4BbL2R
	QAzcA0mYz7BY6EBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49146136A1;
	Wed, 22 Jan 2025 22:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JohxDnVxkWeRRAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 22 Jan 2025 22:30:13 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI: brcmstb: Fix for missing of_node_put
Date: Thu, 23 Jan 2025 00:29:55 +0200
Message-ID: <20250122222955.1752778-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE07B2115D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,linux.com,linaro.org,google.com,suse.de,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

A call to of_parse_phandle() is incrementing the refcount, of_node_put
must be called when done the work on it. Add missing of_node_put() after
the check for msi_np == np and MSI initialization.

Cc: stable@vger.kernel.org # v5.10+
Fixes: 40ca1bf580ef ("PCI: brcmstb: Add MSI support")
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
v1 -> v2:
 - Use of_node_put instead of cleanups (Florian).
 - Sent the patch separately from PCIe 2712 series (Florian).

 drivers/pci/controller/pcie-brcmstb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 744fe1a4cf9c..d171ee61eab3 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1844,7 +1844,7 @@ static struct pci_ops brcm7425_pcie_ops = {
 
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node, *msi_np;
+	struct device_node *np = pdev->dev.of_node;
 	struct pci_host_bridge *bridge;
 	const struct pcie_cfg_data *data;
 	struct brcm_pcie *pcie;
@@ -1944,9 +1944,14 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
-	if (pci_msi_enabled() && msi_np == pcie->np) {
-		ret = brcm_pcie_enable_msi(pcie);
+	if (pci_msi_enabled()) {
+		struct device_node *msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
+
+		if (msi_np == pcie->np)
+			ret = brcm_pcie_enable_msi(pcie);
+
+		of_node_put(msi_np);
+
 		if (ret) {
 			dev_err(pcie->dev, "probe of internal MSI failed");
 			goto fail;
-- 
2.47.0


