Return-Path: <linux-pci+bounces-14469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D0E99CB21
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9E3B223C1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBE41BFE10;
	Mon, 14 Oct 2024 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U63faUZf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HrUpPN+2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U63faUZf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HrUpPN+2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA291B85E3;
	Mon, 14 Oct 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911267; cv=none; b=APwJpXeA4BFMj4bzi8jt1MxZBbaH/sbrnvGvOTHqWYSbJKehi6Yxm/Z1l6jEG74Ftowb1i5A1fZaIhtKO4rzi06/Mc6+ZrHDM290uvFl5ujWnK+Dh0Pls4y5NmDmsNcD8zPFBCXBxlbxIU/OwRuwY2LnJT5+3N1du446wE5nUGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911267; c=relaxed/simple;
	bh=ZTmMP9+orp+PHCeTBEJ8UKDhxWX5nor/QBPLZVUpgkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVlHjnpsyfwWISSvzX5vXOj1FN6zalBVNUzOwri0sBmwDOQOyKWH4eE+B9yAvd7l4ZxF0wNKVKf6DJ1hcQQ7VBspDb9OUi79BGJTy3WgNqa4UX7rFJ4p0CssMWcdjQLKs9DlqrUJxFkOxAkC7z/lO4xvv9o5CHEnrO19QivojTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U63faUZf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HrUpPN+2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U63faUZf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HrUpPN+2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2146921D83;
	Mon, 14 Oct 2024 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XffrhzQrGdzdN3IUx4YVAtm8Pi44R6VVyrxsJ/n9ADA=;
	b=U63faUZfTq3oeMNRduutK6PpXmAs/dyJJo0kg+Dmb2aOgR52aNtzJz/HxQDn0BszA9b42l
	QMvACKbaNIrkSjc9FYM1LC/PccnsG3Cc4zFuevcZQjm1xV+tRQ1DNhD9/rjMyvIvevfUQf
	KvHRm5qdaCRVyPicOF/Am4MnNWLGGPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XffrhzQrGdzdN3IUx4YVAtm8Pi44R6VVyrxsJ/n9ADA=;
	b=HrUpPN+28GUF6qD1lFjKr2xbwwGgFpjoJqhEjvAUQZCdgNQQ2HuY+Px3OQjwMDbqWMDrZd
	mMS/J9WzThoy5cCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XffrhzQrGdzdN3IUx4YVAtm8Pi44R6VVyrxsJ/n9ADA=;
	b=U63faUZfTq3oeMNRduutK6PpXmAs/dyJJo0kg+Dmb2aOgR52aNtzJz/HxQDn0BszA9b42l
	QMvACKbaNIrkSjc9FYM1LC/PccnsG3Cc4zFuevcZQjm1xV+tRQ1DNhD9/rjMyvIvevfUQf
	KvHRm5qdaCRVyPicOF/Am4MnNWLGGPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XffrhzQrGdzdN3IUx4YVAtm8Pi44R6VVyrxsJ/n9ADA=;
	b=HrUpPN+28GUF6qD1lFjKr2xbwwGgFpjoJqhEjvAUQZCdgNQQ2HuY+Px3OQjwMDbqWMDrZd
	mMS/J9WzThoy5cCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BF8D13A79;
	Mon, 14 Oct 2024 13:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WAJ+BJ8XDWcqTwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 14 Oct 2024 13:07:43 +0000
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
Subject: [PATCH v3 11/11] arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes
Date: Mon, 14 Oct 2024 16:07:10 +0300
Message-ID: <20241014130710.413-12-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014130710.413-1-svarbanov@suse.de>
References: <20241014130710.413-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

Enable pcie1 and pcie2 DT nodes. Pcie1 is used for the extension
connector and pcie2 is used for RP1 south-bridge.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
v2 -> v3:
 - No changes.

 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 2bdbb6780242..e970a6013c6f 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -62,3 +62,11 @@ &sdio1 {
 	sd-uhs-ddr50;
 	sd-uhs-sdr104;
 };
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
-- 
2.43.0


