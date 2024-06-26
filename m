Return-Path: <linux-pci+bounces-9292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5940E917EC3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128922836C1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149A9181CE6;
	Wed, 26 Jun 2024 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vq7nBfRq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dmAtDw15";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vq7nBfRq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dmAtDw15"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B59181BA3;
	Wed, 26 Jun 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398815; cv=none; b=StOsKqWymnRhJFV1aMjmsG94aX2xCXXdTTCIMzWJeY9D1buD63QQKGv1DivcweiaALLH/zLv+B+qe8lrKOJXfFQd/Rg57V7MWk8/yENwLO+oj0QhZIy/tpOP6gOGik5LljNARlJnxXABOi0QapR3lNJ1FJJVa1rxWz9qWfK3+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398815; c=relaxed/simple;
	bh=V0gOKP7yrJUfS37uyh8DXg0gXmOJJjQyp0M6f8WLuS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmLJPN2ryf0o646T2HTdawiRWzH3jygWRm4csti8mCAcSeylDoythiRYwOQWZ+IYYluk2cbfANuz4o26+5prnklfKldZCcnflfHXosAuy1Fbhr8XNTZjWZc92bnWzgL2vDI4HpA3FxyfAvzQAFbFVmGQ9gHTg8DKp7Gg4s1Jtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vq7nBfRq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dmAtDw15; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vq7nBfRq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dmAtDw15; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA24E21AE3;
	Wed, 26 Jun 2024 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JIlwJA+a1DRRddGL8GnSOzHBrJfoo6yBvpc4TQle5I=;
	b=vq7nBfRqbYW8GYU/74x1R9M85p+n7gZpR2yR7F2IvJ8ju1ggNcuYF6S/qVSy/qfyKay1kM
	YD339wDPYaadcBzssBGGfaL29u3cnpoLaWj8ZC/QgTSsLH7LzZDDb6p5GLRWV0KsAt2WGF
	//tNaGDA9DxvKRRQj6lpLcAQFpbm0Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JIlwJA+a1DRRddGL8GnSOzHBrJfoo6yBvpc4TQle5I=;
	b=dmAtDw150kIO0UPwYI35YACjrNWP81/xfsyFnOgGR8aDMhkFGWPDEbTu9R1S28GjuDIYVN
	w6B9IufhWHlv4oAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vq7nBfRq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dmAtDw15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JIlwJA+a1DRRddGL8GnSOzHBrJfoo6yBvpc4TQle5I=;
	b=vq7nBfRqbYW8GYU/74x1R9M85p+n7gZpR2yR7F2IvJ8ju1ggNcuYF6S/qVSy/qfyKay1kM
	YD339wDPYaadcBzssBGGfaL29u3cnpoLaWj8ZC/QgTSsLH7LzZDDb6p5GLRWV0KsAt2WGF
	//tNaGDA9DxvKRRQj6lpLcAQFpbm0Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JIlwJA+a1DRRddGL8GnSOzHBrJfoo6yBvpc4TQle5I=;
	b=dmAtDw150kIO0UPwYI35YACjrNWP81/xfsyFnOgGR8aDMhkFGWPDEbTu9R1S28GjuDIYVN
	w6B9IufhWHlv4oAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C22B513AD2;
	Wed, 26 Jun 2024 10:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yJqxLJTxe2ZuDQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 26 Jun 2024 10:46:44 +0000
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
Subject: [PATCH 5/7] PCI: brcmstb: add phy_controllable flag
Date: Wed, 26 Jun 2024 13:45:42 +0300
Message-ID: <20240626104544.14233-6-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626104544.14233-1-svarbanov@suse.de>
References: <20240626104544.14233-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA24E21AE3
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.44 / 50.00];
	BAYES_HAM(-2.93)[99.71%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	R_RATELIMIT(0.00)[to_ip_from(RLw7mkaud87zuqqztkur5718rm)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Not all PCIe can control the phy block, add a flag
in config structure to take that fact into account.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4ca509502336..ff8e5e672ff0 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -224,6 +224,7 @@ enum pcie_type {
 struct pcie_cfg_data {
 	const int *offsets;
 	const enum pcie_type type;
+	bool phy_controllable;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
@@ -1301,11 +1302,17 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
 
 static inline int brcm_phy_start(struct brcm_pcie *pcie)
 {
+	if (!pcie->cfg->phy_controllable)
+		return 0;
+
 	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
 static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 {
+	if (!pcie->cfg->phy_controllable)
+		return 0;
+
 	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
@@ -1498,6 +1505,7 @@ static const int pcie_offsets_bmips_7425[] = {
 static const struct pcie_cfg_data generic_cfg = {
 	.offsets	= pcie_offsets,
 	.type		= GENERIC,
+	.phy_controllable = true,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
@@ -1505,6 +1513,7 @@ static const struct pcie_cfg_data generic_cfg = {
 static const struct pcie_cfg_data bcm7425_cfg = {
 	.offsets	= pcie_offsets_bmips_7425,
 	.type		= BCM7425,
+	.phy_controllable = true,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
@@ -1512,6 +1521,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 static const struct pcie_cfg_data bcm7435_cfg = {
 	.offsets	= pcie_offsets,
 	.type		= BCM7435,
+	.phy_controllable = true,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
@@ -1519,6 +1529,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 static const struct pcie_cfg_data bcm4908_cfg = {
 	.offsets	= pcie_offsets,
 	.type		= BCM4908,
+	.phy_controllable = true,
 	.perst_set	= brcm_pcie_perst_set_4908,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
@@ -1532,6 +1543,7 @@ static const int pcie_offset_bcm7278[] = {
 static const struct pcie_cfg_data bcm7278_cfg = {
 	.offsets	= pcie_offset_bcm7278,
 	.type		= BCM7278,
+	.phy_controllable = true,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 };
@@ -1539,6 +1551,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
 static const struct pcie_cfg_data bcm2711_cfg = {
 	.offsets	= pcie_offsets,
 	.type		= BCM2711,
+	.phy_controllable = true,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
-- 
2.43.0


