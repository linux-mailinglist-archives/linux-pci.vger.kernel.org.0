Return-Path: <linux-pci+bounces-14458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9799CB00
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD721F2349B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4953E1AA797;
	Mon, 14 Oct 2024 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rllpg817";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YcW8KmYn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rllpg817";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YcW8KmYn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D521A76C4;
	Mon, 14 Oct 2024 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911256; cv=none; b=R4MQN1PQRygo66pooxDSuyeXD18ikqAkaCpGAAoPf4qk5ZGXJr/VBRgBVLoq+1d/EiQsn1XLLLX/EPC0Dnf8exqdj3Oc/3J4/64RjwDOIEYTXIatHeG6hJxM8aLDd0ConDTXIaXp7lQl3BMy5NVLvSWDzbvzMaxcy4OH32tPmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911256; c=relaxed/simple;
	bh=x3GiOz239MFSFd041iij7RDs+kgXlz88ADllNxdluUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSjz8XugnpANXIHNmro9Ihnlf4f7gJZc9e494NwEUiZSNw4bGhw18rSS/d9gqTVJie4Jvwb66jMCaKI0V3zd/3wdDMJU4CZu1MfRKldoDpShu0wGZ7wqVeBb3/jQgbvuiwKbBsy6Io71FIzaoJvx1X4qaQGRtaH8hkal+3rc+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rllpg817; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YcW8KmYn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rllpg817; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YcW8KmYn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64AA321D3F;
	Mon, 14 Oct 2024 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dnazj/SBO1aQxEa66dJTvC8ksemBo5idWIChnf144/w=;
	b=rllpg817fNVE+ltyDyG88s4d+O2XIc1VwTNoWUkGH4L4fslTQHJRVyi5SM5cqJTgSYIrVv
	dFMIj3iofkFJqJO8luXZ5rXknTyolijj5IATQMUv5ybEeAOcJ39awvkHN7dCjLR+kHvoeu
	khcrcqLng9yplh5jrzl2FAJy5OI+PhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dnazj/SBO1aQxEa66dJTvC8ksemBo5idWIChnf144/w=;
	b=YcW8KmYnf3YJX9Jw+b5s2D9gcgTEAr3Xyh1xAQ3yoBP9dFb4Knds7LWIvSVQaoKznYZfTr
	4sbut5o5wqHfBjBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rllpg817;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YcW8KmYn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dnazj/SBO1aQxEa66dJTvC8ksemBo5idWIChnf144/w=;
	b=rllpg817fNVE+ltyDyG88s4d+O2XIc1VwTNoWUkGH4L4fslTQHJRVyi5SM5cqJTgSYIrVv
	dFMIj3iofkFJqJO8luXZ5rXknTyolijj5IATQMUv5ybEeAOcJ39awvkHN7dCjLR+kHvoeu
	khcrcqLng9yplh5jrzl2FAJy5OI+PhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dnazj/SBO1aQxEa66dJTvC8ksemBo5idWIChnf144/w=;
	b=YcW8KmYnf3YJX9Jw+b5s2D9gcgTEAr3Xyh1xAQ3yoBP9dFb4Knds7LWIvSVQaoKznYZfTr
	4sbut5o5wqHfBjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B43213A42;
	Mon, 14 Oct 2024 13:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id moq0E5MXDWcqTwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 14 Oct 2024 13:07:31 +0000
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
Subject: [PATCH v3 00/11] Add PCIe support for bcm2712
Date: Mon, 14 Oct 2024 16:06:59 +0300
Message-ID: <20241014130710.413-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64AA321D3F
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Flag: NO

Hello,

Here is v3 the series to add support for PCIe on bcm2712 SoC
used by RPi5. Previous v2 can be found at [1].

v2 -> v3 changes include:
 - Added Reviewed-by/Acked-by tags.
 - MIP MSI-X driver has been converted to MSI parent.
 - Added a new patch for PHY PLL adjustment need to succesfully
   enumerate PCIe endpoints on extension connector (tested with
   Pineboards AI Bundle + NVME SSD adapter card).
 - Re-introduced brcm,msi-offset DT private property for MIP
   interrupt-controller (without it I'm anable to use the interrupts
   of adapter cards on PCIe enxtension connector).

For more info check patches.

[1] https://patchwork.kernel.org/project/linux-pci/cover/20240910151845.17308-1-svarbanov@suse.de/

Stanimir Varbanov (11):
  dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
  dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
  irqchip: mip: Add Broadcom bcm2712 MSI-X interrupt controller
  PCI: brcmstb: Expand inbound size calculation helper
  PCI: brcmstb: Enable external MSI-X if available
  PCI: brcmstb: Avoid turn off of bridge reset
  PCI: brcmstb: Add bcm2712 support
  PCI: brcmstb: Reuse config structure
  PCI: brcmstb: Adjust PHY PLL setup to use a 54MHz input refclk
  arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
  arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes

 .../brcm,bcm2712-msix.yaml                    |  60 ++++
 .../bindings/pci/brcm,stb-pcie.yaml           |   5 +-
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   8 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 160 +++++++++
 drivers/irqchip/Kconfig                       |  16 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-bcm2712-mip.c             | 308 ++++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c         | 197 ++++++++---
 8 files changed, 707 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c

-- 
2.43.0


