Return-Path: <linux-pci+bounces-20143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44443A16CB7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 14:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047A03A6664
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8D1E0DCA;
	Mon, 20 Jan 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XniOJ6O2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xu7SzZEO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XniOJ6O2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xu7SzZEO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC11BEF87;
	Mon, 20 Jan 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378108; cv=none; b=suahDSzhIDYUEXsndQw9RrEeHiOik3PjRGqWH3dsFwimx5GDx9qBqyEAZDxg7/5B2BVC9Xjl3viR1rC8PaVzZBwbxeaDHuRcpBxjqc2Z0qmDCNWQm0LEQ6ascmmcj/0eZ1ZouAYNWgWsUGXaaagOaZZYNI6Zk0BZTaP24X2xOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378108; c=relaxed/simple;
	bh=YYENTLaFuYhkD3cS4qSuwFLmyVFfxRdFewt36ZcUfKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/rXeYn6M/RBxWWSZVjawlEsG7NojwTurjvJlci1QwibEqTAY5+9ls5vXhusThtM5TUzZtAnE1Pp1LB7gaQcp3AuJ1gsnbOcAMFYWelUV9+flgCl7Tn9AyG+paGLGHU3BI5Yh1WSO9Fw1vGIVGCq4s5eTObtVmirSwWPm+uqOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XniOJ6O2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xu7SzZEO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XniOJ6O2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xu7SzZEO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 116CA2115D;
	Mon, 20 Jan 2025 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SyTzT5pv3y66+h4CWiY6o2neUIUBscg8lb1Kk7WLuaE=;
	b=XniOJ6O20qc73fK/fA688yxzfq35OK9WxDy8jQAa1m/Mil7ctcWB2eWRNvcBj9jGkerRsK
	HIEvonn59SGyeWHVqLtstPCrEVDwAG//088SrVHFb7tkFiRZ2dhhxSdZ1B2IVRId2dOs5H
	UTBEW8YYJ0WPSB5ujtsZ9JagLx1uFYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SyTzT5pv3y66+h4CWiY6o2neUIUBscg8lb1Kk7WLuaE=;
	b=xu7SzZEO7WkgfTqbpBW8aBsVNnN3yuMYey3EkW3NE2myW2AQKyNdGMQ3bvtNVCDT1oyJ4u
	90p3m62ieOEseyCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XniOJ6O2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xu7SzZEO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SyTzT5pv3y66+h4CWiY6o2neUIUBscg8lb1Kk7WLuaE=;
	b=XniOJ6O20qc73fK/fA688yxzfq35OK9WxDy8jQAa1m/Mil7ctcWB2eWRNvcBj9jGkerRsK
	HIEvonn59SGyeWHVqLtstPCrEVDwAG//088SrVHFb7tkFiRZ2dhhxSdZ1B2IVRId2dOs5H
	UTBEW8YYJ0WPSB5ujtsZ9JagLx1uFYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SyTzT5pv3y66+h4CWiY6o2neUIUBscg8lb1Kk7WLuaE=;
	b=xu7SzZEO7WkgfTqbpBW8aBsVNnN3yuMYey3EkW3NE2myW2AQKyNdGMQ3bvtNVCDT1oyJ4u
	90p3m62ieOEseyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 143801393E;
	Mon, 20 Jan 2025 13:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WZSOAjhJjmc4XQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 20 Jan 2025 13:01:44 +0000
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
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v5 -next 00/11] Add PCIe support for bcm2712
Date: Mon, 20 Jan 2025 15:01:08 +0200
Message-ID: <20250120130119.671119-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 116CA2115D
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
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Flag: NO

Here is v5 of the series which aims to add support for PCIe on bcm2712 SoC
used by RPi5. Previous v4 can be found at [1].

Based the series on linux-next because of vc4 gpu node in bcm2712.dtsi.

v4 -> v5 changes include:
 - Addressed comments to interrupt-controller driver. (Thomas)
 - Fixed DTB warnings  broadcom/bcm2712-rpi-5-b.dtb.
 - New patch in the series to fix missing of_node_put.
 - New patch to make a softdep to a MIP MSI-X driver.
 - Dropped the patch which adds MSI-X support in pcie-brcmstb driver,
   and instead use DT dma-ranges to pass the needed information. (Jim)

For more detailed info check patches.

Comments are welcome!
~Stan

[1] https://patchwork.kernel.org/project/linux-pci/cover/20241025124515.14066-1-svarbanov@suse.de/

Stanimir Varbanov (11):
  dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
  dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
  irqchip: Add Broadcom bcm2712 MSI-X interrupt controller
  PCI: brcmstb: Reuse config structure
  PCI: brcmstb: Expand inbound window size up to 64GB
  PCI: brcmstb: Add bcm2712 support
  PCI: brcmstb: Adjust PHY PLL setup to use a 54MHz input refclk
  PCI: brcmstb: Adding a softdep to MIP MSI-X driver
  PCI: brcmstb: Fix for missing of_node_put
  arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
  arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes

 .../brcm,bcm2712-msix.yaml                    |  60 ++++
 .../bindings/pci/brcm,stb-pcie.yaml           |   6 +-
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   8 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 147 +++++++++
 drivers/irqchip/Kconfig                       |  16 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-bcm2712-mip.c             | 292 ++++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c         | 147 ++++++---
 8 files changed, 632 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c

-- 
2.47.0


